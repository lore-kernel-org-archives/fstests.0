Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40139 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752277AbbDAR5L (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 1 Apr 2015 13:57:11 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t31HvBNn006422
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 1 Apr 2015 13:57:11 -0400
Date: Wed, 1 Apr 2015 13:57:10 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH 6/9] generic: test I/O error path by fully filling dm
 snapshot
Message-ID: <20150401175710.GF4756@bfoster.bfoster>
References: <1426846618-23413-7-git-send-email-eguan@redhat.com>
 <1427896455-12048-1-git-send-email-eguan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1427896455-12048-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 01, 2015 at 09:54:15PM +0800, Eryu Guan wrote:
> xfs used to panic in this test, this xfs commit fix the bug
> 
> 8d6c121 xfs: fix buffer use after free on IO error
> 
> ext4 and btrfs trigger WARNING on current 4.0-rc3 kernel
> 
> Signed-off-by: Eryu Guan <eguan@redhat.com>
> ---
> v2:
> - add _require_dm_snapshot() function to require dm snapshot target
> - make sure SCRATCH_DEV has enough space for the test
> - fail the test directly when failures detected in setup phase
> 

FYI, the mail subject header hasn't changed so Dave might not notice
this is a new patch.

>  common/config         |  1 +
>  common/rc             | 10 ++++++
>  tests/generic/081     | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/081.out |  2 ++
>  tests/generic/group   |  1 +
>  5 files changed, 100 insertions(+)
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
> diff --git a/common/rc b/common/rc
> index 857308a..74df379 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1311,6 +1311,16 @@ _require_dm_flakey()
>      fi
>  }
>  
> +_require_dm_snapshot()
> +{
> +	_require_command "$DMSETUP_PROG" dmsetup
> +	modprobe dm-snapshot >/dev/null 2>&1
> +	$DMSETUP_PROG targets | grep -q snapshot
> +	if [ $? -ne 0 ]; then
> +		_notrun "This test requires dm snapshot support"
> +	fi
> +}
> +
>  # this test requires the projid32bit feature to be available in mkfs.xfs.
>  #
>  _require_projid32bit()
> diff --git a/tests/generic/081 b/tests/generic/081
> new file mode 100755
> index 0000000..3e17d34
> --- /dev/null
> +++ b/tests/generic/081
> @@ -0,0 +1,86 @@
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
> +_require_dm_snapshot
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
> +# make sure there's enough disk space for 256M lv, test for 300M here in case
> +# lvm uses some space for metadata
> +_scratch_mkfs_sized $((300 * 1024 * 1024)) >>$seqres.full 2>&1
> +$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
> +$LVM_PROG lvcreate --yes -L 256M -n $lvname $vgname >>$seqres.full 2>&1
> +
> +# _mkfs_dev exits the test on failure, this can make sure lv is created in
> +# above vgcreate/lvcreate steps
> +_mkfs_dev /dev/mapper/$vgname-$lvname
> +
> +# create a 4M snapshot
> +$LVM_PROG lvcreate -s -L 4M -n $snapname $vgname/$lvname >>$seqres.full 2>&1 || \
> +	_fail "Failed to create snapshot"
> +
> +_mount /dev/mapper/$vgname-$snapname $mnt
> +
> +# write 5M data to the snapshot
> +$XFS_IO_PROG -fc "pwrite 0 5m" $mnt/testfile >>$seqres.full 2>&1
> +

I noticed there were no errors in $seqres.full when running this test.
E.g., the pwrite succeeds because nothing is written back to disk at
that point. The fs does shutdown due to the flush on umount, but it's
kind of hidden away up in the _cleanup() function.

Kind of a nit, but we could be a bit more explicit and do a '-c fsync'
after the pwrite here? That way it's clear that writeback to disk is
part of the core test and we have a little feedback in $seqres.full that
I/O errors occurred, as expected.

Otherwise, the rest looks Ok to me.

Brian

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
