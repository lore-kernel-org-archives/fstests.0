Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626891D88D7
	for <fstests@vger.kernel.org>; Wed, 19 Mar 2025 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742403273; cv=none; b=EL+SsTUMeWBkZexuKcv/QpStnXZN5LlWaNILaNo/MRBmLHn4W2zdvxh11bqgYiR3xTQ+g97ZphngDqDzAeoFz4f43I8mfGokeU1956Zm3WpvrF2NIiy2NMuL+qHkdF6Zirc9ZwDNBCKsoQ3N8fUw5yN+RhRmOkOIZ/KOOtymceE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742403273; c=relaxed/simple;
	bh=4wtH+YYuJvQ+2yioXTGZtlN0FZxGBTk9wq4kUrCiwMk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j988gkstrQhQ2G5HPy9Vk7Es4IyVt100ultAzBIz4alX7ZuJuyEhzDq0sKe5QeFom53blDRWYPlgvu2yaGqvGANoaG2PsD39AZbsv/GyQL3Q+aOy+bJF697RJE42tMge2DqzxwoLtVgpvFyoYRdKyO2KjtxWOgyn+1JiA3FEDS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=dcpN3PwG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=0DNLXfNH; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="dcpN3PwG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="0DNLXfNH"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 566512540118;
	Wed, 19 Mar 2025 12:54:30 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 19 Mar 2025 12:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742403270;
	 x=1742489670; bh=uI8Fyw6EjAXbH+Jfu+D8oW9Y25T4UvKKRao6P0AW1DE=; b=
	dcpN3PwGOpbQgDXmEyCTNHtsBzC9/tYgPSxL7lZxeaEIlvTBVlYOQpo08+fWN6UJ
	3+/Gcd+pSoobGvFhwpypP5orRM4vVgSX9RFtK7xxsg6ZuzEr+Vo15Zou1DbBU+N2
	G6hKVhYQvoBK7IRdcWE5mD9/hMfC/4OLGlzqnFb4LRnj+Cjw1VYtH86lOp6stjgM
	2s7xx+RscUtw6Ht+jrHSjY/uaQcVMt28DvEjAv2dBIH5BdeHa1d2oinDcT5dUPyc
	egJaQlVanlCo3hHTkHha5dQL0LB1Sjx092Du0rJZ47WiVu7+ls5oKkLjw1qfIMcx
	0NtyHd6FUIdyEJxy7CbbmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742403270; x=
	1742489670; bh=uI8Fyw6EjAXbH+Jfu+D8oW9Y25T4UvKKRao6P0AW1DE=; b=0
	DNLXfNHLW45/eKal8s0G9KUQf2HBOnF4weKaLubYl8HFL1F4bi9RoCMDvGLgKcNt
	u0M8MgMQD1GJJpOnXYdpdTMb0sHmk/Z21fC8JeCFPq/hk82XFRqY12uo4aD3vsdM
	MW5ljeEvLNEzI8AvzdMwn125oww1aii9KjKj7+TcxVsDNImWeL9PDc9GjQ0K5rLF
	Ou7yJIz80vQq9/AB4SMe4ra7+LnJu31F5fY2c0KtZtr4cbBC2oMM4djst0L595KO
	ry94i4QKl6Hx63Y1FzzOHPV/+DsDB11shh3SRprH6fsfp8TIpgAPheu+LbAU2GU5
	Y7i4KB/x070aD2kdYI9HA==
X-ME-Sender: <xms:xvbaZ98rjqSyC_k4TThHDL5eJMGp1S3fJKjf2KRpZ3wN2kUnCXrEcA>
    <xme:xvbaZxskfecCclGwId-gQSzN5fcThT_RV3nEY5QL7ReW0nYy87JOAuH5kpbDVroLJ
    HMNtNV9LLclDc2ymaY>
X-ME-Received: <xmr:xvbaZ7D5_KgafvDSZrBFhBh9AbGnk_y07uJzmYVm74jwwuyPUoLNHP2FvmwAlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnug
    gvvghnrdhnvghtqeenucggtffrrghtthgvrhhnpeevieekueetfeeujedtheeffedvgeff
    iedvjeejleffhfeggeejuedtjeeulefhvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhn
    sggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehthihtsh
    hosehmihhtrdgvughupdhrtghpthhtohepiihlrghnghesrhgvughhrghtrdgtohhmpdhr
    tghpthhtohepsghrrghunhgvrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhsth
    gvshhtshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:xvbaZxfcLU9wXhfE3n51IycTuRDm0XI76qQGDxJbidtPwIeB_R7OFw>
    <xmx:xvbaZyMku_2oakNVrMM0seEAWWRhy_encN_i08J-ZFD_QZehcyTgWw>
    <xmx:xvbaZzlxUFaYSSwd0nLiu7khfGg9aFqrxVJ6hxRVHxBghCZslX9VtA>
    <xmx:xvbaZ8v8Ikd2MCFqfftzFJSir8V_uc3VQSP4PY3g8-ZTBI5LGP51CA>
    <xmx:xvbaZ_o5zdlFMsxkd2slCjxQOyvI4fJpPn06Rq03dRnYTbLVjPhdcvPA>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 12:54:29 -0400 (EDT)
Message-ID: <5d1397d5-b8ae-42f8-b323-e7fbf66d929e@sandeen.net>
Date: Wed, 19 Mar 2025 11:54:29 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: generic/699 fails on ext4 due to using ext4 mount options w/
 overlayfs
To: Theodore Ts'o <tytso@mit.edu>, Zorro Lang <zlang@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>,
 "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <c46d8caf-053a-4af1-b562-7ca7203cb926@sandeen.net>
 <20250318235116.GE787758@mit.edu>
 <ffed04f3-5743-4a92-9b2c-20887c04a4cf@sandeen.net>
 <20250319151144.3r27tjgenbzty5tr@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250319153902.vn3xcttrrytrkfx3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
 <20250319164410.GB1061595@mit.edu>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20250319164410.GB1061595@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/19/25 11:44 AM, Theodore Ts'o wrote:
> On Wed, Mar 19, 2025 at 11:39:02PM +0800, Zorro Lang wrote:
>>
>> I've forgotten why I left g/699 to generic, not in overlay. Maybe
>> Christian hope to run these two cases together in one FSTYP test
>> round (don't need to run overlay test once). I'm good to move this
>> case to tests/overlay/, cc Christian to check his review point.
> 
> I had assumed it was because we might want to test the combination of
> overlayfs with a variety of different underlying file systems?

don't we already get that with ./check -overlay while the fundamental
test/scratch devices are formatted with the underlying filesystem you
wish to test with overlayfs?

note that AFAICT generic/699 is the only test which explicitly exercises
overlayfs outside of tests/overlayfs/ ... (right?)

-Eric

> If we move this to tests/overlay, I'd still be able to do this kind of
> testing via:
> 
>   {gce,kvm}-xfstests --primary-fstype {ext4,xfs} -c overlay/default -g auto
> 
> This allows me to test overlayfs with the underlying upper and lower
> directories being either ext4 or xfs.  (I could and should extend this
> to support other base file system types, via some minor changes to
> test-appliance/files/root/fs/overlay/config, but I had never gotten
> around to it.)
> 
> How do other people who are testing overlayfs handle this?
> 
> 						- Ted
> 							

