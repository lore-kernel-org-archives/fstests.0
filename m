Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34546 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752036AbbDBMIZ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 2 Apr 2015 08:08:25 -0400
Date: Thu, 2 Apr 2015 20:08:22 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 6/9] generic: test I/O error path by fully filling dm
 snapshot
Message-ID: <20150402120822.GI16808@dhcp-13-216.nay.redhat.com>
References: <1426846618-23413-7-git-send-email-eguan@redhat.com>
 <1427896455-12048-1-git-send-email-eguan@redhat.com>
 <20150401224101.GG28621@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150401224101.GG28621@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 02, 2015 at 09:41:01AM +1100, Dave Chinner wrote:
> On Wed, Apr 01, 2015 at 09:54:15PM +0800, Eryu Guan wrote:
> > xfs used to panic in this test, this xfs commit fix the bug
> > 
> > 8d6c121 xfs: fix buffer use after free on IO error
> > 
> > ext4 and btrfs trigger WARNING on current 4.0-rc3 kernel
> > 
> > Signed-off-by: Eryu Guan <eguan@redhat.com>
> ....
> > +# lvm uses some space for metadata
> > +_scratch_mkfs_sized $((300 * 1024 * 1024)) >>$seqres.full 2>&1
> > +$LVM_PROG vgcreate -f $vgname $SCRATCH_DEV >>$seqres.full 2>&1
> > +$LVM_PROG lvcreate --yes -L 256M -n $lvname $vgname >>$seqres.full 2>&1
> > +
> > +# _mkfs_dev exits the test on failure, this can make sure lv is created in
> > +# above vgcreate/lvcreate steps
> > +_mkfs_dev /dev/mapper/$vgname-$lvname
> 
> So on my 1p test VM, this fails with
> 
> +mkfs.xfs: cannot open /dev/mapper/vg_081-base_081: Device or resource busy
> 
> The problem is that udev has not finished setting up the device
> before mkfs is run. Hence we need a "udevadm settle" call after the
> lvcreate call. This results in mkfs succeeding on this machine.
> 
> Eryu, I'm going to commit the test as it stands as it works on all
> my other test systems - can you write a followup patch that does the
> udev settle call in a portable manner? i.e. older systems used to
> have a 'udev-settle' command, do we still care about that?

Sure, I'll do that, along with the fix of the cleanup error, as Brian
suggested.

As a distribution tester of RHEL, I don't care much about older systems
now like RHEL5, but I'll try to make it portable if possible.

Thanks,
Eryu
