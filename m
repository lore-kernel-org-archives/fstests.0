Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276939;
	b=gLU6Z/E0s1SE1r99bLUYj7Cwt0TjWdl/X8NOSYbU1L/3ZPa4rxHSIs+Yg+S1JpfKnnL0
	 vWq1EygHV/FDa4ZuR45XiPlr8dnEuabg82f9v70mzifChSB57tHRe4CxIcLxfIsCDNDXY
	 dp69i0nCYdKafN4dTL9jFIqy6KmTwR2UeYmbFPlDXOtHK5keRLXRfPPOgpbhfKjQbMe+A
	 r1Z2wjoQWl9jufm8t2qm2u+DKf5FTCyU/xU6kZHdM9UrXcevEMfAQjE48aWoTSCAnrSK9
	 ZhMySGWA4MCFyK+ww6+zANPgwuT3W9iO/h/vPLT0SnNr6z7F14Amg0a9jttuQEisf2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276939;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PXp20XL3Gp1jxPMTn0MCFAQ9adhBIzNFQfhJNEp9ekc=;
	b=rnuyOERcJC6ulPMW3gioIhgAN9CYJWmEvNop+mp2EszZOCF0Zu3gihi7FnVxF11pK5Iq
	 QjGs/Nrq9Qka8lEkLsZ9f5+BDFLMS5iMxeZaRn04Br4/BDw8f7ThGnXeKSxpPnIUXzslG
	 ZCdljNMqGy8hIH6f5HE1fs8yJEXFM/GNCkQIuuJXRtxAEEngkelO+VjXbqQ2UWFEKFAzX
	 +PeAmIa46jEDleHWurdi/vtaOfeGFegFcyHLpvWYoE7t1sbiXtCZ3LpLeP2/Tf2/VHt12
	 MgryA3a33xHgw9aRRpV+aS21RcfupXsu4IlOOQ9jRb2HobmB0f/nDZsWu3A8g572NyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YrZCBS9c;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A50C606A32C
	for <fstests@vger.kernel.org>; Thu, 29 Oct 2026 12:28:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A50C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YrZCBS9c
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a215e64962so22063805e9.1
        for <fstests@vger.kernel.org>; Thu, 29 Oct 2026 05:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793276937; x=1793881737; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PXp20XL3Gp1jxPMTn0MCFAQ9adhBIzNFQfhJNEp9ekc=;
        b=YrZCBS9cJjtd4vUk53UWdrb83wr1lZRsshmPWUV4Yh1sE5VBpXiegCIDXFlxZ6bq08
         vBT6rvgC/Cxeg2py8h8ryaB6aqQ8s0H74aoe2EMumNePCsdsJKyDRiCLBrLP0KQDUGGL
         yBOpgksTltD2+PaX3YSQJ98dKHdqbOOSvqWFTyJobQqZrgMmnLqGuF4AyUMzsOG8C1cn
         8HAD9LJ+dHTyGTs+MsP9M8n1ySWH7UcfcbOrG71m2yZdy+fOLPShIm8s5EG3WZkhVF7t
         14iEXDi0CcJzLrdooJfXKZ74MhzvRKCGEfWBaPZ9Gb23UEVV+lk9v5MOcYycB7Eo9O5c
         As5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793276937; x=1793881737;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PXp20XL3Gp1jxPMTn0MCFAQ9adhBIzNFQfhJNEp9ekc=;
        b=xEraM7mxth+h5ls7eGirLHTnTw1O8HI9Wj3PU4YU3RmESafttriQOJq29LUE+bh1RJ
         3b2lSbk07+vM8KFxvc13qBsUiAYWahPhcJFO7RwFAkSOMXgdmNjiSvHKe1KjsslQwek3
         4hAMHogS5NERKlsEGPG2XDQmS6FhoIs2Zue0i5D4tPgKdd1ma7jK5BUYsNzQKmKbGeQA
         bmXm6Nxc/Zf3hNDsR3yn1QqnZb9J8cmMs0Bt9/EehlAJANwFhZXguHVFq64o1Sg1cvMo
         tlMOXtepp4g5Aia9IM/ga2hx15yJ0PD1onsG7eiwC7SHliBNrPkQ29bh+nOQVGy5L7wX
         Vp2Q==
X-Gm-Message-State: AFq9FYKIloIMCVgfpnJP6FnQqAUMhi73E39gm7fQoeUpQxgpkxvaHccO
	DNEeaaKVcujQowqNbUEv4UpT6lzH8VkLcDieiacvi6tDeQy0dMfCQhX5V5WP+iIU
X-Gm-Gg: AYBFou3eANaq5gOTV3uox9CufPwwz/q3WDN9sopnj228RcygIJ3t5YJ4MVHi4pLJDxR
	9ebjGHQC3uGu5U4V+N6s1XeUM0rsC8kHifvAgW9e2W7pGkFduy0UPNeIHu6+bPPtbKSIHxk0vQV
	FIG8IyhJM8lbamC6hIzX+Vby7uMhO84NpBtpejW/05bhWqcEGYAL2B4Xmcn4zYoPw56mcjTnHD0
	ZSIb/zIveo1nGqSUvL646zW0UQIjfxhZlXCXGt+hWclWxU37h1yRx31wRQIkV/XsLSAOEJnYoim
	UNN9Kw6YcTmOMxtmFcgCirryjiS1R0dHc1Z1M/mvPJMTAKGPsr9Zrr+YDfIAgCz9p0zKnU58LlY
	xjTq+7vV5gwxXX+bxEuPUq7/jLbj8UolBqVYtHreigXs92GcSo5sh7ZYTMmdoaSbBgWXQ3g0Ez3
	0XPFOKV03CydKphJxi4V5QaEMaxQQ2uPzuTjl6e/jmCe2Cxj/wk3F8/5wC4MxJyQNyAFVgZrfbx
	pnOVIzYYMinmQ2B6I3pL4v357Y/JurUDJ86tmnrR7EUKPCBKXB+3hf+uqSJIJM4H+4dCL2XpTc+
	yEiMBP0CeK8M3mXL/iDEPWdd5xZeF4TjdDvieSIxnqOFV3+ApgrJ91wioRY/
X-Received: by 2002:a05:600c:4e42:b0:4a0:27eb:49b with SMTP id 5b1f17b1804b1-4a9678c276dmr120311025e9.30.1793276937398;
        Thu, 29 Oct 2026 05:28:57 -0700 (PDT)
Received: from Cluster2.powerhub ([2a0a:ef40:18b5:9e01:225:90ff:fefc:9ffe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f7f50d3sm92477915e9.8.2026.10.29.05.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 05:28:57 -0700 (PDT)
From: Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Google-Original-From: Artem Blagodarenko <ablagodarenko@thelustrecollective.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	adilger.kernel@dilger.ca,
	ablagodarenko@thelustrecollective.com,
	Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: [RFC PATCH v5 5/8] ext4/066: verify LUFID dirdata operations
Date: Thu, 29 Oct 2026 12:28:36 +0000
Message-ID: <20261029122842.230704-6-ablagodarenko@thelustrecollective.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261029122842.230704-1-ablagodarenko@thelustrecollective.com>
References: <20261029122842.230704-1-ablagodarenko@thelustrecollective.com>
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

From: Artem Blagodarenko <artem.blagodarenko@gmail.com>

Test ext4 LUFID set/get operations on dirdata fields. This test
verifies that the EXT4_IOC_SET_LUFID ioctl can be used
to attach LUFID data to a directory entry and that `debugfs ls -lD`
can read this data.

Verification uses `debugfs ls -lD` to check for `fid:` markers,
indicating the presence of LUFID data in directory entries.

Signed-off-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>
---
 tests/ext4/066     | 159 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/066.out |   4 ++
 2 files changed, 163 insertions(+)
 create mode 100755 tests/ext4/066
 create mode 100644 tests/ext4/066.out

diff --git a/tests/ext4/066 b/tests/ext4/066
new file mode 100755
index 00000000..979d9f1e
--- /dev/null
+++ b/tests/ext4/066
@@ -0,0 +1,159 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 The Lustre Collective. All Rights Reserved.
+# Author: Artem Blagodarenko <ablagodarenko@thelustrecollective.com>
+#
+# FS QA Test ext4/066
+#
+# Test the ext4 dirdata feature with LUFID ioctl functionality.
+# LUFID is a 16-byte identifier that can be attached
+# to directory entries. It is used for quick access to file metadata.
+# EXT4_IOC_SET_LUFID is an ioctl that allows LUFID data to be set on a
+# directory entry.
+
+. ./common/preamble
+_begin_fstest auto quick
+
+# Import common functions
+. ./common/filter
+. ./common/ext4
+
+_exclude_fs ext2
+_exclude_fs ext3
+
+_require_scratch_nocheck
+_require_command "$SET_LUFID_PROG"
+
+# Check if dirdata feature is supported (required for LUFID IOCTL)
+_require_scratch_dirdata()
+{
+	if test ! -f /sys/fs/ext4/features/dirdata ; then
+		_notrun "dirdata feature not supported by kernel (required for LUFID)"
+	fi
+
+	# Verify that mkfs supports dirdata
+	if ! $MKFS_EXT4_PROG -O dirdata -n $SCRATCH_DEV &>>$seqres.full ; then
+		_notrun "mkfs.ext4 does not support dirdata feature"
+	fi
+
+	# Verify kernel can mount filesystem with dirdata
+	if ! _scratch_mkfs -O dirdata &>>$seqres.full ; then
+		_notrun "failed to create filesystem with dirdata"
+	fi
+	if ! _try_scratch_mount &>>$seqres.full ; then
+		_notrun "kernel cannot mount filesystem with dirdata"
+	fi
+	_scratch_unmount
+}
+
+_require_scratch_dirdata
+
+_u32_to_le_hex()
+{
+	local v=$1
+	local h
+
+	h=$(printf '%08x' "$((v & 0xffffffff))")
+	printf '%s%s%s%s' "${h:6:2}" "${h:4:2}" "${h:2:2}" "${h:0:2}"
+}
+
+_build_default_expected_fid()
+{
+	local path=$1
+	local inode
+	local version
+	local ino_lo
+	local ver_hi ver_lo
+	local seq_hex oid_hex ver_hex
+
+	inode=$(stat -c '%i' "$path") || return 1
+	version=$(debugfs -R "stat <${inode}>" $SCRATCH_DEV 2>/dev/null | \
+		sed -n 's/.*Generation:[[:space:]]*\([0-9xa-fA-F]\+\).*/\1/p' | head -n 1)
+
+	if [ -z "$version" ]; then
+		return 1
+	fi
+
+	ino_lo=$((inode & 0xffffffff))
+	ver_lo=$((version & 0xffffffff))
+	ver_hi=$(((version >> 32) & 0xffffffff))
+
+	# Match lu_fid cast semantics: set_lufid stores u32 words in native memory
+	# order; debugfs reads lu_fid fields and prints f_seq/f_oid/f_ver.
+	# ext4 inode numbers are 32-bit so f_seq fits in 8 hex chars; avoid a
+	# 16-char $((16#...)) that would overflow for values >= 0x8000000000.
+	seq_hex="$(_u32_to_le_hex "$ino_lo")"
+	oid_hex="$(_u32_to_le_hex "$ver_lo")"
+	ver_hex="$(_u32_to_le_hex "$ver_hi")"
+
+	printf '[0x%x:0x%x:0x%x]' "$((16#$seq_hex))" "$((16#$oid_hex))" \
+		"$((16#$ver_hex))"
+}
+
+# Create a filesystem with dirdata feature
+_scratch_mkfs -O dirdata &>>$seqres.full
+_scratch_mount
+
+# Test: Create file and set multiple 16-byte LUFIDs on the same file
+echo "Test: Set multiple 16-byte LUFIDs on the same file"
+mkdir -p $SCRATCH_MNT/lufid_test
+echo "test content" > $SCRATCH_MNT/lufid_test/testfile.txt
+
+# Set both LUFIDs on the file at the same time (32 bytes total: two 16-byte FIDs)
+# First FID:  [part1 (8 bytes):part2 (4 bytes):part3 (4 bytes)]
+# Second FID: [part1 (8 bytes):part2 (4 bytes):part3 (4 bytes)]
+$SET_LUFID_PROG $SCRATCH_MNT/lufid_test testfile.txt >>$seqres.full
+if [ $? -ne 0 ]; then
+	echo "FAIL: Could not set both LUFIDs on testfile.txt"
+	_scratch_unmount
+	_check_scratch_fs
+	status=1
+	exit
+fi
+
+# Verify file is still accessible
+if [ ! -f $SCRATCH_MNT/lufid_test/testfile.txt ]; then
+	echo "FAIL: File not accessible after setting LUFIDs"
+	_scratch_unmount
+	_check_scratch_fs
+	status=1
+	exit
+fi
+
+# Verify file content is preserved
+content=$(cat $SCRATCH_MNT/lufid_test/testfile.txt 2>/dev/null)
+if [ "$content" != "test content" ]; then
+	echo "FAIL: File content not preserved after setting LUFIDs"
+	_scratch_unmount
+	_check_scratch_fs
+	status=1
+	exit
+fi
+
+expected_fid=$(_build_default_expected_fid $SCRATCH_MNT/lufid_test/testfile.txt)
+if [ -z "$expected_fid" ]; then
+	echo "FAIL: Could not calculate expected default LUFID"
+	_scratch_unmount
+	_check_scratch_fs
+	status=1
+	exit
+fi
+
+echo "Successfully set and verified both 16-byte LUFIDs on same file at the same time"
+
+# Dump directory structure to verify dirdata
+if ! _dump_dir_structure $SCRATCH_MNT/lufid_test testfile.txt "$expected_fid"; then
+	echo "FAIL: Stored LUFID does not match expected default value"
+	_scratch_unmount
+	_check_scratch_fs
+	status=1
+	exit
+fi
+
+# Cleanup and verify filesystem
+_scratch_unmount
+_check_scratch_fs
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/066.out b/tests/ext4/066.out
new file mode 100644
index 00000000..4ec0fd6d
--- /dev/null
+++ b/tests/ext4/066.out
@@ -0,0 +1,4 @@
+QA output created by 066
+Test: Set multiple 16-byte LUFIDs on the same file
+Successfully set and verified both 16-byte LUFIDs on same file at the same time
+  Directory structure of lufid_test: OK (dirdata verified)
-- 
2.52.0

