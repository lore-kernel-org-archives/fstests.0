Received: from sandeen.net ([63.231.237.45]:48832 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752029AbcI2Nhe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 29 Sep 2016 09:37:34 -0400
Subject: Re: [PATCH] common: add support for the "local" file system type
References: <20160923200526.29674-1-tytso@mit.edu>
 <20160926221814.GC2532@dastard> <20160928235713.tt76og3lxuvozrpi@thunk.org>
 <20160929021628.GI9806@dastard> <20160929035636.g2776ggv2cundlrh@thunk.org>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <97c94e4e-c76c-b93f-022c-57f625e20f5d@sandeen.net>
Date: Thu, 29 Sep 2016 08:37:31 -0500
MIME-Version: 1.0
In-Reply-To: <20160929035636.g2776ggv2cundlrh@thunk.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>, Dave Chinner <david@fromorbit.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 9/28/16 10:56 PM, Theodore Ts'o wrote:
>> xfstests is not designed for validating system call API compliance -
>> > it's for exercising /filesystem implementations/.  xfstests assumes
>> > the syscall API is valid and working, and tries to break the
>> > underlying storage implementation.

To play devil's advocate, I think there are a few tests that find problems
pretty high up the callchain, possibly in the vfs or syscall layer...

>>  As such, your example really
>> > isn't something you should be using xfstests for - it doesn't test
>> > anything like what is needed to verify that the "VFS emulation" is
>> > valid and complete and working exactly as documented in the linux
>> > man pages.
> Who says there isn't an underlying file system implementation which we
> want to test?  In fact we *are* using the right tool for the job.
> (I'm quite aware of the other testing tools that might be available
> including LTP and others, such as the LSB tests.)

So you want to test a filesystem without being able to mount/unmount...
Is this because you want to test how things behave in a restricted
privs environment of some sort, or because the system under test has
absolutely no way to mount & unmount a filesystem for any user?

So many of the current tests expect to check fs consistency, check
data integrity after a shutdown or remount, test recovery, examine
on-disk structures of a quiesced, consistent block device, test mount
options, etc, I fear that there will be so many special snowflakes scattered
around individual tests that this might be very hard to maintain.

-Eric

