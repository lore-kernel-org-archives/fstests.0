Received: from ipmail01.adl6.internode.on.net ([150.101.137.136]:20139 "EHLO
        ipmail01.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934583AbeF0ODM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 10:03:12 -0400
Date: Thu, 28 Jun 2018 00:03:09 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 2/8] tests: convert various test dirs to setup preamble
Message-ID: <20180627140309.GG19934@dastard>
References: <20180627082103.9662-1-david@fromorbit.com>
 <20180627082103.9662-3-david@fromorbit.com>
 <CAOQ4uxgxt8LTCaN-7OS+Qp=npponARGYGfqco0xgaZ4oN5uf8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgxt8LTCaN-7OS+Qp=npponARGYGfqco0xgaZ4oN5uf8w@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 27, 2018 at 01:34:07PM +0300, Amir Goldstein wrote:
> On Wed, Jun 27, 2018 at 11:20 AM, Dave Chinner <david@fromorbit.com> wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> >
> > Convert all the test dirs with a very small number of tests in one
> > go.
> >
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> [...]
> 
> > -rm -f $seqres.full
> > +echo "Silence is golden"
> > +
> > +fio_config=$tmp.fio
> > +fio_results=$tmp.json
> >
> >  _size=$((16 * $LOAD_FACTOR))
> >  cat >$fio_config <<EOF
> > @@ -60,5 +56,5 @@ $FIO_PROG --output-format=json --output=$fio_results $fio_config
> >  _scratch_unmount
> >  cat $fio_results >> $seqres.full
> >  _fio_results_compare $seq $fio_results
> > -echo "Silence is golden"
> > -status=0; exit
> > +
> > +_success
> 
> I realize that without status=0 test will not pass, but it always
> annoys me that echo "Silence is golden" before the end of the test.

That's because it's supposed to be at the start of the test,
documenting the fact that any output from the test is expected to
cause it to fail. That's generally important to know before you get
ot the last line of the test code....

> How about _success_silent to further reduce the boilerplate echo
> "Silence is golden"?

No.  Removing "silence is golden" (and all the variations that have
crept in over the years) and replacing them with
_success_silent can be mostly scripted once everything
has first been converted to call _success. IMO that's a relatively easy followup
patchset, and it's precisely what this initial conversion is supposed to
enable us to do. i.e. make codebase wide setup/completion
maintenance much easier to perform.

So let's not make the hard part of converting 1260 tests to common
setup infrastructure any harder than it already is going to be by
adding lots of other random cleanups into it as well.....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
