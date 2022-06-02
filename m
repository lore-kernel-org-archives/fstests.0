Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E5CC433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Jun 2022 05:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiFBFR0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 2 Jun 2022 01:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbiFBFRY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Jun 2022 01:17:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8282CE0AC
        for <fstests@vger.kernel.org>; Wed,  1 Jun 2022 22:17:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33590B81E4C
        for <fstests@vger.kernel.org>; Thu,  2 Jun 2022 05:17:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001CBC385A5;
        Thu,  2 Jun 2022 05:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654147039;
        bh=T3q26iJWiD5agm5bjXvDCmkefKOMI7MqUAVZgGWnA3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rvEBXe4XPaaM50B3tjZnS/na/P3zU9LDFS3RkxTwqcrjEPMwyO2QvdhgkcvXAw+YY
         TkMLZVeuW1V4elLr3Mwv9szjXEGIjPojUqMnUNgWyDFTMhef9SJHE63HhIn2FZJa3q
         8OFeKos5tr4cfHr6qOqq1mHwbmlKAYdRazchNSBXlUSVOflZW+tQ3pSxGGC7kXz31v
         9jlt3yC3x65TGc5ljw33RQZ/gfbRuB7CYbDJ80p58d5NIwkKuhnsS0mS/yS+trcSd4
         AxvkxrNrp0u762Ia5s2vnBr+Rn2xfUokfzMB9vWDtxvAwEZRijeEn4vp+PjJRhVjF1
         QhEJBOXkRta3A==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Cc:     djwong@kernel.org
Subject: [PATCH v3] generic/139: require 512 bytes to be the minimum dio size
Date:   Thu,  2 Jun 2022 13:17:16 +0800
Message-Id: <20220602051716.2050004-1-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <YpeixjeZ8kdVw/+7@magnolia>
References: <YpeixjeZ8kdVw/+7@magnolia>
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

Thanks the review from Darrick on v2, this v3 remove some duplicate code
which I forgot.

Thanks,
Zorro

 common/rc         | 13 ++++++++++---
 tests/generic/139 |  2 +-
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index 2f31ca46..9823e3a1 100644
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
@@ -2735,9 +2738,13 @@ _require_odirect()
 		fi
 	fi
 	local testfile=$TEST_DIR/$$.direct
-	$XFS_IO_PROG -F -f -d -c "pwrite 0 20k" $testfile > /dev/null 2>&1
+	$XFS_IO_PROG -F -f -d -c "pwrite $alignment 0 20k" $testfile > /dev/null 2>&1
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

