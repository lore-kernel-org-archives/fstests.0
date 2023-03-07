Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5520C678D4
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 12:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231296AbjCGMGP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 07:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbjCGMGO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 07:06:14 -0500
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4233B0DA
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 04:06:12 -0800 (PST)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 07 Mar 2023 11:45:41 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH 06/11] vfs: Prepare tests in &s_idmapped_mounts to be reused inside a userns
Date:   Tue,  7 Mar 2023 12:45:02 +0100
Message-Id: <20230307114507.332309-7-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
References: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Future patches will call these tests within a userns. So, let's skip
operations not allowed inside a userns.

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
---
 src/vfs/idmapped-mounts.c | 54 +++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git src/vfs/idmapped-mounts.c src/vfs/idmapped-mounts.c
index ed7948b6..828b2ea3 100644
--- src/vfs/idmapped-mounts.c
+++ src/vfs/idmapped-mounts.c
@@ -535,7 +535,7 @@ static int fsids_mapped(const struct vfstest_info *info)
 			die("failure: create");
 
 		/* create character device */
-		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | 0644, makedev(5, 1)))
+		if (!info->t_inside_userns && mknodat(open_tree_fd, CHRDEV1, S_IFCHR | 0644, makedev(5, 1)))
 			die("failure: create");
 
 		/* create symlink */
@@ -764,7 +764,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 	}
 
 	/* create character device */
-	if (mknodat(info->t_dir1_fd, CHRDEV1, S_IFCHR | 0644, makedev(5, 1))) {
+	if (!info->t_inside_userns && mknodat(info->t_dir1_fd, CHRDEV1, S_IFCHR | 0644, makedev(5, 1))) {
 		log_stderr("failure: mknodat");
 		goto out;
 	}
@@ -825,7 +825,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
-	if (!expected_uid_gid(info->t_dir1_fd, CHRDEV1, 0, 0, 0)) {
+	if (!info->t_inside_userns && !expected_uid_gid(info->t_dir1_fd, CHRDEV1, 0, 0, 0)) {
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
@@ -857,7 +857,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
-	if (!expected_uid_gid(open_tree_fd1, CHRDEV1, 0, 10000, 10000)) {
+	if (!info->t_inside_userns && !expected_uid_gid(open_tree_fd1, CHRDEV1, 0, 10000, 10000)) {
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
@@ -912,7 +912,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
-	if (!expected_uid_gid(open_tree_fd2, CHRDEV1, 0, 30000, 30000)) {
+	if (!info->t_inside_userns && !expected_uid_gid(open_tree_fd2, CHRDEV1, 0, 30000, 30000)) {
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
@@ -942,7 +942,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 		log_stderr("failure: fchownat");
 		goto out;
 	}
-	if (fchownat(info->t_dir1_fd, CHRDEV1, 2000, 2000, 0)) {
+	if (!info->t_inside_userns && fchownat(info->t_dir1_fd, CHRDEV1, 2000, 2000, 0)) {
 		log_stderr("failure: fchownat");
 		goto out;
 	}
@@ -972,7 +972,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
-	if (!expected_uid_gid(info->t_dir1_fd, CHRDEV1, 0, 2000, 2000)) {
+	if (!info->t_inside_userns && !expected_uid_gid(info->t_dir1_fd, CHRDEV1, 0, 2000, 2000)) {
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
@@ -1002,7 +1002,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
-	if (!expected_uid_gid(open_tree_fd1, CHRDEV1, 0, 12000, 12000)) {
+	if (!info->t_inside_userns && !expected_uid_gid(open_tree_fd1, CHRDEV1, 0, 12000, 12000)) {
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
@@ -1032,7 +1032,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
-	if (!expected_uid_gid(open_tree_fd2, CHRDEV1, 0, 32000, 32000)) {
+	if (!info->t_inside_userns && !expected_uid_gid(open_tree_fd2, CHRDEV1, 0, 32000, 32000)) {
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
@@ -1064,7 +1064,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 			die("failure: fchownat");
 		if (!fchownat(info->t_dir1_fd, HARDLINK1, 1000, 1000, 0))
 			die("failure: fchownat");
-		if (!fchownat(info->t_dir1_fd, CHRDEV1, 1000, 1000, 0))
+		if (!info->t_inside_userns && !fchownat(info->t_dir1_fd, CHRDEV1, 1000, 1000, 0))
 			die("failure: fchownat");
 		if (!fchownat(info->t_dir1_fd, SYMLINK1, 2000, 2000, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW))
 			die("failure: fchownat");
@@ -1079,7 +1079,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 			die("failure: fchownat");
 		if (!fchownat(open_tree_fd2, HARDLINK1, 1000, 1000, 0))
 			die("failure: fchownat");
-		if (!fchownat(open_tree_fd2, CHRDEV1, 1000, 1000, 0))
+		if (!info->t_inside_userns && !fchownat(open_tree_fd2, CHRDEV1, 1000, 1000, 0))
 			die("failure: fchownat");
 		if (!fchownat(open_tree_fd2, SYMLINK1, 2000, 2000, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW))
 			die("failure: fchownat");
@@ -1094,7 +1094,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 			die("failure: fchownat");
 		if (fchownat(open_tree_fd1, HARDLINK1, 1000, 1000, 0))
 			die("failure: fchownat");
-		if (fchownat(open_tree_fd1, CHRDEV1, 1000, 1000, 0))
+		if (!info->t_inside_userns && fchownat(open_tree_fd1, CHRDEV1, 1000, 1000, 0))
 			die("failure: fchownat");
 		if (fchownat(open_tree_fd1, SYMLINK1, 2000, 2000, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW))
 			die("failure: fchownat");
@@ -1109,7 +1109,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 			die("failure: expected_uid_gid");
 		if (!expected_uid_gid(info->t_dir1_fd, HARDLINK1, 0, info->t_overflowuid, info->t_overflowgid))
 			die("failure: expected_uid_gid");
-		if (!expected_uid_gid(info->t_dir1_fd, CHRDEV1, 0, info->t_overflowuid, info->t_overflowgid))
+		if (!info->t_inside_userns && !expected_uid_gid(info->t_dir1_fd, CHRDEV1, 0, info->t_overflowuid, info->t_overflowgid))
 			die("failure: expected_uid_gid");
 		if (!expected_uid_gid(info->t_dir1_fd, SYMLINK1, AT_SYMLINK_NOFOLLOW, info->t_overflowuid, info->t_overflowgid))
 			die("failure: expected_uid_gid");
@@ -1124,7 +1124,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 			die("failure: expected_uid_gid");
 		if (!expected_uid_gid(open_tree_fd2, HARDLINK1, 0, info->t_overflowuid, info->t_overflowgid))
 			die("failure: expected_uid_gid");
-		if (!expected_uid_gid(open_tree_fd2, CHRDEV1, 0, info->t_overflowuid, info->t_overflowgid))
+		if (!info->t_inside_userns && !expected_uid_gid(open_tree_fd2, CHRDEV1, 0, info->t_overflowuid, info->t_overflowgid))
 			die("failure: expected_uid_gid");
 		if (!expected_uid_gid(open_tree_fd2, SYMLINK1, AT_SYMLINK_NOFOLLOW, info->t_overflowuid, info->t_overflowgid))
 			die("failure: expected_uid_gid");
@@ -1139,7 +1139,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 			die("failure: expected_uid_gid");
 		if (!expected_uid_gid(open_tree_fd1, HARDLINK1, 0, 1000, 1000))
 			die("failure: expected_uid_gid");
-		if (!expected_uid_gid(open_tree_fd1, CHRDEV1, 0, 1000, 1000))
+		if (!info->t_inside_userns && !expected_uid_gid(open_tree_fd1, CHRDEV1, 0, 1000, 1000))
 			die("failure: expected_uid_gid");
 		if (!expected_uid_gid(open_tree_fd1, SYMLINK1, AT_SYMLINK_NOFOLLOW, 2000, 2000))
 			die("failure: expected_uid_gid");
@@ -1167,7 +1167,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
-	if (!expected_uid_gid(info->t_dir1_fd, CHRDEV1, 0, 1000, 1000)) {
+	if (!info->t_inside_userns && !expected_uid_gid(info->t_dir1_fd, CHRDEV1, 0, 1000, 1000)) {
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
@@ -1197,7 +1197,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
-	if (!expected_uid_gid(open_tree_fd1, CHRDEV1, 0, 11000, 11000)) {
+	if (!info->t_inside_userns && !expected_uid_gid(open_tree_fd1, CHRDEV1, 0, 11000, 11000)) {
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
@@ -1227,7 +1227,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
-	if (!expected_uid_gid(open_tree_fd2, CHRDEV1, 0, 31000, 31000)) {
+	if (!info->t_inside_userns && !expected_uid_gid(open_tree_fd2, CHRDEV1, 0, 31000, 31000)) {
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
@@ -1259,7 +1259,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 			die("failure: fchownat");
 		if (!fchownat(info->t_dir1_fd, HARDLINK1, 0, 0, 0))
 			die("failure: fchownat");
-		if (!fchownat(info->t_dir1_fd, CHRDEV1, 0, 0, 0))
+		if (!info->t_inside_userns && !fchownat(info->t_dir1_fd, CHRDEV1, 0, 0, 0))
 			die("failure: fchownat");
 		if (!fchownat(info->t_dir1_fd, SYMLINK1, 3000, 3000, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW))
 			die("failure: fchownat");
@@ -1274,7 +1274,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 			die("failure: fchownat");
 		if (!fchownat(open_tree_fd1, HARDLINK1, 0, 0, 0))
 			die("failure: fchownat");
-		if (!fchownat(open_tree_fd1, CHRDEV1, 0, 0, 0))
+		if (!info->t_inside_userns && !fchownat(open_tree_fd1, CHRDEV1, 0, 0, 0))
 			die("failure: fchownat");
 		if (!fchownat(open_tree_fd1, SYMLINK1, 3000, 3000, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW))
 			die("failure: fchownat");
@@ -1289,7 +1289,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 			die("failure: fchownat");
 		if (fchownat(open_tree_fd2, HARDLINK1, 0, 0, 0))
 			die("failure: fchownat");
-		if (fchownat(open_tree_fd2, CHRDEV1, 0, 0, 0))
+		if (!info->t_inside_userns && fchownat(open_tree_fd2, CHRDEV1, 0, 0, 0))
 			die("failure: fchownat");
 		if (!fchownat(open_tree_fd2, SYMLINK1, 3000, 3000, AT_EMPTY_PATH | AT_SYMLINK_NOFOLLOW))
 			die("failure: fchownat");
@@ -1304,7 +1304,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 			die("failure: expected_uid_gid");
 		if (!expected_uid_gid(info->t_dir1_fd, HARDLINK1, 0, info->t_overflowuid, info->t_overflowgid))
 			die("failure: expected_uid_gid");
-		if (!expected_uid_gid(info->t_dir1_fd, CHRDEV1, 0, info->t_overflowuid, info->t_overflowgid))
+		if (!info->t_inside_userns && !expected_uid_gid(info->t_dir1_fd, CHRDEV1, 0, info->t_overflowuid, info->t_overflowgid))
 			die("failure: expected_uid_gid");
 		if (!expected_uid_gid(info->t_dir1_fd, SYMLINK1, AT_SYMLINK_NOFOLLOW, info->t_overflowuid, info->t_overflowgid))
 			die("failure: expected_uid_gid");
@@ -1319,7 +1319,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 			die("failure: expected_uid_gid");
 		if (!expected_uid_gid(open_tree_fd1, HARDLINK1, 0, info->t_overflowuid, info->t_overflowgid))
 			die("failure: expected_uid_gid");
-		if (!expected_uid_gid(open_tree_fd1, CHRDEV1, 0, info->t_overflowuid, info->t_overflowgid))
+		if (!info->t_inside_userns && !expected_uid_gid(open_tree_fd1, CHRDEV1, 0, info->t_overflowuid, info->t_overflowgid))
 			die("failure: expected_uid_gid");
 		if (!expected_uid_gid(open_tree_fd1, SYMLINK1, AT_SYMLINK_NOFOLLOW, info->t_overflowuid, info->t_overflowgid))
 			die("failure: expected_uid_gid");
@@ -1334,7 +1334,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 			die("failure: expected_uid_gid");
 		if (!expected_uid_gid(open_tree_fd2, HARDLINK1, 0, 0, 0))
 			die("failure: expected_uid_gid");
-		if (!expected_uid_gid(open_tree_fd2, CHRDEV1, 0, 0, 0))
+		if (!info->t_inside_userns && !expected_uid_gid(open_tree_fd2, CHRDEV1, 0, 0, 0))
 			die("failure: expected_uid_gid");
 		if (!expected_uid_gid(open_tree_fd2, SYMLINK1, AT_SYMLINK_NOFOLLOW, 2000, 2000))
 			die("failure: expected_uid_gid");
@@ -1362,7 +1362,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
-	if (!expected_uid_gid(info->t_dir1_fd, CHRDEV1, 0, 0, 0)) {
+	if (!info->t_inside_userns && !expected_uid_gid(info->t_dir1_fd, CHRDEV1, 0, 0, 0)) {
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
@@ -1392,7 +1392,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
-	if (!expected_uid_gid(open_tree_fd1, CHRDEV1, 0, 10000, 10000)) {
+	if (!info->t_inside_userns && !expected_uid_gid(open_tree_fd1, CHRDEV1, 0, 10000, 10000)) {
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
@@ -1422,7 +1422,7 @@ static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
-	if (!expected_uid_gid(open_tree_fd2, CHRDEV1, 0, 30000, 30000)) {
+	if (!info->t_inside_userns && !expected_uid_gid(open_tree_fd2, CHRDEV1, 0, 30000, 30000)) {
 		log_stderr("failure: expected_uid_gid");
 		goto out;
 	}
-- 
2.39.2

