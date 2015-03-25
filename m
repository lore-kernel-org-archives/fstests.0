Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:32868 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751850AbbCYTcj (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 25 Mar 2015 15:32:39 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 41DE8C3289
	for <fstests@vger.kernel.org>; Wed, 25 Mar 2015 19:32:39 +0000 (UTC)
Date: Wed, 25 Mar 2015 15:32:36 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 3/9 RESEND] generic: test hardlink to unlinked file
Message-ID: <20150325193236.GD3436@laptop.bfoster>
References: <1426846618-23413-1-git-send-email-eguan@redhat.com>
 <1426846618-23413-4-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1426846618-23413-4-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, Eric Sandeen <esandeen@redhat.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 20, 2015 at 06:16:52PM +0800, Eryu Guan wrote:
> Kernel commit
> 
> aae8a97 fs: Don't allow to create hardlink for deleted file
> 
> disabled hardlink to unlinked file.
> 
> Test the race between link and unlink, which could end up adding link
> count to an unlinked file and leading to fs corruption on xfs.
> 
> Test case was originally written by Eric Sandeen.
> 
> Cc: Eric Sandeen <esandeen@redhat.com>
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  tests/generic/073     | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/073.out |  2 ++
>  tests/generic/group   |  1 +
>  3 files changed, 102 insertions(+)
>  create mode 100755 tests/generic/073
>  create mode 100644 tests/generic/073.out
> 
> diff --git a/tests/generic/073 b/tests/generic/073
> new file mode 100755
> index 0000000..6a5261c
> --- /dev/null
> +++ b/tests/generic/073
> @@ -0,0 +1,99 @@
> +#! /bin/bash
> +# FS QA Test No. 073
> +#
> +# Test hardlink to unlinked file.
> +#
> +# Regression test for commit:
> +# aae8a97 fs: Don't allow to create hardlink for deleted file
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2015 Red Hat Inc.  All Rights Reserved.
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
> +#-----------------------------------------------------------------------
> +#
> +
> +seq=`basename $0`
> +seqres=$RESULT_DIR/$seq
> +echo "QA output created by $seq"
> +
> +here=`pwd`
> +tmp=/tmp/$$
> +status=1	# failure is the default!
> +trap "_cleanup; exit \$status" 0 1 2 3 15
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $tmp.*
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +
> +link_unlink_storm()
> +{
> +	local src=$1
> +	local target=$2
> +
> +	while true; do
> +		ln -f $src $target >/dev/null 2>&1
> +		rm -f $target >/dev/null 2>&1
> +	done
> +}

This seems slightly different from the original reproducer in that it
recreates the same link and unlinks/recreates the $src entry many times
as well. That seems Ok, but out of curiousity, is this test confirmed to
reproduce the original problem?

> +
> +rm -f $seqres.full
> +nr_cpu=`$here/src/feature -o`
> +echo "Silence is golden"
> +
> +# create, open & unlinked files so unlinked inode list is not empty
> +for i in `seq 1 64`; do

		   $nr_cpu

> +	testfile=$TEST_DIR/$seq.unlinked.$i
> +	touch $testfile
> +	tail -f $testfile &
> +	tail_pids="$tail_pids $!"
> +	rm -f $testfile

I get some file not found errors from 'tail' when I run this test. They
go away if I add a sleep after the 'tail -f ... &,' so I suspect the rm
-f could be racing with the file removal.

That might be unnecessarily slow, however. Perhaps create and tail all
of the files in one loop, sleep for a bit, then remove them?

> +done
> +
> +# start link/unlink storm
> +src=$TEST_DIR/$seq.target
> +touch $testfile

touch $src ?

> +for i in `seq 1 $nr_cpu`; do
> +	target=$TEST_DIR/$seq.target.link.$i
> +	link_unlink_storm $src $target &
> +	link_pids="$link_pids $!"
> +done
> +
> +# remove & re-create target to race with link/unlink
> +while true; do
> +	rm -f $src
> +	touch $src
> +done &
> +sleep 5
> +kill $! >/dev/null 2>&1
> +
> +kill $tail_pids $link_pids >/dev/null 2>&1
> +wait $tail_pids $link_pids
> +
> +# all done, no oops/hang expected, _check_filesystems checks TEST_DEV after test
> +status=0
> +exit
> diff --git a/tests/generic/073.out b/tests/generic/073.out
> new file mode 100644
> index 0000000..d107704
> --- /dev/null
> +++ b/tests/generic/073.out
> @@ -0,0 +1,2 @@
> +QA output created by 073
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index c0210d2..ee5b642 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -75,6 +75,7 @@
>  070 attr udf auto quick stress
>  071 auto quick prealloc
>  072 auto quick quota
> +073 auto metadata

quick seems fine as well.

Brian

>  074 rw udf auto
>  075 rw udf auto quick
>  076 metadata rw udf auto quick stress
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
