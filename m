Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6B3D522B
	for <fstests@vger.kernel.org>; Fri,  8 May 2026 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778270882; cv=none; b=AaLfjG7MlakudkmhATtDaH48z+oAoyj0D3/PwhCMsRktdchyGtzsv40r2nl7Gl7xMLWFi0nro94qvzLsA8+2WkzmfrDtXh9ETvUpLSflkgTq091uLPdUGbqNoCdr1b2EZ3FKzkCZ+G9G5omyK96dP6W1qY2YU7E3c6xXxesH54c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778270882; c=relaxed/simple;
	bh=4c4+fprHnGdtGYr4N+6Ob1Joyv6dQyTnqsG1Yj/7HZY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:Subject:Content-Type; b=Xy0vccl2z0fpuCqX45pHhWctiNJda/ZcOxR4KNFvK4nyXJRr+FEK8Oap8jlDxOZMCmBfiQFELzXc1b/VPeXZjSSbSjo9uC2WzOejJQj7G9g/0wz3beIBuBCmNvYutkKy9gbZHVmetNh0fco9NOecAZwkpPp/fDQHIiSCQV+v5fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org; spf=pass smtp.mailfrom=verbum.org; dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b=F7yUV75p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oCRxx/i1; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=verbum.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=verbum.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=verbum.org header.i=@verbum.org header.b="F7yUV75p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oCRxx/i1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 919BF7A00E7;
	Fri,  8 May 2026 16:07:59 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-04.internal (MEProxy); Fri, 08 May 2026 16:07:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verbum.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm3; t=1778270879; x=1778357279; bh=F2
	dxhu3OT/PSuU1C2f71kJZcPLR2UW5C7fzDhH405so=; b=F7yUV75pYAfCbH/Spf
	r8UUOelg0pDikTwR2h/Z09DOfJrburZHzS6EyICTgXy4NNvikMebwX34L8ti8KSO
	Vkrr171sTKAbQGbVnEwyO04Le1HZTUfIHCsiyhALr+onLVyY/gSyuRO5Q1/w9VpU
	iSxtLRiYHreCbc9gDl4kdztp5pW+i3FCRogkF/kLBnS9I0WS5qh2iitGEMJqWgH5
	lIvKCLDBIRXG8ZC7BN5LeEyPPLrtceKwZZAHBNylHqvHYm+GhVHja8qtjJbZ/nSu
	Iyq84yyJGS2K7MjX647oRvUkmbhPS5TV+rtJ4aawJqfcrgcFNwR03ERo/zU70/JC
	cFrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1778270879; x=1778357279; bh=F2dxhu3OT/PSuU1C2f71kJZcPLR2
	UW5C7fzDhH405so=; b=oCRxx/i1C14HQQUW8BIZo1L8Ju5GqFuaBCwqeGl3NpaD
	y2jKvonwdV349fhcOXZILPrMvX+b2m3d1yY2ZWSg27a5A5s2AG2MTMryoH/kWqT9
	u7JT1f89vUOh5l9MU2iqklx5hxoZrWOfKMwbhiisQ/uGG15cOC8ez3Vfz1YQf4ge
	PGS7xTnry+G8MN4i1iLZlToMDqvmjYZGC5cEBGGBuOs/TowNpCSoF8IpgSMmH9Vf
	So+M9HOD1bXPw2SP08lisKTYPkvOPLIWYSc9T5LnkoRWzxr+d3707GdR1OVsRHVR
	IYD20+rrbIsp7tvgoe+3DWr3yndBMIouljxyJKA/9g==
X-ME-Sender: <xms:n0L-adR5GXRHxymS2cJDqrYntZiWLiDjeQiB6ztmJM7hi5A_E1S9hw>
    <xme:n0L-aRkrTFUFzeZBbqlA2IsZapD_TTidmbCc99z7FDeYJpRmWWV0QI_iFTK8ELgMj
    xsUEvEIucQdzBEHxadDrwLuzzyZOETPu_OF5_ojo62Y_fDEc8SE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudduvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefoggffhffvvefkufgtgfesthejredtre
    dttdenucfhrhhomhepfdevohhlihhnucghrghlthgvrhhsfdcuoeifrghlthgvrhhssehv
    vghrsghumhdrohhrgheqnecuggftrfgrthhtvghrnhepleefjeekgffgjeefjeevtdevge
    elgfdtffeikefgteejjeevgeefveffkefgtedunecuffhomhgrihhnpehgihhthhhusgdr
    tghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    ifrghlthgvrhhssehvvghrsghumhdrohhrghdpnhgspghrtghpthhtohepvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepfhhsthgvshhtshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:n0L-af_9xVy2RHNsfir6-qQtKbzL9jt4APsoc_GUDpD1zWEktCqOCw>
    <xmx:n0L-aZqIbtMPId9qmXcdIKhL6GzoLT2nZu0DdmxXCBCJyjuTGJggnw>
    <xmx:n0L-aUkDibhDSfbb6m3XkYmfsJtPffseSoI_k1lqcVHmAzsC6irsqQ>
    <xmx:n0L-aYLnLZ7jaNkSAE5ClhmTAt-IQlbt3QDlxO1ZjJLIOESAYnY0Rg>
    <xmx:n0L-acg599wzkzTSyZBtIkP2sg_CW1U-blJvWL5IoPSrJScfC-Rh_eZV>
Feedback-ID: ibe7c40e9:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 32757780077; Fri,  8 May 2026 16:07:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 08 May 2026 16:07:39 -0400
From: "Colin Walters" <walters@verbum.org>
To: fstests@vger.kernel.org
Cc: "Amir Goldstein" <amir73il@gmail.com>
Message-Id: <97140e8a-541c-4e0a-accd-cf58dd1feae6@app.fastmail.com>
Subject:  [PATCH] overlay/080: cycle base fs in prepare_midlayer to exercise lazy
 verity load
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This reproduces the regression reported at:
https://github.com/bootc-dev/bootc/issues/2174

Assisted-by: OpenCode (Claude Sonnet 4.6)
Signed-off-by: Colin Walters <walters@verbum.org>
---
 tests/overlay/080 | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/overlay/080 b/tests/overlay/080
index ce5c2375..ede04dab 100755
--- a/tests/overlay/080
+++ b/tests/overlay/080
@@ -21,6 +21,8 @@ _require_scratch_nocheck
 _require_scratch_overlay_features redirect_dir metacopy
 _require_scratch_overlay_lowerdata_layers
 _require_scratch_overlay_verity
+_fixed_by_kernel_commit 0c8c88b8eb82a2a41bec5f17c076d6312dc40316 \
+    "ovl: fix verity lazy-load guard broken by fsverity_active() semantic change"
 
 # remove all files from previous tests
 _scratch_mkfs
@@ -222,6 +224,11 @@ prepare_midlayer()
        echo -n "changed" > $lowerdir/$subdir$wrongverityname
        _fsv_enable $lowerdir/$subdir$wrongverityname
        echo "$lowerdata4" > $lowerdir/$subdir$missingverityname
+
+       # Cycle the base fs to evict cached inodes, so the overlay mount
+       # that follows exercises the lazy verity load path from disk.
+       _overlay_base_unmount "$OVL_BASE_SCRATCH_DEV" "$OVL_BASE_SCRATCH_MNT"
+       _overlay_base_scratch_mount
 }
 
 test_common()
-- 
2.52.0

