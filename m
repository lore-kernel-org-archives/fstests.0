Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807D7132117
	for <fstests@vger.kernel.org>; Thu, 18 Dec 2025 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766042251; cv=none; b=JSlXkZ4mCv5haHvz5tSHfIZCH39SO58CQDwTrT+8ddD6ZstOiQa+Ojv64Iq3Ci9HnqrZOpSGT0mWAo/0m8eqaNN8k1FoeUDDihuPBwc2Ybbi2pEpp79vHNfFDe2TsWu0kC5ST+sXQIlFoDI+FFcITOH+1QFtdUJfWHrpPMnfDmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766042251; c=relaxed/simple;
	bh=B4cUMYoYJV448TFU8Z8aP+Wd6PGZ7+qI3wXPYPx5WB8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=teMkF2ckOTPvGjG+twHE6gxPly6LvZlJIHAAx7l825Xp68meyrVOByDnpf+7zFkCYgic4Hfrf4VBZuT+TVkaLIeNAs/1GBmaLQ6TJE8Tk7PU4Gzg2n295OKotQH0H3gfOFdevYCYu5WGGXVv+yRkoaG5yrZPBn/ZitcoAH465DA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Hd8X/8fK; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joannechien.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hd8X/8fK"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7c7957d978aso510669b3a.1
        for <fstests@vger.kernel.org>; Wed, 17 Dec 2025 23:17:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766042250; x=1766647050; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xKVoCbsNxKQYZtB4BuZGzRvyC3k2P4dMNqUBymSgTnA=;
        b=Hd8X/8fKAz1FCH0J2fOrZ4vdP75lEBmmib1ApIVozAqgEdNgwNB7DjLd2cDYZ8TCzS
         8SmRpICx/0b3QR0ZQkAe/ko5LlmTCPdwOVjFdLjfEiQfwnUZ1bRQpxsnck4j1e2TChA4
         1zur+kdNhfZ1luSYXLgguDLnaIHAbS/wHkljOaJlCR1PkcegYNsFtnNYeYVQmCF7iBH1
         5rNRDHS+C9j21MD2llkKNrQBhYXhUColM3X9W6Y74UGxCCs05XcnhaK5+pM5lwI3gINd
         zjktO38sYJNP9SbrXoYdBZB6poctL49UC3ZO42PYIl3T5iaZHpv5NN2US4YMygFanG+x
         BuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766042250; x=1766647050;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xKVoCbsNxKQYZtB4BuZGzRvyC3k2P4dMNqUBymSgTnA=;
        b=Zw44yINDmGsJ1lruHhmTGHsw4mjzSXxaQJaLZupkGCLf4NhqXJ7kcEaP3bnIlPuuta
         mc3idK4jXdzwJu958WERu9fVjO1YVgsekKXLEc1wjLOqHU9GPmNOq6d3eh0rtFQvJ2Qg
         47y5A3DZ7I/Kc0x/yEwxJFVwH/BN+ftA3/SdLQWuvx0Hr6kD13mT/pRdNI3xHmeH4aX4
         Y0FW+P84s3QbEdumGtnSa9rV3smhveTgjIpa6YicshqSwHF/BaHtjz449D5wNorAgvNa
         j616cSoeyP8s0VE8Ho6Vs8SYOu22YPQjqMd3+mTTscB80EyALJQlKaOJLFktoG6vxAUk
         OXiw==
X-Forwarded-Encrypted: i=1; AJvYcCVTvXUVlr3TH8EHTgZzoypgTI2mbL+BO2HUUwZB5ay1+i114FKuARKX9pNnAMh3NZkZVTyaF1mw@vger.kernel.org
X-Gm-Message-State: AOJu0YzNge+NB3brsp6qz/PsStIOu8Yv4/U2+2B+SKgmHC3LeBLzCFhW
	uJEFRHrEOLTIRe1Ycr+HOgTnj7l56cpXaQZRss26YUAMSdVMC82fa9CtrQJJ7uKFVYjp7SlGB86
	w8b5LoZ32dI6vS5aYzeW1u/YnDg==
X-Google-Smtp-Source: AGHT+IHbkacaOyXp/ZNrkhluvqAvKQwLxhC1/JTp6/ItJ4DdUJpNGQI6HchisZWanelvxUT7Znb9Ux4QW+y8hhCOrw==
X-Received: from pgbbx39.prod.google.com ([2002:a05:6a02:527:b0:b6c:f35f:bae9])
 (user=joannechien job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:7486:b0:33b:5a3f:3cbe with SMTP id adf61e73a8af0-369afa08091mr18617994637.54.1766042249795;
 Wed, 17 Dec 2025 23:17:29 -0800 (PST)
Date: Thu, 18 Dec 2025 07:17:17 +0000
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.313.g674ac2bdf7-goog
Message-ID: <20251218071717.2573035-1-joannechien@google.com>
Subject: [PATCH v1] generic/735: disable for f2fs
From: Joanne Chang <joannechien@google.com>
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net, 
	Chao Yu <chao@kernel.org>, Joanne Chang <joannechien@google.com>
Content-Type: text/plain; charset="UTF-8"

generic/735 attempts to create a file with nearly 2^32 blocks. However,
the maximum block count per file in F2FS is limited by the capacity of
the inode. This limit is roughly 2^30 blocks, which is significantly
lower than the test's requirement.

Signed-off-by: Joanne Chang <joannechien@google.com>
---
 tests/generic/735 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/generic/735 b/tests/generic/735
index 9bbdf3a1..d5ba5673 100755
--- a/tests/generic/735
+++ b/tests/generic/735
@@ -19,6 +19,9 @@ if [[ "$FSTYP" =~ ext[0-9]+ ]]; then
 	_fixed_by_kernel_commit 2dcf5fde6dff "ext4: prevent the normalized size from exceeding EXT_MAX_BLOCKS"
 fi
 
+# Block number 0xffffffff is too big for a file in f2fs.
+_exclude_fs f2fs
+
 _require_odirect
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "finsert"
-- 
2.52.0.313.g674ac2bdf7-goog

