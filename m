Return-Path: <SRS0=/bTx=EH=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF85C2D0A3
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Nov 2020 17:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2563D2236F
	for <linux-fstests@archiver.kernel.org>; Sun,  1 Nov 2020 17:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604251043;
	bh=B3oktzd1LKmRaS+3iKvJJbaAWsCAcqMLCs2/KDavqZ4=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=fYNnp4ROfD8tzuswRaj9Pu7kwR4t1lg9zsoN2yI3ez7AlSFMfDqr2kRtLMJScN+ad
	 6x1ZdjrJTEnk+xwFqjOVfr+i33qleuPQDr7n63TEaRXzZoNb4SpQimdMFP8F8lMAzx
	 jQZN72JNgg/s2s87eITms5uFi24w6zmV+KbLOrOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgKARRW (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 1 Nov 2020 12:17:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726790AbgKARRV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sun, 1 Nov 2020 12:17:21 -0500
Received: from sol.attlocal.net (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F40C2231B;
        Sun,  1 Nov 2020 17:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604251041;
        bh=B3oktzd1LKmRaS+3iKvJJbaAWsCAcqMLCs2/KDavqZ4=;
        h=From:To:Cc:Subject:Date:From;
        b=LLmxeyM8jEpwdUeTVnThDavad0tRecjWX6kI4RmtwmuNH1DZDzX61O0nD6Bvm1N/W
         3PhXo4+dWBeBu0mmoddFg23v4RWZUfTts/WWtW1jpqodLOb8tBdRoN6DtgWuGRMCeG
         JuuNK5J8aJeNiJ343DWiZd2vFrogd6pc6yH7mTjk=
From:   Eric Biggers <ebiggers@kernel.org>
To:     fstests@vger.kernel.org
Cc:     Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] tests/ceph: add Makefile
Date:   Sun,  1 Nov 2020 09:16:19 -0800
Message-Id: <20201101171619.323800-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

'make install' stopped working because the tests/ceph/ directory is
missing a Makefile.  Add it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 tests/ceph/Makefile | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)
 create mode 100644 tests/ceph/Makefile

diff --git a/tests/ceph/Makefile b/tests/ceph/Makefile
new file mode 100644
index 00000000..55e35d77
--- /dev/null
+++ b/tests/ceph/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0
+
+TOPDIR = ../..
+include $(TOPDIR)/include/builddefs
+
+CEPH_DIR = ceph
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(CEPH_DIR)
+
+include $(BUILDRULES)
+
+install:
+	$(INSTALL) -m 755 -d $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
+	$(INSTALL) -m 644 group $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
+
+# Nothing.
+install-dev install-lib:
-- 
2.29.1

