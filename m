Received: from mail-qt0-f176.google.com ([209.85.216.176]:35836 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753446AbdHUQsT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 21 Aug 2017 12:48:19 -0400
Received: by mail-qt0-f176.google.com with SMTP id x36so16937676qtx.2
        for <fstests@vger.kernel.org>; Mon, 21 Aug 2017 09:48:18 -0700 (PDT)
Date: Mon, 21 Aug 2017 12:48:16 -0400
From: Josef Bacik <josef@toxicpanda.com>
Subject: Re: Crash Consistency xfstests
Message-ID: <20170821164815.GA23225@destiny>
References: <CAOQ4uxgSkzxqoH0T+WpKdsCLJw0439fEG+C7y+d1eEJ=obkGAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgSkzxqoH0T+WpKdsCLJw0439fEG+C7y+d1eEJ=obkGAQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Josef Bacik <josef@toxicpanda.com>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, fstests <fstests@vger.kernel.org>, Eryu Guan <eguan@redhat.com>, Christoph Hellwig <hch@lst.de>
List-ID: <fstests@vger.kernel.org>

On Mon, Aug 21, 2017 at 05:35:02PM +0200, Amir Goldstein wrote:
> On Wed, Aug 16, 2017 at 3:06 PM, Josef Bacik <josef@toxicpanda.com> wrote:
> ...
> >
> > Sorry I was travelling yesterday so I couldn't give this my full attention.
> > Everything you guys do is already accomplished with dm-log-writes.  If you look
> > at the example scripts I've provided
> >
> > https://github.com/josefbacik/log-writes/blob/master/replay-individual-faster.sh
> > https://github.com/josefbacik/log-writes/blob/master/replay-fsck-wrapper.sh
> >
> > The first initiates the replay, and points at the second script to run after
> > each entry is replayed.  The whole point of this stuff was to make it as
> > flexible as possible.  The way we use it is to replay, create a snapshot of the
> > replay, mount, unmount, fsck, delete the snapshot and carry on to the next
> > position in the log.
> >
> > There is nothing keeping us from generating random crash points, this has been
> > something on my list of things to do forever.  All that would be required would
> > be to hold the entries between flush/fua events in memory, and then replay them
> > in whatever order you deemed fit.  That's the only functionality missing from my
> > replay-log stuff that CrashMonkey has.
> >
> > The other part of this is getting user space applications to do more thorough
> > checking of consistency that it expects, which I implemented here
> >
> > https://github.com/josefbacik/fstests/commit/70d41e17164b2afc9a3f2ae532f084bf64cb4a07
> >
> > fsx will randomly do operations to a file, and every time it fsync()'s it saves
> > it's state and marks the log.  Then we can go back and replay the log to the
> > mark and md5sum the file to make sure it matches the saved state.  This
> > infrastructure was meant to be as simple as possible so the possiblities for
> > crash consistency testing were endless.  One of the next areas we plan to use
> > this in Facebook is just for application consistency, so we can replay the fs
> > and verify the application works in whatever state the fs is at any given point.
> >
> 
> Joseph,
> 
> FYI, while testing your patches I found that on my system (Ubuntu 16.04)
> fsx was always generating the same pseudo random sequence, even
> though the printed seed was different.
> 
> Replacing initstate()/setstate() with srandom() in fsx fixed the problem for me.
> When I further mixed pid into the randomized seed, thus, generating
> different sequence of events in the 4 parallel fsx invocations, I
> started getting
> checksum failures on replay. I will continue to investigate this phenomena.
> 
> BTW, I am not sure if it is best to use a randomized or constant random seed
> for an xfstest. What is the common practice if any?
> 

Oops I thought fsx was generating different sequence each time.  My preference
is that we be as random as possible and we just print out the seed at the start
so that if we hit a problem we can go back and reproduce with the same seed for
debugging.  Fsstress prints out the seed it's using, we should do the same for
fsx.

> > 3) My patches need to actually be pushed into upstream fstests.  This would be
> > the largest win because then all the fs developers would be running the tests
> > by default.
> >
> 
> FYI, I rebased your patch, added some minor cleanups and tested over xfs:
> https://github.com/amir73il/xfstests/commits/dm-log-writes
> 
> replay-log is still an external dependency, but I intend to import
> it as xfstests src test program.
> 

Yeah I think this is a good idea and what I had planned to do the next time I
submitted stuff.

> I also intend to split your patch into several smaller patches
> - infrastructure
> - fsx fixes
> - generic test
> 
> When done with this, I will try to import the fsstress/replay test to
> xfstests.
> 
> For now, I will leave the btrfs specific tests out from my work.
> It should be trivial to add them once the basic infra has been merged.
> 

Agreed.

> I noticed that if SCRATCH_DEV is a dm target itself (linear), then
> log-writes target creation fails. Is that by design? Can be fixed?
> If not, the test would have to require_scratch_not_dm_target or so.
> 
> Please let me know if have any other tip or pointers for me.

Huh that's weird, I was using it with dm-snapshot and it worked fine.  Maybe I
was doing something else and it's never worked, but it's definitely not by
design.  I'll look into this when I get some time.  Thanks,

Josef
