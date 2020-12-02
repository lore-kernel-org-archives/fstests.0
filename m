Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A44C64E7C
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Dec 2020 10:16:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE64A221FA
	for <linux-fstests@archiver.kernel.org>; Wed,  2 Dec 2020 10:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgLBKQf (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 2 Dec 2020 05:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbgLBKQf (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 2 Dec 2020 05:16:35 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A30C0613D6
        for <fstests@vger.kernel.org>; Wed,  2 Dec 2020 02:15:55 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id x4so861071pln.8
        for <fstests@vger.kernel.org>; Wed, 02 Dec 2020 02:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cij6uNUMwWdEvMmnCRBAigcL3KFuqXr/lH4oDDprerA=;
        b=CUt5wF93GFMbrCte7GCu91dLn31t8gxxUep1gW1e1tyeEQtZTRtr83AdotFeB6APCM
         vE3X/MTJghMxxUrSEOiUvFqe0Ri4nN91cg7ikzrwGCEg5N94cc4tfDHsqZztsKm9Bbo3
         /FH6V+FITkSeXTarEMXtM0a6XLsDrOeJicf6T4y/7QQgsaNNWFfDRglxAWoXDdDC2jZ5
         xKBc+PGrGW7ilc4ipB5qkk+YjUMXpuUehJkFQqOjlh8XurEfn/oqEJmxT18WEz1+0lhv
         OMAXLcQOdEb+MwChT+ddjNovBGMV/GkE+9CKGQQGAs9GmQyUK5eI1KHPygViIGAha9Ta
         HT/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cij6uNUMwWdEvMmnCRBAigcL3KFuqXr/lH4oDDprerA=;
        b=BYhpu5LLiwqD8FnkvUgWdRniQtBxJZ4b/ZKjPw5xgl7ZUV7rCbFnAiz5sn5IbICiDy
         usgotEKu3lxJcMnbqNxp3I6P5UsSRpkK7W1ZyIRk10G8RPHo0VvopQfJe2ph2l3/HozD
         8unJkkqTTDJ3mDWm/MmJ/FgERs6GUdKkJJPFJb1ePdGy+aWh0JTyL8lO/bNAGwdJ+Avr
         nNmbOrfZSXOmkjUVNiZjOiA+4IF4kbqsfGEwCjbmrAPq/rIpmGLeVLoEKri0tEee+r4V
         kv3TgSpz/LAWwoy/thW438UQB8UA7KWOXaFNtpmvksPpqMoUakGoTVnh5i4P85YcFx36
         SBLg==
X-Gm-Message-State: AOAM533uhNKduNZynsHJgRYqk5z9UgvliFktSJjDBBwbJE4l2SYdWhSr
        A6s4ZhSD1mDO3SLH4Ey48/5FBRkTamk=
X-Google-Smtp-Source: ABdhPJyvKQEFwMQkT8mr9yibXP/yzLHQgMuGbaPLd1gJtLGV0Zr10qG9p62nlyQFZG8WDFElgtXeLQ==
X-Received: by 2002:a17:90b:8d3:: with SMTP id ds19mr1745100pjb.186.1606904154338;
        Wed, 02 Dec 2020 02:15:54 -0800 (PST)
Received: from xzhoux.usersys.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id c3sm1596223pgm.41.2020.12.02.02.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 02:15:53 -0800 (PST)
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     fstests@vger.kernel.org
Cc:     darrick.wong@oracle.com, Murphy Zhou <jencce.kernel@gmail.com>
Subject: [PATCH] generic/506: require prjquota
Date:   Wed,  2 Dec 2020 18:15:21 +0800
Message-Id: <20201202101521.15405-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

To avoid false failure on overlayfs.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 tests/generic/506 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/506 b/tests/generic/506
index d5b28cad..edcda6db 100755
--- a/tests/generic/506
+++ b/tests/generic/506
@@ -42,6 +42,7 @@ rm -f $seqres.full
 # real QA test starts here
 _supported_fs generic
 
+_require_prjquota
 _require_scratch
 _require_scratch_shutdown
 
-- 
2.20.1

