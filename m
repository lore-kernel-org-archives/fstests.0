Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1C1FC433EF
	for <linux-fstests@archiver.kernel.org>; Thu,  6 Jan 2022 13:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239524AbiAFNay (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 6 Jan 2022 08:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230323AbiAFNay (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 6 Jan 2022 08:30:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD114C061245
        for <fstests@vger.kernel.org>; Thu,  6 Jan 2022 05:30:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 72BF5B8214F
        for <fstests@vger.kernel.org>; Thu,  6 Jan 2022 13:30:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA01C36AE3;
        Thu,  6 Jan 2022 13:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641475851;
        bh=g5XINOTeJvNQh2KkS+WnSfJlGd1e0FGR+fr43LLsLMM=;
        h=From:To:Cc:Subject:Date:From;
        b=YWux+OQNnE8+iqQ9+8hIaCTlzyy2LQ1Nc26TNA7bRZdCm4MXrFAx596+X17wddal1
         IZMQ47+TdgdvdTB37bDbGVsz7bRORuGxlSg+W74v4uUQmfjD0eY6IilYnM2jmPaQX7
         hd+gfDhIkXahXs8y9PjtBw45tRVWFIw9QIDk++03BxpfWhl10oWjr8UvaUzPzbnivF
         /ulcPeFUkLuN3UJlfKH8F1s4orz2I3nYWnSktsh3+NvUUBeybjh3d+7iqQuHhNIerC
         y5p60cUoxmJa+dVy8MWpiqVPfC1utG1ZtWVQLecqayOcD+120NbX5wMc8Ma7MMtSfY
         W/8Jrm2748jKA==
From:   Jeff Layton <jlayton@kernel.org>
To:     fstests@vger.kernel.org
Cc:     guan@eryu.me, Luis Henriques <lhenriques@suse.de>,
        Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH v2] common/rc, ceph: skip ceph/001-ceph/003 if test_dummy_encryption is enabled
Date:   Thu,  6 Jan 2022 08:30:49 -0500
Message-Id: <20220106133049.68171-1-jlayton@kernel.org>
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
Cc: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 common/btrfs   |  2 +-
 common/rc      | 28 +++++++++++++++++++---------
 tests/ceph/001 |  1 +
 tests/ceph/002 |  1 +
 tests/ceph/003 |  1 +
 5 files changed, 23 insertions(+), 10 deletions(-)

Thanks to Eric and Luis for review so far!

v2: fix argument handling in _exclude_mount_option
    fix _require_btrfs_no_compress
    ensure _normalize_mount_options callers pass correct argument
    
diff --git a/common/btrfs b/common/btrfs
index fe5985663ab4..4afe81eb2dfb 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -115,7 +115,7 @@ _require_btrfs_fs_sysfs()
 
 _require_btrfs_no_compress()
 {
-	if _normalize_mount_options | grep -q "compress"; then
+	if _normalize_mount_options "$MOUNT_OPTIONS" | grep -q "compress"; then
 		_notrun "This test requires no compression enabled"
 	fi
 }
diff --git a/common/rc b/common/rc
index 341abc9a0d02..0c985d0f2952 100644
--- a/common/rc
+++ b/common/rc
@@ -2039,7 +2039,7 @@ _require_sane_bdev_flush()
 # Returns 0 if DAX will be used, 1 if DAX is not going to be used.
 __scratch_uses_fsdax()
 {
-	local ops=$(_normalize_mount_options)
+	local ops=$(_normalize_mount_options "$MOUNT_OPTIONS")
 
 	echo $ops | egrep -qw "dax(=always| |$)" && return 0
 	echo $ops | grep -qw "dax=never" && return 1
@@ -3718,7 +3718,7 @@ _has_metadata_journaling()
 			return 1
 		}
 		# ext4 might not load a journal
-		if _normalize_mount_options | grep -qw "noload"; then
+		if _normalize_mount_options "$MOUNT_OPTIONS" | grep -qw "noload"; then
 			echo "mount option \"noload\" not allowed in this test"
 			return 1
 		fi
@@ -3882,20 +3882,20 @@ _require_cloner()
 		_notrun "cloner binary not present at $CLONER_PROG"
 }
 
-# Normalize mount options from global $MOUNT_OPTIONS
-# Convert options like "-o opt1,opt2 -oopt3" to
-# "opt1 opt2 opt3"
+# Normalize mount options from the option string in $1
+# Convert options like "-o opt1,opt2 -oopt3" to "opt1 opt2 opt3"
 _normalize_mount_options()
 {
-	echo $MOUNT_OPTIONS | sed -n 's/-o\s*\(\S*\)/\1/gp'| sed 's/,/ /g'
+	echo "$1" | sed -n 's/-o\s*\(\S*\)/\1/gp'| sed 's/,/ /g'
 }
 
-# skip test if MOUNT_OPTIONS contains the given strings
+# skip test if $1 contains the given strings in trailing arguments
 # Both dax and dax=always are excluded if dax or dax=always is passed
-_exclude_scratch_mount_option()
+_exclude_mount_option()
 {
-	local mnt_opts=$(_normalize_mount_options)
+	local mnt_opts=$(_normalize_mount_options "$1")
 
+	shift
 	while [ $# -gt 0 ]; do
 		local pattern=$1
 		echo "$pattern" | egrep -q "dax(=always|$)" && \
@@ -3907,6 +3907,16 @@ _exclude_scratch_mount_option()
 	done
 }
 
+_exclude_scratch_mount_option()
+{
+	_exclude_mount_option "$MOUNT_OPTIONS" $@
+}
+
+_exclude_test_mount_option()
+{
+	_exclude_mount_option "$TEST_FS_MOUNT_OPTS" $@
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

