Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCCDC54EE9
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 18:55:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiIVSzS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 14:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbiIVSzR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 14:55:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7545E5AC76
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 11:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663872915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2AfeuUL/XcFbHtL4X+jKEHAcvP8m2BCfdYhXMHntmZE=;
        b=GnWNvMqboI66u6jjVUMfIsFs38pWzR54gW8JOHawfhGxyVxgcntzLoMIShsyGY2sf4scll
        HfIy9eP3B8rPCTzxqNqlMqf8Eecnul/iE8P3FoQ1vkKLdEbqhCtorcWmqo7R9Y/PSMqRtg
        jn+6t8WZFpXZX/jKq615JS0uibWL0sk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-204-1ZhF9NSKNEC1RKwq-qLYQA-1; Thu, 22 Sep 2022 14:55:06 -0400
X-MC-Unique: 1ZhF9NSKNEC1RKwq-qLYQA-1
Received: by mail-ed1-f72.google.com with SMTP id t13-20020a056402524d00b00452c6289448so7296113edd.17
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 11:55:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=2AfeuUL/XcFbHtL4X+jKEHAcvP8m2BCfdYhXMHntmZE=;
        b=ZGcAPh0oBzhYGHVaHmXHYRMYgY+RUMG9vArDMj0h3uXFBCoNZ7Gz2lXINkt70MrSLQ
         JZybGBS5j4CWN+f9SdX0p3baNXstD020m1taD+16XbfBrnNJceIeKoK7lrrRIC8hiS7h
         8dAoPFL1NEf3M8DUJl9F/Y+pp387KKpBLsUYUG02xQrVld4lY5U8cVkr/94RvqVhPSBl
         KV3hnj8L2IXMZj2k3tF4alnVUTDuCx1fVYsHpsT54FLPJ0g6hQbUkCKTAmneAuG5lE3T
         Sr4QPl5hRVfGthMQYhDu1AutwECybzASmunUTrf1l2lf7Tlmqdy+wJEfLs6pBHHWXbY8
         YYZw==
X-Gm-Message-State: ACrzQf3L4JZ//iLmF6inVPe5CZC5dt3VzPWV2PEYhobiMsv/vo5QAdmd
        7EcqK9g2eYFG1HXCOgCunlmzHHakBcmyGK1GimwyOpb6eWm5o1UV5+xeAoJIx0mS/wahb9Q7Ufl
        0TavpraMxteNcDOLzkkPO+mkNHKiruBfGk1OKubRFnIqDGeZmvl+j+sGOQnh2VsGr7y8I
X-Received: by 2002:a17:906:959:b0:741:6f76:546f with SMTP id j25-20020a170906095900b007416f76546fmr4182834ejd.32.1663872904930;
        Thu, 22 Sep 2022 11:55:04 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM73QKEDExgTVKiSk36ldYYbgZI6SnfUsE6l71V9Gcw7lz9zh+gHk/6GZTKhFiAyfvvF5MMq+A==
X-Received: by 2002:a17:906:959:b0:741:6f76:546f with SMTP id j25-20020a170906095900b007416f76546fmr4182822ejd.32.1663872904665;
        Thu, 22 Sep 2022 11:55:04 -0700 (PDT)
Received: from localhost.localdomain (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id i14-20020a50fc0e000000b0044792480994sm4094541edr.68.2022.09.22.11.55.03
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 11:55:03 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v2 1/2] clean-up; Remove left files after test finishes
Date:   Thu, 22 Sep 2022 20:55:01 +0200
Message-Id: <20220922185502.1046115-1-preichl@redhat.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Fix file leak in _get_max_file_size - This is obviously mostly
problematic for FS lacking support for sparse files.

There seems to be some seek_sanity_testfile files that are not
cleaned up and take up space:

-rwxr-xr-x. 1 root root 8.0G Sep 22 13:39 seek_sanity_testfile10

g/394: Clean up test files taking space:

-rwxr-xr-x. 1 root root 1.0G Sep 22 14:58 394.1183899
-rwxr-xr-x. 1 root root 1.0G Sep 22 14:58 394.1183899-1
-rwxr-xr-x. 1 root root    0 sep 22 14:58 394.1183899+1

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 common/rc         | 1 +
 tests/generic/285 | 2 +-
 tests/generic/394 | 2 +-
 tests/generic/436 | 2 +-
 tests/generic/445 | 2 +-
 tests/generic/448 | 2 +-
 6 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/common/rc b/common/rc
index 228fcb37..c9078649 100644
--- a/common/rc
+++ b/common/rc
@@ -4637,6 +4637,7 @@ _get_max_file_size()
 			l=$m
 		fi
 	done
+	rm -f $testfile
 	echo $l
 }
 
diff --git a/tests/generic/285 b/tests/generic/285
index 6c755b5f..d1850021 100755
--- a/tests/generic/285
+++ b/tests/generic/285
@@ -28,7 +28,7 @@ _require_test_program "seek_sanity_test"
 # Override the default cleanup function.
 _cleanup()
 {
-	eval "rm -f $BASE_TEST_FILE.*"
+	rm -f $BASE_TEST_FILE*
 }
 
 _run_seek_sanity_test $BASE_TEST_FILE > $seqres.full 2>&1 ||
diff --git a/tests/generic/394 b/tests/generic/394
index fc03e2f3..cbc2ce13 100755
--- a/tests/generic/394
+++ b/tests/generic/394
@@ -14,7 +14,7 @@ _cleanup()
 {
 	cd /
 	ulimit -f unlimited
-	rm -f $tmp.*
+	rm -f $tmp.* $TEST_DIR/$seq.*
 }
 
 # Import common functions.
diff --git a/tests/generic/436 b/tests/generic/436
index 7fb24b41..d54af436 100755
--- a/tests/generic/436
+++ b/tests/generic/436
@@ -16,7 +16,7 @@ BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile
 # Override the default cleanup function.
 _cleanup()
 {
-	rm -f $tmp.* $BASE_TEST_FILE.*
+	rm -f $tmp.* $BASE_TEST_FILE*
 }
 
 # Import common functions.
diff --git a/tests/generic/445 b/tests/generic/445
index 05d1c5b3..d9e9f84b 100755
--- a/tests/generic/445
+++ b/tests/generic/445
@@ -16,7 +16,7 @@ BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile
 # Override the default cleanup function.
 _cleanup()
 {
-	rm -f $tmp.* $BASE_TEST_FILE.*
+	rm -f $tmp.* $BASE_TEST_FILE*
 }
 
 # Import common functions.
diff --git a/tests/generic/448 b/tests/generic/448
index d66967bc..11945549 100755
--- a/tests/generic/448
+++ b/tests/generic/448
@@ -15,7 +15,7 @@ BASE_TEST_FILE=$TEST_DIR/seek_sanity_testfile_$seq
 _cleanup()
 {
 	cd /
-	rm -f $tmp.* $BASE_TEST_FILE
+	rm -f $tmp.* $BASE_TEST_FILE*
 }
 
 # Import common functions.
-- 
2.37.3

