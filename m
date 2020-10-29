Return-Path: <SRS0=FwvB=EE=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70563C55178
	for <linux-fstests@archiver.kernel.org>; Thu, 29 Oct 2020 07:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A1EC21D24
	for <linux-fstests@archiver.kernel.org>; Thu, 29 Oct 2020 07:38:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i3QQII73"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgJ2HiO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 29 Oct 2020 03:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbgJ2HYy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 29 Oct 2020 03:24:54 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8C2C0613AA
        for <fstests@vger.kernel.org>; Wed, 28 Oct 2020 21:41:33 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id c20so1308938pfr.8
        for <fstests@vger.kernel.org>; Wed, 28 Oct 2020 21:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=XKHCS3l0ebiE0VNk0QTJSgX8/jgCvzZHl1FZlDd/ub0=;
        b=i3QQII73MWS5HLYBtve3qmDS4LnTo/W4Vh7oAWVuwphTYpo6MyBSh4tyI/nVCKDhlQ
         SAI9NFY82EJEQP/sodTKkmrhN/MC6BcWA+0xPljsAu9e1ocfGNghyI7phj13FVG3ggOD
         A9pZRgbhmHyJUOSvJY3y157TjmQoKUNQawwvpybAQp1pbHGAgq/KyBKEw1D/sdCHyvvN
         nUCKOCUlp/oqPmQo3A9RtHg4lBDgknfNjR97pU0nDNQ5gmUko6qlG1wy2ZTNtOoNATMC
         ftOiF9RsNir1TXhoWtsSfwqO0DCNzKCxaahJHCGuiJmQSoFz63SkszTtHrCkylEszg10
         zj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=XKHCS3l0ebiE0VNk0QTJSgX8/jgCvzZHl1FZlDd/ub0=;
        b=ctAh5/oJlsf04BlVnMdOmSxbwj73KJAVXm0TXAsFs3ru5iqVipZx19cbZAHPd7+f6Q
         Y21NL5LbX8JD1zQhT42vN8rtuf04jgiv4bReD7w/wHyOIx5RBmtZk683CY6W94wQu5jo
         6woTUVrPhxLDB8PJO7vP9Rzg30JISqefxOsvc95rEi35K1qYHoqTOAHfQj2FjhgF4ziF
         zetjP/m0IqNynqWd4wz90iGl0MSFuGzmWflo5Wu055J49XgQaTSX+T6PjTyyIU32Km9n
         XnxWL3iA10X/wZ2Es/rUbwr69+7CAs8Nd4CkDPXK1doZbj3R0LhSwSsyZIbRHhm3WiwC
         meoQ==
X-Gm-Message-State: AOAM532zcsBEQ+iqBPwjaAs++3nehg2wwJJiw34iNOHdSTc81teCifsJ
        AUKhAc3ZvJr5hBW4LZX7qygnMQ==
X-Google-Smtp-Source: ABdhPJyg/Ibb5D7x+XvFvWBQ0NcXtNMqX/79ur3Gk88/5nq/95d+Z0tZpbVcAzynzXEIWN/7wednSg==
X-Received: by 2002:a63:313:: with SMTP id 19mr2402171pgd.18.1603946492800;
        Wed, 28 Oct 2020 21:41:32 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id z16sm1229492pfq.33.2020.10.28.21.41.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 21:41:32 -0700 (PDT)
Subject: [PATCH] open_by_handle: Don't use MAX_HANDLE_SZ
Date:   Wed, 28 Oct 2020 21:03:39 -0700
Message-Id: <20201029040338.238990-1-palmerdabbelt@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>
From:   Palmer Dabbelt <palmerdabbelt@google.com>
To:     fstests@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When I compile this normally I end up with the definition of
MAX_HANDLE_SZ, but when I compile it in a minimal buildroot-based
environment I don't.  I'm not sure where this is supposed to come from,
but as of 3f4760c2 ("open_by_handle: add option -z to query file handle
size") it appears to be unnecessary.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
I haven't actually run this, as I haven't figured out how to yet.  It
does build, though.
---
 src/open_by_handle.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/open_by_handle.c b/src/open_by_handle.c
index 0f74ed08..ddeffb7a 100644
--- a/src/open_by_handle.c
+++ b/src/open_by_handle.c
@@ -92,7 +92,6 @@ Examples:
 
 struct handle {
 	struct file_handle fh;
-	unsigned char fid[MAX_HANDLE_SZ];
 } handle[MAXFILES], dir_handle;
 
 void usage(void)
-- 
2.29.1.341.ge80a0c044ae-goog

