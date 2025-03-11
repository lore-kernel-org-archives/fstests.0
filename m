Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5DD78F5D
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741700323; cv=none; b=Tk5i5DzWHqiS5pYOOGED1lrHWM5ZSGY4U2iSUFkh/A8GPCtfKhIsuPKxjvhB5RqM6YJQ3fQg5Hxz+PMhpdYTcUFahDje6ljcN2/A02v4BOpM5y+BYx5UmwHYfI+Kqknh1HW5RlabrE+T2Ym0kkHbqBNDkrDVEYSd1PziBjlCm44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741700323; c=relaxed/simple;
	bh=mh7mW+cMkm1Z2cLY3sLee7n1Aa7D510LNjHxaLFdWuk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s03drxoWho0sIL3yNNZVYmjtjkpkfEGS1qpCOKlmcqcnae8kpdmHI1ezOkr+0QEa6EXVTBJZzfESSvRTwvknxS87WV+yzk8iCgcz0dhb59dJdJVO84zwb/i6V/DvLxfbecaW3ir0CyglXCupnd1nRDHdoa5V+ctiFa3QkQar8xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=kgbai7DK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I6FMEGJY; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="kgbai7DK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I6FMEGJY"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 00B3D254019D;
	Tue, 11 Mar 2025 09:38:39 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Tue, 11 Mar 2025 09:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741700319;
	 x=1741786719; bh=xAtHqgk8zVO1ujVF7K4wDSLE8UVtjzd7bO5aKvMKeyM=; b=
	kgbai7DKQrenopN7q0UqYHoN8gBsiiFEQfsnouWFXrxsSH/7cXee+e3CfaSW7zG2
	BQRqJd9DaQf4jbZSfnY/HcVrwuxTjQN8F8iYL9mRshws6xgQpDRI9AvNr68im0mO
	VAoynlQpMVcfDhsVqc1+nwFY8ZeHb6/ZHJM03FBs4bhxuYkYPiHLSjFFES6I/uBp
	pJa5X+SuXVNX2KF6EBZsvy5W7SAi69/abbxguQY+DgJ5ZCD3hDYwb4foGLlqdYC6
	OmpQGe+BjRw9Q8poAwvU14qgDLU8eCwrv3RnaJwQJAFeh5+H0RH526ibEVhySlcG
	aP96Ap6e3Kw7UbSHwHubAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741700319; x=
	1741786719; bh=xAtHqgk8zVO1ujVF7K4wDSLE8UVtjzd7bO5aKvMKeyM=; b=I
	6FMEGJYz8dkxPsue7hv6p6ImdaBdYN44s0gmVBOzj/M2sOguP4ZnawHX410T0iFn
	nubn/R/eB9Qdz/ZhwGzjOscIFC14LJb/+dZPWfohkBvO94Ez+ST097UZe1E4+fJK
	nEr2nGZUpyoTmVMnU6DOKzv7znyTYF2xIq1/DsiGm55eqE+MOJ0KFDLxp9s8oyaK
	mkVMNKNIfdmJTidQBzFtWqPPakDwP7KJgDD19L/nZ0RdkVanDQpwB17mif22TR6e
	89WO25CwnRaw8qRTkfUW+CphayjKO2VKfWQXxBM8ErDnr7i/KatXBBYoDw5PAI19
	vFZfqUacSFFr5WRR7gvfg==
X-ME-Sender: <xms:3zzQZ6TQYK_lJ79Z6JluiftW9At7OeaCY9fEETpQuWRi28KexeKPXg>
    <xme:3zzQZ_xJ0n7yDCofMtlIZCRFb7XVcOYLlyb-XAkO2RImarYacNXskfxO2WUrhA_dG
    s3kMWaeHbhmiZL9qSw>
X-ME-Received: <xmr:3zzQZ31AsqHoyymj3Aw0YBMRS19uZjRu1ATBnvxoZYDvJsLG8dPEL5YsNcV1Uw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddvfeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnug
    gvvghnrdhnvghtqeenucggtffrrghtthgvrhhnpeevieekueetfeeujedtheeffedvgeff
    iedvjeejleffhfeggeejuedtjeeulefhvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhn
    sggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehhtghhse
    hinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohepshgrnhguvggvnhesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepfhhsthgvshhtshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:3zzQZ2Av9RwlrWolfOLDqru1HXxjnq2bQY8BQh-H5JdTQCNDVOuSAA>
    <xmx:3zzQZzgwucXl0KNDa1o87YEr8x9SXr-wZgpy4iNI4iD6Xbdqtih3IQ>
    <xmx:3zzQZyp0shW0awpBiWXdDm0oyB6-JVh106Rv2Y6Rlgn_eIDLfLq3sg>
    <xmx:3zzQZ2jDrobyTFmx9EPfKDMH7s_V7NimltrpFi7zcX7WN1FBvOn30w>
    <xmx:3zzQZwt14WefS1rtickUsIx0Ef0fB7iJF41gi5h9jSJJ3zeSD26CZBC6>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 09:38:39 -0400 (EDT)
Message-ID: <d7361298-b038-46c5-9691-7b1722b2778a@sandeen.net>
Date: Tue, 11 Mar 2025 08:38:38 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/rc: use getent when available
To: Christoph Hellwig <hch@infradead.org>, Eric Sandeen <sandeen@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <52747027-2915-4c92-a6e9-b0dce1cbe198@redhat.com>
 <Z8_pY1N6Pccsz5K3@infradead.org>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <Z8_pY1N6Pccsz5K3@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 2:42 AM, Christoph Hellwig wrote:
> On Mon, Mar 10, 2025 at 12:55:51PM -0500, Eric Sandeen wrote:
>> Zorro noticed that on systems using nss-altfiles, some tests failed when
>> trying to parse /etc/passwd directly. The "getent" command does the
>> right thing in this case, so let's use it as long as it's available.
> 
> Are the reevant systyems where it does not exist?  It seems to come
> with glibc and apparenly has for a long time.

It's impossible for me to know whether any systems exist that don't have
it, so I erred on the safe side to not break things for anyone.

(i.e. it could depend on packaging etc, and I simply have no idea.)

-Eric
