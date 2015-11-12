Received: from mx2.suse.de ([195.135.220.15]:52667 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750824AbbKLRIw (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 12 Nov 2015 12:08:52 -0500
Date: Thu, 12 Nov 2015 09:08:50 -0800
From: Mark Fasheh <mfasheh@suse.de>
Subject: Re: [PATCH] btrfs/104: replace ugly sleep with subvol sync
Message-ID: <20151112170850.GM15575@wotan.suse.de>
Reply-To: Mark Fasheh <mfasheh@suse.de>
References: <20151110003002.GK15575@wotan.suse.de>
 <20151112004917.GQ19199@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151112004917.GQ19199@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi David,

On Thu, Nov 12, 2015 at 11:49:17AM +1100, Dave Chinner wrote:
> > +# Subvol delete is a delayed operation, wait for it to complete before
> > +# unmounting.
> > +_run_btrfs_util_prog subvolume sync $SCRATCH_MNT
> 
> Won't that now fail on systems without the "subvolume sync"
> command because of the hidden use of _run_check in
> _run_btrfs_util_prog? i.e. doesn't it need to do something like:
> 
> $BTRFS_UTIL_PROG subvolume sync $SCRATCH_MNT
> if [ $? -ne 0 ]; then
> 	sleep 45
> fi
> 
> So that it works on all versions of the btrfs utility?

You know, you are probably right and I should have known because we already
talked about _run_check hiding errors! I'll fix that up and send out a new
patch once I've tested the change.

Thanks,
	--Mark

--
Mark Fasheh
