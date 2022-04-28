Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3C0C433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Apr 2022 15:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348935AbiD1PTp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 28 Apr 2022 11:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348919AbiD1PTp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Apr 2022 11:19:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB9BAF1F1
        for <fstests@vger.kernel.org>; Thu, 28 Apr 2022 08:16:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AB18EB82E10
        for <fstests@vger.kernel.org>; Thu, 28 Apr 2022 15:16:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B1CC385AE;
        Thu, 28 Apr 2022 15:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651158987;
        bh=KeCXrr3FeYA22vMQdWUUiQ6CdwbsF6BIAXDWdlmbS0w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E0P1kHOE1fKydKxSJLjiE0rUCY3Et7d7p4eURrlZ0yANacsr1gG7YpvTAWceiyp5j
         +RpQ8yS6ScGAIgQXXLKSGSzaOUyAyHSRRMUEclkPh8n3hZ4WLQ7648BwnX7hfvI+4p
         c7/MdU2v0igMtiXy5sxfX6jOjgID9I/Z4rbEb1UTwH5s2ca9KoeSOgL6AGUIM51nmn
         quk1Y+uQupxfn8/qLXCf0nKE/iBt0U/PIrYV7z0zUuqef8ewnc8yV0R2lPv5XkSU17
         5JLQ86SKDbTPX2jNdJn6F6qK3Jwm9s1z7DLDTmjgO2lZ+xbrkKFVcqNbD2zDhsrepF
         zg+HSGj5gv8Mw==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guaneryu@gmail.com>, Zorro Lang <zlang@redhat.com>,
        fstests <fstests@vger.kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 02/11] src/vfs: rename idmapped-mounts.c file
Date:   Thu, 28 Apr 2022 17:15:50 +0200
Message-Id: <20220428151559.947144-3-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220428151559.947144-1-brauner@kernel.org>
References: <20220428151559.947144-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8603; h=from:subject; bh=KeCXrr3FeYA22vMQdWUUiQ6CdwbsF6BIAXDWdlmbS0w=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRlrV+00HtqzfmJHUcu9KyeGF+966Bdj3mj5JcDDFnqE1TM GZYd7ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIxAaG/y4vyzf0rtT25d5iXsXhHf vmd+ElvbSNb1sPVzTavWQ0q2VkOFfNqsslopVh2FabIXP63pdlC8QEOFaLRtwurVDrk9rCAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The idmapped mounts test suite has grown to cover a lot of generic vfs
functionality that is not concerned with idmapped mounts at all.

As was discussed upstream it's time to rename it to something that
reflects its generic nature. So rename the source file from
idmapped-mounts.c to vfstest.c before we split it into multiple source
files in the next patches.

Cc: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests <fstests@vger.kernel.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 .gitignore                               |  2 +-
 common/rc                                |  8 ++++----
 src/vfs/Makefile                         |  8 ++++----
 src/vfs/{idmapped-mounts.c => vfstest.c} | 14 +++++++-------
 tests/btrfs/245                          |  2 +-
 tests/generic/633                        |  2 +-
 tests/generic/644                        |  2 +-
 tests/generic/645                        |  2 +-
 tests/generic/656                        |  2 +-
 tests/xfs/152                            |  2 +-
 10 files changed, 22 insertions(+), 22 deletions(-)
 rename src/vfs/{idmapped-mounts.c => vfstest.c} (99%)

diff --git a/.gitignore b/.gitignore
index b9e42635..88c79412 100644
--- a/.gitignore
+++ b/.gitignore
@@ -192,7 +192,7 @@ tags
 /src/aio-dio-regress/aio-last-ref-held-by-io
 /src/aio-dio-regress/aiocp
 /src/aio-dio-regress/aiodio_sparse2
-/src/vfs/idmapped-mounts
+/src/vfs/vfstest
 /src/vfs/mount-idmapped
 /src/log-writes/replay-log
 /src/perf/*.pyc
diff --git a/common/rc b/common/rc
index b0940872..dec6a715 100644
--- a/common/rc
+++ b/common/rc
@@ -2287,18 +2287,18 @@ _require_mount_setattr()
 # test whether idmapped mounts are supported
 _require_idmapped_mounts()
 {
-        IDMAPPED_MOUNTS_TEST=$here/src/vfs/idmapped-mounts
-        [ -x $IDMAPPED_MOUNTS_TEST ] || _notrun "idmapped-mounts utilities required"
+        IDMAPPED_MOUNTS_TEST=$here/src/vfs/vfstest
+        [ -x $IDMAPPED_MOUNTS_TEST ] || _notrun "vfstest utilities required"
 
 	_require_mount_setattr
 
-	$here/src/vfs/idmapped-mounts --supported \
+	$here/src/vfs/vfstest --idmapped-mounts-supported \
 		--device "$TEST_DEV" \
 		--mount "$TEST_DIR" \
 		--fstype "$FSTYP"
 
 	if [ $? -ne 0 ]; then
-		_notrun "idmapped-mounts not support by $FSTYP"
+		_notrun "vfstest not support by $FSTYP"
 	fi
 }
 
diff --git a/src/vfs/Makefile b/src/vfs/Makefile
index 2df3daf8..adef9ff3 100644
--- a/src/vfs/Makefile
+++ b/src/vfs/Makefile
@@ -3,8 +3,8 @@
 TOPDIR = ../..
 include $(TOPDIR)/include/builddefs
 
-TARGETS = idmapped-mounts mount-idmapped
-CFILES_IDMAPPED_MOUNTS = idmapped-mounts.c utils.c
+TARGETS = vfstest mount-idmapped
+CFILES_VFSTEST = vfstest.c utils.c
 CFILES_MOUNT_IDMAPPED = mount-idmapped.c utils.c
 
 HFILES = missing.h utils.h
@@ -25,9 +25,9 @@ depend: .dep
 
 include $(BUILDRULES)
 
-idmapped-mounts: $(CFILES_IDMAPPED_MOUNTS)
+vfstest: $(CFILES_VFSTEST)
 	@echo "    [CC]    $@"
-	$(Q)$(LTLINK) $(CFILES_IDMAPPED_MOUNTS) -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
+	$(Q)$(LTLINK) $(CFILES_VFSTEST) -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
 
 mount-idmapped: $(CFILES_MOUNT_IDMAPPED)
 	@echo "    [CC]    $@"
diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/vfstest.c
similarity index 99%
rename from src/vfs/idmapped-mounts.c
rename to src/vfs/vfstest.c
index 4cf6c3bb..66768175 100644
--- a/src/vfs/idmapped-mounts.c
+++ b/src/vfs/vfstest.c
@@ -13801,7 +13801,7 @@ static void usage(void)
 	fprintf(stderr, "--fstype                            Filesystem type used in the tests\n");
 	fprintf(stderr, "--help                              Print help\n");
 	fprintf(stderr, "--mountpoint                        Mountpoint of device\n");
-	fprintf(stderr, "--supported                         Test whether idmapped mounts are supported on this filesystem\n");
+	fprintf(stderr, "--idmapped-mounts-supported	     Test whether idmapped mounts are supported on this filesystem\n");
 	fprintf(stderr, "--scratch-mountpoint                Mountpoint of scratch device used in the tests\n");
 	fprintf(stderr, "--scratch-device                    Scratch device used in the tests\n");
 	fprintf(stderr, "--test-core                         Run core idmapped mount testsuite\n");
@@ -13819,7 +13819,7 @@ static const struct option longopts[] = {
 	{"mountpoint",				required_argument,	0,	'm'},
 	{"scratch-mountpoint",			required_argument,	0,	'a'},
 	{"scratch-device",			required_argument,	0,	'e'},
-	{"supported",				no_argument,		0,	's'},
+	{"idmapped-mounts-supported",		no_argument,		0,	's'},
 	{"help",				no_argument,		0,	'h'},
 	{"test-core",				no_argument,		0,	'c'},
 	{"test-fscaps-regression",		no_argument,		0,	'g'},
@@ -13998,9 +13998,9 @@ int main(int argc, char *argv[])
 {
 	int fret, ret;
 	int index = 0;
-	bool supported = false, test_btrfs = false, test_core = false,
-	     test_fscaps_regression = false, test_nested_userns = false,
-	     test_setattr_fix_968219708108 = false;
+	bool idmapped_mounts_supported = false, test_btrfs = false,
+	     test_core = false, test_fscaps_regression = false,
+	     test_nested_userns = false, test_setattr_fix_968219708108 = false;
 
 	while ((ret = getopt_long_only(argc, argv, "", longopts, &index)) != -1) {
 		switch (ret) {
@@ -14014,7 +14014,7 @@ int main(int argc, char *argv[])
 			t_mountpoint = optarg;
 			break;
 		case 's':
-			supported = true;
+			idmapped_mounts_supported = true;
 			break;
 		case 'c':
 			test_core = true;
@@ -14070,7 +14070,7 @@ int main(int argc, char *argv[])
 		die("failed to open %s", t_mountpoint_scratch);
 
 	t_fs_allow_idmap = fs_allow_idmap();
-	if (supported) {
+	if (idmapped_mounts_supported) {
 		/*
 		 * Caller just wants to know whether the filesystem we're on
 		 * supports idmapped mounts.
diff --git a/tests/btrfs/245 b/tests/btrfs/245
index 6403f878..dadc8492 100755
--- a/tests/btrfs/245
+++ b/tests/btrfs/245
@@ -26,7 +26,7 @@ _scratch_mount "-o user_subvol_rm_allowed" >> $seqres.full
 
 echo "Silence is golden"
 
-$here/src/vfs/idmapped-mounts --test-btrfs --device "$TEST_DEV" \
+$here/src/vfs/vfstest --test-btrfs --device "$TEST_DEV" \
 	--mountpoint "$TEST_DIR" --scratch-device "$SCRATCH_DEV" \
 	--scratch-mountpoint "$SCRATCH_MNT" --fstype "$FSTYP"
 
diff --git a/tests/generic/633 b/tests/generic/633
index 2054b646..9b29dbf1 100755
--- a/tests/generic/633
+++ b/tests/generic/633
@@ -19,7 +19,7 @@ _require_test
 
 echo "Silence is golden"
 
-$here/src/vfs/idmapped-mounts --test-core --device "$TEST_DEV" \
+$here/src/vfs/vfstest --test-core --device "$TEST_DEV" \
 	--mount "$TEST_DIR" --fstype "$FSTYP"
 
 status=$?
diff --git a/tests/generic/644 b/tests/generic/644
index 17fc0539..edf9b03e 100755
--- a/tests/generic/644
+++ b/tests/generic/644
@@ -21,7 +21,7 @@ _require_test
 
 echo "Silence is golden"
 
-$here/src/vfs/idmapped-mounts --test-fscaps-regression \
+$here/src/vfs/vfstest --test-fscaps-regression \
 	--device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
 
 status=$?
diff --git a/tests/generic/645 b/tests/generic/645
index f1209ad0..74e0f589 100755
--- a/tests/generic/645
+++ b/tests/generic/645
@@ -21,7 +21,7 @@ _require_test
 
 echo "Silence is golden"
 
-$here/src/vfs/idmapped-mounts --test-nested-userns \
+$here/src/vfs/vfstest --test-nested-userns \
 	--device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
 
 status=$?
diff --git a/tests/generic/656 b/tests/generic/656
index 9e95ac96..5c090cfa 100755
--- a/tests/generic/656
+++ b/tests/generic/656
@@ -26,7 +26,7 @@ _require_group fsgqa2
 
 echo "Silence is golden"
 
-$here/src/vfs/idmapped-mounts --test-setattr-fix-968219708108 \
+$here/src/vfs/vfstest --test-setattr-fix-968219708108 \
 	--device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
 
 status=$?
diff --git a/tests/xfs/152 b/tests/xfs/152
index de9b8fc6..12b77f91 100755
--- a/tests/xfs/152
+++ b/tests/xfs/152
@@ -246,7 +246,7 @@ qmount_idmapped()
 	mkdir -p "${SCRATCH_MNT}/unmapped"
 	mkdir -p "${SCRATCH_MNT}/idmapped"
 
-	$here/src/idmapped-mounts/mount-idmapped \
+	$here/src/vfstest/mount-idmapped \
 		--map-mount b:$id:$id2:1 \
 		--map-mount b:0:0:1 \
 		"$SCRATCH_MNT/unmapped" "$SCRATCH_MNT/idmapped" || _fail "mount-idmapped failed"
-- 
2.32.0

