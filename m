Return-Path: <fstests-owner@vger.kernel.org>
Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:17358 "EHLO
	ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752819AbbDGC3v (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 6 Apr 2015 22:29:51 -0400
Date: Tue, 7 Apr 2015 12:29:37 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH] generic/076: fixed incorrect fsstress parameters
Message-ID: <20150407022937.GB13731@dastard>
References: <1427990168-21503-1-git-send-email-omzg@plexistor.com>
 <CAL3q7H4KPH22AptJaSMFapp1iOECuWHKUjEYznrCwe7mV5SUcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4KPH22AptJaSMFapp1iOECuWHKUjEYznrCwe7mV5SUcg@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Filipe David Manana <fdmanana@gmail.com>
Cc: Omer Zilberberg <omzg@plexistor.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Apr 02, 2015 at 10:05:40PM +0100, Filipe David Manana wrote:
> On Thu, Apr 2, 2015 at 4:56 PM, Omer Zilberberg <omzg@plexistor.com> wrote:
> > Test was not run because directory parameter was omitted.
> > Also return value was not tested, so this problem was not caught.
> >
> > Signed-off-by: Omer Zilberberg <omzg@plexistor.com>
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Tested-by: Filipe Manana <fdmanana@suse.com>
> 
> > ---
> >  tests/generic/076 | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/generic/076 b/tests/generic/076
> > index aa0aae0..3e1aa1a 100755
> > --- a/tests/generic/076
> > +++ b/tests/generic/076
> > @@ -74,9 +74,11 @@ echo "*** test concurrent block/fs access"
> >  cat $SCRATCH_DEV >/dev/null &
> >  pid=$!
> >
> > -FSSTRESS_ARGS=`_scale_fsstress_args -p 2 -n 2000 $FSSTRESS_AVOID`
> > +FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -p 2 -n 2000 $FSSTRESS_AVOID`
> >  echo "run fsstress with args: $FSSTRESS_ARGS" >>$seqres.full
> >  $FSSTRESS_PROG $FSSTRESS_ARGS >>$seqres.full
> > +rc=$?
> > +[ $rc != 0 ] && echo "fsstress returned $rc - see $seqres.full"
> 
> run_check $FSSTRESS_PROG $FSSTRESS_ARGS
>
> Would also do it (some other tests do this).

Please don't encourage run_check usage - it's cargo-cult programming
at it's worst. It stops people from thinking about what errors they
actually need to care about and capture exactly via other methods
(such as output filtering).

To demonstrate: fsstress only ever returns non-zero when there's a
config or setup problem. This basically never happens once the test
has been written. Further, fsstress does not collect runtime errors
from child processes because it is designed to trigger errors and
still continue onwards. Finally, the output stream is really only
debug information, so that's not useful for anythign other than
debugging, either.

Hence there is never any need to check exit status of fsstress, nor
do anything with the output stream except redirect it to the
debug output file or the bit bucket.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
