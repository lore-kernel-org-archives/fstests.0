Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F39C433EF
	for <linux-fstests@archiver.kernel.org>; Tue, 18 Jan 2022 14:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243975AbiARONh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 18 Jan 2022 09:13:37 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:37818 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233774AbiARONg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Jan 2022 09:13:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 490856149C
        for <fstests@vger.kernel.org>; Tue, 18 Jan 2022 14:13:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6ABC00446;
        Tue, 18 Jan 2022 14:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642515215;
        bh=i9NVtAsWwW7RB4YYMTfkADaB2G8ircntcHtYD5DaIBA=;
        h=From:To:Cc:Subject:Date:From;
        b=uA5xJxU2g/QMHREdqKqh0DeIHvHRPVint10UcLk7A4kc1l1XvKzKa+p5xUwEOstnx
         03058SnugRFaB8WArrkQl1u9+unHCIf8IRNgQkDT2AfqLisDfujC8+59/M0YIIkp7n
         Et8IxTvYii7eAAQeI/LPzKgwlTDkoG9E8qRL5m6EvzcrckbRpE2L1bUFtfWzeYyALf
         rRN4ucv9E755PAGJ/AZMiL86gDB4TSxms+GxsYnu8NClwdwUoNj+kE6EF1eRcL+hc3
         Sh+fyF4mrMtTAIfT11skEK3jd875b9snHuKwxFM2gAwaYrtsTCbHinKENwjsFcesoD
         88HMCLx5rFnDg==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>
Cc:     Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christian Brauner <brauner@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>
Subject: [PATCH v2 1/2] idmapped-mounts: add fs_allow_idmap() helper
Date:   Tue, 18 Jan 2022 15:13:23 +0100
Message-Id: <20220118141324.1500160-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2892; h=from:subject; bh=i9NVtAsWwW7RB4YYMTfkADaB2G8ircntcHtYD5DaIBA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQ+O/VbKOPATqGe82+VdmaIF/AZvZz/yjGsmM9w84nCdNHa grwnHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABN55crIsCOzvs7423J1LWOP9Xyy61 2z5G8KO65rl/FlCj8725VvHsM/Tb5Hc8oeztMWEE9880fp8YLki3Mj7WKvV3Bt2GE53TCUGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Move the check whether the underlying filesystem supports idmapped
mounts into a separate helper. We will use it in the following patch to
make it possible to always run all tests that don't require idmapped
mounts.

Link: https://lore.kernel.org/r/20220113132421.865002-1-brauner@kernel.org
Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
/* v2 */
- Eryu Guan <guaneryu@gmail.com>:
  - Don't call exit() in new fs_allow_idmap() helper. Instead, return
    and the caller decide whether to call exit() or not.
---
 src/idmapped-mounts/idmapped-mounts.c | 57 ++++++++++++++-------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index a5c0a983..fc305606 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -13955,6 +13955,35 @@ static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
 	return true;
 }
 
+static bool fs_allow_idmap(void)
+{
+	int ret;
+	int open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set	= MOUNT_ATTR_IDMAP,
+		.userns_fd	= -EBADF,
+	};
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd = get_userns_fd(0, 1000, 1);
+	if (attr.userns_fd < 0)
+		return false;
+
+	open_tree_fd = sys_open_tree(t_mnt_fd, "",
+				     AT_EMPTY_PATH | AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0)
+		ret = -1;
+	else
+		ret = sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr,
+					sizeof(attr));
+	close(open_tree_fd);
+	close(attr.userns_fd);
+
+	return ret == 0;
+}
+
 int main(int argc, char *argv[])
 {
 	int fret, ret;
@@ -14035,34 +14064,8 @@ int main(int argc, char *argv[])
 	 * idmapped mounts.
 	 */
 	if (supported) {
-		int open_tree_fd = -EBADF;
-		struct mount_attr attr = {
-			.attr_set	= MOUNT_ATTR_IDMAP,
-			.userns_fd	= -EBADF,
-		};
-
-		/* Changing mount properties on a detached mount. */
-		attr.userns_fd	= get_userns_fd(0, 1000, 1);
-		if (attr.userns_fd < 0)
+		if (!fs_allow_idmap())
 			exit(EXIT_FAILURE);
-
-		open_tree_fd = sys_open_tree(t_mnt_fd, "",
-					     AT_EMPTY_PATH |
-					     AT_NO_AUTOMOUNT |
-					     AT_SYMLINK_NOFOLLOW |
-					     OPEN_TREE_CLOEXEC |
-					     OPEN_TREE_CLONE);
-		if (open_tree_fd < 0)
-			ret = -1;
-		else
-			ret = sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr));
-
-		close(open_tree_fd);
-		close(attr.userns_fd);
-
-		if (ret)
-			exit(EXIT_FAILURE);
-
 		exit(EXIT_SUCCESS);
 	}
 

base-commit: bec9f2cc9d7ad86a9bf2a602529bc20667fcfe88
-- 
2.32.0

