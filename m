Return-Path: <SRS0=iucR=7Q=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C06A2C433E0
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Jun 2020 10:21:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D5720679
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Jun 2020 10:21:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lBE3ZZob"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725881AbgFCKVT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 3 Jun 2020 06:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbgFCKVO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Jun 2020 06:21:14 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0042C08C5C0
        for <fstests@vger.kernel.org>; Wed,  3 Jun 2020 03:21:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id q16so675872plr.2
        for <fstests@vger.kernel.org>; Wed, 03 Jun 2020 03:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QGIvRlWNcsPfdG6tx/HBHBHsscgubm3oWVYu3vHnwXA=;
        b=lBE3ZZobyND3RfMp++F57ma7EwHkHnVHb8kw84A7Q5iY1dhMuNKer8isxe4Pt4T4J1
         mZ1TEc6KUMZGbWJgBpGzMgr0ZGbmKkopgenjBLOvUNOlRTLSZJb2XmaYGlGAVupHSrf7
         Ykp7kNddgMHLys+BxTUQkWaY61ikRn7KUWWYCZd+8gbRH9MLWLvvHCtY43uxzvIbclFM
         EApsROOA6+ikb3T3gHStwbWw7VLB9xwC12NfHVoZluvIo2MgJ6fT8yeiph9bdr+jP9yn
         HJVLrUOoO6GoveQYBsN7kBJa2GYJBprT9qcAYDdGyzGH/suPy/zWCTzydxm20340Kr4K
         gEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QGIvRlWNcsPfdG6tx/HBHBHsscgubm3oWVYu3vHnwXA=;
        b=O1p6PsRB/V36uEwayHJp0aXivcv/plzTJX0T45MJIDsX48W0K+7Un6bNsm0vv0w1oj
         5MkSq7v80yCN1nkGYQN7z/9m6+m44Al2DY86fcsnDXLFbakBzVuIFMKwV2Fz9LiV/CNx
         /y7NkXfBmXPTonNaT/e4csb9XQMLRkCAwcIWpgHCNckDeyNoP39EJKOqaITiF54C2psE
         EeHvQs+dl0rCwSRNFcZpGWP76/KcrGVdnT5d89w1Rw5Rul+bQYCTfS5sn+zOpMUIKzrT
         2Trusc59IWIrelJZDqql82NW5stOqQxA5W+Az65OOgQGvZA41C5Q51PUrpKaOAG+AmRx
         0DQQ==
X-Gm-Message-State: AOAM532YuBjVSoO6s8SFNRO1bLpO/uRfuiv6vJ6Y9fOV8WMKBsRaJKq5
        OrouPDnDZI3zk8/CShYtUxRj88j2
X-Google-Smtp-Source: ABdhPJxPHB1kybNdR+HU5td8RV5zdkeNUDTr5V1f7lBjlINZZPBm96yciUiXvrqOW/7uhTQpNWH8mw==
X-Received: by 2002:a17:902:9f93:: with SMTP id g19mr3414346plq.314.1591179673028;
        Wed, 03 Jun 2020 03:21:13 -0700 (PDT)
Received: from linux-50d1.suse.de (li2018-174.members.linode.com. [172.105.125.174])
        by smtp.gmail.com with ESMTPSA id f14sm2012796pjq.36.2020.06.03.03.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jun 2020 03:21:12 -0700 (PDT)
From:   Yong Sun <sunyong0511@gmail.com>
X-Google-Original-From: Yong Sun <yosun@suse.com>
To:     fstests@vger.kernel.org
Cc:     Yong Sun <yosun@suse.com>
Subject: [PATCH] fstests: modify user name beginning with non-digit
Date:   Wed,  3 Jun 2020 18:20:36 +0800
Message-Id: <20200603102035.552-1-yosun@suse.com>
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
---
 README            | 1 +
 tests/generic/597 | 4 ++--
 tests/generic/598 | 4 ++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/README b/README
index 094a7742..cffa0bc6 100644
--- a/README
+++ b/README
@@ -22,6 +22,7 @@ _______________________
 - create fsgqa test user ("sudo useradd -m fsgqa")
 - create fsgqa group ("sudo groupadd fsgqa")
 - create 123456-fsgqa test user ("sudo useradd 123456-fsgqa")
+- create fsgqa-123456 test user ("sudo useradd fsgqa-123456")
 
 ______________________
 USING THE FSQA SUITE
diff --git a/tests/generic/597 b/tests/generic/597
index 1d87a23a..c4d524b7 100755
--- a/tests/generic/597
+++ b/tests/generic/597
@@ -43,11 +43,11 @@ _require_sysctl_variable fs.protected_symlinks
 _require_sysctl_variable fs.protected_hardlinks
 # su in _require_user prints warnings about user name starts with a digit,
 # discard the warning
-_require_user 123456-fsgqa >/dev/null 2>&1
+_require_user fsgqa-123456 >/dev/null 2>&1
 # Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
 _require_user fsgqa
 
-OWNER=123456-fsgqa
+OWNER=fsgqa-123456
 OTHER=fsgqa
 
 # Save current system state to reset when done
diff --git a/tests/generic/598 b/tests/generic/598
index 998b62cf..1cf9a3d1 100755
--- a/tests/generic/598
+++ b/tests/generic/598
@@ -43,11 +43,11 @@ _require_sysctl_variable fs.protected_regular
 _require_sysctl_variable fs.protected_fifos
 # su in _require_user prints warnings about user name starts with a digit,
 # discard the warning
-_require_user 123456-fsgqa >/dev/null 2>&1
+_require_user fsgqa-123456 >/dev/null 2>&1
 # Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
 _require_user fsgqa
 
-USER1=123456-fsgqa
+USER1=fsgqa-123456
 USER2=fsgqa
 
 # Save current system state to reset when done
-- 
2.26.2

