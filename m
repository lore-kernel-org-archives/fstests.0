Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA23C433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Jan 2022 14:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347814AbiAGOo5 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Jan 2022 09:44:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347804AbiAGOo4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jan 2022 09:44:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E79C061574
        for <fstests@vger.kernel.org>; Fri,  7 Jan 2022 06:44:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E7BCB82659
        for <fstests@vger.kernel.org>; Fri,  7 Jan 2022 14:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEDBC36AED;
        Fri,  7 Jan 2022 14:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641566693;
        bh=nIh6oMYtp+0XCuPddcVyHt75yBc9TxPk1NSInWN2o7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OWYNTJ5PrddCqYJ09BkGn4KHsD6M8QZgDkqkao1evSzGiVgXxaToF57fgvHdC7MQF
         HlsGwLuyLFYW9XD41ekYtLSenmuH+bqx865K27VYw8OSNpn7CcDtF6cvcUHbOyUfUy
         7CiUmI1XyvY7AJSYCdiXaBTMhw+mYp0DU/7mkvlEVvV8fLKtMJXJVPQWYp2bTiiotG
         SUBhnbx7p9Z36MH7E7vdwIqWqOhQY9vFsEIsZz+ortJXWGnnFo5BnwzTube7SJ4vfJ
         yVCS7xtM1+gzef0aj7QDedcwaBtmphF/cayN3K/wsoyPIRj3pQIjuKNDC0IG5PcDIp
         Yd4zcBExf0zVw==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>
Cc:     Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Seth Forshee <seth.forshee@digitalocean.com>,
        Eryu Guan <guaneryu@gmail.com>
Subject: [PATCH 3/3] idmapped-mounts: add missing ownership comparisons to setgid tests
Date:   Fri,  7 Jan 2022 15:44:36 +0100
Message-Id: <20220107144436.332389-3-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220107144436.332389-1-brauner@kernel.org>
References: <20220107144436.332389-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2688; h=from:subject; bh=Dvm4J26iaMUHiutmbxTVaNPUnTqcjoc2NBXHQF76cLE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTeCHSZN8n9zqZ/h35Kigte6e1arpfQN7Xv9ZN1D86GJj2Y u2EmY0cpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEnvoy/FMPXbfrf4b7Hssmj1e3RC q/TeT+635xpe/ejpm3+PKXfuNk+B/e7XZm1/vN184mMj40fRRXN4/v8q4D/9KmvJH3j1ls0sYCAA==
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

In some setgid tests we missed to check ownership right after file or
directory creation in order to verify whether gid ownership inheritance
from the parent directory to the newly created file or directory works
correctly. Add the missing ones.

Cc: Seth Forshee <seth.forshee@digitalocean.com>
Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 38 +++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index c53e1942..a5c0a983 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -7863,6 +7863,12 @@ static int setgid_create(void)
 		if (!is_setgid(t_dir1_fd, DIR1, 0))
 			die("failure: is_setgid");
 
+		if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(t_dir1_fd, DIR1, 0, 0, 0))
+			die("failure: check ownership");
+
 		if (unlinkat(t_dir1_fd, FILE1, 0))
 			die("failure: delete");
 
@@ -7911,6 +7917,22 @@ static int setgid_create(void)
 				die("failure: is_setgid");
 		}
 
+		/*
+		 * In setgid directories newly created files always inherit the
+		 * gid from the parent directory. Verify that the file is owned
+		 * by gid 0, not by gid 10000.
+		 */
+		if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 0, 0))
+			die("failure: check ownership");
+
+		/*
+		 * In setgid directories newly created directories always
+		 * inherit the gid from the parent directory. Verify that the
+		 * directory is owned by gid 0, not by gid 10000.
+		 */
+		if (!expected_uid_gid(t_dir1_fd, DIR1, 0, 0, 0))
+			die("failure: check ownership");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8013,6 +8035,22 @@ static int setgid_create_idmapped(void)
 				die("failure: is_setgid");
 		}
 
+		/*
+		 * In setgid directories newly created files always inherit the
+		 * gid from the parent directory. Verify that the file is owned
+		 * by gid 10000, not by gid 11000.
+		 */
+		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		/*
+		 * In setgid directories newly created directories always
+		 * inherit the gid from the parent directory. Verify that the
+		 * directory is owned by gid 10000, not by gid 11000.
+		 */
+		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 10000, 10000))
+			die("failure: check ownership");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
-- 
2.32.0

