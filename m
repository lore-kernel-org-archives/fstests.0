Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5E786266
	for <fstests@vger.kernel.org>; Wed, 28 Feb 2024 21:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709155009; cv=none; b=ngvsmSYX92g2c9g3TxSF1Wi17MWzUqfEwudJFfk5SGfIZSlCBOU2kjtZ9l8wMPgczgVjZCgRByhmtMI17Lq8lXRKoIm0cpjLVU4NMtSBR252NBTz7fDv9qGUzA4ubdXUncLkkQr3gZ/6d3tTGC94TqPaklWOI816xcPrjq+GZpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709155009; c=relaxed/simple;
	bh=5CbfDHq0taE18XJANyJep67L9uDlQEDqUHb2h/lB0lo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=uOl/89FYqcC+NTGlsU9V9vRReXBYp07nmg11Maj8nR40Wyg4TGpM89u3/TkaGVUxTEX/rCK22LZWn6hLDXfKFc8sKYeiPPTU031wiKsqj7tqlwXusKZapdVS/9oyqekZMzhhYCAoozVtGEoaOu2zg8MA11K0upBgCQRyYH8ASII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EwPZThWO; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EwPZThWO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709155008; x=1740691008;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uwAIEbyZUj3YM1qV3W5HSvub7xA7PzbTPiAG7BlMbPM=;
  b=EwPZThWOJPsgn9kqbBP5EVKyVbAhLj+4KlEzCPCHB2WXaZ3YZEDS6nNw
   Xb848uCWqVisoy+69QAnR+LWAVAK3OP6AdC/LO1J9ZFrNGTwPA+pgJwcW
   av90YhPPHH4MSSD0jy6JTvlM3fvJasnq0q3htZl/Q43xdGdpmVKb2RjAM
   8=;
X-IronPort-AV: E=Sophos;i="6.06,191,1705363200"; 
   d="scan'208";a="384376661"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 21:16:47 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:8690]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.44.165:2525] with esmtp (Farcaster)
 id ea0815db-1fe6-4bce-b42a-eb34d388842d; Wed, 28 Feb 2024 21:16:46 +0000 (UTC)
X-Farcaster-Flow-ID: ea0815db-1fe6-4bce-b42a-eb34d388842d
Received: from EX19D030UWB002.ant.amazon.com (10.13.139.182) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 28 Feb 2024 21:16:36 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.187.171.32) by
 EX19D030UWB002.ant.amazon.com (10.13.139.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 28 Feb 2024 21:16:36 +0000
From: Suraj Jitindar Singh <surajjs@amazon.com>
To: <fstests@vger.kernel.org>
CC: <surajjs@amazon.com>, <sjitindarsingh@gmail.com>
Subject: [PATCH] ext4/060: Test marking last group as trimmed
Date: Wed, 28 Feb 2024 13:16:12 -0800
Message-ID: <20240228211612.2602355-1-surajjs@amazon.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D030UWB002.ant.amazon.com (10.13.139.182)

Regression test for upstream commit added in v6.8-rc1:
7c784d624819a ext4: allow for the last group to be marked as trimmed

Which fixes bug introduced by upstream commit in v6.6-rc2:
45e4ab320c9b5 ext4: move setting of trimmed bit into ext4_try_to_trim_range()

Applicable to kernels 4.19..6.7:
Kernel		Bug Introduced			Bug Fixed
		kver      - commit sha		kver      - commit sha
4.19		v4.19.296 - d61445f6a5c57	v4.19.307 - 5b6a7f323b533
5.4		v5.4.258  - 4db34feaf2977	v5.4.269  - a7edaf40fccae
5.10		v5.10.198 - c502b09d9befc	v5.10.210 - fa94912241835
5.15		v5.15.134 - a9d3bb58da959	v5.15.149 - cb904f5c71629
6.1		v6.1.56   - b4d5db1c77fac	v6.1.76   - 852b6b2a2f7b7
6.6		v6.6-rc2  - 45e4ab320c9b5	v6.6.15   - da9008da96404
6.7		v6.6-rc2  - 45e4ab320c9b5	v6.7.3    - 73986e8d2808c

Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
---
 tests/ext4/060     | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/060.out |  2 ++
 2 files changed, 64 insertions(+)
 create mode 100755 tests/ext4/060
 create mode 100644 tests/ext4/060.out

diff --git a/tests/ext4/060 b/tests/ext4/060
new file mode 100755
index 00000000..cc5f3819
--- /dev/null
+++ b/tests/ext4/060
@@ -0,0 +1,62 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# FS QA Test No. 309
+#
+# Regression test for upstream commit added in v6.8-rc1:
+# 7c784d624819a ext4: allow for the last group to be marked as trimmed
+#
+# Which fixes bug introduced by upstream commit in v6.6-rc2:
+# 45e4ab320c9b5 ext4: move setting of trimmed bit into ext4_try_to_trim_range()
+#
+# Applicable to kernels 4.19..6.7:
+# Kernel	Bug Introduced			Bug Fixed
+#		kver      - commit sha		kver      - commit sha
+# 4.19		v4.19.296 - d61445f6a5c57	v4.19.307 - 5b6a7f323b533
+# 5.4		v5.4.258  - 4db34feaf2977	v5.4.269  - a7edaf40fccae
+# 5.10		v5.10.198 - c502b09d9befc	v5.10.210 - fa94912241835
+# 5.15		v5.15.134 - a9d3bb58da959	v5.15.149 - cb904f5c71629
+# 6.1		v6.1.56   - b4d5db1c77fac	v6.1.76   - 852b6b2a2f7b7
+# 6.6		v6.6-rc2  - 45e4ab320c9b5	v6.6.15   - da9008da96404
+# 6.7		v6.6-rc2  - 45e4ab320c9b5	v6.7.3    - 73986e8d2808c
+
+. ./common/preamble
+_begin_fstest auto
+
+# Override the default cleanup function.
+_cleanup()
+{
+    _scratch_unmount
+}
+
+# Import common functions.
+. ./common/filter
+
+# real QA test starts here
+_supported_fs ext4
+
+_require_scratch
+_require_fstrim
+
+# Make an ext4 fs where the last group has fewer blocks than blocks per group
+blksz=$(_get_page_size)
+blocks_per_group=8192
+
+$MKFS_EXT4_PROG -F -b $blksz -g $blocks_per_group $SCRATCH_DEV $(( blocks_per_group - 1 )) >>$seqres.full 2>&1
+_scratch_mount
+
+$FSTRIM_PROG -v $SCRATCH_MNT >>$seqres.full 2>&1
+# If we have the fix commit then the above trim command should have marked the
+# group as trimmed and subsequent trim operations shouldn't discard anything.
+# If we don't have the fix commit then the group won't have been marked as
+# trimmed and the below trim operation will discard more than 0.
+bytes=$($FSTRIM_PROG -v $SCRATCH_MNT | tee -a $seqres.full | _filter_fstrim)
+if [ $bytes -gt 0 ]; then
+	status=1
+	echo "Final group in filesystem not marked as trimmed after trimming entire fs."
+else
+	status=0
+	echo "Final group in filesystem correctly marked as trimmed after trimming entire fs."
+fi
+
+exit
diff --git a/tests/ext4/060.out b/tests/ext4/060.out
new file mode 100644
index 00000000..f3457134
--- /dev/null
+++ b/tests/ext4/060.out
@@ -0,0 +1,2 @@
+QA output created by 060
+Final group in filesystem correctly marked as trimmed after trimming entire fs.
-- 
2.34.1

