Received: from mail-pg0-f67.google.com ([74.125.83.67]:34274 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754019AbdEQSpn (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 17 May 2017 14:45:43 -0400
Received: by mail-pg0-f67.google.com with SMTP id u187so2847901pgb.1
        for <fstests@vger.kernel.org>; Wed, 17 May 2017 11:45:38 -0700 (PDT)
Date: Wed, 17 May 2017 11:45:35 -0700
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH 1/2] Add support for UBIFS
Message-ID: <20170517184535.GB91213@gmail.com>
References: <20170517095531.11818-1-david.oberhollenzer@sigma-star.at>
 <20170517095531.11818-2-david.oberhollenzer@sigma-star.at>
 <20170517115355.GE7250@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170517115355.GE7250@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: David Oberhollenzer <david.oberhollenzer@sigma-star.at>, fstests@vger.kernel.org, linux-mtd@lists.infradead.org, richard@nod.at
List-ID: <fstests@vger.kernel.org>

On Wed, May 17, 2017 at 07:53:55PM +0800, Eryu Guan wrote:
> On Wed, May 17, 2017 at 11:55:29AM +0200, David Oberhollenzer wrote:
> > This patch is mostly based on the previous attempts of Eric Biggers
> > and Dongsheng Yang at adding UBIFS support to xfstests.
> > 
> > In addition to rebasing the previous attempts to recent xfstests,
> > most of the encryption tests now also support UBIFS with this patch.
> > 
> > Since mkfs.ubifs doesn't support creating encryption-capable filesystems
> > yet, _scratch_mkfs_encrypted() is modified to wipe the underlying UBI
> > volume. The filesystem is then created when mounting the emtpy volume.
> > 
> > Some tests that require SCRATCH_DEV to be a block device, despite
> > not using device-mapper or otherwise doing something block device
> > specific have that requirement removed.
> > 
> > Signed-off-by: David Oberhollenzer <david.oberhollenzer@sigma-star.at>
> 
> Thanks for the patch! I know only very little about ubifs (from previous
> reviews to attempts to add ubifs support to fstests), but it's still
> good to have some words to introduce ubifs briefly in commit log,
> especially the fact that it uses char device not block device.
> 
> > ---
> >  check             |  2 ++
> >  common/config     |  7 +++++++
> >  common/encrypt    |  3 +++
> >  common/rc         | 24 ++++++++++++++++++++++++
> >  tests/generic/076 |  1 -
> >  tests/generic/409 |  1 -
> >  tests/generic/410 |  1 -
> >  tests/generic/411 |  1 -
> >  8 files changed, 36 insertions(+), 4 deletions(-)
> > 
> > diff --git a/check b/check
> > index 9cef58b4..f8db3cd6 100755
> > --- a/check
> > +++ b/check
> > @@ -70,6 +70,7 @@ check options
> >      -overlay		test overlay
> >      -pvfs2          test PVFS2
> >      -tmpfs              test TMPFS
> > +    -ubifs              test ubifs
> >      -l			line mode diff
> >      -udiff		show unified diff (default)
> >      -n			show me, do not run tests
> > @@ -267,6 +268,7 @@ while [ $# -gt 0 ]; do
> >  	-overlay)	FSTYP=overlay; export OVERLAY=true ;;
> >  	-pvfs2)		FSTYP=pvfs2 ;;
> >  	-tmpfs)		FSTYP=tmpfs ;;
> > +	-ubifs)		FSTYP=ubifs ;;
> 
> As being pointed out in previous reviews, it'll be great if we can probe
> ubifs from the char device if possible instead of adding new fs-specific
> option, just as what we're doing at the end of common/config for other
> local filesystems. But I'm not sure if blkid works for char device and
> ubifs (probably not).
> 

It seems to work fine without the -ubifs option:

# blkid -o value -s TYPE /dev/ubi0_0
ubifs

# TEST_DEV=/dev/ubi0_0 TEST_DIR=/vdb ./check  generic/001
FSTYP         -- ubifs
PLATFORM      -- Linux/x86_64 kvm-xfstests 4.12.0-rc1-xfstests-00083-ga844e08648f0-dirty

generic/001	[  372.213194] run fstests generic/001 at 2017-05-17 11:43:47
 8s
Ran: generic/001
Passed all 1 tests

- Eric
