Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:10072 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750928AbdJKKsj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Oct 2017 06:48:39 -0400
Date: Wed, 11 Oct 2017 21:48:37 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [whacky issue] xfs/277 endlessly looping in
 _require_xfs_io_command
Message-ID: <20171011104837.GH15067@dastard>
References: <20171011080047.GE15067@dastard>
 <20171011103937.GE32909@bfoster.bfoster>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171011103937.GE32909@bfoster.bfoster>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Oct 11, 2017 at 06:39:37AM -0400, Brian Foster wrote:
> On Wed, Oct 11, 2017 at 07:00:47PM +1100, Dave Chinner wrote:
> > HI folks,
> > 
> > I was wondering if anyone else had seen this problem, because it's
> > got me absolutely stumped. One of my test VMs is having a really
> > weird livelock in xfs/277. It's getting stuck in an endless loop
> > burning the entire CPU in a the 277 process (i.e. running bash).
> > What it is stuck on makes no sense to me, nor does the looping
> > behaviour, and I can only reproduce it on this one machine.
> > 
> > The code in question:
> > 
> >         "fsmap" )
> >                 testio=`$XFS_IO_PROG -f -c "fsmap" $testfile 2>&1`
> >                 echo $testio | grep -q "Inappropriate ioctl" && \
> >                         _notrun "xfs_io $command support is missing"
> > 
> 
> Oh, so it looks like you're in _require_xfs_io_command(). I was hunting
> around for this code in xfs/277. :P

Oh, sorry, I forgot to paste the function name.

> 
> > Is pretty simple and obvious - not a lot to go wrong. set -x
> > shows the last command in the output file to be the fsmap command.
> > $test_io has about 5000 lines of output in it.
> > 
> > I did some testing to isolate the problem. This exits having
> > executed the fsmap command just fine:
> > 
> > 
> >         "fsmap" )
> >                 testio=`$XFS_IO_PROG -f -c "fsmap" $testfile 2>&1`
> >                 exit
> > 
> > But this never exits and it starts burning down teh CPU:
> > 
> >         "fsmap" )
> >                 testio=`$XFS_IO_PROG -f -c "fsmap" $testfile 2>&1`
> >                 echo $testio
> >                 exit
> > 
> > Yeah, echoing the output of the fsmap command seems to cause bash to
> > enter an endless loop of some kind. Well, it's not endless, because
> > every 30s or so the process dies and a new child process runs the
> > same loop again. Attaching strace to one of these processes:
> > 
> ...
> > 
> > bash is running around in a tight loop running readdir() on some
> > unknown directory over and over again. I can't work it out - this is
> > the only machine that does it, and it I can't reproduce it outside
> > of running xfs/277 from xfstests...
> > 
> > I'm outta ideas - I've got no idea what the hell is going wrong
> > here. Anyone got any ideas?
> > 
> 
> Heh, that sounds pretty strange. Does your test dev have a pre-existing
> $testfile?

Nope, the test file is "$pid.xfs_io". I've got several of them in
$TEST_DIR from killing tests that hung.

> Have you tried to execute the associated code in an
> independent bash script?

Yes. Doesn't fail from the command line, with unique new files or
the files created from _require_xfs_io_command.

> E.g., I'd probably try to do something like
> mount your test dev then run:
> 
> 	XFS_IO_PROG=...
> 	testfile=...
> 
> 	testio=`$XFS_IO_PROG -f -c "fsmap" $testfile 2>&1`
> 	echo $testio
> 
> ... from a separate script using hardcoded values from the xfstests
> environment, and see what happens..?

... and it doesn't fail from a #!/bin/bash script.

I can only reproduce it from running xfs/277, and only on this
machine. That's what's got me stumped.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
