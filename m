Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795724973;
	b=03Fwr1+ny/Xxk8TAmkqksOJ0ytrAG3nfSmvVFr//OcLrcFvZuKRwZrjJ+pl0bgh6Si2l
	 ejrH/r6Wb09+Z88xXzVCsVIXKrGQmi9JLzC94R4u8idjIVacjLNl1HMvKxt10t4H/xdSE
	 Jc6KB6ox8VbsLv/sawMpdNXNN9rbkhjd6xY36TbGHBNoDFqt5dmNPBctqxE+gfDRPLfpy
	 WJGZpmI5JErjO2IUVM91EU17ElSo9230fDkxj1bPO48pW7MSQ11s6xWWx1b2LlYRVkUMw
	 P6cRZsUsCt6LEKz8ljj+DLdcrkTJWpqcgyw6lXUWanqjQYKO5Z/4GA3xIqtXMRl5uTg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795724973;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4JTSal57Ra1kXTFLQxjvMhmn7tu5dOzJDY+EVLtFAY0=;
	b=J4A2srHKRGJu1WXtkFBQ89JLJwZ0EHoi16UllY43fdq0Jo5GEwvSYuWy2lRlutaP7N6p
	 vAziF/mZDcgBRyHTpCJeAHp8LqcyRczQsNbOLU6VoAAAanT/DOgdgEXEkg+FSXdLAKDDe
	 NTadl+RKLgC02USbLhNDUebxjf5F1ABTrlURRTvz8V9ubY6/NDs9FCfieaOvkVZtQtyDO
	 V6rS4KUxgLRqX7oFcbViiMC4RXHEmrA7osTmfWQ+XKaTIcUEUGPCBcl45I+f6vOXprrik
	 hP4HmuzvZmw/+YOnChFs45dNzLsWUWnqz1VTYCJ38hstqAI06ZUpw3xTIHWvS2dc0Ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KIo0YkPl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B954A606A31E;
	Thu, 26 Nov 2026 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KIo0YkPl
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795724972;
	b=k4fWoq2wolA0t2aU4WiBMmPK/iqr0CRfeIx0+p0BDuoy/FwLeZ4HabWQNtclvpcunYAV
	 cdOZcxqLX04gUt0/RNYzwA++1x5JXIqLHMI2iB+CzfZLV+CTswD+XivVOMJNIK4m4RTVb
	 ujNU7b8UfQa8QQZ1h/W42kSZ6OiXS3uugxuCHorvmMwgDfFCGmYe7e10iYbQ5DeClhTwu
	 +NnqqG2qhk2m2cK09M4wXBV6OlzTu7RNBMlz5k8kgEC0Xgtgm1yZ2yMQlvLymXNIy5hga
	 D9LaxvhyXFGVrmBy4b5FvwcM5YR4D7/AVv+y6QvU7p/SuN43QOA2FCbk3LfqHGSNyLg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795724972;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=4JTSal57Ra1kXTFLQxjvMhmn7tu5dOzJDY+EVLtFAY0=;
	b=oh/m1mzYhRkHPN+tGiQ3ZJo030IZlpyWrjhOO+AZ3meuNQQ4CV5n679Pb1KM5Iq6+XIC
	 ySvWQZRetFqqEdlgQtbNyFLQXgCojyma3/gLDXcmPAbJ7lId03CXWptr2rD1rQZsAV9WF
	 9FL/0RSn/ZXIWNluxBT5OLg4uNKqHiSaj3ijxCV/9VQ5TlCr+FbQHiMqCYwptzXLBTJX1
	 4Y3EPi+TyrmCGsY4OE94VlmIYA+Eel8Wkt1++Sz0wRl1fvIpOIWlNit3IZirlKdYoQuZZ
	 ++oqFGELQNn2XdWIsBTHIH9s4DnZkmeRbSIkfjZ6ZQNVAN6Ff2RE0WJBp8ctdGOOzLg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 59BFF1F0089B;
	Thu, 26 Nov 2026 20:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795724972;
	bh=4JTSal57Ra1kXTFLQxjvMhmn7tu5dOzJDY+EVLtFAY0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=KIo0YkPlXrHMMJy2wO6sm4jsGM9V321qEFGb6RNQKPBI2rfZMUflTuakMxq4gZcvv
	 aYzQEUGHGXNJJbuEiczjw+10SQahgT4DQAquBOgoE4oSYq63Qu/3T8c2rJCPHTYoJ9
	 XiIdmFBIjK8A+OGa5qxK4cnc0JmYV08lEesZR/jBhkXdJuFI1zl4I0VSVn3WqrLLK9
	 BYAOLDVUHBR+71HTSwYK1vZvs9KOZiFoHpnbktK58Pj6iFcPyNHX4OegaMidWaeQk8
	 Q9fyibkHEB7E68YgxzDcwT4wEgL33wTIRrHdZimBaHReimgcZJAlGXsK467NhK/e4f
	 9R3lYWdF9PN4A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DF8514D7F8;
	Thu, 26 Nov 2026 20:29:25 +0000 (UTC)
From: Ernest Borowski via B4 Relay <devnull+ernest.borowski.git.proton.me@kernel.org>
Date: Thu, 26 Nov 2026 21:29:25 +0100
Subject: [PATCH v2 2/4] generic: check the size after a buffered write runs
 out of space
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
Message-Id: <20261126-ntfs-reproducers-v2-2-7d5fa5a688b9@proton.me>
References: <20261126-ntfs-reproducers-v2-0-7d5fa5a688b9@proton.me>
In-Reply-To: <20261126-ntfs-reproducers-v2-0-7d5fa5a688b9@proton.me>
To: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Cc: ntfs@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>, 
 Hyunchul Lee <hyc.lee@gmail.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
 Ernest Borowski <ernest.borowski.git@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5135;
 i=ernest.borowski.git@proton.me; s=default; h=from:subject:message-id;
 bh=lnpV2z8fc1PLEC20/FZcqZnQe83YXlORyjSto2dz+SE=;
 b=owGbwMvMwCVWzJ65uCpJ5D/jabUkhmyOaUsY3eIjXNmcE/8YyN1XYS7aWmWSo/D8t2riv4/lR
 W0x/hs7SlkYxLgYZMUUWTr+3wjxCfn2aVmcVh/MHFYmkCEMXJwCMJGfSxkZjinVbHleeP+F4gOx
 veeE5m9dvtw1e+4EPru35y1eG1heN2RkmBbL8+GbyfTN83avFF5pOVty0ff4C61mzd36O5Ik/0V
 /4gIA
X-Developer-Key: i=ernest.borowski.git@proton.me; a=openpgp;
 fpr=88FFD8544C54F6F2A65E2A8E730769A37A6214FF
X-Endpoint-Received: by B4 Relay for ernest.borowski.git@proton.me/default
 with auth_id=1589
X-Original-From: Ernest Borowski <ernest.borowski.git@proton.me>
Reply-To: ernest.borowski.git@proton.me
Content-Transfer-Encoding: 7bit

From: Ernest Borowski <ernest.borowski.git@proton.me>

A buffered write that runs out of free space part way returns a short
count, and the file size has to end at the last byte it wrote. ntfs raises
the size to the end of the whole request before it copies anything and
keeps it after the copy stops early, so the file grows by a tail of zeroes
that the caller never wrote; "ntfs: trim the sizes after a short write" by
Zhan Xusheng, under review on the ntfs list, fixes that. Fill a 512 MiB
filesystem, free 256 KiB or more again, write eight times as much to a file
in one write(2) that starts 64 KiB or one block before the end of the file,
and check the size before and after a remount and the contents of the file.
XFS and ext4 reserve space for all of a new range at once, so a write that
started at the end of the file failed there with nothing written; this one
stores the part over the old data and comes up short. A write error other
than ENOSPC fails the test, and a
write that fails with ENOSPC before storing anything is checked the same
way but then reported as not run. generic/275 also runs a filesystem out of
space with writes, but only checks that some data was written.

Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
---
 tests/generic/816     | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/816.out |  2 ++
 2 files changed, 93 insertions(+)

diff --git a/tests/generic/816 b/tests/generic/816
new file mode 100755
index 00000000..625a8429
--- /dev/null
+++ b/tests/generic/816
@@ -0,0 +1,91 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Ernest Borowski <ernest.borowski.git@proton.me>.  All Rights Reserved.
+#
+# FS QA Test No. 816
+#
+# A buffered write that runs out of space part way must leave the file size
+# at the end of the bytes it wrote.  Fill a small filesystem, free a little
+# space again, and write more than that to a file in one write(2) that starts
+# a little before the end of the file and goes past it.  Check that the size
+# ends at the end of the old data or of the bytes the write returned,
+# whichever is further, before and after a remount, and that the file holds
+# the old data with the bytes written over it.
+#
+. ./common/preamble
+_begin_fstest auto quick rw enospc
+
+. ./common/populate
+
+_fixed_by_fs_commit ntfs xxxxxxxxxxxx \
+	"ntfs: trim the sizes after a short write"
+
+_require_scratch
+_require_no_compress
+
+_scratch_mkfs_sized $((512 * 1024 * 1024)) >> "$seqres.full" 2>&1
+_scratch_mount
+
+blksz=$(_get_file_block_size "$SCRATCH_MNT")
+unit=$((blksz > 65536 ? blksz : 65536))
+old=$((4 * unit))
+len=$((32 * unit))
+# The write starts inside the old data: a filesystem that reserves space for
+# all of a new range at once, as XFS does, then still stores the part over
+# allocated blocks and comes up short instead of failing with nothing written.
+pos=$((old - unit))
+file=$SCRATCH_MNT/file
+
+$XFS_IO_PROG -f -c "pwrite -q -S 0x11 0 $old" -c fsync "$file"
+$XFS_IO_PROG -f -c "pwrite -q -S 0x33 0 $old" -c fsync "$SCRATCH_MNT/spare"
+_fill_fs $((64 * 1024 * 1024)) "$SCRATCH_MNT/fill" "$blksz" 0 >> "$seqres.full" 2>&1
+rm -f "$SCRATCH_MNT/spare"
+_scratch_sync
+$DF_PROG "$SCRATCH_MNT" >> "$seqres.full"
+
+# One write(2) of $len bytes at $pos.  xfs_io prints the count
+# the write returned, or the error when the write failed.  ENOSPC before the
+# first byte is checked like a short write of zero bytes, any other error
+# fails the test.
+$XFS_IO_PROG -c "pwrite -S 0x22 -b $len $pos $len" "$file" > "$tmp.write" 2>&1
+cat "$tmp.write" >> "$seqres.full"
+written=$(sed -n -e 's/^wrote \([0-9]*\)\/.*/\1/p' "$tmp.write")
+if [ -z "$written" ]; then
+	grep -q "No space left on device" "$tmp.write" || \
+		_fail "write failed: $(cat "$tmp.write")"
+	written=0
+fi
+[ "$written" -lt "$len" ] || _notrun "could not run the filesystem out of space"
+
+end=$((pos + written > old ? pos + written : old))
+errors=0
+check_size()
+{
+	local size
+
+	size=$(_get_filesize "$file")
+	[ "$size" -eq "$end" ] && return
+	echo "$1: size $size after writing $written bytes at $pos"
+	errors=$((errors + 1))
+}
+
+check_size "after the write"
+# shellcheck disable=SC2119 # the mount options argument is optional
+_scratch_cycle_mount
+check_size "after remount"
+
+$XFS_IO_PROG -f -c "pwrite -q -S 0x11 0 $old" "$tmp.expected"
+[ "$written" -gt 0 ] && \
+	$XFS_IO_PROG -c "pwrite -q -S 0x22 $pos $written" "$tmp.expected"
+if ! cmp -s "$file" "$tmp.expected"; then
+	echo "file contents differ"
+	errors=$((errors + 1))
+fi
+
+# A write that failed before storing anything must not change the file either,
+# but it did not test a short write.
+[ "$written" -eq 0 ] && [ "$errors" -eq 0 ] && \
+	_notrun "the write failed with ENOSPC before storing anything"
+
+echo "Silence is golden"
+_exit 0
diff --git a/tests/generic/816.out b/tests/generic/816.out
new file mode 100644
index 00000000..a9d8f943
--- /dev/null
+++ b/tests/generic/816.out
@@ -0,0 +1,2 @@
+QA output created by 816
+Silence is golden

-- 
2.56.1


