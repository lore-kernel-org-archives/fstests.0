Return-Path: <SRS0=288U=2B=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F47C43603
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Dec 2019 20:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 494BC20836
	for <linux-fstests@archiver.kernel.org>; Wed, 11 Dec 2019 20:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576095514;
	bh=wn8i6SPp9lcbnstJnMsvTdbo1QAO4+BF6p8YRBL4okY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=S35nXm1YW0uegxejPFOreh5ycFW7aXJpxwYzDHamHW9v3PxyjgtTVtsWcLoTchvZm
	 L+IR8WEv7EgLkfLHXwauKntLaLowjWcbZIHo+72DRkOpq7TwYw0w7BmpzxFIWREdzR
	 Hfs1ON6BrUMS4Yehqr2lprztkjjhyeBhR57H7tbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbfLKUSe (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:18:34 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40365 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbfLKUSd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 11 Dec 2019 15:18:33 -0500
Received: by mail-pj1-f67.google.com with SMTP id s35so21701pjb.7
        for <fstests@vger.kernel.org>; Wed, 11 Dec 2019 12:18:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=02Rl6VxCuaqr626GRQ1Zrp7O8kYllluTOrv9vePcanQ=;
        b=lbX2IusrdA1rPoW8sm/NqhPRV8VSzc2xn6sxAutgYt8uZkHtnLM5Va0WFJstrcTPIo
         413llz98ls6bxVQpHSYHMo+kSPpinkCErRuJtkJCsrTHnuHGXmkURDK/ttcxVaku7Jtd
         84eiHJ233+ZMwCDnNmCh+ejrIXIKwdyLzid6UMK7qoXDzz17b0eOfPWWx3Rd1uXCNrmV
         VpCugTYTUVvuIzce5yZqHOwNvp2Defm/PBs2MTAWYQvU0Dy4lgN0mTNq8IG4bttBcNh1
         /FT7QeH2XOXSWI3T6hWb3C96+sOdrFUSaxEDfiNqMmLVU4luF+6f8lQzqJC8mJISr5fa
         8qtw==
X-Gm-Message-State: APjAAAVd1dOg8C4/xtOqCpwW9rJ3SDddbSA2+oXagQfqzUsN7YBEas/2
        8C2y9PoCPIGEs2fjOny6DY0T/SX1euY=
X-Google-Smtp-Source: APXvYqwTWZIKX0wSYjrUYos4ATpUPLCUNbJDqu5AmDAW1oEubn5mANgCDNKhdVoBlkXP0VULuDikfA==
X-Received: by 2002:a17:90a:8c12:: with SMTP id a18mr5642591pjo.53.1576095513000;
        Wed, 11 Dec 2019 12:18:33 -0800 (PST)
Received: from dennisz-mbp.thefacebook.com ([199.201.64.138])
        by smtp.gmail.com with ESMTPSA id u18sm4031977pgn.9.2019.12.11.12.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Dec 2019 12:18:32 -0800 (PST)
From:   Dennis Zhou <dennis@kernel.org>
To:     fstests@vger.kernel.org
Cc:     kernel-team@fb.com, Dennis Zhou <dennis@kernel.org>
Subject: [PATCH] common/rc: fix device size parser
Date:   Wed, 11 Dec 2019 12:18:30 -0800
Message-Id: <20191211201830.18911-1-dennis@kernel.org>
X-Mailer: git-send-email 2.13.5
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

If you have multiple devices that share the same regex (eg dm-1, dm10),
then _get_device_size() can return "$size\n$size" which causes the
following error for btrfs/011.

    QA output created by 011
    ./common/rc: line 3084: [: too many arguments

So, fix this by making grep check against eol.

Signed-off-by: Dennis Zhou <dennis@kernel.org>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 5cdd829b..b819ede1 100644
--- a/common/rc
+++ b/common/rc
@@ -3583,7 +3583,7 @@ _get_available_space()
 # return device size in kb
 _get_device_size()
 {
-	grep `_short_dev $1` /proc/partitions | awk '{print $3}'
+	grep "$(_short_dev $1)\$" /proc/partitions | awk '{print $3}'
 }
 
 # Make sure we actually have dmesg checking set up.
-- 
2.17.1

