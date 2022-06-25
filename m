Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77CBECCA481
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Jun 2022 03:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiFYDIP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jun 2022 23:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiFYDHi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jun 2022 23:07:38 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D1968029
        for <fstests@vger.kernel.org>; Fri, 24 Jun 2022 20:07:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25P37WlM010329
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 23:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656126454; bh=v0uefXiivY+UFCTaPIW6yNc1vffL2jo+FqJKaJjS/QI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VaaVbWX6013aFaE1iSynMmfweJM9Mk30wMMF4oGDJhws9bAFklXVo3XU8w4tBHEE3
         t2kN3yQ+sXIXmLc41HsB5uAewfc9md4gX56DV+6J3Fpt1SjzTehHRxW1IXA30IAAd1
         /+ehJ4e8TmOGSt3wzKNPiAnxzmAzDq4R+13F5p6vu6wkK9riig/lWklW5YYNHZt5hU
         xHLFYqB0AR5WqNQW5pAmc2kufMLR+VVd/JnJwc6klIvwqYSgyqWkZgdbZy2zdASibe
         dxqfehLhYdCJo0IIJ5/Y4TNfpgGtBsrn/i/jFycegOtcWrAZnyZWVUS0AZDC3CEP6n
         OS56gGCrTvowA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CB32015C4314; Fri, 24 Jun 2022 23:07:32 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 4/5] ext4/054: skip test if the dax mount option is enabled
Date:   Fri, 24 Jun 2022 23:07:17 -0400
Message-Id: <20220625030718.1215980-5-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220625030718.1215980-1-tytso@mit.edu>
References: <20220625030718.1215980-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The ext4/054 test explicitly creates a file system with a 1k
blocksize.  This can't possibly work on if the dax mount option is
enabled, so change ext4/054 to use _scratch_mkfs_blocksized, and and a
check to _scratch_mkfs_blocksized to _notrun the test if the block
size is less than the page size.

Also remove an unnecessary _require_test declaration since this test
does not use the test device.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 common/rc      | 3 +++
 tests/ext4/054 | 5 ++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index 9378ff26..3014f5fc 100644
--- a/common/rc
+++ b/common/rc
@@ -1220,6 +1220,9 @@ _scratch_mkfs_blocksized()
 	if ! [[ $blocksize =~ $re ]] ; then
 		_notrun "error: _scratch_mkfs_sized: block size \"$blocksize\" not an integer."
 	fi
+	if [ $blocksize -lt $(get_page_size) ]; then
+		_exclude_scratch_mount_option dax
+	fi
 
 	case $FSTYP in
 	btrfs)
diff --git a/tests/ext4/054 b/tests/ext4/054
index 9a11719f..e23acbb1 100755
--- a/tests/ext4/054
+++ b/tests/ext4/054
@@ -19,7 +19,6 @@ _begin_fstest auto quick dangerous_fuzzers
 
 # real QA test starts here
 _supported_fs ext4
-_require_test
 _require_scratch_nocheck
 _require_xfs_io_command "falloc"
 _require_xfs_io_command "pwrite"
@@ -28,8 +27,8 @@ _require_xfs_io_command "fpunch"
 _require_command "$DEBUGFS_PROG" debugfs
 
 # In order to accurately construct the damaged extent in the following
-# test steps, the blocksize is set to 1024 here
-_scratch_mkfs "-b 1024" > $seqres.full 2>&1
+# test steps, the block size is set to 1024 here
+_scratch_mkfs_blocksized 1024 >> $seqres.full 2>&1
 _scratch_mount
 
 TEST_FILE="${SCRATCH_MNT}/testfile"
-- 
2.31.0

