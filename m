Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC992C433FE
	for <linux-fstests@archiver.kernel.org>; Sun, 29 May 2022 10:55:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbiE2KzP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 29 May 2022 06:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbiE2KzN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 29 May 2022 06:55:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB2762CD1
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 03:55:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5CFC2B80139
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 10:55:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B1CFC34119
        for <fstests@vger.kernel.org>; Sun, 29 May 2022 10:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653821710;
        bh=WIjcizgcG493Ekas9px4UBEw1C6MfRFREfhW6Q3phiE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gciHKYYue6xuzO85Lzsb8BvHxTjdpW30JGMxOa67Jz2082ptMA5/5ytkzWQMCOY+E
         cv0VpHJBp3AhGah1BFqB4c4tDsJ4FFs7uxo2z4kl8+ly2WVIfycnokXjiI7Wj+IiDf
         iK0LofjwLoMJke8Ajy+uJLCbfZBO756Om1+WVad2+kldcTPvOHkqlKuxRHKRPrVet+
         LE8fQUf1Q1lT8t/scbHfE8LWBceKnWCE9kAoMQw4PdvFyYZJOnXKofjYL2nk2osW4P
         Nd6A+oMZ1YN6IqXYd7nbR9uNGY4UtmR1ClhmsXinZRRwC2q237FaMw6cSVM170FMSs
         /PL35q/vT/VKw==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH 1/5] generic/139: require 512 bytes to be the minimum dio size
Date:   Sun, 29 May 2022 18:55:01 +0800
Message-Id: <20220529105505.667891-2-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220529105505.667891-1-zlang@kernel.org>
References: <20220529105505.667891-1-zlang@kernel.org>
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
 common/rc         | 11 ++++++++---
 tests/generic/139 |  2 +-
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index 2f31ca46..6f7a37fd 100644
--- a/common/rc
+++ b/common/rc
@@ -2721,7 +2721,8 @@ _require_xfs_io_command()
 	fi
 }
 
-# check that kernel and filesystem support direct I/O
+# check that kernel and filesystem support direct I/O, and check if "$1" size
+# aligned (optional) is supported
 _require_odirect()
 {
 	if [ $FSTYP = "ext4" ] || [ $FSTYP = "f2fs" ] ; then
@@ -2735,9 +2736,13 @@ _require_odirect()
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
+		_notrun "O_DIRECT $1 is not supported"
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

