Return-Path: <SRS0=dxnf=2L=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67DA3C2D0D3
	for <linux-fstests@archiver.kernel.org>; Sat, 21 Dec 2019 18:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D78206D8
	for <linux-fstests@archiver.kernel.org>; Sat, 21 Dec 2019 18:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sBqi/2Xf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbfLUSwA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 21 Dec 2019 13:52:00 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:35497 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfLUSv7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 21 Dec 2019 13:51:59 -0500
Received: by mail-wr1-f50.google.com with SMTP id g17so12555363wro.2;
        Sat, 21 Dec 2019 10:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5BRhvobtNdmKk3i7GYogWznJM8/6rPQQF6haJk7WNLI=;
        b=sBqi/2XfoiHBVyY6OTVJxsq9+FaiFoR31Hs7vO85HhOTLTplR7NETQzPwCpfTuh1A8
         NW8HUt98jFhGDDL92NCRUktljQUEKHRmhAFIJgmj/gMqjoYe5A0NfCENzcdkGAuzXSaF
         uJLG6COemtF+IX0IW1oklwHmHs/bgy1pINh2owgjyVcu1e29ho35aEn9H4HGFg6ZOCxo
         ATW8ldqhrcVZW4QumHaZ0/0H2Gli02si23TY6SkOE2y2+iUNmCTOMmvVR7YqGKlNs/wA
         oE1L1JvQi80fPhlwYarq7d+mGCNaftDgVtrv/w6tA9d4OnLusZy25suBgw+ySe1CVr/J
         V0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5BRhvobtNdmKk3i7GYogWznJM8/6rPQQF6haJk7WNLI=;
        b=CWr8VRsVhPubIPcvgHxNBwnevUvMgrW80Hx6JBCfluNXD4ETAM77Ye/K6sAzBO0T8l
         QL61iihvjPRBRLH8oKQLoVMxHexQpaW2I+Vpsk5OGLTIX+yLZYkRQOlrHBzwIZM/8Vk6
         f5QGxuWIjfK7qfEW+nlWE4kBfoUXF3lMdLeBBKYkCrAHFrE1a4ouJekNmL4RTxz3XYmY
         jPDWu+gOzcyA4BzmAzdzCmmDaRidStj5WWuHJrclzeimHp5G77ufYPlHRidMyKZbwclv
         VLtR+tK3G9p9sol1hm0sc4GTjDvm08G9OuTwVRRkyH8+xnPyRoIjRDZw4Iu40tS3HOP3
         etgA==
X-Gm-Message-State: APjAAAWNnNb1LIaJ/6HJ/2RO5eRl3B7Z+CLUHx0k50dhyB0r5vbn/NqG
        42Fa7/o6qesLhtadDs4raMM=
X-Google-Smtp-Source: APXvYqwit37sQ5eCTWi58huyDmVZN8iZaFcodNXwADrFPVShHgKC+ofwYYn8nIY1huSP5Zm+/R0XOw==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr21638887wro.310.1576954317867;
        Sat, 21 Dec 2019 10:51:57 -0800 (PST)
Received: from localhost.localdomain ([141.226.162.223])
        by smtp.gmail.com with ESMTPSA id o4sm13729832wrx.25.2019.12.21.10.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Dec 2019 10:51:57 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
        fstests@vger.kernel.org
Subject: [PATCH 1/3] overlay: create the overlay/nested test group
Date:   Sat, 21 Dec 2019 20:51:47 +0200
Message-Id: <20191221185149.17509-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191221185149.17509-1-amir73il@gmail.com>
References: <20191221185149.17509-1-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

For tests that mount an overlayfs over overlayfs.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 tests/overlay/group | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/overlay/group b/tests/overlay/group
index b7cd7774..e809f7f2 100644
--- a/tests/overlay/group
+++ b/tests/overlay/group
@@ -24,14 +24,14 @@
 019 auto stress
 020 auto quick copyup perms
 021 auto quick copyup
-022 auto quick mount
+022 auto quick mount nested
 023 auto quick attr
 024 auto quick mount
 025 auto quick attr
 026 auto attr quick
 027 auto quick perms
 028 auto copyup quick
-029 auto quick
+029 auto quick nested
 030 auto quick perms
 031 auto quick whiteout
 032 auto quick copyup hardlink
-- 
2.17.1

