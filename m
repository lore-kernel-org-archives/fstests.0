Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477FAC77B76
	for <linux-fstests@archiver.kernel.org>; Fri, 14 Apr 2023 22:11:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjDNWL6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 14 Apr 2023 18:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjDNWL4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 14 Apr 2023 18:11:56 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6D14EE9
        for <fstests@vger.kernel.org>; Fri, 14 Apr 2023 15:11:42 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id f2so11317413pjs.3
        for <fstests@vger.kernel.org>; Fri, 14 Apr 2023 15:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681510301; x=1684102301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U2E6oLT8a9wEsZkAUiDTeUjMtVbGXoTa5rKPpX0GQKU=;
        b=idwbjr53furWG8SS9F7hFFaEV/Qn4Lh6NRgaw2/MnT1etLLsr2tDsoJLO1RLKGU+5r
         hjRza6YPR4JSm/qD/suxo4xi7/qCnFm4P4jUcnaNAcH/WvKvwZ4qQ+UZIXublopWL5Vk
         W04iM/iK+f2Kn4nACEJi0NYy0m657CRpAKkEC8zMPyu87tc16hMZiTqdQmiy+w6MDPx8
         NyZO7Hgjr5bOzElBTOgDRBgrq9w6o5IVNRjpqtuWepYrMveQ2kWe0c9ShC3ObKEen2Po
         EUwXsDBBCxy2Gwq47/MnaaO4a42TwIyzaG5EpJ6JkW5HLhQvVbAmY9tvypCXe2risnq4
         OItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681510301; x=1684102301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U2E6oLT8a9wEsZkAUiDTeUjMtVbGXoTa5rKPpX0GQKU=;
        b=bWycVw/66/SvMAu2zKbddAV0ka5EmENoI2Q96bcvkpL/MwH1HMyS5vbBsmnd2Jk/rZ
         dRpWdBX+zOlx9f4RtP73qgI8KWYEJDgQfabq3EWjG/V0xea4oD7rG9cjU1TkY8yoKqUj
         CNPnzv+F5TjUNJB2aP092UaPCR6u476D//apKQ4qiWaaFV52Nwt4cVA4k8VCUhlpXPgu
         0KmLg/RRFKRquoSNOvdTRMf/O2k9zywHe0KzYGIVBI/i8k+LLnVTOqpng7mrLj/j7ZR9
         XJk2djhA9uCW/9wxaCHbAHlnSYyyD9rrG5mt7LYFJDKEOMsQOSExfimDPL/dD1jyLsjE
         P6Xw==
X-Gm-Message-State: AAQBX9cLk/Cde9t06pd+ep9Ae8B/JKJ0mVQHa/0NYlcAk61RvNpoI/QR
        g5oZZOPEo44rZmVoRI4MZdIIbMfW0tc=
X-Google-Smtp-Source: AKy350Y3rWj+xaM406WaJ2M75WNayOCRPpWa/Yw0K55f5764CM9EyS+d0Nbw2B650mDcqcl6FrCV4w==
X-Received: by 2002:a05:6a20:1454:b0:ec:414f:8f9f with SMTP id a20-20020a056a20145400b000ec414f8f9fmr9291961pzi.25.1681510301401;
        Fri, 14 Apr 2023 15:11:41 -0700 (PDT)
Received: from lrumancik.svl.corp.google.com ([2620:15c:2d4:203:1fb3:c400:8b7a:ed6])
        by smtp.gmail.com with ESMTPSA id k14-20020aa792ce000000b0062e15c22cd8sm3473219pfa.48.2023.04.14.15.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 15:11:41 -0700 (PDT)
From:   Leah Rumancik <leah.rumancik@gmail.com>
To:     fstests@vger.kernel.org
Cc:     tytso@mit.edu, djwong@kernel.org,
        Leah Rumancik <leah.rumancik@gmail.com>
Subject: [PATCH 2/2] check: _check_filesystems for errors even if test failed
Date:   Fri, 14 Apr 2023 15:11:33 -0700
Message-ID: <20230414221133.3431400-2-leah.rumancik@gmail.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
In-Reply-To: <20230414221133.3431400-1-leah.rumancik@gmail.com>
References: <20230414221133.3431400-1-leah.rumancik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Previously, we would only run _check_filesystems to ensure that a test
that appeared to pass did not have any filesystem corruption. However,
in _check_filesystems, we also repair any errors found in the filesystem.
Let's do this even if we already know the test failed so that subsequent
tests aren't affected.

Signed-off-by: Leah Rumancik <leah.rumancik@gmail.com>
---
 check | 1 +
 1 file changed, 1 insertion(+)

diff --git a/check b/check
index befbf465..c18f02ca 100755
--- a/check
+++ b/check
@@ -972,6 +972,7 @@ function run_section()
 			# Even though we failed, there may be something interesting in
 			# dmesg which can help debugging.
 			_check_dmesg
+			(_adjust_oom_score 250; _check_filesystems)
 			tc_status="fail"
 		else
 			# The test apparently passed, so check for corruption
-- 
2.40.0.634.g4ca3ef3211-goog

