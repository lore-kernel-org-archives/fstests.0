Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D274C07545
	for <linux-fstests@archiver.kernel.org>; Sun, 22 Oct 2023 21:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjJVVzo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 22 Oct 2023 17:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbjJVVzm (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 22 Oct 2023 17:55:42 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691BEE7
        for <fstests@vger.kernel.org>; Sun, 22 Oct 2023 14:55:40 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 39MLtXUF015862
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 22 Oct 2023 17:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1698011735; bh=nsVJL90y0ciANW67opnVRb3ZmabQtsy92nTuMZfKPE0=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=hMzCcKyY06PJzhmbKPsu3kUOhAq/M8moGWELzY27d/UYw0HLZK3FuN28lhVZ2jlJy
         Wx+OPhbaLVAICe7sZWDLEKdxvYPk6vZPtcEcyu6dvDkz3vcKfEuZ1psgmfy03sh5Xm
         Js0Q8s2Ib+bBNiW7LcV5ycDd8Ige/cyKUtEgzZ9c02vl+dukhEQ9OL020IwCFiSuRY
         0mEB98CLp7YNTHoRhNSC1aCgt2fSwLRqhoMZlG6fAjnSKYWe6J2vfgbaZlS1VZKgr1
         /WEWhkNMaF7txrKLwqvgiK3KWhqHP65MlOXcIcLUpDbGQ7QTS+CfiMjFJ0Zsombvu1
         cqmKdPDwd5xnw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 86CDA15C024D; Sun, 22 Oct 2023 17:55:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 1/2] common: check if the scratch device can support 1024 block sizes
Date:   Sun, 22 Oct 2023 17:55:28 -0400
Message-Id: <20231022215529.2202150-2-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20231022215529.2202150-1-tytso@mit.edu>
References: <20231022215529.2202150-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

If the scratch device has as logical blocksize larger than 512 --- for
example, some SSD or HDD's may have a 4k logical blocksize, and so
will not support a file system with a 1k block size.

Add a new function, _require_scratch_support_blocksize so we can skip
tests that use _scratch_mkfs_blocksized with a size less than the
scratch device's logical block size.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc      | 12 ++++++++++++
 tests/ext4/055 |  1 +
 tests/xfs/205  |  1 +
 tests/xfs/432  |  1 +
 tests/xfs/516  |  1 +
 5 files changed, 16 insertions(+)

diff --git a/common/rc b/common/rc
index 7f5a9527c..8d7179567 100644
--- a/common/rc
+++ b/common/rc
@@ -1124,6 +1124,9 @@ _scratch_mkfs_blocksized()
 	if [ $blocksize -lt $(_get_page_size) ]; then
 		_exclude_scratch_mount_option dax
 	fi
+	if [ $blocksize -lt $(blockdev --getss $SCRATCH_DEV) ]; then
+		_require_scratch_support_blocksize "$blocksize"
+	fi
 
 	case $FSTYP in
 	btrfs)
@@ -4452,6 +4455,15 @@ _get_device_size()
 	echo $(($(blockdev --getsz $1) >> 1))
 }
 
+_require_scratch_support_blocksize()
+{
+	local blocksize=$1
+
+	if [ $blocksize -lt $(blockdev --getss $SCRATCH_DEV) ]; then
+		_notrun "$SCRATCH_DEV does not support a block size of $blocksize."
+	fi
+}
+
 # Make sure we actually have dmesg checking set up.
 _require_check_dmesg()
 {
diff --git a/tests/ext4/055 b/tests/ext4/055
index aa15cfe98..7025f6283 100755
--- a/tests/ext4/055
+++ b/tests/ext4/055
@@ -27,6 +27,7 @@ echo "Silence is golden"
 
 # The 1K blocksize is designed for debugfs.
 _exclude_scratch_mount_option dax
+_require_scratch_support_blocksize 1024
 _scratch_mkfs "-F -O quota -b 1024" > $seqres.full 2>&1
 
 # Start from 0, fill block 1 with 6，replace the original 2.
diff --git a/tests/xfs/205 b/tests/xfs/205
index 104f1f45a..84c099208 100755
--- a/tests/xfs/205
+++ b/tests/xfs/205
@@ -23,6 +23,7 @@ _require_scratch_nocheck
 unset SCRATCH_RTDEV
 
 fsblksz=1024
+_require_scratch_support_blocksize $fsblksz
 _scratch_mkfs_xfs -d size=$((32768*fsblksz)) -b size=$fsblksz >> $seqres.full 2>&1
 _scratch_mount
 
diff --git a/tests/xfs/432 b/tests/xfs/432
index 66315b039..2efa6230b 100755
--- a/tests/xfs/432
+++ b/tests/xfs/432
@@ -50,6 +50,7 @@ echo "Format and mount"
 # block.  8187 hashes/dablk / 248 dirents/dirblock = ~33 dirblocks per
 # dablock.  33 dirblocks * 64k mean that we can expand a directory by
 # 2112k before we have to allocate another da btree block.
+_require_scratch_support_blocksize 1024
 _scratch_mkfs -b size=1k -n size=64k > "$seqres.full" 2>&1
 _scratch_mount >> "$seqres.full" 2>&1
 
diff --git a/tests/xfs/516 b/tests/xfs/516
index 9e1b99317..65fc635dd 100755
--- a/tests/xfs/516
+++ b/tests/xfs/516
@@ -23,6 +23,7 @@ _cleanup()
 # real QA test starts here
 _supported_fs xfs
 _require_scratch_nocheck
+_require_scratch_support_blocksize 1024
 
 # Assume that if we can run scrub on the test dev we can run it on the scratch
 # fs too.
-- 
2.31.0

