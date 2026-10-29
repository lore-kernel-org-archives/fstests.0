Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793276937;
	b=z46NV7SBGEPC0qRgJ7GCVtOvK1MeIF9MQNYg60m+yXc0cFTM4IQMzxnBqK/kmtDWE43i
	 UK+nHCs0keirebCZvb4GedePW2P85RTvNN97wpDaYHSz7alL+ovl/7oJCBjF981s7369h
	 t4x+U2qNmpyYWtrEsbtfeHluM+raREMfq+WOHasAAT8agc4AGm/QyukSJjLSkBywZZz3h
	 cVVIbHJFg5W8jQumn3Gyf+EXV0wIP+nkWN60V/pmff0Dnm1+x/1CrwW062iBFwn/AHoay
	 8YE7H0MOQRqoAjWox+yy6IGrQ2pZv1UNEkF5SjBfDCDN1sH2CkB0j1UhEE2PuXgD0Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793276937;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MwXaZde9zt0ozpMzF9BRrA+TxYTe7FGqdiTijLKAy5g=;
	b=rP6u+oGyhzAwQ5NVHy/vE5KvL/tKbRgYYyeYfo1Zb3IEiOZ7IVZIa0B+7bZpth0IMvyh
	 TXkoQfPZGVvTUL63DVxMLRZfle5IRV1ftMFgCing234U5yZezB+Oi+Kc/g+bKqCm5i6LM
	 I5QHSVUyb/uiHg2aNpvZ6UspjhEmfYqXggyYr4/FapfHmbqAmyfw4U+NPAbaQZ4dkkbW2
	 VS3a2MSBhp1Qs91hgenyKpQITwFZP0QtYB5YxHPPVg+XGq3X61NjFicPethO+Q+q8ZmA0
	 /tS1vPVz8377lEsyn+W9+Yq54lXcv2ZlQjfzKS47/kG1pET/woU8t0hNlkEg2Bf80sA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fYAGWXHw;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C61606A32C
	for <fstests@vger.kernel.org>; Thu, 29 Oct 2026 12:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01C61606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fYAGWXHw
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so13150425e9.3
        for <fstests@vger.kernel.org>; Thu, 29 Oct 2026 05:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793276935; x=1793881735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MwXaZde9zt0ozpMzF9BRrA+TxYTe7FGqdiTijLKAy5g=;
        b=fYAGWXHw6S9d5bPOxRA+J2bZGQETdgnTTZ7rqGB6iLmHoZAwru79/jtq70Fia79KXq
         bKnF7ORbuvlvS/nXZp/1gnZk7CjApR9HHNoXQkMfHVVyylUFcTfg/Ibyt1tpgrPDkSl5
         6HXZuDwyz801SQ6AcHaOkIVuj4Lq+02V7ty7yKesmacWwHMVXu5BTzHTZzlK7uYFdqUN
         ueC+vSdkOIHi6UlaWn2KY2HE1YhlDTcV1TGM4Ycue7Rgheit7/1i78yTtR2jLiDF+4RZ
         7yhVJQEZweP0LADIq3o9AnmDBMxn5CrNEQEgwp60RZMpk/yMH90uM5YSUUzKvx9UFp3z
         NubA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793276935; x=1793881735;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MwXaZde9zt0ozpMzF9BRrA+TxYTe7FGqdiTijLKAy5g=;
        b=v5xZfdoexwkNbS7koIGFjA7kXWTluFX0LVXYYGJTT9/j1ty+ASqtENDKk2ajE59amF
         0pypTp8w7/jMuiWEx9O+e62iqgqJZhy3I4Ay3S3s0lSHLy/cPEdRi4iH2JTzRWvLMATI
         kftoGzMDXXjEFgu0hZFI7i2kOINmGCq7W0h6wUOPVddxMj6ycORhTbBTCvTXhersBv/0
         jdMfB2My7pXQNv5tLBzUCsrAIWoRIqrX+WtZDX1plgqYIPyAV4CVvajEXMirlGWoE+vQ
         N/JMaO0y4Ouwdo/cvnTKPyeC0Y/ajO+lnG7Q1rEKpWdrf1Zcsezg0TFXEz6Y+dH4B2Km
         +vpw==
X-Gm-Message-State: AFq9FYKF4IwHfP4/+UdPQ+so8GZOONmqZJ65mweVRGFNzHD1RNvLB1KK
	fPrwhK6qRX3ZrdGOmcytrgm1AxPh83RBtFeZMdKvRfAxniGeeZNM4Dtiy/2ERb2U
X-Gm-Gg: AYBFou3Kqd/EKNCNfaJssCgQw9Q3iuStVaBFtGWFmlO9mtyGtIOHt+xF+vqiIdgON1G
	v15t0/ssIE1VNhkE2s12ONfjljJTQK9xBR79X5DwBWZND5Go0RIhtjtiMVoCJnnF6JZVbMXa3SJ
	05mLK4P/R84W9zH8jYsDDVWhFi6QohEFvIoFgHLGMDgX6THkKfl/+/mdYHERMo4VkM0n2qpGBWY
	nI7RRpfPe8JSO0/HEAy9EyhVW1mN2aamqdzqQWRImcGOQmoU3u0t5Ac0C3co4dX/XVoQn4TSDbB
	QBQ6pIILgdT3HIvC92FAqmmhj8P5WwZNjZiW7XCDRU+SCVzLC6otmJm1nSN35+gO0DJSQCX1oo7
	QmLDjjHessRL/iqbXrZlrdzbH+N/eV5CUW5mzqVEzMtwJOr5M6LzUjkj2wq1PaCUU9gEyIZLyqT
	1cHH52dFa11V/HDSH+1CLVxXMd+CXN43aVAvX8L77qBcx84QlcyutTnmSSEDdEYIA2JuNS50X8a
	kaW6mWu+hxK2f75aMWFFQ1ssPBM8MQzAD6xpEfn3MYffCVJ/9EfskQTV3qzk1P3+CYuc8ibYD0F
	64cwh4onUwqLbANvVECwXq+qx/ZCpOeJXpGLSiugkw1QIoh+BWFePfR4mW9k
X-Received: by 2002:a05:600c:870f:b0:4a1:fcfa:2a07 with SMTP id 5b1f17b1804b1-4a967f84822mr135544095e9.30.1793276935311;
        Thu, 29 Oct 2026 05:28:55 -0700 (PDT)
Received: from Cluster2.powerhub ([2a0a:ef40:18b5:9e01:225:90ff:fefc:9ffe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f7f50d3sm92477915e9.8.2026.10.29.05.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 05:28:54 -0700 (PDT)
From: Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Google-Original-From: Artem Blagodarenko <ablagodarenko@thelustrecollective.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	adilger.kernel@dilger.ca,
	ablagodarenko@thelustrecollective.com,
	Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: [RFC PATCH v5 2/8] ext4/064 encryption + casefold feature combination WITHOUT dirdata
Date: Thu, 29 Oct 2026 12:28:33 +0000
Message-ID: <20261029122842.230704-3-ablagodarenko@thelustrecollective.com>
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

This test verifies that files created in directories with both
encryption and case-insensitive (casefold) attributes work correctly.
See ext4/065 for the same test WITH dirdata feature enabled.

Signed-off-by: Artem Blagodarenko <artem.blagodarenko@gmail.com>
---
 tests/ext4/064     | 153 +++++++++++++++++++++++++++++++++++++++++++++
 tests/ext4/064.out |  17 +++++
 2 files changed, 170 insertions(+)
 create mode 100755 tests/ext4/064
 create mode 100644 tests/ext4/064.out

diff --git a/tests/ext4/064 b/tests/ext4/064
new file mode 100755
index 00000000..53450927
--- /dev/null
+++ b/tests/ext4/064
@@ -0,0 +1,153 @@
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
+_require_scratch_encryption
+_require_scratch_casefold
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
2.52.0

