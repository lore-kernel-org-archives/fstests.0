Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6047D16C6A5
	for <fstests@vger.kernel.org>; Mon,  1 Jul 2024 14:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719845523; cv=none; b=F6HipRLTskQrbyIQnNUeVS2GbbtnkB6M+wUKOW98mmR1qKCbJY61ea7EAbEj9yaB1/lndY6cTf4LvNG+oi+Kt6HP2SiewUwElgRcDFceBFKyhIVjr3trIyA71cjL0EGTc4I3mC5lbDFd439MIu/VTnUxCqrOidu8UpEXidmcekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719845523; c=relaxed/simple;
	bh=uGyFHuxkn0ENH/WQGALQ85rAlCvXRBx5Pc41sOiBuvE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mRkabT4zYTkX+wKhoW5k8R+yjhUOT+5bKw0srrDQd3PGIi8unQsTljlDMPO94KVJbscTip6MggYtqSomWKsbdcKXn2ZrxU1ncm7PbQSXpRDNQoln5UWF5SG9qx65y7oZ/9pOvBadScIfSxmPBqNY91DCRR9rV/1nQBXqgfGptFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmQSKX2f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmQSKX2f"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1719FC4AF15;
	Mon,  1 Jul 2024 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719845523;
	bh=uGyFHuxkn0ENH/WQGALQ85rAlCvXRBx5Pc41sOiBuvE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=CmQSKX2fyUXQamKgBWgu2LzEGz4lgwpwHjj/QXDFHDzaT+CJQJCwaRCh1ZWyBKwMa
	 elM+I0Tm6rHEpMG9djZ/nS3E5D+4PkRxYBhFb6ateHxs9rZNFOcJB2rhtzlglGVPyz
	 4ZulQJOrB3sSdn0WU1Z/3ek93/g+GEy0//rk7t6Tx6q3hVkuZeTDYUePQxI68aT0pj
	 qcHut+aUra0AyQ3wBkcylL+iL32e/xIjVVlQ2SAtCFCKKC9YiAzu1AraNmKIPt9qau
	 +XnBbnX31TrVEB74RmNFjiBIbgLXtSlswi+X76Tg98SGMs9qmq5v0e5VJ8TgjahJnt
	 OTI8ECklRIu6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043F7C3065B;
	Mon,  1 Jul 2024 14:52:03 +0000 (UTC)
From: Daniel Gomez via B4 Relay <devnull+da.gomez.samsung.com@kernel.org>
Date: Sun, 30 Jun 2024 23:52:44 +0200
Subject: [PATCH v2 5/5] common/rc: print test mount options
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240630-common-fixes-v2-5-16d26fb1dee0@samsung.com>
References: <20240630-common-fixes-v2-0-16d26fb1dee0@samsung.com>
In-Reply-To: <20240630-common-fixes-v2-0-16d26fb1dee0@samsung.com>
To: fstests@vger.kernel.org
Cc: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@redhat.com>, 
 mcgrof@kernel.org, gost.dev@samsung.com, 
 Samsung Samsung <"Daniel Gomez d+samsung"@kruces.com>, 
 Daniel Gomez <da.gomez@samsung.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719784382; l=2734;
 i=da.gomez@samsung.com; s=20240621; h=from:subject:message-id;
 bh=NkZG9YGxsIk1iK1q+OR884fD08LAqJ4Ql3wlQbinl1o=;
 b=1b9VZWGWwZU+PkQz3IMf3M4LrEaiHUkU2GTjkVX2ETo6y6GemZmPgtXTFMuiB5xmatqRu6RlL
 B7nTKREM/JjAVYxKCF2VfmkV/cWFCtdLH3RnDLzJpRaKXycu3Zzjtdi
X-Developer-Key: i=da.gomez@samsung.com; a=ed25519;
 pk=BqYk31UHkmv0WZShES6pIZcdmPPGay5LbzifAdZ2Ia4=
X-Endpoint-Received: by B4 Relay for da.gomez@samsung.com/20240621 with
 auth_id=175
X-Original-From: Daniel Gomez <da.gomez@samsung.com>
Reply-To: da.gomez@samsung.com

From: Daniel Gomez <da.gomez@samsung.com>

Mount options for a SCRATCH device might not be the same for a TEST
device if RECREATE_TEST_DEV is not enabled. Add mount options for TEST
devices when printing fstest header to clarify this.

Add mount and mkfs info for TEST devices so we get the same information
being printed for both devices.

Export new TEST_{MKFS/MOUNT}_OPTIONS and include them in the report.

Signed-off-by: Daniel Gomez <da.gomez@samsung.com>
---
 check         |  2 ++
 common/rc     | 19 ++++++++++++++++++-
 common/report |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/check b/check
index 9222cd7e4..ca30771c5 100755
--- a/check
+++ b/check
@@ -819,6 +819,8 @@ function run_section()
 	# print out our test configuration
 	echo "FSTYP         -- `_full_fstyp_details`"
 	echo "PLATFORM      -- `_full_platform_details`"
+	echo "TEST_MKFS_OPTIONS  -- `_test_mkfs_options`"
+	echo "TEST_MOUNT_OPTIONS -- `_test_mount_options`"
 	if [ ! -z "$SCRATCH_DEV" ]; then
 	  echo "MKFS_OPTIONS  -- `_scratch_mkfs_options`"
 	  echo "MOUNT_OPTIONS -- `_scratch_mount_options`"
diff --git a/common/rc b/common/rc
index 627dbaaaa..bbbd274a7 100644
--- a/common/rc
+++ b/common/rc
@@ -235,6 +235,15 @@ _scratch_mount_options()
 					$SCRATCH_DEV $SCRATCH_MNT $*
 }
 
+_test_mount_options()
+{
+	_test_options mount
+
+	export TEST_MOUNT_OPTIONS="$TEST_OPTIONS $TEST_FS_MOUNT_OPTS \
+				$SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR"
+	echo $TEST_MOUNT_OPTIONS
+}
+
 _supports_filetype()
 {
 	local dir=$1
@@ -457,7 +466,7 @@ _test_mount()
     fi
 
     _test_options mount
-    _mount -t $FSTYP$FUSE_SUBTYP $TEST_OPTIONS $TEST_FS_MOUNT_OPTS $SELINUX_MOUNT_OPTIONS $* $TEST_DEV $TEST_DIR
+    _mount -t $FSTYP$FUSE_SUBTYP `_test_mount_options $*`
     mount_ret=$?
     [ $mount_ret -ne 0 ] && return $mount_ret
     _idmapped_mount $TEST_DEV $TEST_DIR
@@ -571,6 +580,14 @@ _metadump_dev() {
 	esac
 }
 
+_test_mkfs_options()
+{
+	_test_options mkfs
+
+	export TEST_MKFS_OPTIONS="$TEST_OPTIONS $MKFS_OPTIONS $* $TEST_DEV"
+	echo $TEST_MKFS_OPTIONS
+}
+
 _test_mkfs()
 {
     case $FSTYP in
diff --git a/common/report b/common/report
index 0e91e481f..44de33e61 100644
--- a/common/report
+++ b/common/report
@@ -5,6 +5,7 @@
 # List of xfstests's enviroment variables to include reports
 ## TODO automate list population inside common/conf
 REPORT_ENV_LIST=("SECTION" "FSTYP" "PLATFORM" "MKFS_OPTIONS" "MOUNT_OPTIONS" \
+		 "TEST_MKFS_OPTIONS" "TEST_MOUNT_OPTIONS" \
 		 "HOST_OPTIONS" "CHECK_OPTIONS" "XFS_MKFS_OPTIONS" \
 		 "TIME_FACTOR" "LOAD_FACTOR" "TEST_DIR" "TEST_DEV" \
 		 "SCRATCH_DEV" "SCRATCH_MNT" "OVL_UPPER" "OVL_LOWER" "OVL_WORK")

-- 
2.43.0


