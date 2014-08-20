Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:6378 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752980AbaHTW5H (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 20 Aug 2014 18:57:07 -0400
Date: Thu, 21 Aug 2014 08:57:01 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [patch, v3] add an aio test which closes the fd before
 destroying the ioctx
Message-ID: <20140820225701.GG26465@dastard>
References: <x49vbrq6r0c.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49vbrq6r0c.fsf@segfault.boston.devel.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jun 24, 2014 at 03:34:27PM -0400, Jeff Moyer wrote:
> 
> By closing the file descriptor before calling io_destroy, you pretty
> much guarantee that the last put on the ioctx will be done in interrupt
> context (during I/O completion).  This behavior has unearthed bugs in
> the kernel in several different kernel versions, so let's add a test to
> poke at it.
> 
> The original test case was provided by Matt Cross.  He has graciously
> relicensed it under the GPL v2 or later so that it can be included in
> xfstests.  I've modified the test a bit so that it would generate a
> stable output format and to run for a fixed amount of time.
> 
> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

Jeff, this test is causing xfstests to fail unmounts with EBUSY
frequently on some of my test VMs (i.e. in >60% of my test runs in
the past week).

$ sudo MKFS_OPTIONS="-m crc=1,finobt=1" ./check generic/323
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 test2 3.16.0-dgc+
MKFS_OPTIONS  -- -f -m crc=1,finobt=1 /dev/vdb
MOUNT_OPTIONS -- /dev/vdb /mnt/scratch

generic/323 121s ... 121s
umount: /mnt/test: device is busy.
        (In some cases useful info about processes that use
         the device is found by lsof(8) or fuser(1))
_check_xfs_filesystem: filesystem on /dev/vda has dirty log (see /home/dave/src/xfstests-dev/results//generic/323.full)
_check_xfs_filesystem: filesystem on /dev/vda is inconsistent (c) (see /home/dave/src/xfstests-dev/results//generic/323.full)
_check_xfs_filesystem: filesystem on /dev/vda is inconsistent (r) (see /home/dave/src/xfstests-dev/results//generic/323.full)
Ran: generic/323
Passed all 1 tests
$ sudo umount /mnt/test
$

i.e. something that the test is doing it leaving the superblock
referenced after all the processes have finished and exited, but an
immediate unmount after the test fails works just fine. So the
situation only persists for a couple of seconds. Adding a "sleep 5"
to the test just before it exits also makes the failure go away.

I have only ever seen this same issue with generic/208 - it's been
doing this randomly for as long as I can remember. That test is also
a aio+dio test and adding the same "sleep 5" makes that test no
longer show the issue.

IOWs, we now have two AIO+DIO tests showing the same symptoms that
no other tests show. This tends to point at AIO not being fully
cleaned up and completely freed by the time the processes
dispatching it have exit()d. This failure generally occurs when
there is other load on the system/disks backing the test VM (e.g.
running xfstests in multiple VMs at the same time) so I suspect it
has to do with IO completion taking a long time.

Can you spend some time trying to reproduce this and getting to the
bottom of whatever is triggering the unmount error?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
