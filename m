Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx4-phx2.redhat.com ([209.132.183.25]:50482 "EHLO
	mx4-phx2.redhat.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752787AbbCZPQE convert rfc822-to-8bit (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 26 Mar 2015 11:16:04 -0400
Date: Thu, 26 Mar 2015 11:16:02 -0400 (EDT)
From: Jan Tulak <jtulak@redhat.com>
Message-ID: <1912769466.3218422.1427382962269.JavaMail.zimbra@redhat.com>
In-Reply-To: <20150326144109.GP20767@suse.cz>
References: <20150321131159.GA4810@dhcp-13-216.nay.redhat.com> <1427376933-7588-1-git-send-email-jtulak@redhat.com> <20150326144109.GP20767@suse.cz>
Subject: Re: [PATCH] fstests: Tests can use any name now, not 3 digits only.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: fstests-owner@vger.kernel.org
To: dsterba@suse.cz
Cc: eguan@redhat.com, fstests@vger.kernel.org, lczerner@redhat.com
List-ID: <fstests@vger.kernel.org>



----- Original Message -----
> From: "David Sterba" <dsterba@suse.cz>
> To: "Jan Ťulák" <jtulak@redhat.com>
> Cc: eguan@redhat.com, fstests@vger.kernel.org, lczerner@redhat.com
> Sent: Thursday, 26 March, 2015 3:41:09 PM
> Subject: Re: [PATCH] fstests: Tests can use any name now, not 3 digits only.
> 
> Please put a revision number in the subject so we know what's the latest
> one, eg:
> 
> [PATCH v5] fstests: Tests can use any name now, not 3 digits only
> 
> On Thu, Mar 26, 2015 at 02:35:33PM +0100, Jan Ťulák wrote:
> > Tests can use any name now, not 3 digits only.
> > (e.g. a test can be named "tests/generic/001-some-name")
> > 
> > Names are limited to alphanumeric characters and dash and are always
> > prefixed
> > with an unique id for easier identification of a specific patch.
> 
> patch or test?

Fixed.


> 
> > --- a/README
> > +++ b/README
> > @@ -205,7 +205,7 @@ Test script environment:
> >  
> >  Verified output:
> >  
> > -    Each test script has a numerical name, e.g. 007, and an associated
> > +    Each test script has a name, e.g. 007, and an associated
> >      verified output, e.g. 007.out.
> 
> I think the naming scheme could be described in the README, probably in
> the "Creating new tests scripts:" section.

True, added into the readme.


> 
> > +if [[ "$REPLY" =~ ^[Yy]$ ]]; then
> 
> You don't need to quote variables in the [[ ]] block as it's a builtin,
> unlike [ (in general). Also, [[ $variable = glob ]] does really match
> globs, so it's simple [[ $REPLY = [yY] ]] if you insist on using [[ .
> 
Thank you for this info, I didn't knew this. :-)

> > +	for found in `tail -n +$line $tdir/group | $AWK_PROG '{ print $1 }'`; do
> > +		foundId=$(echo "$found" | tr - ' ' | $AWK_PROG '{ print $1 }')
> > +		line=$((line+1))
> > +		if [ -z "$found" ] || [ "$found" == "#" ]; then
> > +			continue
> > +		elif [[ "$found" > "$name" ]] || [ "$foundId" -gt "$id" ]; then
> 
> Bash guide advices not to use [[ ]] for arithmetic expressions, in favor
> of (( )). Besides, I find mixing [[ ]] and [ ] inconsistent, choose one.

The [[ "$found" > "$name" ]] is a string expression, for lexicographic ordering. :-)
The second [ ] is for arithmetic - so I used the mix of [[]] and [] deliberately to distinguish it. Though if it is a bad practise, I will stick to not mixing it in one condition.

Jan
