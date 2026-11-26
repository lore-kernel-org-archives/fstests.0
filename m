Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710775;
	b=roAADr1S6U72PKpEhsoDP06ThzyKRk+4twjrxaOihQ7mTE63G0h0EVzUDF0v1NhG8r3A
	 uqHKSz28SIhI0esZW75bV1ZenN4ucdQp4ghf/Zt1Usl+WQw8/LdDq3VDwr+faZNdzq44P
	 C/xkZHTTia0p4CC8+nEO/T0t5+X+FDQRqZzSqQf/49HQrdiWcBfQ4Tg05DHWniW63Xbmz
	 YFMOXnrfHrWZYlqrV3Zn5QmQme0pUa5iufcwOpgCuWtk2VoQRS8jCXg5XOwhZeCpT3F96
	 k0pFALmvvREYm373BH/x4LxaQcb0IyM1nKuroYORzWT4LQAA+Q9QWj9AQYpdzHPP5DQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710775;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=xbZpAkp5szZuOrpZSlQKCHFQSwzcnQCErS3TR56FIg8=;
	b=m7QjH+mES2HlFU8fI8N6KmcXlSpiqqCiwuj6lCcdZivLrUMkq6rlLxM8PgCUQJDxKz51
	 rTB9Oz2CJOlJ0P575u2Eww0kupXW7igdLTWPslyoO2UWyZEtQzD29etvzLvVfeneEBkVc
	 pg7IC4x4Zt0V3IlVHlzVgy7NSspVbDRene+vgYYfq0aUsvXs4WgVg1I1yD6QwOPfZ26Gc
	 Fi8cy9DVrmWT2GlMbkhPvwAAW+8bXTLnZCB6BfBtTA7ADLTbey8sVcV3whIeQeHyK3bqN
	 QoO8dMOTDqnMSyWYAmXrVao9hvG5WzdkmGVhCT/RhVTYMcFAc5Cv51jb1jwmWkANuzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPksBQ0E;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE41606A31C
	for <fstests@vger.kernel.org>; Thu, 26 Nov 2026 16:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPksBQ0E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FFE1F000D1;
	Thu, 26 Nov 2026 16:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795710774;
	bh=xbZpAkp5szZuOrpZSlQKCHFQSwzcnQCErS3TR56FIg8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kPksBQ0EeXmqIB8WTz+0/07K2nOG8tgcs0NBDuaLGwxe4bAoHdUGYcbxhlyPZqdQ7
	 Cs1SqJ9wEg8YVHdVorZffuOEGy7r+I/Wxk14qhjLwKrkv4N8/g2UBGSNH+XaSpylP0
	 ToEKIfntkScc8vVIxY10Enz+uEIxTHaBxc7WTqCGpV5vrCrn5afwrNIzBvhNHxSnPz
	 0bEi5WiO3kCFLkZJd2FNnewPYzXbfPkGoma+rg1syAHcIoilHa5GgnGvKMprLz6rX5
	 zAVsCd+xXA4SamDBfNaPmz3iQHQ+aQlPsjyODH1etJsSn55nkF3JWpppneojmIw5Uk
	 k7n/xok9iP7gA==
Date: Fri, 27 Nov 2026 00:32:46 +0800
From: Zorro Lang <zlang@kernel.org>
To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fstests <fstests@vger.kernel.org>, preichl@redhat.com
Subject: Re: [PATCH 2/2] xfs/349,xfs/556: both these tests require online
 repair in the kernel
Message-ID: <awhad6V9h2NEbKra@zlang-mailbox>
Mail-Followup-To: Andrey Albershteyn <aalbersh@kernel.org>, 
	fstests <fstests@vger.kernel.org>, preichl@redhat.com
References: <20261124103617.4012647-1-aalbersh@kernel.org>
 <20261124103617.4012647-3-aalbersh@kernel.org>
 <awXw0TF3yf7pM_f-@zlang-mailbox>
 <awa6F8rKj-4xD-eF@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
 <awdT2Ox9WQZWFkq8@zlang-mailbox>
 <awgC2L0b9xRBTQy0@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awgC2L0b9xRBTQy0@aalbersh-thinkpadx1carbongen13.rmtcz.csb>

On Thu, Nov 26, 2026 at 11:12:39AM +0100, Andrey Albershteyn wrote:
> On 2026-11-26 05:40:24, Zorro Lang wrote:
> > On Wed, Nov 25, 2026 at 11:48:48AM +0100, Andrey Albershteyn wrote:
> > > On 2026-11-25 04:20:46, Zorro Lang wrote:
> > > > On Tue, Nov 24, 2026 at 11:36:15AM +0100, Andrey Albershteyn wrote:
> > > > > Both these tests run xfs_scrub without -n (scrub only, no repair),
> > > > > therefore, scrub tries to repair found issues. However, without online
> > > > > repair enabled in the kernel scrub exits with a message that online
> > > > > repair is not supported, breaking the golden output.
> > > > > 
> > > > > In the xfs/556 case, online repair will not repair anything but just
> > > > > prints a message that unrepairable issue found.
> > > > > 
> > > > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > > > ---
> > > > >  tests/xfs/349 | 1 +
> > > > >  tests/xfs/556 | 1 +
> > > > >  2 files changed, 2 insertions(+)
> > > > > 
> > > > > diff --git a/tests/xfs/349 b/tests/xfs/349
> > > > > index a03ab812dc9e..0940ced42121 100755
> > > > > --- a/tests/xfs/349
> > > > > +++ b/tests/xfs/349
> > > > > @@ -18,6 +18,7 @@ _register_cleanup "_cleanup" BUS
> > > > >  
> > > > >  _require_scratch
> > > > >  _require_scrub
> > > > > +_require_xfs_io_command "repair"	# online repair support
> > > > 
> > > > As neither of these two cases explicitly runs xfs_io -c "repair", I think
> > > > the comment could briefly mention why the online repair command is needed,
> > > > to prevent it from being accidentally removed in the future.
> > > > 
> > > > Thanks,
> > > > Zorro
> > > 
> > > This could be probably be better wrapped into
> > > _require_xfs_online_repair then?
> > 
> > Do you have any additional needs beyond calling _require_xfs_io_command
> > repair directly?  If not, maybe we can hold off on introducing
> > _require_xfs_online_repair in this patch, since quite a few tests in fstests
> > already use "_require_xfs_io_command repair" for online repair.
> > 
> > Of course, if more specific requirements come up later, you're always
> > very welcome to add dedicated helpers for online repair anytime.
> 
> The line:
> 
> 	_require_xfs_io_command "repair"	# online repair support
> 
> is in the test to check that kernel supports "online repair",
> nothing else.
> 
> If online repair is not supported the xfs_scrub will output
> different message.

For example, if the line above ^^ is the reason why the online repair feature is
required, you can say:

# If online repair is not enabled in the kernel, _scratch_scrub will output
# different messages and break the golden image
_require_xfs_io_command "repair"

Of course, feel free to replace this comment if you have a better explanation.
I just wanted to make it clear why a test case that doesn't explicitly run
online repair still requires online repair support. (After all, on the surface,
this test just calls _scratch_scrub, and by default _scratch_scrub should only
run an online check without actually doing a repair, right? ）

Thanks,
Zorro

> 
> So, how do you see it, should I keep it like this?
>
> -- 
> - Andrey
> 
