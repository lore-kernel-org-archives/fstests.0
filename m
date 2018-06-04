Received: from ipmail01.adl6.internode.on.net ([150.101.137.136]:28021 "EHLO
        ipmail01.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751412AbeFDC6y (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 3 Jun 2018 22:58:54 -0400
Date: Mon, 4 Jun 2018 12:58:51 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 1/2] fstests: generic test setup preamble
Message-ID: <20180604025851.GD10972@dastard>
References: <20180529004752.8243-1-david@fromorbit.com>
 <20180529004752.8243-2-david@fromorbit.com>
 <20180603135316.GL6581@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180603135316.GL6581@desktop>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Jun 03, 2018 at 09:53:16PM +0800, Eryu Guan wrote:
> On Tue, May 29, 2018 at 10:47:51AM +1000, Dave Chinner wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> > 
> > So many tests chop random bits out of the mandaotry test setup
> > preamble which leads to subtle problems and stray files being dumped
> > all over the place. Create a common test preamble with hooks for
> > local cleanup functions so we can prevent this in future.
> > 
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
....

> > --- a/new
> > +++ b/new
> > @@ -181,31 +181,15 @@ cat <<End-of-File >$tdir/$id
> >  #-----------------------------------------------------------------------
> >  #
> >  
> > -seq=\`basename \$0\`
> > -seqres=\$RESULT_DIR/\$seq
> > -echo "QA output created by \$seq"
> > +. common/setup_test
> >  
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
> Should be just "cleanup" here.

Fixed.

> > diff --git a/tests/xfs/001 b/tests/xfs/001
> > index 2c205f064e2e..1b5a1020e173 100755
> > --- a/tests/xfs/001
> > +++ b/tests/xfs/001
> > @@ -23,44 +23,17 @@
> >  #-----------------------------------------------------------------------
> >  #
> >  
> > -seq=`basename $0`
> > -seqres=$RESULT_DIR/$seq
> > -echo "QA output created by $seq"
> > +. common/setup_test
> >  
> > -here=`pwd`
> > -tmp=/tmp/$$
> > -status=1	# failure is the default!
> > -trap "_cleanup; exit \$status" 0 1 2 3 15
> > -
> > -_cleanup()
> > -{
> > -    cd /
> > -    rm -f $tmp.*
> > +# test exit cleanup goes here
> > +cleanup() {
> > +	rm -rf $TEST_DIR/$$
> >  }
> >  
> > -_do_bit_test()
> 
> Removed by mistake? Test fails without it.

Hmmm - there's a hunk missing from this patch - I moved that
function down further into the test. it's in my current local
version and the test passes just fine. Not sure what went wrong
here...

Cheers,

Dave.

-- 
Dave Chinner
david@fromorbit.com
