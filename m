Return-Path: <SRS0=nTdV=YV=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE07CA9EA0
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Oct 2019 07:57:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206FC214AF
	for <linux-fstests@archiver.kernel.org>; Mon, 28 Oct 2019 07:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h8XLgBMy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733092AbfJ1H5F (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 28 Oct 2019 03:57:05 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:35770 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733079AbfJ1H5F (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 Oct 2019 03:57:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id c8so6373938pgb.2
        for <fstests@vger.kernel.org>; Mon, 28 Oct 2019 00:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0ehtYjbKLltf1SSdu0NlbUGNnZhpmyIN0HAjpAFFInE=;
        b=h8XLgBMy5shLwq+oaEyFiGohLaUHLRzt6ShBPl+y3EFqrNDq/WWx9jf5ApVQfvdVNq
         VClVZ89bYSAsHg6f9xWBXNrOlFndRS2AKYwpgaB5tVw+F8D8OZEPlA34CmlG8JdJVtpR
         onxHqWx83HQsg97eGBuQbbXifF1dJXgstHN3DqEOYaLLSNQTZf1OoYHrgLurTwZ9Wvik
         KHimB/hyQjmR2e8nGcksFx0OQdatuux/Ft+Rv5KLzp43S/SK5E9bYUt5tdmkE4MyQe4Y
         65gSvoV8hKLfeM0hKfuQI/ZWwRNMbnzQFli/3F5nesZod5J+lNwX0KBwVjg6Uu3J5RgD
         5hcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0ehtYjbKLltf1SSdu0NlbUGNnZhpmyIN0HAjpAFFInE=;
        b=Q+FNiL2bryalH8nDmcOP7LlEPI9zel/lx1GecN/Lf4HM19UsYYp8S66jbVOUpNEFEN
         4o8cplYlESVZsrCAh1YMK5ZtWToYmBbRzfHpn3fLxw8E9M6IX58s0lfPYp7ard2qB2Uo
         NuyodayT1mpmW1MrzXlBgCc7G7PVdptU9bvv05cIVfiHO5D6li91MVpUuaOjajB5/GdB
         LH+LBrSkOUtJIR+OdKPxzMhpCGk/CkcGpaBuaaOoNuSEQtE60uQChbh30rBN1vfNJVr0
         cVENtZqTxNZ7bXHLuYVvp88qyD62KIrJOoJXN03O1O5xCD+eIQBvV6B0QmduGrWLywYb
         PTTw==
X-Gm-Message-State: APjAAAUUnA/KyMnonzR+i1ytXBcoPBVZVCI2+jmgfcPvq1JE2ldpD1fQ
        b+E5Ri0n7gl5wy1U4OzyNh4RgnFYCiw8MwoS
X-Google-Smtp-Source: APXvYqxLDH9WtRaKF74Wc3pUv4rOV/RzmmefztZ1hJYiNpZzNx1NCmeu69H/c9PM6vMR9khUlH84dg==
X-Received: by 2002:a62:e103:: with SMTP id q3mr12074251pfh.239.1572249424499;
        Mon, 28 Oct 2019 00:57:04 -0700 (PDT)
Received: from lbh-vm.xmfducmkfhgejfckffvf135llh.hx.internal.cloudapp.net ([52.175.53.118])
        by smtp.gmail.com with ESMTPSA id s5sm8613110pjn.24.2019.10.28.00.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2019 00:57:04 -0700 (PDT)
From:   Baihua Lu <lubaihua0331@gmail.com>
To:     fstests@vger.kernel.org
Cc:     balu@microsoft.com, decui@microsoft.com, Lili.Deng@microsoft.com,
        weh@microsoft.com, Baihua Lu <lubaihua0331@gmail.com>
Subject: [PATCH] common/rc: fix _require_xfs_io_command utimes check
Date:   Mon, 28 Oct 2019 07:56:59 +0000
Message-Id: <20191028075659.38940-1-lubaihua0331@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

There is an error on checking utimes command. Put quotation mark after four "0".

Signed-off-by: Baihua Lu <lubaihua0331@gmail.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index a29bd780..aeac903b 100644
--- a/common/rc
+++ b/common/rc
@@ -2184,7 +2184,7 @@ _require_xfs_io_command()
 			_notrun "xfs_io $command support is missing"
 		;;
 	"utimes" )
-		testio=`$XFS_IO_PROG -f -c "utimes" 0 0 0 0 $testfile 2>&1`
+		testio=`$XFS_IO_PROG -f -c "utimes 0 0 0 0" $testfile 2>&1`
 		;;
 	"syncfs")
 		touch $testfile
-- 
2.17.1

