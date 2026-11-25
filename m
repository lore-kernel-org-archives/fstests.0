Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795633437;
	b=mbRTrW6anJn78yE9KQ2l13GLDhCAeVF2ps/Iu8bLXxYOfgnlAkYbCjoJ1+Icursl4235
	 1D3mVEa5UeUMLgQwlEuGXSReRuVXatXI8kiTmeH65A3nQEi1wbB8keWEsoEBeGMlfl0QV
	 Un4LWLC9247NEy7Ui7VA7pbSc1Clni0+p05N9/z8/6REvvK1PknIFoNKdhSh0XwDtg+Id
	 8Ia4ZnF7CU7OlfkyvbYDroy9n2VZO7ZnwhWCMgHs9ipRlc+AkG/p+WRdT3Iq6xfIhyVGu
	 sQHgg4YUHFwLcjYYnFg5NClwRFsWjnEfHFpghnD+hI07sGBCz/s79JfZvfdZfzr015Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633437;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WXT7P9oaCg/DjZfm4kzlGXW904dc2sHGq/DwxaOBZ84=;
	b=ksBbff/Dan4myeI4lqGV/7BmcgJNFYyGRT9PcV55DWsPeX/Mzvt3EnHOO9DJzd5gvrNV
	 P9ra8tudASO+8bmtsIMtXMLSZjqH8bnfnjleP/Hj0KEmi9IEFcWtu8WhaBtnRWm+iJLqx
	 aL3SbjWKeuN2Wq+slNqit7wjfw4Lhf+E5nKvA7jgKGds4ItFoVRvM+D6H8e+8qTQnA0cH
	 8SDGsAdRFSrZH3N6izicJe8Q4KrHyrKmg2ceZlIou1/+oDAB8ElMeZzrVlkUlzkvswS2q
	 Luk8KBUtZQYLQxPcgImDjRaikkvNSjji++tekGZQhpdb4ZaEmSwdrjGDnyP6Ww9e7ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jr9gncY8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889AB606A32D;
	Wed, 25 Nov 2026 19:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jr9gncY8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795633437;
	b=e2TaG1LyLAaTjZAB9qYfdEaQ14/lqFlQC4fOPy1N/n4U4poYBtxf9TpJgUGAU2bL9srq
	 MUlYP7RytWCs9IW/zf7UAEhMr2+HQoMBOeS2O3M9Wzse3uzs6hptclDRKQGf+hpHVjRQN
	 hVc+ZnqCFimS/UX10clXfgnWy8etDQ4bbOumkW6HtB7sed3ojdj9AmTP5zPdmlQIfoUY4
	 BFMZKiuPeTewmmwwlVbVINm4xX0YYgQhZrQcyfnmOhBNjvdLZTirou3TYX57KBnjmVV8y
	 ia0uK3VGYsXfFWpT/+ocNZRNfPK0ce5X6XOa4DoOMnsB3+8oEwI1GfKmfygXMxo0Suw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795633437;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=WXT7P9oaCg/DjZfm4kzlGXW904dc2sHGq/DwxaOBZ84=;
	b=cVH0gNUExNAwR0/7vnpQtWzn+OtlQg0YEr1OnIE5xLL8mVNxasZayJF87UAwZ5MrYVHF
	 nunda4msk1mEJ7IYEuQ0H5bCM8H7FR2ecyrWNrIA41HJYGb4+8h0PuyzsQo8A+oV4xBB2
	 DILunrZpaCsgHGga+A/4sNfMRhQx2Meu3HvHFVv3mvVYyRh2MQiZEhKqs93ptKlNdRnP/
	 DlIHcsithslD04hdIDnRKcnehRZRjfMcxWeZr/OgW0mV243mvod/GWszyrHN8t+qM2cAR
	 kTnMrOKJx3Klk1AY+5ADyQhYKo7md5OtmHOFYumdC0Ws387FPBbSX24YKzEn65m7EhQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A6BD61F000CF;
	Wed, 25 Nov 2026 19:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795633436;
	bh=WXT7P9oaCg/DjZfm4kzlGXW904dc2sHGq/DwxaOBZ84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Jr9gncY8ms7TlrlDSJDVTdwdY8tcLNyzXfzzHMnCNEINchWFmSncDABz4Iu+mHtwU
	 /8rLz9AXtv1qDCt2/OpgTXsWctpInXk7Q5IDyZOHaK0HTgukx9iXgPNJS4SAlCLeJQ
	 tNbjkmFRl9RNDXrMl+3MOQ10MLJ03SROTQgM5BY1EgtHul7nTBABn3MNrHwnfkjY2/
	 1lvf3BSlua9CxPjqcMTUdHC+yExkAHJGg3xL7kknkRh07wIceGr/3BXPNnCx54ZNB8
	 CGmT0MIj0pGa3lexAo3ewJKcE1qCXQmC517P99wrHZLBpcgom/ARtB0SXGC4v8TqpD
	 LkGgjW4VOdA4g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 32B5C4CFF8;
	Wed, 25 Nov 2026 19:03:44 +0000 (UTC)
From: Ernest Borowski via B4 Relay <devnull+ernest.borowski.git.proton.me@kernel.org>
Date: Wed, 25 Nov 2026 20:03:44 +0100
Subject: [PATCH 2/4] generic: check the size after a buffered write runs
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
Message-Id: <20261125-ntfs-reproducers-v1-2-0cc67533d803@proton.me>
References: <20261125-ntfs-reproducers-v1-0-0cc67533d803@proton.me>
In-Reply-To: <20261125-ntfs-reproducers-v1-0-0cc67533d803@proton.me>
To: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Cc: ntfs@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>, 
 Hyunchul Lee <hyc.lee@gmail.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
 Ernest Borowski <ernest.borowski.git@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3635;
 i=ernest.borowski.git@proton.me; s=default; h=from:subject:message-id;
 bh=Iujrk+gE3XdVg5UO9fzbHHtWGauDODtpqe4fePza+TE=;
 b=owGbwMvMwCVWzJ65uCpJ5D/jabUkhmx2Q762Sxv5JWNCpTXc/5Re46xIucD94sTt1lP8k65dU
 WI9VS3dUcrCIMbFICumyNLx/0aIT8i3T8vitPpg5rAygQxh4OIUgIl4aDAytHFb2vueKUr8bL+h
 mTd63gsWxyvWbH6MDMpabOmma9xUGf6ZpQfvW9z147x7KceUuCnSlqt/LFMRYlm6/Db3Asdnv0S
 YAQ==
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
filesystem, free 256 KiB or more again, append eight times as much to a
file in one write(2), and check the size before and after a remount and the
contents of the file. generic/275 also runs a filesystem out of space with
writes, but only checks that some data was written.

Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
---
 tests/generic/816     | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/816.out |  2 ++
 2 files changed, 69 insertions(+)

diff --git a/tests/generic/816 b/tests/generic/816
new file mode 100755
index 00000000..14432f13
--- /dev/null
+++ b/tests/generic/816
@@ -0,0 +1,67 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Ernest Borowski <ernest.borowski.git@proton.me>.  All Rights Reserved.
+#
+# FS QA Test No. 816
+#
+# A buffered write that runs out of space part way must leave the file size
+# at the end of the bytes it wrote.  Fill a small filesystem, free a little
+# space again, append more than that to a file in one write(2), and check that
+# the size is the old size plus the count the write returned, before and after
+# a remount, and that the file holds the old data followed by the bytes
+# written.
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
+_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
+_scratch_mount
+
+blksz=$(_get_file_block_size $SCRATCH_MNT)
+unit=$((blksz > 65536 ? blksz : 65536))
+old=$((4 * unit))
+len=$((32 * unit))
+file=$SCRATCH_MNT/file
+
+$XFS_IO_PROG -f -c "pwrite -q -S 0x11 0 $old" -c fsync $file
+$XFS_IO_PROG -f -c "pwrite -q -S 0x33 0 $old" -c fsync $SCRATCH_MNT/spare
+_fill_fs $((64 * 1024 * 1024)) $SCRATCH_MNT/fill $blksz 0 >> $seqres.full 2>&1
+rm -f $SCRATCH_MNT/spare
+_scratch_sync
+$DF_PROG $SCRATCH_MNT >> $seqres.full
+
+# One write(2) of $len bytes at the end of the file.  xfs_io prints the count
+# the write returned, or an error and no count when it wrote nothing.
+$XFS_IO_PROG -c "pwrite -S 0x22 -b $len $old $len" $file > $tmp.write 2>&1
+cat $tmp.write >> $seqres.full
+written=$(sed -n -e 's/^wrote \([0-9]*\)\/.*/\1/p' $tmp.write)
+written=${written:-0}
+[ $written -lt $len ] || _notrun "could not run the filesystem out of space"
+
+check_size()
+{
+	local size=$(_get_filesize $file)
+
+	[ $size -eq $((old + written)) ] || \
+		echo "$1: size $size after writing $written bytes at $old"
+}
+
+check_size "after the write"
+_scratch_cycle_mount
+check_size "after remount"
+
+$XFS_IO_PROG -f -c "pwrite -q -S 0x11 0 $old" $tmp.expected
+[ $written -gt 0 ] && \
+	$XFS_IO_PROG -c "pwrite -q -S 0x22 $old $written" $tmp.expected
+cmp -s $file $tmp.expected || echo "file contents differ"
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


