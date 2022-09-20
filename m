Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D8EC54EE9
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Sep 2022 03:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiITDUN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 19 Sep 2022 23:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiITDUI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 19 Sep 2022 23:20:08 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A5B0371A3
        for <fstests@vger.kernel.org>; Mon, 19 Sep 2022 20:20:04 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id s9so819355qkg.4
        for <fstests@vger.kernel.org>; Mon, 19 Sep 2022 20:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date;
        bh=VV7wVdKLlDnZ02Itv0CwuRjjf35FudCY6fpcnm3FEJc=;
        b=WTOJqChHbqNkZwrLo9JXH4KPB+cF/eVqXN44LYFqG3sYPqMAJICOV7f6iQTUrOHqwD
         EJW+FYawzyZqpd8pnBiFXD8vKMTJOfmcWaZn72t2pD4sTn5AE6IvhYGI+Zgb+tEi1WUj
         cNBH8138ZM1h7QulKnjPbi8AjCBqWl6B4OoAmGnRHk4s4R94WRCE9unPEyOjjOnQ5BHp
         22VvoiGeObY3CrsAFcV6IoRGfGvKGtMzVLriacpcUT7qXjSegF0zkk3B4matrJrTaQFk
         cBpO7G5L8M2y7xwAhEkL1VHtuuXKHGtzJC/vxAmLlOR/ElFWu/szUIpOckyfXzOt1hkG
         z7VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=VV7wVdKLlDnZ02Itv0CwuRjjf35FudCY6fpcnm3FEJc=;
        b=oLGLFoj6Lyd6glSc537AzUNS4RlrEqBCCfLBopDOQpFyG6MyX2cwbPKL3LPHZEeIHL
         H24UPhY5PhflXQMo9pSbEgrpprAYUgdY89uNW7UT3YlqiDT474EGK+P2IVOGMYHv+jlb
         AtWPI9MZMPvtmJJhxZEShcv5B++8wAcuMk6Dz4e2oFcJl7cdE2+L11rhcckvVGujFwke
         Rtw/Mh9L/Uxjm1IuuoWwk0Eawu4i1sIGXEX5ByiE+8O0IT76Ab1yr5Y7Pcn3A6FwzivA
         vH+OoTZYAa2OwQ04MU2jms8YFWgVseZopGDRJRnrkSzCcdafnbEBnqu5orM/J7f+d351
         99FA==
X-Gm-Message-State: ACrzQf1E6DbaIisJwVXGdZhuXs/DLy8Q5hqPqbCV9yivlTlrT7BEjshs
        xaRXXE78xfyWaHjYREsM5WvD1S0fNpNCIA==
X-Google-Smtp-Source: AMsMyM7u//RWpQZT2OzxbdZpQrOd765zKpLILkz5UMJDS2yeBzeWjiPTUvsu90bA+kA59rSyCCnJzQ==
X-Received: by 2002:a05:620a:4388:b0:6ce:4068:754 with SMTP id a8-20020a05620a438800b006ce40680754mr14489949qkp.369.1663644003637;
        Mon, 19 Sep 2022 20:20:03 -0700 (PDT)
Received: from xzhouw.hosts.qa.psi.rdu2.redhat.com ([66.187.232.127])
        by smtp.gmail.com with ESMTPSA id m22-20020a05620a24d600b006b942f4ffe3sm225149qkn.18.2022.09.19.20.20.03
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 20:20:03 -0700 (PDT)
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v2 2/2] common/quota: fix grep pattern
Date:   Tue, 20 Sep 2022 11:19:51 +0800
Message-Id: <20220920031951.2098839-2-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220920031951.2098839-1-jencce.kernel@gmail.com>
References: <20220920031951.2098839-1-jencce.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The second dash is not needed now. Newer grep is complaining:
+grep: warning: stray \ before -

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
v1-->v2:
	Using -- option.

 common/quota | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/quota b/common/quota
index 22be3c69..24251d09 100644
--- a/common/quota
+++ b/common/quota
@@ -218,7 +218,7 @@ _qmount()
         quotacheck -ug $SCRATCH_MNT >>$seqres.full 2>&1
         quotaon -ug $SCRATCH_MNT >>$seqres.full 2>&1
         # try to turn on project quota if it's supported
-        if quotaon --help 2>&1 | grep -q '\-\-project'; then
+        if quotaon --help 2>&1 | grep -q -- '--project'; then
             quotaon --project $SCRATCH_MNT >>$seqres.full 2>&1
         fi
     fi
-- 
2.31.1

