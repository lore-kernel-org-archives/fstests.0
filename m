Received: from imap.thunk.org ([74.207.234.97]:59142 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750969AbeECSfJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 3 May 2018 14:35:09 -0400
Date: Thu, 3 May 2018 14:35:08 -0400
From: "Theodore Y. Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] common: add support for the "local" file system type
Message-ID: <20180503183507.GE29205@thunk.org>
References: <20180503034340.GA20908@thunk.org>
 <CAOQ4uxjEAhDteK7iZF0KLq-oFi+nO9LbUe0F+5eLTOo59=hTLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjEAhDteK7iZF0KLq-oFi+nO9LbUe0F+5eLTOo59=hTLQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, May 03, 2018 at 12:22:42PM +0300, Amir Goldstein wrote:
> 
> This looks like a very useful feature, but I suspect that some bits of the
> patch may be a bit too specific to your use case (see below) - I may be wrong.

The primary characteristic of "local" is there nothing to mount or
unmount.  So for example, it should be possible to use this
Microsoft's Subsystem for Linux.

> The ultimate proof would be to demonstrate the usefulness of the feature
> to more than a single use case - how about FUSE passthrough example?
> Perhaps FSTYP=user would be more descriptive in general to the use
> case at hand, because 'local' is usually the counter of 'remote',
> but I'm fine with FSTYP=local.

It certainly wouldn't be problem to demo using the local file system
type for FUSE --- but it would not be _ideal_ for fuse, since fuse has
the concept of mounting and unmounting.

> > +{
> > +    case "$*" in
> > +       ro|ro,*|*,ro) _notrun "ro mount option not supported" ;;
> > +       *nosuid*) _notrun "nosuid mount option not supported" ;;
> > +       *noatime*) _notrun "noatime mount option not supported" ;;
> > +       *relatime*) _notrun "relatime mount option not supported" ;;
> > +       *diratime*) _notrun "diratime mount option not supported" ;;
> > +       *strictatime*) _notrun "strictatime mount option not supported" ;;
> > +    esac
> > +}
> 
> Why specifically these mount options? Is this really generic?

The local file system type does not support mount, umount, or remount
command.  So there is no way to modulate noatime, relatime, etc.  So
this would be useful if someone wanted to test Windows System for
Linux, for example.

> > +
> >  # mount scratch device with given options but don't check mount status
> >  _try_scratch_mount()
> >  {
> > @@ -376,6 +388,9 @@ _scratch_unmount()
> >         btrfs)
> >                 $UMOUNT_PROG $SCRATCH_MNT
> >                 ;;
> > +       local)
> > +                rm -rf $SCRATCH_MNT/*
> > +                ;;
> 
> _scratch_mkfs already does that. Why does it make sense in _scratch_unmount?

Just for cleanup purposes.

> > @@ -386,6 +401,10 @@ _scratch_remount()
> >  {
> >      local opts="$1"
> >
> > +    if [ "$FSTYP" = "local" ]; then
> > +       _local_validate_mount_opt "$*"
> > +       return 0;
> > +    fi
> 
> It makes more sense to me to _require_scratch_remount
> for tests that need to remount in the beginning of tests - yeh
> that's a bit more work.

There are some tests where the remount operation is just to reset the
file system.  So the test is just to unmount and remount the file
system, and making sure the file status are the same.  So I didn't
want to block all remounts; instead, to let some remounts be no-op's
so the rest of the test could still be used to provide test coverage,
and only block those remounts which were modulating things like ro/rw,
noatime, etc.

> > @@ -395,7 +414,7 @@ _scratch_cycle_mount()
> >  {
> >      local opts="$1"
> >
> > -    if [ "$FSTYP" = tmpfs ]; then
> > +    if [ "$FSTYP" = "tmpfs" -o "$FSTYP" = "local" ] ; then
> >         _scratch_remount "$opts"
> 
> That seems like cheating - seems better to implement
> and use _require_scratch_cycle_mount

Again, I didn't want to end up skipping a huge number of tests.  I
didn't consider this "cheating"; I considered it a case of "let's
maximize test coverage".

> > +    if [ "$FSTYP" == "local" ]; then
> > +        mkdir -p $TEST_DIR
> > +       return $?
> > +    fi
> 
> What is the desired logic here? can you add a comment?
> Seems to me that we need to verify there is something mounted
> at $TEST_DIR. no?

Again -- the big thing about the "local" file system is there is no
way to mount, umount, or remount.  So no block device, no mount point,
nothing to shutdown, etc.

The mkdir -p isn't strictly necessary here.  It could be done by the
kvm-xfstests or whatever is running the xfstests.  It was more of a
safety thing, but if people don't like it, we can drop it.

> > @@ -1465,6 +1488,10 @@ _check_mounted_on()
> >         local mnt=$4
> >         local type=$5
> >
> > +       if [ "$FSTYP" == "local" ]; then
> > +               return 0
> > +       fi
> > +
> 
> Shouldn't we check that "something" is mounted on $mnt?

Nope.  See above.  "local" means never having to say you need to mount
something.

> > @@ -3003,6 +3058,9 @@ _require_fio()
> >  # Does freeze work on this fs?
> >  _require_freeze()
> >  {
> > +       if [ "$FSTYP" == "local" ]; then
> > +               _notrun "local does not support freeze"
> 
> When users read this warning they may be confused,
> same for shutdown/dax/morecovery.
> Something like "user defined fs does not support freeze"

I think you have a very different idea of what "local" means.  The
basic model was that this is something where the file system is
provided for use by the docker infrastructure (or by Windows 10 in the
WSL case), and so the docker job can't actually mount or unmount the
file system.  However, it is still desirable to check to see how POSIX
compliant the underlying file system might be, and it can also be used
to exercise the underlying file system.

I'm not tied to the name "local", but for me what it means is "the
local file system".  If people want to nominate a different name, I'm
certainly open to suggestions.

					- Ted

