Received: from mail-yw1-f68.google.com ([209.85.161.68]:41234 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfCFHvf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Mar 2019 02:51:35 -0500
MIME-Version: 1.0
References: <20190304140622.23997-1-fdmanana@kernel.org> <CAOQ4uxi87QhQHake0L_xVtUYChc3D2kLqho1obq14aG6zCMu6A@mail.gmail.com>
 <20190305005020.GA26298@dastard> <CAOQ4uxgKj8pAKKra9jv+xTb9dOxG-J5fKvJ_6a_iabWR9RbgrQ@mail.gmail.com>
 <20190305223301.GD26298@dastard>
In-Reply-To: <20190305223301.GD26298@dastard>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 6 Mar 2019 09:51:23 +0200
Message-ID: <CAOQ4uxggon==2r2hibMvXc4_N4zod+2z0Ycw74eKRn+q1uwYsw@mail.gmail.com>
Subject: Re: [PATCH] generic: add test for fsync after shrinking truncate and rename
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Filipe Manana <fdmanana@kernel.org>, fstests <fstests@vger.kernel.org>, Linux Btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Mar 6, 2019 at 12:33 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Tue, Mar 05, 2019 at 07:39:28AM +0200, Amir Goldstein wrote:
> > On Tue, Mar 5, 2019 at 2:50 AM Dave Chinner <david@fromorbit.com> wrote:
> > >
> > > On Mon, Mar 04, 2019 at 05:04:23PM +0200, Amir Goldstein wrote:
> > > > On Mon, Mar 4, 2019 at 4:44 PM <fdmanana@kernel.org> wrote:
> > > > >
> > > > > From: Filipe Manana <fdmanana@suse.com>
> > > > >
> > > > > Test that if we truncate a file to reduce its size, rename it and then
> > > > > fsync it, after a power failure the file has a correct size and name.
>
> This says:
>
> - ftruncate A
> - rename A B
> - fsync B
>
> > > > I am not sure that ext4/xfs semantics guaranty anything about
> > > > persisting file name after fsync of file?...
> > >
> > > They do.  It's that pesky "strictly ordered metadata" thing I keep
> > > having to explain to people...
> > >
> > > i.e. if you fsync an inode, then you are persisting all the changes
> > > needed to reference that file and it's data. And so if there was a
> > > rename in the history of that file, then that is persisted, too.
> > > Which means that both the original and the new directory
> > > modifications are persisted, too.
> > >
> > > *POSIX* doesn't require this - it says that if you O_DSYNC data,
> > > then it also includes all the metadata needed to reference that
> > > data. So even if the data is there, POSIX doesn't define whether the
> > > rename is there or noti, just that you can get to the fsync'd data
> > > via either the old or new name. IOWs, POSIX allows the behaviour to
> > > be implementation specific.
> > >
> > > In this case, file systems with strictly ordered metadata will end
> > > up making the rename visible because the rename occurred before the
> > > truncate that the fsync() is persisting...
> > >
> >
> > That is not what is happening in Filipe's test. Test has:
> > - ftruncate A
> > - fsync A
> > - rename A B
> > - fsync B
>
> And this does not match the test description.
>
> /me goes and looks at the test again to check.
>
> Ok, the test is as Filipe describes:
>
> - pwrite 0 0x8000 A
> - fsync A
> - truncate 3000 A
> - rename A B
> - fsync B
>
> There is no fsync between truncate and rename.
>
> > So the reason this is working is because 2nd fsync needs to
> > persist ctime of B and not because it needs to persist the
> > truncate.
>
> ctime modifications during rename are irrelevent because there's no
> fsync between the truncate and the rename so the file inode is
> already dirty due to the truncate. I think you've got the wrong end
> of the stick here, Amir. :)
>

Doh! The discussion is still interesting because people have
hard time to understand that those hidden details like ctime
update on rename may have different behavior on different fs
regardless if they obay ordered metadata or not.
Btrfs is different in the respect of metadata dependencies from
xfs/ext4 in many ways as seen in the different rename/link
crash consistency discussions.

Thanks,
Amir.
