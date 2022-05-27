Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 769F2C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 27 May 2022 12:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349339AbiE0Mbo (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 27 May 2022 08:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239376AbiE0Mbj (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 27 May 2022 08:31:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A0DA451
        for <fstests@vger.kernel.org>; Fri, 27 May 2022 05:11:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAAEC60B3C
        for <fstests@vger.kernel.org>; Fri, 27 May 2022 12:11:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 850AAC385A9;
        Fri, 27 May 2022 12:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653653478;
        bh=2AzqA5vrp36vrBYb2zP4mf/SGTDnFI0ePuJ1prbWTuY=;
        h=From:To:Cc:Subject:Date:From;
        b=QfRvlahDH3bCkRjSr68xok/sWyjUc10QxWDkjaW022LLfNo4qkN0qV3BPOVhNdS9d
         sR93/kbnxhxh1G+X7ie6fC0Ov0xe2Kthh13e2tgPv2i5itvA8JnsCr7h4PECJShFv5
         LY8lHJ8RkmYUZz7x8i1EYLz+MwpEzFXi12MxaraGT0OeD20/WWtVswvucxobBpynxS
         o/J6ek/DeH+0i+gVd2Gj0y7Js72cKcv4OWH9dz6YWvcdpllv/vgfRLO8FqVt5KBkiC
         jhpmVcOcnPmFaGpELbOXNUPy51Vbt9JsrL6lyGEVVwZbPHNIphVmdD9od0DNrC30J5
         P75DKZgOs8JXw==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Cc:     david@fromorbit.com
Subject: [PATCH v2] common/filter: filter out extra mount error output
Date:   Fri, 27 May 2022 20:11:15 +0800
Message-Id: <20220527121115.34358-1-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The lastest mount command (from util-linux) merged below commit:
  79534c0d7e0f ("mount: add hint about dmesg(8) to error messages")
which brought in a new error output when mount fails, no matter
ro/rw/busy mount fails.

That cause some cases (e.g. xfs/005) fail as:
  mount: Structure needs cleaning
         dmesg(1) may have more information after failed mount system call

More failed cases like generic/050, ext4/002, xfs/154, xfs/158 etc.
Especially xfs/154 and xfs/158, need to change their _filter_scratch
to _filter_error_mount.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---

Thanks the review points from Dave. This V2 turn to filter out the error in
_filter_error/ro/busy_mount. And change xfs/154 and xfs/158 to use
_filter_error_mount.

Thanks,
Zorro

 common/filter     | 13 +++++++++++--
 tests/xfs/154     |  2 +-
 tests/xfs/154.out |  2 +-
 tests/xfs/158     |  2 +-
 tests/xfs/158.out |  2 +-
 5 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/common/filter b/common/filter
index a6a42b7a..14f6a027 100644
--- a/common/filter
+++ b/common/filter
@@ -380,6 +380,8 @@ _filter_ending_dot()
 # ancient:	   mount: cannot remount block device <device> read-write, is write-protected
 # prior to v2.30:  mount: cannot remount <device> read-write, is write-protected
 # v2.30 and later: mount: <mountpoint>: cannot remount <device> read-write, is write-protected.
+# v2.38 and later:
+# dmesg(1) may have more information after failed mount mount system call
 #
 # Now use _filter_ro_mount to unify all these differences across old & new
 # util-linux versions. So the filtered format would be:
@@ -412,7 +414,8 @@ _filter_ro_mount() {
 		print "mount: cannot remount device read-write, is write-protected\n";
 	} else {
 		print "$_";
-	}' | _filter_ending_dot
+	}' | grep -v "dmesg(1) may have more information after failed mount" | \
+	_filter_ending_dot
 }
 
 # Filter a failed mount output due to EUCLEAN and USTALE, util-linux changed
@@ -424,6 +427,8 @@ _filter_ro_mount() {
 # mount: mount <device> on <mountpoint> failed: Structure needs cleaning
 # v2.30 and later:
 # mount: <mountpoint>: mount(2) system call failed: Structure needs cleaning.
+# v2.38 and later:
+# dmesg(1) may have more information after failed mount mount system call
 #
 # This is also true for ESTALE error. So let's remove all the changing parts
 # and keep the 'prior to v2.21' format:
@@ -431,7 +436,8 @@ _filter_ro_mount() {
 # mount: Stale file handle
 _filter_error_mount()
 {
-	sed -e "s/mount:\(.*failed:\)/mount:/" | _filter_ending_dot
+	grep -v "dmesg(1) may have more information after failed mount" | \
+		sed -e "s/mount:\(.*failed:\)/mount:/" | _filter_ending_dot
 }
 
 # Similar to _filter_error_mount, filter a busy mount output.
@@ -440,8 +446,11 @@ _filter_error_mount()
 # old: mount: <device> is already mounted or <mountpoint> busy
 # new: mount: <mountpoint>: <device> already mounted or mount point busy.
 # filtered: mount: device already mounted or mount point busy
+# v2.38 and later, filter out:
+# dmesg(1) may have more information after failed mount mount system call
 _filter_busy_mount()
 {
+	grep -v "dmesg(1) may have more information after failed mount" | \
 	sed -e "s/.*: .* already mounted or .* busy/mount: device already mounted or mount point busy/" | \
 		_filter_ending_dot
 }
diff --git a/tests/xfs/154 b/tests/xfs/154
index 3f90a397..548c9490 100755
--- a/tests/xfs/154
+++ b/tests/xfs/154
@@ -48,7 +48,7 @@ test $? -eq 137 || echo "repair should have been killed??"
 _check_scratch_xfs_features NEEDSREPAIR
 _try_scratch_mount &> $tmp.mount
 res=$?
-_filter_scratch < $tmp.mount
+_filter_error_mount < $tmp.mount
 if [ $res -eq 0 ]; then
 	echo "Should not be able to mount after needsrepair crash"
 	_scratch_unmount
diff --git a/tests/xfs/154.out b/tests/xfs/154.out
index 12f154ab..1263f091 100644
--- a/tests/xfs/154.out
+++ b/tests/xfs/154.out
@@ -1,4 +1,4 @@
 QA output created by 154
 FEATURES: NEEDSREPAIR:YES
-mount: SCRATCH_MNT: mount(2) system call failed: Structure needs cleaning.
+mount: Structure needs cleaning
 FEATURES: NEEDSREPAIR:NO
diff --git a/tests/xfs/158 b/tests/xfs/158
index 505a9c73..4440adf6 100755
--- a/tests/xfs/158
+++ b/tests/xfs/158
@@ -51,7 +51,7 @@ test $? -eq 137 || echo "repair should have been killed??"
 _check_scratch_xfs_features NEEDSREPAIR INOBTCNT
 _try_scratch_mount &> $tmp.mount
 res=$?
-_filter_scratch < $tmp.mount
+_filter_error_mount < $tmp.mount
 if [ $res -eq 0 ]; then
 	echo "needsrepair should have prevented mount"
 	_scratch_unmount
diff --git a/tests/xfs/158.out b/tests/xfs/158.out
index 4f9dfd08..5461031a 100644
--- a/tests/xfs/158.out
+++ b/tests/xfs/158.out
@@ -8,7 +8,7 @@ FEATURES: INOBTCNT:NO
 Fail partway through upgrading
 Adding inode btree counts to filesystem.
 FEATURES: NEEDSREPAIR:YES INOBTCNT:YES
-mount: SCRATCH_MNT: mount(2) system call failed: Structure needs cleaning.
+mount: Structure needs cleaning
 Re-run repair to finish upgrade
 FEATURES: NEEDSREPAIR:NO INOBTCNT:YES
 Filesystem should be usable again
-- 
2.31.1

