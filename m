Received: from mail-yw1-f68.google.com ([209.85.161.68]:44076 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfCEFjk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 5 Mar 2019 00:39:40 -0500
MIME-Version: 1.0
References: <20190304140622.23997-1-fdmanana@kernel.org> <CAOQ4uxi87QhQHake0L_xVtUYChc3D2kLqho1obq14aG6zCMu6A@mail.gmail.com>
 <20190305005020.GA26298@dastard>
In-Reply-To: <20190305005020.GA26298@dastard>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 5 Mar 2019 07:39:28 +0200
Message-ID: <CAOQ4uxgKj8pAKKra9jv+xTb9dOxG-J5fKvJ_6a_iabWR9RbgrQ@mail.gmail.com>
Subject: Re: [PATCH] generic: add test for fsync after shrinking truncate and rename
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Filipe Manana <fdmanana@kernel.org>, fstests <fstests@vger.kernel.org>, Linux Btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 5, 2019 at 2:50 AM Dave Chinner <david@fromorbit.com> wrote:
>
> On Mon, Mar 04, 2019 at 05:04:23PM +0200, Amir Goldstein wrote:
> > On Mon, Mar 4, 2019 at 4:44 PM <fdmanana@kernel.org> wrote:
> > >
> > > From: Filipe Manana <fdmanana@suse.com>
> > >
> > > Test that if we truncate a file to reduce its size, rename it and then
> > > fsync it, after a power failure the file has a correct size and name.
> > >
> >
> > I am not sure that ext4/xfs semantics guaranty anything about
> > persisting file name after fsync of file?...
>
> They do.  It's that pesky "strictly ordered metadata" thing I keep
> having to explain to people...
>
> i.e. if you fsync an inode, then you are persisting all the changes
> needed to reference that file and it's data. And so if there was a
> rename in the history of that file, then that is persisted, too.
> Which means that both the original and the new directory
> modifications are persisted, too.
>
> *POSIX* doesn't require this - it says that if you O_DSYNC data,
> then it also includes all the metadata needed to reference that
> data. So even if the data is there, POSIX doesn't define whether the
> rename is there or noti, just that you can get to the fsync'd data
> via either the old or new name. IOWs, POSIX allows the behaviour to
> be implementation specific.
>
> In this case, file systems with strictly ordered metadata will end
> up making the rename visible because the rename occurred before the
> truncate that the fsync() is persisting...
>

That is not what is happening in Filipe's test. Test has:
- ftruncate A
- fsync A
- rename A B
- fsync B

So the reason this is working is because 2nd fsync needs to
persist ctime of B and not because it needs to persist the
truncate.

XFS does it, but it doesn't seem like something that any
filesystem is guaranteed to do the same:
        /*
         * We always want to hit the ctime on the source inode.
         *
         * This isn't strictly required by the standards since the source
         * inode isn't really being changed, but old unix file systems did
         * it and some incremental backup programs won't work without it.
         */
        xfs_trans_ichgtime(tp, src_ip, XFS_ICHGTIME_CHG);

So for the purpose of the test itself, which needs to guaranty that
btrfs persists the size, fsync of parent would be more robust for
any filesystem.

Thanks,
Amir.
