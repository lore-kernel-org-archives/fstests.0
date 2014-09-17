Return-Path: <david@fromorbit.com>
Date: Wed, 17 Sep 2014 14:51:57 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 4/5] generic: add mmap write vs truncate/remap test
Message-ID: <20140917045157.GI4267@dastard>
References: <1410918113-23516-1-git-send-email-david@fromorbit.com>
 <1410918113-23516-5-git-send-email-david@fromorbit.com>
 <54190ECB.2070900@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54190ECB.2070900@sandeen.net>
To: Eric Sandeen <sandeen@sandeen.net>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 16, 2014 at 11:32:11PM -0500, Eric Sandeen wrote:
> On 9/16/14 8:41 PM, Dave Chinner wrote:
> > This test exposed a problem with mapped writes to the tail page of a
> > file in XFS and potentially ext4. Eric did all the hard work of
> > taking the bug report and generating the reproducable test case
> > on ext4, but I haven't been able to reproduce then problem on ext4.
> 
> Hm, not even w/ the last test case below, on the byte boundaries?

Sorry, I forgot to rewrite that once I got the byte boundary test
from you. It does, indeed, fail on ext4 as does the previous
mmap/truncate test:

$ sudo MKFS_OPTIONS="-b 1024" ./check generic/029 generic/03[01]
FSTYP         -- ext4
PLATFORM      -- Linux/x86_64 test4 3.17.0-rc4-dgc+
MKFS_OPTIONS  -- -b 1024 /dev/ram1
MOUNT_OPTIONS -- -o acl,user_xattr /dev/ram1 /mnt/scr

generic/029 2s ... - output mismatch (see /home/dave/src/xfstests-dev/results//generic/029.out.bad)
    --- tests/generic/029.out   2014-09-17 10:33:15.000000000 +1000
    +++ /home/dave/src/xfstests-dev/results//generic/029.out.bad        2014-09-17 14:50:02.000000000 +1000
    @@ -10,7 +10,9 @@
     ==== Post-Remount ==
     00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
     *
    -00000800  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
    +00000800  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
    +*
    +00001000  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
    ...
    (Run 'diff -u tests/generic/029.out /home/dave/src/xfstests-dev/results//generic/029.out.bad'  to see the entire diff)
generic/030 1s ... - output mismatch (see /home/dave/src/xfstests-dev/results//generic/030.out.bad)
    --- tests/generic/030.out   2014-09-17 11:13:55.000000000 +1000
    +++ /home/dave/src/xfstests-dev/results//generic/030.out.bad        2014-09-17 14:50:03.000000000 +1000
    @@ -10,7 +10,7 @@
     ==== Post-Remount ==
     00000000  58 58 58 58 58 58 58 58  58 58 58 58 58 58 58 58  |XXXXXXXXXXXXXXXX|
     *
    -004e6400  59 59 59 59 59 59 59 59  59 59 59 59 59 59 59 59  |YYYYYYYYYYYYYYYY|
    +004e6400  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
     *
     004e7000
    ...
    (Run 'diff -u tests/generic/030.out /home/dave/src/xfstests-dev/results//generic/030.out.bad'  to see the entire diff)
generic/031 2s ... 2s
Ran: generic/029 generic/030 generic/031
Failures: generic/029 generic/030
Failed 2 of 3 tests


> FWIW, I think I can simplify that one - the repeated ops aren't
> necessary.  Probably no need to carry that along if they aren't
> relevant to the bug.
> 
> I'll look at this more closely tomorrow, thanks for encapsulating
> this in an xfstest.

Can you send any updates as delta patches to this one?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
