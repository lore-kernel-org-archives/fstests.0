Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55798 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752472AbbDAMPH (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 1 Apr 2015 08:15:07 -0400
Date: Wed, 1 Apr 2015 14:15:02 +0200 (CEST)
From: =?ISO-8859-15?Q?Luk=E1=A8_Czerner?= <lczerner@redhat.com>
Subject: Re: [PATCH v9] fstests: Tests can use any name now, not 3 digits
 only.
In-Reply-To: <1003463620.6015995.1427890174467.JavaMail.zimbra@redhat.com>
Message-ID: <alpine.LFD.2.00.1504011411040.29043@localhost.localdomain>
References: <20150327072539.GB4810@dhcp-13-216.nay.redhat.com> <1427456966-21130-1-git-send-email-jtulak@redhat.com> <20150401043542.GD8465@dastard> <1003463620.6015995.1427890174467.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Wed, 1 Apr 2015, Jan Tulak wrote:

> > > --- a/common/rc
> > > +++ b/common/rc
> > > @@ -21,6 +21,7 @@
> > >  #-----------------------------------------------------------------------
> > >  
> > >  BC=$(which bc 2> /dev/null) || BC=
> > > +SUPPORTED_TESTS="[a-zA-Z0-9-]\+"
> > 
> > but $SUPPORTED_TESTS doesn't define the correct format for the test
> > names. It defines valid characters, but does not enforce the fact
> > that the first 3 characters must match [0-9] (i.e. the NNN bit), and
> > then the rest is optional but must be alphanumeric symbols and dash.
> > i.e it should be matching against:
> > 
> 
> I did it to be "generous on input, strict on output" - the ./new script always put 3 numbers at the beginning, but if someone for some reason needs to avoid it, it will still work. Enforcing it is easy, but is it needed?

Hi Jan,

I thought that we've already established that indeed yes, it is
needed. Having ./new script to create the right format is nice, but
it's not enough.

You can easily create new tests without ./new script and while I do
not know how many people are using it, I've never used it myself.

Please enforce the naming format.

Thanks!
-Lukas
