Return-Path: <david@fromorbit.com>
Date: Tue, 5 May 2015 15:34:39 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 4/4] filter: inode size output of mkfs.xfs can change
Message-ID: <20150505053439.GL15810@dastard>
References: <1430776893-25158-1-git-send-email-david@fromorbit.com>
 <1430776893-25158-5-git-send-email-david@fromorbit.com>
 <554825A0.5010407@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <554825A0.5010407@sandeen.net>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, May 04, 2015 at 09:06:24PM -0500, Eric Sandeen wrote:
> On 5/4/15 5:01 PM, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > With the change to CRCs by default, the mkfs inode size is defaults
> > to 512 bytes and the minimum block size changes to 1024 bytes. This
> > causes mismatches with golden output that expects the inode size to
> > be 256 bytes, and some tests are tailored around the amount of space
> > inside a 256 byte inode. Fix them with appropriate filtering or mkfs
> > parameters to allow 256 byte inodes to be used.
> 
> I guess I kind of have the same concerns here; lots of magic mkfs
> args w/ no real clue about why they exist.
> 
> The things that filter out isize etc make good sense in general.
> 
> But the new mkfs args could use comments or helpers or something
> that make it a little more obvious why they're used.  What do you
> think?

Well, to my mind it's pretty self documenting - the "-m crc=0"
indicates that the test relies on something that isn't supported on
CRC enabled filesystems...

Regardless, for most of them I added comments or expanded existing
comments to explain it, so I really don't see that there's much else
we need to do here...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
