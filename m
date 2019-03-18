Received: from mail-yw1-f65.google.com ([209.85.161.65]:45830 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725918AbfCRFq2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 18 Mar 2019 01:46:28 -0400
MIME-Version: 1.0
References: <1552418820-18102-1-git-send-email-jaya@cs.utexas.edu>
 <20190314011925.GG23020@dastard> <CAOQ4uxjNDKjjzzcowy6oFZ=V7hWCkCbSyOQggE2XJirr4JHAyA@mail.gmail.com>
 <20190318024806.GE23356@mit.edu>
In-Reply-To: <20190318024806.GE23356@mit.edu>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 18 Mar 2019 07:46:15 +0200
Message-ID: <CAOQ4uxj8YpYPPdEvAvKPKXO7wdBg6T1O3osd6fSPFKH9j=i2Yg@mail.gmail.com>
Subject: Re: [PATCH v2] Documenting the crash-recovery guarantees of Linux
 file systems
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: Dave Chinner <david@fromorbit.com>, Jayashree <jaya@cs.utexas.edu>, fstests <fstests@vger.kernel.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, linux-doc@vger.kernel.org, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>, chao@kernel.org, Filipe Manana <fdmanana@gmail.com>, Jonathan Corbet <corbet@lwn.net>
List-ID: <fstests@vger.kernel.org>

On Mon, Mar 18, 2019 at 4:48 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Thu, Mar 14, 2019 at 09:19:03AM +0200, Amir Goldstein wrote:
> > > > +ext4
> > > > +-----
> > > > +fsync(file) : Ensures that a newly created file's directory entry is
> > > > +persisted (no need to explicitly persist the parent directory). However,
> > > > +if you create multiple names of the file (hard links), then their directory
> > > > +entries are not guaranteed to persist unless each one of the parent
> > > > +directory entries are persisted [2].
> > >
> > > So you use a specific example to indicate an exception where ext4
> > > needs an explicit parent directory fsync (i.e. hard links to a
> > > single file across multiple directories). That implies ext4 POSIX
> > > SIO compliance is questionable, and it is definitely not SOMC
> > > compliant. Further, it implies that transactional change atomicity
> > > requirements are also violated. i.e. the inode is journalled with a
> > > link count equivalent to all links existing, but not all the dirents
> > > that point to the inode are persisted at the same time.
> > >
> > > So from this example, ext4 is not SOMC compliant.
> >
> > I question the claim made by the document about ext4
> > behavior.
> > I believe Ted's words [2] may have been misinterpreted.
> > Ted, can you comment?
>
> We need to be really careful about claims and specifications.
> Consider the following sequence of events (error checking ignored;
> assume that it's there).
>
>        unlink("foo");  // make sure the file "foo" doesn't exist
>        unlink("bar");  // make sure the file "bar" doesn't exist
>        fd = open("foo", O_CREAT|O_WRONLY);
>        write(fd, "foo bar data", 12);
>        fsync(fd);
>        // if we crash here, the file "foo" will exist, and you will be able
>        // to read 12 bytes, and it will be present
>        link("foo", "bar");
>        fdatasync(fd);
>        // if we crash here, there is no guarantee that the hard link "bar"
>        // will be persisted
>
> I believe this is perfectly compliant with _POSIX_SYNCHRONIZED_IO.
>
> If the last fsyncdata(fd) is replaced with fsync(fd), the link(2) will
> touch the ctime, so in order only to persist the ctime change, as a
> side effect we will also update the directory entry so the existence
> of "bar" will be persisted.
>
> The bottom line, though, is I remain *very* skeptical about people who
> want to document and then tie the hands of file system developers
> about guarantees that go beyond Posix unless we have a very careful
> discussion about what benefit this will provide application
> developers, at least in general.  If application developers start
> depending on behaviors beyond POSIX, it limits the ability of file
> system developers to innovate in order to improve performance.
>

That is understandable. But I believe the ACK Jayashree is looking
for from you has to do with the SOMC guaranty. That has to do with
ordering of metadata operations, which are all journalled by default
in ext4 and has nothing to do with writeback hacks for dodgy apps.

> There may be cases where it's worth it, and there may be cases where
> it's pretty clear that the laws of physics such that certain things
> that go beyond POSIX will always be true.  But before we encourage
> application developers to go beyond POSIX, we really should have this
> conversation first.
>
> For example, ext4 implements a guarantee that goes beyond POSIX, in
> that if you create a file, say, "foo.new", and then you rename that
> file such that it replaces an existing file, say "foo", then after the
> rename system call, we will initiate asynchronous writeback on
> "foo.new".  This is free if the application programmer has alrady
> called fsync on "foo.new".  However, for an sloppy application which
> doesn't bother to call fsync(2), for which Darrick informs me includes
> "rpm", it saves you from lost files if you immediately reboot.
>
> I do this, because there are tons of sloppy application programmers,
> and so they outnumber file system developers.  However, this is not
> documented behavior, nor is it guaranteed by POSIX!  I'm told by
> Darrick that XFS doesn't do this, and he believes the XFS developers
> would refuse to add such hacks, because it accomodates incompetent
> userspace programmers.
>
> Perhaps the right answer is to yell at the application programmers who
> make these mistakes.  After all, the fact that ext4 accomodates
> incompetence could be argued is leading to decreased application
> quality and decreased portability.  But at least back in the O_PONIES
> era, I looked at multiple text editors supplied by both GNOME and KDE,
> and I discovered to my horror they were writing files in an extremely
> unsafe manner.  (Some of them also were simply opening an existing
> file with O_TRUNC, and then rewriting the text file's data, and NOT
> bother calling fsync afterwards; so ext4 also has a hack so for files
> opened with O_TRUNC where an existing file is truncated, on the close,
> we will initiate writeback.  I chose this as being relatively low
> overhead, because no competently implemented text editor should be
> saving files in this way....)
>
> Whether or not ext4 should accomodate application programmers by going
> on POSIX, I believe very strongly that it should *not* be documented,
> since it just encourages the bad application programming practice.
> It's there just as a backstop, and in fact, it's done as an
> asynchronous writeback, not as a data integrity writeback.  So it is
> *not* something people should be relying on.
>
> So before we document behavior that goes beyond POSIX, we should think
> *very* carefully if this is something that we want to be encouraging
> application programmers to rely on this sort of thing.
>

Perhaps it makes sense that if a behavior is already documented or
will be documented in an xfstest with _require_metadata_journaling
then it might as well be documented as well. Perhaps not.

Thanks,
Amir.
