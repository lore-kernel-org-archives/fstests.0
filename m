Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B575DC00140
	for <linux-fstests@archiver.kernel.org>; Thu, 18 Aug 2022 07:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243799AbiHRHPb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 18 Aug 2022 03:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235917AbiHRHPa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 18 Aug 2022 03:15:30 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED2E876A9
        for <fstests@vger.kernel.org>; Thu, 18 Aug 2022 00:15:29 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r16so669450wrm.6
        for <fstests@vger.kernel.org>; Thu, 18 Aug 2022 00:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=KgfJ2VHqNfyE2tXuh4J/SNsxRsdXLBo5NV9aNCmXBW0=;
        b=eG9fvdSM5uekOA7lFDeoaWdjTcDBk7Le7YX4it8SPw9Y8m1yR+om778D1fXrHO93M0
         8ysCgGz9qMIoYHOhdKs5x4PU0GYwlm27uGjBvwXP0sIvqRliq4wvLOoWuP66HCS7yf5G
         OzoibKywVBMAqLUaVlaPuIWNn2hoHLiAmGYpNT4KBygtaBPRZGZjF4zpWr94bdrD76uj
         oYhBlcmuKw+CGtIGHyGrHyrVGU+lJX0Z30+MIuQcSNUIp4pr2guQBuMqltik6muVk9tr
         HC2C23LxbCuLfQsGSFvDkdiPaOuAObY0meLiGlaRrHXUxjpRmcrHeikB+vs7KWfUIwMs
         d4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=KgfJ2VHqNfyE2tXuh4J/SNsxRsdXLBo5NV9aNCmXBW0=;
        b=dnErkOScopYPV+9Cr4lmzbVc8dmyVZFu9aG43UNlMiQXEWkWTv2iA1H3/S8+X/vR7q
         RntZq3Zb4sU3y9wraWSoTPIyKgJ3shHmS8wXA4mzoeXY/JKpau7xDfVt3mq8mSbsDl0i
         Saektnu1p4AlGCx1cpi4ZglvdQ5rBxcDr89adcH5JTPefIlDTq+jipaIQSs93Og0QNXR
         ZrOLbZxJxcY/VNWKLU1EqSa5D+ybW68EdeLmGotKQDDvOSop2kf2SWTX6wdmzYikFPT1
         mmayx9RiEgf7cvq4OqH9gAt9J2BsQtezC7PxWPO9syIzB1rL74YpyxFst8hledVlljzF
         quCg==
X-Gm-Message-State: ACgBeo2BjVJQnmFOW6Fum7ci6BL1/2KnjkVli4shm3yuXplNqWMF56Xs
        pRSU9A9MIIxNjWN6pOQIt4gP4kYtufk=
X-Google-Smtp-Source: AA6agR5Yfr/hMR/hwuQLq6m1J/ZlpMOFPCDuk3Pa+fgKk9Rm7WaWD0iMhW9w83ULiJONdnuGE2S2zA==
X-Received: by 2002:a5d:5885:0:b0:21f:bf7:39ea with SMTP id n5-20020a5d5885000000b0021f0bf739eamr801738wrf.217.1660806927923;
        Thu, 18 Aug 2022 00:15:27 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([77.137.66.49])
        by smtp.gmail.com with ESMTPSA id f14-20020a05600c154e00b003a32251c3f9sm5374768wmg.5.2022.08.18.00.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 00:15:27 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Leah Rumancik <leah.rumancik@gmail.com>, fstests@vger.kernel.org
Subject: [PATCH] gce-xfstests: fix setup iam policy binding
Date:   Thu, 18 Aug 2022 10:15:23 +0300
Message-Id: <20220818071523.928417-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On a new account setup. gce-xfstests setup failed with error:

  "Failed to add iam policy binding for roles/..."

On the second (verbose) retry, the opertaion succeeds,
but the script still aborts.

Fix a typo in the first invocation of the command.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 run-fstests/util/gce-do-setup | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/run-fstests/util/gce-do-setup b/run-fstests/util/gce-do-setup
index c06a1e9..037068e 100755
--- a/run-fstests/util/gce-do-setup
+++ b/run-fstests/util/gce-do-setup
@@ -141,9 +141,9 @@ function SetupServiceAccount () {
 		   --display-name "$name"
 	if ! run_gcloud projects add-iam-policy-binding "$GCE_PROJECT" \
 	     --member "serviceAccount:$srv_acct" \
-	     --role "projects/$GCE_PROJECT/roles/$role" \
+	     --role "$role" \
 	     --verbosity none >& /dev/null ; then
-	    echo "Failed to add iam policy binding for roles/$role"
+	    echo "Failed to add iam policy binding for role $role"
 	    # Re-run to get error message
 	    run_gcloud projects add-iam-policy-binding "$GCE_PROJECT" \
 		       --member "serviceAccount:$srv_acct" \
-- 
2.25.1

