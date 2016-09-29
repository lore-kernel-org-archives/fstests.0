Received: from ipmail05.adl6.internode.on.net ([150.101.137.143]:56020 "EHLO
        ipmail05.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755214AbcI2CRS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Sep 2016 22:17:18 -0400
Date: Thu, 29 Sep 2016 12:16:29 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] common: add support for the "local" file system type
Message-ID: <20160929021628.GI9806@dastard>
References: <20160923200526.29674-1-tytso@mit.edu>
 <20160926221814.GC2532@dastard>
 <20160928235713.tt76og3lxuvozrpi@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160928235713.tt76og3lxuvozrpi@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 28, 2016 at 07:57:13PM -0400, Theodore Ts'o wrote:
> On Tue, Sep 27, 2016 at 08:18:14AM +1000, Dave Chinner wrote:
> > 
> > Ignoring the code changes for the moment - what's the reason/use
> > case for running /kernel/ test suites inside a user container with
> > such restricted access to filesystems and devices? Especially
> > considering test failures can take the kernel down, which will kill
> > /everything/ on the machine, not just the container.
> > 
> > This doesn't make a whole lot of sense to me - who is going to use
> > this and what extra test coverage does it bring to the table
> > compared to just running inside a guest VM with full privileges?
> 
> So I'm doing this work on behalf of a team who is working on an
> to-be-announced project, so the details aren't mine to give.  However,
> I can say that obviously, if they could do that they would.

So, sooper-s3kr3t internal google stuff that you can't talk about
and may never see the light of day. When it is announced and
released, then let's talk about integration....

> Let me give an other example where this might be useful.  Suppose you
> are using the Windows Subsystem for Linux which emulates system calls
> for Linux, so you can run most Linux binaries, but for which certain
> system calls simply aren't implemented, either for security reasons or
> because they just don't make sense (e.g., reboot, kexec, mount,
> unmount, etc.).  To the extent that such a subsystem purports to offer
> Linux compatibility, and has a Linux VFS emulation, it would be useful
> to have a "local" file system type which doesn't try to do any mounts
> and unmounts, but which could otherwise stress test the file system
> layer and find bugs in the system call emulation for file systems,
> that would be a good and useful thing to do.

xfstests is not designed for validating system call API compliance -
it's for exercising /filesystem implementations/.  xfstests assumes
the syscall API is valid and working, and tries to break the
underlying storage implementation.  As such, your example really
isn't something you should be using xfstests for - it doesn't test
anything like what is needed to verify that the "VFS emulation" is
valid and complete and working exactly as documented in the linux
man pages.

As it is, we have a test harness that is supposed to validate
Linux syscall behaviour exactly as you are describing: LTP.

> As I recall, AIX also had a Linux system emulator (the better to run
> the huge numbers of commercial third-party Linux binaries :-), and if
> I recall correctly, it didn't support mount and unmount either.
> NetBSD also has a Linux emulation layer (and in the past, an Irix
> emulation layer), and again, it's not clear that it would extend to
> things like mount/unmount --- nor would it really need to in order to
> be useful for most of their desired use cases.

xfstests would be implemented on such platforms using the native
mount/unmount commands, just like it is for Irix. Indeed, in this
situation one should be testing the native filesystem implementation
with xfstests, and then using LTP to test the linux emulation layer
behaves as expected.

Use the right tool for the job....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
