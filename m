Return-Path: <SRS0=y1X6=7S=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EE6C433E0
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Jun 2020 03:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9E3A207DA
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Jun 2020 03:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bXtwBjbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFEDUI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Jun 2020 23:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgFEDUI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Jun 2020 23:20:08 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA94EC08C5C0
        for <fstests@vger.kernel.org>; Thu,  4 Jun 2020 20:20:06 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id k15so6515790otp.8
        for <fstests@vger.kernel.org>; Thu, 04 Jun 2020 20:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oj7QV0TxkdHa/Ld7K3KKyon3cbAWvMNaO9YyNjjVSLw=;
        b=bXtwBjbbRn48fQCbiTJVPn35Oaw5iMvpUmXGnMXk++HnvAi6bmdtdFXPh8Ox0/ZgtA
         uG70f7KVWErI/MhmS19omQJlPk5Pi37WKSAagTkALKR+7d/dQIUm0+90gb1xSmgxo1M3
         DUBJ395EVHRw7q4dlcs61/w2zlMRVfjfRU5B1x6HotXiQSx/cldnAJWSiVt30aVxCSr4
         yfuYv+RqnhPQqKwOmYLEJIY2P1hALemfWSx1OcyEUdYx8kvuDf0EGCUOdh6pjLsZQRu/
         ofUTsMCCHGUPY38v+oYDaAxdtjApP0JmEe3c9Bp+7M3tmJ8MamujRiJWzCDiRqP4vUrG
         jdcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oj7QV0TxkdHa/Ld7K3KKyon3cbAWvMNaO9YyNjjVSLw=;
        b=C3r2En1D5mjfKapAwChwamUI6Z0wBhNxKYuc4lUiHAildjr+2ZuYNoM7V8wh4MRekm
         EzeSexO/m63n374UDQ/65K8bEezs0i3a5XP/wmipAbEkAMM32q8tQyKz4cYkR9RiatWX
         d6+kUGnxORiGeC/TMZCFkFblff7JFmuT0qYdsRwpT61AwVXHen4C/BjIsTwx0tcxeKjH
         hyLtBylgXcz9bEQ3bxCX52AZoWfVtHCggFqINzG0nWknxOoaeiZvJCz29pFKHo/srr75
         rhBKKfWUTlFJoz0uwLU2sE2IqPNFQYS+WVRrVtu4YhfvT43t9jy3dOsf281mat5rbG6q
         OktA==
X-Gm-Message-State: AOAM532FxwDshSmNK9yzmTWyTYwBri0O+lK0DpBRm6BeyjIB2p1w9DjV
        XGnQcIt6DNUg64mNmsxBZ1+GxYQkNig=
X-Google-Smtp-Source: ABdhPJyWYBhcQTHIMU7SN44Vn3oC0CMul2bLlep1CvaZNDfsPz4/dEHhkj56BUPOWI4QzitSYDYyWg==
X-Received: by 2002:a9d:20e6:: with SMTP id x93mr3324734ota.256.1591327205911;
        Thu, 04 Jun 2020 20:20:05 -0700 (PDT)
Received: from linux-50d1.suse.de (li2018-174.members.linode.com. [172.105.125.174])
        by smtp.gmail.com with ESMTPSA id u93sm1663524otb.33.2020.06.04.20.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 20:20:05 -0700 (PDT)
From:   Yong Sun <sunyong0511@gmail.com>
X-Google-Original-From: Yong Sun <yosun@suse.com>
To:     fstests@vger.kernel.org
Cc:     Yong Sun <yosun@suse.com>, sandeen@sandeen.net, pvorel@suse.cz
Subject: [PATCH v3] fstests: modify user name beginning with non-digit
Date:   Fri,  5 Jun 2020 11:12:38 +0800
Message-Id: <20200605031236.7529-1-yosun@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

openSUSE and SLE don't support username begin with digit, so it will
skip test generic/597 and generic/598 by lack of 123456-fsgqa user.
generic/597 and 598 are not test username begin with digit on purpose
(different with generic/381). It's will be helpful to use an username
begin with non-digit in this case.

Signed-off-by: Sun Yong <yosun@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
v2: Remove invalid comments after change
v3: Add relevant comment back and choose a better username
---
 README            | 1 +
 tests/generic/597 | 6 ++----
 tests/generic/598 | 6 ++----
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/README b/README
index 094a7742..f1fac399 100644
--- a/README
+++ b/README
@@ -22,6 +22,7 @@ _______________________
 - create fsgqa test user ("sudo useradd -m fsgqa")
 - create fsgqa group ("sudo groupadd fsgqa")
 - create 123456-fsgqa test user ("sudo useradd 123456-fsgqa")
+- create fsgqa2 test user ("sudo useradd fsgqa2")
 
 ______________________
 USING THE FSQA SUITE
diff --git a/tests/generic/597 b/tests/generic/597
index 1d87a23a..df6911a1 100755
--- a/tests/generic/597
+++ b/tests/generic/597
@@ -41,13 +41,11 @@ _supported_os Linux
 _require_test
 _require_sysctl_variable fs.protected_symlinks
 _require_sysctl_variable fs.protected_hardlinks
-# su in _require_user prints warnings about user name starts with a digit,
-# discard the warning
-_require_user 123456-fsgqa >/dev/null 2>&1
+_require_user fsgqa2
 # Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
 _require_user fsgqa
 
-OWNER=123456-fsgqa
+OWNER=fsgqa2
 OTHER=fsgqa
 
 # Save current system state to reset when done
diff --git a/tests/generic/598 b/tests/generic/598
index 998b62cf..119d5644 100755
--- a/tests/generic/598
+++ b/tests/generic/598
@@ -41,13 +41,11 @@ _supported_os Linux
 _require_test
 _require_sysctl_variable fs.protected_regular
 _require_sysctl_variable fs.protected_fifos
-# su in _require_user prints warnings about user name starts with a digit,
-# discard the warning
-_require_user 123456-fsgqa >/dev/null 2>&1
+_require_user fsgqa2
 # Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
 _require_user fsgqa
 
-USER1=123456-fsgqa
+USER1=fsgqa2
 USER2=fsgqa
 
 # Save current system state to reset when done
-- 
2.26.2

