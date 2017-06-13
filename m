Received: from mail-pg0-f66.google.com ([74.125.83.66]:35244 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752033AbdFMRi7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Jun 2017 13:38:59 -0400
Received: by mail-pg0-f66.google.com with SMTP id f127so20023451pgc.2
        for <fstests@vger.kernel.org>; Tue, 13 Jun 2017 10:38:59 -0700 (PDT)
Date: Tue, 13 Jun 2017 10:38:56 -0700
From: Eric Biggers <ebiggers3@gmail.com>
Subject: Re: [PATCH] generic/397: be compatible with ignored SIGPIPE
Message-ID: <20170613173856.GA119255@gmail.com>
References: <20170612211528.45666-1-ebiggers3@gmail.com>
 <20170613065438.GA4788@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170613065438.GA4788@eguan.usersys.redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

Hi Eryu,

On Tue, Jun 13, 2017 at 02:54:38PM +0800, Eryu Guan wrote:
> On Mon, Jun 12, 2017 at 02:15:28PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > If generic/397 is executed in an environment with SIGPIPE ignored, it
> > fails because the 'yes' program prints an error message:
> > 
> >     yes: standard output: Broken pipe
> >     yes: write error
> > 
> > This can be reproduced with:
> > 
> >     trap '' SIGPIPE; ./check generic/397
> > 
> > Fix it by generating the string of 255 y's using just 'head' and 'tr'
> > instead of 'yes', 'head', and 'tr'.
> > 
> > Although it's not really a good idea to execute xfstests with SIGPIPE
> > ignored, this is the only test I've noticed where it causes a problem,
> > so it might as well be fixed in the test.
> 
> I'm just curious, why do you need to run fstests with SIGPIPE ignored?
> 

It's more of an accidental thing, and I'm likely still going to fix the specific
case I encountered where 'check' was being run with SIGPIPE being ignored
(regardless of whether this xfstests patch goes in or not).  But I think it's an
easy problem for others to run into, since sometimes processes ignore SIGPIPE
because they want to get write errors instead, but then when doing fork() +
exec() they forget to reset the SIGPIPE handler.  Notably, Python got this wrong
and it wasn't fixed until Python 3, so any programs executing the 'check' script
from a Python 2 script will usually get this wrong (see:
https://bugs.python.org/issue1652).  And usually everything works fine but every
once in a while there is a weird problem like this which has to be debugged.

> 
> Using perl seems simpler, we have some other tests do similar tasks
> using perl too.
> 
> 	maxname=$($PERL_PROG -e 'print "y" x 255;')
> 

Yes, the perl version works too.

Eric
