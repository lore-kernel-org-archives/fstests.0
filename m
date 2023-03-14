Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFE4C7618D
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Mar 2023 11:46:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCNLqQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Mar 2023 07:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjCNLqO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Mar 2023 07:46:14 -0400
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AA2166CB
        for <fstests@vger.kernel.org>; Tue, 14 Mar 2023 04:45:39 -0700 (PDT)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 14 Mar 2023 11:45:35 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH v4 0/9] Tests for idmapped tmpfs
Date:   Tue, 14 Mar 2023 12:45:02 +0100
Message-Id: <20230314114511.128207-1-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi!

This patches add tests for tmpfs idmap mounts inside a userns.

Changes in v4 affect only patch 9:
	* Fix copyright in the Makefile and in the file: tests/tmpfs/001
	* Removed empty blank line at the end of tmpfs-idmapped-mounts.h
	* Fix Makefile TARGET_DIR


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
 src/vfs/tmpfs-idmapped-mounts.h |  14 ++
 src/vfs/utils.c                 |  19 +-
 src/vfs/utils.h                 |   4 +-
 src/vfs/vfstest.c               |  19 +-
 src/vfs/vfstest.h               |  10 ++
 tests/tmpfs/001                 |  27 +++
 tests/tmpfs/001.out             |   2 +
 tests/tmpfs/Makefile            |  24 +++
 12 files changed, 519 insertions(+), 87 deletions(-)
 create mode 100644 src/vfs/tmpfs-idmapped-mounts.c
 create mode 100644 src/vfs/tmpfs-idmapped-mounts.h
 create mode 100644 src/vfs/vfstest.h
 create mode 100755 tests/tmpfs/001
 create mode 100644 tests/tmpfs/001.out
 create mode 100644 tests/tmpfs/Makefile

-- 
2.39.2

