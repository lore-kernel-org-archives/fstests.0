Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0705AECAAD8
	for <linux-fstests@archiver.kernel.org>; Tue, 20 Sep 2022 08:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiITIh1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 20 Sep 2022 04:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiITIg6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 20 Sep 2022 04:36:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CC51F637
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 01:35:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5AEFE6264C
        for <fstests@vger.kernel.org>; Tue, 20 Sep 2022 08:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5570EC433D6;
        Tue, 20 Sep 2022 08:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663662928;
        bh=O+qvEdwiMziQxjyDuhS72AP4Wo9ddb8yo23TSw3LXOU=;
        h=From:To:Cc:Subject:Date:From;
        b=OcZBXEKC3MKCyOWtIpSmN0rbmricud6m4LUPqBYRGQiEBOIW7RlYJ20CiqMDAULuZ
         sbbNv0sXzAVYnZrOJFMNlMSiD74p2c00/9qZFtEoVfANtbtLmMlCpHJYOPZa8KXfr3
         G27PPm0C6QSiYpPdVoVX3KSE5mdPgKMI9amQX1SOyINOmQSROKjBk8VV1q8DwlPFd+
         VlFFtvBIUHLY8cF7vPIlsSyIZDNFQL6HlYfci20hnQkE5dMQMRlTY3XhD/3fYjHJYL
         oOrzLgZW8Sism9zWg4S9YZblJLBkmjPgavTELTS0Ap3q4kiI6q0/9ExR0xB2Ce15Qf
         SS3GDXE4DpBTw==
From:   Christian Brauner <brauner@kernel.org>
To:     Seth Forshee <sforshee@kernel.org>, Zorro Lang <zlang@kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Subject: [PATCH] idmapped-mounts: account for EOVERFLOW
Date:   Tue, 20 Sep 2022 10:35:22 +0200
Message-Id: <20220920083522.1291798-1-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1445; i=brauner@kernel.org; h=from:subject; bh=O+qvEdwiMziQxjyDuhS72AP4Wo9ddb8yo23TSw3LXOU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRrVrvtvX5pboH/NI8Tc5+peKlvk+7j6/axbjht9OzZlZlV f2fN7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIMmtGhqVK3UslPieIf7teMHOSla 3kO/5vteWVGTtSvASOB17oP8LIsDz8moRixLe38+eq3wt3X8RkW/haoUN8ge3HH20m/LddWQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

We introduced a new type vfs{g,u}id_t into the vfs in b27c82e12965
("attr: port attribute changes to new types"). This type makes sure that
{g,u}ids mapped into an idmapped mount are distinct from regular
k{g,u}id_t. This expands the possible errnos that users may see so we
need to handle both EINVAL and EOVERFLOW.

Cc: Seth Forshee (DigitalOcean) <sforshee@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 src/vfs/idmapped-mounts.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
index c010dfa1..ed7948b6 100644
--- a/src/vfs/idmapped-mounts.c
+++ b/src/vfs/idmapped-mounts.c
@@ -7367,7 +7367,7 @@ static int setattr_fix_968219708108(const struct vfstest_info *info)
 		 */
 		if (!fchownat(open_tree_fd, FILE1, 0, 0, AT_SYMLINK_NOFOLLOW))
 			die("failure: change ownership");
-		if (errno != EINVAL)
+		if (errno != EINVAL && errno != EOVERFLOW)
 			die("failure: errno");
 
 		/*
@@ -7457,7 +7457,7 @@ static int setattr_fix_968219708108(const struct vfstest_info *info)
 		 */
 		if (!fchownat(open_tree_fd, FILE1, 0, 0, AT_SYMLINK_NOFOLLOW))
 			die("failure: change ownership");
-		if (errno != EINVAL)
+		if (errno != EINVAL && errno != EOVERFLOW)
 			die("failure: errno");
 
 		/*

base-commit: 890c50823b6430bf0929d9a57e76b9b4d6bbc25f
-- 
2.34.1

