Received: from mx1.redhat.com ([209.132.183.28]:44526 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379AbbFZNmw (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 26 Jun 2015 09:42:52 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 81B273070AC
	for <fstests@vger.kernel.org>; Fri, 26 Jun 2015 13:42:52 +0000 (UTC)
Date: Fri, 26 Jun 2015 21:42:50 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH v2] xfstests: generic xattr enospc cleanup test
Message-ID: <20150626134250.GI1210@dhcp-13-216.nay.redhat.com>
References: <1435318505-41653-1-git-send-email-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1435318505-41653-1-git-send-email-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Jun 26, 2015 at 07:35:05AM -0400, Brian Foster wrote:
> XFS had a regression where inode reclaim in the unlink codepath would
> not correctly tear down extended attribute forks where no xattr extents
> are present. Add a generic test to create this condition.
> 
> The test sets extended attributes on a series of files under ENOSPC
> conditions and then verifies that the files can be removed without
> syslog warnings or errors.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>
> ---
> 
> v2:
> - Add fallocate requirement.
> - Update _check_dmesg() to detect resulting XFS "Internal error."

I did a test run with this update (./check -g auto) on 4.1 kernel, and
no false alart showed up, I thought there would be some tests generate
"Internal error" logs on purpose.

But I did see shared/298 failed _check_dmesg, it generated the same call
trace as what this test generates. Perhaps shared/298 is another
reproducer of this bug.

And the update to _check_dmesg conflicts with my patch
"fstests: move _check_dmesg to common/rc"

Anyway, v2 looks good to me.
Reviewed-by: Eryu Guan <eguan@redhat.com>

> v1: http://thread.gmane.org/gmane.comp.file-systems.fstests/885
> 
>  check                 |  1 +
>  tests/generic/103     | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/103.out |  2 ++
>  tests/generic/group   |  1 +
>  4 files changed, 96 insertions(+)
>  create mode 100755 tests/generic/103
>  create mode 100644 tests/generic/103.out
> 
> diff --git a/check b/check
> index a300130..675005c 100755
> --- a/check
> +++ b/check
> @@ -412,6 +412,7 @@ _check_dmesg()
>  	     -e "BUG:" \
>  	     -e "Oops:" \
>  	     -e "possible recursive locking detected" \
> +	     -e "Internal error" \
>  	     $seqres.dmesg
>  	if [ $? -eq 0 ]; then
>  		echo "_check_dmesg: something found in dmesg (see $seqres.dmesg)"
> diff --git a/tests/generic/103 b/tests/generic/103
> new file mode 100755
> index 0000000..3884e3e
> --- /dev/null
> +++ b/tests/generic/103
> @@ -0,0 +1,92 @@
> +#! /bin/bash
> +# FSQA Test No. 103
> +#
> +# Test attribute fork teardown. This test is inspired by a regression in XFS
> +# that resulted in problematic removal of inodes with remote attribute forks
> +# without attribute extents. The attribute fork condition is created by
> +# attempting to set larger attribute values on a filesystem that is at or near
> +# ENOSPC.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2015 Red Hat, Inc.  All Rights Reserved.
> +#
> +# This program is free software; you can redistribute it and/or
> +# modify it under the terms of the GNU General Public License as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it would be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License
> +# along with this program; if not, write the Free Software Foundation,
> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> +#
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +_cleanup()
> +{
> +        cd /
> +        rm -f $tmp.*
> +}
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15 25
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/attr
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_scratch
> +_require_attrs
> +_require_xfs_io_command "falloc"
> +
> +rm -f $seqres.full
> +
> +_consume_freesp()
> +{
> +	file=$1
> +
> +	# consume nearly all available space (leave ~512kB)
> +	avail=`_get_available_space $SCRATCH_MNT`
> +	filesizekb=$((avail / 1024 - 512))
> +	$XFS_IO_PROG -fc "falloc 0 ${filesizekb}k" $file
> +}
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +for i in $(seq 0 63); do
> +	touch $SCRATCH_MNT/$seq.$i
> +done
> +
> +# Generate a large attribute value and consume the rest of the space in the
> +# filesystem.
> +$XFS_IO_PROG -fc "pwrite 0 64k" $SCRATCH_MNT/attrval > /dev/null 2>&1
> +_consume_freesp $SCRATCH_MNT/spc
> +
> +# Set attributes on the test files. These should start to hit ENOSPC.
> +for i in $(seq 0 63); do
> +	$SETFATTR_PROG -n user.test -v "`cat $SCRATCH_MNT/attrval`" \
> +		$SCRATCH_MNT/$seq.$i >> $seqres.full 2>&1
> +done
> +
> +# Remove the files with attributes to test attribute fork teardown. Problems
> +# result in dmesg output.
> +rm -f $SCRATCH_MNT/$seq.*
> +
> +echo Silence is golden.
> +
> +status=0
> +exit
> diff --git a/tests/generic/103.out b/tests/generic/103.out
> new file mode 100644
> index 0000000..ce229bf
> --- /dev/null
> +++ b/tests/generic/103.out
> @@ -0,0 +1,2 @@
> +QA output created by 103
> +Silence is golden.
> diff --git a/tests/generic/group b/tests/generic/group
> index 0c8964c..41f3039 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -98,6 +98,7 @@
>  097 udf auto
>  099 udf auto
>  100 udf auto
> +103 auto enospc quick
>  105 acl auto quick
>  112 rw aio auto quick
>  113 rw aio auto quick
> -- 
> 1.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
