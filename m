Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:62254 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932304AbeEYGZd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 25 May 2018 02:25:33 -0400
Date: Fri, 25 May 2018 16:25:30 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: Widespread test setup template problems (was Re: [PATCH]
 generic: fix cleanup function for test 490)
Message-ID: <20180525062530.GG10363@dastard>
References: <20180520184517.8826-1-tytso@mit.edu>
 <20180521024144.GO10363@dastard>
 <20180521025400.GJ29080@desktop.hz.ali.com>
 <20180525002914.GA10363@dastard>
 <20180525005940.GB10363@dastard>
 <20180525012335.GC10363@dastard>
 <20180525041759.GA5915@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525041759.GA5915@sol.localdomain>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: Eryu Guan <guaneryu@gmail.com>, Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org, jack@suse.cz
List-ID: <fstests@vger.kernel.org>

On Thu, May 24, 2018 at 09:17:59PM -0700, Eric Biggers wrote:
> On Fri, May 25, 2018 at 11:23:36AM +1000, Dave Chinner wrote:
> > Abstracting it out would look like the patch below. That, and moving
> > to SPDX tags for the licensing text, will greatly clean up the test
> > setup preamble. It will also draw a line in the sand for new tests -
> > if they don't match the new setup preamble, they don't pass
> > review...
> > 
> > Thoughts?
> > 
> 
> I agree with adding a common test preamble.  The current boilerplate is way too
> verbose and easy to get wrong.  Even if technically you are supposed to use the
> 'new' script which does it right... the fact that you need to generate the code
> using a script at all, instead of being able to write something simple and
> obviously correct, is problematic.

Using code to write code is a much more efficient way of generating
new code than having people copy-and-waste. The problem is that
people still copy and paste, despite the documentation saying "don't
do that, use the script" and the script being fast and easy to use.

The moral of the story: no matter what we do, people will not follow
the rules and they'll do whatever they damn well want.

> > -here=\`pwd\`
> > -tmp=/tmp/\$\$
> > -status=1	# failure is the default!
> > -trap "_cleanup; exit \\\$status" 0 1 2 3 15
> > -
> > -_cleanup()
> > -{
> > -	cd /
> > -	rm -f \$tmp.*
> > -}
> > -
> > -# get standard environment, filters and checks
> > -. ./common/rc
> > -. ./common/filter
> > +# test exit cleanup goes here
> > +local_cleanup() { true }
> 
> Did you consider defining the no-op local_cleanup() in the common preamble, and
> having tests override it if needed by redefining local_cleanup()?

Yes.

> Or
> alternatively, the preamble could use use 'type -t' to check if local_cleanup is
> defined before calling it. 

Didn't know that trick, but it has the same problem as above.

> Either is slightly error prone as a typo in the
> function name may go unnoticed, but it would save boilerplate from most tests.

Yup, far too likely to have people do their own/wrong thing because
we know they won't/don't follow documented instructions for creating
new tests.

> > +# remove previous $seqres.full before test
> > +rm -f $seqres.full
> 
> Why can't the $seqres.full removal be done in the common preamble?

Because it's common during test failure debugging to comment out the
removal of this file. I do it all the time, and I'm sure other
people do too.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
