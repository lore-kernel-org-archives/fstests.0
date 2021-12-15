Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFA43C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 15 Dec 2021 19:02:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239082AbhLOTCw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 15 Dec 2021 14:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbhLOTCw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 15 Dec 2021 14:02:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B0BC061574
        for <fstests@vger.kernel.org>; Wed, 15 Dec 2021 11:02:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AFF2BB82053
        for <fstests@vger.kernel.org>; Wed, 15 Dec 2021 19:02:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 274BCC36AE3;
        Wed, 15 Dec 2021 19:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639594969;
        bh=5qeCT7mdOKILoZKvOx3p2MkTNqkvF5wmF6OAgaLExz8=;
        h=From:To:Cc:Subject:Date:From;
        b=VWVpx1ch8siLOyRGMXVFuFHbYxAic7WY/58E8LKnKEXB0s8BMTLjR9f0hJQj4kx6H
         8+S1sSeRbF6oq+hNzVNYJrVX+PJstHngOkuXSv5IWMFOS+dqp9+YqQ65siRR6RB43/
         HqL76wVM6OUlmsPaeFSSo707MsK+BYTlSYVz0Ze6ku9pJDpAeVqs3xkGHaoK1s0XPo
         sWTzdFEyzzL6mTdeEZ3okmBVbFKCtg7VtyFmp0mCfOTbXOXT+nHLwZgrIAr2PXDcfe
         MUE/fSfKkyWjELmEf5H49E1AaQCSKDMikW3G4lCG+yXKGMO86ALTNx6U79PCwXfbId
         R+jlQYV5Qf/mQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     fstests@vger.kernel.org
Cc:     Luis Henriques <lhenriques@suse.de>
Subject: [PATCH v3] common/encrypt, ceph: add _require_not_encrypted test
Date:   Wed, 15 Dec 2021 14:02:48 -0500
Message-Id: <20211215190248.111263-1-jlayton@kernel.org>
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

Also add this requirement to three ceph tests that change the layout.

Cc: Luis Henriques <lhenriques@suse.de>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 common/encrypt | 18 ++++++++++++++++++
 tests/ceph/001 |  2 ++
 tests/ceph/002 |  2 ++
 tests/ceph/003 |  2 ++
 4 files changed, 24 insertions(+)

v2: make ceph/001 also call _require_not_encrypted

v3: move test into common/encrypt

diff --git a/common/encrypt b/common/encrypt
index f90c4ef05a3f..156425af40a8 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -940,3 +940,21 @@ _filter_nokey_filenames()
 	# of characters that have ever been used in such names.
 	sed "s|${dir}${dir:+/}[A-Za-z0-9+,_-]\+|${dir}${dir:+/}NOKEY_NAME|g"
 }
+
+# Some tests require that encryption not be enabled.
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
diff --git a/tests/ceph/001 b/tests/ceph/001
index c00de308fd95..d6ded026a6dd 100755
--- a/tests/ceph/001
+++ b/tests/ceph/001
@@ -17,11 +17,13 @@ _begin_fstest auto quick copy_range
 . common/filter
 . common/attr
 . common/reflink
+. common/encrypt
 
 # real QA test starts here
 _supported_fs ceph
 
 _require_xfs_io_command "copy_range"
+_require_not_encrypted
 _require_attrs
 _require_test
 
diff --git a/tests/ceph/002 b/tests/ceph/002
index 9bc728fd2e18..2232b75e6dfa 100755
--- a/tests/ceph/002
+++ b/tests/ceph/002
@@ -25,11 +25,13 @@ _begin_fstest auto quick copy_range
 # get standard environment
 . common/filter
 . common/attr
+. common/encrypt
 
 # real QA test starts here
 _supported_fs ceph
 
 _require_xfs_io_command "copy_range"
+_require_not_encrypted
 _require_attrs
 _require_test
 
diff --git a/tests/ceph/003 b/tests/ceph/003
index faedb48cfeea..aa130ae807f9 100755
--- a/tests/ceph/003
+++ b/tests/ceph/003
@@ -13,11 +13,13 @@ _begin_fstest auto quick copy_range
 . common/filter
 . common/attr
 . common/reflink
+. common/encrypt
 
 # real QA test starts here
 _supported_fs ceph
 
 _require_xfs_io_command "copy_range"
+_require_not_encrypted
 _require_attrs
 _require_test
 
-- 
2.33.1

