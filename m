Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0182925A2B7
	for <fstests@vger.kernel.org>; Tue, 25 Mar 2025 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742907530; cv=none; b=S5mzQ/QqiQzuSSRz1i6hlQ1o4T7mVp6mJOHNTb9bif3tWmjnBkSwPKyYhmh9GGAGuFl4jxQNrYuxRBaRLv5ehWsrigC1whVMV7GmfgHugmUDwwt6DicGpF8JPRH5QuHLjYfFqmozRU88tscRM3kJ1bVFLWrVj4sTWsP7ETcinzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742907530; c=relaxed/simple;
	bh=00DLigW1BznJ8vTs4yfqAv7qlo9NXstRvHEGDfH0+AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jrl9dx8IrP6HhSFFR8SuD73T1DsjMus5gIgxHoza73BD3S1qcSncFRXh0BjtL73psmagqMEJxvYplEUHy3MKOmx/n+C/Zt5qreTSlAxIlQ059ofSS25kJS6ufc6Po87HINCdO28o5VYan5Ch8N1Di4eZQ4cQ0wg2W4Nvf3yxg1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rvqD+t/v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvqD+t/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7A5CC4CEED;
	Tue, 25 Mar 2025 12:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742907529;
	bh=00DLigW1BznJ8vTs4yfqAv7qlo9NXstRvHEGDfH0+AU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rvqD+t/vGpY2tdZeuLreLdmIwRKIAfejszt4vOWSfuHf9r+gK5W4XmEVMBNmJ9yHW
	 fySK7S+6yLZcttkhceiJXdl4tm1ABkR5ZcDtvkBKlBOigBrHTgrByFuIjpoo4fvl/Z
	 5cVcQmIe9lGSBafSEh1ZEKmbhCZbX5z1WEFuZEhgFT+BwnhaliQ/0PeiUEgbjrhfom
	 i5pdV2QJ8WTkJTGT2JkgZaG7dRYS8qFYjgahQg1w6d7AMQHUH6rKxFx5fTxm3AqBfv
	 j67053xcsZ9lM1jwpZKnbrHETcKefgik2rH6Zu+SfeFYphquIlFD3IKEPsiw/T6+tX
	 gvxXbYNqq/sIw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v5 5/6] common/rc: introduce _check_f2fs_filesystem()
Date: Tue, 25 Mar 2025 20:58:23 +0800
Message-ID: <20250325125824.3367060-5-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557-goog
In-Reply-To: <20250325125824.3367060-1-chao@kernel.org>
References: <20250325125824.3367060-1-chao@kernel.org>
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
 common/rc | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/common/rc b/common/rc
index ac2bac81..cabd44de 100644
--- a/common/rc
+++ b/common/rc
@@ -3527,6 +3527,50 @@ _check_generic_filesystem()
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
+    if [ "$type" = "f2fs" ]
+    then
+        # mounted ...
+        local mountpoint=`_umount_or_remount_ro $device`
+    fi
+
+    $F2FS_FSCK_PROG --dry-run $device >$tmp.fsck.f2fs 2>&1
+    if [ $? -ne 0 ];then
+        _log_err "_check_f2fs_filesystem: filesystem on $device is inconsistent"
+        echo "*** fsck.f2fs output ***" >>$seqres.full
+        cat $tmp.fsck.f2fs              >>$seqres.full
+        echo "*** end fsck.f2fs output" >>$seqres.full
+
+    ok=0
+    fi
+    rm -f $tmp.fsck.f2fs
+
+    if [ $ok -eq 0 ]
+    then
+        echo "*** mount output ***"		>>$seqres.full
+        _mount					>>$seqres.full
+        echo "*** end mount output"		>>$seqres.full
+    elif [ "$type" = "f2fs" ]
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
@@ -3631,6 +3675,9 @@ _check_test_fs()
     ubifs)
 	# there is no fsck program for ubifs yet
 	;;
+    f2fs)
+        _check_f2fs_filesystem $TEST_DEV
+        ;;
     *)
 	_check_generic_filesystem $TEST_DEV
 	;;
@@ -3687,6 +3734,9 @@ _check_scratch_fs()
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

