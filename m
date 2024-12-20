Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35200216399
	for <fstests@vger.kernel.org>; Fri, 20 Dec 2024 15:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707523; cv=none; b=eLiFRE2fWTOCEzooSPKY/az3KCR45ObVUyRCqpxps5ay50iBeP5zydJ+64s+Ei6eaIgvHCqb1522b7ehvZvdfp4p2eF5CY/rNaA6uSzshotHMu2kFYtNz7Rrr2hXFDcKFqe7zTDxpnujx1V48L0Y9cfl8vHhBBPRZkzwiDmHrH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707523; c=relaxed/simple;
	bh=WIBQVwkqWOPywQPO2x+mbHP4jvJY/EvvYwMGNjIGIgg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UvmNLmrqz03oSECOGYuX5qoNziW2a+mM79wH/wgqQ5IQaV5yuThZnXyDcPUyGHPQTILEeouu39TMDT2KOyYOuyfd/qitkEkbpSQHoK3nbCu/R+ylwlsJjqzCWlSFtzho3oacDjFr5UdbOku61x89/TkM8bfy9unBqvaE6zP0lsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=EEBraCam; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SFenpr3S; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="EEBraCam";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SFenpr3S"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 367F91140146;
	Fri, 20 Dec 2024 10:12:00 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 20 Dec 2024 10:12:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734707520;
	 x=1734793920; bh=WIBQVwkqWOPywQPO2x+mbHP4jvJY/EvvYwMGNjIGIgg=; b=
	EEBraCami6fAks9fFCSvyO/rvhJymMopCUxvr1+KKLfOo9jchjZ0I21A4oUtQpTB
	XbX30xrK7ICZH6PFEPE5BAR1sU9d3HpSuRoUTP5jhZ2ToWPu+Dd/ga+3rh+K3UVN
	Xab8F7Aag56T5VzSzJT5Mv3yPQr4B4D2b+PZ/1DGfrggkKPMht9b+vGI/RRHos65
	/NH309j5CNcLnqVTF9Wl8+5Vb9PUDf8RMjuwhvpLF2bJ0XHuZ4xXnt0gGI5Uac8J
	hWGtRCMh1y/5s/VE7AL9xS81+pSK5AaiDMjoPxvKD6cgyj7cDLYhM7Mmrep4xRO/
	XqU3pDpI8HE/mo2t4jLMug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1734707520; x=
	1734793920; bh=WIBQVwkqWOPywQPO2x+mbHP4jvJY/EvvYwMGNjIGIgg=; b=S
	Fenpr3SGrfohQ1+b++fstGXdzSE0jZzNfAdcBFYPdga/Puj4+P80aplSGz186hmP
	NyGwgzOxkvIppo/2YjD4XPASYfQERW+QWSOF43ug56eQiOfjNNdV4du+rH+Mw3ut
	st8us5KIJGV7ZNAymzNI0vN9872Q7MeEviU8SsDua0hWcUVUorg5q667u61a2XD8
	ZDFziKiQ2jMmczeRX47PJbZnoM0NtY85q/vutrZWGyHv5IhfL/eSvxThFrvAsGPt
	6dfpf6h8Yr49x5BAGCrFSzBUITnm1cs9UsasIz3LoyRHS8TmKtdpogPZ7lhTz9jz
	0fQXYbLRYdoA0hy7XVx0w==
X-ME-Sender: <xms:P4llZ-s10reFwfX_R68byErORjP_AbllqIskYSVJrEWcdl5QqlD0eQ>
    <xme:P4llZzczjOcSdeJb_DwWemYa_w6GyyrNIcWulz9m7vMBl1LHeoPJLS9Dg6Trnj4sC
    HzCO_K9eNTrd4L30M8>
X-ME-Received: <xmr:P4llZ5yQyWwEL6EwXUOEfPzvxZYjskSDnUvFJM1ZUC4dB067D84pgPniLEhgv0TJlXztvTKYD_6iI_0UpyNynWNKTzM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdej
    necuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnuggvvg
    hnrdhnvghtqeenucggtffrrghtthgvrhhnpeevieekueetfeeujedtheeffedvgeffiedv
    jeejleffhfeggeejuedtjeeulefhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhnsggp
    rhgtphhtthhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegujhifohhngh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrvhhiugesfhhrohhmohhrsghithdr
    tghomhdprhgtphhtthhopeiilhgrnhhgsehrvgguhhgrthdrtghomhdprhgtphhtthhope
    hhtghhsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepthihthhsohesmhhithdr
    vgguuhdprhgtphhtthhopehfshhtvghsthhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepshhhihhrlhgvhidrmhgrsehorhgrtghlvgdrtghomhdprhgtphhtthho
    pehkohhnrhgrugdrfihilhhksehorhgrtghlvgdrtghomh
X-ME-Proxy: <xmx:P4llZ5MmckYYSUmYSEe6P04X46I8flm3FY_icmF-RSRoPvlrBsb9xQ>
    <xmx:P4llZ-9CCtNDY5gVR906uGlgk0F1LoKRzhBu1LpEyuhuan_odlRLHQ>
    <xmx:P4llZxXWu4pKaX2iWZzInReLTlU5K90PF5o98DRoAO-XHKyWfIXT1A>
    <xmx:P4llZ3eWStjOSxXn7EO-4dIwyfkeDDBPFXRdoftTFtY1Tc3LfbBD9g>
    <xmx:QIllZyTYrXC7sscxQQxJB67T55NDSW-9dEQd8OvL3W-xhguC7WN5t-Vq>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Dec 2024 10:11:59 -0500 (EST)
Message-ID: <0b37904f-7ab6-4b92-a9a0-30318fcadc4a@sandeen.net>
Date: Fri, 20 Dec 2024 09:11:58 -0600
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] generic/530: only use xfs-specific mkfs options when
 testing on xfs
To: "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>
Cc: Zorro Lang <zlang@redhat.com>, Christoph Hellwig <hch@infradead.org>,
 Theodore Ts'o <tytso@mit.edu>, fstests@vger.kernel.org,
 Shirley Ma <shirley.ma@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20241215051242.3340572-1-tytso@mit.edu>
 <20241215051242.3340572-3-tytso@mit.edu> <Z2EyG0vqtyTSyM5a@infradead.org>
 <Z2NL_oc5QSscZdZ_@dread.disaster.area> <Z2OxMQACnMgmBR1a@infradead.org>
 <20241219101626.ze5pqs3ub7izpoqr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20241219163206.GD6160@frogsfrogsfrogs>
 <Z2SG2HsqgA46kuAz@dread.disaster.area>
 <20241219225331.GG6197@frogsfrogsfrogs>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20241219225331.GG6197@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

<snip the latest grousing back and forth>

Gentlemen, It would go a really long way if everyone could keep a
few things in mind as we work together in this public space.

1) Act in good faith
2) Assume good intent
3) Don't escalate conflict
4) Own your mistakes

That's basic stuff. Could we maybe give that a shot for a while,
and see if we can reduce this misery a bit?

(If you took any of the above personally, please don't. I'm just
reflecting on what I think are some longstanding patterns, here.)

Everybody's working hard, everybody's stressed, everybody makes
mistakes. I have no desire to go point by point through some
of the many recent blow-ups, but in nearly every one of them I
think things would have gone better if at any time during the back
and forth, people had stopped to reflect on the points above
before firing off a reply.

Above isn't perfect and perhaps others have thoughts on basic
guidelines for communicating without conflict, but maybe it's a
start?

-Eric

