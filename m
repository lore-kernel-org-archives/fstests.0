Received: from mail.kernel.org ([198.145.29.99]:39636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726250AbfCEJ0V (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 5 Mar 2019 04:26:21 -0500
MIME-Version: 1.0
References: <20190304140622.23997-1-fdmanana@kernel.org> <CAOQ4uxi87QhQHake0L_xVtUYChc3D2kLqho1obq14aG6zCMu6A@mail.gmail.com>
 <CAL3q7H6ceptNOyf65jbzojbZV5Nq3d0iKvYOvvE=pLaVnpgO2w@mail.gmail.com>
 <CAOQ4uxhno=ORXpLgLC2O7KoJJXm2sVEtZ8DgiHZi-4p_HmfEwg@mail.gmail.com>
 <CAL3q7H6XDTkp+wHmM9+ON+smcqk6fR5fL3Bf1OmVFE06BRnEjw@mail.gmail.com> <CAOQ4uxg_D0r2L=6zg4yxN1AfzkK8aHkWwOQPKEaKt8Z7WtVf2w@mail.gmail.com>
In-Reply-To: <CAOQ4uxg_D0r2L=6zg4yxN1AfzkK8aHkWwOQPKEaKt8Z7WtVf2w@mail.gmail.com>
From: Filipe Manana <fdmanana@kernel.org>
Date: Tue, 5 Mar 2019 09:26:08 +0000
Message-ID: <CAL3q7H7F8tuczjCXCUOewuJu3CKLq+MgYv-B2mbLA8qep7+xyA@mail.gmail.com>
Subject: Re: [PATCH] generic: add test for fsync after shrinking truncate and rename
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>, Linux Btrfs <linux-btrfs@vger.kernel.org>, Filipe Manana <fdmanana@suse.com>, Dave Chinner <david@fromorbit.com>
List-ID: <fstests@vger.kernel.org>

On Tue, Mar 5, 2019 at 5:59 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Tue, Mar 5, 2019 at 12:31 AM Filipe Manana <fdmanana@kernel.org> wrote:
> >
> > On Mon, Mar 4, 2019 at 5:59 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Mon, Mar 4, 2019 at 5:23 PM Filipe Manana <fdmanana@kernel.org> wrote:
> > > >
> > > > On Mon, Mar 4, 2019 at 3:04 PM Amir Goldstein <amir73il@gmail.com> wrote:
> > > > >
> > > > > On Mon, Mar 4, 2019 at 4:44 PM <fdmanana@kernel.org> wrote:
> > > > > >
> > > > > > From: Filipe Manana <fdmanana@suse.com>
> > > > > >
> > > > > > Test that if we truncate a file to reduce its size, rename it and then
> > > > > > fsync it, after a power failure the file has a correct size and name.
> > > > > >
> > > > >
> > > > > I am not sure that ext4/xfs semantics guaranty anything about
> > > > > persisting file name after fsync of file?...
> > > > >
> > > > > > This test is motivated by a bug found in btrfs, which is fixed by a
> > > > > > patch for the linux kernel titled:
> > > > > >
> > > > > >   "Btrfs: fix incorrect file size after shrinking truncate and fsync"
> > > > >
> > > > > At least the title of this patch says nothing about persisting the
> > > > > name.
> > > >
> > > > Because the bug in btrfs is not about persisting the name, it's about
> > > > persisting the correct inode size.
> > > >
> > >
> > > OK. Still AFAIK, ext4/xfs don't guaranty that the name bar will exist
> > > after power failure unless the parent dir was fsynced.
> > > If you fsync the parent dir instead of the file after rename, it will
> > > make the test correct for ext4/xfs (and POSIX for that matter).
> >
> > I'm not so sure about that. Couldn't find anything explicit anywhere about that.
>
> man fsync(2):
> "       Calling  fsync() does not necessarily ensure that the entry in
> the directory
>         containing the file has also reached disk.  For that an
> explicit fsync() on a file
>         descriptor for the directory is also needed."
>
> > There are other tests that do similar assumptions, either after
> > renames or after adding a new
> > hard link (fsyncing just the file being enough to guarantee the new
> > hard link exits after a power
> > failure, without the need to fsync the parent directory). I don't
> > recall ever having had such comment before,
>
> Because I missed it in review...
>
> > even for much more complex cases involving renames
> > such as [1] for example.
> >
> > [1] https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/?id=e2d866668a98af4cd47cd6913418e410cd80aa93
> >
> > In this case both old and new names are in the same parent directory,
> > but if they were in different directories, and
> > requiring the user/application to fsync both directories, it could be
> > dangerous, if the old parent dir is fsync'ed and
> > a power failure happened before fsync'ing the new parent (requiring
> > the user/application to know about this
> > and fsync the new parent before the old parent dir also seems very
> > demanding), leading to a potential file loss
> > after replaying the log/journal (there were such cases in btrfs before).
> >
>
> This is not a problem for ext4/xfs.
> fsync(newdir) guarantees persisting new filename
> metadata ordering implies that olddir changes (and file nlink)
> also persist.
>
> To meet requirement of both btrfs and ext4/xfs in that case
> your test may fsync both file AND newdir, as long as this
> still allows your test to catch the bug?
>
> > > Will that test modification still catch the btrfs bug (pre fix)?
> >
> > Yes, it will still trigger the btrfs bug.
> >
> > Well, I don't mind doing such change, but I would like to hear other
> > opinions too, perhaps Dave could shed some light on this?
> > Even old reiserfs and f2fs (both on posix and strict fsync modes)
> > currently pass this test.
> >
>
> As I wrote to Dave, if file is not "metadata dirty" before rename,
> then whether or not rename dirties to file for fsync is a filesystem
> specific implementation detail that is not in any standard.
>
> Since filesystems tend to try to optimize out unneeded journal
> commits, so the observation about what filesystems do today
> empirically is not a sufficiently strong argument.

Even if the strictly ordered metadata guarantees Dave explained so
many time before is not formally defined anywhere,
I think it's a behavior that shouldn't change, as not only it makes
sense, but applications might be relying on it and therefore
useful to make sure no regressions happen. If such tests should be
shared (and run only filesystems known to support
the strictly ordered metadata) or require something special, is
another question.

>
> Again, if your test can afford to do fsync of file and parent dir
> it is best to be on the safe side (please audit other similar tests
> that you know about). If your test cannot afford to fsync parent
> dir, then at least a fat comment about this issue is worth about
> the expected (but not guaranteed) effects of fsync of file.

I'm sending a v2 with the fsync against the parent directory, despite
not being needed for any fs I could
run the tests against, because it's a generic test.

Thanks.

>
> Thanks,
> Amir.
