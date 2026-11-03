Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793713879;
	b=bc4IjFnVr0QeEIrkIbRz4tfKuYR2nVtX/AWwQN3rjmzfc/oROfW8mqsKbrcxhaF4bcBZ
	 wmNAJM5b/4IeXazt4jksdQAqIJF6UIF4U/a1ierUt+HpfAgzEZmvK1XLaCRB1qlen5oZt
	 PBTtEO/ZhGS5GtH4dG8UuHJLn8JP3I1zcjDE2LtJfJPrk2nciCgb/5Bqvv+q3HpRPHFc3
	 ETUkj8iaZMIKQfY68TUZnJHlzzBNDleejGZc+Rk13/uc8bwBIQjZB18KSeYwVDkknnL6e
	 X9C1CNmgomcnMRKx57oaKaQ4hkhNtjPRyEHORnxjhzL1dwhGEssoz2LVtPcxGO78fPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793713879;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:
	 X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MwXaZde9zt0ozpMzF9BRrA+TxYTe7FGqdiTijLKAy5g=;
	b=KIFgEZ9CenjBVjFUJqa2mOOpT6FHSBp6oXRNhwORCrutELjIjNMVo6DRSxhIr4iPWJ8q
	 yktP6+hMyTpCiKCVP6aAx4wRzo8EugOLzg2WFa7I+Abs0QCsItq/28XfqU+e7WphmzhZ6
	 6uWrFg1H1P+44zk2/V1zsV6WX8kQUkhGNS7n2tDRUimRIu4gMmpaaLJI42I1HjKNGARUJ
	 oHut3C2Bg3iIkHlgW7NIkzZCfTEyOsaHCC4HJFJjgTT5IaYqDjD0gYzPafpgk+kTqQo7F
	 sZFvql4rSGoKkyb6N1qzuP91zLy0lmiMmlOkoMYz7UTrij3eXACMAStQKVs8hM/Wokw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KyOlnZc+;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D123C6083610
	for <fstests@vger.kernel.org>; Tue,  3 Nov 2026 13:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D123C6083610
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KyOlnZc+
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso42323215e9.3
        for <fstests@vger.kernel.org>; Tue, 03 Nov 2026 05:51:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793713877; x=1794318677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MwXaZde9zt0ozpMzF9BRrA+TxYTe7FGqdiTijLKAy5g=;
        b=KyOlnZc+QvwAWP3UW5o/ntrcS+rrLsDNS2iqw7OOAJ5JplAQZmAh4QoZydUci8Ykzl
         WiQ/XMoa+gnNDmP9i+lAMoEWK9NJ4lWyLGmPx1HxEnO20dv4vlrpVVgcNwz+FQQih/RD
         Vmatg8PQVw9j8W+mbMpOV67QgdVpVYX5jo4LN4DM2wJHLmdCBU4cHWSu8KBh+xO3bTki
         eTyguX4LmWTrPlQjlXQvyYptFbSC9Kh01KnabrzmpjrKe34Pi4AdW0fsBCrbw7XFDwJZ
         DQja+NnLwqNjvHn4em4tsSLxwluvOFilcHt7o/IszNXNUisO3sgqsCH5Cp7ArEO2v4Pi
         TBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793713877; x=1794318677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MwXaZde9zt0ozpMzF9BRrA+TxYTe7FGqdiTijLKAy5g=;
        b=f6ZTI3g9zTPMaHhycPAajU1Q3LJCfsNZVz9gdmHPhm+VJ9mjfEhW1qQXqXOhltbEG7
         zx6wucgG/3pURBJFuNS8u3Kl7lF9Zlm0GCzbO82V2ZC6Yux6FNWzllMESxtUAo+Cgd71
         UNSJW0saC+xaY0H12aYqgTV+AD+wCsstUe4o285g3elZTo8n9J9FQzVEOXxTwiQgrEI2
         BIAnYnEGd0bfYdSAybBIM8o+iJBdq8rTIyUF1EZe2C46APtzmR5nWy/c92jev4dt182M
         8G3AOBiK6UktFk2zV1L9SVbReJR8fCw8GF6JmJJeriB19z9g94XLqqLsvPSnHAyT6qtt
         oBSw==
X-Gm-Message-State: APuU4Z/gN92mNP6uV+/LP/ZQdQlI6k4cmNe1K0TzKVH9PWz9O18U0GAI
	3fiudOqJ+P7Y0RPTPSasS4RPgodNwceSOqxYQEvIYpVIPnI827FwdxqduW1wJu6i4+k=
X-Gm-Gg: AYBFou3PF1QmR7Nl8uwOO9pQcKWnf03WQsEJgJyqSwO4glM+OAB6hk3A0Fmj3HWMTPc
	JdsTcwfZH9YMsWa28thlajxe3xakkT4pbiKbm/z1WC2fFLxjENatI/fkkmGaw29F4Jq16vhJG4Q
	8w1jmB1+xOLlQLnA1Jgyq0/83ZYp727Ae7bdTeB43AQASCFdURq921nqJtlN7GyKkvJrAQ7fqqu
	YJzNvCHO1Yt11YUjgA2SrRZ+yInDiGdtasVudJGSjz8bkIesCNpH7pmwSuQfWzOEduslouHwArx
	LURcHBS4VcVkDpg/3+vWHD+ommqjN9EC9/rRffwnO0rKOzGbsU4m2Vl9WDLxI1sxD/NsIkGCqhE
	3R4aJsq4nXPEzcEhVFccpH5wZ4sXZqknwkYlv65pD8vKpLfADZvV5T3MIkFon1x9W2JepftPJsF
	Fb7ubL7hw9D7NSzz1neD/ViYVPJNzVRHfjNuyq4F4wpVRp5zr26p30Wj/DZtWS5fLRxqWLkIIMa
	Yqooww0DgE/2ou7q/Wj9MU+oUAiIz2bARJweJP1r8ZAo/oJOUNPzWR+stvJwwILN/vnYyolv3/E
	t43aPYOmSTR9VPWY8AcoyvEHg4BBxG49fEXq5GghEkfOnwmjFi8miBk0PdQ3
X-Received: by 2002:a05:600c:8b66:b0:4a3:5a91:5f61 with SMTP id 5b1f17b1804b1-4ac1793f8ddmr314485035e9.14.1793713877155;
        Tue, 03 Nov 2026 05:51:17 -0800 (PST)
Received: from Cluster2.powerhub ([2a0a:ef40:18b5:9e01:225:90ff:fefc:9ffe])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a96fc87fsm55320335e9.12.2026.11.03.05.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 05:51:16 -0800 (PST)
From: Artem Blagodarenko <artem.blagodarenko@gmail.com>
X-Google-Original-From: Artem Blagodarenko <ablagodarenko@thelustrecollective.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	adilger.kernel@dilger.ca,
	ablagodarenko@thelustrecollective.com,
	Artem Blagodarenko <artem.blagodarenko@gmail.com>
Subject: [RFC PATCH v6 2/8] ext4/064 encryption + casefold feature combination WITHOUT dirdata
Date: Tue,  3 Nov 2026 13:50:58 +0000
Message-ID: <20261103135106.610169-3-ablagodarenko@thelustrecollective.com>
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

