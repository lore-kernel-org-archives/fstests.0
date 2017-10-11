Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:32112 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751958AbdJKMUM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Oct 2017 08:20:12 -0400
Received: from dave by dastard with local (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1e2Fzd-0006E9-HK
        for fstests@vger.kernel.org; Wed, 11 Oct 2017 23:20:09 +1100
Date: Wed, 11 Oct 2017 23:20:09 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [whacky issue] xfs/277 endlessly looping in
 _require_xfs_io_command
Message-ID: <20171011122009.GI15067@dastard>
References: <20171011080047.GE15067@dastard>
 <20171011081330.GF15067@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171011081330.GF15067@dastard>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Oct 11, 2017 at 07:13:30PM +1100, Dave Chinner wrote:
> On Wed, Oct 11, 2017 at 07:00:47PM +1100, Dave Chinner wrote:
> > HI folks,
> > 
> > I was wondering if anyone else had seen this problem, because it's
> > got me absolutely stumped. One of my test VMs is having a really
> > weird livelock in xfs/277. It's getting stuck in an endless loop
> > burning the entire CPU in a the 277 process (i.e. running bash).
> > What it is stuck on makes no sense to me, nor does the looping
> > behaviour, and I can only reproduce it on this one machine.
> 
> FWIW, the trigger for this was enabling rmap+reflink on the test
> device on this machine for the first time. Hence this is the first
> time the test has been run on that machine...

TL;DR: this is a result of bugs in the xfstests code. "echo $var"
results in $var being evaluated for glob/regex matches with
files in the current working directory.


Longer: the fsmap
output contains test like [1234..5678] on every line, and there were
5,000 lines of output being generated with about 100k of characters
inside [] brackets. If you run 'echo [1234]', it
does not output '[1234]' to the console - it treats [1234] as a glob
and goes searching the current working directory for matches. That's
where the readdir output comes from.

So:

$ echo foo [1234..5768] bar
foo 1 bar
$ ls -l |grep " 1$"
-rw-r--r-- 1 dave dave         35 Apr 14  2010 1
$

The "1" is output because it matches a file in the local directory.

and if I strace the echo command. I see:

open(".", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 3
fstat(3, {st_mode=S_IFDIR|0755, st_size=28672, ...}) = 0
getdents(3, /* 1109 entries */, 32768)  = 31656
getdents(3, /* 0 entries */, 32768)     = 0
close(3) = 0
write(1, "foo 1 bar\n", 10)             = 10

So, that's where the readdir comes from. Doesn't explain the
slowness, or why it doesn't reproduce in a interactive shell or on
any other machine.


So, look at what directory it is running in ($here, the root of the
xfstests installation) and now add other xfstests bugs that havei
resulted in ~6500 test files being dumped in $here.

(generic/109 is one of the culprits)

Now we have ~100k characters being matched against ~6500 filenames.
There's the slowness.  I simply wasn't patient enough to wait for
it.

One `git clean -f -d` later, and the test now runs and completes in
4s.

So, what's the bug in xfstests? The usual bug in shell programs:i
missing variable quoting.

$ echo foo [1234..5768] bar 
foo 1 bar
$ echo "foo [1234..5768] bar"
foo [1234..5768] bar

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
