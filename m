Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D93C433F5
	for <linux-fstests@archiver.kernel.org>; Sat,  7 May 2022 15:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbiEGPFH (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 7 May 2022 11:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241703AbiEGPFE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 7 May 2022 11:05:04 -0400
Received: from mail1.bemta32.messagelabs.com (mail1.bemta32.messagelabs.com [195.245.230.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB5142EC7
        for <fstests@vger.kernel.org>; Sat,  7 May 2022 08:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1651935673; i=@fujitsu.com;
        bh=BqOoc7/VSHJO0BF4zGHIaOqIPo0DqiznXhA+VYiR0BU=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=J6HgSVwOTOdSPYxfLPNNWbBxXwPDbJWQM5hOwVHB424vppeECQb+a8f1ZPjn+lFe3
         DzQw/2h9Vj2YFmAAoG1QDRGW9REaCEOBxwYt8fc+ga8P9IZWJsRalz5NSc/Rhz9shK
         fhuCSOJXC9nXDF9HPYIQHgpRo3gTqkdXWcV1JaHcpTZJPVKgoNKqyCvd84+qgQgXZq
         uv8nyujTGtU8FOS82eB4uK6Og5IIHkBPKv3c9SsWugBBQk3D3R/DRa143T805ZTmkC
         O79v/ttyuSs14jQFkGH+38Z14HXKIXLDio2BtBzAOYzxomV0nz7Zx+pE52+HJQ7mMv
         lH4M6QZVg63Qw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRWlGSWpSXmKPExsViZ8ORqLujsyz
  JYMcbOYvXhz8xWpxu2cvuwOSxaVUnm8fnTXIBTFGsmXlJ+RUJrBmXrt1iKrgVW/Hs0m+WBsYz
  vl2MXBxCAlsYJfa9mc0E4Sxgkpi68QIjhLObUWLN1QYgh5ODTUBT4lnnAuYuRg4OEQEJiV2Lw
  kDCzAJOEnPWnWICsYUFfCWanxxiB7FZBFQk3l1YCxbnFfCQ+DPjA5gtIaAgMeXhe2YQm1PAU2
  L2pSlg9UJANcsO/2WGqBeUODnzCQvEfAmJgy9eMEP0Kkpc6vjGCGFXSMya1QY1U03i6rlNzBM
  YBWchaZ+FpH0BI9MqRsukosz0jJLcxMwcXUMDA11DQ1NdQ11TS73EKt1EvdRS3fLU4hJdQ73E
  8mK91OJiveLK3OScFL281JJNjMCgTilmtN7B2NH3U+8QoyQHk5Iob4tNaZIQX1J+SmVGYnFGf
  FFpTmrxIUYZDg4lCd6AjrIkIcGi1PTUirTMHGCEwaQlOHiURHhtSoHSvMUFibnFmekQqVOMuh
  x/P/3dyyzEkpeflyolzptUB1QkAFKUUZoHNwIW7ZcYZaWEeRkZGBiEeApSi3IzS1DlXzGKczA
  qCfMeAbmEJzOvBG7TK6AjmICO+BhQCnJESSJCSqqBSSg+TuA6P3u/yoH0BbmZc68uzpFP6HvL
  O/992JJ1Wa0/a/f4qTuI3GG8qFXXnb3swCk2k9c5PL89YtWivRK+2uavkxH15Pk0Tz0rYf3PP
  3diGhcUeu4tu3n12O9c16XPxB46+2om/YitvqBrc2/eZq+yf49vf39yRW0HU9ecu+23Myacnm
  CtEsDa4XG6dH22n2nVth1hhwWkl86cvmTNGS9RJ97Ac1o64iZNhzcHRu1giN6ey/KVwa1UWqx
  FarqG99WUpWkPDuXt/vHseF9U5u1Cqb6guZP+XldcEbov9Pt7R+vwoA67qEk73t04IfZ2jcjJ
  X+xXbqkunHq4ZXXCFJOdgUc95D48YrLeUd/NpcRSnJFoqMVcVJwIADi+INJxAwAA
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-8.tower-591.messagelabs.com!1651935672!235382!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.86.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 16359 invoked from network); 7 May 2022 15:01:12 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-8.tower-591.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 7 May 2022 15:01:12 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id C8176100184;
        Sat,  7 May 2022 16:01:11 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id A3314100186;
        Sat,  7 May 2022 16:01:11 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Sat, 7 May 2022 16:00:53 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <brauner@kernel.org>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v5 2/3] idmapped-mounts: Add mknodat operation in setgid test
Date:   Sun, 8 May 2022 00:01:26 +0800
Message-ID: <1651939287-2714-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1651939287-2714-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1651939287-2714-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Since mknodat can create file, we should also check whether strip S_ISGID.
Also add new helper caps_down_fsetid to drop CAP_FSETID because strip S_ISGID
depend on this cap and keep other cap(ie CAP_MKNOD) because create character
device needs it when using mknod.

Only test mknodat with character device in setgid_create function and the another
two functions test mknodat with whiteout device.

Since kernel commit a3c751a50 ("vfs: allow unprivileged whiteout creation") in
v5.8-rc1, we can create whiteout device in userns test. Since kernel 5.12, mount_setattr
and MOUNT_ATTR_IDMAP was supported, we don't need to detect kernel whether allow
unprivileged whiteout creation. Using fs_allow_idmap as a proxy is safe.

Tested-by: Christian Brauner (Microsoft)<brauner@kernel.org>
Reviewed-by: Christian Brauner (Microsoft)<brauner@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 222 +++++++++++++++++++++++++-
 1 file changed, 215 insertions(+), 7 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 2e94bf71..592a15d5 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -243,6 +243,35 @@ static inline bool caps_supported(void)
 	return ret;
 }
 
+/* caps_down_fsetid - lower CAP_FSETID effective cap */
+static int caps_down_fsetid(void)
+{
+	bool fret = false;
+#ifdef HAVE_SYS_CAPABILITY_H
+	cap_t caps = NULL;
+	cap_value_t cap = CAP_FSETID;
+	int ret = -1;
+
+	caps = cap_get_proc();
+	if (!caps)
+		goto out;
+
+	ret = cap_set_flag(caps, CAP_EFFECTIVE, 1, &cap, 0);
+	if (ret)
+		goto out;
+
+	ret = cap_set_proc(caps);
+	if (ret)
+		goto out;
+
+	fret = true;
+
+out:
+	cap_free(caps);
+#endif
+	return fret;
+}
+
 /* caps_down - lower all effective caps */
 static int caps_down(void)
 {
@@ -7807,9 +7836,9 @@ out_unmap:
 #endif /* HAVE_LIBURING_H */
 
 /* The following tests are concerned with setgid inheritance. These can be
- * filesystem type specific. For xfs, if a new file or directory is created
- * within a setgid directory and irix_sgid_inhiert is set then inherit the
- * setgid bit if the caller is in the group of the directory.
+ * filesystem type specific. For xfs, if a new file or directory or node is
+ * created within a setgid directory and irix_sgid_inhiert is set then inherit
+ * the setgid bit if the caller is in the group of the directory.
  */
 static int setgid_create(void)
 {
@@ -7865,18 +7894,44 @@ static int setgid_create(void)
 		if (!is_setgid(t_dir1_fd, DIR1, 0))
 			die("failure: is_setgid");
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(t_dir1_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (!is_setgid(t_dir1_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		/* create a character device via mknodat() vfs_mknod */
+		if (mknodat(t_dir1_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, makedev(5, 1)))
+			die("failure: mknodat");
+
+		if (!is_setgid(t_dir1_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
 		if (!expected_uid_gid(t_dir1_fd, FILE1, 0, 0, 0))
 			die("failure: check ownership");
 
 		if (!expected_uid_gid(t_dir1_fd, DIR1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(t_dir1_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(t_dir1_fd, CHRDEV1, 0, 0, 0))
+			die("failure: check ownership");
+
 		if (unlinkat(t_dir1_fd, FILE1, 0))
 			die("failure: delete");
 
 		if (unlinkat(t_dir1_fd, DIR1, AT_REMOVEDIR))
 			die("failure: delete");
 
+		if (unlinkat(t_dir1_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(t_dir1_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -7891,8 +7946,8 @@ static int setgid_create(void)
 		if (!switch_ids(0, 10000))
 			die("failure: switch_ids");
 
-		if (!caps_down())
-			die("failure: caps_down");
+		if (!caps_down_fsetid())
+			die("failure: caps_down_fsetid");
 
 		/* create regular file via open() */
 		file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
@@ -7919,6 +7974,19 @@ static int setgid_create(void)
 				die("failure: is_setgid");
 		}
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(t_dir1_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(t_dir1_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		/* create a character device via mknodat() vfs_mknod */
+		if (mknodat(t_dir1_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, makedev(5, 1)))
+			die("failure: mknodat");
+
+		if (is_setgid(t_dir1_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
 		/*
 		 * In setgid directories newly created files always inherit the
 		 * gid from the parent directory. Verify that the file is owned
@@ -7935,6 +8003,24 @@ static int setgid_create(void)
 		if (!expected_uid_gid(t_dir1_fd, DIR1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(t_dir1_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(t_dir1_fd, CHRDEV1, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (unlinkat(t_dir1_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(t_dir1_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
+		if (unlinkat(t_dir1_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(t_dir1_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8037,6 +8123,20 @@ static int setgid_create_idmapped(void)
 				die("failure: is_setgid");
 		}
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
 		/*
 		 * In setgid directories newly created files always inherit the
 		 * gid from the parent directory. Verify that the file is owned
@@ -8053,6 +8153,24 @@ static int setgid_create_idmapped(void)
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 10000, 10000))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8151,18 +8269,44 @@ static int setgid_create_idmapped_in_userns(void)
 		if (!is_setgid(open_tree_fd, DIR1, 0))
 			die("failure: is_setgid");
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (!is_setgid(open_tree_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (!is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
 			die("failure: check ownership");
 
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 0, 0))
+			die("failure: check ownership");
+
 		if (unlinkat(open_tree_fd, FILE1, 0))
 			die("failure: delete");
 
 		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
 			die("failure: delete");
 
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8192,9 +8336,12 @@ static int setgid_create_idmapped_in_userns(void)
 			exit(EXIT_SUCCESS);
 		}
 
-		if (!switch_userns(attr.userns_fd, 0, 0, true))
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
 			die("failure: switch_userns");
 
+		if (!caps_down_fsetid())
+			die("failure: caps_down_fsetid");
+
 		/* create regular file via open() */
 		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
 		if (file1_fd < 0)
@@ -8220,6 +8367,20 @@ static int setgid_create_idmapped_in_userns(void)
 				die("failure: is_setgid");
 		}
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
 		/*
 		 * In setgid directories newly created files always inherit the
 		 * gid from the parent directory. Verify that the file is owned
@@ -8236,12 +8397,24 @@ static int setgid_create_idmapped_in_userns(void)
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 1000))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 0, 1000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 0, 1000))
+			die("failure: check ownership");
+
 		if (unlinkat(open_tree_fd, FILE1, 0))
 			die("failure: delete");
 
 		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
 			die("failure: delete");
 
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
@@ -8268,9 +8441,12 @@ static int setgid_create_idmapped_in_userns(void)
 			exit(EXIT_SUCCESS);
 		}
 
-		if (!switch_userns(attr.userns_fd, 0, 1000, true))
+		if (!switch_userns(attr.userns_fd, 0, 1000, false))
 			die("failure: switch_userns");
 
+		if (!caps_down_fsetid())
+			die("failure: caps_down_fsetid");
+
 		/* create regular file via open() */
 		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
 		if (file1_fd < 0)
@@ -8297,12 +8473,44 @@ static int setgid_create_idmapped_in_userns(void)
 				die("failure: is_setgid");
 		}
 
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
 		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 0))
 			die("failure: check ownership");
 
 		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 0))
 			die("failure: check ownership");
 
+		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
 		exit(EXIT_SUCCESS);
 	}
 	if (wait_for_pid(pid))
-- 
2.27.0

