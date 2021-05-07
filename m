Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF6AC433B4
	for <linux-fstests@archiver.kernel.org>; Fri,  7 May 2021 15:01:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 137B16145D
	for <linux-fstests@archiver.kernel.org>; Fri,  7 May 2021 15:01:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236714AbhEGPCT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 May 2021 11:02:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230486AbhEGPCT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 7 May 2021 11:02:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CB0776145A;
        Fri,  7 May 2021 15:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620399679;
        bh=+ZXapNqAJdsrwvPxOfZ6KztdX5TeVqdj/RqAVnkz1V0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tof00WNf0FylO30Cd5fXfF2enNcFuM+JjYet2uHSlttDPjEsnbcLGWuJlCHVKhH4R
         /qaIN0IxqseXUlWC+haBrQQufIqzcyeQpa4l1vwJqvg7MjgBPctUh7VDvIHsp7+5HR
         EAj2c2kp/B7yv6mx4kOs+UfObn/0eQm2OpEEQA6XcD+95TyLSg1hf17SPFrZp3uEmu
         kx8OoYmKt4qzdZGuNuUmq0LRnMLKpu9vPuU2YzAmsYU7zp/J9qrx82eU9OURqil78G
         wUlpyoiXyk8tomA9OKOWG8dKz7yO6P/07E9K5ZMAM+MNu8lp+M8cPvuJr9sFAzhzvu
         dP6w4H3h28/3w==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guan@eryu.me>, fstests@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 2/7] idmapped-mounts: add missing newline to print_r()
Date:   Fri,  7 May 2021 17:00:55 +0200
Message-Id: <20210507150100.968659-3-brauner@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210507150100.968659-1-brauner@kernel.org>
References: <20210507150100.968659-1-brauner@kernel.org>
MIME-Version: 1.0
X-Patch-Hashes: v=1; h=sha256; i=JIDOOp8bimcVseNEX/pKO9nFqJ2BhX8jlE+EuF+cbgI=; m=ZZPj429gxwBvBnqNpII5Wx4tuVMSKDV+oVGHXtQGJeY=; p=fRGcEXtgrISjJb3f2y3sdmIpl801y5jrpiZKRO3mD+o=; g=7ee073e9ad2f2546c157419ef52eb3825f2af27b
X-Patch-Sig: m=pgp; i=christian.brauner@ubuntu.com; s=0x0x91C61BC06578DCA2; b=iHUEABYKAB0WIQRAhzRXHqcMeLMyaSiRxhvAZXjcogUCYJVWGgAKCRCRxhvAZXjcomQ7AQC25JZ eP1qsvDaWFEWuUVk6nDbX1OsaNbJPjPK4dR7hPAD/VyAkm+rhs2j2FR+zoyZ/f9i4ZmqcXzedj1/I 6VrltQ0=
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

The function missed to print a newline making the output difficult to
read when running with DEBUG_TRACE.

Cc: fstests@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 66bdd817..59a3daa8 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -620,7 +620,7 @@ __attribute__((unused)) static int print_r(int fd, const char *path)
 		ret = fstatat(fd, path, &st,
 			      AT_NO_AUTOMOUNT | AT_SYMLINK_NOFOLLOW);
 	if (!ret)
-		fprintf(stderr, "mode(%o):uid(%d):gid(%d) -> %s",
+		fprintf(stderr, "mode(%o):uid(%d):gid(%d) -> %s\n",
 			(st.st_mode & ~S_IFMT), st.st_uid, st.st_gid,
 			(path && *path) ? path : "(null)");
 
-- 
2.27.0

