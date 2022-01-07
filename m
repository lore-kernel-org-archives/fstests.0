Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E3D4C433FE
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Jan 2022 14:44:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239550AbiAGOow (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Jan 2022 09:44:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41640 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347786AbiAGOov (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jan 2022 09:44:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8DB95B82658
        for <fstests@vger.kernel.org>; Fri,  7 Jan 2022 14:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A74C36AED;
        Fri,  7 Jan 2022 14:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641566689;
        bh=yiHZekh+My6I6Dsr7qCrnGaPbHwXRJKPt2BzIh/KqCE=;
        h=From:To:Cc:Subject:Date:From;
        b=kqd98Gg+z2BWF7rK1hZVGg9AQs0CCzKzcCNvkfdoxPqhpl6xRvmVGECWzKkNy8jwL
         nk8DM8bfJKK4LhI2pMDHMtqzGmQbH0+q3lsnulu8uuSjvpqIBpdhVW7iqXgz253b7N
         a/fgAGASYmZSZLpyBlnyTvcA2IcVlGTYwDbvMT0uZ3Hkdyf7iDROKSy+Vbsq9I6BJJ
         smTcI2xFq6tE/C2b89hb3f/uMj5ESrnkd7c1VSyJZn9tGLnuVY2hXHlbqrqprTIVPk
         iXFnax9RQHXF+R6LEhxdV1Gd+QqUf6nHtQhqVfv+R3MBT5JVYKXJt1Yzjbm9YRYFog
         cgCkodq0RUS7A==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>
Cc:     Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Seth Forshee <seth.forshee@digitalocean.com>,
        Eryu Guan <guaneryu@gmail.com>
Subject: [PATCH 1/3] idmapped-mounts: remove redundant fchownat() call in setgid tests
Date:   Fri,  7 Jan 2022 15:44:34 +0100
Message-Id: <20220107144436.332389-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=989; h=from:subject; bh=7lW0Hrl8ZzgXRWZJ9lwIG+B4TE+8J9GF0NFhmhtvsqE=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTeCHTe4LRtW8PzHh31JMbJijtW8bQxXgw4KX57eursD3bH D1063FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRj9IMfzi23PyjFLG08U+C9TRP37 sLNBSnndaM3zVjqZNI9Z+0DBZGhl3zdp1JKG+Jv3dV9/C128xRju/LvjL3TF1fI9WqdmCFJicA
X-Developer-Key: i=christian.brauner@ubuntu.com; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

There's another call to fchownat() right above it so we really don't
need the second one.

Cc: Seth Forshee <seth.forshee@digitalocean.com>
Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index da690779..56b26b0c 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -8133,11 +8133,6 @@ static int setgid_create_idmapped_in_userns(void)
 		goto out;
 	}
 
-	if (fchownat(t_dir1_fd, "", -1, 1000, AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) {
-		log_stderr("failure: fchownat");
-		goto out;
-	}
-
 	pid = fork();
 	if (pid < 0) {
 		log_stderr("failure: fork");

base-commit: 770f462e17e52c4b2bc026fd707ad01fcce95f32
-- 
2.32.0

