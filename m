Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795724980;
	b=eLyDY7Mi8GDnReU6k/E8FQUQ+y4QHUB6RfooNn8JDKQetnKnEi0FaBZOvVZdT99yW6gX
	 q70n7tjP3DidS22SX2cfIgZfh5O2R4LDX6rqQMWtpI/VpYl7KIJYt8Dcna1EchkmtnXxJ
	 g9zvpP5F1k+opNbu7cTiBhZQnHD5ZwD3Zl8f+n/XqSWdPO/sJkLbQjOiMnGNH/IpboJds
	 /UawFqBVrSfvvkEwCD/s58ADwBB7q+TQ7sjlaGEQHpiFD8xK8kModyR98Hq/8iufZLPFa
	 JFtNjUNQEnt3VRKgGHEA3ck+J3OsaHQFYRrvovUo3iruD3ynddzIz5i3xMDo3UWLHbg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724980;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fYJUgeYo8ErRb7AeBHDCWCg/ROE/ao7cxAid5k/Ro2k=;
	b=t7yzJCLvTR2JjXacKbqvf4B6dcZ3SBXIgZ3nlMiYn16TTM8WsLdv6sgOzdr1vLveO33G
	 2ZScfYhxWCBdUkf9wMj8yn9U5YBKotuvDntvrUP3D3GTadFofexxYI1AMNsM9O6S4oZWT
	 3/Sa/vbADxqKPV75kM3NvWD4uOAx+SqSaKobBYTpkDmgMfhlBYkDVD2o8CLaUEVUmuRDJ
	 olYdiWMHYBWvtpsQ/gVLLdqjEaErPz32VbdwYtGixGlK9daN95Rf40vHZYZXQPkFUFVeC
	 HWu7ANfGGpdkz0CzihT/xypMcoPL8m37GrcCqW+oq4hfb1ZXDfEZD0O9ULtFzjLhogA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0MV4TZb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ED5606A31E;
	Thu, 26 Nov 2026 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0MV4TZb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795724979;
	b=YHAUsm4eeqCM/GxD3DimZzyZ00uG/bnGs/7YCT9p6/QCGwoc3mf1WRnO6gLGh2SC/Q3Y
	 be8FmNVylJmLvNwPaveujwQKluaCn84cLASnoyKw5Y+ZBT2fDKuj8rZrCtk2t35JDCeeU
	 y6wSbDOJwY7Hf/vGSZVbK/XOEZs0SbYVXKBWe68TV18KIygkMoQpxALXKgFU2GCDNgFJh
	 pIXhrLB1fDyYyuID86qa5Ghw0u0zkHV/1MoFlMFbOE2SUScGulGbhty8rjtEuMArLoGwF
	 7d+iZGRgsGrdNPgg/tePcRbubck1iQfAKjLq80cyfFCJNeDxMKv1rK2IxifXM+MLpnw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795724979;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=fYJUgeYo8ErRb7AeBHDCWCg/ROE/ao7cxAid5k/Ro2k=;
	b=RbgHF340NHwVHzpIZK3lyfpVnuJ3McaXXwZiVTcy9+qAy4CQYYO+lo4fhilSGWq4o66p
	 h1YBmKmkx35aVdGpFbDoRBIxa2jNDyWs4Pp+HUQBWVpkZ6hP3FLhRIEk4Oo/TUc3eQjnb
	 x7zm+WIt5FdwGX0LxQ+2wcRUCrP3V3VMBE8KK7gArpuPW7R8Ns+cVE0/Ab5qdRSwrPFew
	 dBmVsWO7btyPU1nVVKy+pGgfiyZNpJehxAmUsIYRmriH7/ttZ2oWWNYao058LqnB2rxgE
	 1EJQlFsShtzPY8o7bR3SPxPLOUXbtjN83RyBPiLnjI1iQd+rt9ouupk6NjA6XRsSWtQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A0D361F00923;
	Thu, 26 Nov 2026 20:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795724979;
	bh=fYJUgeYo8ErRb7AeBHDCWCg/ROE/ao7cxAid5k/Ro2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=S0MV4TZbyEIp/cWqMRys5CX7a2awhEtc5b29Vof4UpEBLlDMT2qOkU2GlV9utaRq5
	 7qV9Mtt4V3oD/fJOIQfjVbRDJEdvY3RS6MaRFQwG+YoADT3t0hZL0npvNL3Yt51VX7
	 iwCUGLtnLDfjEbkoTdWbCS0P2QQSe2ZkjZjOoloCCs+DrPGD5f8ptkAHYK70PpqPCU
	 z+ahElTRvgc+RbfDDUw52XP4XTEoyfvEXE7JiHyws5l29S22jDGjnRcUN/pdK+e4BN
	 RInnbE2InrpcyC9dN2YYQEdKgk3ar3G1g3DDwhpBViE7BBeoEra3aH95aSvSOy/JBb
	 TGqVPs0ZRmlEQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 2EF1D4D800;
	Thu, 26 Nov 2026 20:29:26 +0000 (UTC)
From: Ernest Borowski via B4 Relay <devnull+ernest.borowski.git.proton.me@kernel.org>
Date: Thu, 26 Nov 2026 21:29:27 +0100
Subject: [PATCH v2 4/4] generic: test a short copy into a hole of reused
 blocks
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-ntfs-reproducers-v2-4-7d5fa5a688b9@proton.me>
References: <20261126-ntfs-reproducers-v2-0-7d5fa5a688b9@proton.me>
In-Reply-To: <20261126-ntfs-reproducers-v2-0-7d5fa5a688b9@proton.me>
To: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Cc: ntfs@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>, 
 Hyunchul Lee <hyc.lee@gmail.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
 Ernest Borowski <ernest.borowski.git@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5688;
 i=ernest.borowski.git@proton.me; s=default; h=from:subject:message-id;
 bh=PImeVP0MGgpXxJ60DZciRiMAS/A5NIpfCDK+SniO0P8=;
 b=owGbwMvMwCVWzJ65uCpJ5D/jabUkhmyOaUvWdZ2SVlc7X3J+Zcwb12ULjmUaGNS7P2LuL/6UL
 Tbv0hvZjlIWBjEuBlkxRZaO/zdCfEK+fVoWp9UHM4eVCWQIAxenAExE2Yrhfz33pV9bzUI3K2jI
 beRfIiAbO+nzRbmGidN+3Mg24WRi383wT8FuS1KN2on2GkbVlhsW1ts6RJtsrf+3WjDdq746+/Z
 8XgA=
X-Developer-Key: i=ernest.borowski.git@proton.me; a=openpgp;
 fpr=88FFD8544C54F6F2A65E2A8E730769A37A6214FF
X-Endpoint-Received: by B4 Relay for ernest.borowski.git@proton.me/default
 with auth_id=1589
X-Original-From: Ernest Borowski <ernest.borowski.git@proton.me>
Reply-To: ernest.borowski.git@proton.me
Content-Transfer-Encoding: 7bit

From: Ernest Borowski <ernest.borowski.git@proton.me>

When a buffered write into a hole stops part way through a block because
its source buffer runs into an unreadable page, only the bytes copied are
dirty. A filesystem that allocates in units larger than the blocks it
tracks as dirty, as ntfs does, has to zero the rest of the allocation, or
reads return what the reused clusters held before. On ntfs the rest of the
cluster read back the old file contents after an fsync and a remount, with
4 KiB and with 64 KiB clusters; the fix is "ntfs: zero the rest of a new
cluster after a short buffered write" from the ntfs delayed allocation
series, not merged yet. Fill a 512 MiB filesystem with data, so that the
blocks the hole gets held data before, free the blocks of a filled file by
truncating it to zero and back, write its last byte, write two and a half
blocks into the hole from a buffer whose readable part ends in the first,
second or third block, and compare the file with the expected contents
after a remount. The write has to return a count between one and the
readable length. The test does not run with the discard mount option,
which may zero the freed blocks.

Link: https://lore.kernel.org/all/20261124-b4-ntfs-delalloc-fixes-v2-0-f394c800ec03@proton.me/
Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
---
 tests/generic/818     | 88 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/818.out |  2 ++
 2 files changed, 90 insertions(+)

diff --git a/tests/generic/818 b/tests/generic/818
new file mode 100755
index 00000000..ae669fac
--- /dev/null
+++ b/tests/generic/818
@@ -0,0 +1,88 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Ernest Borowski <ernest.borowski.git@proton.me>.  All Rights Reserved.
+#
+# FS QA Test No. 818
+#
+# A buffered write into a hole whose copy from user space stops part way
+# through a block, because the source buffer runs into an unreadable page,
+# must leave everything it did not write reading as zeroes once the data is on
+# the disk.  The blocks the hole gets may have held data before, so a block
+# that is allocated but only partly written would expose that old data.
+#
+# Fill a small filesystem with data, so that every block the hole can get held
+# data before.  Then fill a file and fsync it, truncate it to zero and back to
+# its size so that its old blocks are free again, write its last byte, and
+# write two and a half blocks at a block boundary from a buffer with only part
+# of it readable.  After an fsync and a remount the file must hold the bytes
+# the write returned and zeroes around them.
+#
+. ./common/preamble
+_begin_fstest auto quick rw
+
+_fixed_by_fs_commit ntfs xxxxxxxxxxxx \
+	"ntfs: zero the rest of a new cluster after a short buffered write"
+
+_require_scratch
+# Compressed data would not fill the filesystem.
+_require_no_compress
+_require_test_program "pwrite-short-copy"
+# Online discard can make freed blocks read back as zeroes, which hides the
+# missing zeroing.
+_exclude_scratch_mount_option "discard"
+
+_scratch_mkfs_sized $((512 * 1024 * 1024)) >> "$seqres.full" 2>&1
+_scratch_mount
+
+blksz=$(_get_file_block_size "$SCRATCH_MNT")
+size=$((32 * blksz))
+off=$((8 * blksz))
+len=$((2 * blksz + blksz / 2))
+file=$SCRATCH_MNT/file
+
+# Write until ENOSPC, in large and then in single blocks, so that the only free
+# space left is what the file and the spare file free again.  _fill_fs is not
+# used, as it may preallocate, which writes no data.  The syncs let delayed
+# allocation give back what it reserved, so that the next pass writes it.
+$XFS_IO_PROG -f -c "pwrite -q -S 0xab 0 $size" -c fsync "$file"
+$XFS_IO_PROG -f -c "pwrite -q -S 0x33 0 $((2 * size))" -c fsync \
+	"$SCRATCH_MNT/spare"
+$XFS_IO_PROG -f -c "pwrite -S 0xcd -b 1m 0 512m" "$SCRATCH_MNT/fill1" \
+	>> "$seqres.full" 2>&1
+_scratch_sync
+$XFS_IO_PROG -f -c "pwrite -S 0xcd -b $blksz 0 512m" "$SCRATCH_MNT/fill2" \
+	>> "$seqres.full" 2>&1
+_scratch_sync
+rm -f "$SCRATCH_MNT/spare"
+_scratch_sync
+$DF_PROG "$SCRATCH_MNT" >> "$seqres.full"
+
+# _scratch_cycle_mount sets $ret, so the write's result is kept in $written.
+# Short copies that end in the first, second and third block of the write.
+for copy in $((blksz / 4)) $((blksz + blksz / 4)) $((2 * blksz + blksz / 8)); do
+	$XFS_IO_PROG -f -c "pwrite -q -S 0xab 0 $size" -c fsync \
+		-c "truncate 0" -c "truncate $size" \
+		-c "pwrite -q -S 0x01 $((size - 1)) 1" "$file"
+	written=$("$here/src/pwrite-short-copy" "$file" "$off" "$len" "$copy") || \
+		_fail "pwrite-short-copy failed"
+	echo "copy $copy: write of $len bytes at $off returned $written" >> "$seqres.full"
+	# The first $copy bytes of the buffer are readable, so the write must
+	# store some of them and stop at the first unreadable byte.
+	if [ "$written" -le 0 ] || [ "$written" -gt "$copy" ]; then
+		echo "copy $copy: write of $len bytes at $off returned $written"
+		continue
+	fi
+	$XFS_IO_PROG -c fsync "$file"
+	# shellcheck disable=SC2119 # the mount options argument is optional
+	_scratch_cycle_mount
+
+	rm -f "$tmp.expected"
+	$XFS_IO_PROG -f -c "truncate $size" \
+		-c "pwrite -q -S 0x01 $((size - 1)) 1" \
+		-c "pwrite -q -S 0x5c $off $written" "$tmp.expected"
+	cmp -s "$file" "$tmp.expected" || \
+		echo "copy $copy: file contents differ after a short copy"
+done
+
+echo "Silence is golden"
+_exit 0
diff --git a/tests/generic/818.out b/tests/generic/818.out
new file mode 100644
index 00000000..cb099786
--- /dev/null
+++ b/tests/generic/818.out
@@ -0,0 +1,2 @@
+QA output created by 818
+Silence is golden

-- 
2.56.1


