Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E63C636CC
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Feb 2023 07:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjBHHEO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Feb 2023 02:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjBHHDq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Feb 2023 02:03:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FEF457D1
        for <fstests@vger.kernel.org>; Tue,  7 Feb 2023 23:01:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F144CB81C3A
        for <fstests@vger.kernel.org>; Wed,  8 Feb 2023 07:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FF8DC433EF;
        Wed,  8 Feb 2023 07:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675839706;
        bh=tvH7qbRPVT02/Z1qAVam/0DyXzhQHXSwPG+2Eo/qDMc=;
        h=From:To:Cc:Subject:Date:From;
        b=oCp11Fp9ya9vyhDPj6YqAy9H4hXao/1vIL1q97TtWJM+IbpyKQ5zkGyKIW6DL8ZFM
         7FSeCptgq2ey3ROMNjjnewxcwe4JezVjO9gqY4le/H1EIfPQEZCAig1OGk+H1QPGaD
         UgpMg91MU3FcMaE8xLtFG1+NuJSY2iIGIs31x9pWmkZPTNDkmMpTouDcRunFUquXPf
         d0m0WsqwS61VbFF5AlxAeKJkCK2qdOV3+MEGoGm04fCS4JuVibf/8q5oboD4aA75Em
         fmC/rcvlkYL3PeJ7cYq4+f1ZJK1pUQspjIZxtcgHAgDMTmeNc5/nRgf+D6gDHR8JUF
         IH7rV1L6vaPSQ==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: [xfstests-bld PATCH] fstests-bld: use new git repo URL for fsverity-utils
Date:   Tue,  7 Feb 2023 23:01:29 -0800
Message-Id: <20230208070129.229178-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

See the announcement at "[ANNOUNCE] Moving the fsverity-utils git repo"
(https://lore.kernel.org/r/Y9GKm+hcm70myZkr@sol.localdomain).

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fstests-bld/config        | 2 +-
 fstests-bld/config.docker | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fstests-bld/config b/fstests-bld/config
index 5308027..6fe916a 100644
--- a/fstests-bld/config
+++ b/fstests-bld/config
@@ -6,7 +6,7 @@ XFSTESTS_GIT=https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git
 XFSPROGS_GIT=https://git.kernel.org/pub/scm/fs/xfs/xfsprogs-dev.git
 FIO_GIT=http://git.kernel.dk/fio.git
 QUOTA_GIT=https://git.kernel.org/pub/scm/utils/quota/quota-tools.git
-FSVERITY_GIT=https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/fsverity-utils.git/
+FSVERITY_GIT=https://git.kernel.org/pub/scm/fs/fsverity/fsverity-utils.git
 BLKTESTS_GIT=https://github.com/osandov/blktests.git
 
 # Optional repositories, uncomment only if needed
diff --git a/fstests-bld/config.docker b/fstests-bld/config.docker
index 780b73a..678cbee 100644
--- a/fstests-bld/config.docker
+++ b/fstests-bld/config.docker
@@ -12,7 +12,7 @@ QUOTA_COMMIT=d2256ac2d44b0a5be9c0b49ce4ce8e5f6821ce2a
 # SYZKALLER_GIT=https://github.com/google/syzkaller
 # SYZKALLER_COMMIT=2f93b54f26aa40233a0a584ce8714e55c8dd159a
 
-FSVERITY_GIT=https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/fsverity-utils.git/
+FSVERITY_GIT=https://git.kernel.org/pub/scm/fs/fsverity/fsverity-utils.git
 FSVERITY_COMMIT=ddc6bc9daeb79db932aa12edb85c7c2f4647472a
 
 IMA_EVM_UTILS_GIT=https://git.code.sf.net/p/linux-ima/ima-evm-utils.git
-- 
2.39.1

