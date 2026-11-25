Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795602955;
	b=C+PIYJsCfpCMrrzPm2JN6T7/PZW2kmxco75Xy6AxY199a2UvV4gzhTHEBmgAhHQzAJnD
	 ZjiSfqCOuAZDvw53+F+JhTIPzH+IMqn0C0YwcDq/TNR8TTZrIsp8rnIXldOaetP0OSs1I
	 YZt4C5EgbrENL4tADjFVp0awNXs62S1XFhwijlPOoF58kYYXkfU5HYvACS/x1uwqUXI4F
	 M39sRvtM8uLxbpkW37BSWy7V6dCN0QrR72RorSxaKwiQh6VwyUeTptZz8rwQpFAasVtLo
	 y1VoGNldMokw6endhiLELvFziqdOEEodRxR4WIfbxITbX2afgtQ96uA1Usn7cqE9k7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602955;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=qgGkSV7ASFQBlAq1ANrqoqZfogiBnB4l4E4AlRFb8BE=;
	b=s3+xTtwVPNcoLuJ9aXXFm6qtl6uvDRjzYECqSLhqN7mwBo9PAGVDlCEB6gk0SlIMcQee
	 R0R/1OfeKJIF7priEz+htDKjCAh8AvyV6sd6MWTEA3gE62FasZme5VTCFf4PwC1KGmz8L
	 lxYjEe3dywbBFKkK64mLYxQqBYrsinBFOJsBdB6ThcBmj3o+2DmP81UsGbEv00qYBTzBx
	 2xbDrnFUoJN376jqVOkH6EP6mo74HAkXAuRb4BLbTGfDFLyuOMS9uk0YXjH/KjzFvnHih
	 FV2Jzs+Xca3+tNqSYXX3YFlSSOEVPlE5Am6KqEXd0CFEKFkeA2OUnO6pY6NI2K5/tFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FOVxi1G3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B31606A31E
	for <fstests@vger.kernel.org>; Wed, 25 Nov 2026 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FOVxi1G3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09411F000C4;
	Wed, 25 Nov 2026 10:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795602954;
	bh=qgGkSV7ASFQBlAq1ANrqoqZfogiBnB4l4E4AlRFb8BE=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=FOVxi1G3v7CWbwGceGU4t20Y+bgkrmuNDp9eXpDye08AEM3nd9NWKqfKK8GuJid7T
	 eJ4JG0rSgQuw+lK7eWBdFEDSX4e3lNwe6d1SteitfmLxajqPWj2+Tq9j4VI7uuELKG
	 GaqwqlywN9JrJ+2ZrDLM6FVlgPCRm3S8zDSmp1VZ8RTTMoWRDygpcKjBvEdAb81BOH
	 B4leK0mpKKx7rvZ18EiCv3vEJYIpxiPYLKsi6JL1sLkHICaMNtZXpIlAs20elgcgga
	 yJnFQIc8rhl72/UPQ+zS0HjrsWnEYS0uo58zLyfBwY1q6f2zagujo/FGdiS0Mp5iva
	 qHI0OWhHeJjhA==
Date: Wed, 25 Nov 2026 11:35:50 +0100
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests <fstests@vger.kernel.org>, preichl@redhat.com
Subject: Re: [PATCH 1/2] generic/453,generic/454: add a hint for the missing
 xfsprogs commit
Message-ID: <awa5ubRKXD95vs-l@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20261124103617.4012647-1-aalbersh@kernel.org>
 <20261124103617.4012647-2-aalbersh@kernel.org>
 <awXwfJ-CuO7XpuzY@zlang-mailbox>
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
In-Reply-To: <awXwfJ-CuO7XpuzY@zlang-mailbox>

On 2026-11-25 04:16:22, Zorro Lang wrote:
> On Tue, Nov 24, 2026 at 11:36:14AM +0100, Andrey Albershteyn wrote:
> > These two test will fail with xfs_scrub before v7.0.0 which dropped
> > warning about use of bidirectional characters. These tests trigger these
> > warning and break the golden output on older xfsprogs.
> > 
> > +Unnecessary complaints about mixed bidi characters in a name?
> 
> Sorry, what's this question for?

This is the message printed in the bad.out (for anyone grepping). I
can add a note to make it more clear

-- 
- Andrey
