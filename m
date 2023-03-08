Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AD0C64EC4
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Mar 2023 11:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbjCHLOT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Mar 2023 06:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbjCHLOM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Mar 2023 06:14:12 -0500
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF642567A0
        for <fstests@vger.kernel.org>; Wed,  8 Mar 2023 03:14:07 -0800 (PST)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Wed, 08 Mar 2023 11:14:01 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH v2 0/9] Tests for idmapped tmpfs
Date:   Wed,  8 Mar 2023 12:13:34 +0100
Message-Id: <20230308111343.510970-1-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patches add tests for tmpfs idmap mounts inside a userns.

Changes in v2:
	* Added reviewed-by Christian to some patches
	* Clarified commit description on "Fix race condition on get_userns_fd"
	  and removed the noreturn attribute in the function
        * As noted by Christian, we can makedev(0,0) and have that work inside a
          userns. So, simplified patch 6 for that
	* Fixed typo in the #endif comment of vfstest.h
	* Folded adding DIR0 constant into the patch that uses it
	* Fixed the indentation patch to only change one line and not change the
	  usage() section

Similar as before, the first patches are just unrelated simple fixes that I saw
while playing with this:
  vfs: Don't open-code safe_close()
  vfs: Fix documentation typo
  vfs: Use tabs to indent, not spaces
  vfs: Fix race condition on get_userns_fd()

These pave the way to support running core tests within another test (from the
tmpfs suite that we will add):
  vfs: Fix race condition on get_userns_fd()
  vfs: Make switch_userns set PR_SET_DUMPABLE
  vfs: Prepare tests in &s_idmapped_mounts to be reused inside a userns
  vfs: Make idmapped core tests public
  vfs: Export test_setup() and test_cleanup()

As mentioned in the changelog, "vfs: Prepare tests in &s_idmapped_mounts to be
reused inside a userns" is now simplified. Changing only these few places to
mkdev(0, 0) did the trick. These tests are doing a switch_fsids() and that
inside the userns fails if we don't use 0:0 as major/minor.

Just to be super careful, I'd like if Christian can have a look and see if
indeed the places that mknod fails inside a userns and don't make sense.

Can you please take a look at that, Christian? I'm in a hurry and have to catch
a train in a few minutes.

Finally, the suite for idmapped tmpfs is implemented here:
  vfs: Add tmpfs tests for idmap mounts


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
 src/vfs/tmpfs-idmapped-mounts.c | 298 ++++++++++++++++++++++++++++++++
 src/vfs/tmpfs-idmapped-mounts.h |  15 ++
 src/vfs/utils.c                 |  19 +-
 src/vfs/utils.h                 |   4 +-
 src/vfs/vfstest.c               |  19 +-
 src/vfs/vfstest.h               |  10 ++
 tests/tmpfs/001                 |  27 +++
 tests/tmpfs/001.out             |   2 +
 tests/tmpfs/Makefile            |  24 +++
 12 files changed, 513 insertions(+), 87 deletions(-)
 create mode 100644 src/vfs/tmpfs-idmapped-mounts.c
 create mode 100644 src/vfs/tmpfs-idmapped-mounts.h
 create mode 100644 src/vfs/vfstest.h
 create mode 100755 tests/tmpfs/001
 create mode 100644 tests/tmpfs/001.out
 create mode 100644 tests/tmpfs/Makefile

-- 
2.39.2

