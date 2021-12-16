Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF87CC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 16 Dec 2021 12:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbhLPMr4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 16 Dec 2021 07:47:56 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:43522 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236919AbhLPMr4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 16 Dec 2021 07:47:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30497B8240F
        for <fstests@vger.kernel.org>; Thu, 16 Dec 2021 12:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C6AC36AE3;
        Thu, 16 Dec 2021 12:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639658874;
        bh=i3t8FzzHlzhi6PInLHIheJZxTdAr5q0TmZt2WjNKUNw=;
        h=From:To:Cc:Subject:Date:From;
        b=tq1dsdaH3f6FNJFPSqPYM6zG4mIyMxBCZS1RDkcWOuZbVNM2mCmqEs2QOngoI5hQf
         wKh/uMqNqa1G8EDHIXw6m8riQ48ZzwaDJ4Eo+x3K/wjaR3LK+lIGLKlXRbX3YtbnsR
         BjPA3GSUq/Xzvzi44ZCHR/YFrz1zKydjaEFke2lv6YmDVrMtdNwbHXzJiIS/T/u2TA
         R+xiv/M/YlrUtZGqQatqiBCLshs2W3tIRIvHWvUKVQHWihOD+FgVrcrf9Pvh5terZn
         7dktH3JJFCnbCsM5zC4IjlYhMRUWaVfpUZvo65BlfA7TI2aFK+ted6GaORgB3EAT9N
         Bu8u1BakvKSdw==
From:   Jeff Layton <jlayton@kernel.org>
To:     fstests@vger.kernel.org
Cc:     ebiggers@kernel.org, guan@eryu.me,
        Luis Henriques <lhenriques@suse.de>
Subject: [PATCH] common/rc, ceph: skip ceph/001-ceph/003 if test_dummy_encryption is enabled
Date:   Thu, 16 Dec 2021 07:47:52 -0500
Message-Id: <20211216124752.13768-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Some tests on ceph require changing the layout of new files, which is
forbidden when the files are encrypted. Skip these tests if the
test_dummy_encryption mount option is being used.

Generalize the _exclude_scratch_mount_option code and add a new
_exclude_test_mount_option call as well. Call the new function from the
ceph tests that should exclude test_dummy_encryption.

Cc: Luis Henriques <lhenriques@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 common/rc      | 18 ++++++++++++++----
 tests/ceph/001 |  1 +
 tests/ceph/002 |  1 +
 tests/ceph/003 |  1 +
 4 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/common/rc b/common/rc
index 7973ceb5fdf8..312ebea8fb57 100644
--- a/common/rc
+++ b/common/rc
@@ -3844,14 +3844,14 @@ _require_cloner()
 # "opt1 opt2 opt3"
 _normalize_mount_options()
 {
-	echo $MOUNT_OPTIONS | sed -n 's/-o\s*\(\S*\)/\1/gp'| sed 's/,/ /g'
+	echo "$1" | sed -n 's/-o\s*\(\S*\)/\1/gp'| sed 's/,/ /g'
 }
 
-# skip test if MOUNT_OPTIONS contains the given strings
+# skip test if $2 contains the given strings in $1
 # Both dax and dax=always are excluded if dax or dax=always is passed
-_exclude_scratch_mount_option()
+_exclude_mount_option()
 {
-	local mnt_opts=$(_normalize_mount_options)
+	local mnt_opts=$(_normalize_mount_options "$2")
 
 	while [ $# -gt 0 ]; do
 		local pattern=$1
@@ -3864,6 +3864,16 @@ _exclude_scratch_mount_option()
 	done
 }
 
+_exclude_scratch_mount_option()
+{
+	_exclude_mount_option "$1" "$MOUNT_OPTIONS"
+}
+
+_exclude_test_mount_option()
+{
+	_exclude_mount_option "$1" "$TEST_FS_MOUNT_OPTS"
+}
+
 _require_atime()
 {
 	_exclude_scratch_mount_option "noatime"
diff --git a/tests/ceph/001 b/tests/ceph/001
index c00de308fd95..5a828567d500 100755
--- a/tests/ceph/001
+++ b/tests/ceph/001
@@ -22,6 +22,7 @@ _begin_fstest auto quick copy_range
 _supported_fs ceph
 
 _require_xfs_io_command "copy_range"
+_exclude_test_mount_option "test_dummy_encryption"
 _require_attrs
 _require_test
 
diff --git a/tests/ceph/002 b/tests/ceph/002
index 9bc728fd2e18..ac3d65b529bd 100755
--- a/tests/ceph/002
+++ b/tests/ceph/002
@@ -30,6 +30,7 @@ _begin_fstest auto quick copy_range
 _supported_fs ceph
 
 _require_xfs_io_command "copy_range"
+_exclude_test_mount_option "test_dummy_encryption"
 _require_attrs
 _require_test
 
diff --git a/tests/ceph/003 b/tests/ceph/003
index faedb48cfeea..2d6cb393b3f6 100755
--- a/tests/ceph/003
+++ b/tests/ceph/003
@@ -18,6 +18,7 @@ _begin_fstest auto quick copy_range
 _supported_fs ceph
 
 _require_xfs_io_command "copy_range"
+_exclude_test_mount_option "test_dummy_encryption"
 _require_attrs
 _require_test
 
-- 
2.33.1

