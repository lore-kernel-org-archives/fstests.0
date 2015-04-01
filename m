Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:19799 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750874AbbDAWlH (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 1 Apr 2015 18:41:07 -0400
Date: Thu, 2 Apr 2015 09:41:01 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 6/9] generic: test I/O error path by fully filling dm
 snapshot
Message-ID: <20150401224101.GG28621@dastard>
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
....
> +# lvm uses some space for metadata
> +_scratch_mkfs_sized $((300 * 1024 * 1024)) >>$seqres.full 2>&1
> +$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
> +$LVM_PROG lvcreate --yes -L 256M -n $lvname $vgname >>$seqres.full 2>&1
> +
> +# _mkfs_dev exits the test on failure, this can make sure lv is created in
> +# above vgcreate/lvcreate steps
> +_mkfs_dev /dev/mapper/$vgname-$lvname

So on my 1p test VM, this fails with

+mkfs.xfs: cannot open /dev/mapper/vg_081-base_081: Device or resource busy

The problem is that udev has not finished setting up the device
before mkfs is run. Hence we need a "udevadm settle" call after the
lvcreate call. This results in mkfs succeeding on this machine.

Eryu, I'm going to commit the test as it stands as it works on all
my other test systems - can you write a followup patch that does the
udev settle call in a portable manner? i.e. older systems used to
have a 'udev-settle' command, do we still care about that?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
