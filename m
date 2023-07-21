Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC4C5EB64DD
	for <linux-fstests@archiver.kernel.org>; Fri, 21 Jul 2023 19:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjGUTsb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 21 Jul 2023 15:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGUTsa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 21 Jul 2023 15:48:30 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036A92D7C
        for <fstests@vger.kernel.org>; Fri, 21 Jul 2023 12:48:30 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-cea0021d1f3so5099819276.0
        for <fstests@vger.kernel.org>; Fri, 21 Jul 2023 12:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20221208.gappssmtp.com; s=20221208; t=1689968909; x=1690573709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=REYU7wtoXPaXK5+8EvlWJ8j+7C0tsyFIsn1U4/RaKF4=;
        b=S40iCYrXBJCfKekHhG+dtDqL8RK6YYYtYdXlEK4J922vHeq2HMUD1vEYowKgXKRpA+
         u/nDU9B3gqkARHzWZw9SBlvOi1fO8j8ehY4HqyINvUXBBmzrNS38OhB3mEfbYfaJeOqF
         yFjQi29pGZqL/IB/i0J4D2Pi7dkn/UUoKrKMpUldpS4TrUwVufYiJJGFn/5YasgDyr9r
         oHctTGt1U9PGhIvySEnau9FWi0h/tCwsKZWFtAxEdaAg368QSBhsUJkxQ/mFC2N7silb
         pPrupRJ6gJEy8sdwHqc1pgrd1rTWc9sH42cX28M9WRH8SgIIUqQm4shmgAklUz+/1P4c
         n7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689968909; x=1690573709;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=REYU7wtoXPaXK5+8EvlWJ8j+7C0tsyFIsn1U4/RaKF4=;
        b=SBlMR9Km7uFd3dqX/AtyMoiGGIBY+ZitYPn+ZQt8Wdd2AVudWc6szcWaHQJiAsB9KI
         eAekymTLfkBCaoOvX4LYwdtsrmAGd1OaN2zdsJu3W5Xcv1K3JgaRSdLPKRwtsuq0uC7U
         EmbwcSCYq4WozoS0kFXYcIR826rr8uErIpys4R5fkoa6gQ8GUOYkAqbRdzhuiglaL4/Z
         aDp80dRshjhXifJuNPF+TUYWIKL4tHKrTOzqwnv3Jowyv5pzkVWBxpulMUceKdnpw3nK
         UrBMGxoxe2ikZ0lS5YU9JPk9YXQWxcb74vkCrsOhk32n6PZpM2jrjeSS1IfpbrrJnuu7
         6Wag==
X-Gm-Message-State: ABy/qLagrDqtUF5OGA3MPZ0VVnRyO7Lct7iBwK2BzS2Cps0+ceriZId0
        0rO2o7qmfVo2O5O71Qf87p+zlzu3Hi3xAjZwA0WE0A==
X-Google-Smtp-Source: APBJJlFGzEVa0fOW8ScjNavSS4gM69gJn2NDFgoSEp0arq3j9lhlInFNfNBSrui4LRhy3EvlpDECgg==
X-Received: by 2002:a25:ff19:0:b0:cfc:d478:be7e with SMTP id c25-20020a25ff19000000b00cfcd478be7emr6313741ybe.10.1689968909005;
        Fri, 21 Jul 2023 12:48:29 -0700 (PDT)
Received: from localhost (cpe-76-182-20-124.nc.res.rr.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id b12-20020a25ae8c000000b00bc68b767cf9sm959434ybj.41.2023.07.21.12.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 12:48:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: [PATCH] fstests: make check actually honor expunged list
Date:   Fri, 21 Jul 2023 15:48:24 -0400
Message-ID: <732fc62557b3dfdba820b83cd9643de314b6976e.1689968898.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The patch 60054d51 ("check: fix excluded tests are only expunged in the
first iteration") messed up the logic, if _function will be true if it
gets 1, so the _expunge_test return values are inverted.  Also it
appears bash swallows the output in this calling convention, so you
don't get the 'expunged' output.  I noticed this when my CI system
stopped honoring my exclude list, this makes everything work properly
again.

Fixes: 60054d51 ("check: fix excluded tests are only expunged in the first iteration")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 check | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/check b/check
index c8593252..b731af74 100755
--- a/check
+++ b/check
@@ -570,11 +570,10 @@ _expunge_test()
 
 	for f in "${exclude_tests[@]}"; do
 		if [ "${TEST_ID}" == "$f" ]; then
-			echo "       [expunged]"
-			return 0
+			return 1
 		fi
 	done
-	return 1
+	return 0
 }
 
 # retain files which would be overwritten in subsequent reruns of the same test
@@ -870,6 +869,7 @@ function run_section()
 
 		if $showme; then
 			if _expunge_test $seqnum; then
+				echo "       [expunged]"
 				tc_status="expunge"
 			else
 				echo
@@ -896,6 +896,7 @@ function run_section()
 
 		# check if we really should run it
 		if _expunge_test $seqnum; then
+			echo "       [expunged]"
 			tc_status="expunge"
 			_stash_test_status "$seqnum" "$tc_status"
 			continue
-- 
2.41.0

