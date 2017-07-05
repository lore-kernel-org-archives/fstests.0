Received: from mx1.redhat.com ([209.132.183.28]:36560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752018AbdGEMuZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 5 Jul 2017 08:50:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 82A0E80F6B
        for <fstests@vger.kernel.org>; Wed,  5 Jul 2017 12:50:24 +0000 (UTC)
Date: Wed, 5 Jul 2017 08:50:16 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] xfs test: Buffer resubmittion test
Message-ID: <20170705125016.GB51285@bfoster.bfoster>
References: <20170703153200.14423-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170703153200.14423-1-cmaiolino@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Carlos Maiolino <cmaiolino@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 03, 2017 at 05:32:00PM +0200, Carlos Maiolino wrote:
> Hi folks,
> 
> this is the xfstests case for the buffer resubmition failures with
> dm-thin I'm working on.
> 
> I used test 999 to avoid the need of changing the test number between
> revisions. I don't write a xfstest for a while, so I am not sure if the
> test is ok as it is.
> 
> It is doing its job though :) Passing with a kernel using my last
> patches for the problem (although they still need revision), and hanging
> up when the test is executed with a kernel without my patches, so be
> careful to try it.
> 
> Thoughts?
> 
> Cheers
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>  tests/xfs/999     | 102 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/999.out |   2 ++
>  tests/xfs/group   |   1 +
>  3 files changed, 105 insertions(+)
>  create mode 100755 tests/xfs/999
>  create mode 100644 tests/xfs/999.out
> 
> diff --git a/tests/xfs/999 b/tests/xfs/999
> new file mode 100755
> index 0000000..5ae8b74
> --- /dev/null
> +++ b/tests/xfs/999
> @@ -0,0 +1,102 @@
> +#! /bin/bash
> +# FS QA Test 999
> +#
> +# Test buffer resubmission after a failed writeback with to a full overcommited
> +# dm-thin device. 

FYI: trailing space on the line above. A bit more information about the
problem this is testing for would be useful as well.

> +#
> +# This test will hang the filesystem when ran on an unpatched kernel
> +#
> +#-----------------------------------------------------------------------
> +# Copyright (c) 2017 YOUR NAME HERE.  All Rights Reserved.
> +#

Needs a copyright. :)

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
> +	$UMOUNT_PROG $mnt >/dev/null 2>&1
> +	$LVM_PROG vgremove -ff $vgname >>$seqres.full 2>&1
> +	$LVM_PROG pvremove -ff $SCRATCH_DEV >>$seqres.full 2>&1
> +}
> +
> +# get standard environment, filters and checks
> +. ./common/rc
> +. ./common/filter
> +
> +# real QA test starts here
> +
> +# Modify as appropriate.
> +_supported_fs xfs
> +_supported_os Linux
> +_require_scratch_nocheck
> +_require_dm_target thin-pool
> +_require_command $LVM_PROG lvm
> +
> +# remove previous $seqres.full before test
> +rm -f $seqres.full
> +
> +vgname=vg_$seq
> +lvname=lv_$seq
> +poolname=pool_$seq
> +snapname=snap_$seq
> +origpsize=100
> +virtsize=200
> +newpsize=200
> +mnt=$SCRATCH_DIR/mnt_$seq

I think this should be $SCRATCH_MNT.

> +mkdir -p $mnt
> +

We haven't mounted scratch at this point so it looks like this creates a
directory on the local rootfs..? Looking ahead.. if we're not really
going to mount the scratch dev directly, could we just use $SCRATCH_MNT
as the mountpoint?

> +#Ensure we have enough disk space
> +_scratch_mkfs_sized $((250 * 1024 * 1024)) >>$seqres.full 2>&1
> +
> +$LVM_PROG pvcreate -f $SCRATCH_DEV >/dev/null 2>&1
> +$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >/dev/null 2>&1
> +
> +$LVM_PROG lvcreate  --thinpool $poolname  --errorwhenfull y --zero n \
> +-L $origpsize --poolmetadatasize 4M $vgname >/dev/null 2>&1
> +
> +$LVM_PROG lvcreate  --virtualsize $virtsize -T $vgname/$poolname \
> +-n $lvname >/dev/null 2>&1

The above multi-line commands could use some indentation and perhaps
some one-liner comments to explain what's going on. E.g., "create an
overprovisioned thin volume."

Also, perhaps some of the /dev/null redirection should go to
$seqres.full..?

> +
> +_mkfs_dev /dev/mapper/$vgname-$lvname >/dev/null 2>&1
> +
> +$LVM_PROG lvcreate  -k n -s $vgname/$lvname -n $snapname >/dev/null 2>&1
> +
> +_mount /dev/mapper/$vgname-$snapname $mnt
> +

"Consume all of the space in the volume and freeze to ensure everything
required to make the fs consistent is flushed to disk. Note that this
may hang on affected XFS filesystems."

> +xfs_io -f -d -c 'pwrite -b 1m 0 120m' $mnt/f1 >/dev/null 2>&1
> +
> +fsfreeze -f $mnt &
> +
> +#Wait fsfreeze to its job
> +sleep 10

I think you could use 'wait' here rather than a sleep. But is there a
reason we need to put the freeze in the background in the first place?
It seems to me this test will either complete or hang regardless. ;P

> +

"extend the volume with sufficient space and unfreeze ..."

> +lvextend -L $newpsize $vgname/$poolname >/dev/null 2>&1
> +
> +fsfreeze -u $mnt
> +echo "Test OK"
> +
> +status=0
> +exit
> diff --git a/tests/xfs/999.out b/tests/xfs/999.out
> new file mode 100644
> index 0000000..8c3c938
> --- /dev/null
> +++ b/tests/xfs/999.out
> @@ -0,0 +1,2 @@
> +QA output created by 999
> +Test OK
> diff --git a/tests/xfs/group b/tests/xfs/group
> index 792161a..2bde916 100644
> --- a/tests/xfs/group
> +++ b/tests/xfs/group
> @@ -416,3 +416,4 @@
>  416 dangerous_fuzzers dangerous_scrub dangerous_repair
>  417 dangerous_fuzzers dangerous_scrub dangerous_online_repair
>  418 dangerous_fuzzers dangerous_scrub dangerous_repair
> +999 dangerous

I think the auto group makes sense too.

Also, since the discussion around having a couple tests here (one using
error injection and this one using dm-thin) it seems like this test
could be more suited to a generic test.  Nothing in the test really
depends on a particular filesystem. The header comment could simply be
updated to explain the specific XFS issue as the inspiration and that
the test generically exercises the ability to recover/continue after a
dm-thin ENOPSPC and subsequent volume extend. Thoughts?

Brian

> -- 
> 2.9.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
