Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:17348 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbfCEAuY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 4 Mar 2019 19:50:24 -0500
Date: Tue, 5 Mar 2019 11:50:20 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic: add test for fsync after shrinking truncate and
 rename
Message-ID: <20190305005020.GA26298@dastard>
References: <20190304140622.23997-1-fdmanana@kernel.org>
 <CAOQ4uxi87QhQHake0L_xVtUYChc3D2kLqho1obq14aG6zCMu6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi87QhQHake0L_xVtUYChc3D2kLqho1obq14aG6zCMu6A@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fdmanana@kernel.org, fstests <fstests@vger.kernel.org>, Linux Btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 04, 2019 at 05:04:23PM +0200, Amir Goldstein wrote:
> On Mon, Mar 4, 2019 at 4:44 PM <fdmanana@kernel.org> wrote:
> >
> > From: Filipe Manana <fdmanana@suse.com>
> >
> > Test that if we truncate a file to reduce its size, rename it and then
> > fsync it, after a power failure the file has a correct size and name.
> >
> 
> I am not sure that ext4/xfs semantics guaranty anything about
> persisting file name after fsync of file?...

They do.  It's that pesky "strictly ordered metadata" thing I keep
having to explain to people...

i.e. if you fsync an inode, then you are persisting all the changes
needed to reference that file and it's data. And so if there was a
rename in the history of that file, then that is persisted, too.
Which means that both the original and the new directory
modifications are persisted, too.

*POSIX* doesn't require this - it says that if you O_DSYNC data,
then it also includes all the metadata needed to reference that
data. So even if the data is there, POSIX doesn't define whether the
rename is there or noti, just that you can get to the fsync'd data
via either the old or new name. IOWs, POSIX allows the behaviour to
be implementation specific.

In this case, file systems with strictly ordered metadata will end
up making the rename visible because the rename occurred before the
truncate that the fsync() is persisting...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
