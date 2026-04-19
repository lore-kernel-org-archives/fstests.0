Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF58C1E9B3D
	for <fstests@vger.kernel.org>; Sun, 19 Apr 2026 18:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776624741; cv=none; b=lTU+TgPOjlo33AV/vPUWU54mrwpinVuL95e3GcUvjEVT1v00lzQrMACLsIXFCeEtAmfksuo8Ncl1jpetf5ieFReLWw2GgDCtrFfZh2uSYx/qLZGHQgNibLK9ILEZgWaikY0iTxuQ1PqLYpoWJC7vQKOpXvi0H2NpHSAQMNbLWQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776624741; c=relaxed/simple;
	bh=e2ZXz9El51g1RD6EKfetxbYKJLS2iylvtEyIUN89uSU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=claWRtiehpBWCfMfFnVq5NkxgS2elDcpR6x9DC1QyJW/CsBw7fP7SFHpvURU+1Q3nZW67nMkT+egQ6J++RB45wSz2m31hus9g+HxSCAMx687ZmIjVnAUWZQusxBq9YeSzQBdEAbS6SoQ3WHNPrMcOdct0EoAiV7On77fK8aGOTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TfzKHuAr; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TfzKHuAr"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so36166185e9.2
        for <fstests@vger.kernel.org>; Sun, 19 Apr 2026 11:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776624738; x=1777229538; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JOLVEsbAJOmJN5pZrazzA23v63Rjq08BMGljx81/Nek=;
        b=TfzKHuArBaUrXTJaL0RCAR81Xw0thywXRU5DZGYoXtWroE4byv5C5m+iOlTw1ncp8Q
         ZV8Taf9SdMsUfwdy/ZCO0nyNfnyKBQpQSR8c5/Xt8D/AMeSLNLgIEsB2jGeILtkGGwTw
         Us/XQNKX7fM6az29zmnC8Mv4vDQyjQaFevsYd/SwfByEb7gnXCOOYGyuSWMmIqQASSXe
         oofRDvuiemk495dn+7IDxi+Kb8iBLSqTdKIVQDQ7RALx9aiGKfSs5emrA47Y9cuNq+QI
         D1YV9UIosZHdW+5Kn+lTmh+txGRHOG702rr6CHxKFYn+qSL7x0ZeXVU57XWjLEnV3cU7
         rqSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776624738; x=1777229538;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOLVEsbAJOmJN5pZrazzA23v63Rjq08BMGljx81/Nek=;
        b=Z2boOW4z+wscrU9+CT5O0Tto1bUP3qsEX3zeumHv1Lae+NgIh7MuhCIz7d8hjzKvre
         9Ue/JlWXfq63WVX7P4EEND068GCyE1rcZ+uQqC0GqYbcrwxBRifsRrVwp+Pf/sCrnd4M
         +rgcI/Vs5U2HcIvN2cCm9SxPIl5qzumMDKQsGDZ4aMuLW6nGq8Ssb2KvectjuSTTxZzL
         OX0gbLh/T6DbHxzSVOSCmr+MxwXh6CJrurfNYZvZ0HpyknE8+KBLEiaA/7MvcTSow35m
         zGGnSnOwZifw1qoZcwBOfikReaaE5FlRMmUDQrGyxRSlGyMrUv5CvsIb8rTWadSRxuJb
         AwIA==
X-Gm-Message-State: AOJu0Yz+AdYg3OUT6uGqIiYy14OmU3s7whFm/IlCWuVmY3xglTxX9dQi
	qsd0k6snUbQgl/L/WiNqvYzYq8n9J2a54NL0s0HBW0Oiw8jlcHTHpLByw0+nbfm9
X-Gm-Gg: AeBDieuYD9ZMEbnLo9JZA+/NkhBKJpw8j5G6J0IKyBs7/+gnwiqnqaJYq5XP9LQS3PN
	mYPzHlFQpA1ITIzN4l7Yp/56sEWtFBzZ+ZXTwQzBw3Qto287ko01zjz8XL0JB9oYIC6gM2YICIL
	ZjTkknDZru0+TbKAceS7yJG4YUcT/gMKtsNYrmgTborpLXhOEW1UcQUP+WcHWxo/YSwS3r1K4oN
	R9rhD+fBcwP+kcvilzRcJh0Pqq4N1+yorJJkrjt+4EMB0HisWfZSzLb0KgCfBI6e2W+1cVlKlWF
	Tc/HlzvZJi9wsDO64qekdxoqqmXwljb0QmRGr0tjs6Lji+Bmf6T92fpQeON1qQb1NY1sFZkPM7r
	vl9Go3bHQX0o247FZaglqcIU/m6b2xck9IWNz53RcO5RBmrDyNrDTfbRgI2B5nzNvnLYAkuZYtv
	utLU4pHFqcKBgVFQKzcH/WQ1Jpxkb/nzIPUBmFRRfUkQ==
X-Received: by 2002:a05:600c:1390:b0:483:709e:f238 with SMTP id 5b1f17b1804b1-488fb78ea6fmr151706415e9.29.1776624737759;
        Sun, 19 Apr 2026 11:52:17 -0700 (PDT)
Received: from Cluster1.local ([2a00:23c7:90c1:9201:ef47:d559:d907:fd0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c01cfsm234324695e9.10.2026.04.19.11.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:52:17 -0700 (PDT)
From: Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Google-Original-From: Artem Blagodarenko <ablagodarenko@ddn.com>
To: fstests@vger.kernel.org
Cc: adilger.kernel@dilger.ca,
	tytso@mit.edu,
	Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: [PATCH 1/2] ext4/064 encryption + casefold feature combination WITHOUT dirdata
Date: Sun, 19 Apr 2026 14:52:08 -0400
Message-ID: <20260419185209.4526-1-ablagodarenko@ddn.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Artem Blagodarenko <artem.blagodarenko@gmail.com>

This test verifies that files created in directories with both
encryption and case-insensitive (casefold) attributes work correctly.
See ext4/065 for the same test WITH dirdata feature enabled.

Signed-off-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>
---
 tests/ext4/064     | 154 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/064.out |  17 +++++
 2 files changed, 171 insertions(+)
 create mode 100755 tests/ext4/064
 create mode 100644 tests/ext4/064.out

diff --git a/tests/ext4/064 b/tests/ext4/064
new file mode 100755
index 00000000..6ad865a9
--- /dev/null
+++ b/tests/ext4/064
@@ -0,0 +1,154 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (c) 2026 The Lustre Collective.  All Rights Reserved.
+# Author: Artem Blagodarenko <ablagodarenko@thelustrecollective.com>
+#
+# FS QA Test ext4/064
+#
+# Test ext4 encryption + casefold feature combination WITHOUT dirdata.
+# This test verifies that files created in directories with both
+# encryption and case-insensitive (casefold) attributes work correctly.
+# See ext4/065 for the same test WITH dirdata feature enabled.
+#
+. ./common/preamble
+_begin_fstest auto quick encrypt casefold
+
+# get standard environment and checks
+. ./common/filter
+. ./common/encrypt
+. ./common/casefold
+. ./common/attr
+
+_exclude_fs ext2
+_exclude_fs ext3
+
+_require_scratch_nocheck
+_require_encrypted_casefold
+_require_command "$CHATTR_PROG" chattr
+_require_command "$LSATTR_PROG" lsattr
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
+# Create a filesystem with both encrypt and casefold features
+_scratch_mkfs -O encrypt,casefold &>>$seqres.full
+_scratch_mount
+
+# Test 1: Create an encrypted + casefolded directory and verify lookups work
+echo "Test 1: Basic encrypted casefold lookup"
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
+
+# Cleanup and verify filesystem
+_scratch_unmount
+_check_scratch_fs
+
+echo "Encrypted casefold tests completed"
+
+# success, all done
+status=0
+exit
diff --git a/tests/ext4/064.out b/tests/ext4/064.out
new file mode 100644
index 00000000..0197e51e
--- /dev/null
+++ b/tests/ext4/064.out
@@ -0,0 +1,17 @@
+QA output created by 064
+Test 1: Basic encrypted casefold lookup
+Case-insensitive lookup works in encrypted dir
+Original filename preserved
+Test 2: Conflicting names in encrypted casefold dir
+Content after writes: second
+Test 3: Unicode in encrypted casefold dir
+Unicode normalization works in encrypted dir
+Test 4: Directory operations in encrypted casefold dir
+Directory case-insensitive lookup works
+Test 5: Inheritance of attributes
+Attributes inherited correctly
+Test 6: Remove and recreate with different case
+Recreated file has new case
+Test 7: Hard links in encrypted casefold dir
+Hard link case-insensitive lookup works
+Encrypted casefold tests completed
-- 
2.43.5

