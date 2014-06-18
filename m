Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:57227 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753095AbaFRX4v (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 18 Jun 2014 19:56:51 -0400
Date: Thu, 19 Jun 2014 09:56:36 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [patch] add an aio test which closes the fd before destroying
 the ioctx
Message-ID: <20140618235636.GE4453@dastard>
References: <x4961k97o9o.fsf@segfault.boston.devel.redhat.com>
 <20140610004911.GF4453@dastard>
 <x49k38eozfm.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <x49k38eozfm.fsf@segfault.boston.devel.redhat.com>
Sender: xfstests-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>
Cc: fstests@vger.kernel.org, Matt Cross <matt.cross@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 18, 2014 at 02:17:01PM -0400, Jeff Moyer wrote:
> Dave Chinner <david@fromorbit.com> writes:
> >> +  CPU_ZERO(&cpuset);
> >> +  CPU_SET(mycpu, &cpuset);
> >> +  if (sched_setaffinity(mytid, sizeof(cpuset), &cpuset)) {
> >> +    printf("FAILED to set thread %d to run on cpu %ld\n", mytid, mycpu);
> >> +  }
> >
> > Any reason why process layout like this is necessary? Comments are
> > nice, even in test code...
> 
> I honestly don't remember the specifics, other than it gave a better
> probability for reproducing the failure.  I can at least make a comment
> stating that.

Sounds good.

> >> +#-----------------------------------------------------------------------
> >> +# Copyright (c) 2014 Jeff Moyer.  All Rights Reserved.
> >
> > Sent from a Red Hat email address. Can you please clarify who owns
> > the copyright?
> 
> The script is mine, the code is Matt's.  There are copyright headers in
> both, and they attribute the copyright to the proper individual.  What
> isn't clear about that?

I have a patch that is:


From: Jeff Moyer <jmoyer@redhat.com>

Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

with code you wrote but doesn't have a Red Hat copyright on it. I
don't know when you wrote it or what context it was written in, but normally
the copyright of work done on behalf of an employer is owned by the
employer. Hence the ownership for the portions of the patch you wrote
is not clear to me from the information presented and so I've asked
for clarification.

FWIW, most people use their personal email addresses for code they
write that is not owned by their employer to avoid this confusion.

> >> +
> >> +_run_323() {
> >> +	local testtemp=$TEST_DIR/aio-testfile
> >
> > testfile?
> 
> Are you suggesting that I rename aio-tesfile to testfile?  Or rename
> testtempt to testfile?  Something else?

testtemp is a terrible variable name. It's a test file.

> >> +	return $status
> >> +}
> >> +
> >> +_run_323
> >
> > Like I said, no need for a function for such a simple test... 
> 
> I'm no bash guru.  I created a function in order to avoid creating a
> global testtemp variable.  If that doesn't matter, I'm happen to flatten
> things out.

For xfstests, library functions and internal variables are preceeded
by a "_" and global variables are in upper case so you don't have to
worry about namespace pollution your the test script.

Cheers,

Dave.


-- 
Dave Chinner
david@fromorbit.com
