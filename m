Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8FFC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Jan 2022 13:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbiAMNYs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:24:48 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50146 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235103AbiAMNYs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Jan 2022 08:24:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D18AB821C1
        for <fstests@vger.kernel.org>; Thu, 13 Jan 2022 13:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00452C36AE3;
        Thu, 13 Jan 2022 13:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642080285;
        bh=gf4Hn6Tm98KDHaTaQQLlSyTZEfcw529ytlCQzeq2xTk=;
        h=From:To:Cc:Subject:Date:From;
        b=s558ctadn92sfYXOMLUZFMmunv6/0sltSOVyzAYej0d5Jp7YU/MPEISYtgXFOdJHQ
         wGJ/3F6sY7f1sERds/NzR8luN9nW4UFoXX0ec9kv0pzQinb3HuHdeOGU2/KGoZH6qk
         Q8DsS1wV+NXP8Nhd8SAPrVrUMzoQHbnE4RudG5P/hFJfE9j/pU0kLp63S+FD0049T7
         ziyFZ3cqE8AS15ipopBVEaM6YJcNdPoyH2pPIOYbyHlkrZBYiuJSaa2h8gNL3KQCJy
         GpuMEsoG0rQsBCLqHDpIJHDbKZjI1u3chtjDgnW5x5ibVGzS4K/xyP7siXikYt4Th0
         TjI4rldMGeZ9w==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>
Cc:     Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christian Brauner <brauner@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>
Subject: [PATCH 1/2] idmapped-mounts: add fs_allow_idmap() helper
Date:   Thu, 13 Jan 2022 14:24:20 +0100
Message-Id: <20220113132421.865002-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2643; h=from:subject; bh=gf4Hn6Tm98KDHaTaQQLlSyTZEfcw529ytlCQzeq2xTk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQ+UP+3JoDJy5fPwq7C4m24RfQytUXvv21wXlF5erLXXKtb E5+t7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI13yG/8kul5vvz1drveywdsXS5c fesaQ6/v8zsele/QZe5i3c+4QYGRYabT4Rl9n1bj37m4As47Q7DU+TNda/2GS5Puvjkz1B69kB
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Move the check whether the underlying filesystem supports idmapped
mounts into a separate helper. We will use it in the following patch to
make it possible to always run all tests that don't require idmapped
mounts.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 src/idmapped-mounts/idmapped-mounts.c | 57 ++++++++++++++-------------
 1 file changed, 30 insertions(+), 27 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index da690779..a78a901f 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -13907,6 +13907,35 @@ static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
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
+		exit(EXIT_FAILURE);
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
@@ -13987,34 +14016,8 @@ int main(int argc, char *argv[])
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
 

base-commit: c61c1e2f4cad89d4f900eaef173616b309228110
-- 
2.32.0

