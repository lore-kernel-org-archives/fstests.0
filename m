Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C132673B7
	for <fstests@vger.kernel.org>; Wed,  2 Jul 2025 11:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751454209; cv=none; b=OxMzKwv8ygKtV0aUnkuXV2l6lcEKnAHADc169QHZdw8uhQ3oqUW+gZrEjyCpBXnzVdONSyfn7olA9F3z++pFpU/H+kJ63PD5KUQaWsFIhvVRBP6gbG8+ZT2XEHtHMhJk6YDFgV+lx7LomBqMbe6Itw266ylA5jsb3Xcs8m1GRPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751454209; c=relaxed/simple;
	bh=1ejaeF3d+CsdtlVB90ag4XAq4kvdFO3BaHrUfsuNpWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G5BXbNw4ENZtPkCuqzeBlK6WENw9FMILqyXwBGt15+XdjXRZ98KU1nOZUIRttJrIy/1q4P9gtMXWpU3+ddrz6f3T1G1610hzYSq0MiTreKbScAqgL3gYrB86B8EIbkAzSXZAYZD0vwv55KaUDqG8ufSXePNAUWrRBb5AXbPUtEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VyRSg2tO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VyRSg2tO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8751C4CEF0;
	Wed,  2 Jul 2025 11:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751454208;
	bh=1ejaeF3d+CsdtlVB90ag4XAq4kvdFO3BaHrUfsuNpWU=;
	h=From:To:Cc:Subject:Date:From;
	b=VyRSg2tO0BUI4Cxe2ULHBodVAeHLeFW4NUotqvyKvRTCPl9p1M8wF+4LiX63j39dt
	 pfV4Ac3esFQk6a+EPekJsvonarqkiD96BHzDV/0/684eHVt0m4khRAuxoBsZKqrECx
	 jnkzK9EWK2teJA5pfveX3rmgVXzFrBIEpHi8cl88qxR4mRqCu3dTpGTlTgrcnNTkhw
	 WEMjI3OA2NJMnhdBZ2EFjfnsrEp2zBXhMoTtMZxCtLVohcmLyefNOlLqcxGFEPAv1A
	 KKh9pqeE09pBILUa3K6/ofWIeW4N0B6yQ8jpe+hl/TUfY6FoyhcAH47sbKo5W1tuyo
	 n6ASTpSMeD7Aw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs/015: test mount options
Date: Wed,  2 Jul 2025 19:02:04 +0800
Message-ID: <20250702110204.1063796-1-chao@kernel.org>
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
 tests/f2fs/015     | 141 ++++++++++++++++++++++++++++++
 tests/f2fs/015.out | 207 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 348 insertions(+)
 create mode 100755 tests/f2fs/015
 create mode 100644 tests/f2fs/015.out

diff --git a/tests/f2fs/015 b/tests/f2fs/015
new file mode 100755
index 00000000..86f0ef9e
--- /dev/null
+++ b/tests/f2fs/015
@@ -0,0 +1,141 @@
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
+_require_scratch
+
+options=(
+#	mount_option			mkfs_option
+	"background_gc=on"		""			\
+	"background_gc=off"		""			\
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
+	"compress_algorithm=ztsd:1"	"extra,compression"	\
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
+	_scratch_mkfs "-O ${options[$((i+1))]}" >> $seqres.full
+	_try_scratch_mount "-o ${options[$i]}" >> $seqres.full 2>&1
+	echo $?
+	_scratch_unmount
+done
+
+status=0
+exit
diff --git a/tests/f2fs/015.out b/tests/f2fs/015.out
new file mode 100644
index 00000000..83e6ad51
--- /dev/null
+++ b/tests/f2fs/015.out
@@ -0,0 +1,207 @@
+QA output created by 015
+Option#0: background_gc=on : 
+0
+Option#2: background_gc=off : 
+0
+Option#4: background_gc=off : 
+0
+Option#6: background_gc=sync : 
+0
+Option#8: disable_roll_forward : 
+0
+Option#10: norecovery : 
+32
+Option#12: discard : 
+0
+Option#14: nodiscard : 
+0
+Option#16: no_heap : 
+0
+Option#18: heap : 
+0
+Option#20: user_xattr : 
+0
+Option#22: nouser_xattr : 
+0
+Option#24: acl : 
+0
+Option#26: noacl : 
+0
+Option#28: active_logs=2 : 
+0
+Option#30: active_logs=4 : 
+0
+Option#32: active_logs=6 : 
+0
+Option#34: disable_ext_identify : 
+0
+Option#36: inline_xattr : 
+0
+Option#38: noinline_xattr : 
+0
+Option#40: inline_xattr_size=400 : extra,flexible_inline_xattr
+0
+Option#42: inline_xattr_size=400 : 
+0
+Option#44: inline_data : 
+0
+Option#46: noinline_dentry : 
+0
+Option#48: inline_dentry : 
+0
+Option#50: noinline_dentry : 
+0
+Option#52: flush_merge : 
+0
+Option#54: noflush_merge : 
+0
+Option#56: barrier : 
+0
+Option#58: nobarrier : 
+0
+Option#60: fastboot : 
+0
+Option#62: extent_cache : 
+0
+Option#64: noextent_cache : 
+0
+Option#66: data_flush : 
+0
+Option#68: reserve_root=32768 : 
+0
+Option#70: resuid=1000 : 
+0
+Option#72: resgid=1000 : 
+0
+Option#74: fault_injection=100 : 
+0
+Option#76: fault_type=4095 : 
+0
+Option#78: mode=adaptive : 
+0
+Option#80: mode=lfs : 
+0
+Option#82: mode=fragment:segment : 
+0
+Option#84: mode=fragment:block : 
+0
+Option#86: usrquota : 
+0
+Option#88: grpquota : 
+0
+Option#90: prjquota : 
+32
+Option#92: usrjquota=ausrquota : 
+32
+Option#94: grpjquota=agrpquota : 
+32
+Option#96: prjjquota=aprjquota : 
+32
+Option#98: jqfmt=vfsold : 
+0
+Option#100: jqfmt=vfsv0 : 
+0
+Option#102: jqfmt=vfsv1 : 
+0
+Option#104: usrjquota= : 
+0
+Option#106: grpjquota= : 
+0
+Option#108: prjjquota= : 
+0
+Option#110: quota : 
+0
+Option#112: noquota : 
+0
+Option#114: alloc_mode=reuse : 
+0
+Option#116: alloc_mode=default : 
+0
+Option#118: fsync_mode=posix : 
+0
+Option#120: fsync_mode=strict : 
+0
+Option#122: fsync_mode=nobarrier : 
+0
+Option#124: test_dummy_encryption : 
+0
+Option#126: test_dummy_encryption=v1 : 
+0
+Option#128: test_dummy_encryption=v2 : 
+0
+Option#130: checkpoint=enable : 
+0
+Option#132: checkpoint=disable : 
+0
+Option#134: checkpoint=disable:32768 : 
+0
+Option#136: checkpoint=disable:50% : 
+0
+Option#138: checkpoint_merge : 
+0
+Option#140: nocheckpoint_merge : 
+0
+Option#142: compress_algorithm=lzo : 
+0
+Option#144: compress_algorithm=lzo : extra,compression
+0
+Option#146: compress_algorithm=lz4 : extra,compression
+0
+Option#148: compress_algorithm=zstd : extra,compression
+0
+Option#150: compress_algorithm=lzo-rle : extra,compression
+0
+Option#152: compress_algorithm=lz4:3 : extra,compression
+0
+Option#154: compress_algorithm=ztsd:1 : extra,compression
+32
+Option#156: compress_log_size=8 : extra,compression
+0
+Option#158: compress_extension=so : extra,compression
+0
+Option#160: nocompress_extension=so : extra,compression
+0
+Option#162: nocompress_extension=* : extra,compression
+32
+Option#164: compress_extension=so,nocompress_extension=so : extra,compression
+32
+Option#166: compress_chksum : extra,compression
+0
+Option#168: compress_mode=fs : extra,compression
+0
+Option#170: compress_mode=user : extra,compression
+0
+Option#172: compress_cache : extra,compression
+0
+Option#174: inlinecrypt : 
+0
+Option#176: atgc : 
+0
+Option#178: discard_unit=block : 
+0
+Option#180: discard_unit=segment : 
+0
+Option#182: discard_unit=section : 
+0
+Option#184: memory=normal : 
+0
+Option#186: memory=low : 
+0
+Option#188: age_extent_cache : 
+0
+Option#190: errors=panic : 
+0
+Option#192: errors=continue : 
+0
+Option#194: errors=remount-ro : 
+0
+Option#196: nat_bits : 
+0
+Option#198: atgc,mode=lfs : 
+32
+Option#200: ro,flush_merge : 
+32
+Option#202: rw : ro
+0
+Option#204: norecovery,ro : 
+0
-- 
2.49.0

