Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9783DD532
	for <fstests@vger.kernel.org>; Wed,  5 Aug 2026 07:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785914325; cv=none; b=uvrOMtmv0SumcavhHZYPyiQeXtDYlO/AwsAdDGlCe0FhCmk29izgWHnt8O1PoL0oNttAnltJtfVGyfYq69C5caKGrYxevVE+NX9pIPQEAuR+dg2YbHV1ASjY3HA4IvmmhKRb6cLFPYCDQXdX2zPEFkRR8bufIdnXA8omeDFEBQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785914325; c=relaxed/simple;
	bh=uOWIMGEsC7423FfrQngMl4wBp6ka1DDD6emQGrQwbeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qaXKOdDMX7xki12sv17p13dzHt9uOV5H1vjwV8MS6tmeehXej2KUogk7K/TvMtFbPZjLrNbSe353TjGRxSc5IV1zo6Y1sgdigxNk0V1KCP6TcpmBmkNV+Ms7hEK8yWuMcjKTdrGCGa8E+t7p4AD7fnLExcupG2PFfcHWooBAH70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUjAUzMX; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUjAUzMX"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38759bcd877so684400a91.2
        for <fstests@vger.kernel.org>; Wed, 05 Aug 2026 00:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785914323; x=1786519123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7OH1Adj6KGkDmwwYAQROKRkU3gY6ZAfzxjTeuyOIM8o=;
        b=LUjAUzMX0PAPAyfciITvFRyj5cmz/AHJR9KpLagjYIeo4h2GWEq3eePnqnup82U3s9
         VL11/SIaNXK1pGD4cZs0bnDDOutMBgne6ookh8q9Krh4UfyVXId3o2CnVRDh0iiY8fFw
         5CjA57fCij12/Zvn7jlQOfws5bgvCAaaRMSzP3gt2q7p/P9SHwWWcbbvzqXXbOM2Jef+
         DbvNuxUrFImlE8rGjCArBh8YMxmnfwYmgIyvPC4fyq44Q3NDCJe+9OMRGhGVkAfMtHZW
         mT4LMFnBIzsL3Dtb5ie7C/bBdgJ9I9/fGuwI6CXrj4nEoi3SzcoOAt6C4BW1KnpPQUon
         lGSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785914323; x=1786519123;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7OH1Adj6KGkDmwwYAQROKRkU3gY6ZAfzxjTeuyOIM8o=;
        b=Whpm1TO1bL4sk1hgbfiB+pzoW/fJKMRC/5RxcldbkcZJ65Zexk4g8FBWJbAmDjYJ7Q
         HeFhla6dwIVi0KRfaUGdXg1WnjRMSTpoVANICPP6mmvCRiABGKdfrsEAQTVdMEDXcFGV
         9+Gsvn89A8WRElgGiiBYo+nZqxyEHStGgg+H/qVTko1c6goplvHajFVUlFH2Pn5RPg+r
         AgicU+sBJmCiw6CXb/VV6o2/LyedU4A5L9XUQJOw2too6enSoqIw9L5wgpCI/kBEBn5q
         gcpxsXSbxnVTbG733wC+PU5ChNu5trdACDT9iHzwgrFvvfe9P3XNPth7fkEGdsgwQySc
         NPVA==
X-Gm-Message-State: AOJu0YyrzCuJULngqXIrYm9BhpaM85HKuBUqmUqSAnj1uuel+tS0+yHZ
	Mohjy33FGfoKVza7rQEZ+EiBgi9612jkZyDak+7P0JFKyDRPFUznNWmZhv1nUdmg
X-Gm-Gg: AR+sD13bkVHuQ0rbY5rpeYbJwUOCtIxxfS/pEbVsZC9MM/XBSvE/a8gsRhomg8CKcvQ
	XRhMK4BfmRDLmY0L/GrA91HGz4Q0uLXJNlxjoFeHbocVoKenI3kSjCqiO9Hjr8rGl4R6FW4Z0vE
	eqWrVtRf3M2PYGfFvuOe0jzH3QKH4SMC/7h0Zq960ulyWzt1Y2DEY9CV5dpPwUjrCgw4DUzkW1G
	XptmTZhYXFmlBwQM5XG5ca1AgDmoNvVbu8NjsE7YY8z/qzF1NsMjCKGGJbuJDhegpj+eCbJeez7
	u4n7BVDCMmuEbKKtRksQJlx3PbsAJXrKXVKGYBUruMhLT5YAxCvqOCCrP01gYPnMKACNP1rGM/m
	UhDAVp2GdhoF8PY/15H2ESuKiSCjgh82rrkBl8aGW9YTarmXU/UskP+MgzpSaLkkUrKrOaRuRC7
	WgkMYwfP3gdFreV3P4zDF9/MESPbDM2v8DQkwbFqr2p0L25uhIesyYpC2/DC1kd/3uFCsLNtbUk
	hO4MIwucGFlxw3mNbuQx3N+UT0DobGbSl9Qe07gK6pcCCccESyBtG8dMXANBsHbFk+yQSHhgrnT
	STsAzCayMt15Vyqe8i0x8q+hF32qzsOTl7ZKAGk1mlPeAEOEFMKB
X-Received: by 2002:a17:90b:17c5:b0:37c:607b:2cd9 with SMTP id 98e67ed59e1d1-3903b9f3ee3mr4007895a91.0.1785914323088;
        Wed, 05 Aug 2026 00:18:43 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.252.203.158])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fedc650a0sm3638742a91.14.2026.08.05.00.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 00:18:42 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: fstests@vger.kernel.org
Cc: Matthias Goergens <matthias.goergens@gmail.com>,
	Zorro Lang <zlang@kernel.org>
Subject: [PATCH 0/2] fstests: expect and test truthful FIDEDUPERANGE progress
Date: Wed,  5 Aug 2026 15:18:37 +0800
Message-ID: <20260805071839.3423779-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series pairs with the kernel series "vfs: report truthful
FIDEDUPERANGE progress safely", posted separately to linux-fsdevel:

  https://lore.kernel.org/linux-fsdevel/20260805071414.3414870-1-matthias.goergens@gmail.com/

Patch 1 corrects generic/517's expected output: an unaligned 131172-byte
request is shortened to 131072 bytes, and the 100-byte remainder that
xfs_io retries now fails per destination with -EINVAL instead of
reporting success. These expectations encode the paired kernel change;
on an unpatched kernel the test fails on exactly these corrected lines,
as it did when the original kernel fix was briefly merged in 2022.

Patch 2 adds generic/806, a raw FIDEDUPERANGE ioctl test covering the
cases the retrying xfs_io interface cannot express precisely: an
explicit zero-length request succeeds with bytes_deduped=0, and mixed
multi-destination requests report the shortened count for an interior
destination and the full count for a destination ending at EOF. The new
number follows for-next's generic/798 and the publicly claimed numbers
through 805.

generic/517 and generic/806 both pass on Btrfs and XFS against the
paired kernel.

Matthias Goergens (2):
  generic/517: expect truthful dedupe progress
  generic: test FIDEDUPERANGE result reporting

 src/Makefile          |   2 +-
 src/fideduperange.c   | 138 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/517     |   6 ++
 tests/generic/517.out |   6 +-
 tests/generic/806     |  83 +++++++++++++++++++++++++
 tests/generic/806.out |   4 ++
 6 files changed, 235 insertions(+), 4 deletions(-)
 create mode 100644 src/fideduperange.c
 create mode 100755 tests/generic/806
 create mode 100644 tests/generic/806.out

-- 
2.55.0

