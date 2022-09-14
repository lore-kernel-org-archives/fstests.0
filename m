Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 824ABC6FA89
	for <linux-fstests@archiver.kernel.org>; Wed, 14 Sep 2022 09:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbiINJP1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 14 Sep 2022 05:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbiINJOe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 14 Sep 2022 05:14:34 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88A778589
        for <fstests@vger.kernel.org>; Wed, 14 Sep 2022 02:06:33 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id c6so11222283qvn.6
        for <fstests@vger.kernel.org>; Wed, 14 Sep 2022 02:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=qYcb/Ydik4KcUVhndWl8iSSvBnJ7xykgJWs3X+3iiIM=;
        b=aXgsG1aVquj/S3yVeOJU1rC1q9aBpRZC7H1BVGkwJvJMtHI/RjNEw7PYYu+RQ6ZICY
         7gyqItAaqju8Gbk7iukiRo4migp3vxWDiGcWHccNKg7SFPVee+/21fzF+LOrwbUOA2FT
         E2nwC4QHS9ZetyJBHV6tr0JFBVhQTfeOCUBfVmhiCAIFAU/ORwB4tauB5uosvQscZlWr
         2mHmNCEjwIfE6MNldX+xgjVBTqloIGApl98HuMWns4V9YWqx62iqfeZMQ5PUnr7MYYOz
         skkuvf1IXa0buGkKK8kJAkAyppC/uKr8R2sXkBpNVViGikzx1peANmxWxW14G/49KEyH
         +4Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=qYcb/Ydik4KcUVhndWl8iSSvBnJ7xykgJWs3X+3iiIM=;
        b=iBQIogWtiDa9phBNhQEKBBrGZYR+zdTrXia9EiUM+y/oNChGQWuWywtoC0fLQsrqCQ
         CaaJEDlSAAXEI1uL6sxq77Tci8IXGO67TsEkbucDZ6bxGsdnAafFjfmrMAQ4EIG4I6OM
         SoxvUqM1TmFwJgBUk8QEHJp0LCcVoFR4G4ZolQ0VI/cAEeIRhaHavTKCC9JQt/jwzXjr
         xxy7ZDI6QhSyF+ANQ46jOjvYGqW2co9+moE/4pBWJwNRqrHpPzRgVlKUvWaGwS/aZvS/
         ztksK7YXJ2ZmouZUQ58CJQfEGvgD1LJIinnfSXSgByQb4TSuY3IEQ+9Cqfs/kiuLsjqS
         iSiQ==
X-Gm-Message-State: ACgBeo1uKeoVjsiLEWWOyZ0BxW44fPc112yh8KtiZPe6Cr/hvB6iSuzc
        5wSYGSpu39FTn07Ae6e3HKhcf9Rt5gY=
X-Google-Smtp-Source: AA6agR67uCml+EYpOGIptFZF65BNBIGQxh3D6foGIKY06wRnSKUlUKltw40/Snz8lZ9mrXeixtK1xw==
X-Received: by 2002:ad4:5bec:0:b0:4ac:9578:4c4c with SMTP id k12-20020ad45bec000000b004ac95784c4cmr18638973qvc.13.1663146383542;
        Wed, 14 Sep 2022 02:06:23 -0700 (PDT)
Received: from xzhouw.hosts.qa.psi.rdu2.redhat.com ([66.187.232.127])
        by smtp.gmail.com with ESMTPSA id cp4-20020a05622a420400b0035bab4dd6c9sm1250324qtb.22.2022.09.14.02.06.22
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 02:06:23 -0700 (PDT)
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 2/2] common/quota: fix grep pattern
Date:   Wed, 14 Sep 2022 17:06:10 +0800
Message-Id: <20220914090610.1994485-2-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220914090610.1994485-1-jencce.kernel@gmail.com>
References: <20220914090610.1994485-1-jencce.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The second dash is not needed now. Newer grep is complaining:
+grep: warning: stray \ before -

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 common/quota | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/quota b/common/quota
index 22be3c69..01ff7e6d 100644
--- a/common/quota
+++ b/common/quota
@@ -218,7 +218,7 @@ _qmount()
         quotacheck -ug $SCRATCH_MNT >>$seqres.full 2>&1
         quotaon -ug $SCRATCH_MNT >>$seqres.full 2>&1
         # try to turn on project quota if it's supported
-        if quotaon --help 2>&1 | grep -q '\-\-project'; then
+        if quotaon --help 2>&1 | grep -q '\--project'; then
             quotaon --project $SCRATCH_MNT >>$seqres.full 2>&1
         fi
     fi
-- 
2.31.1

