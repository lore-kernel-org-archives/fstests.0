Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795278017;
	b=dGCLy2E2Rr0KTdnrR33Br8oelDNVpg6wKKwlXwxRiADQp4+qgup4n+TrfyiiTgFkdCWv
	 tcK/FzDfktTe2pX12ERrbtP9hGKqj2f9rJr+vuKRxUQF49GELj6+ecmeQJDTz4OiVsRVZ
	 z6PBseVMvJcJt4tEv5uGbJdaT1smLL5XI2DVfbKWyl+DZL4/OB9rPgnsYUKyUhZ6RKgWP
	 bvgJKWZ259GRsJoi1IwR5SDafTE6xIQGUChX9j2i8yGd+LpesXK2Yq34Mzx6+xKbDjFnq
	 m3DQ1a31nKyYO0bRlZGQSKGNzf0OBgE39NaFFVJNZuUNRjXcKIaDabpR1oUWMCC4xFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795278017;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=VW9VRCvOuiUXItd/QvLY7J0ZG4GH9DREJ7eQb7fYodg=;
	b=QK+cUs8rXj4coOHYAeKTH998deZVvk8h/+ZwC/JQp6fV56Sk5qsbktXxP8tJj6CDFhAA
	 5JGz68v0nfR5CEtr7elYKiF77/RpgwzP+JFtV4e2Y2ZOwJ7LGUPXYw6IUgb1AddmWCZQi
	 YGVRRGgjI24cRfJmBKdHIYw5IJBzYhf2VaEL9QYcAogOMkbm25PZtzfJdh55OEIAvmilE
	 Rkf46CKeH9yDbE2PpB4SKzWu26NkXfo6c8d3Gextq1w0jkSzNwqNSVdrCPQ2pJzWAFkec
	 5T6iqnuOhAXWhnjEU1Bk6+0RqqW5zw6sZUir0oT2mhUdgO0bi/fel3sRyrT5KT1GbLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bd9HNujU;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 327A7606A320
	for <fstests@vger.kernel.org>; Sat, 21 Nov 2026 16:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 327A7606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bd9HNujU
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4bb6886d30aso18339015e9.3
        for <fstests@vger.kernel.org>; Sat, 21 Nov 2026 08:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795278015; x=1795882815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VW9VRCvOuiUXItd/QvLY7J0ZG4GH9DREJ7eQb7fYodg=;
        b=Bd9HNujUrMCthXMlYRglu6iPubWQ/1h6bW1lHsJbzlilmUpcS5+xMfTHUbEUOhOlz7
         f5Yj1ZgG+CCnG4xTIh69ZH+tUWOKfRf9BjUNDXxMLT5V6H/YmLbSBl15/AGt1A3+QNLi
         AdMgf8MoqxtZ4vN6nE/8gz9gpSCCbQOOwJIYrTqjdBsxynCqkgM+b4JrxMRAxS2hUX3h
         Wc0tc2N7CW9JN5REZT0OSy3d+rdYPRONnAXJ66GXErvOXP89SgsK871R2hxfiLZi1X7t
         fG/cKRXnRXA01Ar4qSHK1+viyU2U/HOzVjpJ7rxLQpCQ7joWJWXL7Xv9g8XFiCsbvdGt
         DbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795278015; x=1795882815;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VW9VRCvOuiUXItd/QvLY7J0ZG4GH9DREJ7eQb7fYodg=;
        b=d7ynn1eHxsE6qA+usy5LZ7s+ytjMkAasAnCRGYY64pxSSsTMBYpJOSaOXDD87dK/x+
         HoOoK5HFRiYcmgtknp15Hk/l/OxXJ33GxO1bejYInGKq1USkLi5Q719OZEeOzGP8qXVo
         7T8P3+oR/+U8LfvB64NiKl/efJ9meu+Qx3Eq3s5AI6jYna0r24NGUJFRreYLyWimKlnf
         dDW2rK5VONu73de6zR6hsFZnMZ0B90vZa9WOaD+xWeivcr2VAYygNg5dWkjrkkaY1Tl5
         lyjac+lz+BArsfY/q0KreU3Xd7Wz7YxVqQbcUscAuI+UsJbPsl9SvRP03qZTayxnM1Ch
         b7AQ==
X-Gm-Message-State: APuU4Z8NL2QLAHB2uLX0IBhQm47zMDwL1DWKHVfmizErCwM2npA3dijd
	n9z+Tk7lfeHO9nlmmV2TWafiLWI3NyNrqdcPorCHMDXnfNNGQlq6n2KA
X-Gm-Gg: AZFdTZcDMPEskmEV45NA2yd2Fv0gB7g+f2JLVmmFiss5RDIEvQ2pCNQfnH+RlBMD1Ck
	itbrRt4qn4SQjEHZi2iqI5GlTM7RMhAJCQTO8AQRo4tG1ZU0dB/u0gbwtYJuRCcxetli7/ih0CS
	tqCUkXwF8hn+BlfE2hJZ1TFH/s+TzzRiLP+tdQwL6Q36oPFpwv5C6Fvdl+skNdO99VIIeNWT+zc
	JftOZFhJwY31SW09kiacqnvHytzn+ogISNd47ASJoXtELzY4LZ0cYS83WTWzh/dsdsZiv7TL18/
	3cz85eRECcasOQtzJVLHgEc1Y6cqX9Dhkbqa4cv+7itVy34A9gRU+wviPz7N0aG9L67jizxAVBp
	sVNt0riXGkduF7a+hZ0YbLBG+mY2A10bwSfQznz2saPMAoPa3FIxPqA3ZPPGzdr9xwRVv15MbBH
	lTGPO4tD6L0BKHwIlLAOghWJ3zK+FQpw0V0pe9mbLo2yr5SkIno7rKUsoPkCkRNnV3sm+Yp5Zwn
	VmCiCkuDGdMUKfnglaa7pbVtNKpOjGQp93plBVXrkrXnsJ6FUU1zq8vXlKSQnejvkhYw+ItZuMz
	S5+oUGiJGyi0RIOMWc+EnTcuwA==
X-Received: by 2002:a05:600c:6749:b0:4bb:5f95:c014 with SMTP id 5b1f17b1804b1-4bb8880f283mr153429965e9.19.1795278015242;
        Sat, 21 Nov 2026 08:20:15 -0800 (PST)
Received: from infinity ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8d4f9aa8sm138956685e9.4.2026.11.21.08.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 08:20:14 -0800 (PST)
From: koraynilay <koray.fra@gmail.com>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org,
	koraynilay <koray.fra@gmail.com>
Subject: [PATCH v2] generic: add test for garbled stat output from negative nanoseconds
Date: Sat, 21 Nov 2026 17:20:03 +0100
Message-ID: <20261121162003.234307-1-koray.fra@gmail.com>
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
v2 changes:
- use _fixed_by_fs_commit for ksmbd and cifs
- add _fixed_by_fs_commit for ntfs3
- fix cleanup function
- remove useless comment
- wrap more the other comments so they're easier to read

Thanks.

 tests/generic/812     | 48 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/812.out |  3 +++
 2 files changed, 51 insertions(+)
 create mode 100755 tests/generic/812
 create mode 100644 tests/generic/812.out

diff --git a/tests/generic/812 b/tests/generic/812
new file mode 100755
index 00000000..eb76f2e5
--- /dev/null
+++ b/tests/generic/812
@@ -0,0 +1,48 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 koraynilay.  All Rights Reserved.
+#
+# FS QA Test No. 812
+#
+# Based on generic/258, but tests timestamps prior to epoch with sub-second
+# precision.
+#
+# ksmbd, cifs, ntfs3 and other filesystem drivers violate timespec64
+# non-negative nanoseconds constraint, garbling output of stat.
+#
+. ./common/preamble
+_begin_fstest auto quick bigtime
+
+_fixed_by_fs_commit cifs 6a75ce0866bb \
+	"smb: client: fix negative timestamps being read from smb"
+_fixed_by_fs_commit cifs f2f961e0983c \
+	"ksmbd: fix negative timestamps being saved to disk"
+_fixed_by_fs_commit ntfs3 xxxxxxxxxxxx \
+	"ntfs3: fix negative timestamps corrupting stat output"
+
+_require_test
+_require_negative_timestamps
+
+TESTFILE=$TEST_DIR/timestamp-test.txt
+# we use 123456700 instead of 123456789 because some
+# filesystems support only 100ns precision
+DATE="1960-01-01 01:01:01.123456700 UTC"
+
+_cleanup()
+{
+	cd /
+	rm -f "$TESTFILE"
+}
+
+# create a file with a timestamp prior to the
+# epoch with nanosecond precision
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

