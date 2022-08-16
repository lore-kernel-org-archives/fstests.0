Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51F9C2BB41
	for <linux-fstests@archiver.kernel.org>; Tue, 16 Aug 2022 09:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229930AbiHPJzm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 16 Aug 2022 05:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234195AbiHPJyO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 16 Aug 2022 05:54:14 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D48D3A4B2
        for <fstests@vger.kernel.org>; Tue, 16 Aug 2022 02:25:46 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id 202so8742778pgc.8
        for <fstests@vger.kernel.org>; Tue, 16 Aug 2022 02:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fydeos.io; s=fydeos;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=6zlstte6oL6Xkd4b+ayvuWp40bPvPk7lHS372DHRY0I=;
        b=MgNxxjrcomfdBiCYspQ0RGk/AiwZW7h7k/lkMX1+VcLC/XWKPqPiwwFHVADolTn4iI
         wJIIq0kdC99rQ4hleDQeGarHbJ1AuMEOdK17BB46Rr0vvGTKVJCUEOp8pq/uaivg552a
         Tob4sd2Qat7et2Bly+AwLjVe7dMxzpvTCu6l+DGgb2XVcafDOLGJrcaappeWFZI4AQtF
         38QGhN9eWcNKgvDnKQuxIG8nHu83tmsa53LpDV3luRvFitbuolC7UJCFteYEe4oySwMj
         7gfMjFMhurtDY+sZDxINePc9A5Y5YzERB0m+0DXRfzxzHK4jXzeUei/Lqbmuv89Tqe/q
         6vAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=6zlstte6oL6Xkd4b+ayvuWp40bPvPk7lHS372DHRY0I=;
        b=Go+1jJdPQ2l1PpolSP1+k4gFYswhBe4WOtP2BGAF7g1q+LWOd2+pbPtpgjOvGhfqa1
         xibIW0QOitNYEdEgESR/KJxZx2KRyrQICETNRf1mp1kKpduECu1if44BrsTSxVLYlENM
         kkL8mvvDpCvlrYuCE+sd7uHuu+3W32qbVCZ/VsYiaHsjg+Oljb8M8/9cco8ggoAskHZI
         x37ie9iwMwGC2y1YBCsXTlvrMxJvYOR6zMSJ81KnE2Q8rDCUjk/T0DtTu/podk/PPVKL
         bP3e2rF3kTTKcUAnViU6Yg+NP8fnVD0CkP3IOYl+/9X52ICUxRzy2np5iwUmrYtH7vln
         BCMQ==
X-Gm-Message-State: ACgBeo0L4LKrv6HW50IgJn9KgUUSxJiorWyodwPCaCuU6wp5wxxxidB3
        ++Ayi4EKVHDAcGZh7FkSQeK8rw==
X-Google-Smtp-Source: AA6agR4WLr2XjWTUVVhoOmao75KXr3CHxE/aXfDTSjjO1wPkHlfUw1tyymeHBywDk185OWCzT25FNA==
X-Received: by 2002:a63:5a61:0:b0:41b:b021:f916 with SMTP id k33-20020a635a61000000b0041bb021f916mr16683240pgm.387.1660641945954;
        Tue, 16 Aug 2022 02:25:45 -0700 (PDT)
Received: from damenlys-MBP.lan ([103.117.102.23])
        by smtp.gmail.com with ESMTPSA id n68-20020a634047000000b0041b29fd0626sm7210395pga.88.2022.08.16.02.25.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 16 Aug 2022 02:25:45 -0700 (PDT)
From:   Su Yue <glass@fydeos.io>
To:     linux-fsdevel@vger.kernel.org
Cc:     fstests@vger.kernel.org, l@damenly.su, Su Yue <glass@fydeos.io>,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@digitalocean.com>
Subject: [PATCH] attr: validate kuid first in chown_common
Date:   Tue, 16 Aug 2022 17:25:38 +0800
Message-Id: <20220816092538.84252-1-glass@fydeos.io>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Since the commit b27c82e12965 ("attr: port attribute changes to new
types"), chown_common stores vfs{g,u}id which converted from kuid into
iattr::vfs{g,u}id without check of the corresponding fs mapping ids.

When fchownat(2) is called with unmapped {g,u}id, now chown_common
fails later by vfsuid_has_fsmapping in notify_change. Then it returns
EOVERFLOW instead of EINVAL to the caller.

Fix it by validating k{u,g}id whether has valid fs mapping ids in
chown_common so it can return EINVAL early and make fchownat(2)
behave consistently.

This commit fixes fstests/generic/656.

Cc: Christian Brauner (Microsoft) <brauner@kernel.org>
Cc: Seth Forshee <sforshee@digitalocean.com>
Fixes: b27c82e12965 ("attr: port attribute changes to new types")
Signed-off-by: Su Yue <glass@fydeos.io>
---
 fs/open.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/open.c b/fs/open.c
index 8a813fa5ca56..967c7aac5aba 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -715,6 +715,13 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
 	mnt_userns = mnt_user_ns(path->mnt);
 	fs_userns = i_user_ns(inode);
 
+	if ((user != (uid_t)-1) &&
+	     !vfsuid_has_fsmapping(mnt_userns, fs_userns, VFSUIDT_INIT(uid)))
+		return -EINVAL;
+	if ((group != (gid_t)-1) &&
+	    !vfsgid_has_fsmapping(mnt_userns, fs_userns, VFSGIDT_INIT(gid)))
+		return -EINVAL;
+
 retry_deleg:
 	newattrs.ia_valid =  ATTR_CTIME;
 	if ((user != (uid_t)-1) && !setattr_vfsuid(&newattrs, uid))
-- 
2.37.1

