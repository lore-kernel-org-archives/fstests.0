Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 280E3C6FA91
	for <linux-fstests@archiver.kernel.org>; Thu, 22 Sep 2022 13:49:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231516AbiIVNtF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 22 Sep 2022 09:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbiIVNsk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 22 Sep 2022 09:48:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6C5ACA35
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 06:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663854512;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eKCyWHJlsRjMOYYRZHs9YjXkHVMq9auHAU1ITO9K/xk=;
        b=AroBMcehex3hAdjl5ib9PAUXB/DkPagvbjqQzMM9RSiB0H4+JyoLRncf6bMvNCUYKIJsnC
        LqPFE/OqCpf+t/loVXMUyhiX2mgsJth2ZQVGnRFVqJRj+PPn1wEw+UjlYbAiBnq6dJZj89
        tJ6+qHz5C8rvVGPGJ4msYXJBUxkgk7A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-587-up2hgG-wOVWckR0jL3RFFA-1; Thu, 22 Sep 2022 09:48:31 -0400
X-MC-Unique: up2hgG-wOVWckR0jL3RFFA-1
Received: by mail-ed1-f70.google.com with SMTP id z16-20020a05640235d000b0045485e4a5e0so5680627edc.1
        for <fstests@vger.kernel.org>; Thu, 22 Sep 2022 06:48:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eKCyWHJlsRjMOYYRZHs9YjXkHVMq9auHAU1ITO9K/xk=;
        b=YJ/2QZcEuDcCTPofGNBRaclIQs3L6KvMaosrpmPAp0Djtrwee2DIsvHf+O4uIMEYFv
         J42iFUwScTIjInXYuUlQM/dyif3+hnJRIZycJLMweHFLF4o0TGHDQcepVNtPVsRu7Hbt
         PPY1wIP/aZRm1mZ2nEGT1Un6gtlg1QEjyvLRkdihgB/AX65v2VQ2qM48sShEI9eEANvK
         v27H3oqihSB/7E3PKl+gCBD9FBQrNHPIkN48McUWe7McMfsl1mYBfqy40p6/cRyeaKOW
         Ky1OA8DJWyuZrzalLjJavqHANkPpKURHCasLPVhHEiU3ImuV55cg6WkudftvYUuaz9Or
         q7Gg==
X-Gm-Message-State: ACrzQf2zTAQUxRg/CpJe7ZqknOZn0Aky3T4LY+/ZYNAsctZvSeQ5WGLQ
        baZVdjfCtN0e4RToOmMkCaAZFd4/P6gVi/eqexgLUiGw4USCgj8vooYe2VPstn9yxbnOvNC4UCp
        gwGfe1eYWp0PUhWrOWx+/i/berHH0QHZyDJuSECo5EQt6b2T6lKfHKHTmEu9I1Vg5OvvX
X-Received: by 2002:a05:6402:e01:b0:442:dd7e:f49d with SMTP id h1-20020a0564020e0100b00442dd7ef49dmr3431756edh.355.1663854509585;
        Thu, 22 Sep 2022 06:48:29 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM745KIQrJ1tTbF+u56XaiEt7uaaLF2xVIIfyDLyBqyji25juedX6IZ3JuhTAVGdQE+7KcduxA==
X-Received: by 2002:a05:6402:e01:b0:442:dd7e:f49d with SMTP id h1-20020a0564020e0100b00442dd7ef49dmr3431726edh.355.1663854509268;
        Thu, 22 Sep 2022 06:48:29 -0700 (PDT)
Received: from localhost.localdomain (gw19-pha-stl-mmo-1.avonet.cz. [131.117.213.203])
        by smtp.gmail.com with ESMTPSA id e4-20020aa7d7c4000000b0044ec76521a1sm3760861eds.55.2022.09.22.06.48.26
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 06:48:28 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 3/4] generic: cleanup test files
Date:   Thu, 22 Sep 2022 15:48:21 +0200
Message-Id: <20220922134822.1020119-3-preichl@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922134822.1020119-1-preichl@redhat.com>
References: <20220922134822.1020119-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

There seems to be some seek_sanity_testfile files that are not
cleaned up and take up space.

-rwxr-xr-x. 1 root root 8.0G Sep 22 13:39 seek_sanity_testfile10

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 tests/generic/285 | 2 +-
 tests/generic/436 | 2 +-
 tests/generic/445 | 2 +-
 tests/generic/448 | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

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

