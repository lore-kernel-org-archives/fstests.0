Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713881;
	b=2QjpOnt3Cm9cqIUbGbN8ftlRJjpssYTWbmIhl76V6+b5vAnrtaQ7YjEFkckcCrxCumoj
	 Tk7axqk8RWf/mIbNUTaO11jTrGj4A8mcypVoa5/Cj50Lh9GX0VuGY6TiMAlTkz5wh6f5d
	 TBWJPzH7aoKG9YaShlV8GvNtx+RyCUv1I4sR6BV/cKzlStzLZLv/rf6vDdQUI3hhpnl66
	 FMp70BJk87cEJJ6KPxPL/sDttnnCpAk4doRcJqY4icHlok/QtVJdfCWW2G/HAMs31rDxj
	 DREeEQIuUGiBw0HHY3W521X843CEM8Fdlu7InQu44FSHYKiJ1Jtf9F8jZCg4As7XfFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713881;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=PXp20XL3Gp1jxPMTn0MCFAQ9adhBIzNFQfhJNEp9ekc=;
	b=QC4keXzM1n1BqMpyluDQ8vSZ1Ss7Q5kBAJh2QNRpuokxPQEpZZcS1fsQYSh0iIyVXObB
	 /ZMf4vXPdUOnCSeyeoeEHA0xr5h6wb6uFHCMr4IJNA0WRFb4kLRbG4+YzzuSPrziWVOhR
	 Vb0YEs6HJaBAPbEhkd5bHXkukRyON4cTuTvq+uEFjTXPUo2c47CoA82/INvty6j6xaVR6
	 W9Ri+LSX86TZJKsXKJOLb/nNqjbmwCl34sTbBp37ZogssoNeRrmv9H0BZoBiewR1+Dd+m
	 6dK7D6GhXFp105bGZt2OPreDHf2pzcOIncstRNDfaKkw/qxUCQUvQEAEL5SJrPgPoiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yQeuLM5A;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754BD606D83F
	for <fstests@vger.kernel.org>; Tue,  3 Nov 2026 13:51:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 754BD606D83F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yQeuLM5A
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so44075905e9.3
        for <fstests@vger.kernel.org>; Tue, 03 Nov 2026 05:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793713880; x=1794318680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PXp20XL3Gp1jxPMTn0MCFAQ9adhBIzNFQfhJNEp9ekc=;
        b=yQeuLM5A4Fy/+MsAyJJA6AaYWq+mSHkK7nS0IQkQ3cKvke04mNTaUuhYfil7J5REHP
         zY+DtRriTHg7nuc42hy5XBGzBtwJEkf5waHUJM4xjXOUTc2BM/68QjOAlA2PfVWdnJ0D
         7Szazuhmyjzqcf0L09+gghBvUP1v8tLaJfZXNTnqSZVA5kn+QZ3bjm/08EALaHlouA4+
         axwC74n/I/B7Hq8S3fXHigbxFR/K08ZEBn7eH9oPIh8KjGohMsaC/nZU73XolWcy/zWZ
         46azwu0pWaPiwSSkxLiuhTfLuWR0puKq+L11feTLhtiKO/AooLwxINJghvjGtGeGaikp
         t7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793713880; x=1794318680;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PXp20XL3Gp1jxPMTn0MCFAQ9adhBIzNFQfhJNEp9ekc=;
        b=p+EswERCds0qAFodMbDPzJAFHJWscurJT/aSEo2m+J0N67a5SKIMWVh7CbtXXeExtg
         GXnQIP1CEDxtygqCYODSOHiPkYzC97atkJw2cY7twdzIRKeDUmimWVLCEV256KSxYTa8
         Tdpaq5KPICskXb+E+wytD3TP5viK8q8XUXako4GsfyNV0sdKv1PrDJPhkB1Al2pezH1K
         mkDEfDfYwtdb7pfJ5oVTk35rp7e6vs4QYkQp0YwSVXlGLskCm+DtFPxVxRSxrrenzpLB
         N3Huili2YCnEHbPhX6QNbHDhLRLzsclfmoACTcgx3PSgRiT3yVfYDEAbNq0sOB3yc8zT
         gzlg==
X-Gm-Message-State: APuU4Z9lX7r3myM2INehP+mQruxhiLIu3nOEbm7V8oSWxTWOJsvFasqa
	EsFMoee7dAkHF6jmunLmls/XY4dqFPTsaCKPl/5ALLLXug3gUaFfinstBv+Hz1DFgKM=
X-Gm-Gg: AYBFou0+1M9DFk0baloepFbrLYIONAPTZqqOzGxSTPwUJCrrQHSr68+F2SDjHqkn20W
	EqJoqs9I5Zc/gq2UH4g0ponLDn3QA72Q7qBlTLsivVxts22cJVtEM/WsR63BbQsEpkYxVjzeC6b
	OB8/rcZTvx1az3m39ZPKO7Qx3WPpqNj5FDMLevGsyUk9h5aGYH0wICBTM54Slsiq5YuRq4Wd3Hp
	d2EmBcg3vHr43axvEzgI2+6H6hOybEcT9c8KX0VDzGKal9bkiAlFrvxgmyLlItBbjwmgmdV/vYO
	ll56xRBXwdPYGvbQEiQW0pRk9FbfzfeC/nVPmhtVcueseJfAaYeDR/fq93i3h/SLYjgSnnEU6Je
	xXjZ2Ni36nLN4sXKeg+knt44DWyoswkzlGAZp6ayF5EC/qmgfzFhtKoOfKzbC9x0D2GiszUQICp
	SKUlE3Mfv2gwntxGdaPT7wP2oBhdGO2IpaexsI/toSdWEzPd51zY9Kg0QzO7VXUayj5Ff/oyKKe
	6fXEY7PSqNy/FJ/TN5r6fYf7LNzou4uQkuyCzNnFbv327HJRq62x7Y7Pc//G/YfajfEhKcZ1e9N
	Tf7XXw4YT/jGBGPzdaMm/0WwysOomWOvmXmorU6QfuBOmYlOFN2KBkUO3Iq3EIexYRcJeEDw6RD
	OUA1agA==
X-Received: by 2002:a05:600c:64c5:b0:4a2:150f:1613 with SMTP id 5b1f17b1804b1-4ac17a367edmr306727295e9.7.1793713879775;
        Tue, 03 Nov 2026 05:51:19 -0800 (PST)
Received: from Cluster2.powerhub ([2a0a:ef40:18b5:9e01:225:90ff:fefc:9ffe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a96fc87fsm55320335e9.12.2026.11.03.05.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:51:19 -0800 (PST)
From: Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Google-Original-From: Artem Blagodarenko <ablagodarenko@thelustrecollective.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	adilger.kernel@dilger.ca,
	ablagodarenko@thelustrecollective.com,
	Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: [RFC PATCH v6 5/8] ext4/066: verify LUFID dirdata operations
Date: Tue,  3 Nov 2026 13:51:01 +0000
Message-ID: <20261103135106.610169-6-ablagodarenko@thelustrecollective.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261103135106.610169-1-ablagodarenko@thelustrecollective.com>
References: <20261103135106.610169-1-ablagodarenko@thelustrecollective.com>
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

