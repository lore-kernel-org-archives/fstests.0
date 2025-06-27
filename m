Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78891215783
	for <fstests@vger.kernel.org>; Fri, 27 Jun 2025 18:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751049760; cv=none; b=ZnHpTbemOZnZlYc42a1q3XHRoiM2Qi+Rt7Bt1DVn400/a/JdCQ8tIN/IPCrYaAdQZp2fi3XFPdUnHQvOpW/4YTyfZ5Xz4AAUE8ElIlpB/vusyb+jxAjjeBhu68CoUp0Yt6xnBHVkhDP52XeyNkArvCekdt4kWotWHZ5tIcPvf80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751049760; c=relaxed/simple;
	bh=TFuT6y53VKXj3SaphfLIbrv7DtIxTxDgJ+V3hK3PEkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aWvX/0nVtmlFfnT7Mz6VEG4ZQrf0Hc3cmI4mOfbEnYK6oWUQwNhL+6W5sz63wUFgYt8l4SaQM/mq0Qw7GWy60SJEaYBhGBans783NLMwzT4g7cv0hrexfaI+DJstbXENqQhSt2pw/ELRJ6qKzGRwiYhVdgFP9fAQl7DTZjVTsoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=versity.com; spf=pass smtp.mailfrom=versity.com; dkim=pass (2048-bit key) header.d=versity.com header.i=@versity.com header.b=e1yX11GM; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=versity.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=versity.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=versity.com header.i=@versity.com header.b="e1yX11GM"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b170c99aa49so2112851a12.1
        for <fstests@vger.kernel.org>; Fri, 27 Jun 2025 11:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=versity.com; s=google; t=1751049756; x=1751654556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+a7KlzOE25KfvqV67csK4Q9jUgOx2xFzqbWFuaVfuts=;
        b=e1yX11GMrsnutYWsRD0Zrdpgej5iqVbCtrGAQdEjCwPhg4ZuYGppztmfdV3fWCzIit
         haENmRdS5vc7gHFp0C9la0c8IU5U1p0Bgo5EZLw+BUocm/v47tmBvct54alyZGjnXjU+
         e0S6qN8I1EVAeYzlawnOMqTWBQt6I06shCXShlse+nv3hHaVgCAvqeun8H5SEGdzzmcn
         fssofIBFDSf5twb9HNobjv7wy+dPJmX6mkkqwk/l4251sSw1wAT3eLhQ2sbc4AvMX6eP
         8q8XW6lAbUNB/ESxGjCteaqHIc0dWNhxmZVqc9BHSI96lnuehM2pDSvZSf0C4OpOW3tn
         RyXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751049756; x=1751654556;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+a7KlzOE25KfvqV67csK4Q9jUgOx2xFzqbWFuaVfuts=;
        b=eUhcnWDlk/tPg2SrKjvQdsm8z/8f3UDzNN6K5wSMI07lsVtp7kyUW4DsJVgwIantfL
         CwTTg2UR40KdnmgQKwn3qagdCywk8HASs9mENHDL+xidWm0VjpnYK2cGo+55ayr33AsA
         h51/+073s0Wz+I+TTXWXVzXSpiZ58M4mZUavO9SvNkEA9gyx1uboXXBzK69grOrptNgE
         yu9+gfrVvxnA+c9LJ1ZFHW6VYCKE5TaJgomnRk99bEidSlgxN7gfHoXjT/MfuLS2jH3Z
         wMceg/iD7cRf53R6y5ys8AOo33P4WwT+tSCe8Wfczc4qBe3ZIA3EhP2EfW766u0vkYNx
         sB1A==
X-Gm-Message-State: AOJu0Yw1RZ24qkNMf22NP7bwRq8wsLdpIpQWtOWIq6MZddfSnRqvpZu1
	LHkT8oxzepSByaauTtTm/3lI5XxzmLcad64p3NHYhH59zvFb/ehr0gSJfPt+Lw2fcX1DqEcSFs0
	Cz7FF0W0=
X-Gm-Gg: ASbGncv1d9pkn5xuynMGiUZONjLgN6oFH+eEkd5ORoXomLlZeEm6Tm4MqwA38dlSdKu
	V078nnhdGzqsmwA3lJBsE3g+qSa+ebwiFYqmTIj7RuSGHWhkeCF8ayOuRfOk7P2f+LazAj6rbQF
	RnVKr1UeYB8iFY+Mp+gYeAu18vTEb5SWJjZxE53XQsw4+3UrmtmpwjVpQO/4MriOUxl/Ca2BERU
	EVkj7GQGzEm9AUF9Qk4RKYznJ2tQrz9apSQ7a40XgPBSMw5JIZt76NowXSOQGoaw/oR249QrLDO
	5kDXEJBeOroziS2U0CUbbz1W/5FHdDWTN1NhflKB6iT9WpkLz6CBGfqcFNtZ2YHZabpCMsOW+Os
	=
X-Google-Smtp-Source: AGHT+IH/x8UcnkCAYF8iU/fWo7UrSjoi+3kuT5CnLxkM/Ij6cBcTMousgj1r9QWhGjJAKscXBysmjw==
X-Received: by 2002:a17:902:cecf:b0:22e:421b:49b1 with SMTP id d9443c01a7336-23ac487c9f8mr67219885ad.48.1751049756146;
        Fri, 27 Jun 2025 11:42:36 -0700 (PDT)
Received: from pc-versity-test.lan ([2605:59c8:474:a100:82ee:73ff:fee4:d15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3b7a47sm21612005ad.166.2025.06.27.11.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 11:42:35 -0700 (PDT)
From: Auke Kok <auke.kok@versity.com>
To: fstests@vger.kernel.org
Cc: Auke Kok <auke.kok@versity.com>
Subject: [PATCH] common: add scoutfs support.
Date: Fri, 27 Jun 2025 11:42:20 -0700
Message-ID: <20250627184220.114746-1-auke.kok@versity.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Basic scoutfs support: scoutfs uses 2 devices for a filesystem, one for
metadata, and one for data. This requires that we pass a metadev_path
argument to every mount call, as well as a quorum_slot option.

To run any of these tests on scoutfs, you'll need to build and
install the out-of-tree kernel module `scoutfs.ko`, and the `scoutfs`
userspace utility, which can `mkfs` a scoutfs filesystem. The tests
themselves are unmodified - many of them will be skipped due to
unsupported features.

Signed-off-by: Auke Kok <auke.kok@versity.com>
---
 common/config |  1 +
 common/rc     | 26 ++++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/common/config b/common/config
index 22b52432..5273790d 100644
--- a/common/config
+++ b/common/config
@@ -228,6 +228,7 @@ export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
 export PARTED_PROG="$(type -P parted)"
 export XFS_PROPERTY_PROG="$(type -P xfs_property)"
 export FSCRYPTCTL_PROG="$(type -P fscryptctl)"
+export SCOUTFS_PROG="$(type -P scoutfs)"
 
 # udev wait functions.
 #
diff --git a/common/rc b/common/rc
index f71cc8f0..47aac12b 100644
--- a/common/rc
+++ b/common/rc
@@ -361,6 +361,9 @@ _scratch_options()
     ext2|ext3|ext4)
 	_scratch_ext4_options "$@"
 	;;
+    scoutfs)
+	SCRATCH_OPTIONS=$SCOUTFS_SCRATCH_MOUNT_OPTIONS_META_DEV
+	;;
     esac
 }
 
@@ -396,7 +399,14 @@ _test_options()
 # hosted on $SCRATCH_DEV, so can't use external scratch devices).
 _common_dev_mount_options()
 {
+    case "$FSTYPE" in
+    scoutfs)
+	echo $MOUNT_OPTIONS $SELINUX_MOUNT_OPTIONS $SCOUTFS_MOUNT_OPTIONS_META_DEV $*
+	;;
+    *)
 	echo $MOUNT_OPTIONS $SELINUX_MOUNT_OPTIONS $*
+	;;
+    esac
 }
 
 _scratch_mount_options()
@@ -851,6 +861,9 @@ _test_mkfs()
     bcachefs)
 	$MKFS_BCACHEFS_PROG $MKFS_OPTIONS $* $TEST_DEV > /dev/null
 	;;
+    scoutfs)
+	$SCOUTFS_PROG mkfs $MKFS_OPTIONS $* $TEST_DEV
+	;;
     *)
 	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $* $TEST_DEV
 	;;
@@ -896,6 +909,9 @@ _try_mkfs_dev()
     xfs)
 	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $*
 	;;
+    scoutfs)
+	$SCOUTFS_PROG mkfs $MKFS_OPTIONS $*
+	;;
     *)
 	yes | $MKFS_PROG -t $FSTYP -- $MKFS_OPTIONS $*
 	;;
@@ -1003,6 +1019,10 @@ _scratch_mkfs()
 		mkfs_cmd="$MKFS_BCACHEFS_PROG"
 		mkfs_filter="cat"
 		;;
+     scoutfs)
+		mkfs_cmd="$SCOUTFS_PROG mkfs $MKFS_OPTIONS $MKFS_SCRATCH_OPTIONS $* $SCRATCH_META_DEV"
+		mkfs_filter="cat"
+		;;
 	*)
 		mkfs_cmd="yes | $MKFS_PROG -t $FSTYP --"
 		mkfs_filter="cat"
@@ -3670,6 +3690,9 @@ _check_test_fs()
     f2fs)
         _check_f2fs_filesystem $TEST_DEV
         ;;
+    scoutfs)
+	# currently not checking
+	;;
     *)
 	_check_generic_filesystem $TEST_DEV
 	;;
@@ -3729,6 +3752,9 @@ _check_scratch_fs()
     f2fs)
         _check_f2fs_filesystem $device
         ;;
+    scoutfs)
+	# currently not checking
+	;;
     *)
 	_check_generic_filesystem $device
 	;;
-- 
2.49.0

