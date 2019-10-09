Return-Path: <SRS0=es+p=YC=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7741C47404
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Oct 2019 05:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D16C21835
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Oct 2019 05:35:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="autUznIk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730557AbfJIFff (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Oct 2019 01:35:35 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:36789 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730451AbfJIFfe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Oct 2019 01:35:34 -0400
Received: by mail-pg1-f175.google.com with SMTP id 23so672299pgk.3
        for <fstests@vger.kernel.org>; Tue, 08 Oct 2019 22:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=481Ci0kx/vFxIsZ1Yi67RVoTaC52PrgSXnO15ggmUXs=;
        b=autUznIkkMsToM2sQ+8QKDZoLsEwWMXJPhcFfYdockc1NW07kaFAuKh5i5R4ZmGby2
         ikEULuOYRQ732lARGG5lWhkpI3GwVn2ZURXRooALBOtH+D0t2z3SzDvhLZFdyuHS0PSY
         OHmdsS4vpVJAr/AaN3Xh7g+Uyh8pV4mcKer//zF3VD+Y5R3M4JV508SGaisRoou/VoR2
         Qap3lJxwacWsRXMWwutFcSocrQ3XpXf/ds3pR7u4USBmMF7bPDK13VXVMlKEs+wk9/LH
         T7sjpaVXnqiawWdAdu35MLi6oQY90PAY2wQdrDVovR164vPaYR2yADNZxRdlvdeHmmmc
         eJkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=481Ci0kx/vFxIsZ1Yi67RVoTaC52PrgSXnO15ggmUXs=;
        b=OxHmg/OpOcVtwX6n4SIEixoeyiRwJXGyovY++BRmKSCGMUTXhrDaNecbFBFv6OotFH
         0O90Z3mNIoOjbAIxmhHbXjAXAkyrBzySluOyJuQ/WNz4SXSJBNQtTLOpNoOSHT/U2FQv
         XP4gYCn8vbGfAFz+R54CzNUKSvxWaNUNHXHom5OKk4FratnC9MUPBPs/ZVgko3S8hpV4
         2IFc+G0Qm+h5BTjjAjfQzexw5NqVUD50Lq+0jrajMusyd8cDyIPDt/QF2M9WTGLNkJJK
         KiED3HXTwGYVNVKqzXRQpD2+wWMhLKPWNCCK0Ys8kNrGJnfPGx5L5Q3OhuGcmx2qva1u
         jBTQ==
X-Gm-Message-State: APjAAAUdRD4i5Zz4VJXluReKjNGRLehXreKf1bWN+CWXfAOyqlJPiWD0
        sHXntLs5pc7omdKBuk1s+8+Pxqtz/2U=
X-Google-Smtp-Source: APXvYqxgBMWTw5dnppsnMGy0oUqRgjHUhioScSbPOYnBlqs0S7MRW1Wss8IWOdypO3EIHhu2t836Qw==
X-Received: by 2002:a17:90a:f001:: with SMTP id bt1mr2028387pjb.2.1570599334001;
        Tue, 08 Oct 2019 22:35:34 -0700 (PDT)
Received: from xzhoux.usersys.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s14sm892249pfe.52.2019.10.08.22.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2019 22:35:33 -0700 (PDT)
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     fstests@vger.kernel.org
Cc:     Murphy Zhou <jencce.kernel@gmail.com>
Subject: [PATCH] generic/001: remove unnecessary backslash
Date:   Wed,  9 Oct 2019 13:34:34 +0800
Message-Id: <20191009053434.19369-1-jencce.kernel@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Awk 5.0.1 is complaining about this backslash and causing false alarm
like this:
    warning: regexp escape sequence '\#' is not a known regexp operator

This fix works fine with Awk 3.1.7 , 4.0.2 , 4.2.1 and 5.0.1. This
backslash is not necessary.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 tests/generic/001 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/001 b/tests/generic/001
index 046e54e3..3a047754 100755
--- a/tests/generic/001
+++ b/tests/generic/001
@@ -177,7 +177,7 @@ _chain()
 {
     $AWK_PROG -v full_file=$seqres.full -v verify=$verify <$tmp.config '
 BEGIN	{ nfile = 0 }
-/^\#/	{ next }
+/^#/	{ next }
 	{ file[nfile] = $1
 	  size[nfile] = $2
 	  link[nfile] = 0
-- 
2.20.1

