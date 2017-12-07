Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:14863 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751043AbdLGX7Z (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Dec 2017 18:59:25 -0500
Date: Fri, 8 Dec 2017 10:59:22 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: False lockdep completion splats with loop device
Message-ID: <20171207235922.GJ5858@dastard>
References: <20171205030352.6xdopj7cpy5zlwzv@thunk.org>
 <de4d8fd6-48a2-60b6-bab4-d2006e48d828@lge.com>
 <20171205150741.xsbp4mtilqfrsukl@thunk.org>
 <20171205210956.GZ5858@dastard>
 <b0efd17c-eb56-36bf-5be0-06e5bba23c06@lge.com>
 <CAOQ4uxgCREdY5B4TyujM6zi=E7kwcKWpAqJeLaRuLKZBN6=FWQ@mail.gmail.com>
 <da627345-1356-d0b0-b552-de7e288712f9@lge.com>
 <CAOQ4uxg8+P1r_z_9DGYCJivBY5EPpVNnDRKxqPoph_J41JrOmQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg8+P1r_z_9DGYCJivBY5EPpVNnDRKxqPoph_J41JrOmQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Byungchul Park <byungchul.park@lge.com>, Theodore Ts'o <tytso@mit.edu>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, mingo@redhat.com, kernel-team@lge.com
List-ID: <fstests@vger.kernel.org>

On Thu, Dec 07, 2017 at 04:46:52AM +0200, Amir Goldstein wrote:
> >> For the second order of resolution it may be desired to assign a different
> >> key/class to an instance of loop devices and other stackable block devices
> >> (e.g. dm, nbd)  to cover the case of a deeper nested blockdev stack,
> >> such as: ext4 over loop inside ext4 over loop inside ext4 over real disk.
> >
> >
> > This is what I should do.
> >
> 
> But that won't help Ted. The test use case doesn't include doubly nested loop,
> very few setups will do that. Maybe xfstests running within a container over
> loop image. I doubt it that setup is common, so until there are nested container
> implementations out there that are using loop image mount, this use case
> is not very interesting.

xfs/073 nests xfs/loop/xfs/loop/xfs/scratchdev

And I know that people are running with loop devices on XFS as their
test/scratch devices. That gives us filesystems nested 4 layers deep
before we even consider what block device the host filesystem is
sitting on top of.

> The lockdep chain is: ext4/loop -> loop completion -> ext4/real
> but all the internal ext4 locks (i.e. &meta_group_info[i]->alloc_sem) are
> annotated statically for the ext4 fs type, so to fix that need:
> 1. ext4 to know it is mounted over loop/nbd
> 2. ext4 to annotate all internal locks that surround blockdev I/O as
>     "loop nested"/"not loop nested" like overlayfs does with the vfs locks

*cough*

And so every filesystem would need to do this annotation, because
they can all sit above/below a loop device. Essentially you are
suggesting we use superblock-private lockdep class keys rather
than static global maps as we use now.

That's possible, but it could be messy and we'd have to change all
the internal locking setup in every filesystem to do this.

And we'd have to do the same thing for all the block devices that
use completions internally, too because they can also get stacked
above/below other block devices.

> 3. if multi nested looped fs is important (not really) then loop/nbd will
>     need to know if its file is on a looped fs and propagate nesting level
>     to ext4

This functionality is definitely used and needs to be supported by
the annotations.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
