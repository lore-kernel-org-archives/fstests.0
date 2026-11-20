Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795216975;
	b=Spck5j/lqi7BcHJDQxryuZQ/i67V/O86wTussqe1tp5NNrAW5Vpn3QxV6NPY/6J2NHR7
	 rJ1FMSRkJLGU3ICtm7+iyIobzXjziFCfUatdkgZjF1PlHDah8ZpH+h0pblW4nFayMq/AZ
	 mmmVYaD2vzuvPgmbDquvC1HF1Jlp5Cs5g7zRlgHxtt1T4uxKLCVYpS1OMPY/3S1vhxTwk
	 cwswZJjf05JdZLFr4ziM4vx8IwG3URFtK2jfDIgQEGcvMyLaL47DWjNcyB5UGkQDuamCL
	 UekjYfHIeLItyW1noD42Zpucd7uB7B7v+GRf/857TdFNsUQGb66abi4PQPBefaqOBjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795216975;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=wKmkH4n0r7LKJE3Mmru/c044QE1X1IfOH9ejBrfkF2E=;
	b=vfgaqVD5KVHzGRgg2Ss9lm5DXIoeim2QlrKCNy/tWMANl6gEl1mg5ickT1Dnepbp1vJT
	 3MqkSmdCkZ5TGwKXYKQ7SP8Ba5PtWce16QIOYyeygmvf/VkgdgnCdgmHXkdq4BLTVlJsu
	 rbSx3uSRVZXBXGv/GV7POQZCUSxKNctvFarIqRVw0seblbEyojicsQZloe/ebO+hfos+6
	 Vvy5Vd3cQLVhCDlqQXGP3xs96UHBtPmS7pk7qKh9s83CvzR1aoxQCWfQKWokOQM3fCmS1
	 wNv8x2xjZ2yjmwH5/OuA8a+JjNPQVws2plREdlFTVSDMwS6PRX3occlrHyCzXiTg1GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PR4spAVw;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28298606A6A1
	for <fstests@vger.kernel.org>; Fri, 20 Nov 2026 23:22:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28298606A6A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PR4spAVw
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb6057b333so6265585e9.3
        for <fstests@vger.kernel.org>; Fri, 20 Nov 2026 15:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795216973; x=1795821773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wKmkH4n0r7LKJE3Mmru/c044QE1X1IfOH9ejBrfkF2E=;
        b=PR4spAVwwrcOzehuUS/7VLKtEhdv3Abd7XaL42/QY7Bw46PUs+l+s8Xr/2X9fuv+L1
         LoaauW/oySvcDclBNKexG0P2WTOUw84zpD6Omj0rUYEwYjLJf87MI82oH/OItFWpKgr2
         Fm8n0cTxXAxVU+gGTqOYPvc8MRVKWAPwiIj7q1yv+rGJ391W9JJkB3vzjkL5CSttkCAd
         nqYWxBzvL563PyZM8FHtVmL5WYKIShXukUVKh0HNsjsdBBErfu3E73n5kKihHHNSeeBP
         yBM+ytSAZXLf0VI+Rn+yVODpMwwNe3+y2bglSZpTgduRsmf9RRS+H5WnOTsx/Rf8qZU2
         GBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795216973; x=1795821773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wKmkH4n0r7LKJE3Mmru/c044QE1X1IfOH9ejBrfkF2E=;
        b=aqtZs4a4nN+z74XodfJsJ6xwQsZITv+96HXKrm+B7XwC+9v1xwDQ0oAYvsFTIvhJq/
         9nOrlfEXJK2npTiWimhPBnpEvvIEyF0n9hTVyfCj36U8acNX2RhIGHAzACquABHdOp4Z
         kdZKfB07mJiUsrwyvZPV1KRN5C8tmsQngttjIAtxXMuNWEmJBSWPmFxAeqqvHnai+AkE
         VC3MnSkZ5deGYj9JIW/p9rm57q1lEmQ+Oj7UT+4J4YmDaXsgGJ8UZq12hLhemH7fMmAI
         1O8vuJKEj1tPpaCYKt86qLrmwCRXtZrNQcPYzus1ClygDg2k1+oOCG2OvgcnLnn8VjcV
         kKtA==
X-Gm-Message-State: APuU4Z+5ft7fOqgIKis1qxyGZan4fAbkofK459Yp05WEIAu/oWRxPtaw
	c6j2RNcZ5pCtg8m/fbAiNZufPl/FfZPGoUOzR7K41URekQT790Gi7WUI
X-Gm-Gg: AYBFou0xzw5rjz04HGIowhXsW6yqwItWrZVd2BIWpRL3hFUqBByafFrctvLOYZl2N1O
	wZXlsV2dydynnZjG2EnUdRyQZViRl4z1aBxL9+s7Xx8bkMaH5zUHWzJwUk387g7EqxNKRrTu0GV
	R5rhi/yWh/U7MQfWYB6Kg96ygY3658XgsYO0FWE9Y1OayUD56jvNJYHlOYkfvL4ua3szLUue0Nb
	05BVA5zN1EDoqKvBpd7wBZNi4K5RAYSH5/JJqZDBO/nbU2z6zpnP7/xHQReNVHF49M31e7rjjco
	ORHCrxDRc30nRhawdrxiiVLtmotGTe5+bPfUHikn99xIB6fABVb5fVXVbBnND64Bx4anBnwdJ9E
	a6yluUIx9ORibF8NsSYmvrnzb1rU2KGtbPvFmYS4kQH9Ggqc4cPs1GwXnQD1eGm9kEaK34pWZnb
	no38F3CutklbZFQXQtHBZCm/mFLixrXMHEQ2FfdwEzSrv579z+qMeimmpERb2G7YmLsnv43AqWu
	XoMK+OLLsVF1HF7Oab1Co9iKRzw4g0HDVlCZB+AgU980sUeEp5pYOzkaytuw2bse9DJQ+NHZNFJ
	P65n8vsTL9cvhSo8VFpFg6vacRkdS/NCUf1veilnMHY7yA==
X-Received: by 2002:a05:600c:820c:b0:4bb:6a2d:b426 with SMTP id 5b1f17b1804b1-4bb887c281dmr100092695e9.1.1795216973340;
        Fri, 20 Nov 2026 15:22:53 -0800 (PST)
Received: from infinity ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6a680483sm8262512f8f.28.2026.11.20.15.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 15:22:52 -0800 (PST)
From: koraynilay <koray.fra@gmail.com>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org,
	koraynilay <koray.fra@gmail.com>
Subject: [PATCH] generic: add test for garbled stat output from negative nanoseconds
Date: Sat, 21 Nov 2026 00:22:40 +0100
Message-ID: <20261120232240.563633-1-koray.fra@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some filesystems don't use set_normalized_timespec64() to handle their
timestamps format conversion, leading to a garbled stat command output
for timestamps.

For example:
     from cache:   1960-01-01 01:01:01.123456789 +0000
  after remount:   1960-01-01 01:01:02.()*+,--00 +0000

This bug also violates a struct timespec64 invariant, as documented in
the set_normalized_timespec64() kernel-doc:
[...]
 * Note: The tv_nsec part is always in the range of 0 <= tv_nsec <
 * NSEC_PER_SEC.
 * For negative values only the tv_sec field is negative !
 */

Example patches that fix the problem[1][2].

Link: https://lore.kernel.org/linux-cifs/20261112111637.184045-1-koray.fra@gmail.com/ [1]
Link: https://lore.kernel.org/linux-cifs/20261112111637.184045-2-koray.fra@gmail.com/ [2]
Signed-off-by: koraynilay <koray.fra@gmail.com>
---
Thanks.

 tests/generic/812     | 43 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/812.out |  3 +++
 2 files changed, 46 insertions(+)
 create mode 100755 tests/generic/812
 create mode 100644 tests/generic/812.out

diff --git a/tests/generic/812 b/tests/generic/812
new file mode 100755
index 00000000..de57fab6
--- /dev/null
+++ b/tests/generic/812
@@ -0,0 +1,43 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 koraynilay.  All Rights Reserved.
+#
+# FS QA Test No. 812
+#
+# Based on generic/258, but tests timestamps prior to epoch with sub-second precision
+#
+# ksmbd, cifs and other filesystem drivers violate timespec64 non-negative
+# nanoseconds constraint, garbling output of stat
+# See commit 6a75ce0866bb1efe67947fc5536a476381d7a9d9 ("smb: client: fix negative timestamps being read from smb")
+# See commit f2f961e0983c8f339f842e1a8c351e6963793868 ("ksmbd: fix negative timestamps being saved to disk")
+#
+. ./common/preamble
+_begin_fstest auto quick bigtime
+
+# Import common functions.
+
+_require_test
+_require_negative_timestamps
+
+TESTFILE=$TEST_DIR/timestamp-test.txt
+# we use 123456700 instead of 123456789 because some filesystems support
+# only 100ns precision
+DATE="1960-01-01 01:01:01.123456700 UTC"
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.* "$TESTFILE"
+}
+
+# Create a file with a timestamp prior to the epoch with nanosecond precision
+touch -d "$DATE" "$TESTFILE"
+
+TZ=UTC stat -c "%y" "$TESTFILE"
+
+# unmount, remount, and check the timestamp
+_test_cycle_mount
+
+TZ=UTC stat -c "%y" "$TESTFILE"
+
+_exit 0
diff --git a/tests/generic/812.out b/tests/generic/812.out
new file mode 100644
index 00000000..f0267fbb
--- /dev/null
+++ b/tests/generic/812.out
@@ -0,0 +1,3 @@
+QA output created by 812
+1960-01-01 01:01:01.123456700 +0000
+1960-01-01 01:01:01.123456700 +0000

base-commit: 71641219a506ac62bfa231592394265ca812670e
-- 
2.56.0

