Received: from mail-pl0-f67.google.com ([209.85.160.67]:41487 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752624AbeEUCyE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 20 May 2018 22:54:04 -0400
Received: by mail-pl0-f67.google.com with SMTP id az12-v6so7896242plb.8
        for <fstests@vger.kernel.org>; Sun, 20 May 2018 19:54:04 -0700 (PDT)
Date: Mon, 21 May 2018 10:54:00 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic: fix cleanup function for test 490
Message-ID: <20180521025400.GJ29080@desktop.hz.ali.com>
References: <20180520184517.8826-1-tytso@mit.edu>
 <20180521024144.GO10363@dastard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180521024144.GO10363@dastard>
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org, jack@suse.cz
List-ID: <fstests@vger.kernel.org>

On Mon, May 21, 2018 at 12:41:44PM +1000, Dave Chinner wrote:
> On Sun, May 20, 2018 at 02:45:17PM -0400, Theodore Ts'o wrote:
> > generic/490 fails because cleanup tries to delete . and .. since $tmp
> > is left unset, and so "rm -f $tmp.*" does nothing useful.  Instead
> > delete temp files created by seek_sanity_test.
> > 
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > ---
> >  tests/generic/490 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tests/generic/490 b/tests/generic/490
> > index b5042c2e..c0335ca0 100755
> > --- a/tests/generic/490
> > +++ b/tests/generic/490
> > @@ -49,7 +49,7 @@ _require_test_program "seek_sanity_test"
> >  _cleanup()
> >  {
> >  	cd /
> > -	rm -f $tmp.*
> > +	rm -f $base_test_file*
> >  }
> >  
> >  $here/src/seek_sanity_test -s 19 -e 20 $base_test_file > $seqres.full 2>&1 ||
> 
> This is wrong. $tmp must always be set in a test, as the
> infrastructure uses it. Failing to set $tmp will result in stray
> files being spewed around the place by the test and not cleaned up.
> Hence the "rm -f $tmp.*" line must stay, the normal tmp=/tmp/$$ line
> added to the test preamble, and then you can remove the base test
> file...

Yeah, I wanted to point that out too. So always using the './new' script
is the recommended way to write new test, it already puts all the common
setups (including the 'tmp=/tmp/$$' definition and 'rm -f $tmp.*'
cleanup) in the test template.

Thanks,
Eryu
