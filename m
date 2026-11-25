Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642323;
	b=yaMTvRqj6i2SYV3nxTYwCI0dTSSxpZ8jNci0cR0QuxMtEWCtByBaz8I/YBZBMsjvN8EB
	 wIYIW2lPwdZNjrt9VRP5WtBTjfXfaSjiy8EwhbTxXhIv0tNM2vaQRCjTL2GvSQuV7PdwL
	 t2XRvewgAFeAD2GeqOQla+75bmovGrASzxu1+3RWx5fv+JjdbksH4wX0XRKy06ytQgmhC
	 jzHtf2+nGaUrVlhyWlN+gHIRrkFS6K2wyf18BR91AczBw+ngAtsGtSW/bgJv/JSo36kAz
	 NBW/rms9rvu5TKSZ+pET2tbwyiTj6U81F9rDSiYQstVzDbtqMKPhvlowQyiIN5/XUEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642323;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=adt8kMzu9vDyKuBydch38etJllhqG3yDIQpYyMUlwSE=;
	b=4WRMlaBaq+L2o+PDhnxIIHcw7G+yTG2akpd3DDVlJEDNq53uNCVqkWAtONgKo1uQkucG
	 SKKiWU2twNcnBILbcON55Qoy2bpSVh6SxwmqDmcs3sVP0uB8NTJIkKt13HrjM+3Rm3McI
	 aHsXoKDqqRqsqlKnpZ0yayeJVskwjneqVZlEWJBBNTJtM0cf8JIMQgZ1I8LW0TvP4n1B0
	 i92ERD4tnkgW88wuyihBYUzzKYMXTBjx7DuvTya7Y0zBDpHJpD8EXXFmlqYldn5jkkYRU
	 qY9EJpQngh3EQDQNtXTgIQEexsN4nSx7kfwxUr9CFWn0uua22IdUYllVnEJwPdWDKrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6f6nf22;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69EB606A31E
	for <fstests@vger.kernel.org>; Wed, 25 Nov 2026 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H6f6nf22
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C3BB1F000C0;
	Wed, 25 Nov 2026 21:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642323;
	bh=adt8kMzu9vDyKuBydch38etJllhqG3yDIQpYyMUlwSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H6f6nf223f1rvfDn15OThT9GuZC1QoGwJNQx+2SG+LWsvnXarEFi5gdET2q2OM+A6
	 wZx/441M2TCbTPvfmXSeylfqWo2Jy6iywzXo7jrSwwIc39FpdE1Rc96eAYE2iBY9m2
	 syFW1u0MlGFy2zqztqD0RCYGorzOlCMgqNKiQFL4AAs2p7wdQZLCHYlljqys29ELO9
	 7AcYoUTO8sr48g3uFrdTSeqqXLow3nkNNex+U/3lg3ZcIZeWQzJK7qrOXxFcDbmNz5
	 kYi+4yqqlIyb50tqQpYp3I4gpmsJSuiLB8X5+/5JuWY9dSG2gx2pKy8pSP+XxEMpx1
	 3OQTANR6iid0Q==
Date: Thu, 26 Nov 2026 05:31:56 +0800
From: Zorro Lang <zlang@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests <fstests@vger.kernel.org>, preichl@redhat.com
Subject: Re: [PATCH 1/2] generic/453,generic/454: add a hint for the missing
 xfsprogs commit
Message-ID: <awdTtBNTHHFC_Phi@zlang-mailbox>
Mail-Followup-To: Andrey Albershteyn <aalbersh@kernel.org>, 
	fstests <fstests@vger.kernel.org>, preichl@redhat.com
References: <20261124103617.4012647-1-aalbersh@kernel.org>
 <20261124103617.4012647-2-aalbersh@kernel.org>
 <awXwfJ-CuO7XpuzY@zlang-mailbox>
 <awa5ubRKXD95vs-l@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
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
In-Reply-To: <awa5ubRKXD95vs-l@aalbersh-thinkpadx1carbongen13.rmtcz.csb>

On Wed, Nov 25, 2026 at 11:35:50AM +0100, Andrey Albershteyn wrote:
> On 2026-11-25 04:16:22, Zorro Lang wrote:
> > On Tue, Nov 24, 2026 at 11:36:14AM +0100, Andrey Albershteyn wrote:
> > > These two test will fail with xfs_scrub before v7.0.0 which dropped
> > > warning about use of bidirectional characters. These tests trigger these
> > > warning and break the golden output on older xfsprogs.
> > > 
> > > +Unnecessary complaints about mixed bidi characters in a name?
> > 
> > Sorry, what's this question for?
> 
> This is the message printed in the bad.out (for anyone grepping). I
> can add a note to make it more clear

Sure, thanks!

> 
> -- 
> - Andrey
> 
