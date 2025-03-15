Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFB2D26D
	for <fstests@vger.kernel.org>; Sat, 15 Mar 2025 14:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742047267; cv=none; b=qH73wVW2pt8/VYhQ6ecSvQT+2R7w31pAEhhjnucKBrsiZXdOhPLUy0ZszpZw2OKqN08T4Qf5rFk2xz3H+7vXseO6i0qRUICOCP95Xvj52qSr5EK9mmT9bLIpGDrJFqya9LQFn8U/sOZs+JPOBBQGkSghM+8N5YclRE49buI+/tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742047267; c=relaxed/simple;
	bh=HjM45nb8HrDNHtxM5SNdih5pnFUapem257q39rL2AlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hFooLQn7DBaG7d/PzEEEdTXWz+4071qW9RaUFOCmVgyYIhl0dglPSLXRn6Lu2SHUq7SoYKG9kSL2QzntZwKitlwhafeZqa8MIyD+4BLvIiV01DMekP7WQkk17/duH1JEyEruEuO99KZoTzohLT4tvanZ4UNah0T8j+ALjEREYY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=ocVpsBda; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zp4j81Xo; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="ocVpsBda";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zp4j81Xo"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DDB1211401BE;
	Sat, 15 Mar 2025 10:01:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Sat, 15 Mar 2025 10:01:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742047263;
	 x=1742133663; bh=ZLKKxOO+3GJ7KyNUb+IvoZFba8NRbnVWfC0xTQp9/AU=; b=
	ocVpsBdaP2SVpfNVVZcx7EmRfLykjf6YUURfnaVKfdsHIOFuFSJmqVeiR2XgFGic
	UVRPiB7fWpjKj2oo3Nmv1ibwDlD9TaQnt24TgLpMsH1OnGub6rqsFIcMVn7Q84RS
	JabeLBM+KYElD/Dj3NIfVeLrYwCIpO3kNZHFsmNKJzLuJO1yg/vKGSBB4dBuKjGW
	LUnZkDi+kVajh2NeUo51CfFahrKfMWCanH/eC54OmYXxgrtXNm640ZPh0zw3yJNY
	sNi8kfSm/4ZILjv8QoGbPBxUpZJ4ajLvdgH24hg71+H5OMv4oXVWwWs7y4rOkRLM
	6ldQtP7TATvNKPalM+dKPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742047263; x=
	1742133663; bh=ZLKKxOO+3GJ7KyNUb+IvoZFba8NRbnVWfC0xTQp9/AU=; b=z
	p4j81XoFiiIQub70HmGwteiOACDsUxptas9vseuhE0QMKh3DsN6wKqDzuqnP5mtp
	LEBvduFDUftvn9oVrhYo3PPUoDVotxsmJ5WcmKpijhgKeMr7EN9IKXvfewt4taEW
	0P5WSXn2npb2aES95uDFn+4yfpOhqhmDJa7WAV188GZWIVufgEB1r4ur+bxtbcDw
	am63GDYWcarARqwmR5ly+fusBS/AIqw520fd+NCD2MXxXeIKo90JwYeA1kl8r7M1
	+F1GW94T2AVmc3t3EBQZF8Hpe3ePGEVDmbZb4Ze50bYhVRf045CNIJOnyVtrNkT2
	7eVlpCsraeQBk+qIGQ8DA==
X-ME-Sender: <xms:H4jVZ4JCugUd65wURP7t2LspcfL_1-8XfCW9xsz_i20Gqw0Y2gCh3Q>
    <xme:H4jVZ4I53RvqLcXx7PdIXb-Yi9Jij6W8nMrbVnwoorLDL-Adjz5Aqs5_IJyozpo8-
    J3BhUgrckoxgSwgdVk>
X-ME-Received: <xmr:H4jVZ4ugFFYom7lFOueNkfMR1n8P4O0RlduGnLybFbIkfsT3D96lYJO9FxVT6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddufeefleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnug
    gvvghnrdhnvghtqeenucggtffrrghtthgvrhhnpeevieekueetfeeujedtheeffedvgeff
    iedvjeejleffhfeggeejuedtjeeulefhvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhn
    sggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiilhgrnh
    hgsehrvgguhhgrthdrtghomhdprhgtphhtthhopehfshhtvghsthhssehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:H4jVZ1apDP4W6DDBsXoctXDcsxAd9n-hYsXE7tuSRMTOEJvHn0sjFQ>
    <xmx:H4jVZ_YhE3cwmXdyZxojv_sy3LYTJWCdeCOU-WhVcHqSebzSi30MnA>
    <xmx:H4jVZxAWVwcXCoX3cYsUIAL0Nvw7GYpHmG8bwAEztJNlusvn-xg7iw>
    <xmx:H4jVZ1ZWRAcwh-KBHddL2exxk3qSz0cw3hjsJNZ3BouqhhM4wTqB_A>
    <xmx:H4jVZ-k36Komu1Hq7oKaUcsbkqe8jk7925eVIQAdp0NibjP8ZFsKgtUq>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 15 Mar 2025 10:01:03 -0400 (EDT)
Message-ID: <7d4441e9-03e5-4d0f-9c46-d2bb8dc1b124@sandeen.net>
Date: Sat, 15 Mar 2025 09:01:02 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3] common/rc: explicitly test for engine availability in
 _require_fio
To: Zorro Lang <zlang@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <3d35c97d-8c04-4d0b-b7d7-bc689edbc1ed@sandeen.net>
 <20250315043728.l7topnjhoyttemar@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20250315043728.l7topnjhoyttemar@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/14/25 11:37 PM, Zorro Lang wrote:
...

>> +	# Explicitly check for every ioengine listed in the job
>> +	for eng in `sed -n "s/ioengine=\(.*\)/\1/p" $job | sort | uniq`; do
>                                                            ^^^^^^^^^^^
>                                                            sort -u ?
> 
> If you agree, I can help to change that when I merge it.

Sure Zorro, that's fine.

-Eric

> Thanks,
> Zorro
