Received: from mail-ua1-f65.google.com ([209.85.222.65]:40644 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbfBHWrF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Feb 2019 17:47:05 -0500
Received: by mail-ua1-f65.google.com with SMTP id n32so210598uae.7
        for <fstests@vger.kernel.org>; Fri, 08 Feb 2019 14:47:04 -0800 (PST)
MIME-Version: 1.0
From: Jayashree Mohan <jayashree2912@gmail.com>
Date: Fri, 8 Feb 2019 16:46:50 -0600
Message-ID: <CA+EzBbDyoPF8=mZyG8HQAoHTm4h4MSCe=5WX_SBqRwPej=4uFg@mail.gmail.com>
Subject: Documenting the crash consistency guarantees of file systems
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Filipe Manana <fdmanana@gmail.com>, Amir Goldstein <amir73il@gmail.com>, Dave Chinner <david@fromorbit.com>, Chris Mason <clm@fb.com>, Vijaychidambaram Velayudhan Pillai <vijay@cs.utexas.edu>
List-ID: <fstests@vger.kernel.org>

Hi all,

We all understand that providing strong crash consistency guarantees
while not impacting performance, can be tricky. While you strive to
achieve that, it is worth documenting the expected/current guarantees
provided by each file system so that users can report buggy behaviors
and stop pursuing potential dead ends.

In the course of developing our crash-consistency testing tool:
CrashMonkey, we've had several interesting discussions with
file-system developers regarding the guarantees provided by
file-system operations. For example, the crash-consistency guarantees
of symlink does not ensure that the symlink-ed file survives a crash,
even if it was persisted explicitly before the crash. This is because,
unlike hard links, symlinks are not regular files and it is not
possible to directly open them to fsync() [1].

Similarly, most file systems today provide guarantees more
than what the POSIX expects; however, these are not formally
documented. For example, in btrfs, fsync() of any file should be
enough to persist that file in its current directory; it does
not require that its parent directory be explicitly persisted [2].
f2fs on the other hand, offers multiple fsync() modes like
FSYNC_MODE_STRICT, FSYNC_MODE_POSIX etc, each with different
guarantees. As a user, we are unaware of these differences in
guarantees each file system has to offer.

More recently, there was a bug report which stated that chmod'ed
permissions on special files were not persisted upon fsync() [3].
While Ted explained that special files don't have a fsync() function
defined, thereby making it a no-op, we believe such information is
crucial and worth documenting.

In this context, how about adding a new file to the Linux kernel
documentation, for example,
linux/Documentation/filesystems/crash-consistency-guarantees.txt,
where developers or users could contribute their knowledge on such
special cases where persistence guarantees are not applicable, or the
extent of crash-guarantees each file system provides? If this sounds
good, we will be happy to send out a patch detailing the information
we gathered about each file-system's guarantees while testing them
with CrashMonkey. This would serve as a one-stop destination for all
information related to crash-consistency guarantees and encourage any
future conversations pertaining to crash consistency to be documented
here.

[1] https://www.spinics.net/lists/linux-btrfs/msg76835.html
[2] https://www.spinics.net/lists/linux-btrfs/msg77340.html
[3] https://bugzilla.kernel.org/show_bug.cgi?id=202485


Thanks,
Jayashree Mohan
