Received: from aserp2120.oracle.com ([141.146.126.78]:33078 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727305AbfIRXLI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Sep 2019 19:11:08 -0400
Date: Wed, 18 Sep 2019 16:10:50 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: question of xfs/148 and xfs/149
Message-ID: <20190918231050.GH2229799@magnolia>
References: <4BF2FD5A942B1C4B828DDAF5635768C1041AB0E2@G08CNEXMBPEKD02.g08.fujitsu.local>
 <20190917163933.GC736475@magnolia>
 <20190918025915.GK7239@dhcp-12-102.nay.redhat.com>
 <7b5d5797-afff-90bc-0131-38fd13eced34@cn.fujitsu.com>
 <20190918163711.GX2229799@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918163711.GX2229799@magnolia>
Sender: fstests-owner@vger.kernel.org
To: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Cc: Zorro Lang <zlang@redhat.com>, "fstests@vger.kernel.org" <fstests@vger.kernel.org>, xfs <linux-xfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 18, 2019 at 09:37:11AM -0700, Darrick J. Wong wrote:
> On Wed, Sep 18, 2019 at 11:24:47AM +0800, Yang Xu wrote:
> > 
> > 
> > on 2019/09/18 10:59, Zorro Lang wrote:
> > > xfs/030 is weird, I've found it long time ago.
> > > 
> > > If I do a 'whole disk mkfs' (_scratch_mkfs_xfs), before this sized mkfs:
> > > 
> > >    _scratch_mkfs_xfs $DSIZE >/dev/null 2>&1
> > > 
> > > Everything looks clear, and test pass. I can't send a patch to do this,
> > > because I don't know the reason.
> > Yes. I also found running _scratch_mkfs_xfs in xfs/030 can slove this
> > problem yesterday. Or, we can adjust _try_wipe_scratch_devs order in
> > check(But I dont't have enough reason to explain why adjust it). as below:
> 
> (Yeah, I don't see any obvious reason why that would change outcomes...)
> 
> > --- a/check
> > +++ b/check
> > @@ -753,7 +753,6 @@ for section in $HOST_OPTIONS_SECTIONS; do
> >                         # _check_dmesg depends on this log in dmesg
> >                         touch ${RESULT_DIR}/check_dmesg
> >                 fi
> > -               _try_wipe_scratch_devs > /dev/null 2>&1
> >                 if [ "$DUMP_OUTPUT" = true ]; then
> >                         _run_seq 2>&1 | tee $tmp.out
> >                         # Because $? would get tee's return code
> > @@ -799,7 +798,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
> >                 # Scan for memory leaks after every test so that associating
> >                 # a leak to a particular test will be as accurate as
> > possible.
> >                 _check_kmemleak || err=true
> > -
> > +               _try_wipe_scratch_devs > /dev/null 2>&1
> >                 # test ends after all checks are done.
> >                 $timestamp && _timestamp
> >                 stop=`_wallclock`
> > 
> > > 
> > > I'm not familiar with xfs_repair so much, so I don't know what happens
> > > underlying. I suppose the the part after the $DSIZE affect the xfs_repair,
> > > but I don't know why the wipefs can cause that, wipefs only erase 4 bytes
> > > at the beginning.
> > > 
> >  I am finding the reasion. It seems wipefs wipes important information and
> > $DSIZE option(using single agcount or dsize, it also fails ) can not format
> > disk completely. If we use other options, it can pass.
> 
> How does mkfs fail, specifically?
> 
> Also, what's your storage configuration?  And lsblk -D output?

I'm still interested in the answer to these questions, but I've done a
little more research and noticed that yes, xfs/030 fails if the device
doesn't support zeroing discard.

First, if mkfs.xfs detects an old primary superblock, it will write
zeroes to all superblocks before formatting the new filesystem.
Obviously this won't be done if the device doesn't have a primary
superblock.

(1) So let's say that a previous test formatted a 4GB scratch disk with
all defaults, and let's say that we have 4 AGs.  The disk will look like
this:

  SB0 [1G space] SB1 [1G space] SB2 [1G space] SB3 [1G space]

(2) Now we _try_wipe_scratch_devs, which wipes out the primary label:

  000 [1G space] SB1 [1G space] SB2 [1G space] SB3 [1G space]

(3) Now xfs/030 runs its special mkfs command (6AGs, 100MB disk).  If the
disk supports zeroing discard, it will discard the whole device:

  <4GB of zeroes>

(4) Then it will lay down its own filesystem:

  SB0 [16M zeroes] SB1 [16M zeroes] <4 more AGs> <zeroes from 100M to 4G>

(5) Next, xfs/030 zaps the primary superblock:

  000 [16M zeroes] SB1 [16M zeroes] <4 more AGs> <zeroes from 100M to 4G>

(6) Next, xfs/030 runs xfs_repair.  It fails to find the primary sb, so it
tries to find secondary superblocks.  Its first strategy is to compute
the fs geometry assuming all default options.  In this case, that means
4 AGs, spaced 1G apart.  They're all zero, so it falls back to a linear
scan of the disk.  It finds SB1, uses that to rewrite the primary super,
and continues with the repair (which is mostly uneventful).  The test
passes; this is why it works on my computer.

---------

Now let's see what happened before _try_wipe_scratch_devs.  In step (3)
mkfs would find the old superblocks and wipe the superblocks, before
laying down the new superblocks:

  SB0 [16M zeroes] SB1 [16M zeroes] <4 more AGs> <zeroes from 100M to 1G> \
      000 [1G space] 000 [1G space] 000 [1G space]

Step (5) zaps the primary, yielding:

  000 [16M zeroes] SB1 [16M zeroes] <4 more AGs> <zeroes from 100M to 1G> \
      000 [1G space] 000 [1G space] 000 [1G space]

Step (6) fails to find a primary superblock so it tries to read backup
superblocks at 1G, 2G, and 3G, but they're all zero so it falls back to
the linear scan and picks up SB1 and proceeds with a mostly uneventful
repair.  The test passes.

---------

However, with _try_wipe_scratch_devs and a device that doesn't support
discard (or MKFS_OPTIONS includes -K), we have a problem.  mkfs.xfs
doesn't discard the device nor does it find a primary superblock, so it
simply formats the new filesystem.  We end up with:

  SB0 [16M zeroes] SB1 [16M zeroes] <4 more AGs> <zeroes from 100M to 1G> \
      SB'1 [1G space] SB'2 [1G space] SB'3 [1G space]

Where SB[0-5] are from the filesystem that xfs/030 formatted but
SB'[1-3] are from the filesystem that was on the scratch disk before
xfs/030 even started.  Uhoh.

Step (5) zaps the primary, yielding:

  000 [16M zeroes] SB1 [16M zeroes] <4 more AGs> <zeroes from 100M to 1G> \
      SB'1 [1G space] SB'2 [1G space] SB'3 [1G space]

Step (6) fails to find a primary superblock so it tries to read backup
superblocks at 1G.  It finds SB'1 and uses that to reconstruct the /old/
filesystem, with what looks like massive filesystem damage.  This
results in test failure.  Oops.

----------

The reason for adding _try_wipe_scratch_devs was to detect broken tests
that started using the filesystem on the scratch device (if any) before
(or without!) formatting the scratch device.  That broken behavior could
result in spurious test failures when xfstests was run in random order
mode either due to mounting an unformatted device or mounting a corrupt
fs that some other test left behind.

I guess a fix for XFS would be have _try_wipe_scratch_devs try to read
the primary superblock to compute the AG geometry and then erase all
superblocks that could be on the disk; and then compute the default
geometry and wipe out all those superblocks too.

Does any of that square with what you've been seeing?

--D

> --D
> 
> > > Darrick, do you know more about that?
> > > 
> > > Thanks,
> > > Zorro
> > > 
> > > > > xfs/148 is a clone of test 030 using xfs_prepair64 instead of xfs_repair.
> > > > > xfs/149 is a clone of test 031 using xfs_prepair instead of xfs_repair
> > > I'm not worried about it too much, due to it always 'not run' and never
> > > failsYes. But I perfer to remove them because IMO they are useless.
> > > 
> > 
> > > xfs/148 [not run] parallel repair binary xfs_prepair64 is not installed
> > > xfs/149 [not run] parallel repair binary xfs_prepair is not installed
> > > Ran: xfs/148 xfs/149
> > > Not run: xfs/148 xfs/149
> > > Passed all 2 tests
> > > 
> > 
> > 
