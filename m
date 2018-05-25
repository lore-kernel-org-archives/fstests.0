Received: from ipmail03.adl2.internode.on.net ([150.101.137.141]:62761 "EHLO
        ipmail03.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S964791AbeEYIpb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 25 May 2018 04:45:31 -0400
Date: Fri, 25 May 2018 18:45:19 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Widespread test setup template problems (was Re: [PATCH]
 generic: fix cleanup function for test 490)
Message-ID: <20180525084519.GH10363@dastard>
References: <20180520184517.8826-1-tytso@mit.edu>
 <20180521024144.GO10363@dastard>
 <20180521025400.GJ29080@desktop.hz.ali.com>
 <20180525002914.GA10363@dastard>
 <20180525005940.GB10363@dastard>
 <20180525012335.GC10363@dastard>
 <20180525041759.GA5915@sol.localdomain>
 <20180525062530.GG10363@dastard>
 <CAOQ4uxgeq5f0_BQKoYQgJEGum4HQvP5bNopYamrXN+gs0Rou-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgeq5f0_BQKoYQgJEGum4HQvP5bNopYamrXN+gs0Rou-Q@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: Eric Biggers <ebiggers3@gmail.com>, Eryu Guan <guaneryu@gmail.com>, Theodore Ts'o <tytso@mit.edu>, fstests <fstests@vger.kernel.org>, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

On Fri, May 25, 2018 at 11:06:23AM +0300, Amir Goldstein wrote:
> On Fri, May 25, 2018 at 9:25 AM, Dave Chinner <david@fromorbit.com> wrote:
> > On Thu, May 24, 2018 at 09:17:59PM -0700, Eric Biggers wrote:
> >> On Fri, May 25, 2018 at 11:23:36AM +1000, Dave Chinner wrote:
> >> > Abstracting it out would look like the patch below. That, and moving
> >> > to SPDX tags for the licensing text, will greatly clean up the test
> >> > setup preamble. It will also draw a line in the sand for new tests -
> >> > if they don't match the new setup preamble, they don't pass
> >> > review...
> >> >
> >> > Thoughts?
> >> >
> >>
> >> I agree with adding a common test preamble.  The current boilerplate is way too
> >> verbose and easy to get wrong.  Even if technically you are supposed to use the
> >> 'new' script which does it right... the fact that you need to generate the code
> >> using a script at all, instead of being able to write something simple and
> >> obviously correct, is problematic.
> >
> > Using code to write code is a much more efficient way of generating
> > new code than having people copy-and-waste. The problem is that
> > people still copy and paste, despite the documentation saying "don't
> > do that, use the script" and the script being fast and easy to use.
> >
> > The moral of the story: no matter what we do, people will not follow
> > the rules and they'll do whatever they damn well want.
> >
> 
> As a frequent copy&paste offender, I welcome this change very much.
> Keep in mind that it is a very common practice in xfstests to create
> a variant of an existing test, so copy & pasting will likely not stop.

My thoughts exactly :P

> >> > -here=\`pwd\`
> >> > -tmp=/tmp/\$\$
> >> > -status=1   # failure is the default!
> >> > -trap "_cleanup; exit \\\$status" 0 1 2 3 15
> >> > -
> >> > -_cleanup()
> >> > -{
> >> > -   cd /
> >> > -   rm -f \$tmp.*
> >> > -}
> >> > -
> >> > -# get standard environment, filters and checks
> >> > -. ./common/rc
> >> > -. ./common/filter
> >> > +# test exit cleanup goes here
> >> > +local_cleanup() { true }
> >>
> >> Did you consider defining the no-op local_cleanup() in the common preamble, and
> >> having tests override it if needed by redefining local_cleanup()?
> >
> > Yes.
> >
> 
> Maybe just cleanup() for local cleanup as is the convention in all the tests
> that _funcs() are global and funcs() are local.

Yup, I wrote then deleted in my last reply that I've renamed it to
just "cleanup().

> 
> Did you notice that your patch left an overriding _cleanup() function
> in generic/001
> that does not call local_cleanup(), but that does do local cleanups.

Yup - I didn't change any of the code in that test as I was just
demonstrating the sort of cleanup needed. generic/001 uses _cleanup
as a local function called between two different parts of the test,
not as an error trap, so more work is needed to fix it completely.

> I don't think that is what you intended do to.  Also, as an
> example you picked the only test that actually calls _cleanup() at
> start of test as well - not that it matters much, but the cleanup
> and handling of $TEST_DIR/$$ is quite bizarre and needs to be
> killed, so you may want to pick another poster child ;-)

I'm not going to fix every problem that this specific test has - I
want to fix the wider, more general problem first.  I just picked it
as an example for an initial RFC, not because it is a complete,
fully working patch ready for inclusion. There's 800+ plus
files that need work as part of this cleanup, so I want to make sure
the cleanup I'm going to do is acceptable before spending any time
on it.


> BTW, there are only 3 other tests that call _cleanup directly, but they
> do it just before calling exit... (generic/{124,127,236}).
> 
> >> Or
> >> alternatively, the preamble could use use 'type -t' to check if local_cleanup is
> >> defined before calling it.
> >
> > Didn't know that trick, but it has the same problem as above.
> >
> >> Either is slightly error prone as a typo in the
> >> function name may go unnoticed, but it would save boilerplate from most tests.
> >
> > Yup, far too likely to have people do their own/wrong thing because
> > we know they won't/don't follow documented instructions for creating
> > new tests.
> >
> >> > +# remove previous $seqres.full before test
> >> > +rm -f $seqres.full
> >>
> >> Why can't the $seqres.full removal be done in the common preamble?
> >
> > Because it's common during test failure debugging to comment out the
> > removal of this file. I do it all the time, and I'm sure other
> > people do too.
> >
> 
> IDGI, this is removing the full log of previous test run.
> Why is it useful to comment it out?

Because when you have a test that doesn't fail every time and you
run it in a loop, you don't know which of the test runs is going to
fail, and often you get different failure signatures. Collecting
them all is easy this way - I've been using xfstests this way for the
last 15 years and I see no reason to make this harder to acheive.

> And if it is useful, better control keeping old log with env var and
> still keep the default code in setup_test, e.g.:
> KEEP_FULL_LOG=1 ./check ...

I don't like magic env settings that nobody (including me) will
remember or use and so will just bit rot. I'm trying to remove
technical debt from xfstests, not add more.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
