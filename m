Received: from mx1.redhat.com ([209.132.183.28]:58864 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753193AbeAGPYR (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 7 Jan 2018 10:24:17 -0500
Date: Sun, 7 Jan 2018 23:24:14 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/466: be more precise about which block sizes to
 use
Message-ID: <20180107152414.GM5123@eguan.usersys.redhat.com>
References: <20171211172742.3490-1-tytso@mit.edu>
 <20171213173629.GG6896@magnolia>
 <20171231184508.GA29994@thunk.org>
 <20180102203650.GC5146@magnolia>
 <20180105021227.GA5606@magnolia>
 <20180105032843.GA32314@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180105032843.GA32314@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jan 04, 2018 at 10:28:43PM -0500, Theodore Ts'o wrote:
> > > That depends on whether this function returns the smallest blocksize
> > > guaranteed to pass mkfs given the current set of options or the
> > > theoretical smallest blocksize supported by that fs given the right set
> > > of options.  IOWs, if this is a v5 fs being tested, then "mkfs.xfs -b
> > > size=$(_fs_min_blocksize) -m crc=1" will fail.
> 
> Some of the discussion that we had on our weekly ext4 developer's
> conference call.  One of the motivations for this patch is due to a
> local change that I have in my xfstests tree, which adds:
> 
> 	|| _die "${MKFS_PROG}.$FSTYP failed!"
> 
> to the ${MKFS_PROG}.$FSTYP call in _scratch_mkfs_sized and similar
> functions.  The reason for that is there a number of tests which use
> additional file system options, different block sizes, unusually small
> file system sizes, etc. --- and 99.97% of them don't bother to do any
> error checking.

My first reaction is to fix _scratch_mkfs_sized so it could retry with
only user specified mkfs options, if the first mkfs failed due to
conflicts between MKFS_OPTIONS and addtional mkfs options specified in
the tests. (We've done similar update to _scratch_mkfs in commit
596a068bf130 ("fstests: teach _scratch_mkfs to handle mkfs option
conflicts"), and Dave just brought up that _scratch_mkfs_sized couldn't
handle conflicts in mkfs options just a few days ago.)

And we can fix the tests that fail mkfs due to small fs size, enlarge
the default fs size so mkfs succeeds even with additional mkfs options
specified.

But I'd like to know some exact example tests that fail for you, so I
can dig into them more.

> 
> So what ends up happening is the test will not notice that the mkfs
> had failed, and would continue staggering on, sometimes succeeding,
> and sometimes failing --- depending on what test was running
> previously and the state of the scratch device.  Ugh.  Hence, my
> addition of the "|| die ..."

Yeah, this sometimes does happen. Historically we kind prefer letting
the tests continue even if mkfs and/or mount failed, so the tests could
run in some uncommon setups and exercise some corner cases (this did
help find bugs that are hard to hit before), and in most cases tests
would fail in the end so we noticed such failures.

But we would check mkfs and/or mount failure explicitly if the test will
do destructive operations on scratch dev, e.g. freeze $SCRATCH_DEV or
fulfill $SCRATCH_MNT, so tests won't destroy the underlying filesystem
(usually root fs).

Thanks,
Eryu

> 
> The problem is that generic/466 is one of the few tests that actually
> (a) deliberately feed arguments that cause _scratch_mkfs_sized to
> fail, and (b) actually does error checking.
> 
> Darrick mentioned on the call that he's seen similar problems which
> he's had to track down when testing xfs, and it was simiarly annoying.
> 
> So instead of it being a local hack in my xfstests tree, perhaps this
> is something we should try to fix more generally.  There a number of I
> could imagine going about this.
> 
> 1) The approach I took in this patch, which is requires accurately
> determine min and max blocksizes --- and then to add error checks to
> all of the mkfs invocations in _scratch_mkfs_blocksized for all file
> systems.
> 
> 2) Add an argument to _scratch_mkfs_blockized() and similar functions
> which indicates that error checking should _not_ be done, since it
> will be done by the caller (such as generic/466).  And then add error
> checks in _scratch_mkfs_blocksized() and similar functions unless the
> optional flag is passed by the test.
> 
> 3)  Sweep through all of the tests scripts adding error checks.
> 
> It seems to me (2) might be the simplest approach, although (1) does
> speed up the test somewhat, and so maybe we should do (1) as well as
> (2).  Eryu, do you have any thoughts/opinions?
> 
> > > I haven't tried it in some time, but the last time I ran xfstests
> > > against fuse2fs it more or less worked (modulo all the fancy fallocate
> > > stuff that it doesn't support).
> > 
> > (Maybe we should separate out ext4/fuse2fs?)
> 
> Darrick explained this require bind mounting mount.fuse2fs on
> mount.ext4, and other unnatural hacks.  It seems to me that it might
> be useful to add first class support for fuse2fs to xfstests, with
> arguments ala overlayfs to specify what the fuse driver (such as
> fuse2fs) should be used; what should be used for mkfs, etc.
> 
> Once we do this, we can use a different max blocksize for fuse2fs.
> 
>      	   	    	      		- Ted
> 
> 					
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
