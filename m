Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2831C3BE1
	for <fstests@vger.kernel.org>; Wed, 19 Mar 2025 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742398587; cv=none; b=QJTxDZLIu7U74sQYdmNOplZ9S/yVKNnNRcQ30JAGpBYRLUBT+UjHhKKMj9HpOsaXo3U/3BjdaF/5Xc5yPMDBHlSw1Ds8kIA+7Qg0+a/WUpzBv6IxoGFMkvdspUoWwTLUOex1FupMtL9rkhXVNDnaaESoSjtMGU7SrpBqHxXE0sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742398587; c=relaxed/simple;
	bh=xy/l0Jo/9Afri1SDfMxgDfbFDeuSVSQVKh+pN4lMy8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t1PCBZQ1dqr/s43+YH4H9NrXA65G82Ca35gNBkN+kD7nAV2KFjuQvNegV2krHp3CVLMcaIQIdiRO+qGMf82nLpHX2oFLfraMBhWfJwsAdR/4tXlHOdX7JIB1Dsl5GR3t5s6lPnbHTbPdmM9Chy60+bLnPlEW1pqDBXDaStrjNGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=S9r+Q4A9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S7bUmnb/; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="S9r+Q4A9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S7bUmnb/"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 98C7A25401FD;
	Wed, 19 Mar 2025 11:36:23 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 19 Mar 2025 11:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742398583;
	 x=1742484983; bh=23ldyuDOJW0o8qD3UzI/cSXBfDCatQtgaDmuO1vVCdM=; b=
	S9r+Q4A9MCsh4WyVS70KXmVZ22UaFhXNwSX+108jLljF2wQNOr17gd6a+UZl/qhi
	iZDZbvI2iTYmU45rSjvmWYQskfOc0M3q4raxMYphBjiH3rqQa2vknFErzao+4hfi
	b9uzMqTgMwz+t4/x/trtJXMGsP04+ola2jJrx+vZjofrmBso3sHJoOFWojh/5j2B
	UDWoJ6nOm/3dHWtf7WoHh3O6k1kuOqhxigBaNtfLEEyknyiHCMvTSjbheDDpFOwU
	oRxX/yAo0bgj4l87kxQGiT9gtVzD81cDvVnfQJdBEp9IfD50v0XcNphERudptxXT
	FXlCnJSwS9FrWQahnOZThw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742398583; x=
	1742484983; bh=23ldyuDOJW0o8qD3UzI/cSXBfDCatQtgaDmuO1vVCdM=; b=S
	7bUmnb/DH+C0l8EHAaQJktJsCT8WcSUeYXH6FVP3xA1of512RT73cj755lMIolZR
	3WlEzsgTPGBzXv7M68zE3NQu+zVHnz+WnszFFlUmkGdlmoKQdVgIok+S2yIKjkdi
	w/Ap1f1FvuEeVfpknL6CRRYdsekcazRKjwbIyIrNu322Xnl3nbnPySThhBTHC6a6
	EMdUJdqyPev+rVJKpErSuAVthRAf6bz1rX+hKV3lwSewdYUq9pwEZ9O1s7R+o8xT
	2cf4q/8bnRb8SIt6tI6sRar/iEbNmE55d0Fe0nDx66E3+N7amELr4lUFKmUHGnR4
	hui3H6xy0OdYYirMakmOw==
X-ME-Sender: <xms:d-TaZzlayfcFq-s0kLPj-bAYqLgmjwk7bHzjK4xVVs4eNJU9imUX8w>
    <xme:d-TaZ228TEpKEoGzAoB6Kp24KG1ffF8eOfu1turbMH7_Chj6gAN0Sde02-FAuqiv8
    0OajU7MtMAF8UiDUhc>
X-ME-Received: <xmr:d-TaZ5qA0sU1TWXCo4AI3vUOh_pLOLZ_S5oeVtPXJPlkAkUO88JEAKxqnkoi5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeehjeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefkff
    ggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepgfhrihgtucfurghnuggv
    vghnuceoshgrnhguvggvnhesshgrnhguvggvnhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveeikeeuteefueejtdehfeefvdegffeivdejjeelfffhgeegjeeutdejueelhfdvnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrnhguvg
    gvnhesshgrnhguvggvnhdrnhgvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtthhopehfsh
    htvghsthhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:d-TaZ7mJBrmBWMRQ3m-3RtYbA-6coY-y2HeEq8otXydC7rXGVUwk4Q>
    <xmx:d-TaZx2eVEjYH42J6J1gaJmV2obIc79hjJhrQcEbK_L-IkBzNHjJ_A>
    <xmx:d-TaZ6v8tzvLSTzWUQydnALM_WJAMeHsLllAsr0z3zr6bwc1kZijUw>
    <xmx:d-TaZ1XImWSAWgaGJJ7YrZW4s-L51DsxbzGPjmBM6q6ploIKjbsncQ>
    <xmx:d-TaZ_BxGHvFVCsoYsEjqft-7uXzuppMpHU47Iv3sKDhJ723sy8MCUg2>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Mar 2025 11:36:22 -0400 (EDT)
Message-ID: <ae2f1f77-b011-404e-ad3d-4f17d039ce30@sandeen.net>
Date: Wed, 19 Mar 2025 10:36:22 -0500
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: generic/699 fails on ext4 due to using ext4 mount options w/
 overlayfs
To: Theodore Ts'o <tytso@mit.edu>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <c46d8caf-053a-4af1-b562-7ca7203cb926@sandeen.net>
 <20250318235116.GE787758@mit.edu>
 <ffed04f3-5743-4a92-9b2c-20887c04a4cf@sandeen.net>
 <20250319035815.GG787758@mit.edu>
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20250319035815.GG787758@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 10:58 PM, Theodore Ts'o wrote:
> On Tue, Mar 18, 2025 at 07:58:05PM -0500, Eric Sandeen wrote:
>>
>> I shouldn't have said "failed" - you're seeing what I'm seeing, it's 
>> skipped (not failed) because it tries to test overlayfs idmapped layers
>> using the ext4 default options, and acl mounts fail, skipping the test.
> 
> Ah, OK.
> 
> Hmm... I think the fundamental problem is that _overlay_mount_dirs()
> shouldn't be using _common_dev_mount_options().

I'm not sure but I think that's still necessary to get to
OVERLAY_MOUNT_OPTIONS for overlayfs mounts ...

>  Depending on the file
> system configuration that we might be testing, MOUNT_OPTIONS might
> include any number of things which overlayfs might not understand,
> including things like: "nfsvers=4", "data=journal", "dax",
> "test_dummy_encryption", "trans=virtio" ,"version=9p2000.L"
> ,"posixacl", "prjquota", and probably quite a few others.

Right.

> After all, we'd want to test overlayfs on top of (for exaple) 9pfs
> with generic/699, and in that case, MOUNT_OPTIONS will be set from
> PLAN9_MOUNT_OPTIONS, and will contain options like "version=9p2000.L"
> that overalyfs has no hope of handling.
> 
> What I'm wondering is what mount options _overlay_mount_dirs() needs
> from _common_dev_mount_options()?  Why is it there in the first place?
> If there are some specific mount options that we need to pass on to
> overlatyfs, maybe _overlay_mount_dirs() should be grepping out
> whatever mount options. it needs, instead of just blindly pulling all
> of the mount options?  Or, maybe _overlay_mount_dirs() sould avoid
> calling _common_dev_mount_options if FSTYP != overlay?

Again I think that _common_dev_mount_options is intended to pick up
any OVERLAY_MOUNT_OPTIONS mount options the user might have set.

In this case, though, it picks up the underlying fs options, because
in this case FSTYP is the underlying fs type, not overlay.

I asked Zorro offline if maybe this test should just move into overlayfs/
if that can work. I think it would solve the issue, though I'm not
familiar enough with what this test is doing to know if it's ok to only
get this coverage with an explicit ./check -overlay run ...

-Eric

> 				     	      - Ted
> 
> 

