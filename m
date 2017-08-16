Received: from mx1.redhat.com ([209.132.183.28]:48792 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751224AbdHPHCS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 16 Aug 2017 03:02:18 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0A9824D4AC
        for <fstests@vger.kernel.org>; Wed, 16 Aug 2017 07:02:18 +0000 (UTC)
Date: Wed, 16 Aug 2017 15:02:14 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs: Test infinite loop while searching for a free inode
 slot
Message-ID: <20170816070214.GJ14807@eguan.usersys.redhat.com>
References: <20170815125541.12243-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170815125541.12243-1-cmaiolino@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Carlos Maiolino <cmaiolino@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Carlos,

On Tue, Aug 15, 2017 at 02:55:41PM +0200, Carlos Maiolino wrote:
> Tests the search algorithm for a free inode slot in a specific AG, done
> in xfs_dialloc_ag_inobt().
> 
> When finobt is not used, and agi->freecount is not 0, XFS will scan the AG inode
> tree looking for a free inode slot, but if agi->freecount is corrupted,
> and there is no free slot at all, it will end up in an infinite loop.
> 
> This test checks for the infinite loop fix.

The test passed for me with 4.13-rc kernel with latest upstream
xfsprogs, but I expected it to fail (hang). Does it hang for you?

Some comments inline.

> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>  tests/xfs/057     | 80 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/057.out |  2 ++
>  tests/xfs/group   |  1 +
>  3 files changed, 83 insertions(+)
>  create mode 100755 tests/xfs/057
>  create mode 100644 tests/xfs/057.out
> 
> diff --git a/tests/xfs/057 b/tests/xfs/057
> new file mode 100755
> index 00000000..446ea1eb
> --- /dev/null
> +++ b/tests/xfs/057
> @@ -0,0 +1,80 @@
> +#! /bin/bash
> +# FS QA Test 057
> +#
> +# Check if the filesystem will lockup when trying to allocate a new inode in
> +# an AG with no free inodes but with a corrupted agi->freecount showing free inodes. 

Trailing whitespace in above line :)

> +#
> +# At the end of the test, the scratch device will purposely be in a corrupted
> +# state, so there is no need for checking that.
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
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
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs generic
> +_supported_os Linux
> +#_require_scratch

Can be removed.

> +_require_scratch_nocheck
> +
> +_scratch_mkfs_xfs -mfinobt=0 >/dev/null 2>&1 \
> +	|| _notrun "Failed to initialize filesystem."

Hmm, I'd use _require_xfs_finobt to _notrun on old kernel/userspace
where finobt feature is not supported, i.e.

_require_scratch_nocheck
_require_xfs_finobt

_scratch_mkfs -mfinobt=0 >>$seqres.full 2>&1

> +_scratch_mount >/dev/null 2>&1

This mount should succeed, so I'd drop the I/O redirection, just let the
error message fail the test if there's a mount failure.

> +
> +# At the end of filesystem's initialization, AG 0 will still have 61 free
> +# inodes in the agi->freecount, create 61 extra dummy files to fill it up
> +for i in `seq 1 61`; do
> +	touch $SCRATCH_MNT/dummy_file$1
                                    ^^^ $i not $1
so I know why I can't reproduce the hang now, fixing this typo works for
me :)

> +done

How about getting the freecount number via xfs_db (before
_scratch_mount) instead of assmuing it always be 61?

freecount=`_scratch_xfs_db -c "agi 0" -c "p freecount" | cut -d' ' -f 3`

> +
> +_scratch_unmount
> +
> +# agi->freecount is 0 here, corrupt it to show extra free inodes
> +$XFS_DB_PROG -x -c "agi 0" -c "write -d freecount 10" $SCRATCH_DEV >/dev/null 2>&1

redirect stdout and stderr to $seqres.full for debug purpose

> +
> +_scratch_mount >/dev/null 2>&1

No need to drop stdout and stderr either.

> +
> +# Lock up a buggy kernel
> +touch $SCRATCH_MNT/lockupfile

Would this touch return any error message if the kernel bug is fixed? If
so, I'd drop stdout/stderr of touch.

> +
> +# If we reach this point, the filesystem is fixed
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/xfs/057.out b/tests/xfs/057.out
> new file mode 100644
> index 00000000..185023c7
> --- /dev/null
> +++ b/tests/xfs/057.out
> @@ -0,0 +1,2 @@
> +QA output created by 057
> +Silence is golden
> diff --git a/tests/xfs/group b/tests/xfs/group
> index cf876a29..3ca8e75a 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -54,6 +54,7 @@
>  054 auto quick
>  055 dump ioctl remote tape
>  056 dump ioctl auto quick
> +057 dangerous

I think it's a good fit to auto and quick group too, and maybe fuzzers
group.

Thanks,
Eryu

>  059 dump ioctl auto quick
>  060 dump ioctl auto quick
>  061 dump ioctl auto quick
> -- 
> 2.13.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
