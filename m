Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1A0C433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 12 May 2022 16:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356452AbiELQxT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 12:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356712AbiELQxS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 12:53:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDB526866E
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 09:53:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1ABA562039
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 16:53:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89EDDC36AE2;
        Thu, 12 May 2022 16:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652374396;
        bh=OUYmXGD6Z5VdhYQKu7nQOhDRUsFdumnmhmkqs7CvYtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=seUl8djFBoDNLlYnVFRqNaqnDspWGLkmxmlOhVz+OvcL8t0DzNoIxuYqyqiM0lwGV
         nuskPk5XO68UJrBzLxbaC0B/L6+h8bIf+PpuQiCnRrMaF6eTJZdQrLFBeSt+zl86oF
         JDvX3S6QL/1c69D4CK4kP6gqrWKr0MmEj9+9VKOC5Tiy3RTaRhw0rhFd5isOjVgwdw
         /bDb9ZaXdo2n7dFfcs/8g2mB4yyD6W0KrtC3pIBRyLk8myeUoUkZrTrkgOj7brZpv8
         D+/9zxWSpfvbYHpC2OItk8YxFdgJRo4BGfYDPZy5vlBlcLAy/N75MD2CxCZeCnYziH
         r4/4ApW3WxblA==
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2 05/13] utils: add missing global.h include
Date:   Thu, 12 May 2022 18:52:42 +0200
Message-Id: <20220512165250.450989-6-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220512165250.450989-1-brauner@kernel.org>
References: <20220512165250.450989-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=865; h=from:subject; bh=OUYmXGD6Z5VdhYQKu7nQOhDRUsFdumnmhmkqs7CvYtg=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTVWrtfvVMRYjPXzXN+2Ib370/8zavgFBfgjrbkEOgpnF2Y wWLUUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJEr1Qz/3Q+de9+t9dp1ws4kV+Wl91 bfeF389JzHiXs3F8UIzX32Q47hf/C95h3/lO24pqrxc3C7CJ1O5nkiGv5No7hp4ed3S5fOYAUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Make sure that utils.{c,h} have access to the necessary defines created
during the configure stage when building xfstests.

Cc: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests <fstests@vger.kernel.org>
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 src/vfs/utils.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/vfs/utils.h b/src/vfs/utils.h
index c1024646..e32865a6 100644
--- a/src/vfs/utils.h
+++ b/src/vfs/utils.h
@@ -3,6 +3,8 @@
 #ifndef __IDMAP_UTILS_H
 #define __IDMAP_UTILS_H
 
+#include "../global.h"
+
 #ifndef _GNU_SOURCE
 #define _GNU_SOURCE
 #endif
-- 
2.34.1

