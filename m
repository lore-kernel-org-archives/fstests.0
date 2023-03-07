Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBDEC678D5
	for <linux-fstests@archiver.kernel.org>; Tue,  7 Mar 2023 12:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231183AbjCGMFX (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 7 Mar 2023 07:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbjCGMFX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Mar 2023 07:05:23 -0500
X-Greylist: delayed 1144 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Mar 2023 04:05:19 PST
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA64D32522
        for <fstests@vger.kernel.org>; Tue,  7 Mar 2023 04:05:19 -0800 (PST)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Tue, 07 Mar 2023 11:45:38 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH 00/11] Tests for idmapped tmpfs
Date:   Tue,  7 Mar 2023 12:44:56 +0100
Message-Id: <20230307114507.332309-1-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Hi!

This patches add tests for tmpfs idmap mounts inside a userns.

Linux 6.3 added idmap mounts support for tmpfs and while the core tests pass and
cover a lot, tmpfs also supports to create an idmap mount inside a userns. So
here we add tests for that: create a userns, mount tmpfs inside the userns, and
verify that all works as expected, even when we create an idmap mount of the
aforementioned tmpfs mount.

To verify that all works fine inside the userns with the tmpfs mount, I reuse
the core tests that exist today, that test extensively (symlinks, hardlinks,
mknod, fscaps, acls, etc.). To do that, there are basically two things:

        * Export core tests we use from tmpfs tests (so not static anymore, and
          add them to the .h)
	* Added a DIR0 constant and create a userns and mount a tmpfs in DIR0
	  (so existing tests using DIR1, DIR2, etc. just work fine) 
	* Create a struct vfstest_info to pass to the core test we call, with
	  the mountpoint and mnt_fd set to the DIR0 mount we just did.

This way, we can just reuse existing core tests from the tmpfs suite.

I'd like to see if there are more interesting tests we can add using tmpfs
specific options, but those are left for another time (I'm not sure, though,
there are more interesting things to test, as uid/gid options are automatically
used when mounting a tmpfs inside a userns).

The first 3 patches are just unrelated simple fixes that I saw while playing with
the code:
  vfs: Don't open-code safe_close()
  vfs: Fix documentation typo
  vfs: Fix race condition on get_userns_fd()

The next patches pave the way to create the tmpfs idmap suite:
  vfs: Make switch_userns set PR_SET_DUMPABLE
  vfs: Specify wether a test is run inside a userns or not
  vfs: Prepare tests in &s_idmapped_mounts to be reused inside a userns
  vfs: Make idmapped core tests public
  vfs: Export test_setup() and test_cleanup()
  vfs: Add DIR0 constant

These test just either fix some bugs that are not hit in the current code (but
we will hit in the tmpfs suite when nesting userns), export core tests, and add
the notion if a test is running inside a userns, in which case it skips
operations that will fail (like mknod on char devices).

Then, the tmpfs suite is added here:
  vfs: Add tmpfs tests for idmap mounts

As described already, it creates a userns, mounts a tmpfs and calls the core
tests we prepared for this. Nothing more, really.

And lastly, one small fix to be consistent and use tabs instead of spaces in the
little amount of places we were not doing that:
  vfs: Use tabs to indent, not spaces

I left this last as moving it to the beginning caused lot of conflicts.

I'll be afk soon, I can catch-up with the review comments next week.


Best,
Rodrigo

Rodrigo Campos (11):
  vfs: Don't open-code safe_close()
  vfs: Fix documentation typo
  vfs: Fix race condition on get_userns_fd()
  vfs: Make switch_userns set PR_SET_DUMPABLE
  vfs: Specify wether a test is run inside a userns or not
  vfs: Prepare tests in &s_idmapped_mounts to be reused inside a userns
  vfs: Make idmapped core tests public
  vfs: Export test_setup() and test_cleanup()
  vfs: Add DIR0 constant
  vfs: Add tmpfs tests for idmap mounts
  vfs: Use tabs to indent, not spaces

 src/vfs/Makefile                |   4 +-
 src/vfs/idmapped-mounts.c       | 190 ++++++++++----------
 src/vfs/idmapped-mounts.h       |  38 ++++
 src/vfs/tmpfs-idmapped-mounts.c | 299 ++++++++++++++++++++++++++++++++
 src/vfs/tmpfs-idmapped-mounts.h |  15 ++
 src/vfs/utils.c                 |  20 +--
 src/vfs/utils.h                 |   6 +-
 src/vfs/vfstest.c               |  46 +++--
 src/vfs/vfstest.h               |  10 ++
 tests/tmpfs/001                 |  27 +++
 tests/tmpfs/001.out             |   2 +
 tests/tmpfs/Makefile            |  24 +++
 12 files changed, 555 insertions(+), 126 deletions(-)
 create mode 100644 src/vfs/tmpfs-idmapped-mounts.c
 create mode 100644 src/vfs/tmpfs-idmapped-mounts.h
 create mode 100644 src/vfs/vfstest.h
 create mode 100755 tests/tmpfs/001
 create mode 100644 tests/tmpfs/001.out
 create mode 100644 tests/tmpfs/Makefile

-- 
2.39.2

