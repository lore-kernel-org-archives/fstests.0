Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2045A285041
	for <fstests@vger.kernel.org>; Tue, 18 Nov 2025 07:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763451331; cv=none; b=DF/TZrTr3ldo1oaec/dj8GqT3IH+Cy56i+XjNatlT46LBImmxQydpVnI97HXervKQAQiL8pkeBWJlLBb5GAINxHn/46PWSaSn5Ueb7C9inqeUOgGsLZlV2NGMCX3DKZQ2BiH0u8DrTu4pF01LwyEXpq9DI0BQDRuJV92+984PmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763451331; c=relaxed/simple;
	bh=XVAWyKzt1bYt9jpYTmjEVmTIDb6x305gdOQ85BCuj4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q6UtYzCvQAIAid77ndG7D9gJ62REy2jKh4HNetnFBko4eoLrvnhfxuPclLdd+4ofqC+7owtZ3ItUSUU47ZR/opGJwlgpR0QpFgAhRolpyub7YD42NbNhkR3YnFuOyEhVnzvzaI+zzoXW6UPP/lnRC+XyUtBrKs+MouNVjl3PyfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OdIv4/c2; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OdIv4/c2"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-343d73d08faso4672820a91.0
        for <fstests@vger.kernel.org>; Mon, 17 Nov 2025 23:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763451329; x=1764056129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uTRo4S4W+AYlowFpVgzM04+bbe83GqG0z8F03lkjbS0=;
        b=OdIv4/c2Ol5vOJUb/nckt7xv0nFjOft51w74JlX7Zyr2w/HVc6r3WRqlNoHQ20ddm4
         iky/XPX9bfO2vN4tVFCVH10YNFfvn474hmLTCvuk5ibO8L132m9sG9CNlSTVoCXRNOGt
         zMucKoiXRXB8JVk2ol8hc69AyQeKqiEObqkgmVAu8KVyc0ifhTRwJZjjIFNiM1vQYVv4
         xuIYRB5H8HWlZjYO3mW9usaQx7G+1XgJ2sr2tsmTWxkf1uyxgwrop4JgCZxjApWSTayp
         kC2ru/SMvaEbA1Mv1RYOqUG9LwTAfkGCOX1Ul43mTZIEaWn160gIhMXa3YahrBEBQcFc
         1xNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763451329; x=1764056129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uTRo4S4W+AYlowFpVgzM04+bbe83GqG0z8F03lkjbS0=;
        b=Ikz0jy/WktbwpWW/eKIMY+NXpFufzrUSSitWIab4imjM3912vNSSa9bkOjCS7dyfCy
         JcWWSK3bN28e3XyM71C4se0zq+zwcClpOenm5/bpc59FTIRTwXvdfN9EStN37MKQOO+j
         IQBFSaq8V0hBG97AtUPQMe6dDv+yV+O3ftIzwna479TqAVhcYv9iFx0Z9LsNzLYwQ/Kk
         nZHts8Dq7HHfKMA+69UoMno9qjFlG+4UEF5rCn8tnWuRvc2Fmxl8aYMTJQwJfgGW7Ww6
         /htMhKDJHMwP6YlgXHOmmgi98HqLAU+cIlHgmcb+JMOZiSSDprUAN7WaCp4sXJ9n7Tvf
         dZ8A==
X-Forwarded-Encrypted: i=1; AJvYcCXUbHmdrCz4ITDeHdcUcGMqX/p+kwRVHcmwADTi8R7O4q4AZwwTtHwOK8HfL3M4oI7bLjwIAU1U@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ6dAU509xTR1apn9idN8BMsKEMWv7uNFtp10DOZxyDilwrqyx
	NYmgkaagjiof0J0osTba0zUxwOjJbeKqzCZfkJK4vUN9pw/bQ2hwo/j3
X-Gm-Gg: ASbGnctSuVCMDp/jnA7ubWruxXAShc4w4jRy6yypsJbs4nbSSyMGQXKj44rPE7qMVXI
	FDh9cFhFm23CGCUrpOGFNvIOzYCc5HsyfRYlBO4kQuLydwLlmnq3y44cmfafXEyhiNEWsZgZi5l
	5IfxZvnMEcT7YCbGmKpTGGqhkXeM3GO9AGp3XlxFGx8eRoS7FZ/ikXkw5mGop2TZduWwSEBK2a+
	QQOkmenugcZtwxSHjNuDspFIOjXgtuKnmU0NPFfJyoPUcBCA4w2vAVdJfPfdJySwfo1YI8+MSG1
	hPrOAf0z1c3CZvu2ZilqHCav0Ou41HVzHRnquVOltJP6iTgYNlPpsUGc99JKgO+OWFbCxSJOD2p
	3U2W1tXsuJSL5xMHGYaNsMOylNKSt4kz5phACRyXlUxji2DYGne5vj8utLzQEM6sBlcEvKM7jm+
	TC2uJR38jkruzLt5JWQ/2Wr9eUZARTdDcO/p1zbnurOPwL2DlLbzDMqz+FRe0r
X-Google-Smtp-Source: AGHT+IEHKKz0Cjj3Zv8b67ra4djfJLHStYKLQWPLvtMHZlwVL86SzQ0ZTx4GFMwFHpYtN+UrhI4NLQ==
X-Received: by 2002:a17:90b:3c86:b0:340:f009:ca99 with SMTP id 98e67ed59e1d1-345aea63bf9mr2830554a91.0.1763451329377;
        Mon, 17 Nov 2025 23:35:29 -0800 (PST)
Received: from ddn232-monserver.lab.ddn.com (fs276ec80e.tkyc203.ap.nuro.jp. [39.110.200.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343e06fe521sm21060184a91.1.2025.11.17.23.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 23:35:29 -0800 (PST)
From: Xiao Yang <iceyangxiao@gmail.com>
To: zlang@kernel.org,
	zlang@redhat.com
Cc: timday@amazon.com,
	fstests@vger.kernel.org,
	sihara@ddn.com,
	Xiao Yang <iceyangxiao@gmail.com>
Subject: [PATCH] fstests: Add lustre support
Date: Tue, 18 Nov 2025 07:30:11 +0000
Message-ID: <20251118073011.362595-1-iceyangxiao@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic lustre support so that we can continuously
improve lustre by fstests.

Signed-off-by: Xiao Yang <iceyangxiao@gmail.com>
---
 README                 |  2 ++
 README.config-sections |  7 +++++++
 check                  |  3 ++-
 common/config          |  5 +++++
 common/rc              | 29 ++++++++++++++++++++++++++++-
 5 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 9e9afe3c..9e3ff13f 100644
--- a/README
+++ b/README
@@ -87,6 +87,8 @@ L4: Active support from the fs list, has lots of own cases.
 +------------+-------+---------------------------------------------------------+
 | 9p         |  L1   | N/A                                                     |
 +------------+-------+---------------------------------------------------------+
+| lustre     |  L1   | N/A                                                     |
++------------+-------+---------------------------------------------------------+
 
 _______________________
 BUILDING THE FSQA SUITE
diff --git a/README.config-sections b/README.config-sections
index a42d9d7b..18af445f 100644
--- a/README.config-sections
+++ b/README.config-sections
@@ -135,3 +135,10 @@ TEST_DEV=%example.com:xfstest.test
 TEST_DIR=/mnt/xfstest.test
 SCRATCH_DEV=%example.com:xfstest.scratch
 SCRATCH_MNT=/mnt/xfstest.scratch
+
+[lustre]
+FSTYP=lustre
+TEST_DIR=/mnt/test
+TEST_DEV=192.168.1.1@tcp:/test
+SCRATCH_MNT=/mnt/scratch
+SCRATCH_DEV=192.168.1.1@tcp:/scratch
diff --git a/check b/check
index ce7eacb7..a5d43d98 100755
--- a/check
+++ b/check
@@ -70,6 +70,7 @@ check options
     -pvfs2		test PVFS2
     -tmpfs		test TMPFS
     -ubifs		test ubifs
+    -lustre             test lustre
     -l			line mode diff
     -udiff		show unified diff (default)
     -n			show me, do not run tests
@@ -277,7 +278,7 @@ while [ $# -gt 0 ]; do
 	case "$1" in
 	-\? | -h | --help) usage ;;
 
-	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs)
+	-nfs|-afs|-glusterfs|-cifs|-9p|-fuse|-virtiofs|-pvfs2|-tmpfs|-ubifs|-lustre)
 		FSTYP="${1:1}"
 		;;
 	-overlay)
diff --git a/common/config b/common/config
index 1420e35d..9d3c36e8 100644
--- a/common/config
+++ b/common/config
@@ -394,6 +394,9 @@ _common_mount_opts()
 	ubifs)
 		echo $UBIFS_MOUNT_OPTIONS
 		;;
+	lustre)
+		echo $LUSTRE_MOUNT_OPTIONS
+		;;
 	*)
 		;;
 	esac
@@ -539,6 +542,8 @@ _source_specific_fs()
 		[ "$UBIUPDATEVOL_PROG" = "" ] && _fatal "ubiupdatevol not found"
 		. ./common/ubifs
 		;;
+	lustre)
+		;;
 	esac
 }
 
diff --git a/common/rc b/common/rc
index 8fd7876a..7f75963b 100644
--- a/common/rc
+++ b/common/rc
@@ -867,6 +867,9 @@ _test_mkfs()
     pvfs2)
 	# do nothing for pvfs2
 	;;
+    lustre)
+	# do nothing for lustre
+	;;
     udf)
         $MKFS_UDF_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
 	;;
@@ -981,7 +984,7 @@ _scratch_mkfs()
 	local mkfs_status
 
 	case $FSTYP in
-	nfs*|afs|cifs|ceph|overlay|glusterfs|pvfs2|9p|fuse|virtiofs)
+	nfs*|afs|cifs|ceph|overlay|glusterfs|pvfs2|9p|fuse|virtiofs|lustre)
 		# unable to re-create this fstyp, just remove all files in
 		# $SCRATCH_MNT to avoid EEXIST caused by the leftover files
 		# created in previous runs
@@ -2064,6 +2067,15 @@ _require_scratch_nocheck()
 			_notrun "this test requires a valid \$SCRATCH_MNT"
 		fi
 		;;
+	lustre)
+		echo $SCRATCH_DEV | grep -q "@.*:/" > /dev/null 2>&1
+		if [ -z "$SCRATCH_DEV" -o "$?" != "0" ]; then
+			_notrun "this test requires a valid \$SCRATCH_DEV"
+		fi
+		if [ ! -d "$SCRATCH_MNT" ]; then
+			_notrun "this test requires a valid \$SCRATCH_MNT"
+		fi
+		;;
 	*)
 		 if [ -z "$SCRATCH_DEV" -o "`_is_block_dev "$SCRATCH_DEV"`" = "" ]
 		 then
@@ -2288,6 +2300,15 @@ _require_test()
 			_notrun "this test requires a valid \$TEST_DIR"
 		fi
 		;;
+	lustre)
+		echo $TEST_DEV | grep -q "@.*:/" > /dev/null 2>&1
+		if [ -z "$TEST_DEV" -o "$?" != "0" ]; then
+			_notrun "this test requires a valid \$TEST_DEV"
+		fi
+		if [ ! -d "$TEST_DIR" ]; then
+			_notrun "this test requires a valid \$TEST_DIR"
+		fi
+		;;
 	*)
 		 if [ -z "$TEST_DEV" ] || [ "`_is_block_dev "$TEST_DEV"`" = "" ]
 		 then
@@ -3658,6 +3679,9 @@ _check_test_fs()
 	;;
     pvfs2)
 	;;
+    lustre)
+	# no way to check consistency for lustre
+	;;
     udf)
 	# do nothing for now
 	;;
@@ -3720,6 +3744,9 @@ _check_scratch_fs()
 	;;
     pvfs2)
 	;;
+    lustre)
+	# no way to check consistency for lustre
+	;;
     btrfs)
 	_check_btrfs_filesystem $device
 	;;
-- 
2.43.7

