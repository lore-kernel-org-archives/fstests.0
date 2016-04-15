Received: from mx2.suse.de ([195.135.220.15]:54635 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750952AbcDOXwn (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 15 Apr 2016 19:52:43 -0400
Date: Fri, 15 Apr 2016 16:52:41 -0700
From: Mark Fasheh <mfasheh@suse.de>
Subject: Re: [PATCH] btrfs/104: remove ugly sleep
Message-ID: <20160415235241.GQ2187@wotan.suse.de>
Reply-To: Mark Fasheh <mfasheh@suse.de>
References: <20160414230409.GO2187@wotan.suse.de>
 <CAL3q7H6+bW60tS4Z5ptM9Sbbk7Hd92vZNcA4n2PWtPZ1vBfvkg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H6+bW60tS4Z5ptM9Sbbk7Hd92vZNcA4n2PWtPZ1vBfvkg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Filipe Manana <fdmanana@gmail.com>
Cc: fstests@vger.kernel.org, Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Apr 15, 2016 at 12:04:53PM +0100, Filipe Manana wrote:
> On Fri, Apr 15, 2016 at 12:04 AM, Mark Fasheh <mfasheh@suse.de> wrote:
> > diff --git a/tests/btrfs/104 b/tests/btrfs/104
> > index 6afaa02..627e77b 100755
> > --- a/tests/btrfs/104
> > +++ b/tests/btrfs/104
> > @@ -145,11 +145,9 @@ _scratch_cycle_mount
> >  # referenced above.
> >  _run_btrfs_util_prog subvolume delete $SCRATCH_MNT/snap1
> >
> > -# There is no way from userspace to force btrfs_drop_snapshot to run
> > -# at a given time (even via mount/unmount). We must wait for it to
> > -# start and complete. This is the shortest time on my tests systems I
> > -# have found which always allows drop_snapshot to run to completion.
> > -sleep 45
> > +# Removing snapshots on btrfs is a delayed operation, so we must wait for
> > +# btrfs_drop_snapshot to complete.
> > +_run_btrfs_util_prog subvolume sync $SCRATCH_MNT
> 
> Looks good, except that this will cause a test failure when running
> with older versions of btrfs-progs that don't have this command.

Right, also there was at least one version which had a broken subvol sync
(see commit d3be5b6).


> We should skip the test with such old versions (it's usually what we
> do everywhere) or make it fallback to the sleep.
> We have "_require_btrfs <command>" to check if btrfs-progs supports a
> specific command, so we could extend it to check for a subcommand too
> as an optional argument so we could call
> "_require_btrfs subvolume sync" in the test.

Hmm, so _require_btrfs() can do this by running --help on the subcommand and
checking the return value. I don't think there's a similar trick we can do
for 'btrfs subvol sync'. Anything other than a subvolume as an argument to
subvol sync returns 1.

I suppose we could try grepping the output for 'too few arguments' though.

Also, thanks for the review!
	--Mark

--
Mark Fasheh
