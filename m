Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662AF145A18
	for <fstests@vger.kernel.org>; Wed, 19 Mar 2025 00:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742345889; cv=none; b=IsAnfPahUwtKQ5MNjmZQeuqbXpcgIEuLqZgZQtT4bCK7XbFuSV0VFMmbIoSUUQF3vt4DGK7vLmRxNel33aQvgi5ziuh4+4jn1lKBHmjBEiNG6p+pkS3haFha/mNVzdqmFZXrNT8Cf/VnonWKiWhHPfX2Q3OUESFsJ/rLCneSj5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742345889; c=relaxed/simple;
	bh=oYfgq9seaU39RJLY9kU1ppJEp+QVhj1iYA4N79HsRHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A0a1DRrhSdUt10GRRk3me5OiFqc6ftu5Hx8IopPScYrN/vI7ioIH5d/SGiRUK+UpA8rq454whIRHDF/jjRGyT2D/w22pX5fKMH8XaLW1ufv675IL3XSPm4ykBIxntD5dRej4IUAvC/L4f4k43APXl5bb1MkmNddhXpEXRRzrE38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net; spf=pass smtp.mailfrom=sandeen.net; dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b=h6/+ItCa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oUCJBoP9; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sandeen.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sandeen.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sandeen.net header.i=@sandeen.net header.b="h6/+ItCa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oUCJBoP9"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 616E525401ED;
	Tue, 18 Mar 2025 20:58:06 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 18 Mar 2025 20:58:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sandeen.net; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1742345886;
	 x=1742432286; bh=CRP2M3jIVy2E+2QGLIrOcm//zjuTz3WXamK+FMgz8ps=; b=
	h6/+ItCar2rNAgnkrjov09zbpeH9l0N3cC2jwqzlzRMCCV5x5c8Yyv5b8sYDcjlH
	GbnieOj1+AlI/uEFAz/BHqZSQqAZ1QeOSvdG9yeoufv3EpuPPXVP8ZeKeJsig/WM
	3P3i/PqYMDJvCKjH3ejRERJEdYfjqYgOa0mKcF2aqAiDQCsxMvUzM7kwih57FR2E
	IMGFynZ22NZER7Z4Q+6pWDKwO/1ru+CuzSDVGXNlE8AlUa8JAOYZaSKbWnAiV4/i
	l5z+9hTSlctCxmcg54b4yCOBcDldn1ZmWhklGygKedIXeQJDN7JylL9DZLoi0dfa
	2n2DeNsreMuzWMR/RtDLVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1742345886; x=
	1742432286; bh=CRP2M3jIVy2E+2QGLIrOcm//zjuTz3WXamK+FMgz8ps=; b=o
	UCJBoP9465NYH0XrDDWtliAlPcjR6pKqPNI05bGVODldqbmpk8K4Inpbft64FNv2
	E0oiFiyYWxEVi9kYHyFByxI+/CgxxDHLM/w+p5rX6niRLrQATQw/2ztDXFhalfRW
	kMghdTzxcnm4Ya35YBmWO1hBcbmWQeXHhXxXIHpUorptTM30zdBu/LWJvJcqZTso
	vzgmKJHTisB/J+pds0JsjD/PKry+xWcYUXncT6YRWLrDa072BpBJPKxyhSfAGNxc
	hzCZjNXBrwMVQvo9cTa1mziAsWhAbfLZue3RDs4H5XLcyFwfF+aNLf280S7ktH35
	PdW0uazdRKV90AAGQc9eQ==
X-ME-Sender: <xms:nhbaZ3OQ0XBHYnzH3X5cJueRxVKS0vqHXa5MWPQ1Wa-w1UOYAx2leQ>
    <xme:nhbaZx_v-3zPyVmzcah4FeRZeFekN3WwbpGXYtkc2pnLGDdMSTtN5hlEWsn2IVhV5
    ioJ_C23h6CmzW5EI2Y>
X-ME-Received: <xmr:nhbaZ2QCD9phWDuL_6Z6MlrvFQKcefm2hWz2uLwFVz1cjZ08peONZTWc0CqwTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeefleehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefkff
    ggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepgfhrihgtucfurghnuggv
    vghnuceoshgrnhguvggvnhesshgrnhguvggvnhdrnhgvtheqnecuggftrfgrthhtvghrnh
    epveeikeeuteefueejtdehfeefvdegffeivdejjeelfffhgeegjeeutdejueelhfdvnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrnhguvg
    gvnhesshgrnhguvggvnhdrnhgvthdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepthihthhsohesmhhithdrvgguuhdprhgtphhtthhopehfsh
    htvghsthhssehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nhbaZ7tInYUicPGNKZQI0ZncafOqMcd-thXmi_4I53wNYnCTyiwQAQ>
    <xmx:nhbaZ_e996V4UA5zP4gJtfCcFuE-pBD-U8bnWWdDwxVoZoHTnWh38Q>
    <xmx:nhbaZ31owhFNhzpS_tVNiXHk45xTEg0FV-np8TD-TQQT8IZxQ4scTA>
    <xmx:nhbaZ79cgGXVPmEAr3lkScRPSMUnn-CIerUazpBSAgJcCFuQAQ4UHQ>
    <xmx:nhbaZwrzad4HglWL8AF30puq7u3AJVhdXTCfthPEQ9OkYyX3oiNRG6ne>
Feedback-ID: i2b59495a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 20:58:05 -0400 (EDT)
Message-ID: <ffed04f3-5743-4a92-9b2c-20887c04a4cf@sandeen.net>
Date: Tue, 18 Mar 2025 19:58:05 -0500
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
Content-Language: en-US
From: Eric Sandeen <sandeen@sandeen.net>
In-Reply-To: <20250318235116.GE787758@mit.edu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/25 6:51 PM, Theodore Ts'o wrote:
> On Tue, Mar 18, 2025 at 03:39:33PM -0500, Eric Sandeen wrote:
>> generic/699 fails because _overlay_mount_dirs() uses _common_dev_mount_options(),
>> and when FSTYP is ext4, that yields "-o acl,user_xattr" and acl is not a valid
>> option for overlayfs.
> 
> Hmm, I hadn't noticed because the test is getting skipped for me:
> 
> BEGIN TEST 4k (1 test): Ext4 4k block Tue Mar 18 19:44:51 EDT 2025
> DEVICE: /dev/vdb
> EXT_MKFS_OPTIONS: -b 4096
> EXT_MOUNT_OPTIONS: -o block_validity
> FSTYP         -- ext4
> PLATFORM      -- Linux/x86_64 kvm-xfstests 6.14.0-rc2-xfstests-00063-g6630cf085eb0 #14 SMP PREEMPT_DYNAMIC Mon Mar 17 11:19:56 EDT 2025
> MKFS_OPTIONS  -- -F -q -b 4096 /dev/vdc
> MOUNT_OPTIONS -- -o acl,user_xattr -o block_validity /dev/vdc /vdc
> 
> generic/699        [19:44:51][   12.536740] run fstests generic/699 at 2025-03-18 19:44:51
> [   12.794084] overlay: Unknown parameter 'acl'
>  [19:44:52] [not run]
>         generic/699 -- overlayfs doesn't support idmappped layers
> Ran: generic/699
> 
> I haven't really played with idmapped mount.  Is there some CONFIG
> option I need to enable this test to run?
> 
> 						- Ted

I shouldn't have said "failed" - you're seeing what I'm seeing, it's 
skipped (not failed) because it tries to test overlayfs idmapped layers
using the ext4 default options, and acl mounts fail, skipping the test.

-Eric
