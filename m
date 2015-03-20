Return-Path: <zab@zabbo.net>
Date: Fri, 20 Mar 2015 14:01:52 -0700
From: Zach Brown <zab@zabbo.net>
Subject: Re: [PATCH 1/2] fstests: use mount/umount helpers everywhere
Message-ID: <20150320210152.GB17374@lenny.home.zabbo.net>
References: <550C46B2.8060407@sandeen.net>
 <550C473B.5010004@sandeen.net>
 <20150320185641.GA17374@lenny.home.zabbo.net>
 <550C6DFB.6040506@sandeen.net>
 <550C7C9D.4070108@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <550C7C9D.4070108@sandeen.net>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Mar 20, 2015 at 03:01:33PM -0500, Eric Sandeen wrote:
> On 3/20/15 1:59 PM, Eric Sandeen wrote:
> > On 3/20/15 1:56 PM, Zach Brown wrote:
> >> On Fri, Mar 20, 2015 at 11:13:47AM -0500, Eric Sandeen wrote:
> >>> Replace every explicit mount/umount of scratch or test devices
> >>> with helper functions.  This allows the next patch to add in hooks
> >>> to these functions in order to set up & tear down overlayfs on
> >>> every mount/umount.
> >>
> >> Yeah, I don't know about this.
> >>
> >> For nfs testing we don't setup xfstests to test xfs on block devices and
> >> then then magically configure nfs to export and mount it on the side.
> >>
> >> Wouldn't we treat overlayfs the same way?  It'd be its own fstype whose
> >> underlying resources are fs paths?
> > 
> > Yeah, maybe I need to rethink it.  TBH, I'm not really clear on how
> > nfs gets set up in fstests, but I guess I should look.
> 
> Hrmph, well (talking to the duck, here) - nfs & cifs have no mkfs, no
> fs check, etc.  Overlayfs tests really should, I think.  So it's not
> quite like the net-fs tests.

Neither does overlayfs.  You just know that you happen to be handing
overlayfs paths that are on block devices that can be fscked.  You
certainly could configure an nfs xfstest run to have backing store that
can be quisced and checked with fsck, if that's what you really wanted.

And you might want to test overlayfs on paths that can't be fscked..
like tmpfs for those who don't want persistent exception stores.

It seems pretty straight forward to me that overlayfs is an fs with its
own configuration and behavioural quirks that should be tested.  That's
straight forward when its its own fs type. 

Treating it as an environmental configuration like memory pressure or
flakey IO isn't the right model, particularly because it injects itself
into the interface -- inode numbers and devices in stat dancing around
as upper files are created, that kind of thing.

- z
