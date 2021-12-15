Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFF7C433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Dec 2021 17:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbhLORax (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Dec 2021 12:30:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:45934 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343579AbhLOR3q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Dec 2021 12:29:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09036B82029
        for <fstests@vger.kernel.org>; Wed, 15 Dec 2021 17:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 837BCC36AE0;
        Wed, 15 Dec 2021 17:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639589382;
        bh=iHydJ9QHorSWRhgpQ0WpUKQVibmGYr5OZkg2slw4/BI=;
        h=From:To:Cc:Subject:Date:From;
        b=s5vDKeXOv8FEVelB2i6+lWQzaa6joB5A/vcpj4hqZKtyK31yWp7L03eQF4+bMrX65
         TI2UHYdCsBambZlI0zibkFW/SuTHYX1tgZ3UXXxhtjulsypVK7se8GukOKtSURcmM+
         PEYbRkFuUQmVMxM4LTA3VH4Z1tS1jJZCGf2E/vFzixmnUQdIUI75gA28FEf9X7pEwO
         uKAgooKB4c+5PpeBQsZx7aXhCRUfbMfF91h+oiOe2/vJsa4u2Yl53CaL8q5LR1lPC6
         K16SpeM77qPOMjEV+jCtzQdej65mJp+1PB7Bazl1b0HcRDqkIJwZUP34mJUFp3e41z
         9xVeltxJbyWdw==
From:   Jeff Layton <jlayton@kernel.org>
To:     fstests@vger.kernel.org
Cc:     Luis Henriques <lhenriques@suse.de>
Subject: [PATCH v2] common/rc, ceph: add _require_not_encrypted test
Date:   Wed, 15 Dec 2021 12:29:41 -0500
Message-Id: <20211215172941.89216-1-jlayton@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Some tests on ceph require changing the layout of new files, which is
forbidden when the files are encrypted. Add a test that touches a file
in $TEST_DIR and then tests it to see if it reports the
STATX_ATTR_ENCRYPTED flag, and does a _notrun if it's present.

Also add this requirement to the two ceph tests that change the layout.

Cc: Luis Henriques <lhenriques@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 common/rc      | 17 +++++++++++++++++
 tests/ceph/001 |  1 +
 tests/ceph/002 |  1 +
 tests/ceph/003 |  1 +
 4 files changed, 20 insertions(+)

v2: make ceph/001 also call _require_not_encrypted

diff --git a/common/rc b/common/rc
index 7973ceb5fdf8..9165325dc478 100644
--- a/common/rc
+++ b/common/rc
@@ -4782,6 +4782,23 @@ _require_kernel_config()
 	_has_kernel_config $1 || _notrun "Installed kernel not built with $1"
 }
 
+_require_not_encrypted()
+{
+	local target=$TEST_DIR/require_not_encrypted.$$
+	local ret=0
+
+	#
+	# The top-level directory mounted with test_dummy_encryption is not
+	# itself encrypted. Only new files and directories created under it
+	# are.
+	touch $target
+	local attrs=$($XFS_IO_PROG -c 'statx -r' $target | awk '/stat.attributes / { print $3 }')
+	rm -f $target
+
+	# STATX_ATTR_ENCRYPTED == 0x800
+	[ $(( attrs & 0x800 )) -eq 0 ] || _notrun "Filesystem is encrypted"
+}
+
 init_rc
 
 ################################################################################
diff --git a/tests/ceph/001 b/tests/ceph/001
index c00de308fd95..d92fb8fed95b 100755
--- a/tests/ceph/001
+++ b/tests/ceph/001
@@ -22,6 +22,7 @@ _begin_fstest auto quick copy_range
 _supported_fs ceph
 
 _require_xfs_io_command "copy_range"
+_require_not_encrypted
 _require_attrs
 _require_test
 
diff --git a/tests/ceph/002 b/tests/ceph/002
index 9bc728fd2e18..be5c0f8c644d 100755
--- a/tests/ceph/002
+++ b/tests/ceph/002
@@ -30,6 +30,7 @@ _begin_fstest auto quick copy_range
 _supported_fs ceph
 
 _require_xfs_io_command "copy_range"
+_require_not_encrypted
 _require_attrs
 _require_test
 
diff --git a/tests/ceph/003 b/tests/ceph/003
index faedb48cfeea..c8aefc4ad06f 100755
--- a/tests/ceph/003
+++ b/tests/ceph/003
@@ -18,6 +18,7 @@ _begin_fstest auto quick copy_range
 _supported_fs ceph
 
 _require_xfs_io_command "copy_range"
+_require_not_encrypted
 _require_attrs
 _require_test
 
-- 
2.33.1

