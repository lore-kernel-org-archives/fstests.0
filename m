Return-Path: <SRS0=+7JN=7R=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D73C433E0
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Jun 2020 09:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35930204EA
	for <linux-fstests@archiver.kernel.org>; Thu,  4 Jun 2020 09:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EqmdkXoX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgFDJ6e (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbgFDJ6e (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Jun 2020 05:58:34 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBF3C03E96D
        for <fstests@vger.kernel.org>; Thu,  4 Jun 2020 02:58:34 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id i12so932771pju.3
        for <fstests@vger.kernel.org>; Thu, 04 Jun 2020 02:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yu8eWO2mYVztYV785zNnH/4372HrjoAqjUe9GdJGonQ=;
        b=EqmdkXoXnHAHNOBzuEvMVqzC52aDd/X8luotlDCt0qd38dJh9k2ip98pJotz/lPnCl
         niuBhe4fUsNYqmLypKSYn1KV5KQK4Hh+wUjEnx+MWf32sgB95K1mQA+W+7JtE+KnCD3O
         2Aq9Q+ET3FcDNoHlCWRbFYN6xP6QAlSxzMME57A9LPWEaKJQRn3IJlohvpDvlnQNWaqC
         ZXs3c38G8HhsodM4V4cL+50oAPQLAoAxgFEnRjwUe1QVBwSrWuy46G272sttGkfCSh3s
         kFRYW5P7+8UAQPRtWCoJxpoNzvU3DC7wJLA/FjcocGGAIfGx4/OVcpKDAlDEAMlFOBzC
         vCKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yu8eWO2mYVztYV785zNnH/4372HrjoAqjUe9GdJGonQ=;
        b=ba5FRNlzNESJnJ3AeOzEDzoYOP+1/l8bQxHvDdd6W0/KUJWsMaxmz3KUhd6uNwzDxg
         ryAcsZ+Rrkij7bHKz3dQoCa3/R5X9c76z+XI1V+kZStekc+6l0ubay3JGmIBX8XOYdzb
         ycdX0YQiiUs7G5Be6tzem7WoEx8e9d4xAkEh+cbTG/YLJXWhXnbQCjKtpIe0QtDTW0XM
         +K3JjHsAR//cKNEPm8cJCTfkNS2634i/kji/xzxmVIIEfH7wCIz4ZJ1+VvlxQtjXECQN
         LxSyzH6STqBu2YzMaBi+QyMgDdmtQwfzzH6qirmqrE/Ml98lMztQC9SdXixS5UPXS3aM
         z8Mg==
X-Gm-Message-State: AOAM530AG6zCqRCPBQFxKhEvUPBCGVn9MGRuk2JtL+McgejW6ZR4JROM
        9jx1HMMvQzonFRal84TSBQK78ESL1G0=
X-Google-Smtp-Source: ABdhPJz12HjP3zd3UgCtP7VGu1Ix3WKD+o5Zthx/XsV/np3sBel4yB07IBW5Oq5UmX2b1Ezz+3WoYw==
X-Received: by 2002:a17:90a:dc83:: with SMTP id j3mr4980983pjv.59.1591264713547;
        Thu, 04 Jun 2020 02:58:33 -0700 (PDT)
Received: from linux-50d1.suse.de (li2018-174.members.linode.com. [172.105.125.174])
        by smtp.gmail.com with ESMTPSA id y4sm4084203pfr.182.2020.06.04.02.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 02:58:32 -0700 (PDT)
From:   Yong Sun <sunyong0511@gmail.com>
X-Google-Original-From: Yong Sun <yosun@suse.com>
To:     fstests@vger.kernel.org
Cc:     Yong Sun <yosun@suse.com>, pvorel@suse.cz, zlang@redhat.com
Subject: [PATCH v2] fstests: modify user name beginning with non-digit
Date:   Thu,  4 Jun 2020 17:57:28 +0800
Message-Id: <20200604095727.21720-1-yosun@suse.com>
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
 tests/generic/597 | 7 ++-----
 tests/generic/598 | 7 ++-----
 3 files changed, 5 insertions(+), 10 deletions(-)

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
index 1d87a23a..11846b95 100755
--- a/tests/generic/597
+++ b/tests/generic/597
@@ -41,13 +41,10 @@ _supported_os Linux
 _require_test
 _require_sysctl_variable fs.protected_symlinks
 _require_sysctl_variable fs.protected_hardlinks
-# su in _require_user prints warnings about user name starts with a digit,
-# discard the warning
-_require_user 123456-fsgqa >/dev/null 2>&1
-# Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
+_require_user fsgqa-123456
 _require_user fsgqa
 
-OWNER=123456-fsgqa
+OWNER=fsgqa-123456
 OTHER=fsgqa
 
 # Save current system state to reset when done
diff --git a/tests/generic/598 b/tests/generic/598
index 998b62cf..b6a1cb3a 100755
--- a/tests/generic/598
+++ b/tests/generic/598
@@ -41,13 +41,10 @@ _supported_os Linux
 _require_test
 _require_sysctl_variable fs.protected_regular
 _require_sysctl_variable fs.protected_fifos
-# su in _require_user prints warnings about user name starts with a digit,
-# discard the warning
-_require_user 123456-fsgqa >/dev/null 2>&1
-# Do this SECOND so that qa_user is fsgqa, and _user_do uses that account
+_require_user fsgqa-123456
 _require_user fsgqa
 
-USER1=123456-fsgqa
+USER1=fsgqa-123456
 USER2=fsgqa
 
 # Save current system state to reset when done
-- 
2.26.2

