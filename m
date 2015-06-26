Received: from mx1.redhat.com ([209.132.183.28]:45581 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751902AbbFZL2K (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 26 Jun 2015 07:28:10 -0400
Date: Fri, 26 Jun 2015 07:28:08 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] xfstests: generic xattr enospc cleanup test
Message-ID: <20150626112808.GA40750@bfoster.bfoster>
References: <1435078044-21679-1-git-send-email-bfoster@redhat.com>
 <20150626061545.GF1210@dhcp-13-216.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150626061545.GF1210@dhcp-13-216.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
List-ID: <fstests@vger.kernel.org>

On Fri, Jun 26, 2015 at 02:15:45PM +0800, Eryu Guan wrote:
> On Tue, Jun 23, 2015 at 12:47:24PM -0400, Brian Foster wrote:
> > XFS had a regression where inode reclaim in the unlink codepath would
> > not correctly tear down extended attribute forks where no xattr extents
> > are present. Add a generic test to create this condition.
> > 
> > The test sets extended attributes on a series of files under ENOSPC
> > conditions and then verifies that the files can be removed without
> > syslog warnings or errors.
> > 
> > Signed-off-by: Brian Foster <bfoster@redhat.com>
> > ---
> >  tests/generic/103     | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/103.out |  2 ++
> >  tests/generic/group   |  1 +
> >  3 files changed, 94 insertions(+)
> >  create mode 100755 tests/generic/103
> >  create mode 100644 tests/generic/103.out
> > 
> > diff --git a/tests/generic/103 b/tests/generic/103
> > new file mode 100755
> > index 0000000..373cd9d
> > --- /dev/null
> > +++ b/tests/generic/103
> > @@ -0,0 +1,91 @@
> > +#! /bin/bash
> > +# FSQA Test No. 103
> > +#
> > +# Test attribute fork teardown. This test is inspired by a regression in XFS
> > +# that resulted in problematic removal of inodes with remote attribute forks
> > +# without attribute extents. The attribute fork condition is created by
> > +# attempting to set larger attribute values on a filesystem that is at or near
> > +# ENOSPC.
> > +#
> > +#-----------------------------------------------------------------------
> > +# Copyright (c) 2015 Red Hat, Inc.  All Rights Reserved.
> > +#
> > +# This program is free software; you can redistribute it and/or
> > +# modify it under the terms of the GNU General Public License as
> > +# published by the Free Software Foundation.
> > +#
> > +# This program is distributed in the hope that it would be useful,
> > +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> > +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > +# GNU General Public License for more details.
> > +#
> > +# You should have received a copy of the GNU General Public License
> > +# along with this program; if not, write the Free Software Foundation,
> > +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
> > +#
> > +#-----------------------------------------------------------------------
> > +#
> > +
> > +seq=`basename $0`
> > +seqres=$RESULT_DIR/$seq
> > +echo "QA output created by $seq"
> > +
> > +_cleanup()
> > +{
> > +        cd /
> > +        rm -f $tmp.*
> > +}
> > +
> > +here=`pwd`
> > +tmp=/tmp/$$
> > +status=1	# failure is the default!
> > +trap "_cleanup; exit \$status" 0 1 2 3 15 25
> > +
> > +# get standard environment, filters and checks
> > +. ./common/rc
> > +. ./common/attr
> > +
> > +# real QA test starts here
> > +_supported_fs generic
> > +_supported_os Linux
> > +_require_scratch
> > +_require_attrs
> > +
> > +rm -f $seqres.full
> > +
> > +_consume_freesp()
> > +{
> > +	file=$1
> > +
> > +	# consume nearly all available space (leave ~512kB)
> > +	avail=`_get_available_space $SCRATCH_MNT`
> > +	filesizekb=$((avail / 1024 - 512))
> > +	$XFS_IO_PROG -fc "falloc 0 ${filesizekb}k" $file
> 
> This fails ext2/3 which don't have fallocate(2) support, need
> _require_xfs_io_command "falloc".
> 

Ok.

> This blocks ext2/3 from testing but extN just doesn't support 64k xattr
> value, we don't lose much test coverage. On the other hand, changing
> falloc to pwrite extends test time significantly (2s -> 30+s) and
> doesn't gain much benefit.
> 

Yeah, I don't think it's worth that. It runs really quickly now and the
reason behind it is an XFS regression.

> > +}
> > +
> > +_scratch_mkfs >> $seqres.full 2>&1
> > +_scratch_mount
> > +
> > +for i in $(seq 0 63); do
> > +	touch $SCRATCH_MNT/$seq.$i
> > +done
> > +
> > +# Generate a large attribute value and consume the rest of the space in the
> > +# filesystem.
> > +$XFS_IO_PROG -fc "pwrite 0 64k" $SCRATCH_MNT/attrval > /dev/null 2>&1
> > +_consume_freesp $SCRATCH_MNT/spc
> > +
> > +# Set attributes on the test files. These should start to hit ENOSPC.
> > +for i in $(seq 0 63); do
> > +	$SETFATTR_PROG -n user.test -v "`cat $SCRATCH_MNT/attrval`" \
> > +		$SCRATCH_MNT/$seq.$i >> $seqres.full 2>&1
> > +done
> > +
> > +# Remove the files with attributes to test attribute fork teardown. Problems
> > +# result in dmesg output.
> > +rm -f $SCRATCH_MNT/$seq.*
> 
> I see xfs corruption after the test, I think that's expected.
> 

The problem should be fixed upstream, though 4.1 might still fail. I
also need to backport the fix now that it's merged. ;)

> But I just want to point out here that _check_dmesg is unable to detect
> the call traces in dmesg now, as the call trace doesn't have "WARNING",
> "kernel BUG" etc. keywords that _check_dmesg searches for, we rely on
> _check_fimesystems to fail the test.
> 

Good catch, thanks. The failure here is an XFS error as opposed to a
BUG() or warning. I've updated _check_dmesg() to catch "Internal error"
as well.

Brian

> Thanks,
> Eryu
> > +
> > +echo Silence is golden.
> > +
> > +status=0
> > +exit
> > diff --git a/tests/generic/103.out b/tests/generic/103.out
> > new file mode 100644
> > index 0000000..ce229bf
> > --- /dev/null
> > +++ b/tests/generic/103.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 103
> > +Silence is golden.
> > diff --git a/tests/generic/group b/tests/generic/group
> > index 0c8964c..41f3039 100644
> > --- a/tests/generic/group
> > +++ b/tests/generic/group
> > @@ -98,6 +98,7 @@
> >  097 udf auto
> >  099 udf auto
> >  100 udf auto
> > +103 auto enospc quick
> >  105 acl auto quick
> >  112 rw aio auto quick
> >  113 rw aio auto quick
> > -- 
> > 1.9.3
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe fstests" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
