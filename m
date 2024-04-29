Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AA3823A2
	for <fstests@vger.kernel.org>; Mon, 29 Apr 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714405142; cv=none; b=BnyOmzb6K3oKX9Oxny2m0pZFuXzuA3GYM0GASlXIHEwg6tJMZV2eREaD6O0M48quZ/jtLmU0Ec2SY4/a60HnkEfcFOlBqFeLA2Y1Kyf0h4BCXmVQaJ1O30dFXFu7BjZOo0RG9zgOHlJdQMwltVuDQSfb03BP0L/YYGZyynkOBxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714405142; c=relaxed/simple;
	bh=rvIMZRBKpG1MDP+W8VVswgzxeOwFN4d9k2YwGaJQ7zo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V1rIQj6BfS8gEogtPVNHOCG+xsCiqRs73FIM+Avx0oEgGIFRxcwTV1OBhBRIio4U2wz+85Z22uLP52cf1mUcPTqzvAQwIDZoxzXrQvjiYFxmkYjjTZDmc8MWemXKIehe/+C86VWDe9hIeIpQCVqV4vmhYS1QKppXRV2DG90ko3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zOZK0UkQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=m6JtuBqC; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TesbSOTy; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ew21O9su; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zOZK0UkQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="m6JtuBqC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TesbSOTy";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ew21O9su"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F14161F44B;
	Mon, 29 Apr 2024 15:38:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714405139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qzGJLuokmXfHuQi8N4t3f3RtVjJPGZbgl2iY8J3dj74=;
	b=zOZK0UkQVA2w/DEwDc3Y4QYsMiT2EBeOcHeUma0mMr8/DHh8sYgms11Q5Dv+2qLHrxrcGu
	BJV3I+x1/mKqrz5jnitbOZ5IxCXXVZKCfGWtlPKJeJYU5799jtNetVRUuiyumComopG0fi
	t2Ucrj7Qp7C4oYJOy5SmUn487CpLKX8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714405139;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qzGJLuokmXfHuQi8N4t3f3RtVjJPGZbgl2iY8J3dj74=;
	b=m6JtuBqCMTAnMdyEJCEPOK5cLh3B317M9VaGF+QNk3vSW0uGYo0NMYZUHBqfSAP+rkUK8y
	H/DgN8w+2KaQNiBA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TesbSOTy;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Ew21O9su
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1714405138; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qzGJLuokmXfHuQi8N4t3f3RtVjJPGZbgl2iY8J3dj74=;
	b=TesbSOTyOXP/qo/xUq6GCJYKi57ifTXAQW/oWK+zz27W189Koq4JaZaRYWZCTSKz93KnWn
	9w1UZ2brphIiWdE3RsKembY5WB/VzcPAHXv/2zbSLtrO32QfkohJdlnoTN9hsTk+LW/5nu
	z+o7blm24OkiY7C41hE+6kp4NvZtH9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1714405138;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=qzGJLuokmXfHuQi8N4t3f3RtVjJPGZbgl2iY8J3dj74=;
	b=Ew21O9suFIqkz7xSQlmbsTVi/dtzqB64eZBzd9gxnZ+xaUYs1zPYHxW6dGNGQpu5XB5Avq
	wcgMtAzmiDEx3qCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 680E8138A7;
	Mon, 29 Apr 2024 15:38:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tOkDBxG/L2aDIgAAD6G6ig
	(envelope-from <ddiss@suse.de>); Mon, 29 Apr 2024 15:38:57 +0000
From: David Disseldorp <ddiss@suse.de>
To: fstests@vger.kernel.org
Cc: David Disseldorp <ddiss@suse.de>,
	"Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3] tests: _fail on _scratch_mkfs_sized failure
Date: Tue, 30 Apr 2024 01:37:52 +1000
Message-Id: <20240429153751.23515-1-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-5.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F14161F44B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Score: -5.01

If _scratch_mkfs_sized() fails, e.g. due to an FS not supporting the
provided size, tests may subsequently mount and run atop a previously
created (e.g. non-size-bound) filesystem.
This can lead to difficult to debug failures, or for some -ENOSPC
exercising tests, near infinite runtimes. Avoid this by renaming the
current function to _try_scratch_mkfs_sized() and _fail in the parent
_scratch_mkfs_sized() wrapper.

Suggested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: David Disseldorp <ddiss@suse.de>
---
Changes since v2:
- drop existing test-specific _scratch_mkfs_sized() error handlers
Changes since v1:
- call _fail in a wrapper function, instead of adding failure handlers
  to individual test _scratch_mkfs_sized() callers.

 common/rc         | 9 +++++++--
 tests/btrfs/004   | 3 +--
 tests/btrfs/007   | 3 +--
 tests/ext4/021    | 2 +-
 tests/ext4/059    | 2 +-
 tests/generic/015 | 3 +--
 tests/generic/077 | 2 +-
 tests/generic/083 | 3 +--
 tests/generic/171 | 2 +-
 tests/generic/172 | 2 +-
 tests/generic/173 | 2 +-
 tests/generic/174 | 2 +-
 tests/generic/735 | 2 +-
 tests/xfs/015     | 2 +-
 tests/xfs/057     | 3 +--
 15 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/common/rc b/common/rc
index 56f1afb6..c3def066 100644
--- a/common/rc
+++ b/common/rc
@@ -968,8 +968,8 @@ _small_fs_size_mb()
 }
 
 # Create fs of certain size on scratch device
-# _scratch_mkfs_sized <size in bytes> [optional blocksize]
-_scratch_mkfs_sized()
+# _try_scratch_mkfs_sized <size in bytes> [optional blocksize]
+_try_scratch_mkfs_sized()
 {
 	local fssize=$1
 	local blocksize=$2
@@ -1111,6 +1111,11 @@ _scratch_mkfs_sized()
 	esac
 }
 
+_scratch_mkfs_sized()
+{
+	_try_scratch_mkfs_sized $* || _fail "_scratch_mkfs_sized (size=${1}) failed"
+}
+
 # Emulate an N-data-disk stripe w/ various stripe units
 # _scratch_mkfs_geom <sunit bytes> <swidth multiplier> [optional blocksize]
 _scratch_mkfs_geom()
diff --git a/tests/btrfs/004 b/tests/btrfs/004
index 00a516c3..684f5fdf 100755
--- a/tests/btrfs/004
+++ b/tests/btrfs/004
@@ -157,8 +157,7 @@ workout()
 	_scratch_unmount >/dev/null 2>&1
 	echo "*** mkfs -dsize=$fsz"    >>$seqres.full
 	echo ""                                     >>$seqres.full
-	_scratch_mkfs_sized $fsz >>$seqres.full 2>&1 \
-		|| _fail "size=$fsz mkfs failed"
+	_scratch_mkfs_sized $fsz >>$seqres.full 2>&1
 	_scratch_mount
 	# -w ensures that the only ops are ones which cause write I/O
 	run_check $FSSTRESS_PROG -d $SCRATCH_MNT -w -p $procs -n 2000 \
diff --git a/tests/btrfs/007 b/tests/btrfs/007
index 333524e2..a3a5b185 100755
--- a/tests/btrfs/007
+++ b/tests/btrfs/007
@@ -43,8 +43,7 @@ workout()
 	_scratch_unmount >/dev/null 2>&1
 	echo "*** mkfs -dsize=$fsz"    >>$seqres.full
 	echo ""                                     >>$seqres.full
-	_scratch_mkfs_sized $fsz >>$seqres.full 2>&1 \
-		|| _fail "size=$fsz mkfs failed"
+	_scratch_mkfs_sized $fsz >>$seqres.full 2>&1
 	_scratch_mount "-o noatime"
 
 	run_check $FSSTRESS_PROG -d $SCRATCH_MNT -n $ops $FSSTRESS_AVOID -x \
diff --git a/tests/ext4/021 b/tests/ext4/021
index a9277abf..62768c60 100755
--- a/tests/ext4/021
+++ b/tests/ext4/021
@@ -24,7 +24,7 @@ _scratch_unmount
 
 # With 4k block size, this amounts to 10M FS instance.
 fssize=$((2560 * $blocksize))
-_scratch_mkfs_sized $fssize >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mkfs_sized $fssize >> $seqres.full 2>&1
 _require_metadata_journaling $SCRATCH_DEV
 
 offset=0
diff --git a/tests/ext4/059 b/tests/ext4/059
index 4230bde9..f4864ffc 100755
--- a/tests/ext4/059
+++ b/tests/ext4/059
@@ -23,7 +23,7 @@ _require_scratch_size_nocheck $((1024 * 1024))
 # Initalize a 512M ext4 fs with resize_inode feature disabled
 dev_size=$((512 * 1024 * 1024))
 MKFS_OPTIONS="-O ^resize_inode $MKFS_OPTIONS" _scratch_mkfs_sized $dev_size \
-	>>$seqres.full 2>&1 || _fail "mkfs failed"
+	>>$seqres.full 2>&1
 
 # Force some reserved GDT blocks to trigger the bug
 $DEBUGFS_PROG -w -R "set_super_value s_reserved_gdt_blocks 100" $SCRATCH_DEV \
diff --git a/tests/generic/015 b/tests/generic/015
index 10423a29..716a7b1f 100755
--- a/tests/generic/015
+++ b/tests/generic/015
@@ -31,8 +31,7 @@ _require_no_large_scratch_dev
 
 # btrfs needs at least 256MB (with upward round off) to create a non-mixed mode
 # fs. Ref: btrfs-progs: btrfs_min_dev_size()
-_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1 \
-    || _fail "mkfs failed"
+_scratch_mkfs_sized $((256 * 1024 * 1024)) >> $seqres.full 2>&1
 _scratch_mount
 out=$SCRATCH_MNT/fillup.$$
 
diff --git a/tests/generic/077 b/tests/generic/077
index 94d89fae..2624e88f 100755
--- a/tests/generic/077
+++ b/tests/generic/077
@@ -50,7 +50,7 @@ _scratch_unmount >/dev/null 2>&1
 echo "*** MKFS ***"                         >>$seqres.full
 echo ""                                     >>$seqres.full
 fs_size=$((256 * 1024 * 1024))
-_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1
 _scratch_mount
 mkdir $SCRATCH_MNT/subdir
 
diff --git a/tests/generic/083 b/tests/generic/083
index 2a5af3cc..4cd1c399 100755
--- a/tests/generic/083
+++ b/tests/generic/083
@@ -50,8 +50,7 @@ workout()
 		_scratch_mkfs_xfs -dsize=$fsz,agcount=$ags  >>$seqres.full 2>&1 \
 			|| _fail "size=$fsz,agcount=$ags mkfs failed"
 	else
-		_scratch_mkfs_sized $fsz >>$seqres.full 2>&1 \
-			|| _fail "size=$fsz mkfs failed"
+		_scratch_mkfs_sized $fsz >>$seqres.full 2>&1
 	fi
 	_scratch_mount
 
diff --git a/tests/generic/171 b/tests/generic/171
index f823a454..fb2a6f14 100755
--- a/tests/generic/171
+++ b/tests/generic/171
@@ -42,7 +42,7 @@ sz_bytes=$((nr_blks * 8 * blksz))
 if [ $sz_bytes -lt $((32 * 1048576)) ]; then
 	sz_bytes=$((32 * 1048576))
 fi
-_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 rm -rf $testdir
 mkdir $testdir
diff --git a/tests/generic/172 b/tests/generic/172
index 383824b9..ab5122fa 100755
--- a/tests/generic/172
+++ b/tests/generic/172
@@ -40,7 +40,7 @@ umount $SCRATCH_MNT
 
 file_size=$((768 * 1024 * 1024))
 fs_size=$((1024 * 1024 * 1024))
-_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 rm -rf $testdir
 mkdir $testdir
diff --git a/tests/generic/173 b/tests/generic/173
index e1493278..0eb313e2 100755
--- a/tests/generic/173
+++ b/tests/generic/173
@@ -42,7 +42,7 @@ sz_bytes=$((nr_blks * 8 * blksz))
 if [ $sz_bytes -lt $((32 * 1048576)) ]; then
 	sz_bytes=$((32 * 1048576))
 fi
-_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 rm -rf $testdir
 mkdir $testdir
diff --git a/tests/generic/174 b/tests/generic/174
index c7a177b8..1505453e 100755
--- a/tests/generic/174
+++ b/tests/generic/174
@@ -43,7 +43,7 @@ sz_bytes=$((nr_blks * 8 * blksz))
 if [ $sz_bytes -lt $((32 * 1048576)) ]; then
 	sz_bytes=$((32 * 1048576))
 fi
-_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
 _scratch_mount >> $seqres.full 2>&1
 rm -rf $testdir
 mkdir $testdir
diff --git a/tests/generic/735 b/tests/generic/735
index 0ba111a6..89107a61 100755
--- a/tests/generic/735
+++ b/tests/generic/735
@@ -25,7 +25,7 @@ _require_xfs_io_command "falloc"
 _require_xfs_io_command "finsert"
 
 dev_size=$((80 * 1024 * 1024))
-_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1 || _fail "mkfs failed"
+_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1
 
 _scratch_mount
 _require_congruent_file_oplen $SCRATCH_MNT 1048576	# finsert at 1M
diff --git a/tests/xfs/015 b/tests/xfs/015
index a7f4d243..3896ce1c 100755
--- a/tests/xfs/015
+++ b/tests/xfs/015
@@ -43,7 +43,7 @@ _scratch_mount
 _require_fs_space $SCRATCH_MNT 196608
 _scratch_unmount
 
-_scratch_mkfs_sized $((96 * 1024 * 1024)) > $tmp.mkfs.raw || _fail "mkfs failed"
+_scratch_mkfs_sized $((96 * 1024 * 1024)) > $tmp.mkfs.raw
 cat $tmp.mkfs.raw | _filter_mkfs >$seqres.full 2>$tmp.mkfs
 # get original data blocks number and agcount
 . $tmp.mkfs
diff --git a/tests/xfs/057 b/tests/xfs/057
index 6af14c80..0cf16701 100755
--- a/tests/xfs/057
+++ b/tests/xfs/057
@@ -51,8 +51,7 @@ echo "Silence is golden."
 sdev=$(_short_dev $SCRATCH_DEV)
 
 # use a small log fs
-_scratch_mkfs_sized $((1024 * 1024 * 500)) >> $seqres.full 2>&1 ||
-		_fail "mkfs failed"
+_scratch_mkfs_sized $((1024 * 1024 * 500)) >> $seqres.full 2>&1
 _scratch_mount
 
 # populate the fs with some data and cycle the mount to reset the log head/tail
-- 
2.35.3

