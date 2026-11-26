Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795687962;
	b=e1NhyYxzTicoo5Zwo2Aj5G/Dq4au5FmDdfS8fIwdK8bA9sqkHko3ggE+EAFZzn7emnX4
	 tGY1p9StSYfNt+2wTK4cdnR2+FAN9e2ueDoGdX1KNCOYEWzZXtH0OamyVslA0RZDYm9vK
	 aC08U5yzwy4VcVHk4EtHBDSKuZ6o5ZJBLBbuZNXyFoL+Q0vcLTKK/FraSzgskHnMkYsgJ
	 l1v4xQlLxMeiLjR5obMw4Dd8Hj9RDbJFhH5/ytIqFOo702C7XYkveSJLLJeBU0gcP1ONm
	 +4YoBDRv77Sk0T5ugS8vFnKWIvm521JD31TFcl1pMM2MdSpkgvan9Y+MSr4rjUjNxHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795687962;
	h=Received:DKIM-Signature:Date:From:To:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Hy1UcbGT1p0Dwq9RVBSCLT4M+xfb3ysbFrNvdz/nYRc=;
	b=qmyNsOigK5NV+Ew+9Y62fSOY4GzjMp/cL41t3qFoBOwHV9SLK4Jbv3sbZDN3sqhCXBPn
	 a6VhpmQTNjuBej5v/OnFDjqoJ1ivzv4CPH0cc0kMPZKrmYC+HI8qdQkuQ47jpNr5ytYU8
	 fQDJWc76ZC2u/47hIoyNK8u4VEE9malRQiykQXJZWWMfSRLYqvQx2FHYM04VNJ/xV54/3
	 YjYPXKl4UwJYgHBQUG6R/QBrHqnVXx5xg+VHCXKZBAU1z+9XldgkIlFhByc41H6jnYz1r
	 ERqmpWZA1hofat3MmOWUll2rYVRETzk38Mq4uQDVJtbMEuSXjD0Hr0OJ/7dZKKzjZMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ViRVN4vU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB1D606A31C
	for <fstests@vger.kernel.org>; Thu, 26 Nov 2026 10:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ViRVN4vU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE33F1F000C4;
	Thu, 26 Nov 2026 10:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795687962;
	bh=Hy1UcbGT1p0Dwq9RVBSCLT4M+xfb3ysbFrNvdz/nYRc=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=ViRVN4vUTSUdrbrp+NiV/qgomh+OqQRiW78JvgUPraN8R7NXtwidr5P2N4Qtcg7Pk
	 gneBKgBDXVhQikUlsdPi5vvup1yNyoiaZ5DbUtc2AR+o/s+csfqx6gTLbWLED3G2t3
	 F9Mx8A2/ZqBsZ3Z8wkA55zVaKST6TupVOdOu2fsKfYjJE6ACMHfbmyylWVpkkG+OPJ
	 KLsuRI4pliJtEsnRDseWxjfdwnrqVX19mu8dw9chidy0Kza+d8UDJYPyrnSKyH38Bs
	 lS0on1SpBG4c3zPaE3ygpNyHtTj+fjh041FkZbG7j/oWvpau1Q6xAtxV3wwWP6JdKg
	 6NkC+XIiD5S8w==
Date: Thu, 26 Nov 2026 11:12:39 +0100
From: Andrey Albershteyn <aalbersh@kernel.org>
To: fstests <fstests@vger.kernel.org>, preichl@redhat.com
Subject: Re: [PATCH 2/2] xfs/349,xfs/556: both these tests require online
 repair in the kernel
Message-ID: <awgC2L0b9xRBTQy0@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20261124103617.4012647-1-aalbersh@kernel.org>
 <20261124103617.4012647-3-aalbersh@kernel.org>
 <awXw0TF3yf7pM_f-@zlang-mailbox>
 <awa6F8rKj-4xD-eF@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
 <awdT2Ox9WQZWFkq8@zlang-mailbox>
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
In-Reply-To: <awdT2Ox9WQZWFkq8@zlang-mailbox>

On 2026-11-26 05:40:24, Zorro Lang wrote:
> On Wed, Nov 25, 2026 at 11:48:48AM +0100, Andrey Albershteyn wrote:
> > On 2026-11-25 04:20:46, Zorro Lang wrote:
> > > On Tue, Nov 24, 2026 at 11:36:15AM +0100, Andrey Albershteyn wrote:
> > > > Both these tests run xfs_scrub without -n (scrub only, no repair),
> > > > therefore, scrub tries to repair found issues. However, without online
> > > > repair enabled in the kernel scrub exits with a message that online
> > > > repair is not supported, breaking the golden output.
> > > > 
> > > > In the xfs/556 case, online repair will not repair anything but just
> > > > prints a message that unrepairable issue found.
> > > > 
> > > > Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> > > > ---
> > > >  tests/xfs/349 | 1 +
> > > >  tests/xfs/556 | 1 +
> > > >  2 files changed, 2 insertions(+)
> > > > 
> > > > diff --git a/tests/xfs/349 b/tests/xfs/349
> > > > index a03ab812dc9e..0940ced42121 100755
> > > > --- a/tests/xfs/349
> > > > +++ b/tests/xfs/349
> > > > @@ -18,6 +18,7 @@ _register_cleanup "_cleanup" BUS
> > > >  
> > > >  _require_scratch
> > > >  _require_scrub
> > > > +_require_xfs_io_command "repair"	# online repair support
> > > 
> > > As neither of these two cases explicitly runs xfs_io -c "repair", I think
> > > the comment could briefly mention why the online repair command is needed,
> > > to prevent it from being accidentally removed in the future.
> > > 
> > > Thanks,
> > > Zorro
> > 
> > This could be probably be better wrapped into
> > _require_xfs_online_repair then?
> 
> Do you have any additional needs beyond calling _require_xfs_io_command
> repair directly?  If not, maybe we can hold off on introducing
> _require_xfs_online_repair in this patch, since quite a few tests in fstests
> already use "_require_xfs_io_command repair" for online repair.
> 
> Of course, if more specific requirements come up later, you're always
> very welcome to add dedicated helpers for online repair anytime.

The line:

	_require_xfs_io_command "repair"	# online repair support

is in the test to check that kernel supports "online repair",
nothing else.

If online repair is not supported the xfs_scrub will output
different message.

So, how do you see it, should I keep it like this?

-- 
- Andrey
