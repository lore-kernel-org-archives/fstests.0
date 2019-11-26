Return-Path: <SRS0=JLeR=ZS=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65358C432C0
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Nov 2019 05:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3052D20637
	for <linux-fstests@archiver.kernel.org>; Tue, 26 Nov 2019 05:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxkPFqgN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbfKZFXq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 26 Nov 2019 00:23:46 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39706 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfKZFXq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 26 Nov 2019 00:23:46 -0500
Received: by mail-pj1-f67.google.com with SMTP id v93so4439357pjb.6
        for <fstests@vger.kernel.org>; Mon, 25 Nov 2019 21:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=P1OgTgw0b1XsDHjP8RicW+OXJNvDDICc0wExNfSd6ek=;
        b=GxkPFqgN2nAgdphBZaduSkMwSSbeMz0WbIDJIUgAAt/NiePTG++dzoShCHmtjsJ1UR
         bApSR6dx+kisQvI1x/UdRHD8ioUyO1ZJm69B9oWamrD4cjDruSHLA2fZKJR5cbch+iUA
         TwywJ86vI8ZmerZc2Aupd8pdLGldVxvAOFGUBIyfbvsh9rLvZQZmhOrELwHp5pOEinoT
         E9sZt/OctyzfdotXOozffuPbyjDTz9iDUQvAkBXEpXo7TR6idIt8OPTOzRrhB9AO/Hsl
         4p3Q/GBi30fpgw8RogXcbYAJUfW7lswjtepsENrt0Sz6HILTgd50RnlnjTGeyZg+m/6V
         YTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=P1OgTgw0b1XsDHjP8RicW+OXJNvDDICc0wExNfSd6ek=;
        b=g9/XVV8+p7lsU3FdZq2/4wpMJdPmTbGSqUkANNuPPKc3PqwpWJTNsPaliPFgb2x7WN
         1uuin+oZeVNdH/MxX3lXF9ZdfseOKWHb/nRjtngM42elu8fnplr+EkRHktPgmscg6k3J
         rZyRB/5xZzT2AoFDcQNRtHK81r4U5pCJh7wdINvnLcMwfSd6eYGm0cOo+xSRaYLvOfe+
         DuSrfuzaV/o2OmzcCmPL8t2y6/VQZkY/4/lRP7jXbJwUFxXONo9U9OCpUi9ZSRAzq80B
         IxCxzR442CS0GXyxYoJ0rAprBSOk1dlBqhhtdJ6VBBA9foIpwJIzMQpFVWnYWSKomSWK
         ew5A==
X-Gm-Message-State: APjAAAXrTR0XZCNkL+N17ou8qdK33iSVKtJhXO+jcfzKl/8x+pliY+Y5
        ehEm6+MpQftcujy+r4MieU0PuIjB
X-Google-Smtp-Source: APXvYqxIDLoUNzaM8yX4ot7TcnHvgZBQ8rXAZDsPnuRYV3/SWm8i5t+HoEhlCrWu5w3bHvUS2gD0Fg==
X-Received: by 2002:a17:90a:fb53:: with SMTP id iq19mr4102498pjb.138.1574745825554;
        Mon, 25 Nov 2019 21:23:45 -0800 (PST)
Received: from lbh-vm.xmfducmkfhgejfckffvf135llh.hx.internal.cloudapp.net ([52.175.53.118])
        by smtp.gmail.com with ESMTPSA id q26sm10254192pff.143.2019.11.25.21.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Nov 2019 21:23:44 -0800 (PST)
From:   Baihua Lu <lubaihua0331@gmail.com>
To:     fstests@vger.kernel.org, guaneryu@gmail.com
Cc:     balu@microsoft.com, Lili.Deng@microsoft.com,
        Baihua Lu <lubaihua0331@gmail.com>
Subject: [PATCH] xfs/191-input-validation:Fix issue that the test takes too long
Date:   Tue, 26 Nov 2019 05:23:36 +0000
Message-Id: <20191126052336.98489-1-lubaihua0331@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

In this test, we don't need to check filesystem on the scratch device for there is not
really creating the file system. If _check_filesystems executes, xfs_logprint will be
failed for having dirty log and xfs_repaire will take a long time.

Signed-off-by: Baihua Lu <lubaihua0331@gmail.com>
---
 tests/xfs/191-input-validation | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/191-input-validation b/tests/xfs/191-input-validation
index b6658015..db427349 100755
--- a/tests/xfs/191-input-validation
+++ b/tests/xfs/191-input-validation
@@ -31,7 +31,7 @@ _cleanup()
 # Modify as appropriate.
 _supported_fs xfs
 _supported_os Linux
-_require_scratch
+_require_scratch_nocheck
 _require_xfs_mkfs_validation
 
 
-- 
2.17.1

