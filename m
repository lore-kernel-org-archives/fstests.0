Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B744BC433FE
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Jun 2022 06:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245291AbiFAGhk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Jun 2022 02:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349920AbiFAGhj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Jun 2022 02:37:39 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D134DF43
        for <fstests@vger.kernel.org>; Tue, 31 May 2022 23:37:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2152FB81826
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 06:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B69BC34119
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 06:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654065454;
        bh=b/L3sbbqTchk8ym4yxLU3qo4om3OtIXvsClIhu82jvg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pAcNqf+VCBGBX9YprXphc9r4cnjz12FyKQK42uPHSftw/doqlxfF2cW0LsLg0SoKL
         Y+GUhzKQ/5i7PkhsQhf17fHabeFo8BAxkCYC3IxZ6ov1cKF1gAuDgcHLGVnxwMlrny
         NJujd+C9ClRaGOlNDeYR5w4dhQV8LZ/BYLkBEvf992xobvCDUuck4aTEz9n8hGpMH9
         iaZyRVW+40CxG9G2j1cWuhgzANMOrujVSDoDKIUhnHhVsXPhDIn+3ap6BOtT0Fx9nq
         V9oWtGbFuE7C6kOaORIgybubrrobolq77qiOOm7b77bd17S27TtVtsy25o6FNUAZfn
         ND7u7Ua8ttbYQ==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH v2 1/5] generic/139: require 512 bytes to be the minimum dio size
Date:   Wed,  1 Jun 2022 14:37:26 +0800
Message-Id: <20220601063730.1726879-2-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220601063730.1726879-1-zlang@kernel.org>
References: <20220601063730.1726879-1-zlang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Due to generic/139 tests base on 512 bytes aligned, so skip this test
if the minimum dio write size >512. This patch also change the
common/rc::_require_dio helper, supports a minimum aligned size
argument.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 common/rc         | 17 ++++++++++++++---
 tests/generic/139 |  2 +-
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index 2f31ca46..6d384eaf 100644
--- a/common/rc
+++ b/common/rc
@@ -2721,9 +2721,12 @@ _require_xfs_io_command()
 	fi
 }
 
-# check that kernel and filesystem support direct I/O
+# check that kernel and filesystem support direct I/O, and check if "$1" size
+# aligned (optional) is supported
 _require_odirect()
 {
+	local alignment=${1:+"-b $1"}
+
 	if [ $FSTYP = "ext4" ] || [ $FSTYP = "f2fs" ] ; then
 		if echo "$MOUNT_OPTIONS" | grep -q "test_dummy_encryption"; then
 			_notrun "$FSTYP encryption doesn't support O_DIRECT"
@@ -2735,9 +2738,17 @@ _require_odirect()
 		fi
 	fi
 	local testfile=$TEST_DIR/$$.direct
-	$XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile > /dev/null 2>&1
+	local opt
+	if [ -n "$1" ];then
+		opt="-b $1"
+	fi
+	$XFS_IO_PROG -F -f -d -c "pwrite $opt 0 20k" $testfile > /dev/null 2>&1
 	if [ $? -ne 0 ]; then
-		_notrun "O_DIRECT is not supported"
+		if [ -n "$alignment" ]; then
+			_notrun "O_DIRECT aligned to $1 bytes is not supported"
+		else
+			_notrun "O_DIRECT is not supported"
+		fi
 	fi
 	rm -f $testfile 2>&1 > /dev/null
 }
diff --git a/tests/generic/139 b/tests/generic/139
index 0bbc222c..3eb1519d 100755
--- a/tests/generic/139
+++ b/tests/generic/139
@@ -26,7 +26,7 @@ _cleanup()
 # real QA test starts here
 _require_test_reflink
 _require_cp_reflink
-_require_odirect
+_require_odirect 512
 
 testdir=$TEST_DIR/test-$seq
 rm -rf $testdir
-- 
2.31.1

