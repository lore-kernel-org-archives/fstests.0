Received: from ipmail01.adl2.internode.on.net ([150.101.137.133]:61521 "EHLO
        ipmail01.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751415AbdJKIAu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Oct 2017 04:00:50 -0400
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1e2Bwd-0005xJ-S6
        for fstests@vger.kernel.org; Wed, 11 Oct 2017 19:00:47 +1100
Date: Wed, 11 Oct 2017 19:00:47 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [whacky issue] xfs/277 endlessly looping in _require_xfs_io_command
Message-ID: <20171011080047.GE15067@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

HI folks,

I was wondering if anyone else had seen this problem, because it's
got me absolutely stumped. One of my test VMs is having a really
weird livelock in xfs/277. It's getting stuck in an endless loop
burning the entire CPU in a the 277 process (i.e. running bash).
What it is stuck on makes no sense to me, nor does the looping
behaviour, and I can only reproduce it on this one machine.

The code in question:

        "fsmap" )
                testio=`$XFS_IO_PROG -f -c "fsmap" $testfile 2>&1`
                echo $testio | grep -q "Inappropriate ioctl" && \
                        _notrun "xfs_io $command support is missing"

Is pretty simple and obvious - not a lot to go wrong. set -x
shows the last command in the output file to be the fsmap command.
$test_io has about 5000 lines of output in it.

I did some testing to isolate the problem. This exits having
executed the fsmap command just fine:


        "fsmap" )
                testio=`$XFS_IO_PROG -f -c "fsmap" $testfile 2>&1`
                exit

But this never exits and it starts burning down teh CPU:

        "fsmap" )
                testio=`$XFS_IO_PROG -f -c "fsmap" $testfile 2>&1`
                echo $testio
                exit

Yeah, echoing the output of the fsmap command seems to cause bash to
enter an endless loop of some kind. Well, it's not endless, because
every 30s or so the process dies and a new child process runs the
same loop again. Attaching strace to one of these processes:

......
open(".", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFDIR|0755, st_size=139264, ...}) = 0
getdents(3, /* 1024 entries */, 32768)  = 32744
getdents(3, /* 1023 entries */, 32768)  = 32752
getdents(3, /* 1023 entries */, 32768)  = 32744
getdents(3, /* 1021 entries */, 32768)  = 32768
getdents(3, /* 1022 entries */, 32768)  = 32744
getdents(3, /* 1022 entries */, 32768)  = 32768
getdents(3, /* 401 entries */, 32768)   = 12840
getdents(3, /* 0 entries */, 32768)     = 0
close(3)                                = 0
open(".", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFDIR|0755, st_size=139264, ...}) = 0
getdents(3, /* 1024 entries */, 32768)  = 32744
getdents(3, /* 1023 entries */, 32768)  = 32752
getdents(3, /* 1023 entries */, 32768)  = 32744
getdents(3, /* 1021 entries */, 32768)  = 32768
getdents(3, /* 1022 entries */, 32768)  = 32744
getdents(3, /* 1022 entries */, 32768)  = 32768
getdents(3, /* 401 entries */, 32768)   = 12840
getdents(3, /* 0 entries */, 32768)     = 0
close(3)                                = 0
open(".", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFDIR|0755, st_size=139264, ...}) = 0
getdents(3, /* 1024 entries */, 32768)  = 32744
getdents(3, /* 1023 entries */, 32768)  = 32752
getdents(3, /* 1023 entries */, 32768)  = 32744
getdents(3, /* 1021 entries */, 32768)  = 32768
getdents(3, /* 1022 entries */, 32768)  = 32744
getdents(3, /* 1022 entries */, 32768)  = 32768
getdents(3, /* 401 entries */, 32768)   = 12840
getdents(3, /* 0 entries */, 32768)     = 0
close(3)                                = 0
.....

bash is running around in a tight loop running readdir() on some
unknown directory over and over again. I can't work it out - this is
the only machine that does it, and it I can't reproduce it outside
of running xfs/277 from xfstests...

I'm outta ideas - I've got no idea what the hell is going wrong
here. Anyone got any ideas?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
