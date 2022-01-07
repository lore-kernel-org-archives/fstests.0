Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9783FC433FE
	for <linux-fstests@archiver.kernel.org>; Fri,  7 Jan 2022 14:58:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347928AbiAGO6a (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 7 Jan 2022 09:58:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347927AbiAGO63 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 7 Jan 2022 09:58:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AFEC061574
        for <fstests@vger.kernel.org>; Fri,  7 Jan 2022 06:58:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44A286155E
        for <fstests@vger.kernel.org>; Fri,  7 Jan 2022 14:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DFD6C36AE0;
        Fri,  7 Jan 2022 14:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641567508;
        bh=UqiTKUFe4ld9bkGtzzNrxwwqczDoc/0mCPFR43LJycw=;
        h=From:To:Cc:Subject:Date:From;
        b=dN5Dr7oE1CqSN/lciw42zGQwtE871jsd0F3QvMQ/97d79lw1oh2thqekRCASpmt72
         IclxCGnDX91L4BUhTPDL9KwWnEHUcrA/pPNRjzTaiIl2lKf2PsSTNQtomMqkqjMf8V
         HXn3sLSaxEg8KCNZi7YiGdaWPr9X6CvnRrZGujuu9VrMGBdDehBp0SHbn6i9Ey2ySN
         2jH8Mvf9YUNSgxNRGdV+OD7CiOIOnsOsLz5XZ0L1ELEtGa9zhXoguSILCPacUozrXH
         /ncwsFWn8hZTDeJEnK8qA21ml/YEWip5RchYzc9T7YAObu+GZtKzaNMaLoq83p3kCJ
         iC7tLIVmoVpVw==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>
Cc:     Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christian Brauner <brauner@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>
Subject: [PATCH 1/3] idmapped-mounts: remove redundant fchownat() call in setgid tests
Date:   Fri,  7 Jan 2022 15:58:16 +0100
Message-Id: <20220107145818.336126-1-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1090; h=from:subject; bh=UqiTKUFe4ld9bkGtzzNrxwwqczDoc/0mCPFR43LJycw=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTeCGX2SN2hvPg+zwcOm7wzjaocCh72i9etFFHoEP3T+eji 2tYtHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNpEGZkWBfPL7BmCe9U5/kOV48Vvl Hb2BnKHduz461UpODBw4qnMhn+1548ZrtR1frU4q2K5pc67/T89v1zb96zDaL7n53qn5mUzAoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

There's another call to fchownat() right above it so we really don't
need the second one.

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

