Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F442F44
	for <fstests@vger.kernel.org>; Wed, 12 Mar 2025 07:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741764210; cv=none; b=b2fKSf8YUqlnT5xNtoU/lXJrJOrZaf3vfna01ifA2gB/Osj8Ld6VVlmOjZjPD0lSPXygB3kCopisBWr9xs7WHYbwF2gG7tUI7DwUsUh+LxZB18TRPmSTdIcR2LtAytWEBI6XyteaP9mOeKHyu6KEGBddS0mb0Dx7PCKc8lLP2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741764210; c=relaxed/simple;
	bh=rUFbyS396/sAmJoxRgTRC+6vktKpSWiwYEa3MZG65Hs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MB4gJa7KXEOIfLsLiJ3qvMBaZX07nBTvZyouMaqPxESkPT4jZHqqQSh7lJmLVC9OOsKRybxM9iZPHi9Pe/I3NkiRskShm0mvRZX59UyKDzFOMxd43EVZfA/6J3ut05PpUbs1i7ChzbiFf0T/WpdLYvQmdDzJt82rpFzssobQyh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCS71Pev; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCS71Pev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C42EC4CEEF;
	Wed, 12 Mar 2025 07:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741764210;
	bh=rUFbyS396/sAmJoxRgTRC+6vktKpSWiwYEa3MZG65Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gCS71PevJK9ox8DcOaq2rjd1Y/hplk+iwSQf6DkBKulbfHhBJLr2+HQnOeBnRXglA
	 8kWB4u7fOFESxlNua6ZmQm5mU9RHC+Az15zkD7VuRBu41B/Mfu38xsXw9cmeRYv2Ye
	 ygayEhAqWwulT7Cr1gegCrIlysP3jdYywW8wUyWOLz/3XYqzHPad1O2UhA00VXYL2K
	 vgLu1hy2cO8SWfUhJQeE1ktJKf9HkHryWis64fKzFNYsuHKl1f6Ky35oIGo4AWCCDk
	 Oqcm8lTkh/KNWSa9OqdSpGNzBfMxUOxtRDrrs/B44ml6CRhHWz/8IZaFlJmQ15jFFD
	 VAqlVtQ19+Z0A==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v4 5/6] common/rc: introduce _check_f2fs_filesystem()
Date: Wed, 12 Mar 2025 15:23:08 +0800
Message-ID: <20250312072309.3989074-5-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
In-Reply-To: <20250312072309.3989074-1-chao@kernel.org>
References: <20250312072309.3989074-1-chao@kernel.org>
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
v4:
- clean up $FSTYP and $FSCK_OPTIONS
- dump formated logs to seqres.full once fsck detects the corruption.
 common/rc | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/common/rc b/common/rc
index 23b642f4..43d3fe42 100644
--- a/common/rc
+++ b/common/rc
@@ -3519,6 +3519,50 @@ _check_generic_filesystem()
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
@@ -3623,6 +3667,9 @@ _check_test_fs()
     ubifs)
 	# there is no fsck program for ubifs yet
 	;;
+    f2fs)
+        _check_f2fs_filesystem $TEST_DEV
+        ;;
     *)
 	_check_generic_filesystem $TEST_DEV
 	;;
@@ -3679,6 +3726,9 @@ _check_scratch_fs()
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

