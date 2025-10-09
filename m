Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078B52D7D35
	for <fstests@vger.kernel.org>; Thu,  9 Oct 2025 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760000934; cv=none; b=S4/9POAT6LVDIeDa8hXnnL2HE9XY6EvFD8SuKUCwe2Xtpdn/yNFgT2wUlk49AYmOlY6fuh34Vc9wXmCOv0jr2bHUB5QfWpqnyTxCIs4RH5TILtOgr8GwmGWh7ahQ4Yclg+DP3awQJnAT4mJbqvWSYuxoVITlwiyQ9bYl3VysSGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760000934; c=relaxed/simple;
	bh=7qX7dSyEVqUMvvtMzL7YjED76he7BdxUoYprgSlpf9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nRlDOtfTlIkEgt1CbZUuK+QZ/C5hhWFp24Sv7ospbC15UdrPB8cYd+jQrXP0lQ9VAagi9XvLaU9drTU9lEBHGjT/JSSJ/mTPCzxDUwg6Lugjn1hbVjZvge2/5paOL4bpKIiGHQRyima2Rj3dhUflvPWVfucH0uiudZcdamqEz7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7ehBCcI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7ehBCcI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15633C113D0;
	Thu,  9 Oct 2025 09:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760000933;
	bh=7qX7dSyEVqUMvvtMzL7YjED76he7BdxUoYprgSlpf9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o7ehBCcI9x2GyzJeYX8iDpERFl/6bOwZJ/WqEsN2ORa+kPGudRDmZpWgyESSafqzx
	 u8NcItMtmH8vDASt39/hOQ4Ge25S24XvVxH5MbgsjNQLi3wRgAY8Ib99FxErpuE94p
	 O00XY9pkz82QeAyRc2ppobj2CvBvjLxQ1Sd9Oidd/vMvRuwXtp802kPdltugqVMFkN
	 kCYLw/TGyoSCzUcoZ0ScuUMtvx/vo5/WGKi97KWChf4yS2ad6LNdiZsYfRu01gwpvI
	 a6KI/zosBE0zJgIfH5CMVdzIGFDduTVrHcESQzcfQFWwz/JnRqIbSpV5ep+Y6GOE1U
	 rybByh3Xr+WIQ==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH 2/3] common/rc: move _check_f2fs_filesystem() to common/f2fs
Date: Thu,  9 Oct 2025 16:50:42 +0800
Message-Id: <20251009085043.16910-2-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20251009085043.16910-1-chao@kernel.org>
References: <20251009085043.16910-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

_check_f2fs_filesystem() is f2fs specific, it's better to move it to
common/f2fs.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 common/f2fs | 44 ++++++++++++++++++++++++++++++++++++++++++++
 common/rc   | 44 --------------------------------------------
 2 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/common/f2fs b/common/f2fs
index 1b39d8ce..4d0d688b 100644
--- a/common/f2fs
+++ b/common/f2fs
@@ -25,3 +25,47 @@ _require_scratch_f2fs_compression()
 		_scratch_unmount
 	fi
 }
+
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
diff --git a/common/rc b/common/rc
index 1ec84263..4d121a1b 100644
--- a/common/rc
+++ b/common/rc
@@ -3566,50 +3566,6 @@ _check_generic_filesystem()
     return 0
 }
 
-_check_f2fs_filesystem()
-{
-    local device=$1
-
-    # If type is set, we're mounted
-    local type=`_fs_type $device`
-    local ok=1
-
-    if [ "$type" = "f2fs" ]
-    then
-        # mounted ...
-        local mountpoint=`_umount_or_remount_ro $device`
-    fi
-
-    $F2FS_FSCK_PROG --dry-run $device >$tmp.fsck.f2fs 2>&1
-    if [ $? -ne 0 ];then
-        _log_err "_check_f2fs_filesystem: filesystem on $device is inconsistent"
-        echo "*** fsck.f2fs output ***" >>$seqres.full
-        cat $tmp.fsck.f2fs              >>$seqres.full
-        echo "*** end fsck.f2fs output" >>$seqres.full
-
-    ok=0
-    fi
-    rm -f $tmp.fsck.f2fs
-
-    if [ $ok -eq 0 ]
-    then
-        echo "*** mount output ***"		>>$seqres.full
-        _mount					>>$seqres.full
-        echo "*** end mount output"		>>$seqres.full
-    elif [ "$type" = "f2fs" ]
-    then
-	# was mounted ...
-	_mount_or_remount_rw "$MOUNT_OPTIONS" $device $mountpoint
-	ok=$?
-    fi
-
-    if [ $ok -eq 0 ]; then
-	return 1
-    fi
-
-    return 0
-}
-
 # Filter the knowen errors the UDF Verifier reports.
 _udf_test_known_error_filter()
 {
-- 
2.40.1

