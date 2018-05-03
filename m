Received: from mail-yw0-f193.google.com ([209.85.161.193]:33797 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751599AbeECTYm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 3 May 2018 15:24:42 -0400
Received: by mail-yw0-f193.google.com with SMTP id x27-v6so3414377ywj.1
        for <fstests@vger.kernel.org>; Thu, 03 May 2018 12:24:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180503183507.GE29205@thunk.org>
References: <20180503034340.GA20908@thunk.org> <CAOQ4uxjEAhDteK7iZF0KLq-oFi+nO9LbUe0F+5eLTOo59=hTLQ@mail.gmail.com>
 <20180503183507.GE29205@thunk.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 3 May 2018 22:24:40 +0300
Message-ID: <CAOQ4uxiTRcOFBNz685fGAHHVpgFdsigZAKS9uOse0xpg6gSErQ@mail.gmail.com>
Subject: Re: [PATCH] common: add support for the "local" file system type
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: "Theodore Y. Ts'o" <tytso@mit.edu>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, May 3, 2018 at 9:35 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Thu, May 03, 2018 at 12:22:42PM +0300, Amir Goldstein wrote:
>>
>> This looks like a very useful feature, but I suspect that some bits of the
>> patch may be a bit too specific to your use case (see below) - I may be wrong.
>
> The primary characteristic of "local" is there nothing to mount or
> unmount.  So for example, it should be possible to use this
> Microsoft's Subsystem for Linux.
>
>> The ultimate proof would be to demonstrate the usefulness of the feature
>> to more than a single use case - how about FUSE passthrough example?
>> Perhaps FSTYP=user would be more descriptive in general to the use
>> case at hand, because 'local' is usually the counter of 'remote',
>> but I'm fine with FSTYP=local.
>
> It certainly wouldn't be problem to demo using the local file system
> type for FUSE --- but it would not be _ideal_ for fuse, since fuse has
> the concept of mounting and unmounting.
>
>> > +{
>> > +    case "$*" in
>> > +       ro|ro,*|*,ro) _notrun "ro mount option not supported" ;;
>> > +       *nosuid*) _notrun "nosuid mount option not supported" ;;
>> > +       *noatime*) _notrun "noatime mount option not supported" ;;
>> > +       *relatime*) _notrun "relatime mount option not supported" ;;
>> > +       *diratime*) _notrun "diratime mount option not supported" ;;
>> > +       *strictatime*) _notrun "strictatime mount option not supported" ;;
>> > +    esac
>> > +}
>>
>> Why specifically these mount options? Is this really generic?
>
> The local file system type does not support mount, umount, or remount
> command.  So there is no way to modulate noatime, relatime, etc.  So
> this would be useful if someone wanted to test Windows System for
> Linux, for example.
>
>> > +
>> >  # mount scratch device with given options but don't check mount status
>> >  _try_scratch_mount()
>> >  {
>> > @@ -376,6 +388,9 @@ _scratch_unmount()
>> >         btrfs)
>> >                 $UMOUNT_PROG $SCRATCH_MNT
>> >                 ;;
>> > +       local)
>> > +                rm -rf $SCRATCH_MNT/*
>> > +                ;;
>>
>> _scratch_mkfs already does that. Why does it make sense in _scratch_unmount?
>
> Just for cleanup purposes.
>
>> > @@ -386,6 +401,10 @@ _scratch_remount()
>> >  {
>> >      local opts="$1"
>> >
>> > +    if [ "$FSTYP" = "local" ]; then
>> > +       _local_validate_mount_opt "$*"
>> > +       return 0;
>> > +    fi
>>
>> It makes more sense to me to _require_scratch_remount
>> for tests that need to remount in the beginning of tests - yeh
>> that's a bit more work.
>
> There are some tests where the remount operation is just to reset the
> file system.  So the test is just to unmount and remount the file
> system, and making sure the file status are the same.  So I didn't
> want to block all remounts; instead, to let some remounts be no-op's
> so the rest of the test could still be used to provide test coverage,
> and only block those remounts which were modulating things like ro/rw,
> noatime, etc.
>
>> > @@ -395,7 +414,7 @@ _scratch_cycle_mount()
>> >  {
>> >      local opts="$1"
>> >
>> > -    if [ "$FSTYP" = tmpfs ]; then
>> > +    if [ "$FSTYP" = "tmpfs" -o "$FSTYP" = "local" ] ; then
>> >         _scratch_remount "$opts"
>>
>> That seems like cheating - seems better to implement
>> and use _require_scratch_cycle_mount
>
> Again, I didn't want to end up skipping a huge number of tests.  I
> didn't consider this "cheating"; I considered it a case of "let's
> maximize test coverage".
>

OK. I've used _scratch_cycle_mount as well in exportfs tests
to make sure caches are evicted, so perhaps the "not cheating"
edition of _scratch_cycle_mount for local should at least drop
caches?

Thanks,
Amir.
