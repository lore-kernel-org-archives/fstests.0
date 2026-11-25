Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795633433;
	b=l0GHpg7/vfdpLLencwgsN28E5i656DA9eH811gkEtu/UyKK7ILrAwWUEk6yyGeBNLad5
	 eQg7+4Z4VdP7byzLlniyMb7LKtuyoAmBrcNA4nf02OOLYCQY2gRISiDI/yXjFk7jQhQi9
	 UY+xNTmsxKqvsODxmmKUxAJuwKyCnAT5vAgnEXNSztnJ3euDa+Auhul2Qqnteo7uwGlQJ
	 znU8xI2AdgLxNn/luVWQNVO7tJDAZIpluYZRLquEo8O2exk1xxc6PBm2kM2hklh1sw9Fk
	 PlPf6jWeOdrhlJWPOFFNuGTKYLngvEnjtyq0i01BMTkZ8KeMV6Kg9f3S5+gmzv9Q48Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795633433;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rxjsYp/eiZ71SqlJ1Bu3GEoCWdEB7F2BL3IPtvnHp5c=;
	b=baQYhD7fz8j2QSgjeGjtpbj+vi4myXJ1qo67djKMkV7U9+e8elu+5sYbOuutyRmJyv4E
	 HbXIVzaCYnLnm09TzNWAFtjG/QdJvPB1O6TLLAtnvCnPwgNg+E5rQ6ojnWYp+VuGA1iYc
	 dNkyxWKZHT9rUpjlzpfYiGS9XOfvm7VxAwfp2uQ7buK09RBDITE/Y20BudI/LH7MBwQlG
	 vk3kD8ghyq5sJXsAqUHzeUlU/jEL6cOefN6e133Iw3rL/pHH7zP/Fc+e2eBXVkgwpyLi1
	 e+JgRv3fkHFT6FQWLxUuAm3pItALim/X12iLsTQeMTpAXXysg6zfuzidjuNxiOxiAVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VkmiYA51;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23802606A329;
	Wed, 25 Nov 2026 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VkmiYA51
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795633432;
	b=NwEp8Lkzxgbsjw3rAg1oiXPZRiusBfzonXUf4UEBbPUG48xWGGkwKyR1NSh3tf3yX8Fh
	 ujiyrUEBSvIAmkMcXx9yYthz2m259ar9cQQf6eohA8abwXPIePpf02pEP9okhygJzePHT
	 m4O5nyvxG8gowPTPjxT9VoOoyIpUd7yf8cZdpjjtCJ004fyVKVXKwsENvlX+m/sMHpFYs
	 AWZQ+UvxoSzJJc0DY6tjq/JL0DhTYtvnSgKGweXBeCSRyZpjKO5IjMDdLSZBK5px+Q4Ok
	 /MQYIN0jd5WPWLjLBO0zsPAxvIBpGVgAbkJ9nqUSQ1GbGy1/CSFKZEBU8gk+m3CS40A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795633432;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rxjsYp/eiZ71SqlJ1Bu3GEoCWdEB7F2BL3IPtvnHp5c=;
	b=QAYQFHXMkV6s5nIytn+UlHwv3RkCbX0yZxThIMMJCSsQZJQPru/IQQz6WqwC1FtXlDGx
	 8MdatNV1yCorSdUPWhA9cQb6b3J/l6VhjI71z2DtMbb4RAwQdO/Y/Kturr6zYpRJWxXF7
	 crs4x+txy+dBH8e9469I3Du+iIxEwjDQHelOYva5PzcX/zX5BT+s46AoO8LWPrXVSAVJA
	 ElhOi4OHKiCCwdt00tby1BwI29V90HKUzYQQQkiWpcxGtyeY4zCfVGfaGxZ4jQO48BdgA
	 q/7fVta8dk4QH5w2B5Fy+NyJ4APUz7fzjwBQzsI68Mqjg+f9N71rfMgwYqAof740clw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id E37501F000D1;
	Wed, 25 Nov 2026 19:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795633432;
	bh=rxjsYp/eiZ71SqlJ1Bu3GEoCWdEB7F2BL3IPtvnHp5c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VkmiYA51KOuY9WAnWa9kKluB0KHXpKO+U0iHK5wPcDhvq0BuasczDP45hX+a9ZecV
	 pv4aDXa5hM0AVLEX8E3rhKQaM2C0b98eock4U3xqOnr/4fNMHhvEpAw49YXZD+8G/T
	 F9TwDeChhqfDe3f7kSMOc7gYrE/3KNWeQRw3k7McxfOl531mXvv2sYRdy7vqvJ8HWE
	 f8CBZ5txKNKtUWPwl5jy5U4tKoad8fkxCqzGSVj0pf3u5eFZI3BQWpbAOLcMN19yem
	 4OlJ4QEYyK646q/2KozRODWvYt4SK/UEBK0d4SPZDM30XPB9pZ2hwkPWXdZNAcg2Da
	 FYgmTBSbqKuFg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 6FA364D000;
	Wed, 25 Nov 2026 19:03:44 +0000 (UTC)
From: Ernest Borowski via B4 Relay <devnull+ernest.borowski.git.proton.me@kernel.org>
Date: Wed, 25 Nov 2026 20:03:46 +0100
Subject: [PATCH 4/4] generic: test a short copy into a hole of reused
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
Message-Id: <20261125-ntfs-reproducers-v1-4-0cc67533d803@proton.me>
References: <20261125-ntfs-reproducers-v1-0-0cc67533d803@proton.me>
In-Reply-To: <20261125-ntfs-reproducers-v1-0-0cc67533d803@proton.me>
To: fstests@vger.kernel.org, Zorro Lang <zlang@kernel.org>
Cc: ntfs@lists.linux.dev, Namjae Jeon <linkinjeon@kernel.org>, 
 Hyunchul Lee <hyc.lee@gmail.com>, Zhan Xusheng <zhanxusheng1024@gmail.com>, 
 Ernest Borowski <ernest.borowski.git@proton.me>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3906;
 i=ernest.borowski.git@proton.me; s=default; h=from:subject:message-id;
 bh=nJ56RhZFyeHeI9JCtM7gckxJWIkuFTyzgjE4m6wLb+E=;
 b=owGbwMvMwCVWzJ65uCpJ5D/jabUkhmx2Q77UF21B5fv432RwSEmon0wM+CIvGn+E7d23fR9YY
 jZPqLvcUcrCIMbFICumyNLx/0aIT8i3T8vitPpg5rAygQxh4OIUgInI7GRkuLlDWefa7nRfj4kz
 cw4miyrL7Lhp0mf6SFi7YMb+yX9vNTL8lbV+0rqpSTfpV+CBV9/ONOcrdT84WHvqR/nrtbcTJwk
 cZAYA
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
series, not merged yet. Free the blocks of a filled file by truncating it
to zero and back, write its last byte, write two and a half blocks into the
hole from a buffer that is readable for 1000, 5096 or 12800 bytes, and
compare the file with the expected contents after a remount.

Link: https://lore.kernel.org/all/20261124-b4-ntfs-delalloc-fixes-v2-0-f394c800ec03@proton.me/
Signed-off-by: Ernest Borowski <ernest.borowski.git@proton.me>
---
 tests/generic/818     | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/818.out |  2 ++
 2 files changed, 60 insertions(+)

diff --git a/tests/generic/818 b/tests/generic/818
new file mode 100755
index 00000000..97c30767
--- /dev/null
+++ b/tests/generic/818
@@ -0,0 +1,58 @@
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
+# Fill a file and fsync it, truncate it to zero and back to its size so that
+# its old blocks are free again, write its last byte, then write two and a
+# half blocks at a block boundary from a buffer with only part of it readable.
+# After an fsync and a remount the file must hold the bytes the write returned
+# and zeroes around them.
+#
+. ./common/preamble
+_begin_fstest auto quick rw
+
+_fixed_by_fs_commit ntfs xxxxxxxxxxxx \
+	"ntfs: zero the rest of a new cluster after a short buffered write"
+
+_require_scratch
+_require_test_program "pwrite-short-copy"
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+
+blksz=$(_get_file_block_size $SCRATCH_MNT)
+size=$((32 * blksz))
+off=$((8 * blksz))
+len=$((2 * blksz + blksz / 2))
+file=$SCRATCH_MNT/file
+
+# _scratch_cycle_mount sets $ret, so the write's result is kept in $written.
+# Short copies that end in the first, second and third block of the write.
+for copy in $((blksz / 4)) $((blksz + blksz / 4)) $((2 * blksz + blksz / 8)); do
+	$XFS_IO_PROG -f -c "pwrite -q -S 0xab 0 $size" -c fsync \
+		-c "truncate 0" -c "truncate $size" \
+		-c "pwrite -q -S 0x01 $((size - 1)) 1" $file
+	written=$($here/src/pwrite-short-copy $file $off $len $copy)
+	echo "copy $copy: write of $len bytes at $off returned $written" >> $seqres.full
+	$XFS_IO_PROG -c fsync $file
+	_scratch_cycle_mount
+
+	rm -f $tmp.expected
+	$XFS_IO_PROG -f -c "truncate $size" \
+		-c "pwrite -q -S 0x01 $((size - 1)) 1" $tmp.expected
+	[ "$written" -gt 0 ] && \
+		$XFS_IO_PROG -c "pwrite -q -S 0x5c $off $written" $tmp.expected
+	cmp -s $file $tmp.expected || \
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


