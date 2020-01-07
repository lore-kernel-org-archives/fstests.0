Return-Path: <SRS0=VTFL=24=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CF3C33C9B
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 16:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBB232080A
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Jan 2020 16:55:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="m0omdZf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728806AbgAGQz5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Jan 2020 11:55:57 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44888 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbgAGQz4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Jan 2020 11:55:56 -0500
Received: by mail-qt1-f193.google.com with SMTP id t3so296002qtr.11
        for <fstests@vger.kernel.org>; Tue, 07 Jan 2020 08:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=qlZCxBvnUUAjdtWIZdVAdDAL1tqiSSvBhzh47uiwmCc=;
        b=m0omdZf2gZOoaH2jWMdI6yGukE2XEaHzuAl5bDlNFAPUOxG6/kx8clfcuh+UTVSSEC
         7TPfkZ66xh+SCvZM37m0dvlzW4qBf6nzKBSKByH2fokdA9SjnR50uQbfhxfD72Kr40Px
         UKhIjbINpeHuD5qCaaRtAGdrX9edsh63L1Np2FUe2q1QzcLmPHP2bBjiNo2BrPGNK5sx
         izEMlSGmDVnQcqSpD5rX+LGeNcrLFxEXHt7+DpfN+pBJc+A8ZzvvK1SWs/zYD3gbLh4p
         o4hXBNCSp0O2TV0sREZhHdy5jTwwCEeRG9CNvn4JngJsT2zrq47on4kRTnc/QIL+nA4Z
         DSag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qlZCxBvnUUAjdtWIZdVAdDAL1tqiSSvBhzh47uiwmCc=;
        b=NWOqcX5snsc/Hm1YCrjA7trPSJdxpc5Fg8xkXD+aKFvbGkd3fJ0X4xOTfX5uZmQl5c
         WfOJhK/gx1fvDxXl5oLaspO8iQmLhtR05P5DiGAJBrxxGNxJdHuRRrQyS2P3xUZ0ZSNF
         nGWVRIiemeZ/31ouF5XOdLo3L7FrhhXaLhOiCQgisiL7TecZbgZMujOEgB5C4Nt5N5jP
         1ARk+OK21bdb2jYC6j/IYpePx0kI5LiUmso7AbIcJRYN+syHwrUgDxhE2Gp0jT6dvISk
         q9bEKYkWafndih3xZxxv1+qfC8410hnQXhdq4Vs86Uzzwkm2TtZlu+BbJ3yp/6ma4lLg
         XQyA==
X-Gm-Message-State: APjAAAW3dIX2qSccJKSo2V0yikzJjr+GVpf5K2qhZEaqueDhcugLKn5n
        cprZN29DbIUa1BIxD7U2UGO4PyRMwUnong==
X-Google-Smtp-Source: APXvYqylD6CKxQf79S5PaxMlP5DWYoWsX1dOmP5XuaMtzb6C7t/xqNqVxGhLhcAtWWU24adtses28g==
X-Received: by 2002:ac8:7155:: with SMTP id h21mr75689670qtp.95.1578416154907;
        Tue, 07 Jan 2020 08:55:54 -0800 (PST)
Received: from localhost ([107.15.81.208])
        by smtp.gmail.com with ESMTPSA id g81sm65834qkb.70.2020.01.07.08.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 08:55:54 -0800 (PST)
From:   Josef Bacik <josef@toxicpanda.com>
To:     fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: [PATCH 2/3] ltp/fsx: drop caches if we're doing closeopen
Date:   Tue,  7 Jan 2020 11:55:41 -0500
Message-Id: <20200107165542.70108-3-josef@toxicpanda.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200107165542.70108-1-josef@toxicpanda.com>
References: <20200107165542.70108-1-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

fsx has a closeopen option where it will close and then re-open the
file.  This is handy, but what is really more useful is to drop the file
from cache completely, so add a drop_caches into this operation so that
the file is read back completely from disk to be really evil.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 ltp/fsx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ltp/fsx.c b/ltp/fsx.c
index c74b13c2..e519367b 100644
--- a/ltp/fsx.c
+++ b/ltp/fsx.c
@@ -1778,6 +1778,10 @@ docloseopen(void)
 		prterr("docloseopen: close");
 		report_failure(180);
 	}
+	if (system("echo 3 > /proc/sys/vm/drop_caches")) {
+		prterr("docloseopen: drop_caches");
+		report_failure(213);
+	}
 	fd = open(fname, O_RDWR|o_direct, 0);
 	if (fd < 0) {
 		prterr("docloseopen: open");
-- 
2.23.0

