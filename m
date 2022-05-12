Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D680C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 12 May 2022 16:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356708AbiELQxN (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 12:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356452AbiELQxM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 12:53:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15706E8D9
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 09:53:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DC7262036
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 16:53:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15E1C34116;
        Thu, 12 May 2022 16:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652374389;
        bh=beGli6wGZ9MYdGP05AaPvEyBLKIN7FnrohTenm2iIJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=up/BPcsGeK7k8mQgtF0dSgva3HegH+Ydge0ErMjaT7d41htVS6g83A3g6d8gVI+df
         WV1G/hTRylEPXSFj9aNYokxKkdnGzLn07AQ0pQJ5JOUcmrU1WYuc8yGUexaO63PeaL
         0Uabs3c36nerXr/lkJgBAv88Zr+06ukX5eQgekqHqN5pRElvQg5UkdbLrGytSJFY2q
         /Hu1Y00oP39NxT7GjdgoglvMy4auTPVSnhxATpekz+rUioj4jAuvtqkl35xJXRUKES
         rP5wrVygXn+p4DWwDgYapEobdHl2/Q9hRPgL8OBLcZQSZbsifpz53VPTwdkI6/dUu5
         fig0w+B6Qr7Jg==
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2 02/13] src: rename idmapped-mounts folder
Date:   Thu, 12 May 2022 18:52:39 +0200
Message-Id: <20220512165250.450989-3-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220512165250.450989-1-brauner@kernel.org>
References: <20220512165250.450989-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10774; h=from:subject; bh=beGli6wGZ9MYdGP05AaPvEyBLKIN7FnrohTenm2iIJQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTVWruFnfA5v7ie7eRqQ+ZYof4VxxQNjfyivgmUbFqfMXNr rGZ7RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQUdjEyPLl3NfeppanQ2a63mWqNET sXKk+9fuyNn8xP1e75T62LZRkZnk1yUO+/VJfW4pv2YtG7SNum2WkTWoPO/NhtvsU9YctdbgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The idmapped mounts test suite has grown to cover a lot of generic vfs
functionality that is not concerned with idmapped mounts at all.

As was discussed upstream it's time to rename it to something that
reflects its generic nature. So rename it from idmapped-mounts to vfs.

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
 .gitignore                                    |  4 +--
 common/rc                                     | 28 +++++++++----------
 src/Makefile                                  |  2 +-
 src/detached_mounts_propagation.c             |  2 +-
 src/feature.c                                 |  2 +-
 src/{idmapped-mounts => vfs}/Makefile         |  4 +--
 .../idmapped-mounts.c                         |  0
 src/{idmapped-mounts => vfs}/missing.h        |  0
 src/{idmapped-mounts => vfs}/mount-idmapped.c |  0
 src/{idmapped-mounts => vfs}/utils.c          |  0
 src/{idmapped-mounts => vfs}/utils.h          |  0
 tests/btrfs/245                               |  2 +-
 tests/generic/633                             |  2 +-
 tests/generic/644                             |  2 +-
 tests/generic/645                             |  2 +-
 tests/generic/656                             |  2 +-
 tests/xfs/152                                 |  2 +-
 tests/xfs/153                                 |  2 +-
 18 files changed, 28 insertions(+), 28 deletions(-)
 rename src/{idmapped-mounts => vfs}/Makefile (86%)
 rename src/{idmapped-mounts => vfs}/idmapped-mounts.c (100%)
 rename src/{idmapped-mounts => vfs}/missing.h (100%)
 rename src/{idmapped-mounts => vfs}/mount-idmapped.c (100%)
 rename src/{idmapped-mounts => vfs}/utils.c (100%)
 rename src/{idmapped-mounts => vfs}/utils.h (100%)

diff --git a/.gitignore b/.gitignore
index 5f24909e..b9e42635 100644
--- a/.gitignore
+++ b/.gitignore
@@ -192,8 +192,8 @@ tags
 /src/aio-dio-regress/aio-last-ref-held-by-io
 /src/aio-dio-regress/aiocp
 /src/aio-dio-regress/aiodio_sparse2
-/src/idmapped-mounts/idmapped-mounts
-/src/idmapped-mounts/mount-idmapped
+/src/vfs/idmapped-mounts
+/src/vfs/mount-idmapped
 /src/log-writes/replay-log
 /src/perf/*.pyc
 
diff --git a/common/rc b/common/rc
index e907e362..df724a96 100644
--- a/common/rc
+++ b/common/rc
@@ -355,23 +355,23 @@ _scratch_mount_idmapped()
 	if [ "$type" = "u" ]; then
 		# This means root will be able to create files as uid %id in
 		# the underlying filesystem by going through the idmapped mount.
-		$here/src/idmapped-mounts/mount-idmapped --map-mount u:0:$id:1 \
-							 --map-mount u:$id:0:1 \
-							 --map-mount g:0:0:1 \
-							 "$SCRATCH_MNT" "$SCRATCH_MNT" || _fail "mount-idmapped failed"
+		$here/src/vfs/mount-idmapped --map-mount u:0:$id:1 \
+					     --map-mount u:$id:0:1 \
+					     --map-mount g:0:0:1 \
+					     "$SCRATCH_MNT" "$SCRATCH_MNT" || _fail "mount-idmapped failed"
 	elif [ "$type" = "g" ]; then
 		# This means root will be able to create files as gid %id in
 		# the underlying filesystem by going through the idmapped mount.
-		$here/src/idmapped-mounts/mount-idmapped --map-mount g:0:$id:1 \
-							 --map-mount g:$id:0:1 \
-							 --map-mount u:0:0:1 \
-							 "$SCRATCH_MNT" "$SCRATCH_MNT" || _fail "mount-idmapped failed"
+		$here/src/vfs/mount-idmapped --map-mount g:0:$id:1 \
+					     --map-mount g:$id:0:1 \
+					     --map-mount u:0:0:1 \
+					     "$SCRATCH_MNT" "$SCRATCH_MNT" || _fail "mount-idmapped failed"
 	elif [ "$type" = "b" ]; then
 		# This means root will be able to create files as uid and gid
 		# %id in the underlying filesystem by going through the idmapped mount.
-		$here/src/idmapped-mounts/mount-idmapped --map-mount b:0:$id:1 \
-							 --map-mount b:$id:0:1 \
-							 "$SCRATCH_MNT" "$SCRATCH_MNT" || _fail "mount-idmapped failed"
+		$here/src/vfs/mount-idmapped --map-mount b:0:$id:1 \
+					     --map-mount b:$id:0:1 \
+					     "$SCRATCH_MNT" "$SCRATCH_MNT" || _fail "mount-idmapped failed"
 	else
 		_fail "usage: either \"u\" (uid), \"g\" (gid), or \"b\" (uid and gid) must be specified "
 	fi
@@ -480,7 +480,7 @@ _idmapped_mount()
 	# {g,u}id 10000000 and $(id -u fsgqa) + 10000000. We change ownership
         # of $mnt so {g,u} id 0 can actually create objects in there.
 	chown 10000000:10000000 $mnt || return 1
-	$here/src/idmapped-mounts/mount-idmapped \
+	$here/src/vfs/mount-idmapped \
 		--map-mount b:10000000:0:100000000000 \
 		$mnt $tmp
 	if [ $? -ne 0 ]; then
@@ -2349,12 +2349,12 @@ _require_mount_setattr()
 # test whether idmapped mounts are supported
 _require_idmapped_mounts()
 {
-        IDMAPPED_MOUNTS_TEST=$here/src/idmapped-mounts/idmapped-mounts
+        IDMAPPED_MOUNTS_TEST=$here/src/vfs/idmapped-mounts
         [ -x $IDMAPPED_MOUNTS_TEST ] || _notrun "idmapped-mounts utilities required"
 
 	_require_mount_setattr
 
-	$here/src/idmapped-mounts/idmapped-mounts --supported \
+	$here/src/vfs/idmapped-mounts --supported \
 		--device "$TEST_DEV" \
 		--mount "$TEST_DIR" \
 		--fstype "$FSTYP"
diff --git a/src/Makefile b/src/Makefile
index 24aef09b..7eeb08ef 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -76,7 +76,7 @@ TARGETS += uring_read_fault
 LLDLIBS += -luring
 endif
 
-SUBDIRS += idmapped-mounts
+SUBDIRS += vfs
 ifeq ($(HAVE_LIBCAP), true)
 LLDLIBS += -lcap
 endif
diff --git a/src/detached_mounts_propagation.c b/src/detached_mounts_propagation.c
index d4bc87f9..17db2c02 100644
--- a/src/detached_mounts_propagation.c
+++ b/src/detached_mounts_propagation.c
@@ -26,7 +26,7 @@
 #include <sys/types.h>
 #include <unistd.h>
 
-#include "idmapped-mounts/missing.h"
+#include "vfs/missing.h"
 
 static bool is_shared_mountpoint(const char *path)
 {
diff --git a/src/feature.c b/src/feature.c
index bc0b0b30..941f96fb 100644
--- a/src/feature.c
+++ b/src/feature.c
@@ -46,7 +46,7 @@
 #include <liburing.h>
 #endif
 
-#include "idmapped-mounts/missing.h"
+#include "vfs/missing.h"
 
 #ifndef USRQUOTA
 #define USRQUOTA  0
diff --git a/src/idmapped-mounts/Makefile b/src/vfs/Makefile
similarity index 86%
rename from src/idmapped-mounts/Makefile
rename to src/vfs/Makefile
index ad4ddc99..2df3daf8 100644
--- a/src/idmapped-mounts/Makefile
+++ b/src/vfs/Makefile
@@ -34,7 +34,7 @@ mount-idmapped: $(CFILES_MOUNT_IDMAPPED)
 	$(Q)$(LTLINK) $(CFILES_MOUNT_IDMAPPED) -o $@ $(CFLAGS) $(LDFLAGS) $(LDLIBS)
 
 install:
-	$(INSTALL) -m 755 -d $(PKG_LIB_DIR)/src/idmapped-mounts
-	$(INSTALL) -m 755 $(TARGETS) $(PKG_LIB_DIR)/src/idmapped-mounts
+	$(INSTALL) -m 755 -d $(PKG_LIB_DIR)/src/vfs
+	$(INSTALL) -m 755 $(TARGETS) $(PKG_LIB_DIR)/src/vfs
 
 -include .dep
diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
similarity index 100%
rename from src/idmapped-mounts/idmapped-mounts.c
rename to src/vfs/idmapped-mounts.c
diff --git a/src/idmapped-mounts/missing.h b/src/vfs/missing.h
similarity index 100%
rename from src/idmapped-mounts/missing.h
rename to src/vfs/missing.h
diff --git a/src/idmapped-mounts/mount-idmapped.c b/src/vfs/mount-idmapped.c
similarity index 100%
rename from src/idmapped-mounts/mount-idmapped.c
rename to src/vfs/mount-idmapped.c
diff --git a/src/idmapped-mounts/utils.c b/src/vfs/utils.c
similarity index 100%
rename from src/idmapped-mounts/utils.c
rename to src/vfs/utils.c
diff --git a/src/idmapped-mounts/utils.h b/src/vfs/utils.h
similarity index 100%
rename from src/idmapped-mounts/utils.h
rename to src/vfs/utils.h
diff --git a/tests/btrfs/245 b/tests/btrfs/245
index f3380ac2..6403f878 100755
--- a/tests/btrfs/245
+++ b/tests/btrfs/245
@@ -26,7 +26,7 @@ _scratch_mount "-o user_subvol_rm_allowed" >> $seqres.full
 
 echo "Silence is golden"
 
-$here/src/idmapped-mounts/idmapped-mounts --test-btrfs --device "$TEST_DEV" \
+$here/src/vfs/idmapped-mounts --test-btrfs --device "$TEST_DEV" \
 	--mountpoint "$TEST_DIR" --scratch-device "$SCRATCH_DEV" \
 	--scratch-mountpoint "$SCRATCH_MNT" --fstype "$FSTYP"
 
diff --git a/tests/generic/633 b/tests/generic/633
index 38280647..2054b646 100755
--- a/tests/generic/633
+++ b/tests/generic/633
@@ -19,7 +19,7 @@ _require_test
 
 echo "Silence is golden"
 
-$here/src/idmapped-mounts/idmapped-mounts --test-core --device "$TEST_DEV" \
+$here/src/vfs/idmapped-mounts --test-core --device "$TEST_DEV" \
 	--mount "$TEST_DIR" --fstype "$FSTYP"
 
 status=$?
diff --git a/tests/generic/644 b/tests/generic/644
index 9ed5a511..17fc0539 100755
--- a/tests/generic/644
+++ b/tests/generic/644
@@ -21,7 +21,7 @@ _require_test
 
 echo "Silence is golden"
 
-$here/src/idmapped-mounts/idmapped-mounts --test-fscaps-regression \
+$here/src/vfs/idmapped-mounts --test-fscaps-regression \
 	--device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
 
 status=$?
diff --git a/tests/generic/645 b/tests/generic/645
index ffe30bb4..f1209ad0 100755
--- a/tests/generic/645
+++ b/tests/generic/645
@@ -21,7 +21,7 @@ _require_test
 
 echo "Silence is golden"
 
-$here/src/idmapped-mounts/idmapped-mounts --test-nested-userns \
+$here/src/vfs/idmapped-mounts --test-nested-userns \
 	--device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
 
 status=$?
diff --git a/tests/generic/656 b/tests/generic/656
index 1231de31..9e95ac96 100755
--- a/tests/generic/656
+++ b/tests/generic/656
@@ -26,7 +26,7 @@ _require_group fsgqa2
 
 echo "Silence is golden"
 
-$here/src/idmapped-mounts/idmapped-mounts --test-setattr-fix-968219708108 \
+$here/src/vfs/idmapped-mounts --test-setattr-fix-968219708108 \
 	--device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
 
 status=$?
diff --git a/tests/xfs/152 b/tests/xfs/152
index 129d9c06..de9b8fc6 100755
--- a/tests/xfs/152
+++ b/tests/xfs/152
@@ -34,7 +34,7 @@ _cleanup()
 # real QA test starts here
 _supported_fs xfs
 _require_idmapped_mounts
-_require_test_program "idmapped-mounts/mount-idmapped"
+_require_test_program "vfs/mount-idmapped"
 _require_scratch
 _require_xfs_quota
 _require_user fsgqa
diff --git a/tests/xfs/153 b/tests/xfs/153
index 37303701..8e1430c0 100755
--- a/tests/xfs/153
+++ b/tests/xfs/153
@@ -34,7 +34,7 @@ _require_scratch
 _require_xfs_quota
 _require_user fsgqa
 _require_idmapped_mounts
-_require_test_program "idmapped-mounts/mount-idmapped"
+_require_test_program "vfs/mount-idmapped"
 
 _scratch_mkfs >/dev/null 2>&1
 _scratch_mount
-- 
2.34.1

