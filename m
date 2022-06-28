Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63893CCA481
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Jun 2022 18:26:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbiF1S0A (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jun 2022 14:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234798AbiF1SZ4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jun 2022 14:25:56 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4660921809
        for <fstests@vger.kernel.org>; Tue, 28 Jun 2022 11:25:55 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25SIPoal025937
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 14:25:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656440752; bh=Q1dLm4XjO9MNVOJ+UzDPNE976l4SJ7HkSw/vRvGDP5s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YmbDzZ1z9rD6YTv5QvOfNNHPyIXAotNPeCYZvFhB82peYYj0B8Lrc3EG342y0rjYl
         TgKRjkVkDbXl1N52t8nruKAAM18wqlWQ2IopaaDvbaVkvki5I6NEid+YVep1JwDdKQ
         ZkhitkzIXyLzgkDRfuqPoTD2as5XUbStYR+AGyYLWyeiQEU5p1RdeSOyuPK5FtGobC
         4OALLOmkgcjXPHD+Uwy8iHP1eePMO2MLweQdDx6x+cTLloFWkxJtw4QuJEEdxDemfE
         qDOyJ9v18bR2tQUsF64YaN0+RTDF0hDAQ+Nzxjnv2UWC7hRWpdaUd/7zjlCcULTAAn
         a93qmEWAXfS/w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8566D15C4319; Tue, 28 Jun 2022 14:25:49 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 6/6] ext4: create file systems with the enrypt feature if necessary
Date:   Tue, 28 Jun 2022 14:25:45 -0400
Message-Id: <20220628182545.1834145-7-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220628182545.1834145-1-tytso@mit.edu>
References: <20220628182545.1834145-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The linux kernel commit 5f41fdaea63d ("ext4: only allow
test_dummy_encryption when supported") the kernel will reject mounts
with the test_dummy_encryption option if the ext4 file system does not
have the encrypt feature enabled.

There are a handful of tests (ext4/003, ext4/035, ext4/306, and
generic/260) which will format the scratch file system using a
hard-coded set of mkfs.ext4 parameters ignoring the MKFS_OPTION that
is set by the file system test config.

For file system config that includes test_dummy_encryption in
MOUNT_OPTIONS and "-O encrypt" in MKFS_OPTIONS, we need to test for
test_dummy_encryption and force the hard-coded mkfs options to enable
the encrypt feature.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/003    | 6 +++++-
 tests/ext4/035    | 5 ++++-
 tests/ext4/306    | 3 +++
 tests/generic/260 | 5 ++++-
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/tests/ext4/003 b/tests/ext4/003
index 773bcb03..6a4518e3 100755
--- a/tests/ext4/003
+++ b/tests/ext4/003
@@ -27,7 +27,11 @@ _require_scratch
 _require_scratch_ext4_feature "bigalloc"
 
 BLOCK_SIZE=$(get_page_size)
-$MKFS_EXT4_PROG -F -b $BLOCK_SIZE -O bigalloc -C $(($BLOCK_SIZE * 16)) -g 256 $SCRATCH_DEV 512m \
+FEATURES=bigalloc
+if echo "${MOUNT_OPTIONS}" | grep -q 'test_dummy_encryption' ; then
+    FEATURES=${FEATURES},encrypt
+fi
+$MKFS_EXT4_PROG -F -b $BLOCK_SIZE -O ${FEATURES} -C $(($BLOCK_SIZE * 16)) -g 256 $SCRATCH_DEV 512m \
 	>> $seqres.full 2>&1
 _scratch_mount
 
diff --git a/tests/ext4/035 b/tests/ext4/035
index 1f26e766..a1ccce45 100755
--- a/tests/ext4/035
+++ b/tests/ext4/035
@@ -25,7 +25,10 @@ _require_scratch
 _exclude_scratch_mount_option dax
 _require_command "$RESIZE2FS_PROG" resize2fs
 
-$MKFS_EXT4_PROG -F -b 1024 -E "resize=262144" $SCRATCH_DEV 32768 >> $seqres.full 2>&1
+if echo "${MOUNT_OPTIONS}" | grep -q 'test_dummy_encryption' ; then
+    ENCRYPT="-O encrypt"
+fi
+$MKFS_EXT4_PROG -F -b 1024 -E "resize=262144" $ENCRYPT $SCRATCH_DEV 32768 >> $seqres.full 2>&1
 if [ $? -ne 0 ]; then
     _notrun "Can't make file system with a block size of 1024"
 fi
diff --git a/tests/ext4/306 b/tests/ext4/306
index 2ff88537..a6b7eab5 100755
--- a/tests/ext4/306
+++ b/tests/ext4/306
@@ -33,6 +33,9 @@ features="^extents"
 if grep -q 64bit /etc/mke2fs.conf ; then
     features="^extents,^64bit"
 fi
+if echo "${MOUNT_OPTIONS}" | grep -q 'test_dummy_encryption' ; then
+    features=${features},encrypt
+fi
 
 blksz=$(get_page_size)
 
diff --git a/tests/generic/260 b/tests/generic/260
index b4d72e0f..e86afe9c 100755
--- a/tests/generic/260
+++ b/tests/generic/260
@@ -120,7 +120,10 @@ case $FSTYP in
 		bsize=4096
 		start=$(_math "$base*$agsize*$bsize")
 		len=$start
-		export MKFS_OPTIONS="-F -b $bsize -g $agsize"
+		if echo "${MOUNT_OPTIONS}" | grep -q 'test_dummy_encryption' ; then
+		    ENCRYPT="-O encrypt"
+		fi
+		export MKFS_OPTIONS="-F -b $bsize -g $agsize $ENCRYPT"
 		;;
 	xfs)
 		agsize=65538
-- 
2.31.0

