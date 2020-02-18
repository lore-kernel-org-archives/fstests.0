Return-Path: <SRS0=z/AK=4G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33879C34026
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Feb 2020 14:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F27A6208C4
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Feb 2020 14:29:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="zObFk4cy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgBRO3t (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Feb 2020 09:29:49 -0500
Received: from mail-qk1-f173.google.com ([209.85.222.173]:45447 "EHLO
        mail-qk1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726116AbgBRO3t (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Feb 2020 09:29:49 -0500
Received: by mail-qk1-f173.google.com with SMTP id a2so19584538qko.12
        for <fstests@vger.kernel.org>; Tue, 18 Feb 2020 06:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9GgDl7Uv0suH+DqLJarwivXGLHfuBrz191M6D9vpRs=;
        b=zObFk4cyFJ55d1z0uf7qZPTNZaNqm0DgmV+fQwe8ZfmkVPnKJtX7zHHaR/Dpt3bieI
         t6KEQgeeOpZcNAZf46lKIvxHBwj7TIZnYw6AMHhywgQnVfey5l+LQvy/AgqE7e8kiN4t
         +XJNZRYrQuTf52CzYYBkqY7Bi6Jy2q9V0cKOuS76js1XQ7TGNKyAMRMu+WpVTJRsofA5
         WX/FA2hdP1XS6Dk7owYtmTz8fpbuThpbwXZ+BdrC+uQ5xexqaEX5a7YQ0VOfpUonIgjn
         0ph0G0fCvauUobmRc5Pfnijft8+w5G16cX1OqXJGxcOOnOOuxtWlmNctIbYfVZRzX1FI
         Ytgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R9GgDl7Uv0suH+DqLJarwivXGLHfuBrz191M6D9vpRs=;
        b=VSyuSA5Sb8dLDccOAJ8OyDf1YODwApVVK+OOqfAg4q91wLyygX8Qtdh5SVrFggtl9K
         e+NuLO6FsO/NyvyPAo9vr/oNflX5e739lOg/A4RZNKPCuS9E+pdGe9V9PjlAFhb5lopE
         ltmlgO3a2NgD0DDK/WRjTnokmv4CtuDSKqEacPUnz6iKy6yjf7ripfNGbiXIiAsKXKu1
         36rpURxFxKtJRzC7YcDbsZtFyoW1YekL0CfLdMAOQ93+hLgCdABRihBhKalxxL/iCjsW
         KD/xSoZVH5FPj1OniSKVsXY0aKb7KZrkOEzPM/L9Uo3TeahFNLtzbNCFYWJoIhkV1Y/n
         opFQ==
X-Gm-Message-State: APjAAAXuNWXI4MltNZCm8HSKwHKkpqU0Xkq0MoMlfHA1FFUeqh9f64DK
        bQ9590GP1oWrIpV2h7hMdQQb8A==
X-Google-Smtp-Source: APXvYqwy+ta/ZN2mjSLOWj5WG+8g5+rx1xV+ipNkM02ksbQBpTPv9dx1tSraXx80E9bJu1LyLBmjlw==
X-Received: by 2002:a37:a5cc:: with SMTP id o195mr18989387qke.25.1582036187196;
        Tue, 18 Feb 2020 06:29:47 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id l19sm1941460qkl.3.2020.02.18.06.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2020 06:29:46 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     kernel-team@fb.com, fstests@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: [PATCH] fstests: add perf to the list of test directories
Date:   Tue, 18 Feb 2020 09:29:45 -0500
Message-Id: <20200218142945.3719579-1-josef@toxicpanda.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

I noticed that despite having PERF_CONFIGNAME set I wasn't getting the
perf/ tests run when I used -g auto.  This is because it's not included
in the list of directories to look at.  Fix this so that perf tests get
run as well.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check b/check
index 89f3358a..9e7b6134 100755
--- a/check
+++ b/check
@@ -44,7 +44,7 @@ timestamp=${TIMESTAMP:=false}
 
 rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.xlist $tmp.report.*
 
-SRC_GROUPS="generic shared"
+SRC_GROUPS="generic shared perf"
 export SRC_DIR="tests"
 
 usage()
-- 
2.24.1

