Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33664 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbbCYXIn (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 25 Mar 2015 19:08:43 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2PN8fDA016241
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 25 Mar 2015 19:08:42 -0400
Date: Wed, 25 Mar 2015 19:08:39 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 6/9] generic: test I/O error path by fully filling dm
 snapshot
Message-ID: <20150325230838.GA13510@bfoster.bfoster>
References: <1426846618-23413-1-git-send-email-eguan@redhat.com>
 <1426846618-23413-7-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1426846618-23413-7-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 20, 2015 at 06:16:55PM +0800, Eryu Guan wrote:
> xfs used to panic in this test, this xfs commit fix the bug
> 
> 8d6c121 xfs: fix buffer use after free on IO error
> 
> ext4 and btrfs trigger WARNING on current 4.0-rc3 kernel
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
>  common/config         |  1 +
>  tests/generic/081     | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/081.out |  2 ++
>  tests/generic/group   |  1 +
>  4 files changed, 83 insertions(+)
>  create mode 100755 tests/generic/081
>  create mode 100644 tests/generic/081.out
> 
> diff --git a/common/config b/common/config
> index e5c3579..3732287 100644
> --- a/common/config
> +++ b/common/config
> @@ -190,6 +190,7 @@ export DMSETUP_PROG="`set_prog_path dmsetup`"
>  export WIPEFS_PROG="`set_prog_path wipefs`"
>  export DUMP_PROG="`set_prog_path dump`"
>  export RESTORE_PROG="`set_prog_path restore`"
> +export LVM_PROG="`set_prog_path lvm`"
>  
>  # Generate a comparable xfsprogs version number in the form of
>  # major * 10000 + minor * 100 + release
> diff --git a/tests/generic/081 b/tests/generic/081
> new file mode 100755
> index 0000000..476bfb9
> --- /dev/null
> +++ b/tests/generic/081
> @@ -0,0 +1,79 @@
> +#! /bin/bash
> +# FS QA Test No. 081
> +#
> +# Test I/O error path by fully filling an dm snapshot.
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2015 Red Hat Inc. All Rights Reserved.
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
> +	# lvm may have umounted it on I/O error, but in case it does not
> +	$UMOUNT_PROG $mnt >/dev/null 2>&1
> +	$LVM_PROG vgremove -f $vgname >>$seqres.full 2>&1
> +	$LVM_PROG pvremove -f $SCRATCH_DEV >>$seqres.full 2>&1
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +_supported_fs generic
> +_supported_os Linux
> +_require_test
> +_require_scratch_nocheck
> +_require_block_device $SCRATCH_DEV
> +_require_command $LVM_PROG lvm
> +
> +echo "Silence is golden"
> +rm -f $seqres.full
> +
> +vgname=vg_$seq
> +lvname=base_$seq
> +snapname=snap_$seq
> +mnt=$TEST_DIR/mnt_$seq
> +mkdir -p $mnt
> +
> +$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
> +$LVM_PROG lvcreate --yes -L 256M -n $lvname $vgname >>$seqres.full 2>&1
> +

Hmm, I take it this introduces a block size size requirement of 256MB.
If so, perhaps we could use a sparse file and loop, seeing as we're not
actually using much space. It's not that big of a deal I suppose, even a
ramdisk probably has that much space. At the very least we should do
something like the following:

lvcreate -L 256M ... || _fail "lvcreate failed"

... to catch any failures from these commands.

> +_mkfs_dev /dev/mapper/$vgname-$lvname
> +
> +# create a 4M snapshot
> +$LVM_PROG lvcreate -s -L 4M -n $snapname $vgname/$lvname >>$seqres.full 2>&1

Same thing here... I guess we're assuming dm-snapshot is available too.
We might want a require test for that...

Brian

> +
> +_mount /dev/mapper/$vgname-$snapname $mnt
> +
> +# write 5M data to the snapshot
> +$XFS_IO_PROG -fc "pwrite 0 5m" $mnt/testfile >>$seqres.full 2>&1
> +
> +# _check_dmesg will check for WARNINGs/BUGs in dmesg
> +status=0
> +exit
> diff --git a/tests/generic/081.out b/tests/generic/081.out
> new file mode 100644
> index 0000000..663a886
> --- /dev/null
> +++ b/tests/generic/081.out
> @@ -0,0 +1,2 @@
> +QA output created by 081
> +Silence is golden
> diff --git a/tests/generic/group b/tests/generic/group
> index cf7408c..f5ebe48 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -83,6 +83,7 @@
>  078 auto quick metadata
>  079 acl attr ioctl metadata auto quick
>  080 auto freeze mount
> +081 auto quick
>  083 rw auto enospc stress
>  088 perms auto quick
>  089 metadata auto
> -- 
> 2.1.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
