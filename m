Received: from imap.thunk.org ([74.207.234.97]:42796 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754637AbcI2BRt (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 28 Sep 2016 21:17:49 -0400
Date: Wed, 28 Sep 2016 19:57:13 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] common: add support for the "local" file system type
Message-ID: <20160928235713.tt76og3lxuvozrpi@thunk.org>
References: <20160923200526.29674-1-tytso@mit.edu>
 <20160926221814.GC2532@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160926221814.GC2532@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 27, 2016 at 08:18:14AM +1000, Dave Chinner wrote:
> 
> Ignoring the code changes for the moment - what's the reason/use
> case for running /kernel/ test suites inside a user container with
> such restricted access to filesystems and devices? Especially
> considering test failures can take the kernel down, which will kill
> /everything/ on the machine, not just the container.
> 
> This doesn't make a whole lot of sense to me - who is going to use
> this and what extra test coverage does it bring to the table
> compared to just running inside a guest VM with full privileges?

So I'm doing this work on behalf of a team who is working on an
to-be-announced project, so the details aren't mine to give.  However,
I can say that obviously, if they could do that they would.

Let me give an other example where this might be useful.  Suppose you
are using the Windows Subsystem for Linux which emulates system calls
for Linux, so you can run most Linux binaries, but for which certain
system calls simply aren't implemented, either for security reasons or
because they just don't make sense (e.g., reboot, kexec, mount,
unmount, etc.).  To the extent that such a subsystem purports to offer
Linux compatibility, and has a Linux VFS emulation, it would be useful
to have a "local" file system type which doesn't try to do any mounts
and unmounts, but which could otherwise stress test the file system
layer and find bugs in the system call emulation for file systems,
that would be a good and useful thing to do.

As I recall, AIX also had a Linux system emulator (the better to run
the huge numbers of commercial third-party Linux binaries :-), and if
I recall correctly, it didn't support mount and unmount either.
NetBSD also has a Linux emulation layer (and in the past, an Irix
emulation layer), and again, it's not clear that it would extend to
things like mount/unmount --- nor would it really need to in order to
be useful for most of their desired use cases.

Cheers,

						- Ted
