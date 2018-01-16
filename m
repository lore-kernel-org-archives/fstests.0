Received: from userp2120.oracle.com ([156.151.31.85]:49762 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750716AbeAPHQG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Jan 2018 02:16:06 -0500
Date: Mon, 15 Jan 2018 23:10:20 -0800
From: Liu Bo <bo.li.liu@oracle.com>
Subject: Re: [PATCH] fstests: common/rc: fix device still mounted error with
 SCRATCH_DEV_POOL
Message-ID: <20180116071020.GA6721@lim.localdomain>
Reply-To: bo.li.liu@oracle.com
References: <20180113010459.24321-1-bo.li.liu@oracle.com>
 <20180115062228.GA3102@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180115062228.GA3102@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 15, 2018 at 02:22:28PM +0800, Eryu Guan wrote:
> On Fri, Jan 12, 2018 at 06:04:59PM -0700, Liu Bo wrote:
> > One of btrfs tests, btrfs/011, uses SCRATCH_DEV_POOL and puts a non-SCRATCH_DEV
> > device as the first one when doing mkfs, and this makes
> > _require_scratch{_nocheck} fail to umount $SCRATCH_MNT since it checks mount
> > point with SCRATCH_DEV only, and for sure it finds nothing to umount and the
> > following tests complain about 'device still mounted' alike errors.
> > 
> > Introduce a helper to address this special case where both btrfs and scratch
> > dev pool are in use.
> > 
> > Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
> 
> Hmm, I didn't see this problem, I ran btrfs/011 then another tests that
> uses $SCRATCH_DEV, and the second test ran fine too. Can you please
> provide more details?

Sure, so I was using 4 devices of size being 2500M, btrfs/011 bailed
out when doing a cp due to enospc then _fail is called to abort the
test, and the mount point now is associated with a different device
other than SCRATCH_DEV, so that _require_scratch_nocheck in btrfs/012
was not able to umount SCRATCH_MNT.

> 
> Anyway, I think we should fix btrfs/011 to either not use $SCRATCH_DEV
> in replace operations (AFAIK, other btrfs replace tests do this) or
> umount all devices before exit. And I noticed btrfs/011 does umount
> $SCRATCH_MNT at the end of workout(), so usually all should be fine
> (perhaps it would leave a device mounted if interrupted in the middle of
> test run, because _cleanup() doesn't do umount).

That's true, if you want, I could fix all btrfs replace tests to
umount SCRATCH_MNT right before exit.

thanks,
-liubo
