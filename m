Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D30CCA483
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Jun 2022 14:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiF3Oqu (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235205AbiF3Oqq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 30 Jun 2022 10:46:46 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEDD1C127
        for <fstests@vger.kernel.org>; Thu, 30 Jun 2022 07:46:45 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25UEkeGU005696
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 10:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656600402; bh=qhRE+8WpIYRPZYCoOSgC7za5IujOiBo9qnX6m0IG9+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Rs6GTk9yVnAMnEfxpedHXRIeR4lmGBMvvGEuPYzf7RU2ot3s95YBXSmBLMLHviPGW
         W4KHEqM/dHEUXdc3B6AtDgJJTWFwa7RyiwMfzyTsAYX77Kxgl9je5kD/A75h51O0Z6
         9e7NC7E7sXRj+iaP9JqtpbwlyNKqxmzrW/ODRXGlVj5uXe0N9Td6jCIuQxl1Nssg56
         tPmVT9z3784hc+9sCqJGdIgXR6//hRBcXnz9to2e6e8IrVl/IBmlWosl1WlTpvhvG6
         u9QFFP3TTc7EcU3p4v7ApBfO/UAbxKJO8IGPyDEztFuBSmasS26zRz0Gt4T3O14imf
         NzJsoBv35QyvA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 50C6515C4333; Thu, 30 Jun 2022 10:46:39 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Zorro Lang <zlang@redhat.com>
Subject: [PATCH -v4 7/7] ext4: create file systems with the encrypt feature as necessary
Date:   Thu, 30 Jun 2022 10:46:37 -0400
Message-Id: <20220630144637.478568-8-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220630144637.478568-1-tytso@mit.edu>
References: <20220630144637.478568-1-tytso@mit.edu>
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

For file system configs which includes test_dummy_encryption in
MOUNT_OPTIONS and "-O encrypt" in MKFS_OPTIONS, we need to test for
test_dummy_encryption and force the hard-coded mkfs options to enable
the encrypt feature.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Zorro Lang <zlang@redhat.com>
---
 tests/ext4/003    | 6 +++++-
 tests/ext4/035    | 6 +++++-
 tests/ext4/306    | 5 ++++-
 tests/generic/260 | 3 +++
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/tests/ext4/003 b/tests/ext4/003
index 773bcb03..8ac467b8 100755
--- a/tests/ext4/003
+++ b/tests/ext4/003
@@ -27,7 +27,11 @@ _require_scratch
 _require_scratch_ext4_feature "bigalloc"
 
 BLOCK_SIZE=$(get_page_size)
-$MKFS_EXT4_PROG -F -b $BLOCK_SIZE -O bigalloc -C $(($BLOCK_SIZE * 16)) -g 256 $SCRATCH_DEV 512m \
+features=bigalloc
+if echo "${MOUNT_OPTIONS}" | grep -q 'test_dummy_encryption' ; then
+    features+=",encrypt"
+fi
+$MKFS_EXT4_PROG -F -b $BLOCK_SIZE -O $features -C $(($BLOCK_SIZE * 16)) -g 256 $SCRATCH_DEV 512m \
 	>> $seqres.full 2>&1
 _scratch_mount
 
diff --git a/tests/ext4/035 b/tests/ext4/035
index 1f26e766..a8278b0e 100755
--- a/tests/ext4/035
+++ b/tests/ext4/035
@@ -25,7 +25,11 @@ _require_scratch
 _exclude_scratch_mount_option dax
 _require_command "$RESIZE2FS_PROG" resize2fs
 
-$MKFS_EXT4_PROG -F -b 1024 -E "resize=262144" $SCRATCH_DEV 32768 >> $seqres.full 2>&1
+encrypt=
+if echo "${MOUNT_OPTIONS}" | grep -q 'test_dummy_encryption' ; then
+    encrypt="-O encrypt"
+fi
+$MKFS_EXT4_PROG -F -b 1024 -E "resize=262144" $encrypt $SCRATCH_DEV 32768 >> $seqres.full 2>&1
 if [ $? -ne 0 ]; then
     _notrun "Can't make file system with a block size of 1024"
 fi
diff --git a/tests/ext4/306 b/tests/ext4/306
index 2ff88537..db256284 100755
--- a/tests/ext4/306
+++ b/tests/ext4/306
@@ -31,7 +31,10 @@ _require_command "$RESIZE2FS_PROG" resize2fs
 # Make a small ext4 fs with extents disabled & mount it
 features="^extents"
 if grep -q 64bit /etc/mke2fs.conf ; then
-    features="^extents,^64bit"
+    features+=",^64bit"
+fi
+if echo "${MOUNT_OPTIONS}" | grep -q 'test_dummy_encryption' ; then
+    features+=",encrypt"
 fi
 
 blksz=$(get_page_size)
diff --git a/tests/generic/260 b/tests/generic/260
index b4d72e0f..2f653b4a 100755
--- a/tests/generic/260
+++ b/tests/generic/260
@@ -121,6 +121,9 @@ case $FSTYP in
 		start=$(_math "$base*$agsize*$bsize")
 		len=$start
 		export MKFS_OPTIONS="-F -b $bsize -g $agsize"
+		if echo "${MOUNT_OPTIONS}" | grep -q 'test_dummy_encryption' ; then
+		    MKFS_OPTIONS+=" -O encrypt"
+		fi
 		;;
 	xfs)
 		agsize=65538
-- 
2.31.0

