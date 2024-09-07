Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595E315C131
	for <fstests@vger.kernel.org>; Sat,  7 Sep 2024 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725724482; cv=none; b=hsPzMpj6TMDu8AkMlf4HrItvkFbFiRE5GLhTL6XZu0PIeQh2gw54RhSs8skuF38tOqTey3ui45mL83ySUtGPYtiaz+wWCWFPp40h12MjmGQJW7sBWftkgvNuuEAYUUXnUMnczzung7SFMxfFG1441OkKF+MTNS2SQbBwd5RyK9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725724482; c=relaxed/simple;
	bh=pZiHeesyIqRKchwYQlpCTTK+UUl2nRLWRSn3BnntGzI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=IzU9q7FxX6Qn4e8FUV/lYMT2HRCVMwDk7ZO60BjEvaaLWGp9+7eiAx8ZnyAoMAG/o7bbBFgffPWrNG/OQfzqegVDkXAWtpxPo3wPgMxIhxYZENI+vgeum8LmmkEecJZ4w5ocly3ekNCiTgDKjx/o//Ved6j9am6dIsPiZMdZIgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is; spf=pass smtp.mailfrom=alyssa.is; dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b=VcwaWNlz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cEf4uQqx; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alyssa.is
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alyssa.is
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alyssa.is header.i=@alyssa.is header.b="VcwaWNlz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cEf4uQqx"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 549371380176
	for <fstests@vger.kernel.org>; Sat,  7 Sep 2024 11:54:38 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sat, 07 Sep 2024 11:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1725724478; x=1725810878; bh=3oK4gVTh1MKTi5GYOiqYT
	q9WbxT57fjLibIzrJY0QmE=; b=VcwaWNlzAM02wpWwesiw0zqimtMlpC9rdYlEf
	efhq1fZwB7qf02d0cwQOZ3pc0sMKIBDg/lozMTEZNAyYi4CtSPOUOeuWfseSYWtA
	eGMQ4pXnFIRfF/VDTnd89BUEc9oe2WUEpCDQ0VH35f8uIvZsIUEwqh24ney9YoVs
	2cYfyCm3FoYRNduRtP/XHQyUdQZESZPXEVwfPQSjrI0gc7byQcPaV8i9+Tyj2ZbR
	1QFvCYdYhb6R3x6j357dIZpegl3+10OOMgufUGtTxaKicieF9pRv1O18ScczwfbP
	ErRrjiEXoBxaSRhkck2v73IAO0y0Ky5xf7MRSN1huXJOgu+VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725724478; x=1725810878; bh=3oK4gVTh1MKTi5GYOiqYTq9WbxT5
	7fjLibIzrJY0QmE=; b=cEf4uQqxXq8IY3HFKMvG/Knte10LAAcMq3Ib8hc0ziWO
	7E65SLLLKJC8IqmIWNIK9glvEEeFHlkjPI3BjA1htkQ9HJA7IUfE8D9t/LLmgkQd
	7uI4z2w5PYJ1G8evsq/+cBeoJvk2BkkoV8rkGyx5jQWvv5NpssOgKfZIFsmh1Zz4
	o6g3gXVolXvNQkXFMBSIRSqNHzhIr1OALy1dFbh2wlwcpgAmbM4cSnuky2wL9Juu
	01spaMgGI5+otCZbXDQKn97sdPrRTecZB8PJonTaHbvO5ECPoPF2TU5EWwVtHTvb
	AJEx8NwqDOxMqgFYUuN1zavbBYHAVxD9MkNCq9I5Pg==
X-ME-Sender: <xms:PnfcZjTPZZYJogGyGwKSfYBuNZA9810eh3v_pVtFPMAbZ90g7sG45g>
    <xme:PnfcZkwNaOUTgLlj1-_oGM7CSdiMR5ZeBemT0gIkNzK7o8IU3Dtz83GlAWZw8_miW
    dqvhLDT3viLHV9jiA>
X-ME-Received: <xmr:PnfcZo1JsErynzYxFCbBNQ19QE-C85yBsu10gcjK0h43yphrtAP0rt4AAyjoC4cCp3eP7G7tA_iLz7M70UEj0njpB1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeifedgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvffuff
    fkofgggfestdekredtredttdenucfhrhhomheptehlhihsshgrucftohhsshcuoehhihes
    rghlhihsshgrrdhisheqnecuggftrfgrthhtvghrnhepleejtdeiffegveejuedvkeevie
    etkefgleeuleehfeduleekueejffeikeeggfeinecuffhomhgrihhnpehgihhthhhusgdr
    tghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hhihesrghlhihsshgrrdhishdpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepfhhsthgvshhtshesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PnfcZjBrA4jqRJczOnjNLSJvVy3sOPvNEs8EPANXGb6cTIBeDSgnMw>
    <xmx:PnfcZsiHRagKnx8WlmkO2NAZYmveEX6CbEpm_5TxzkQqdR2VE5JhjQ>
    <xmx:PnfcZnoc3zpEEda5Mf28Fohst6EK3qGX3z1iTL5kg8qMbPIWep4bxA>
    <xmx:PnfcZnhNqgOGUMnc150EioUiPWKLnxsB6AIPgQ3kXd4jKksM8JCCMg>
    <xmx:PnfcZoasShFUThezQWuHJaIGameGxt3fscJh98kceJeqxOskuDsfsrKl>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <fstests@vger.kernel.org>; Sat, 7 Sep 2024 11:54:37 -0400 (EDT)
Received: by sf.qyliss.net (Postfix, from userid 1000)
	id A139681798E0; Sat, 07 Sep 2024 17:54:35 +0200 (CEST)
From: Alyssa Ross <hi@alyssa.is>
To: fstests@vger.kernel.org
Subject: [RFC PATCH] generic: test negative timespecs are accurate
Date: Sat,  7 Sep 2024 17:45:28 +0200
Message-ID: <20240907154527.604864-2-hi@alyssa.is>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Link: https://github.com/koverstreet/bcachefs/issues/743
Signed-off-by: Alyssa Ross <hi@alyssa.is>
---
This is an adapted version of generic/258, but it tests that the stored 
timestamp is accurate to the second, rather than just testing the 
timestamp remains negative.  I created a new test rather than just
making 258 more precise, because I understand that there may be
filesystems that don't store timestamps that accurately by design.
As an example, I've heard that FAT only has 2 second precision, so this
patch is an RFC because I'm not sure how I should write a _require
function (if at all) that restricts the test to filesystems that are
expected to be able to do this.

 tests/generic/363     | 26 ++++++++++++++++++++++++++
 tests/generic/363.out |  2 ++
 2 files changed, 28 insertions(+)
 create mode 100755 tests/generic/363
 create mode 100644 tests/generic/363.out

diff --git a/tests/generic/363 b/tests/generic/363
new file mode 100755
index 00000000..50459d01
--- /dev/null
+++ b/tests/generic/363
@@ -0,0 +1,26 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2011 Red Hat, Inc.  All Rights Reserved.
+# Copyright (c) 2024 Alyssa Ross.  All Rights Reserved.
+#
+# FS QA Test 363
+#
+# Test timestamps prior to epoch with nanosecond components are
+# accurate to the second.
+# bcachefs was slightly off.
+#
+. ./common/preamble
+_begin_fstest auto quick bigtime
+
+_require_test
+_require_negative_timestamps
+
+TESTFILE=$TEST_DIR/timestamp-test.txt
+
+# Create a file with a timestamp prior to the epoch
+touch -d "1969-07-20T03:55:59.750000000+0100" $TESTFILE
+stat -c %X $TESTFILE
+
+# success, all done
+status=0
+exit
diff --git a/tests/generic/363.out b/tests/generic/363.out
new file mode 100644
index 00000000..052bacfd
--- /dev/null
+++ b/tests/generic/363.out
@@ -0,0 +1,2 @@
+QA output created by 363
+-14245441
-- 
2.45.2

