Return-Path: <fstests-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:58801 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753047AbbCZPoN (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 26 Mar 2015 11:44:13 -0400
Date: Thu, 26 Mar 2015 16:44:11 +0100
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] fstests: Tests can use any name now, not 3 digits only.
Message-ID: <20150326154411.GQ20767@suse.cz>
Reply-To: dsterba@suse.cz
References: <20150321131159.GA4810@dhcp-13-216.nay.redhat.com>
 <1427376933-7588-1-git-send-email-jtulak@redhat.com>
 <20150326144109.GP20767@suse.cz>
 <1912769466.3218422.1427382962269.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1912769466.3218422.1427382962269.JavaMail.zimbra@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan Tulak <jtulak@redhat.com>
Cc: eguan@redhat.com, fstests@vger.kernel.org, lczerner@redhat.com
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 26, 2015 at 11:16:02AM -0400, Jan Tulak wrote:
> > > +	for found in `tail -n +$line $tdir/group | $AWK_PROG '{ print $1 }'`; do
> > > +		foundId=$(echo "$found" | tr - ' ' | $AWK_PROG '{ print $1 }')
> > > +		line=$((line+1))
> > > +		if [ -z "$found" ] || [ "$found" == "#" ]; then
> > > +			continue
> > > +		elif [[ "$found" > "$name" ]] || [ "$foundId" -gt "$id" ]; then
> > 
> > Bash guide advices not to use [[ ]] for arithmetic expressions, in favor
> > of (( )). Besides, I find mixing [[ ]] and [ ] inconsistent, choose one.
> 
> The [[ "$found" > "$name" ]] is a string expression, for lexicographic ordering. :-)

Ah, I see, then it's correct.

> The second [ ] is for arithmetic - so I used the mix of [[]] and []
> deliberately to distinguish it. Though if it is a bad practise, I will
> stick to not mixing it in one condition.

And [ -gt ] is ok.
