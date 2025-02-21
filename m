Received: from flow-b5-smtp.messagingengine.com (flow-b5-smtp.messagingengine.com [202.12.124.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C991DA612
	for <fstests@vger.kernel.org>; Fri, 21 Feb 2025 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740154048; cv=none; b=UZJ7uZuGv6Yv1HjXh/PtIkhQ+r+dCOJQGq4rGXhuTQ9ddgHbw5GDkpI6uPfjiISq4m8GhFCo+tiiiiac2apNuLLqyJYKog4ygEDFm2sTp0si+aCg4ktkDInwMq/SMbEzEco09qhILdq2sN1dknCLUk7FYi2LXyM46/3Wqtw5bKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740154048; c=relaxed/simple;
	bh=zfZxcEgLTZg425ATARSP1iuVZP3LL5C43vGbuIMf42g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pctltQdg6gC9xjpBMLf3kQG2eXVoePNfXH4KuRAE6OUbXCW0/J3/FfPJ9Y3WefFV5vmdfJnatVESBqbWnuhAV5Vac9DH9bwZwRjWURINexqoyF1kiauLZNsYzbh8bP0ee/A14854PvngtfjkaKgZX2ik211ScN/Db0p9FBP0lrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=iIiuhipq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nFwAipYF; arc=none smtp.client-ip=202.12.124.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="iIiuhipq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nFwAipYF"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id 7358B1D40D8D;
	Fri, 21 Feb 2025 11:07:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 21 Feb 2025 11:07:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1740154045;
	 x=1740161245; bh=vmZJDadksA7HpG1aHfiwdTLUFfG7D/BxjWAbWUPZ0ys=; b=
	iIiuhipqJzBtwEzW/qHxb2wECs2QD5ofpMt0hS0gzZyHNs8IFGDSN3JcHsUKaXOb
	5ynNz9qROyQBnH3ONKXfeuDWXWboeyHcPaYVeM1vbQ38/tCOj+fzxnOPBWnxQaaE
	3fv8ePvjt+CiVJusnd9eu0ha+1LVa8fUv8TXjfTaFRwlhw/IrxMzDcGSCY21TbRa
	UX7WI+Dquttrk36YrbT8c1Sdf1R8yLgYikvGdc7Qz86nybtBmIqKyrQRbFWeXjuT
	qZUH1Qqgx8aD4wTIGIrn6irJRBd+cGunPZJeOP/DPmR4znszI1XKvUHgq3PGU6ZM
	YzxbbQsEtEi/qRk9DzsEoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1740154045; x=
	1740161245; bh=vmZJDadksA7HpG1aHfiwdTLUFfG7D/BxjWAbWUPZ0ys=; b=n
	FwAipYFQRc4ZS/vaDm9mJtCySNFIL0tJ11MiEdHvSCFbkyaoSLGqkH77sfPPtBod
	qW0uT91uPwSNb3NTe6JAsZFi/Q/QgFf29QUFz+5N3fvTAx4+cPdY61mGIPGyvlDU
	3ncNgqHFttIfa7kfN1ZPlQX74OBIPG3bZjl+flsju1OazBLlvdALMUfQIjisjLIt
	IXo8JL6YyLIEGUN6nbdU9nrmaOmKChy/7j3Cd8Rk5YLAxnLn5rtRbG9K415E91aq
	c4XyUApvlyNEHmcbRg4FgYwBaPgIHgP1V65j10daEPAh6SvcJ/0kiUO3EYZHQKPJ
	BZlFSg1q4Rg1wEre7d2Eg==
X-ME-Sender: <xms:vaS4Z1Jz731bMChs3A-tW6YpEAuNZuVycaY9op6YWgX-d-lsNUWbRg>
    <xme:vaS4ZxLiHXTCVMEnpewS6zbkpyRiJpS2BtGyP8cdvJVWwIFC4tEFRYk-Napxk3Dd2
    bNfTiwVAX-Qzy8660A>
X-ME-Received: <xmr:vaS4Z9vFzUWcq-EbrKc7CA7pK_SkwE9FqlTz-kk8fO4vExVdLioKNU14kheOxxHY429Olrb9iJG_r8FN5uR5As-8rGbSWg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdejtdeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttddv
    jeenucfhrhhomhepgfhrihgtucfurghnuggvvghnuceoshgrnhguvggvnhesshgrnhguvg
    gvnhdrnhgvtheqnecuggftrfgrthhtvghrnhepveeikeeuteefueejtdehfeefvdegffei
    vdejjeelfffhgeegjeeutdejueelhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepshgrnhguvggvnhesshgrnhguvggvnhdrnhgvthdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepughjfihonh
    hgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehsrghnuggvvghnsehrvgguhhgrthdr
    tghomhdprhgtphhtthhopehfshhtvghsthhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtoheplhhinhhkihhnjhgvohhnsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vaS4Z2ZsJy16l-wPq_NbX86V_SbwNdlyH_K-Ujot1bwmY-MtuQY4lg>
    <xmx:vaS4Z8aPeENqZ5YlLmsAm0UnbhMm_qrixWUvhlTr8fbcKkLpIoU1mg>
    <xmx:vaS4Z6C378rh15jH1h4JzMo3Ng5mzX6QQ5lWYllDOuSMKpYiEKpFWg>
    <xmx:vaS4Z6aAKEEYf5LpbPkqgbCXH1z38dHeXJ9Ia4SXMtfPv_4NkIlTZA>
    <xmx:vaS4Z3xefW4ShYgdcOt087q86fIy_DMLkIEuDvZBZ5dNqr-1osmEkOeO>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Feb 2025 11:07:24 -0500 (EST)
Message-ID: <6b3d50a5-d08e-4cbc-8835-333e1674396e@sandeen.net>
Date: Fri, 21 Feb 2025 10:07:23 -0600
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic: test zero-byte writes to new file
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Eric Sandeen <sandeen@redhat.com>,
 "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 Namjae Jeon <linkinjeon@kernel.org>
References: <b4d76883-e58b-4db3-b7e4-7ddeb5ec7f42@redhat.com>
 <20250213195129.GZ21799@frogsfrogsfrogs>
 <e2240afa-2335-4462-81db-410d0b10737f@redhat.com>
 <f05f9875-1552-4d77-8403-7b191da24141@redhat.com>
 <20250214040220.GA21799@frogsfrogsfrogs>
 <65457d9b-c435-40eb-9531-6fd23c48ae75@sandeen.net>
 <20250218173950.GL21799@frogsfrogsfrogs>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20250218173950.GL21799@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/18/25 9:39 AM, Darrick J. Wong wrote:
> On Fri, Feb 14, 2025 at 08:36:25AM -0600, Eric Sandeen wrote:

...

>> Ah, I see. No, the observable problem was an -EFAULT on the write,
>> and the file /does/ get created as expected. The test probably is
>> extraneous to the original bug, because of course open(O_CREAT) and
>> write(0) are two separate operations. I was just a bit over-eager
>> when writing the test.
> 
> <nod> Would you mind resending, but with the rm removed?

I can. I'm OOTO for a bit so it may be a while, but this isn't urgent.
I'll get to it.

Thanks,
-Eric

> --D
