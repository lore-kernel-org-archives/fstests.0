Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=camandro.org header.i=@camandro.org header.b="dsHTTKma"
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [IPv6:2001:67c:2050:0:465::201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 366E3101
	for <fstests@vger.kernel.org>; Thu, 23 Nov 2023 03:47:04 -0800 (PST)
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4Sbbtr2FWVz9t2v;
	Thu, 23 Nov 2023 12:47:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=camandro.org;
	s=MBO0001; t=1700740020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AhynCrVFDax1N7aG27e4H7vTkqh0RwEfpJhdvrDSrUU=;
	b=dsHTTKmawdFLwVkG7jPPbfY7DyOvsM3qb4gEvejjmi/Hw5J476478UmJ4oPaCUHZ19lQMu
	t4azQYNHiY8ZQo+LAjCSHzunAxlMx6Uqcw2ezbxMPIJ3IHVOBE/S1dZS4xknAYldz83nFr
	enetC+2tfQ+B2QJN+NR2WH2EU17pNLg25khHKCMSj5AZDc4J8OgQ72bIGN0eAvTrjg1MJg
	fBihFfvPpKss7Qf91vLdISc1FByyNwMZ+aNhe50QyAtRZ+fc3K5di+rxga9n/nL4M/rUnS
	KTevjtKoGYsRQMtniP9xFyLhe2G3coah2t+HdYYQ9ZcB3a0VKFk/iNQu+qhQ6A==
Date: Thu, 23 Nov 2023 11:46:57 +0000
From: =?iso-8859-1?Q?Lu=EDs?= Henriques <henrix@camandro.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Luis Henriques <lhenriques@suse.de>, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/581: remove extra escape character from awk line
Message-ID: <ZV87sT0lz0QqupDO@camandro.org>
References: <ZV40XOGNJdru13XE@suse.de>
 <20231122231648.GA1541@sol.localdomain>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231122231648.GA1541@sol.localdomain>
X-Rspamd-Queue-Id: 4Sbbtr2FWVz9t2v

(Sorry for replying from private email address)

On Wed, Nov 22, 2023 at 03:16:48PM -0800, Eric Biggers wrote:
> On Wed, Nov 22, 2023 at 05:03:24PM +0000, Luis Henriques wrote:
> > Checking the keys in /proc/key-users is buggy, as there's an extra '\'
> > character: in '{print \$4}' the '$4' shouldn't be escaped otherwise the
> > 'awk' command will fail.  This has passed unnoticed because the output
> > is sent to '_user_do' function and the result assigned to a variable.
> > 
> > While there, replace 'awk' by $AWK_PROG.
> > 
> > Signed-off-by: Luis Henriques <lhenriques@suse.de>
> > ---
> >  tests/generic/581 | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Hi!
> > 
> > Please note that I'm not an 'awk' expert and I may be wrong!  But if I do
> > see an error if I run something like:
> > 
> > $ awk '/^[[:space:]]*1000:/{print \$4}' /proc/key-users 
> > awk: cmd. line:1: /^[[:space:]]*1000:/{print \$4}
> > awk: cmd. line:1:                            ^ backslash not last character on line
> > 
> > But maybe this depends on the awk implementation, although I've tried a few.
> > 
> > diff --git a/tests/generic/581 b/tests/generic/581
> > index cabc7e1c69ab..1a4b571d40ce 100755
> > --- a/tests/generic/581
> > +++ b/tests/generic/581
> > @@ -92,7 +92,7 @@ while grep -E -q '^[0-9a-f]+ [^ ]*i[^ ]*' /proc/keys; do
> >  done
> >  
> >  # Set the user key quota to the fsgqa user's current number of keys plus 5.
> > -orig_keys=$(_user_do "awk '/^[[:space:]]*$(id -u fsgqa):/{print \$4}' /proc/key-users | cut -d/ -f1")
> > +orig_keys=$(_user_do "$AWK_PROG '/^[[:space:]]*$(id -u fsgqa):/{print $4}' /proc/key-users | cut -d/ -f1")
> 
> The backslash is needed to prevent $4 from being expanded by bash, because the
> whole pipeline with 'awk' and 'cut' is in a double-quoted string:
> 
>     "awk '/^[[:space:]]*$(id -u fsgqa):/{print \$4}' /proc/key-users | cut -d/ -f1"
> 
> Without escaping the $, bash would replace $4 with the empty string while it's
> doing expansions on the whole double-quoted string.

/me blushes

Yeah, looking closer it makes sense.  Sorry for the noise.  I'm currently
investigating a test failure (which I can't reproduce locally) where
'orig_key' unexpectedly is set to '1' and makes the test fail because it
was supposed to be '0'.  That's when this caught my attention.  Anyway,
I'll go look somewhere else.

Cheers,
--
Luís
