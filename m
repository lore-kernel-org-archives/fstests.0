Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47C443169
	for <fstests@vger.kernel.org>; Thu,  1 May 2025 13:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746106025; cv=none; b=qKIamXv8j8qWKQV2DfWQo3IQCFX7ESEDMuxWqsA0wGcN1mOITLA+Ld8Yro2L8D0sZLYf3Lci/tpL8KzkV943ZsHdKKY9OftYnstR5m62Ti0JCrzalMWoBsDoZciZ6fdTSgxLq/oPXACZarbAutd9cGaRW01TQhBnDXP2pDyMT6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746106025; c=relaxed/simple;
	bh=qOU+THKGYsrY4YMTTE1H5Tw2Rt8ppWKM+/yndfaaoOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EaV6I+PgQnmQ1jFBMf2iQGUX0bBWUW4qlRURwSWEMGWdsptiYbjSlKnJSuq8Zj99C5CJD02Ljr0kb0rF9fVUIQpdtq98FMEuFCM2R7E2WvFYoybSQHGofjGaZvK1eCR4VwrQSmd5XKDPmU4b/wn1tdA5gLOGAo13/Cjnmuo0N0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=GqNXPi14; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=feYCgTRf; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="GqNXPi14";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="feYCgTRf"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D963125401D4;
	Thu,  1 May 2025 09:27:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 01 May 2025 09:27:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746106021;
	 x=1746192421; bh=k7fM3fv92OcrYO6Tbquuitug+2SYEXqjrTKqj++o7Y8=; b=
	GqNXPi14ZWX63kR9ipX6p0hoGBP4IZnOG2sr7ryEQV79ecIn45DG+XPjnhczP7sK
	K+f/bTJIYp59EEsPn5aX+7YRFuu+EDi/3LDlj173EsviWk37voiU4DX09wV0KIO6
	TP3oiyxaQyVpdCqwW3PHoRfz45soePJzMz9XtEEHTRzDYVE3Aw5SbLoYI0j3nql6
	AgBg/LUMT730hauNWpk4kA0INrXZaWghV9TEOADa0cN2QKGHENaLfMM6RTBsMPZo
	Wacwbyd8e/UpkjN/AQzjSP7Zs9zxLwkXyBdqGTCpGsBSWu4G+RcI9PkooHO/MISW
	9aEguROjSoIEttGb9Cf8jA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746106021; x=
	1746192421; bh=k7fM3fv92OcrYO6Tbquuitug+2SYEXqjrTKqj++o7Y8=; b=f
	eYCgTRfmA/8s7J8MD6epTsj0ZdZ6it8fQXFQBkl+2aR0TiNBb98reuIS/e6pz8MD
	E+0vlgZhjstxz/o7DBIasRBugL3TPM+6mG+QEubwMmTWJygH/iK5S9iJZaY5yKtJ
	TYfL4wOYUwoQlz/Kkdf8PnXobXQd6tgcYD7OdsoAvP0KZr6wAreHi+L7vQzUtyo2
	U4iY8zez1g7y7a0jjh+ci3fNS76qe1TcVkmRHFbfjuAbMY4DnYDysD1dMent15w1
	OHMLL4ytKFyDlmqHY2E28b3r7XXX4dLbxGgpGYWixUgQQJT9KFRj3ZQqyjuimE2a
	WbE4Ybi0Vj+79osEqg5xA==
X-ME-Sender: <xms:pXYTaAlGBsyXcMo0tQUJr-7YOSw2AzXlXHDcsL0hUReXRznaf_BwCw>
    <xme:pXYTaP0D2icWsfjo_YTmx8N9onxUFmTOwuUaPo-CC9gxyI_c1mLTLv2qWewicClo8
    dgfvhl0N5bENDkYsEQ>
X-ME-Received: <xmr:pXYTaOpYBeK1UUmLIeAuseMp6e5DOnrn0fC_JLzF--qJkxvKB98lcx6xs1K89Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieelieelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnug
    gvvghnrdhnvghtqeenucggtffrrghtthgvrhhnpeevieekueetfeeujedtheeffedvgeff
    iedvjeejleffhfeggeejuedtjeeulefhvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhn
    sggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeiilhgrnh
    hgsehrvgguhhgrthdrtghomhdprhgtphhtthhopehfshhtvghsthhssehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhmohihvghrsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:pXYTaMmDxDJAiZf7f5hQfwFS48uEA6xz7jDLzEej58mYER3e05j-Dg>
    <xmx:pXYTaO12ojMIxC4wWUB_glZxTpEyEqnJa6TR2ILNdf_E-bKS70T1hg>
    <xmx:pXYTaDstaJx89_D1O34qK9zSDRrIfh6hrYZ1z1B5zzmDH0t0zZbd4g>
    <xmx:pXYTaKXV_3-Ww9w-nRIC9kESy7j2-sp6DRTUYbsVppN4oX-4M75jJA>
    <xmx:pXYTaHW2KXVXpmivrJENBbVxbSnfSWuA00AbkpWbDYl80hg1W7PyRr1a>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 09:27:01 -0400 (EDT)
Message-ID: <c23fd44e-e07e-4dd9-8641-c94a5935d9df@sandeen.net>
Date: Thu, 1 May 2025 08:27:00 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic/126: Do not run if TEST_DIR is sticky and
 fs.protected_regular enabled
To: Zorro Lang <zlang@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 Jeff Moyer <jmoyer@redhat.com>
References: <51ac35ec-1f3f-45d9-9cef-1ee424a9f9fe@sandeen.net>
 <20250501090136.r46dwhzg3eshupkl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20250501090136.r46dwhzg3eshupkl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/1/25 4:01 AM, Zorro Lang wrote:
> On Wed, Apr 30, 2025 at 05:10:36PM -0500, Eric Sandeen wrote:
>> generic/126 fails in somewhat mysterious ways when run on tmpfs on
>> systems that have the fs.protected_regular sysctl set > 0, because
>> tmpfs defaults to having the sticky bit set, and this causes
>> may_create_in_sticky to fail when the test tries to create writable
>> files.
>>
>> To fix this, _notrun the test if TEST_DIR is sticky, and the protection
>> is enabled.
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
> 
> Hi Eric :)
> 
>>
>> diff --git a/tests/generic/126 b/tests/generic/126
>> index 142d2bb9..007e4433 100755
>> --- a/tests/generic/126
>> +++ b/tests/generic/126
>> @@ -21,6 +21,13 @@ _cleanup()
>>  _require_test
>>  _require_chown
>>  
>> +# If the TEST_DIR has the sticky bit (like tmpfs) and this has restrictions,
>> +# skip this test, because fs.protected_regular changes expected behavior.
>> +PROT=n=$(sysctl -n fs.protected_regular 2>/dev/null)
>         ^^
>      What's this for? Do you hope to have PROT="n=1"?

dumb cut and paste but it worked...

> 
>> +if [[ -k "$TEST_DIR" && "$PROT" -gt "0" ]]; then
>> +	_notrun "test dir has sticky bit and fs.protected_regular enabled"
>> +fi
> 
> And didn't below commit fix the issue you hit?
> 
> commit bd6e01c81e2160ce660ad993091f30e6f718079a
> Author: Jeff Layton <jlayton@kernel.org>
> Date:   Thu Feb 20 06:26:38 2025 -0500
> 
>     generic/126: run it inside its own subdirectory

*sigh* yes it did, I guess the internal reporter ran an older xfstests
and then I did too, without thinking. I'm sorry for the noise.

-Eric

> Thanks,
> Zorro
> 
>> +
>>  QA_FS_PERMS=$here/src/fs_perms
>>  
>>  cd $TEST_DIR
>>
> 
> 

