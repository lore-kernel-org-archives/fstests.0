Received: from ipmail06.adl2.internode.on.net ([150.101.137.129]:9165 "EHLO
        ipmail06.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1030651AbeEYX0A (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 25 May 2018 19:26:00 -0400
Date: Sat, 26 May 2018 09:25:57 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Widespread test setup template problems (was Re: [PATCH]
 generic: fix cleanup function for test 490)
Message-ID: <20180525232557.GI10363@dastard>
References: <20180521024144.GO10363@dastard>
 <20180521025400.GJ29080@desktop.hz.ali.com>
 <20180525002914.GA10363@dastard>
 <20180525005940.GB10363@dastard>
 <20180525012335.GC10363@dastard>
 <20180525041759.GA5915@sol.localdomain>
 <20180525062530.GG10363@dastard>
 <CAOQ4uxgeq5f0_BQKoYQgJEGum4HQvP5bNopYamrXN+gs0Rou-Q@mail.gmail.com>
 <20180525084519.GH10363@dastard>
 <20180525223300.GB199878@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525223300.GB199878@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, Eryu Guan <guaneryu@gmail.com>, Theodore Ts'o <tytso@mit.edu>, fstests <fstests@vger.kernel.org>, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

On Fri, May 25, 2018 at 03:33:00PM -0700, Eric Biggers wrote:
> On Fri, May 25, 2018 at 06:45:19PM +1000, Dave Chinner wrote:
> > On Fri, May 25, 2018 at 11:06:23AM +0300, Amir Goldstein wrote:
> > > On Fri, May 25, 2018 at 9:25 AM, Dave Chinner <david@fromorbit.com> wrote:
> > > >> > +# remove previous $seqres.full before test
> > > >> > +rm -f $seqres.full
> > > >>
> > > >> Why can't the $seqres.full removal be done in the common preamble?
> > > >
> > > > Because it's common during test failure debugging to comment out the
> > > > removal of this file. I do it all the time, and I'm sure other
> > > > people do too.
> > > >
> > > 
> > > IDGI, this is removing the full log of previous test run.
> > > Why is it useful to comment it out?
> > 
> > Because when you have a test that doesn't fail every time and you
> > run it in a loop, you don't know which of the test runs is going to
> > fail, and often you get different failure signatures. Collecting
> > them all is easy this way - I've been using xfstests this way for the
> > last 15 years and I see no reason to make this harder to acheive.
> > 
> > > And if it is useful, better control keeping old log with env var and
> > > still keep the default code in setup_test, e.g.:
> > > KEEP_FULL_LOG=1 ./check ...
> > 
> > I don't like magic env settings that nobody (including me) will
> > remember or use and so will just bit rot. I'm trying to remove
> > technical debt from xfstests, not add more.
> > 
> 
> It could alternatively be an option passed to setup_test upon sourcing, so for
> your debugging workflow you would just replace
> 
> . common/setup_test
> 
> with
> 
> . common/setup_test --keep-full-log
> 
> Having the same boilerplate copy-and-pasted in 800 places solely for the purpose
> of being able to comment it out is very ugly.

Which conflicts with the goal of having a common fixed test setup
preamble that should not be modified by anyone.

i.e. I want to move towards a clean separation of the required test
harness setup parameters vs things that tests can change without
impacting the test harness or common/ test code. Things like $tmp,
$here, etc are controlled by the test harness and used in the common
code. OTOH, removal of $seqres.full output files is a per-test
option, not a test harness parameter - many tests don't use it and
never remove it. Hence it's /definition/ needs to be part of the
test harness setup preamble, but it's removal should not be as that
is a per-test and/or test-run context specific behaviour.


Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
