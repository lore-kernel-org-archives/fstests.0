Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA8C0ECAAD8
	for <linux-fstests@archiver.kernel.org>; Fri, 26 Aug 2022 21:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343782AbiHZVtx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 26 Aug 2022 17:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345245AbiHZVt1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 26 Aug 2022 17:49:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91BD1E97DC
        for <fstests@vger.kernel.org>; Fri, 26 Aug 2022 14:48:37 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo9259700pjd.3
        for <fstests@vger.kernel.org>; Fri, 26 Aug 2022 14:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=bvrd+IKAxDqo/7NPDxGtUhkxVV0kOm/BeU4YQU9fCgw=;
        b=JQWH0+l0tVVm/d9ik6pL1PVg7v0b6ZNOiekaJLRVpyzCzqKNuHKR8V6viv0KLu7Mj7
         8oBriX789E3B5dAhJCCUE5IKSOn+nSEtDfnvHdQw+ZV+wmp0es3/bxqHsBMiT65Ft8qq
         6qOroAOI6qXYMrhVfrIu1FJm1d5kn/s1ey6so=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=bvrd+IKAxDqo/7NPDxGtUhkxVV0kOm/BeU4YQU9fCgw=;
        b=f9NqGmOH+xa23vZg6XCT+sgEXzFu/0vLKjqJkdeMdOITuQWcx18oVBxCGJ4NngVCMy
         U+Pr/q343gGo1DIV4K/QhmiaQiRaabXAP7j4yLP3C6nbEW/G0brCvHwb2dpVMG9QvF2S
         1ycsnt6h6+gUccysOeA2h40H8h3tQsZp6S9Q/M1l8LTIyECEkHaVCgw/pudhfC7+pclD
         xhnIv8pvmttjry5pvYjI/Q+C4BceRIZLDV7WFx4R15ePx6unlwYskOY3bZZW3CtKuTwM
         pUdV3KsFqfU0Qaa0gMbTlcjMq2oTmI6UMXUhGGuSTg89LgwNHTpthuqGnU+Gs6ckKvZ1
         f97A==
X-Gm-Message-State: ACgBeo2pLnwAQLF/GcyFuf97JRFO7MfNUvkmhA6ltqE57DgTpFqoZgug
        ZuYZBxJw7tn9LMhoDlGlTdIckA==
X-Google-Smtp-Source: AA6agR6ucizx9drd380nhTdbOBPR+NjBM0T56sBv+TbZj8rfhxKr9dQIbra/2ZluMuS8oGux13kb5w==
X-Received: by 2002:a17:902:ce12:b0:172:dc6e:18f6 with SMTP id k18-20020a170902ce1200b00172dc6e18f6mr5565243plg.34.1661550516252;
        Fri, 26 Aug 2022 14:48:36 -0700 (PDT)
Received: from localhost ([2620:15c:202:201:da2b:e5dd:15aa:d8e4])
        by smtp.gmail.com with UTF8SMTPSA id a85-20020a621a58000000b00537bdc9c2f2sm2319422pfa.170.2022.08.26.14.48.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Aug 2022 14:48:35 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     tytso@mit.edu
Cc:     fstests@vger.kernel.org, Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] Documentation: alginment fix in quickstart
Date:   Fri, 26 Aug 2022 14:48:30 -0700
Message-Id: <20220826214830.2646837-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Align instructions to build the guest kernel.

Fixes: 72cdf994b221 ("Create and reorganzize top-level directories")

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 Documentation/kvm-quickstart.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/kvm-quickstart.md b/Documentation/kvm-quickstart.md
index bbab180..7401ae4 100644
--- a/Documentation/kvm-quickstart.md
+++ b/Documentation/kvm-quickstart.md
@@ -37,7 +37,7 @@
     the commands:
 
         kvm-xfstests install-kconfig
-	kvm-xfstests kbuild
+        kvm-xfstests kbuild
 
 6.  Run "kvm-xfstests smoke" to do a quick test.  Or "kvm-xfstests
     -g auto" to do a full test.  You can also run specific tests on
-- 
2.37.2.672.g94769d06f0-goog

