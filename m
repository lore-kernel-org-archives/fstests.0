Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEAD1EB9E8
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 08:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741680283; cv=none; b=MzK1srQXT7EwjTKRPWABC/laJkrnqcf6yMD3W1o8CAzMyqSsK3hoDJ6q7Pn4nZOcF+OSTAicl7B6L6Uv5Vg3hljJCnALCljmgJOvhSVxZ0eA7vs88UkPDhzApIKfEwIYpYNGq/iaNa9nm+ZXkFb5N0TdZewbDP183HjyfctAzC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741680283; c=relaxed/simple;
	bh=XMiIuJb3J5tTBjUVwyhd29X9iHjR/S3NZk4YUuvZCpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g88TKYrr182PIalT32yPD4ymTs5uOgfvRAI1MjJvqLZDAjcPrVxLRinLPVQJu1+K3Il0G2cG5ZqKZQ5xyjMNGWKEZVrtHpeuRnm2JmHjcYH4dCFKGIP6mrVGBvW2PK8kkbyPrbScWJc6OZyGD8BqBI+OEju+pEaS4CME/5d+mqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XaA2lejT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XaA2lejT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA8FC4CEF0;
	Tue, 11 Mar 2025 08:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741680282;
	bh=XMiIuJb3J5tTBjUVwyhd29X9iHjR/S3NZk4YUuvZCpk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XaA2lejTGXmrf40Mt1xVI6zerzlXgWPl2CJ1mIBrRGv72vQKsnbLm8E4jJREm2s//
	 DUAnRwaQAR653mnoL/2XTpn0F7BCxWtQj9BBgqqgQEUuvbXnsdm9fzzSqDqAYy4z8x
	 HR6x0aE0c90f5/B8CKf/CFzuoHIkSx3vvaZekRJWn10ANNwisD0WKh48GltG7BzHrV
	 XkssthhUZ4WJl2YjZYCp72ywouoh0lFPW424tOAYghwnoWOa5jC45E/+9k3/g9q6im
	 0bc6oUINzIIAJuiXrUqpW/KVjkBXK61vsFUTqvif+tFsfW8NC+KG4DjtgFReiUGlY6
	 BEw+cbtbM5VSw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 5/6] common/rc: introduce _check_f2fs_filesystem()
Date: Tue, 11 Mar 2025 16:04:29 +0800
Message-ID: <20250311080430.3696582-5-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250311080430.3696582-1-chao@kernel.org>
References: <20250311080430.3696582-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_check_generic_filesystem() will fail the test once it detects
corruption, let's introduce _check_f2fs_filesystem() to just check
filesystem w/ --dry-run option, and return the error number, then
let caller to decide whether the corruption is as expected or not.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v3:
- introduce _check_f2fs_filesystem() to dry run on f2fs image
 common/rc | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/common/rc b/common/rc
index 23b642f4..00883eb7 100644
--- a/common/rc
+++ b/common/rc
@@ -3519,6 +3519,46 @@ _check_generic_filesystem()
     return 0
 }
 
+_check_f2fs_filesystem()
+{
+    local device=$1
+
+    # If type is set, we're mounted
+    local type=`_fs_type $device`
+    local ok=1
+
+    if [ "$type" = "$FSTYP" ]
+    then
+        # mounted ...
+        local mountpoint=`_umount_or_remount_ro $device`
+    fi
+
+    FSCK_OPTIONS="--dry-run"
+    $F2FS_FSCK_PROG $FSCK_OPTIONS $device >>$seqres.full 2>&1
+    if [ $? -ne 0 ]
+    then
+        ok=0
+    fi
+
+    if [ $ok -eq 0 ]
+    then
+        echo "*** mount output ***"		>>$seqres.full
+        _mount					>>$seqres.full
+        echo "*** end mount output"		>>$seqres.full
+    elif [ "$type" = "$FSTYP" ]
+    then
+	# was mounted ...
+	_mount_or_remount_rw "$MOUNT_OPTIONS" $device $mountpoint
+	ok=$?
+    fi
+
+    if [ $ok -eq 0 ]; then
+	return 1
+    fi
+
+    return 0
+}
+
 # Filter the knowen errors the UDF Verifier reports.
 _udf_test_known_error_filter()
 {
@@ -3623,6 +3663,9 @@ _check_test_fs()
     ubifs)
 	# there is no fsck program for ubifs yet
 	;;
+    f2fs)
+        _check_f2fs_filesystem $TEST_DEV
+        ;;
     *)
 	_check_generic_filesystem $TEST_DEV
 	;;
@@ -3679,6 +3722,9 @@ _check_scratch_fs()
     ubifs)
 	# there is no fsck program for ubifs yet
 	;;
+    f2fs)
+        _check_f2fs_filesystem $device
+        ;;
     *)
 	_check_generic_filesystem $device
 	;;
-- 
2.48.1

