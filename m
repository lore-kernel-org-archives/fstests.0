Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail06.adl6.internode.on.net ([150.101.137.145]:35394 "EHLO
	ipmail06.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751488AbbEFW4q (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 6 May 2015 18:56:46 -0400
Date: Thu, 7 May 2015 08:56:27 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 4/4] filter: inode size output of mkfs.xfs can change
Message-ID: <20150506225627.GJ21261@dastard>
References: <1430776893-25158-1-git-send-email-david@fromorbit.com>
 <1430776893-25158-5-git-send-email-david@fromorbit.com>
 <20150506071934.GE1187@dhcp-13-216.nay.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150506071934.GE1187@dhcp-13-216.nay.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, May 06, 2015 at 03:19:34PM +0800, Eryu Guan wrote:
> On Tue, May 05, 2015 at 08:01:33AM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > With the change to CRCs by default, the mkfs inode size is defaults
> > to 512 bytes and the minimum block size changes to 1024 bytes. This
> > causes mismatches with golden output that expects the inode size to
> > be 256 bytes, and some tests are tailored around the amount of space
> > inside a 256 byte inode. Fix them with appropriate filtering or mkfs
> > parameters to allow 256 byte inodes to be used.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> >  tests/xfs/073          |  4 ++--
> >  tests/xfs/096          |  6 +++---
> >  tests/xfs/096.external | 12 ++++++------
> >  tests/xfs/096.internal | 12 ++++++------
> >  tests/xfs/187          |  4 ++--
> >  tests/xfs/194          |  4 +++-
> >  tests/xfs/199          |  2 +-
> >  tests/xfs/206          | 10 ++++++----
> >  tests/xfs/206.out      | 12 ++++++------
> >  tests/xfs/259          | 21 ++++++++++++++++++---
> >  tests/xfs/292          |  4 ++--
> >  tests/xfs/292.out      |  2 --
> >  tests/xfs/300          |  3 ++-
> >  13 files changed, 57 insertions(+), 39 deletions(-)
> > 
> > diff --git a/tests/xfs/073 b/tests/xfs/073
> > index 07fc71b..45a3fdf 100755
> > --- a/tests/xfs/073
> > +++ b/tests/xfs/073
> > @@ -136,7 +136,7 @@ _require_loop
> >  
> >  rm -f $seqres.full
> >  
> > -_scratch_mkfs_xfs -dsize=41m,agcount=2 | _filter_mkfs 2>/dev/null
> > +_scratch_mkfs_xfs -m crc=0 -dsize=41m,agcount=2 | _filter_mkfs 2>/dev/null
> 
> Adding "-m crc=0" to mkfs directly will break testing on older distros
> where mkfs.xfs doesn't have crc support, e.g. RHEL6

I know we need to keep older distros working, but right now we need
to make upstream xfstests work with upstream xfsprogs changes.  Keep
in mind that we do allow upstream changes for upstream support to
break older distro support. The responsibility for keeping upstream
xfstests working on older distros falls to the people running it on
older distros, not the people who are working on upstream.

Of course, people testing older distros always have the option of
not upgrading xfstests every time a commit is made.... :P

> I haven't figured out a better way, but I was thinking about tweaking
> _scratch_mkfs_xfs or $MKFS_XFS_PROG based on mkfs.xfs supports crc or
> not.

I'd suggest that we should look at filtering this out in
_scratch_options, based on some environment variable that you set in
the .config files for the older distros.  e.g.

	mkfs)
+		if [ -n "$MKFS_HAS_NO_META_SUPPORT" ]; then
+			# strip "-m ..." options
+			SCRATCH_OPTIONS=`<insert sed magic here>`
+		fi

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
