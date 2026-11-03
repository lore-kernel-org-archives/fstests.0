Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793735599;
	b=p8JclbkaYwrSkz8x3jMqqUUQl2tsA2jE6fXe3orowJUmpMtuEA8CbaYBJuk2vzLWx+A+
	 fgaL2DatFwo02wXQqop8yoIQMFAGd14L+x5fSVD6ob5FKEV2R9K/n25EqKL+ms4scxHqF
	 02irWqGquZKLeId1TFSbJ9lUzlDRRuiKqn6gUBBcYJ/mArh/fHYdoQPKAOBnC0r7k8CtI
	 TAvfwss91zAmc92exYVW5n7VC3JoCccAfziKx7XL+X9TpAkYZZpTE2jwsXPVwB1qnoPJ0
	 675kt0lsNgyXtQ6o3SA7d3HqQsXPaZGM5N/nMYF9fmQlPzzHXHjj1yzO7vHn7vM6wVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793735599;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=65RX+VfCk+dq17hXxxdv+4/NRmJc42WooAZ095RswII=;
	b=o6hW9KFADzsj6pUT1vxorrDP552nVaqe9EGR4TvUStd8Fahb86SUQydIHtBaqCDsTHaS
	 fPn9XbavnHT9IdtLswepmbpknPhxkyucGX4rODaHrPvKH2WDUF+yUIM1/qMDoV7u/tOOB
	 o3KpFK4LEIYQnhXNcrLOCei7PP6W1RJDnVfdouVcbcF8UMBVXnA0OHWcOXmikIPPZgvUR
	 k0IvKwJYXv1UJCSGHypZU4Sqvvb1tfsE4IFLOzNzd0SgntuWna3DIklV6BPz0Fmhqmmxh
	 Dle/33wZkSlP/nghyOisd0SwmItloWiypd5Trk6JtMn6oYtWJ3KK9tAQW5nyUmY+ZEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6c64cB9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A196F606A32C
	for <fstests@vger.kernel.org>; Tue,  3 Nov 2026 19:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J6c64cB9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136631F000C1;
	Tue,  3 Nov 2026 19:53:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793735599;
	bh=65RX+VfCk+dq17hXxxdv+4/NRmJc42WooAZ095RswII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=J6c64cB963aPuvgVFp6NMHJ7fzJyvOVq6EsqR+FBJMVnpwQRAl1UjOjY6IiU5s6E0
	 YQxO/Uhu9WSUEh79+7xhV/ex/dFWqgUybHTcygfsTPn4e0gtd++ljfxkrOxa/GOgv+
	 SLH1lqQcjszjrVSf1SdLNpTk/EHRrzdk3g+mV/szkpdaYCIKUurafmBlP7J3lZUi4r
	 Y4o2kLP7UGzwya7ekjxmCZR7Fxk2e9H/TyM68ORAnma+evDH8zJJAI9GsdH4D4/uFP
	 W5fA+1TDyXOq0f7WIOpL/I56tXn47uCzffWmxwSasEg/125QSve1Q/sm7f36BMjFdM
	 QYGXOLM1OZNgw==
Date: Wed, 4 Nov 2026 03:53:14 +0800
From: Zorro Lang <zlang@kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] tools/get_maintainer.pl: accept and ignore
 --nogit-chief-penguins
Message-ID: <auo5rGN2D7_akSuF@zlang-mailbox>
Mail-Followup-To: Jeff Layton <jlayton@kernel.org>, 
	fstests@vger.kernel.org
References: <20261027-b4-v1-1-a87dca9172c9@kernel.org>
 <auId2GI01gShq9uf@zlang-mailbox>
 <c236e40a7e6094f35fb0cb529282e25827c2741b.camel@kernel.org>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c236e40a7e6094f35fb0cb529282e25827c2741b.camel@kernel.org>

On Wed, Oct 28, 2026 at 01:18:41PM -0400, Jeff Layton wrote:
> On Thu, 2026-10-29 at 01:09 +0800, Zorro Lang wrote:
> > On Tue, Oct 27, 2026 at 09:51:54AM -0400, Jeff Layton wrote:
> > > b4 prep --auto-to-cc passes --nogit-chief-penguins as an option to
> > > get_maintainer.pl. Ensure that it accepts and ignores it.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > 
> > Makes sense to me, thanks Jeff!
> > 
> > Reviewed-by: Zorro Lang <zlang@kernel.org>
> > 
> > Just out of curiosity, how did you configure your environment to trigger
> > this in fstests? Did you symlink "scripts" to "tools" (e.g. ln -s tools scripts),
> > or did you set some b4 git config :)
> > 
> > Thanks,
> > Zorro
> > 
> 
> Yes, actually -- I symlinked it. We could probably do that as part of
> this patch if you like. I can respin or you can just add it.

Thanks Jeff, but let's skip this for this patch for now. I recall a previous
patch wanting to add a separate "scripts" directory.

If you want to see if more people actually need this, you can send a separate
patch to discuss adding this symlink, along with a doc update to explain its
usage :)

Thanks,
Zorro

>  
> > >  tools/get_maintainer.pl | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/tools/get_maintainer.pl b/tools/get_maintainer.pl
> > > index 671ffe26a799..02c02eea3e67 100755
> > > --- a/tools/get_maintainer.pl
> > > +++ b/tools/get_maintainer.pl
> > > @@ -31,6 +31,7 @@ my $email_fixes = 1;
> > >  my $email_list = 1;
> > >  my $email_moderated_list = 1;
> > >  my $email_subscriber_list = 0;
> > > +my $email_git_penguin_chiefs = 0;
> > >  my $email_git = 0;
> > >  my $email_git_all_signature_types = 0;
> > >  my $email_git_blame = 0;
> > > @@ -228,6 +229,7 @@ if (!GetOptions(
> > >  		'git-blame!' => \$email_git_blame,
> > >  		'git-blame-signatures!' => \$email_git_blame_signatures,
> > >  		'git-fallback!' => \$email_git_fallback,
> > > +		'git-chief-penguins!' => \$email_git_penguin_chiefs,
> > >  		'git-min-signatures=i' => \$email_git_min_signatures,
> > >  		'git-max-maintainers=i' => \$email_git_max_maintainers,
> > >  		'git-min-percent=i' => \$email_git_min_percent,
> > > 
> > > ---
> > > base-commit: 22348afe338c0f6d540c0d7ef0db749eaa51b218
> > > change-id: 20261027-b4-5ff755f4716c
> > > 
> > > Best regards,
> > > -- 
> > > Jeff Layton <jlayton@kernel.org>
> > > 
> 
> -- 
> Jeff Layton <jlayton@kernel.org>
> 
