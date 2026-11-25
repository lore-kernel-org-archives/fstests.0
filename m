Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795642832;
	b=ODNCEbkT7OXX6DSQYsLkFcdYWCQdEToKRqHdzCLa+yH6fRh/3TQ59UUceXra5HhDsyjM
	 f0mWcv2u/GSrzvlrfeE19ivFZVNUDQoA+mH++22MxyKUOT46yteB4ALnLrY4ME6KQn6JW
	 urJfG7mgD+ANxTsQ3dt5g2GLYXFREucsXzHT6nR0ePgqRMEradx5lPgLR8kaCB/9vwIjp
	 Kszdp3a46767+FlfHSvSvSNkTu4uvsViks+zt5mDXoPSJ8pfVfeE+yYm1uZhCtcG4y/xU
	 vcRkjLajool2DxGbwZr50v7QiLspZ9M7+a1pp0pSiZ1ozqz/hbMlzfTxMFD8fXxkFsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795642832;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=7PZN27NEPcuEEbw99oeZvB9nB2zyv87jA8sLkTfMHv8=;
	b=oKez2CbYnL/+LK7pHB9/b3scSNMoIDUxiAKz0edGFr57NVZJlJrEhfnjzMUouuRL+QCV
	 cT3tctN2ir94bh1hmHHY+Kbbvt/lpWJ7N4JMHB0wtbH/AFE6XdDiolBoqJaqs0kt1Pk8y
	 b54Eoqf6rHUs9Hyo+232Tdz/cJu8VCLK2quJmvGkR7KbW2zFtGu6vvzrZT3DolECTOrmy
	 Bmo/atJk97WJaciTUMWrY/iKF3FAteoqQzrKvv890hrdFT99CiPDcj9WZI7pgdL0oIbet
	 J/EucYH0J+iweoySB2BCukQO/359xMZIPUUcbwOsObzM8No4uQiW7gcwfG2skzsKCwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UreaabDI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6218F606A31E
	for <fstests@vger.kernel.org>; Wed, 25 Nov 2026 21:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UreaabDI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A8281F000C0;
	Wed, 25 Nov 2026 21:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795642831;
	bh=7PZN27NEPcuEEbw99oeZvB9nB2zyv87jA8sLkTfMHv8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UreaabDIm45AWAoudln6L0uBhF55IdESVlQYfzOZCzBGdp8/mqNskIq+4co6tNfNP
	 i0VosktlD+NwugRm+EH7NAE0C3Cwmn3s5PvapYRI2Hju5Kow+So8NChl5llujNDNMz
	 tU0bSSMa8G++0OwQtC+ZxpjwpvYuIH1d4TSU2AtTlT0wXBsMmCYqDpm3+NscLd5BxA
	 hhxRjqfzL0cUykG0RTHfWjKOkOfXGYiLHeO15rY77lFbHw7/52wDBJYslDujbHx+4B
	 PzsKrNmAngXVZhNyyN6MUAa72hmchMfsfGeo4TruBzLwzRwrH2sXntgRBAm8A/WT2E
	 CgkWMg4UWjR8A==
Date: Thu, 26 Nov 2026 05:40:24 +0800
From: Zorro Lang <zlang@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests <fstests@vger.kernel.org>, preichl@redhat.com
Subject: Re: [PATCH 2/2] xfs/349,xfs/556: both these tests require online
 repair in the kernel
Message-ID: <awdT2Ox9WQZWFkq8@zlang-mailbox>
Mail-Followup-To: Andrey Albershteyn <aalbersh@kernel.org>, 
	fstests <fstests@vger.kernel.org>, preichl@redhat.com
References: <20261124103617.4012647-1-aalbersh@kernel.org>
 <20261124103617.4012647-3-aalbersh@kernel.org>
 <awXw0TF3yf7pM_f-@zlang-mailbox>
 <awa6F8rKj-4xD-eF@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
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
In-Reply-To: <awa6F8rKj-4xD-eF@aalbersh-thinkpadx1carbongen13.rmtcz.csb>

On Wed, Nov 25, 2026 at 11:48:48AM +0100, Andrey Albershteyn wrote:
> On 2026-11-25 04:20:46, Zorro Lang wrote:
> > On Tue, Nov 24, 2026 at 11:36:15AM +0100, Andrey Albershteyn wrote:
> > > Both these tests run xfs_scrub without -n (scrub only, no repair),
> > > therefore, scrub tries to repair found issues. However, without online
> > > repair enabled in the kernel scrub exits with a message that online
> > > repair is not supported, breaking the golden output.
> > > 
> > > In the xfs/556 case, online repair will not repair anything but just
> > > prints a message that unrepairable issue found.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > ---
> > >  tests/xfs/349 | 1 +
> > >  tests/xfs/556 | 1 +
> > >  2 files changed, 2 insertions(+)
> > > 
> > > diff --git a/tests/xfs/349 b/tests/xfs/349
> > > index a03ab812dc9e..0940ced42121 100755
> > > --- a/tests/xfs/349
> > > +++ b/tests/xfs/349
> > > @@ -18,6 +18,7 @@ _register_cleanup "_cleanup" BUS
> > >  
> > >  _require_scratch
> > >  _require_scrub
> > > +_require_xfs_io_command "repair"	# online repair support
> > 
> > As neither of these two cases explicitly runs xfs_io -c "repair", I think
> > the comment could briefly mention why the online repair command is needed,
> > to prevent it from being accidentally removed in the future.
> > 
> > Thanks,
> > Zorro
> 
> This could be probably be better wrapped into
> _require_xfs_online_repair then?

Do you have any additional needs beyond calling _require_xfs_io_command
repair directly?  If not, maybe we can hold off on introducing
_require_xfs_online_repair in this patch, since quite a few tests in fstests
already use "_require_xfs_io_command repair" for online repair.

Of course, if more specific requirements come up later, you're always
very welcome to add dedicated helpers for online repair anytime.

Thanks,
Zorro

> 
> -- 
> - Andrey
> 
