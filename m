Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BE9C433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Jan 2022 14:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347927AbiAGO6i (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Jan 2022 09:58:38 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:60396 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347935AbiAGO6e (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jan 2022 09:58:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1977061EF7
        for <fstests@vger.kernel.org>; Fri,  7 Jan 2022 14:58:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C485C36AEF;
        Fri,  7 Jan 2022 14:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641567512;
        bh=Czg7uLOahRnQpkQfPkGqyhzGbB9ON78W/OEF3TcayI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hpuN/pEqnBE8AcKz1bzbWHQbtvx9vX8YnXmSTwb3Zr55ZajYGJbSbd+CDJKuKaQEQ
         6G5TQOE/Rg99zlRzOqBmwSx3nrbNkJ+uzr9r10wMfSRYLIZvOogo2tUZRgTtv9oUHr
         AEkFwkkpqFkgf5p/fvUBEXoUWkiSBLEeSVu0uItxSe9WINrHwEvGTs+Mk21xxyFlCV
         Ds8dvZv9OiVfCe5omCfHF9f8cLUnOfhM2N+Rz20U3kvEgSec7NGiqi7CPKdVDt73AR
         rx2g4hElGDRtmaVVDfsnqpxAJuPrsjQNrlRsWgsZq0v3lSXaKuZJXVcnUyoVmezSpG
         wJyrJmLL8blHg==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>
Cc:     Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christian Brauner <brauner@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>
Subject: [PATCH 3/3] idmapped-mounts: add missing ownership comparisons to setgid tests
Date:   Fri,  7 Jan 2022 15:58:18 +0100
Message-Id: <20220107145818.336126-3-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220107145818.336126-1-brauner@kernel.org>
References: <20220107145818.336126-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2789; h=from:subject; bh=Czg7uLOahRnQpkQfPkGqyhzGbB9ON78W/OEF3TcayI8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTeCGVepeXL8tvqfMSEPzFf/6W0vuPem7Mua6tmPr+ih82e +OU/OkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbiNYGRYZb93qWB+QG/Zs93sQ9d/+ t3JtPFmPUq268XZy9QtLV45sfIcLKEU/vOppDvugpzPmyPDe/ftqz/6LL+/6FqfYIFj/5sYQUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

In some setgid tests we missed to check ownership right after file or
directory creation in order to verify whether gid ownership inheritance
from the parent directory to the newly created file or directory works
correctly. Add the missing ones.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
/* v2 */
- Christian Brauner <brauner@kernel.org>:
  - fix Seth's mail address in commit message
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

