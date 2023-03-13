Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44B7C7618B
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Mar 2023 19:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjCMTDx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Mar 2023 15:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231354AbjCMTDv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Mar 2023 15:03:51 -0400
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3443B1DB98
        for <fstests@vger.kernel.org>; Mon, 13 Mar 2023 12:03:49 -0700 (PDT)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Mon, 13 Mar 2023 19:03:44 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH v3 0/9] Tests for idmapped tmpfs
Date:   Mon, 13 Mar 2023 20:03:21 +0100
Message-Id: <20230313190330.94229-1-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi!

This patches add tests for tmpfs idmap mounts inside a userns.

Changes in v3:
	* In patch 9, changed the name of labels for goto. Now after we created
	  an fd, on error we "goto close", after a mkdir, we "goto rm", and so.
	  Before the labels were based on what operation we skipped, that was
	  not so clear when adding a "goto" to which label we should error out.
	* Added Reviewed-by Christian to the first 8 patches
	* Addressed all comments by Christian regarding patch 9, listed below:
	* Removed old reference in the commit msg to
	  "t_inside_userns", as that is not used anymore
	* Make the mount private
	* Use C89 declaration style (declare varaibles at the top of the
	  function)
	* Use "if (!x)" instead of "if (x == NULL)" for not asigned char* vars
	* Add missing space in an if

The only patch changed is the last one (module adding Reviewed-by tags).

I've kept the tabs vs space tabs just in case, but Zorro please feel free to
drop it (IIUC you prefer that?).


Thanks againg for your reviews!

Best,
Rodrigo


Rodrigo Campos (9):
  vfs: Don't open-code safe_close()
  vfs: Fix documentation typo
  vfs: Use tabs to indent, not spaces
  vfs: Fix race condition on get_userns_fd()
  vfs: Make switch_userns set PR_SET_DUMPABLE
  vfs: Prepare tests in &s_idmapped_mounts to be reused inside a userns
  vfs: Make idmapped core tests public
  vfs: Export test_setup() and test_cleanup()
  vfs: Add tmpfs tests for idmap mounts

 src/vfs/Makefile                |   4 +-
 src/vfs/idmapped-mounts.c       | 140 +++++++--------
 src/vfs/idmapped-mounts.h       |  38 ++++
 src/vfs/tmpfs-idmapped-mounts.c | 305 ++++++++++++++++++++++++++++++++
 src/vfs/tmpfs-idmapped-mounts.h |  15 ++
 src/vfs/utils.c                 |  19 +-
 src/vfs/utils.h                 |   4 +-
 src/vfs/vfstest.c               |  19 +-
 src/vfs/vfstest.h               |  10 ++
 tests/tmpfs/001                 |  27 +++
 tests/tmpfs/001.out             |   2 +
 tests/tmpfs/Makefile            |  24 +++
 12 files changed, 520 insertions(+), 87 deletions(-)
 create mode 100644 src/vfs/tmpfs-idmapped-mounts.c
 create mode 100644 src/vfs/tmpfs-idmapped-mounts.h
 create mode 100644 src/vfs/vfstest.h
 create mode 100755 tests/tmpfs/001
 create mode 100644 tests/tmpfs/001.out
 create mode 100644 tests/tmpfs/Makefile

-- 
2.39.2

