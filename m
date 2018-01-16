Received: from mx1.redhat.com ([209.132.183.28]:48880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750764AbeAPHs5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 16 Jan 2018 02:48:57 -0500
Date: Tue, 16 Jan 2018 15:48:54 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] fstests: common/rc: fix device still mounted error with
 SCRATCH_DEV_POOL
Message-ID: <20180116074854.GJ3102@eguan.usersys.redhat.com>
References: <20180113010459.24321-1-bo.li.liu@oracle.com>
 <20180115062228.GA3102@eguan.usersys.redhat.com>
 <20180116071020.GA6721@lim.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180116071020.GA6721@lim.localdomain>
Sender: fstests-owner@vger.kernel.org
To: Liu Bo <bo.li.liu@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jan 15, 2018 at 11:10:20PM -0800, Liu Bo wrote:
> On Mon, Jan 15, 2018 at 02:22:28PM +0800, Eryu Guan wrote:
> > On Fri, Jan 12, 2018 at 06:04:59PM -0700, Liu Bo wrote:
> > > One of btrfs tests, btrfs/011, uses SCRATCH_DEV_POOL and puts a non-SCRATCH_DEV
> > > device as the first one when doing mkfs, and this makes
> > > _require_scratch{_nocheck} fail to umount $SCRATCH_MNT since it checks mount
> > > point with SCRATCH_DEV only, and for sure it finds nothing to umount and the
> > > following tests complain about 'device still mounted' alike errors.
> > > 
> > > Introduce a helper to address this special case where both btrfs and scratch
> > > dev pool are in use.
> > > 
> > > Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
> > 
> > Hmm, I didn't see this problem, I ran btrfs/011 then another tests that
> > uses $SCRATCH_DEV, and the second test ran fine too. Can you please
> > provide more details?
> 
> Sure, so I was using 4 devices of size being 2500M, btrfs/011 bailed
> out when doing a cp due to enospc then _fail is called to abort the
> test, and the mount point now is associated with a different device
> other than SCRATCH_DEV, so that _require_scratch_nocheck in btrfs/012
> was not able to umount SCRATCH_MNT.

Yeah, that's the exact case I described as below. I think adding
_scratch_umount >/dev/null 2>&1 in _cleanup() would resolve your issue.

> 
> > 
> > Anyway, I think we should fix btrfs/011 to either not use $SCRATCH_DEV
> > in replace operations (AFAIK, other btrfs replace tests do this) or
> > umount all devices before exit. And I noticed btrfs/011 does umount
> > $SCRATCH_MNT at the end of workout(), so usually all should be fine
> > (perhaps it would leave a device mounted if interrupted in the middle of
> > test run, because _cleanup() doesn't do umount).
> 
> That's true, if you want, I could fix all btrfs replace tests to
> umount SCRATCH_MNT right before exit.

I think only the tests that replace $SCRATCH_DEV (as what btrfs/011
does) need fixes, _require_scratch would umount $SCRATCH_MNT for other
tests.

Thanks,
Eryu
