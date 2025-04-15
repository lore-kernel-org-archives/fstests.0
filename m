Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB64288CB3
	for <fstests@vger.kernel.org>; Tue, 15 Apr 2025 09:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744709913; cv=none; b=uYtvUyyYOqwHWjnJvDj9wZQbPDEDkFBPzT5/u7biGVG2ybOHUxXam1P/MkLOGK/JvHbIRJW2gaNqPuenBY4QhehuQIlm86bRK0lI+I7c5e431bDaYa7CUG9MGTOzKA0K/++q07dJ1gKW/BaYsZgq1A6qhjLHi6e3kd+Shi3wJ+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744709913; c=relaxed/simple;
	bh=u0EytPYWMSeIqaz6DAmJzDvepXrVjSRMwN12Ddna4Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IsiwUzfUS44ZKlWoRvYj1+Pik1Rino+yKD7tUFUWht2dXTlLkqYlCmiTA4h3MxGfYJxdx3evMPFtcTNHP8t3n02Jko1L8XhqWq9A6K7Oek6/jKEbWiIeTfTmgWZgA45gY9GxfCNZrWcpSwYoxEKCeg6GrqKjALzxs0gT8xioIqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDeDXkAt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDeDXkAt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2F0C4CEDD;
	Tue, 15 Apr 2025 09:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744709913;
	bh=u0EytPYWMSeIqaz6DAmJzDvepXrVjSRMwN12Ddna4Ys=;
	h=From:To:Cc:Subject:Date:From;
	b=iDeDXkAtZ22AmwKMg1lzAiIVoSgjhgDm2WwARAZahJ+d2vFOQscrHu5kZBHJbN2Zj
	 lJi4TZoEH5TUmS7VWb3XJonCZaZJbolVV1bjLmKPQEcEW/mLptlK5M+ABHc2QA1B8k
	 5ra5RMeayJ55GMpZAEiLop54cC+hAM4yE2/uUouua7pydGM6xy5gIkWEOdQpfen12V
	 IkHn+CsaDXACfqL3q6T+oy6ep2LdsTRLbFT7iXv/0BTxR2ck4Sh41guDEBDwPX/xc8
	 PrKIFYA8S/phEx5stCQN4gDD02dQ+GzWCviMMSKxDu1ye2OnHCssK6qtouPHI41urE
	 c7zJj+XwxChUA==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>,
	Daniel Lee <chullee@google.com>
Subject: [PATCH v2] f2fs/012: test red heart lookup
Date: Tue, 15 Apr 2025 17:38:22 +0800
Message-ID: <20250415093822.1100476-1-chao@kernel.org>
X-Mailer: git-send-email 2.49.0.604.gff1f9ca942-goog
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
v2:
- tune linear_lookup feature before fault injection
- check status after tuning linear_lookup feature
- clean up codes
 tests/f2fs/012     | 73 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/012.out |  2 ++
 2 files changed, 75 insertions(+)
 create mode 100755 tests/f2fs/012
 create mode 100644 tests/f2fs/012.out

diff --git a/tests/f2fs/012 b/tests/f2fs/012
new file mode 100755
index 00000000..38a63f2e
--- /dev/null
+++ b/tests/f2fs/012
@@ -0,0 +1,73 @@
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
+check_lookup()
+{
+	local nolinear_lookup=$1
+	local dir=$SCRATCH_MNT/dir
+	# red heart charactor in unicode format
+	local redheart=$dir/$'\u2764\ufe0f'
+
+	_scratch_mkfs -O casefold -C utf8 >> $seqres.full
+	_scratch_mount
+
+	mkdir $dir
+	$F2FS_IO_PROG setflags casefold $dir >> $seqres.full
+	touch $redheart
+	ino=`stat -c '%i' $redheart`
+	_scratch_unmount
+
+	# should tune nolinear_lookup feature before fault injection
+	$F2FS_FSCK_PROG --nolinear-lookup=$nolinear_lookup $SCRATCH_DEV >> $seqres.full
+
+	# check whether linear_lookup is changed as expected
+	if [ $nolinear_lookup == "1" ]; then
+		$F2FS_FSCK_PROG $SCRATCH_DEV | grep -q "linear_lookup \[disable\]" ||	\
+					_fail "linear_lookup is not disabled"
+	else
+		$F2FS_FSCK_PROG $SCRATCH_DEV | grep -q "linear_lookup \[enable\]" ||	\
+					_fail "linear_lookup is not enabled"
+	fi
+
+	$F2FS_INJECT_PROG --dent --mb d_hash --nid $ino --val 0x9a2ea068 $SCRATCH_DEV >> $seqres.full
+
+	_scratch_mount
+	if [ $nolinear_lookup == "1" ]; then
+		[ -f $redheart ] && _fail "red heart file should not exist"
+	else
+		[ -f $redheart ] || _fail "red heart file should exist"
+	fi
+	_scratch_unmount
+
+	# to avoid _check_filesystems failure in the end of test
+	_repair_scratch_fs >> $seqres.full
+}
+
+check_lookup 1
+check_lookup 0
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

