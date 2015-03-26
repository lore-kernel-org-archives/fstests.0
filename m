Return-Path: <fstests-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:53923 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932138AbbCZOlL (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 26 Mar 2015 10:41:11 -0400
Date: Thu, 26 Mar 2015 15:41:09 +0100
From: David Sterba <dsterba@suse.cz>
Subject: Re: [PATCH] fstests: Tests can use any name now, not 3 digits only.
Message-ID: <20150326144109.GP20767@suse.cz>
Reply-To: dsterba@suse.cz
References: <20150321131159.GA4810@dhcp-13-216.nay.redhat.com>
 <1427376933-7588-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1427376933-7588-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Jan =?utf-8?B?xaR1bMOhaw==?= <jtulak@redhat.com>
Cc: eguan@redhat.com, fstests@vger.kernel.org, lczerner@redhat.com
List-ID: <fstests@vger.kernel.org>

Please put a revision number in the subject so we know what's the latest
one, eg:

[PATCH v5] fstests: Tests can use any name now, not 3 digits only

On Thu, Mar 26, 2015 at 02:35:33PM +0100, Jan Ťulák wrote:
> Tests can use any name now, not 3 digits only.
> (e.g. a test can be named "tests/generic/001-some-name")
> 
> Names are limited to alphanumeric characters and dash and are always prefixed
> with an unique id for easier identification of a specific patch.

patch or test?

> --- a/README
> +++ b/README
> @@ -205,7 +205,7 @@ Test script environment:
>  
>  Verified output:
>  
> -    Each test script has a numerical name, e.g. 007, and an associated
> +    Each test script has a name, e.g. 007, and an associated
>      verified output, e.g. 007.out.

I think the naming scheme could be described in the README, probably in
the "Creating new tests scripts:" section.

> +if [[ "$REPLY" =~ ^[Yy]$ ]]; then

You don't need to quote variables in the [[ ]] block as it's a builtin,
unlike [ (in general). Also, [[ $variable = glob ]] does really match
globs, so it's simple [[ $REPLY = [yY] ]] if you insist on using [[ .

> +	for found in `tail -n +$line $tdir/group | $AWK_PROG '{ print $1 }'`; do
> +		foundId=$(echo "$found" | tr - ' ' | $AWK_PROG '{ print $1 }')
> +		line=$((line+1))
> +		if [ -z "$found" ] || [ "$found" == "#" ]; then
> +			continue
> +		elif [[ "$found" > "$name" ]] || [ "$foundId" -gt "$id" ]; then

Bash guide advices not to use [[ ]] for arithmetic expressions, in favor
of (( )). Besides, I find mixing [[ ]] and [ ] inconsistent, choose one.

> +			eof=0
> +			break
> +		fi
> +	done
