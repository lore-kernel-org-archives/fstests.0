Received: from mail-yw1-f66.google.com ([209.85.161.66]:40990 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfCGHwR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 7 Mar 2019 02:52:17 -0500
MIME-Version: 1.0
References: <20190304140622.23997-1-fdmanana@kernel.org> <CAOQ4uxi87QhQHake0L_xVtUYChc3D2kLqho1obq14aG6zCMu6A@mail.gmail.com>
 <20190305005020.GA26298@dastard> <CAOQ4uxgKj8pAKKra9jv+xTb9dOxG-J5fKvJ_6a_iabWR9RbgrQ@mail.gmail.com>
 <20190305223301.GD26298@dastard> <CAOQ4uxggon==2r2hibMvXc4_N4zod+2z0Ycw74eKRn+q1uwYsw@mail.gmail.com>
 <20190306214813.GE26298@dastard>
In-Reply-To: <20190306214813.GE26298@dastard>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 7 Mar 2019 09:52:03 +0200
Message-ID: <CAOQ4uxjM0-D8c3KR0ooXYhhUa5+19j_=3XUaXf6vGMbsNhShJw@mail.gmail.com>
Subject: Re: [PATCH] generic: add test for fsync after shrinking truncate and rename
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Filipe Manana <fdmanana@kernel.org>, fstests <fstests@vger.kernel.org>, Linux Btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 6, 2019 at 11:48 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Wed, Mar 06, 2019 at 09:51:23AM +0200, Amir Goldstein wrote:
> > On Wed, Mar 6, 2019 at 12:33 AM Dave Chinner <david@fromorbit.com> wrote:
> > > > So the reason this is working is because 2nd fsync needs to
> > > > persist ctime of B and not because it needs to persist the
> > > > truncate.
> > >
> > > ctime modifications during rename are irrelevent because there's no
> > > fsync between the truncate and the rename so the file inode is
> > > already dirty due to the truncate. I think you've got the wrong end
> > > of the stick here, Amir. :)
> >
> > Doh! The discussion is still interesting because people have
> > hard time to understand that those hidden details like ctime
> > update on rename may have different behavior on different fs
> > regardless if they obay ordered metadata or not.
> > Btrfs is different in the respect of metadata dependencies from
> > xfs/ext4 in many ways as seen in the different rename/link
> > crash consistency discussions.
>
> Yes, little things like can result in different behaviour, but what
> we are trying to do is get to the point where there is minimal
> difference between all crash-recovery-capable linux filesystems.
>
> e.g. what we see here is that by always including the inode being
> moved in the rename transaction (regardless of how a filesystem
> acheives that), we provide consistent, reliable, predictable
> behaviour in all cases of "fsync after rename". IOWs, the SOMC model
> that _require_metadata_journaling tests are supposed to conform to
> is far more strict that POSIX requires and our tests need to reflect
> this stricter consistency model.
>
> IOWs, we should be encoding the behaviour we want in these tests
> rather than implementing yet another "test POSIX compatible
> behaviour" - POSIX is a complete crapshoot when it comes to
> persistence requirements. And if a filesystem fails a SOMC-model
> test, then the filesystem needs to be fixed, not have the test
> "relaxed" to only exercise POSIX-defined behaviour.
>

Agreed! v1 is better than v2. Sorry for my mistake in v1 review.

I went back to look at similar fsync tests by Filipe:
generic/{106,107,335,336,341,342,343,348,498,501,502,509,510,512}

I found some alleged subtle mistakes about SOMC assumptions.

generic/336 does:
touch $SCRATCH_MNT/a/foo
ln $SCRATCH_MNT/a/foo $SCRATCH_MNT/b/foo_link
touch $SCRATCH_MNT/b/bar
sync
unlink $SCRATCH_MNT/b/foo_link
mv $SCRATCH_MNT/b/bar $SCRATCH_MNT/c/
$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/a/foo

And expects both unlink and rename to persist.
However, this is only true in the *very likely* case that there is no
journal commit in between unlink and rename, because fsync foo
is only guaranteed to persist metadata changes that depend on the
unlink and happened BEFORE it, which is not the case for the rename
of bar.

generic/343 and generic/510 do something similar.

At first glance, generic/498 is actually broken (for xfs) or at least
I don't understand why it works.

Thanks,
Amir.
