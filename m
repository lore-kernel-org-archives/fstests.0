Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8591C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 12 May 2022 16:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356709AbiELQxP (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 12:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356452AbiELQxN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 12:53:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D04B268669
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 09:53:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D3C162014
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 16:53:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F624C34117;
        Thu, 12 May 2022 16:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652374391;
        bh=+dHSaxxw1nidMkAbA4twZQuLgEtanMgN55xKJRxOWpY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F3sUUGqWy7QCVQHle3KEZrHwJaecDT4G87WzknyTEl7eAgoqCWMttYa/4ATr2uQ/O
         SBeKxEzxwhZlOZUaMoo/WSmMgSxOSVePwO8LytrqV/cRBcJH+w6YGE54gdqYgyXTG1
         Z2dTkVfCCZts3CJUkuf7DBhCfW3Cb2WhwfRLIYA0xqbUaTWRmiDSbnZOD1ZtTrWSXx
         8nss9WuRsu9mI1wqujvE3sGWisy5fJXFBKbO4X2plScAApZVa/2EO+VE+ozweyUh/T
         pOcXK1JkreDQn4mD26kDdWSPL5itBmfAXPSuN63u4pPT4ogzhsbmAjB3NORmEjm2pe
         sf9N1uOvOJv+w==
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2 03/13] src/vfs: rename idmapped-mounts.c file
Date:   Thu, 12 May 2022 18:52:40 +0200
Message-Id: <20220512165250.450989-4-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220512165250.450989-1-brauner@kernel.org>
References: <20220512165250.450989-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=8670; h=from:subject; bh=+dHSaxxw1nidMkAbA4twZQuLgEtanMgN55xKJRxOWpY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTVWrtvKP+fLcsZ+HX6y8flBTx+7QzOGmZWnVdnc7U3mR+f ZibSUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJGZLxn++4VV5p665Rw/7cqGt3x3/z 9v/PlhtwtnhEXhcS/JjXP3hDD80y94qF3ZtdPj1UyWp9s4N5ZYq3B78Lt/q7nd3H6J46UBMwA=
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
Acked-by: Christoph Hellwig <hch@lst.de>
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
index df724a96..28e4c11f 100644
--- a/common/rc
+++ b/common/rc
@@ -2349,18 +2349,18 @@ _require_mount_setattr()
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
index e06185b7..7f57b777 100644
--- a/src/vfs/idmapped-mounts.c
+++ b/src/vfs/vfstest.c
@@ -14278,7 +14278,7 @@ static void usage(void)
 	fprintf(stderr, "--fstype                            Filesystem type used in the tests\n");
 	fprintf(stderr, "--help                              Print help\n");
 	fprintf(stderr, "--mountpoint                        Mountpoint of device\n");
-	fprintf(stderr, "--supported                         Test whether idmapped mounts are supported on this filesystem\n");
+	fprintf(stderr, "--idmapped-mounts-supported	     Test whether idmapped mounts are supported on this filesystem\n");
 	fprintf(stderr, "--scratch-mountpoint                Mountpoint of scratch device used in the tests\n");
 	fprintf(stderr, "--scratch-device                    Scratch device used in the tests\n");
 	fprintf(stderr, "--test-core                         Run core idmapped mount testsuite\n");
@@ -14297,7 +14297,7 @@ static const struct option longopts[] = {
 	{"mountpoint",				required_argument,	0,	'm'},
 	{"scratch-mountpoint",			required_argument,	0,	'a'},
 	{"scratch-device",			required_argument,	0,	'e'},
-	{"supported",				no_argument,		0,	's'},
+	{"idmapped-mounts-supported",		no_argument,		0,	's'},
 	{"help",				no_argument,		0,	'h'},
 	{"test-core",				no_argument,		0,	'c'},
 	{"test-fscaps-regression",		no_argument,		0,	'g'},
@@ -14494,9 +14494,9 @@ int main(int argc, char *argv[])
 {
 	int fret, ret;
 	int index = 0;
-	bool supported = false, test_btrfs = false, test_core = false,
-	     test_fscaps_regression = false, test_nested_userns = false,
-	     test_setattr_fix_968219708108 = false,
+	bool idmapped_mounts_supported = false, test_btrfs = false,
+	     test_core = false, test_fscaps_regression = false,
+	     test_nested_userns = false, test_setattr_fix_968219708108 = false,
 	     test_setxattr_fix_705191b03d50 = false;
 
 	while ((ret = getopt_long_only(argc, argv, "", longopts, &index)) != -1) {
@@ -14511,7 +14511,7 @@ int main(int argc, char *argv[])
 			t_mountpoint = optarg;
 			break;
 		case 's':
-			supported = true;
+			idmapped_mounts_supported = true;
 			break;
 		case 'c':
 			test_core = true;
@@ -14570,7 +14570,7 @@ int main(int argc, char *argv[])
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
index de9b8fc6..dd33801d 100755
--- a/tests/xfs/152
+++ b/tests/xfs/152
@@ -246,7 +246,7 @@ qmount_idmapped()
 	mkdir -p "${SCRATCH_MNT}/unmapped"
 	mkdir -p "${SCRATCH_MNT}/idmapped"
 
-	$here/src/idmapped-mounts/mount-idmapped \
+	$here/src/vfs/mount-idmapped \
 		--map-mount b:$id:$id2:1 \
 		--map-mount b:0:0:1 \
 		"$SCRATCH_MNT/unmapped" "$SCRATCH_MNT/idmapped" || _fail "mount-idmapped failed"
-- 
2.34.1

