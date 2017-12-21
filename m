Received: from mx1.mpynet.fi ([82.197.21.84]:53052 "EHLO mx1.mpynet.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750881AbdLUWKT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 21 Dec 2017 17:10:19 -0500
From: Ari Sundholm <ari@tuxera.com>
Subject: [PATCH v2] common/encrypt: Create an encrypted equivalent of _scratch_mkfs_sized
Date: Fri, 22 Dec 2017 00:10:05 +0200
Message-ID: <1513894205-19632-1-git-send-email-ari@tuxera.com>
In-Reply-To: <1513792000-25462-1-git-send-email-ari@tuxera.com>
References: <1513792000-25462-1-git-send-email-ari@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Ari Sundholm <ari@tuxera.com>
List-ID: <fstests@vger.kernel.org>

Test case generic/399 hardcodes "-O encrypt" in MKFS_OPTIONS when
calling _scratch_mkfs_sized, which only works with the mkfs of certain
filesystems. Create a new helper, _scratch_mkfs_sized_encrypted, for
handling the differences between the mkfs tools of different
filesystems. It also allows those filesystems whose mkfs doesn't accept
"-O encrypt" to skip the test gracefully until proper support is added
for them in the helper.

ubifs is not supported in the new helper despite supporting encryption,
as _scratch_mkfs_sized has no ubifs support and adding that should be
done in a separate patch.

Signed-off-by: Ari Sundholm <ari@tuxera.com>
---
 common/encrypt    | 12 ++++++++++++
 tests/generic/399 |  3 +--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/common/encrypt b/common/encrypt
index a6fd89d..189c59e 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -81,6 +81,18 @@ _scratch_mkfs_encrypted()
 	esac
 }
 
+_scratch_mkfs_sized_encrypted()
+{
+	case $FSTYP in
+	ext4|f2fs)
+		MKFS_OPTIONS="$MKFS_OPTIONS -O encrypt" _scratch_mkfs_sized $*
+		;;
+	*)
+		_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized_encrypted"
+		;;
+	esac
+}
+
 # Give the invoking shell a new session keyring.  This makes any keys we add to
 # the session keyring scoped to the lifetime of the test script.
 _new_session_keyring()
diff --git a/tests/generic/399 b/tests/generic/399
index 8f5fcdc..70896e4 100755
--- a/tests/generic/399
+++ b/tests/generic/399
@@ -76,8 +76,7 @@ fs_size_in_mb=64
 fs_size=$((fs_size_in_mb * 1024 * 1024))
 dd if=/dev/zero of=$SCRATCH_DEV bs=$((1024 * 1024)) \
 	count=$fs_size_in_mb &>> $seqres.full
-MKFS_OPTIONS="$MKFS_OPTIONS -O encrypt" \
-	_scratch_mkfs_sized $fs_size &>> $seqres.full
+_scratch_mkfs_sized_encrypted $fs_size &>> $seqres.full
 _scratch_mount
 
 keydesc=$(_generate_encryption_key)
-- 
2.7.4

