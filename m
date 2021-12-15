Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CF7C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Dec 2021 14:20:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237641AbhLOOUv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Dec 2021 09:20:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbhLOOUv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Dec 2021 09:20:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4412DC061574
        for <fstests@vger.kernel.org>; Wed, 15 Dec 2021 06:20:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E0F3B81F2A
        for <fstests@vger.kernel.org>; Wed, 15 Dec 2021 14:20:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908A7C34604;
        Wed, 15 Dec 2021 14:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639578048;
        bh=I9KLDWCUW+tfe+5Z0LXVsY9JtoFVzaw4Nz2Dm6mRo3k=;
        h=From:To:Cc:Subject:Date:From;
        b=Pul/JzfwGlrl8Ak3R7Jlo3XU7wp+e0VwIgHaPmr+k+FGl8DuQQloFWt9PHhB9NU75
         M3JeerwIoCx8MP0K2UtsMOAbxTd0thz/XWa4TcV4RN+7bJ6gWC6oZFJSRmZdxFH2+m
         lR0S+A8ssWtMyEn7L3xSIUdhWqWxzU8y1BZ4qtgSc2X161bbNO9iwmugsD5ad6hN2o
         onAzGiFmrq4dADuJ4p7QIcpKea6hhXahDm4++TKrS7x4O/8N8JRVEaGgQrJl9KMuIJ
         3VAmWO9ewqkTS1A0ghnKwaURs7I6g9CiMxdzV4QVDcTMeth2PbTBCIYhJmRBuTnMnP
         HZ/QPnE4bkBDg==
From:   Jeff Layton <jlayton@kernel.org>
To:     fstests@vger.kernel.org
Cc:     Luis Henriques <lhenriques@suse.de>
Subject: [PATCH] common/rc, ceph: add _require_not_encrypted test
Date:   Wed, 15 Dec 2021 09:20:47 -0500
Message-Id: <20211215142047.66403-1-jlayton@kernel.org>
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
 tests/ceph/002 |  1 +
 tests/ceph/003 |  1 +
 3 files changed, 19 insertions(+)

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

