Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07130255E37
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 15:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741707900; cv=none; b=MFG+5WzZ/5J2hqy+7EEMhVJjvFzatLJdakazNj0+vvb4xHEOAgQe9Aawrzrq/d5q1Nk0IHz/2c+RgMyxc6av743MFBQnj4Kdg0NTA1rSwcQ4sL7kvI+vaNltRQNFPmGYc9cYVkwvx2E7/Fbb3CxSRGAg/5/VjVxUDDXqipSdQ9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741707900; c=relaxed/simple;
	bh=cgkIu+3XxOmiwEaHWdrKPhmfx4faZR3QWschZj2oArE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMNcMYjs82vH0OSsb2Wzr/EGelCxuZ8O0Ker1xZsM+rPvwEEKvkG9VJvLRnReXlv50amq0G/SaRE9TIj3Q9kWroOeC1y63E8yDthCUntImyacO+WCmlosVMqu+0krw9twEykO4xemBlUllBtbknzgovGsLk/aBxux1CgEQg87Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=c3zk5dpM; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zwT9gGBm; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="c3zk5dpM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zwT9gGBm"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id B5F9A254017F;
	Tue, 11 Mar 2025 11:44:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 11 Mar 2025 11:44:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1741707897;
	 x=1741794297; bh=oH+yXkwdlLo0/ClEj/JR0Rg9OJbAvJxFhtYH9nPFK/4=; b=
	c3zk5dpMliRaagNga51DXM5Ub8cNd7491+wcS78gjwFvD2U4hxM3rLxS4F5wSsN+
	ROKz5ZOQ2jmYk4xVNj35kQUm0+2d9u9qcqwEkKxEK/MH3pmfbi71b9dVm+CdGDpS
	ksF1WbFxyyeuoGmAK60Nshelyk5ipw9A9g1rddS/YeX1UqIax/+0n6NqIt8CUvJ+
	QdMeRvCkcVpMEcFSkAqroqnfojZQCgcujKchbr8sGZVORemBiA2/NHHznTfwFPy5
	G+h5cmY6wnl1k92ZNvGvXE+m3taueP6tbd+RImvbC4WGx5PL3sJroBO5U5Q6O2AM
	L0DZu6rluboD2tVxup5VBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1741707897; x=
	1741794297; bh=oH+yXkwdlLo0/ClEj/JR0Rg9OJbAvJxFhtYH9nPFK/4=; b=z
	wT9gGBm3HsOhOKrfYKwfI+jFUuTFFbFl1008CBstrI8vMa4qjehRjWPfOI5PaDqY
	LM9t6rNTmlC0duDXLMbsh+K/hfU9aHDXsYa3eDMVoJ/gjRUUr+WudMAsKesB969I
	tBkr72wRvrQyrYy8oWodpVxAE0n4B8eoSP1Yi3aODVxLXAVX0ot4CTCl03RcobOk
	XOuGUM6VJEq3nZMPVHmaT8zBv/TFiIG2qf8k97l5qvvhgSCZigDpfcUm1SvLZtNG
	CC26l5ilEily7Qv3cLzyzA8Mu7Qcf2BUaIOIIDSpITMwfdQoNxUr7u5ccL/4kRYJ
	RwbK9+IPb94jDWFX3EqoA==
X-ME-Sender: <xms:eVrQZw2t-HE2nGVg81g68F5CX5WW4YJxUKIgJDgKqpWpXa3IOPw0aA>
    <xme:eVrQZ7F4TQjIDi3wHdhbl5-k63BIQxo_ApcxMYXPGbxber0AcM0oUyEyrNk9wqGTZ
    knfILoAXr0wCTwZZMU>
X-ME-Received: <xmr:eVrQZ47B99s_vw9L92ZRKJdOudP01cPcwLr_8r0NL9wV4LKDSzbtw1IC_594kQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvddviedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpefgrhhitgcuufgrnhguvggvnhcuoehsrghnuggvvghnsehsrghnug
    gvvghnrdhnvghtqeenucggtffrrghtthgvrhhnpeevieekueetfeeujedtheeffedvgeff
    iedvjeejleffhfeggeejuedtjeeulefhvdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehsrghnuggvvghnsehsrghnuggvvghnrdhnvghtpdhn
    sggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegujhifoh
    hngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshgrnhguvggvnhesrhgvughhrght
    rdgtohhmpdhrtghpthhtohepfhhsthgvshhtshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:eVrQZ51pLhgGFsmPzx7H2pjNL4vcoO6JS--gaCXTCCWFKuBq7TvnXQ>
    <xmx:eVrQZzHKpb0H2sK-k7pcK2FvLvLGiD2NTXlficbI7i6Ne7EjpZZBsw>
    <xmx:eVrQZy-5URc3mr7uCI4NqMdfgIL-b5ufOcvNh3MnlIW5MPQ9afmXtw>
    <xmx:eVrQZ4mkHUZ6P4M-zxSU-2-fcee30X8K-JHUiEcRdBOsXAg9titx8Q>
    <xmx:eVrQZ7B1AJ7r-lqDE5I1myWIn326focvkBiWosaBBZA-fAogXOkWWha3>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 11:44:56 -0400 (EDT)
Message-ID: <a4f915b2-d261-41e8-bc07-8fb2174af89e@sandeen.net>
Date: Tue, 11 Mar 2025 10:44:56 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/rc: use getent when available
To: "Darrick J. Wong" <djwong@kernel.org>, Eric Sandeen <sandeen@redhat.com>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <52747027-2915-4c92-a6e9-b0dce1cbe198@redhat.com>
 <20250311153037.GI2803740@frogsfrogsfrogs>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20250311153037.GI2803740@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/11/25 10:30 AM, Darrick J. Wong wrote:
> On Mon, Mar 10, 2025 at 12:55:51PM -0500, Eric Sandeen wrote:
>> Zorro noticed that on systems using nss-altfiles, some tests failed when
>> trying to parse /etc/passwd directly. The "getent" command does the
>> right thing in this case, so let's use it as long as it's available.
>>
>> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
>> ---
>>
>> diff --git a/common/rc b/common/rc
>> index 6592c835..50312331 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -2621,7 +2621,11 @@ _yp_active()
>>  _cat_passwd()
>>  {
>>  	[ $(_yp_active) -eq 0 ] && ypcat passwd
>> -	cat /etc/passwd
>> +	if type getent &>/dev/null; then
> 
> If you want to be really nitpicky, 'type' isn't defined for posix
> shells; you're supposed to use command[1]:
> 
> 	if command -v getent &>/dev/null; then
> 
> I don't care that much since fstests is wholly dependent on bashisms so:

Yup, I started with "command -v," realized it wasn't used anywhere else
in fstests, and that we always used "type" - so when in Rome, etc.

> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

Thanks,
-Eric
 
> if you decide to change it or not.
> 
> --D
