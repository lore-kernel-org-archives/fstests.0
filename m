Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:26224 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932907AbeF0OeQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Jun 2018 10:34:16 -0400
Date: Thu, 28 Jun 2018 00:34:13 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 5/8] btrfs: convert some tests to new setup preamble
Message-ID: <20180627143413.GI19934@dastard>
References: <20180627082103.9662-1-david@fromorbit.com>
 <20180627082103.9662-6-david@fromorbit.com>
 <CAOQ4uxi7NP-NpK38CnBB=epxhq6Ykt+V-hSwOtAJuac7Gwt3og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxi7NP-NpK38CnBB=epxhq6Ykt+V-hSwOtAJuac7Gwt3og@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Amir Goldstein <amir73il@gmail.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Wed, Jun 27, 2018 at 02:30:13PM +0300, Amir Goldstein wrote:
> On Wed, Jun 27, 2018 at 11:21 AM, Dave Chinner <david@fromorbit.com> wrote:
> > From: Dave Chinner <dchinner@redhat.com>
> >
> > Small initial batch to demonstrate conversion.
> >
> > Signed-off-by: Dave Chinner <dchinner@redhat.com>
> > ---
> [...]
> > diff --git a/tests/btrfs/007 b/tests/btrfs/007
> > index 09f2f011bc77..50ead03acf31 100755
> > --- a/tests/btrfs/007
> > +++ b/tests/btrfs/007
> > @@ -9,37 +9,23 @@
> >  # (incr) and send both snapshots to a temp file. Remake the file
> >  # system and receive from the files. Check both states with fssum.
> >  #
> > -# creator
> > -owner=list.btrfs@jan-o-sch.net
> > +. common/setup_test
> >
> > -seq=`basename $0`
> > -seqres=$RESULT_DIR/$seq
> > -echo "QA output created by $seq"
> > +# test exit cleanup goes here
> > +cleanup() { :; }
> >
> > -tmp=`mktemp -d`
> > -status=1
> > -
> > -_cleanup()
> > -{
> > -       echo "*** unmount"
> > -       _scratch_unmount 2>/dev/null
> > -       rm -f $tmp.*
> > -}
> 
> Bug in existing test - it does not cleanup $tmp.

Yup, because it creates a non-standard $tmp but then uses code that
assumes that tmp is the standard name prefix definition, not a
directory.  This is exactly the sort of bug I'm trying to eradicate.

And, FWIW, because the test is only using tmp files, it doesn't need
to use TEST_DIR to store them so no need for a working directory to
be defined.

> cleanup() { rm -rf $tmp }
> 
> -tmp=`mktemp -d`
> +mkdir -p $tmp

Again, no. $tmp is not a directory and there's infrastructure that
assumes it is not a directory.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
