Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3932033A
	for <fstests@vger.kernel.org>; Mon, 31 Mar 2025 03:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743391786; cv=none; b=SiTVNz0HAuKzp0u72EMrdxBQG/5/yc4JJcWL9TDFjVHbdsEdVufTSa0YTP/FVpIe0cQH1kxdk1gGW2kdcjGDIJ5zOkI2HWV6rAOp7BBTG7qtp6fqmYzW/ke1/BNt/SM8fbKeWXzdA5BMBBmOyELVWiFaFm2z2boGgHqLBNnDQZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743391786; c=relaxed/simple;
	bh=vCeKXokJDtsIiaj5SsmYmTNxsKqJ9Qwa0X6PWRrP9Og=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LMeZm1qUYdLgx1Q3X12UtuPX1Av8t9a88uLydDu0dPG2wXWvytQ8Dwg54RNlserEzfSszoON6nEEYqubq8IgvWcmNM1KD3k6FOjWszvMZWruZhON0qosD8TZgHFoDgtj9VFcToPBJnU2aUyut7f6gEjAyQ0G2In1uF3Em4dF/ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+svVkoK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+svVkoK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC02FC4CEE4;
	Mon, 31 Mar 2025 03:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743391786;
	bh=vCeKXokJDtsIiaj5SsmYmTNxsKqJ9Qwa0X6PWRrP9Og=;
	h=From:To:Cc:Subject:Date:From;
	b=E+svVkoKzlmMfe+uGwOxbeVEzhF/VnU0iH3OId2xOdzcPlGxaRe95wHteqWKAiYjp
	 jPutDuMFkcdiaNNX1gIXdhuBhwTti3XRHF/NbsnmQqgf/H82y+MY+OynkelcLg0MPJ
	 F2s3dJkVr84ZET8FZLMjaIE/92sf2zyvPzC9W2z4oiiGZtwGhT3KTqDbR5BUyiJFuw
	 fQEaaK8OrroShsknduLij6410X3whUiOpda+PWmks75VkbHisQDUUCzSE2mkHqp/5P
	 uOazd7QuhX4/IwuHhrYQdVD1lRe7B/V0pnFfpaNzqIux25AUMXQJUv/YhF92bCBgFs
	 YCT5t3ThtVY8g==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Daniel Lee <chullee@google.com>
Subject: [PATCH] f2fs/012: test red heart lookup
Date: Mon, 31 Mar 2025 11:29:16 +0800
Message-ID: <20250331032916.489543-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

As Han Qi reported in bugzilla [1], commit 5c26d2f1d3f5 ("unicode: Don't
special case ignorable code points") changes logic to handle ignorable
code points, when we handle filename which has special unicode charactor
like red heart ❤️, utf8_casefold() may return different length than in the
past, result in that f2fs cacluates hash code incorreclty, eventually,
filename w/ special unicode charactor will not be found w/ the wrong hash
code.

f2fs has introduces a linear lookup fallback w/ commit 91b587ba79e1
("f2fs: Introduce linear search for dentries"), once hash-based lookup
fails, it tries linear lookup as a fallback.

This patch can help to check whether linear lookup fallback works well
or not.

Firstly, we use below testcase to check how hash code changes:

mkfs.f2fs -f -O casefold -C utf8 /dev/vda
mount /dev/vda /mnt/f2fs
mkdir /mnt/f2fs/dir/
f2fs_io setflags casefold /mnt/f2fs/dir
touch /mnt/f2fs/dir/$'\u2764\ufe0f'
umount /mnt/f2fs
dump.f2fs -i 4 -d 3 /dev/vda
dump.f2fs -b $blkaddr_of_dir -d 3 /dev/vda

w/o ("unicode: Don't special case ignorable code points")
[dump_dirent: 991] bitmap pos[0x2] name[❤️] len[0x6] hash[0x19dd7132] ino[0x5] type[0x1]
[dump_dirent: 998] name(hex)[0xe2 0x9d 0xa4 0xef 0xb8 0x8f 0x0]

w/ ("unicode: Don't special case ignorable code points")
[dump_dirent: 991] bitmap pos[0x2] name[❤️] len[0x6] hash[0x9a2ea068] ino[0x5] type[0x1]
[dump_dirent: 998] name(hex)[0xe2 0x9d 0xa4 0xef 0xb8 0x8f 0x0]

Correct hash code:	0x19dd7132
Wrong hash code:	0x9a2ea068

So, we can test as below:

1. create file w/ red heart as its filename
2. inject wrong hash code to the file
3. disable linear lookup, expect lookup failure
4. enable linear lookup, expect lookup succeed

[1] https://bugzilla.kernel.org/show_bug.cgi?id=219586

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Daniel Lee <chullee@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/012     | 54 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/012.out |  2 ++
 2 files changed, 56 insertions(+)
 create mode 100755 tests/f2fs/012
 create mode 100644 tests/f2fs/012.out

diff --git a/tests/f2fs/012 b/tests/f2fs/012
new file mode 100755
index 00000000..fdc30bea
--- /dev/null
+++ b/tests/f2fs/012
@@ -0,0 +1,54 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/012
+#
+# This testcase checks whether linear lookup fallback works well
+# or not as below:
+# 1.create file w/ red heart as its filename
+# 2.inject wrong hash code to the file
+# 3.disable linear lookup, expect lookup failure
+# 4.enable linear lookup, expect lookup succeed
+#
+. ./common/preamble
+_begin_fstest auto quick casefold
+
+_fixed_by_kernel_commit 91b587ba79e1 \
+	"f2fs: Introduce linear search for dentries"
+
+export LC_ALL=C.UTF-8
+_require_scratch
+_require_command "$F2FS_IO_PROG" f2fs_io
+_require_command "$F2FS_INJECT_PROG" inject.f2fs
+
+_scratch_mkfs -f -O casefold -C utf8 >> $seqres.full
+_scratch_mount
+
+dir=$SCRATCH_MNT/dir
+
+# red heart charactor in unicode format
+redheart=$dir/$'\u2764\ufe0f'
+
+mkdir $dir
+$F2FS_IO_PROG setflags casefold $dir >> $seqres.full
+touch $redheart
+ino=`stat -c '%i' $redheart`
+_scratch_unmount
+
+$F2FS_INJECT_PROG --dent --mb d_hash --nid $ino --val 0x9a2ea068 $SCRATCH_DEV >> $seqres.full
+
+$F2FS_FSCK_PROG --nolinear-lookup=1 $SCRATCH_DEV >> $seqres.full
+_scratch_mount
+[ -f $redheart ] && _fail "red heart file should not exist"
+_scratch_unmount
+
+$F2FS_FSCK_PROG --nolinear-lookup=0 $SCRATCH_DEV >> $seqres.full
+_scratch_mount
+[ -f $redheart ] || _fail "red heart file should exist"
+_scratch_unmount
+
+echo "Silence is golden"
+
+status=0
+exit
diff --git a/tests/f2fs/012.out b/tests/f2fs/012.out
new file mode 100644
index 00000000..3afeca2f
--- /dev/null
+++ b/tests/f2fs/012.out
@@ -0,0 +1,2 @@
+QA output created by 012
+Silence is golden
-- 
2.49.0

