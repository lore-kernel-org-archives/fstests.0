Received: from mx1.redhat.com ([209.132.183.28]:60662 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750718AbdHRFsh (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 18 Aug 2017 01:48:37 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 440CA85550
        for <fstests@vger.kernel.org>; Fri, 18 Aug 2017 05:48:37 +0000 (UTC)
Date: Fri, 18 Aug 2017 13:48:30 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH V2] xfs: Test infinite loop while searching for a free
 inode slot
Message-ID: <20170818054830.GW14807@eguan.usersys.redhat.com>
References: <20170817133943.10774-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170817133943.10774-1-cmaiolino@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Carlos Maiolino <cmaiolino@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Aug 17, 2017 at 03:39:43PM +0200, Carlos Maiolino wrote:
> Tests the search algorithm for a free inode slot in a specific AG, done
> in xfs_dialloc_ag_inobt().
> 
> When finobt is not used, and agi->freecount is not 0, XFS will scan the AG inode
> tree looking for a free inode slot, but if agi->freecount is corrupted,
> and there is no free slot at all, it will end up in an infinite loop.
> 
> This test checks for the infinite loop fix.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
> 
> Changelog:
> 
> V2:
> 	- Small clean up
> 	- use _disable_dmesg_check (the test will generate error
> 				    messages which will appear in dmesg)
> 	- Get the amount of free inodes from the AGI instead of assuming
> 	  61 free inodes
> 	- Send a few outputs to $seqres.full
> 	- Use xfs_db `write` without -d option once this will create
> 	  incompatibility with previous xfsprogs, and is not strictly
> 	  required for the test to work.
> 	- Check for finobt, and explicitly disable it if it is
> 	  supported by the kernel being tested.

Thanks a lot for the updated version! It looks much better than v1 :)

Though I hit another issue while testing this patch, please see below.

> 
>  tests/xfs/057     | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/057.out |  2 ++
>  tests/xfs/group   |  1 +
>  3 files changed, 89 insertions(+)
>  create mode 100755 tests/xfs/057
>  create mode 100644 tests/xfs/057.out
> 
> diff --git a/tests/xfs/057 b/tests/xfs/057
> new file mode 100755
> index 00000000..9833ba25
> --- /dev/null
> +++ b/tests/xfs/057
> @@ -0,0 +1,86 @@
> +#! /bin/bash
> +# FS QA Test 057
> +#
> +# Check if the filesystem will lockup when trying to allocate a new inode in
> +# an AG with no free inodes but with a corrupted agi->freecount showing free inodes.
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
> +_require_scratch_nocheck
> +_disable_dmesg_check
> +
> +# Make sure we disable finobt if the filesystem supports it, otherwise, just
> +# initialize it with default options.
> +_scratch_mkfs | grep -q "finobt=1" && _scratch_mkfs -m "finobt=0" >/dev/null 2>&1
> +
> +# Get the amount of free inodes from the AGI 0, so we can fill up the freecount
> +# structure.
> +freecount=`_scratch_xfs_db -c "agi 0" -c "p freecount" | cut -d' ' -f 3`
> +
> +_scratch_mount
> +
> +# At the end of filesystem's initialization, AG 0 will have $freecount free
> +# inodes in the agi->freecount, create $freecount extra dummy files to fill it.
> +for i in `seq 1 $freecount`; do
> +	touch $SCRATCH_MNT/dummy_file$i
> +done
> +
> +_scratch_unmount >/dev/null 2>&1
> +
> +# agi->freecount is 0 here, corrupt it to show extra free inodes
> +$XFS_DB_PROG -x -c "agi 0" -c "write freecount 10" $SCRATCH_DEV >> $seqres.full 2>&1

Minor nit, please use _scratch_xfs_db helper.

> +
> +_scratch_mount
> +
> +# Lock up a buggy kernel
> +touch $SCRATCH_MNT/lockupfile >> $seqres.full 2>&1

I applied your patch

Subject: [PATCH] Stop searching for free slots in an inode chunk when there are none

on top of 4.13-rc5 kernel, test passed with a non-debug built xfs, but
with debug built xfs, creating new inode on corrupted freecount xfs
crashes the kernel.

XFS: Assertion failed: freecount == be32_to_cpu(agi->agi_freecount), file: fs/xfs/libxfs/xfs_ialloc.c, line: 246

Perhaps test should _notrun with CONFIG_XFS_DEBUG on?

Thanks,
Eryu

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
> index cf876a29..37e4e641 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -54,6 +54,7 @@
>  054 auto quick
>  055 dump ioctl remote tape
>  056 dump ioctl auto quick
> +057 auto quick fuzzers dangerous
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
