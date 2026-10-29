Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276938;
	b=OR5nUe1EnGNZJ2je6FRyR4hTip28lWXBayNDwBwDXQHWRQMydRc/UfDD+IYTfYIK1EDz
	 XEYlq2K9ny8JeZpNvElKR6Nb1Jzb2tSrWPnmVgtXiaAbZibu+SpKqU9jJXFbw9FhgmQDn
	 RLEf1nIKrHst7xEeuuCcFkFqa0hfc3T9ynGU+pRnCQ2AKUx/uEvR5GgHdN8PF0Cxayexy
	 tMzNoYamR924Ct67lhgQgn4niN5OBDDEn/bCKBRodeCQtVLlEBxRwaBG1d0eIXscYLWC9
	 VL1YthdCQ7sK49tFQ/HKqU60mzm2kkLnFiLFxVmY39R42Q2r416dzDHGPAmojpk74RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UcfbjUbt3TsKg3vyIYDkse8xWvJAfIv3IG9VfRSpZwI=;
	b=029inVlVE7X7YDkNMcF9SWby7DQDfOFL2AeWdSr1+q8WxN7PTAiJCmqUpnSozR9si9St
	 qVgxuh05Glq/OfJyGqK6Hy0yCh/NmGciDb/Wl+b+goq36ULe4N9Sh8ZOvXAbgf79+P6Ts
	 dCXW8ymw5Vkt/Kp5oGHGkn5Or/q3oDjcf4AQp6zKjK30Rf+94dvQAUp6Vw6OJ7lZAHJVH
	 wnX6ZprFggWhN4LPvJOReBjqv6sQ0ac0u0V/NyI5su+hfWfsu1Trc/I6xGuDZJmy3bR7j
	 WaGP+CiYpqaLObOSOGJ6eV0wntQOV9KzIXvsnH+kLCDc1F8WLG1STRmAxndgCDWbGtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cU8at70g;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB22606A339
	for <fstests@vger.kernel.org>; Thu, 29 Oct 2026 12:28:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEB22606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cU8at70g
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a35ac4475dso15750485e9.2
        for <fstests@vger.kernel.org>; Thu, 29 Oct 2026 05:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793276936; x=1793881736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UcfbjUbt3TsKg3vyIYDkse8xWvJAfIv3IG9VfRSpZwI=;
        b=cU8at70geVcwg83s2j3qcqN9AUN2Jvy5F31ofKOmjh8ArnaPZ4IRDD1+pXFfQLl8WE
         nOyPcvGqnoMWkzH/8N6yztXPPXvzpK4GrviKC4il/Ol28GaPMUCG6ifgsxk155KL1ou7
         r3rJCfdCln/UNfNjKqFeAd7M8ju+vYhfo9a/Yhf+kaoicyPBx0LJl/FqpaPMZZG8h0qK
         196mlQ2ZhWzWT+1SwAit7xcctheZFLLEwvaroucq2jCpXAJEsBSoToPyZv7yeLJhV/ss
         IUmQAUTfS9b0gUrCfMGnntEL0nIssJ00OsBJNyC/8gXLNrDxonHG9rRQq6VODHfW3Y0a
         Jl3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793276936; x=1793881736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UcfbjUbt3TsKg3vyIYDkse8xWvJAfIv3IG9VfRSpZwI=;
        b=1VjdJ/ZZznrpYzSfFS3IYn8IDW3Qrj4VnqAFx0/jUOn1CYbW+869Hs8U8R4bVlLhYW
         Brfsa/llIuh6P+O13P1e2WgAAFrSpas6gNRJzptIgtw6LoBDmZAvpF89rml8zLNGkt2E
         +60mHODBY1VspCKiYKwbb6Utl/1ajXnTjJkisrfWj/8CzfmGwyLS4/lLPbBZWypoi3jb
         Q0QBwCVwBOgaoP2Y8caAtvvkOknhsSFId2H/cc8YEVgprFO++dfOUKVYiE8GxamZbu/5
         pSnOH5hWee7TuT2rzRUumPe9Q9ybueWnMXHHLgUWxPFx6oNg1YvjdN/QMZGGjXZLQe//
         sx7A==
X-Gm-Message-State: AFq9FYKgKKMokXuC+SGozEYCxuWh4reAlQZe6UyRLhV5D6V/13PLNVpD
	T8fLYU9UihjLPtjXE9gztOlqsmiD5+MjtpquptwLwOrLx+Ximj+cKxlPhVMgUcwE
X-Gm-Gg: AYBFou2OT0PIeoO+n+1s00BFpZfzB1K4P56TGKB8Mv7tIZeKtUlRno2pJI3HeGAizfP
	geIJ0+PfQePx8shmDqw/iOUnWDbzSRNJfJQigqoDMOQBcfAaad63sh55sbEd5Gv56pH+dQE5Q5D
	ziNG02ZKrzEcWkYgbfmedceNjuziMbMyoZogy87fmzwMYWTGEjCEuFYXAjForrcWka4FEUfySS0
	j6cx7e/u5iHOpRIN4EUk6LlhX2gpsL3IHAZY3vggzJCbg7PPb5KnJEbFu+m6U5Eit9vCxBDoiOo
	1PaTvXxdkn9drlRiEk0gsd7fLyZT4sjWyarPrhwByBwrjqYAAKgkJr403oVcMgWepRYNfLBSL6E
	zHJIffFxHP6SC4cbTLPB62PIBfKjjXRV7IRT+6/L5HyNM7v11vkeHbxWoLEpCCi41sm3yiISxPh
	TfUmAnSRorY74B7L5pyQfiUl27VKWn7mCRRCtOTxa0vY9Z0mpnHxaYfA7O8sOLB8bgKA/G8+U/M
	CELb4f8eybR7wSn8g22F+ekZLq3nokYEtKeO18SnPuxiRMFFCc/qXOUHLhq8XAHYXzXWqJ1xj9C
	rYau3nYiS7T1xvfoA5pq9MRILyLbC3RvN8BoqYaGhQJQa9l9kQjyex3B2Z7Y
X-Received: by 2002:a05:600c:8b78:b0:49f:fd2d:23c7 with SMTP id 5b1f17b1804b1-4a9672fa52cmr117559065e9.27.1793276936027;
        Thu, 29 Oct 2026 05:28:56 -0700 (PDT)
Received: from Cluster2.powerhub ([2a0a:ef40:18b5:9e01:225:90ff:fefc:9ffe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f7f50d3sm92477915e9.8.2026.10.29.05.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 05:28:55 -0700 (PDT)
From: Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Google-Original-From: Artem Blagodarenko <ablagodarenko@thelustrecollective.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	adilger.kernel@dilger.ca,
	ablagodarenko@thelustrecollective.com,
	Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: [RFC PATCH v5 3/8] ext4/065 encryption + casefold + dirdata feature combination
Date: Thu, 29 Oct 2026 12:28:34 +0000
Message-ID: <20261029122842.230704-4-ablagodarenko@thelustrecollective.com>
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

Test ext4 encryption + casefold + dirdata feature combination.
This test verifies that files created in directories with encryption,
case-insensitive (casefold), and dirdata attributes work correctly.
See ext4/064 for the same test WITHOUT dirdata feature.

Signed-off-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>
---
 tests/ext4/065     | 252 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/065.out |  26 +++++
 2 files changed, 278 insertions(+)
 create mode 100755 tests/ext4/065
 create mode 100644 tests/ext4/065.out

diff --git a/tests/ext4/065 b/tests/ext4/065
new file mode 100755
index 00000000..b86d3146
--- /dev/null
+++ b/tests/ext4/065
@@ -0,0 +1,252 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 The Lustre Collective.  All Rights Reserved.
+# Author: Artem Blagodarenko <ablagodarenko@thelustrecollective.com>
+#
+# FS QA Test ext4/065
+#
+# Test ext4 encryption + casefold + dirdata feature combination.
+# This test verifies that files created in directories with encryption,
+# case-insensitive (casefold), and dirdata attributes work correctly.
+# See ext4/064 for the same test WITHOUT dirdata feature.
+#
+. ./common/preamble
+_begin_fstest auto quick encrypt casefold
+
+# get standard environment and checks
+. ./common/filter
+. ./common/encrypt
+. ./common/casefold
+. ./common/attr
+. ./common/ext4
+
+_exclude_fs ext2
+_exclude_fs ext3
+
+# Check if dirdata feature is supported and can be used with encrypt+casefold
+_require_scratch_dirdata()
+{
+	if test ! -f /sys/fs/ext4/features/dirdata ; then
+		_notrun "dirdata feature not supported by kernel"
+	fi
+
+	# Debug: log e2fsprogs tool paths and versions
+	echo "=== _require_scratch_dirdata debug info ===" >> $seqres.full
+	echo "E2FSCK_PROG: $E2FSCK_PROG" >> $seqres.full
+	echo "E2FSCK_PROG resolved: $(type -P e2fsck)" >> $seqres.full
+	echo "MKFS_EXT4_PROG: $MKFS_EXT4_PROG" >> $seqres.full
+	echo "fsck -t ext4 resolves to: $(type -P fsck.ext4)" >> $seqres.full
+	$E2FSCK_PROG -V >> $seqres.full 2>&1
+	$MKFS_EXT4_PROG -V >> $seqres.full 2>&1
+	echo "=== end debug info ===" >> $seqres.full
+
+	# Also verify that mkfs supports dirdata
+	if ! $MKFS_EXT4_PROG -O dirdata -n $SCRATCH_DEV &>>$seqres.full ; then
+		_notrun "mkfs.ext4 does not support dirdata feature"
+	fi
+
+	# Verify kernel can mount filesystem with encrypt+casefold+dirdata
+	echo "Running: _scratch_mkfs -O encrypt,casefold,dirdata" >> $seqres.full
+	if ! _scratch_mkfs -O encrypt,casefold,dirdata &>>$seqres.full ; then
+		_notrun "failed to create filesystem with encrypt+casefold+dirdata"
+	fi
+	if ! _try_scratch_mount &>>$seqres.full ; then
+		_notrun "kernel cannot mount filesystem with encrypt+casefold+dirdata"
+	fi
+	_scratch_unmount
+}
+
+_require_scratch_nocheck
+_require_scratch_encryption
+_require_scratch_casefold
+_require_scratch_dirdata
+_require_xfs_io_command "set_encpolicy"
+_require_xfs_io_command "add_enckey"
+
+# Helper to add a v2 encryption key and set policy on a directory
+_setup_encrypted_casefold_dir()
+{
+	local dir=$1
+	local raw_key=$(_generate_raw_encryption_key)
+	local keyspec=$(_add_enckey $SCRATCH_MNT "$raw_key" | awk '{print $NF}')
+	_set_encpolicy $dir $keyspec
+	_casefold_set_attr $dir
+	echo $keyspec
+}
+
+# Create a filesystem with encrypt, casefold, and dirdata features
+# Debug: log e2fsprogs tool paths and versions
+echo "=== e2fsprogs debug info ===" >> $seqres.full
+echo "E2FSCK_PROG: $E2FSCK_PROG" >> $seqres.full
+echo "E2FSCK_PROG resolved: $(type -P e2fsck)" >> $seqres.full
+echo "MKFS_EXT4_PROG: $MKFS_EXT4_PROG" >> $seqres.full
+echo "FSCK_OPTIONS: $FSCK_OPTIONS" >> $seqres.full
+echo "fsck -t ext4 resolves to: $(type -P fsck.ext4)" >> $seqres.full
+$E2FSCK_PROG -V >> $seqres.full 2>&1
+$MKFS_EXT4_PROG -V >> $seqres.full 2>&1
+echo "=== end e2fsprogs debug info ===" >> $seqres.full
+
+_scratch_mkfs -O encrypt,casefold,dirdata &>>$seqres.full
+_scratch_mount
+
+# Test 1: Create an encrypted + casefolded directory and verify lookups work
+echo "Test 1: Basic encrypted casefold lookup with dirdata"
+mkdir $SCRATCH_MNT/test1
+_setup_encrypted_casefold_dir $SCRATCH_MNT/test1 > /dev/null
+
+# Create file with lowercase, lookup with uppercase
+echo "hello" > $SCRATCH_MNT/test1/testfile.txt
+if [ -f "$SCRATCH_MNT/test1/TESTFILE.TXT" ]; then
+	echo "Case-insensitive lookup works in encrypted dir"
+else
+	echo "FAIL: Case-insensitive lookup failed in encrypted dir"
+fi
+
+# Verify the exact name on disk is preserved
+if _casefold_check_exact_name "$SCRATCH_MNT/test1" "testfile.txt"; then
+	echo "Original filename preserved"
+else
+	echo "FAIL: Original filename not preserved"
+fi
+if ! _dump_dir_structure $SCRATCH_MNT/test1; then
+	_scratch_unmount
+	_check_scratch_fs
+	status=1
+	exit
+fi
+
+# Test 2: Create files with different case variations
+echo "Test 2: Conflicting names in encrypted casefold dir"
+mkdir $SCRATCH_MNT/test2
+_setup_encrypted_casefold_dir $SCRATCH_MNT/test2 > /dev/null
+
+echo "first" > $SCRATCH_MNT/test2/MyFile.txt
+# This should fail or overwrite since "MYFILE.TXT" is equivalent
+echo "second" > $SCRATCH_MNT/test2/MYFILE.TXT 2>/dev/null
+content=$(cat $SCRATCH_MNT/test2/myfile.txt)
+echo "Content after writes: $content"
+if ! _dump_dir_structure $SCRATCH_MNT/test2; then
+	_scratch_unmount
+	_check_scratch_fs
+	status=1
+	exit
+fi
+
+# Test 3: Unicode normalization in encrypted casefold dir
+echo "Test 3: Unicode in encrypted casefold dir"
+mkdir $SCRATCH_MNT/test3
+_setup_encrypted_casefold_dir $SCRATCH_MNT/test3 > /dev/null
+
+# Test with UTF-8 characters
+fr_file1=$(echo -e "cafe\xcc\x81.txt")
+fr_file2=$(echo -e "caf\xc3\xa9.txt")
+echo "french" > "$SCRATCH_MNT/test3/$fr_file1"
+if [ -f "$SCRATCH_MNT/test3/$fr_file2" ]; then
+	echo "Unicode normalization works in encrypted dir"
+else
+	echo "FAIL: Unicode normalization failed in encrypted dir"
+fi
+if ! _dump_dir_structure $SCRATCH_MNT/test3; then
+	_scratch_unmount
+	_check_scratch_fs
+	status=1
+	exit
+fi
+
+# Test 4: Directory operations in encrypted casefold dir
+echo "Test 4: Directory operations in encrypted casefold dir"
+mkdir $SCRATCH_MNT/test4
+_setup_encrypted_casefold_dir $SCRATCH_MNT/test4 > /dev/null
+
+mkdir $SCRATCH_MNT/test4/SubDir
+if [ -d "$SCRATCH_MNT/test4/SUBDIR" ]; then
+	echo "Directory case-insensitive lookup works"
+else
+	echo "FAIL: Directory case-insensitive lookup failed"
+fi
+if ! _dump_dir_structure $SCRATCH_MNT/test4; then
+	_scratch_unmount
+	_check_scratch_fs
+	status=1
+	exit
+fi
+
+# Test 5: Verify inheritance of casefold+encryption in subdirectories
+echo "Test 5: Inheritance of attributes"
+mkdir $SCRATCH_MNT/test5
+_setup_encrypted_casefold_dir $SCRATCH_MNT/test5 > /dev/null
+
+mkdir $SCRATCH_MNT/test5/child
+echo "data" > $SCRATCH_MNT/test5/child/file.txt
+if [ -f "$SCRATCH_MNT/test5/CHILD/FILE.TXT" ]; then
+	echo "Attributes inherited correctly"
+else
+	echo "FAIL: Attributes not inherited"
+fi
+if ! _dump_dir_structure $SCRATCH_MNT/test5; then
+	_scratch_unmount
+	_check_scratch_fs
+	status=1
+	exit
+fi
+
+# Test 6: Remove and recreate with different case
+echo "Test 6: Remove and recreate with different case"
+mkdir $SCRATCH_MNT/test6
+_setup_encrypted_casefold_dir $SCRATCH_MNT/test6 > /dev/null
+
+echo "original" > $SCRATCH_MNT/test6/RemoveMe.txt
+rm $SCRATCH_MNT/test6/REMOVEME.TXT
+echo "recreated" > $SCRATCH_MNT/test6/REMOVEME.TXT
+if _casefold_check_exact_name "$SCRATCH_MNT/test6" "REMOVEME.TXT"; then
+	echo "Recreated file has new case"
+else
+	echo "FAIL: Recreated file case incorrect"
+fi
+if ! _dump_dir_structure $SCRATCH_MNT/test6; then
+	_scratch_unmount
+	_check_scratch_fs
+	status=1
+	exit
+fi
+
+# Test 7: Hard links in encrypted casefold dir
+echo "Test 7: Hard links in encrypted casefold dir"
+mkdir $SCRATCH_MNT/test7
+_setup_encrypted_casefold_dir $SCRATCH_MNT/test7 > /dev/null
+
+echo "linkdata" > $SCRATCH_MNT/test7/original.txt
+ln $SCRATCH_MNT/test7/original.txt $SCRATCH_MNT/test7/hardlink.txt
+if [ -f "$SCRATCH_MNT/test7/HARDLINK.TXT" ]; then
+	echo "Hard link case-insensitive lookup works"
+else
+	echo "FAIL: Hard link case-insensitive lookup failed"
+fi
+if ! _dump_dir_structure $SCRATCH_MNT/test7; then
+	_scratch_unmount
+	_check_scratch_fs
+	status=1
+	exit
+fi
+
+# Cleanup and verify filesystem
+_scratch_unmount
+
+# Dirdata analysis summary
+echo ""
+echo "Dirdata analysis:"
+echo "=== e2fsprogs debug info (before _check_scratch_fs) ===" >> $seqres.full
+echo "E2FSCK_PROG: $E2FSCK_PROG" >> $seqres.full
+echo "E2FSCK_PROG resolved: $(type -P e2fsck)" >> $seqres.full
+echo "fsck -t ext4 resolves to: $(type -P fsck.ext4)" >> $seqres.full
+echo "FSCK_OPTIONS: $FSCK_OPTIONS" >> $seqres.full
+$E2FSCK_PROG -V >> $seqres.full 2>&1
+echo "=== end e2fsprogs debug info ===" >> $seqres.full
+
+_check_scratch_fs
+
+echo "Encrypted casefold tests with dirdata completed"
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/065.out b/tests/ext4/065.out
new file mode 100644
index 00000000..c1316430
--- /dev/null
+++ b/tests/ext4/065.out
@@ -0,0 +1,26 @@
+QA output created by 065
+Test 1: Basic encrypted casefold lookup with dirdata
+Case-insensitive lookup works in encrypted dir
+Original filename preserved
+  Directory structure of test1: OK (dirdata verified)
+Test 2: Conflicting names in encrypted casefold dir
+Content after writes: second
+  Directory structure of test2: OK (dirdata verified)
+Test 3: Unicode in encrypted casefold dir
+Unicode normalization works in encrypted dir
+  Directory structure of test3: OK (dirdata verified)
+Test 4: Directory operations in encrypted casefold dir
+Directory case-insensitive lookup works
+  Directory structure of test4: OK (dirdata verified)
+Test 5: Inheritance of attributes
+Attributes inherited correctly
+  Directory structure of test5: OK (dirdata verified)
+Test 6: Remove and recreate with different case
+Recreated file has new case
+  Directory structure of test6: OK (dirdata verified)
+Test 7: Hard links in encrypted casefold dir
+Hard link case-insensitive lookup works
+  Directory structure of test7: OK (dirdata verified)
+
+Dirdata analysis:
+Encrypted casefold tests with dirdata completed
-- 
2.52.0

