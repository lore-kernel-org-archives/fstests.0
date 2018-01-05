Date: Thu, 4 Jan 2018 22:28:43 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] generic/466: be more precise about which block sizes to
 use
Message-ID: <20180105032843.GA32314@thunk.org>
References: <20171211172742.3490-1-tytso@mit.edu>
 <20171213173629.GG6896@magnolia>
 <20171231184508.GA29994@thunk.org>
 <20180102203650.GC5146@magnolia>
 <20180105021227.GA5606@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180105021227.GA5606@magnolia>
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

> > That depends on whether this function returns the smallest blocksize
> > guaranteed to pass mkfs given the current set of options or the
> > theoretical smallest blocksize supported by that fs given the right set
> > of options.  IOWs, if this is a v5 fs being tested, then "mkfs.xfs -b
> > size=$(_fs_min_blocksize) -m crc=1" will fail.

Some of the discussion that we had on our weekly ext4 developer's
conference call.  One of the motivations for this patch is due to a
local change that I have in my xfstests tree, which adds:

	|| _die "${MKFS_PROG}.$FSTYP failed!"

to the ${MKFS_PROG}.$FSTYP call in _scratch_mkfs_sized and similar
functions.  The reason for that is there a number of tests which use
additional file system options, different block sizes, unusually small
file system sizes, etc. --- and 99.97% of them don't bother to do any
error checking.

So what ends up happening is the test will not notice that the mkfs
had failed, and would continue staggering on, sometimes succeeding,
and sometimes failing --- depending on what test was running
previously and the state of the scratch device.  Ugh.  Hence, my
addition of the "|| die ..."

The problem is that generic/466 is one of the few tests that actually
(a) deliberately feed arguments that cause _scratch_mkfs_sized to
fail, and (b) actually does error checking.

Darrick mentioned on the call that he's seen similar problems which
he's had to track down when testing xfs, and it was simiarly annoying.

So instead of it being a local hack in my xfstests tree, perhaps this
is something we should try to fix more generally.  There a number of I
could imagine going about this.

1) The approach I took in this patch, which is requires accurately
determine min and max blocksizes --- and then to add error checks to
all of the mkfs invocations in _scratch_mkfs_blocksized for all file
systems.

2) Add an argument to _scratch_mkfs_blockized() and similar functions
which indicates that error checking should _not_ be done, since it
will be done by the caller (such as generic/466).  And then add error
checks in _scratch_mkfs_blocksized() and similar functions unless the
optional flag is passed by the test.

3)  Sweep through all of the tests scripts adding error checks.

It seems to me (2) might be the simplest approach, although (1) does
speed up the test somewhat, and so maybe we should do (1) as well as
(2).  Eryu, do you have any thoughts/opinions?

> > I haven't tried it in some time, but the last time I ran xfstests
> > against fuse2fs it more or less worked (modulo all the fancy fallocate
> > stuff that it doesn't support).
> 
> (Maybe we should separate out ext4/fuse2fs?)

Darrick explained this require bind mounting mount.fuse2fs on
mount.ext4, and other unnatural hacks.  It seems to me that it might
be useful to add first class support for fuse2fs to xfstests, with
arguments ala overlayfs to specify what the fuse driver (such as
fuse2fs) should be used; what should be used for mkfs, etc.

Once we do this, we can use a different max blocksize for fuse2fs.

     	   	    	      		- Ted

					
