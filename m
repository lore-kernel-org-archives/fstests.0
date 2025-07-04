Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E40246798
	for <fstests@vger.kernel.org>; Fri,  4 Jul 2025 11:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751629728; cv=none; b=YZIemq3T8DmGyx7Lhd7vRFLujIqlmOh5IcVHWwmUnLCvUV37RWTHVD8TY3Cuy6h+PPlm4PZc655f1AffwvFMpTlJjQZK3bEOXZ32iFA5Dtv8mK+aMotcl6ceEKZNCB5Rvuvfk/kWg1h+gvO066hshdujIZEd3Hy20uoQfbbFpZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751629728; c=relaxed/simple;
	bh=v8oYqlQcWgUn8VtLMsN9ZNS+mEN6ulsKMdnTfoWan6c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GXN51+MYv/O04HFZPeB2ssIVUva6YjHxtoDrH6exikms/LLJ3vBZ3/9isKzq+1dLVh+PK8EI6RWgtWvYyAbwhARmaeKabNnervR7H6fycjG9XJBq6HlUcRK/T4WsjYB9nVjIzp5FTG8XmnGaw2t83V50mWUpZG0LrIE6oWdtoCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=js2JgbdF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="js2JgbdF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7C9C4CEE3;
	Fri,  4 Jul 2025 11:48:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751629727;
	bh=v8oYqlQcWgUn8VtLMsN9ZNS+mEN6ulsKMdnTfoWan6c=;
	h=From:To:Cc:Subject:Date:From;
	b=js2JgbdFd29ohx1Mgv/U/LCs4snntEdOIrZgIuDMdGBkCtgRzukqFt7+9oSUG9SBl
	 dD2tFN9raYGMvYlVq0VGZVituYQBvCc3gG9fFlIsPpniw65atCS00jCIS137A4kT0a
	 pyekR1kuZOb0EZ5SASgm6S3qy6D/zt37aTa20S4/6frRcoWMGNpNnQghCeI7Ih1BqK
	 9XV4HNWLy8BEZf+1NH9Cm2G4g6CNdfwK30Eeg/t5mSojtF5gzXAS4LFbzWyBe2r+6H
	 XbfjJGB7gmEyhdo4yuAPvRgTDQS8N2ZxcVP5QJ+exHRSHxEfFVifvz2STwf0LcgqIM
	 Jp2mmwc8NIllg==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] f2fs/015: test mount options
Date: Fri,  4 Jul 2025 19:48:18 +0800
Message-ID: <20250704114818.1878294-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As f2fs changes to use new mount APIs, let's add a new testcase
to check mount result for all f2fs supported mount options and
their combinations, in order to detect any inconsistency during
mount.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- allow to check mount options w/ zoned device
 common/rc          |   3 +
 tests/f2fs/015     | 159 ++++++++++++++++++++++++++++++++
 tests/f2fs/015.out | 225 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 387 insertions(+)
 create mode 100755 tests/f2fs/015
 create mode 100644 tests/f2fs/015.out

diff --git a/common/rc b/common/rc
index f71cc8f0..94fdce7e 100644
--- a/common/rc
+++ b/common/rc
@@ -844,6 +844,9 @@ _test_mkfs()
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
index 00000000..746e79de
--- /dev/null
+++ b/tests/f2fs/015
@@ -0,0 +1,159 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/015
+#
+# This testcase tries to check stability of mount result
+# w/ all f2fs supported mount option and their combination.
+#
+. ./common/preamble
+_begin_fstest auto quick
+_require_kernel_config CONFIG_F2FS_FS_XATTR
+_require_kernel_config CONFIG_F2FS_FS_POSIX_ACL
+_require_kernel_config CONFIG_F2FS_FAULT_INJECTION
+_require_kernel_config CONFIG_F2FS_FS_COMPRESSION
+_require_kernel_config CONFIG_F2FS_FS_LZO
+_require_kernel_config CONFIG_F2FS_FS_LZORLE
+_require_kernel_config CONFIG_F2FS_FS_LZ4
+_require_kernel_config CONFIG_F2FS_FS_LZ4HC
+_require_kernel_config CONFIG_F2FS_FS_ZSTD
+
+_require_zoned_device "$TEST_DEV"
+_test_unmount >> $seqres.full 2>&1
+
+options=(
+#	mount_option			mkfs_option
+	"background_gc=on"		""			\
+	"background_gc=off"		""			\
+	"background_gc=sync"		""			\
+	"background_gc=on"		"blkzone"		\
+	"background_gc=off"		"blkzone"		\
+	"background_gc=sync"		"blkzone"		\
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
+	"inline_xattr_size=400"		"extra,flexible_inline_xattr"\
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
+	"mode=adaptive"			"blkzone"		\
+	"mode=lfs"			"blkzone"		\
+	"mode=fragment:segment"		"blkzone"		\
+	"mode=fragment:block"		"blkzone"		\
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
+	"compress_algorithm=lzo"	"extra,compression"	\
+	"compress_algorithm=lz4"	"extra,compression"	\
+	"compress_algorithm=zstd"	"extra,compression"	\
+	"compress_algorithm=lzo-rle"	"extra,compression"	\
+	"compress_algorithm=lz4:3"	"extra,compression"	\
+	"compress_algorithm=zstd:1"	"extra,compression"	\
+	"compress_log_size=8"		"extra,compression"	\
+	"compress_extension=so"		"extra,compression"	\
+	"nocompress_extension=so"	"extra,compression"	\
+	"nocompress_extension=*"	"extra,compression"	\
+	"compress_extension=so,nocompress_extension=so"		\
+					"extra,compression"	\
+	"compress_chksum"		"extra,compression"	\
+	"compress_mode=fs"		"extra,compression"	\
+	"compress_mode=user"		"extra,compression"	\
+	"compress_cache"		"extra,compression"	\
+	"inlinecrypt"			""			\
+	"atgc"				""			\
+	"discard_unit=block"		""			\
+	"discard_unit=segment"		""			\
+	"discard_unit=section"		""			\
+	"discard_unit=block"		"blkzone"		\
+	"discard_unit=segment"		"blkzone"		\
+	"discard_unit=section"		"blkzone"		\
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
+	if [ "${options[$((i+1))]}" == "blkzone" ]; then
+		_test_mkfs "-m" >> $seqres.full
+		_test_mount "-o ${options[$i]}" >> $seqres.full 2>&1
+		echo $?
+		_test_unmount >> $seqres.full 2>&1
+	else
+		_scratch_mkfs "-O ${options[$((i+1))]}" >> $seqres.full
+		_try_scratch_mount "-o ${options[$i]}" >> $seqres.full 2>&1
+		echo $?
+		_scratch_unmount >> $seqres.full 2>&1
+	fi
+done
+
+status=0
+exit
diff --git a/tests/f2fs/015.out b/tests/f2fs/015.out
new file mode 100644
index 00000000..d7f4e62a
--- /dev/null
+++ b/tests/f2fs/015.out
@@ -0,0 +1,225 @@
+QA output created by 015
+Option#0: background_gc=on : 
+0
+Option#2: background_gc=off : 
+0
+Option#4: background_gc=sync : 
+0
+Option#6: background_gc=on : blkzone
+0
+Option#8: background_gc=off : blkzone
+32
+Option#10: background_gc=sync : blkzone
+0
+Option#12: disable_roll_forward : 
+0
+Option#14: norecovery : 
+32
+Option#16: discard : 
+0
+Option#18: nodiscard : 
+0
+Option#20: no_heap : 
+0
+Option#22: heap : 
+0
+Option#24: user_xattr : 
+0
+Option#26: nouser_xattr : 
+0
+Option#28: acl : 
+0
+Option#30: noacl : 
+0
+Option#32: active_logs=2 : 
+0
+Option#34: active_logs=4 : 
+0
+Option#36: active_logs=6 : 
+0
+Option#38: disable_ext_identify : 
+0
+Option#40: inline_xattr : 
+0
+Option#42: noinline_xattr : 
+0
+Option#44: inline_xattr_size=400 : extra,flexible_inline_xattr
+32
+Option#46: inline_xattr_size=400 : 
+32
+Option#48: inline_data : 
+0
+Option#50: noinline_dentry : 
+0
+Option#52: inline_dentry : 
+0
+Option#54: noinline_dentry : 
+0
+Option#56: flush_merge : 
+0
+Option#58: noflush_merge : 
+0
+Option#60: barrier : 
+0
+Option#62: nobarrier : 
+0
+Option#64: fastboot : 
+0
+Option#66: extent_cache : 
+0
+Option#68: noextent_cache : 
+0
+Option#70: data_flush : 
+0
+Option#72: reserve_root=32768 : 
+0
+Option#74: resuid=1000 : 
+0
+Option#76: resgid=1000 : 
+0
+Option#78: fault_injection=100 : 
+0
+Option#80: fault_type=4095 : 
+0
+Option#82: mode=adaptive : 
+0
+Option#84: mode=lfs : 
+0
+Option#86: mode=fragment:segment : 
+0
+Option#88: mode=fragment:block : 
+0
+Option#90: mode=adaptive : blkzone
+32
+Option#92: mode=lfs : blkzone
+0
+Option#94: mode=fragment:segment : blkzone
+32
+Option#96: mode=fragment:block : blkzone
+32
+Option#98: usrquota : 
+0
+Option#100: grpquota : 
+0
+Option#102: prjquota : 
+32
+Option#104: usrjquota=ausrquota : 
+32
+Option#106: grpjquota=agrpquota : 
+32
+Option#108: prjjquota=aprjquota : 
+32
+Option#110: jqfmt=vfsold : 
+0
+Option#112: jqfmt=vfsv0 : 
+0
+Option#114: jqfmt=vfsv1 : 
+0
+Option#116: usrjquota= : 
+0
+Option#118: grpjquota= : 
+0
+Option#120: prjjquota= : 
+0
+Option#122: quota : 
+0
+Option#124: noquota : 
+0
+Option#126: alloc_mode=reuse : 
+0
+Option#128: alloc_mode=default : 
+0
+Option#130: fsync_mode=posix : 
+0
+Option#132: fsync_mode=strict : 
+0
+Option#134: fsync_mode=nobarrier : 
+0
+Option#136: test_dummy_encryption : 
+32
+Option#138: test_dummy_encryption=v1 : 
+32
+Option#140: test_dummy_encryption=v2 : 
+32
+Option#142: checkpoint=enable : 
+0
+Option#144: checkpoint=disable : 
+0
+Option#146: checkpoint=disable:32768 : 
+0
+Option#148: checkpoint=disable:50% : 
+0
+Option#150: checkpoint_merge : 
+0
+Option#152: nocheckpoint_merge : 
+0
+Option#154: compress_algorithm=lzo : 
+0
+Option#156: compress_algorithm=lzo : extra,compression
+0
+Option#158: compress_algorithm=lz4 : extra,compression
+0
+Option#160: compress_algorithm=zstd : extra,compression
+0
+Option#162: compress_algorithm=lzo-rle : extra,compression
+0
+Option#164: compress_algorithm=lz4:3 : extra,compression
+0
+Option#166: compress_algorithm=zstd:1 : extra,compression
+0
+Option#168: compress_log_size=8 : extra,compression
+0
+Option#170: compress_extension=so : extra,compression
+0
+Option#172: nocompress_extension=so : extra,compression
+0
+Option#174: nocompress_extension=* : extra,compression
+0
+Option#176: compress_extension=so,nocompress_extension=so : extra,compression
+0
+Option#178: compress_chksum : extra,compression
+0
+Option#180: compress_mode=fs : extra,compression
+0
+Option#182: compress_mode=user : extra,compression
+0
+Option#184: compress_cache : extra,compression
+0
+Option#186: inlinecrypt : 
+0
+Option#188: atgc : 
+0
+Option#190: discard_unit=block : 
+0
+Option#192: discard_unit=segment : 
+0
+Option#194: discard_unit=section : 
+0
+Option#196: discard_unit=block : blkzone
+0
+Option#198: discard_unit=segment : blkzone
+0
+Option#200: discard_unit=section : blkzone
+0
+Option#202: memory=normal : 
+0
+Option#204: memory=low : 
+0
+Option#206: age_extent_cache : 
+0
+Option#208: errors=panic : 
+0
+Option#210: errors=continue : 
+0
+Option#212: errors=remount-ro : 
+0
+Option#214: nat_bits : 
+0
+Option#216: atgc,mode=lfs : 
+32
+Option#218: ro,flush_merge : 
+32
+Option#220: rw : ro
+0
+Option#222: norecovery,ro : 
+0
-- 
2.49.0

