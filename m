Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F8012EBE7
	for <fstests@vger.kernel.org>; Mon,  4 Aug 2025 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754307624; cv=none; b=s/H7Upay3olbb2NI83pd8+1QUdzxHMsgpG3iPR85EqVPYorGGxHBi27ZivZWi1Si5FbwYNGj1WU7J7oaFfKQAZVUU0iZG9KALFLWlJ9+EhyR5Emh04sF6UFdamUIqG0IgUwwMCMKIIWti2CtHQIAz14KSdBMrMKRxgppSDNrzzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754307624; c=relaxed/simple;
	bh=6gVCMue35jXZh2y+xilUsyrrR2boIXhGdo0dUWABY+M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mOkCtRNaTwbpLR48+hLB9UA820q+/sRP0YzKjNGQQVWX9/3x6KyKpHLn+EaT/DQCSuUrD/d5XhwI3k+Pz6jiRO3OyaJFoXo5lF2MDd12/w7LeeNAECWTdVQGfEi/MXbMF7A805QOYGsPV5Pk/QwmrT16qHbLp5RKdMxwlgZ9R30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkhUsEIq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkhUsEIq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB406C4CEE7;
	Mon,  4 Aug 2025 11:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754307624;
	bh=6gVCMue35jXZh2y+xilUsyrrR2boIXhGdo0dUWABY+M=;
	h=From:To:Cc:Subject:Date:From;
	b=YkhUsEIqN6tJQQFvYPoA4yJpNkwzoqdzvu/jczEFROwRMgLjTyjmS9UO5mR5CDbV8
	 RL2YJ3hsHcyVRHdJs2wq0Jdww3NBjvxkOWVJkjwDQO4XIivP+a3Laf9Nut/hZEugM1
	 vnnrui6Jk0Nu/5z8ALvSdlZt8GU9ZAaM+rwxHEZ6GsAuo1afMTstfg4sUuVbeyqxX3
	 OS+DFovw4jgmBFDzi2DBJWXJpnvRnpQoo7nc+otRVmb/mGMLhcJWzKqFxJdUNkwFuW
	 suhkuSqn+QAxFlqTino0ToDLy7K1HJQ6aHPj3iTZQsTO67LzAsLjBZL3yH5GWL9mFy
	 0vIiR1DW9QTpg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 1/3] f2fs/015: test common mount options
Date: Mon,  4 Aug 2025 19:40:14 +0800
Message-ID: <20250804114016.2734919-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As f2fs changes to use new mount APIs, let's add a new testcase
to check mount result for all f2fs supported common mount options
and their combinations, in order to detect any inconsistency during
mount.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 common/rc          |   3 +
 tests/f2fs/015     | 121 +++++++++++++++++++++++++++++++
 tests/f2fs/015.out | 173 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 297 insertions(+)
 create mode 100755 tests/f2fs/015
 create mode 100644 tests/f2fs/015.out

diff --git a/common/rc b/common/rc
index ff5df203..81587dad 100644
--- a/common/rc
+++ b/common/rc
@@ -876,6 +876,9 @@ _test_mkfs()
     ext2|ext3|ext4)
 	$MKFS_PROG -t $FSTYP -- -F $MKFS_OPTIONS $* $TEST_DEV
 	;;
+    f2fs)
+	$MKFS_PROG -t $FSTYP -- -f $MKFS_OPTIONS $* $TEST_DEV
+	;;
     xfs)
 	_test_options mkfs
 	$MKFS_PROG -t $FSTYP -- -f $TEST_OPTIONS $MKFS_OPTIONS $* $TEST_DEV
diff --git a/tests/f2fs/015 b/tests/f2fs/015
new file mode 100755
index 00000000..73ac3d82
--- /dev/null
+++ b/tests/f2fs/015
@@ -0,0 +1,121 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/015
+#
+# This testcase tries to check stability of mount result
+# w/ common mount option and their combination.
+#
+. ./common/preamble
+_begin_fstest auto quick mount
+_require_kernel_config CONFIG_F2FS_FS_XATTR
+_require_kernel_config CONFIG_F2FS_FS_POSIX_ACL
+_require_kernel_config CONFIG_F2FS_FAULT_INJECTION
+
+options=(
+#	mount_option			mkfs_option
+	"background_gc=on"		""			\
+	"background_gc=off"		""			\
+	"background_gc=sync"		""			\
+	"disable_roll_forward"		""			\
+	"norecovery"			""			\
+	"discard"			""			\
+	"nodiscard"			""			\
+	"no_heap"			""			\
+	"heap"				""			\
+	"user_xattr"			""			\
+	"nouser_xattr"			""			\
+	"acl"				""			\
+	"noacl"				""			\
+	"active_logs=2"			""			\
+	"active_logs=4"			""			\
+	"active_logs=6"			""			\
+	"disable_ext_identify"		""			\
+	"inline_xattr"			""			\
+	"noinline_xattr"		""			\
+	"inline_xattr_size=400"		""			\
+	"inline_data"			""			\
+	"noinline_dentry"		""			\
+	"inline_dentry"			""			\
+	"noinline_dentry"		""			\
+	"flush_merge"			""			\
+	"noflush_merge"			""			\
+	"barrier"			""			\
+	"nobarrier"			""			\
+	"fastboot"			""			\
+	"extent_cache"			""			\
+	"noextent_cache"		""			\
+	"data_flush"			""			\
+	"reserve_root=32768"		""			\
+	"resuid=1000"			""			\
+	"resgid=1000"			""			\
+	"fault_injection=100"		""			\
+	"fault_type=4095"		""			\
+	"mode=adaptive"			""			\
+	"mode=lfs"			""			\
+	"mode=fragment:segment"		""			\
+	"mode=fragment:block"		""			\
+	"usrquota"			""			\
+	"grpquota"			""			\
+	"prjquota"			""			\
+	"usrjquota=ausrquota"		""			\
+	"grpjquota=agrpquota"		""			\
+	"prjjquota=aprjquota"		""			\
+	"jqfmt=vfsold"			""			\
+	"jqfmt=vfsv0"			""			\
+	"jqfmt=vfsv1"			""			\
+	"usrjquota="			""			\
+	"grpjquota="			""			\
+	"prjjquota="			""			\
+	"quota"				""			\
+	"noquota"			""			\
+	"alloc_mode=reuse"		""			\
+	"alloc_mode=default"		""			\
+	"fsync_mode=posix"		""			\
+	"fsync_mode=strict"		""			\
+	"fsync_mode=nobarrier"		""			\
+	"test_dummy_encryption"		""			\
+	"test_dummy_encryption=v1"	""			\
+	"test_dummy_encryption=v2"	""			\
+	"checkpoint=enable"		""			\
+	"checkpoint=disable"		""			\
+	"checkpoint=disable:32768"	""			\
+	"checkpoint=disable:50%"	""			\
+	"checkpoint_merge"		""			\
+	"nocheckpoint_merge"		""			\
+	"compress_algorithm=lzo"	""			\
+	"inlinecrypt"			""			\
+	"atgc"				""			\
+	"discard_unit=block"		""			\
+	"discard_unit=segment"		""			\
+	"discard_unit=section"		""			\
+	"memory=normal"			""			\
+	"memory=low"			""			\
+	"age_extent_cache"		""			\
+	"errors=panic"			""			\
+	"errors=continue"		""			\
+	"errors=remount-ro"		""			\
+	"nat_bits"			""			\
+	"atgc,mode=lfs"			""			\
+	"ro,flush_merge"		""			\
+	"rw"				"ro"			\
+	"norecovery,ro"			""			\
+)
+
+for ((i=0;i<${#options[@]};i=i+2))
+do
+	echo "Option#$i: ${options[$i]} : ${options[$((i+1))]}"
+
+	if [ "${options[$((i+1))]}" ]; then
+		_scratch_mkfs "-O ${options[$((i+1))]}" >> $seqres.full || _fail "mkfs failed"
+	else
+		_scratch_mkfs >> $seqres.full || _fail "mkfs failed"
+	fi
+	_try_scratch_mount "-o ${options[$i]}" >> $seqres.full 2>&1
+	echo $?
+	_scratch_unmount >> $seqres.full 2>&1
+done
+
+status=0
+exit
diff --git a/tests/f2fs/015.out b/tests/f2fs/015.out
new file mode 100644
index 00000000..8d6712f0
--- /dev/null
+++ b/tests/f2fs/015.out
@@ -0,0 +1,173 @@
+QA output created by 015
+Option#0: background_gc=on : 
+0
+Option#2: background_gc=off : 
+0
+Option#4: background_gc=sync : 
+0
+Option#6: disable_roll_forward : 
+0
+Option#8: norecovery : 
+32
+Option#10: discard : 
+0
+Option#12: nodiscard : 
+0
+Option#14: no_heap : 
+0
+Option#16: heap : 
+0
+Option#18: user_xattr : 
+0
+Option#20: nouser_xattr : 
+0
+Option#22: acl : 
+0
+Option#24: noacl : 
+0
+Option#26: active_logs=2 : 
+0
+Option#28: active_logs=4 : 
+0
+Option#30: active_logs=6 : 
+0
+Option#32: disable_ext_identify : 
+0
+Option#34: inline_xattr : 
+0
+Option#36: noinline_xattr : 
+0
+Option#38: inline_xattr_size=400 : 
+0
+Option#40: inline_data : 
+0
+Option#42: noinline_dentry : 
+0
+Option#44: inline_dentry : 
+0
+Option#46: noinline_dentry : 
+0
+Option#48: flush_merge : 
+0
+Option#50: noflush_merge : 
+0
+Option#52: barrier : 
+0
+Option#54: nobarrier : 
+0
+Option#56: fastboot : 
+0
+Option#58: extent_cache : 
+0
+Option#60: noextent_cache : 
+0
+Option#62: data_flush : 
+0
+Option#64: reserve_root=32768 : 
+0
+Option#66: resuid=1000 : 
+0
+Option#68: resgid=1000 : 
+0
+Option#70: fault_injection=100 : 
+0
+Option#72: fault_type=4095 : 
+0
+Option#74: mode=adaptive : 
+0
+Option#76: mode=lfs : 
+0
+Option#78: mode=fragment:segment : 
+0
+Option#80: mode=fragment:block : 
+0
+Option#82: usrquota : 
+0
+Option#84: grpquota : 
+0
+Option#86: prjquota : 
+32
+Option#88: usrjquota=ausrquota : 
+32
+Option#90: grpjquota=agrpquota : 
+32
+Option#92: prjjquota=aprjquota : 
+32
+Option#94: jqfmt=vfsold : 
+0
+Option#96: jqfmt=vfsv0 : 
+0
+Option#98: jqfmt=vfsv1 : 
+0
+Option#100: usrjquota= : 
+0
+Option#102: grpjquota= : 
+0
+Option#104: prjjquota= : 
+0
+Option#106: quota : 
+0
+Option#108: noquota : 
+0
+Option#110: alloc_mode=reuse : 
+0
+Option#112: alloc_mode=default : 
+0
+Option#114: fsync_mode=posix : 
+0
+Option#116: fsync_mode=strict : 
+0
+Option#118: fsync_mode=nobarrier : 
+0
+Option#120: test_dummy_encryption : 
+0
+Option#122: test_dummy_encryption=v1 : 
+0
+Option#124: test_dummy_encryption=v2 : 
+0
+Option#126: checkpoint=enable : 
+0
+Option#128: checkpoint=disable : 
+0
+Option#130: checkpoint=disable:32768 : 
+0
+Option#132: checkpoint=disable:50% : 
+0
+Option#134: checkpoint_merge : 
+0
+Option#136: nocheckpoint_merge : 
+0
+Option#138: compress_algorithm=lzo : 
+0
+Option#140: inlinecrypt : 
+0
+Option#142: atgc : 
+0
+Option#144: discard_unit=block : 
+0
+Option#146: discard_unit=segment : 
+0
+Option#148: discard_unit=section : 
+0
+Option#150: memory=normal : 
+0
+Option#152: memory=low : 
+0
+Option#154: age_extent_cache : 
+0
+Option#156: errors=panic : 
+0
+Option#158: errors=continue : 
+0
+Option#160: errors=remount-ro : 
+0
+Option#162: nat_bits : 
+0
+Option#164: atgc,mode=lfs : 
+32
+Option#166: ro,flush_merge : 
+32
+Option#168: rw : ro
+0
+Option#170: norecovery,ro : 
+0
-- 
2.49.0

