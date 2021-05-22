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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19F8C2B9F2
	for <linux-fstests@archiver.kernel.org>; Sat, 22 May 2021 18:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9061A61175
	for <linux-fstests@archiver.kernel.org>; Sat, 22 May 2021 18:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhEVSts (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 22 May 2021 14:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhEVStr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 22 May 2021 14:49:47 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785C2C061574
        for <fstests@vger.kernel.org>; Sat, 22 May 2021 11:48:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id o5so18181119edc.5
        for <fstests@vger.kernel.org>; Sat, 22 May 2021 11:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D0fHEPiPauoBg4PEnxoJ6F6h18h2mlv7kP5p+hFKw+s=;
        b=QSx4wldI/IEXRtO4DwTuMZdTF81pQ28akuvaiHlganTvbeAqcZsUUim9vpB2PVAWgT
         tQcNCnp9iVgwc+IcwiXmzVwjxK+eGF9gW43T1o4pD+JvuBUKWm5AVKiuNauuMYBaDm1Z
         rGvweRRBOwmdEyVqdPpTcPYftLX3OOdUYwqJWkk1fIBVv3eRkQhR32zW5yg+LdhaqPGI
         MJfNVqIx/2z0G+zQeOMvrVXz/hK6G2e1unjWKzJyISfc+BQlkVPFH2e5PapmmxNofmYC
         oeYPxHWnuKZjDbWP/2I8d1oQKvDf/KKYbdWMisQ20+cD1ZpdWKTUZZljXuTiCHB+74kS
         YMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=D0fHEPiPauoBg4PEnxoJ6F6h18h2mlv7kP5p+hFKw+s=;
        b=ppl7+fubaG4evSR75+E0u2NybS2zDfjaSRaqx+zRm5+whsbk1xg+MoMz15thxIeee3
         NZEmyVZx0Q6qQDoQP3m9VeR3PtgW+xBJY2ggRNLYLHUE8Qem9a+kk/Rp8smv4XgwdG1n
         xq198eZSa82TYbzt0xwL1RVVtiiXxCeerRfWcnP7WUSryrmQLgWrBovvzzyTbBi+gqW+
         8iRD9MRatdCcIBY2zQnFvtM1tJNwPdYo7ggxSlDegu0G3EAxHFlyjZgSS6MpUZIb5pfD
         8VH1qgTullprCKhOIfs6X0aPqce2cFEu6NYHQT5p3HVn2D7jYbs98Ca2KMTfSeEUL5mw
         UQqg==
X-Gm-Message-State: AOAM5316nCiKun2GRaEk+L5stTx+tBMmP74cGT5cugH34dad0/9vhg6B
        E7XIYNpJJRjvSh2xZ55D2Mv7vUTq/e0=
X-Google-Smtp-Source: ABdhPJz7S1H0kEyMH9y0qeiFq7xpLI//HZ1EFwe66ge1EjGtcdIfDPOKAGS8HQFEjRunJ4CI+On5Uw==
X-Received: by 2002:a05:6402:2215:: with SMTP id cq21mr17499428edb.28.1621709299809;
        Sat, 22 May 2021 11:48:19 -0700 (PDT)
Received: from brikett.. (2a02-8388-1681-ac80-9121-6c4a-d0f1-170b.cable.dynamic.v6.surfer.at. [2a02:8388:1681:ac80:9121:6c4a:d0f1:170b])
        by smtp.gmail.com with ESMTPSA id m13sm6805214eds.21.2021.05.22.11.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 May 2021 11:48:19 -0700 (PDT)
From:   Jakob Unterwurzacher <jakobunt@gmail.com>
To:     fstests@vger.kernel.org
Cc:     Jakob Unterwurzacher <jakobunt@gmail.com>
Subject: [PATCH] generic/286: fix integer underflow on block sizes != 4096
Date:   Sat, 22 May 2021 20:48:14 +0200
Message-Id: <20210522184814.95802-1-jakobunt@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The read loop always requested 4096 bytes, which only works
when the total read length is a multiple of 4096 bytes.

This is not neccessarily true, and when it's not, len wraps
around to UINT64_MAX and you get a lot of these:

	ERROR: [error:38] reached EOF:Success

This was caught when running xfstests against gocryptfs,
an encrypted overlay file system.

On ext4, the test still passes after this change.

Signed-off-by: Jakob Unterwurzacher <jakobunt@gmail.com>
---
 src/seek_copy_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/seek_copy_test.c b/src/seek_copy_test.c
index 0c2c6a3d..28c021e2 100644
--- a/src/seek_copy_test.c
+++ b/src/seek_copy_test.c
@@ -98,7 +98,7 @@ do_extent_copy(int src_fd, int dest_fd, off_t data_off, off_t hole_off)
 	}
 
 	while (len > 0) {
-		ssize_t nr_read = read(src_fd, buf, BUF_SIZE);
+		ssize_t nr_read = read(src_fd, buf, MIN(len, BUF_SIZE));
 		if (nr_read < 0) {
 			if (errno == EINTR)
 				continue;
-- 
2.31.1

