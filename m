Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181A425486D
	for <fstests@vger.kernel.org>; Mon,  4 Aug 2025 11:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754307628; cv=none; b=pNmV0XGahoBArG/1jtJA9CMRZxmwpz7+sgCc/g0+LfbaZZeumS8tL72DIwwOLIDG6azPK1dgfStE8FZw1jFLVQkRFZIvjX+zioYqbC/aLy4tE84fZGMvuMFXP6Z0DnrJYg84yaIWu0r20CR45SWZcDhOU/rZQ5Sz20hf3mJf50Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754307628; c=relaxed/simple;
	bh=hFks3NyqWVlUlptsrN8TMupvkN80DLByWlaShd7hXuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J3S5uI8o0CMJlA3MqaTl4cPAVVDrDcy6czjyG2r/yiZOfIvFJvZbJbzzvHZ9CljCScN42puFMVgx1YdL5Zvhk+IUQPDOIN4ckRCmm/1SRKnGUKQYo0oKnHR9TgmsmOGb6bF6JZulpVjMhDs9XG45VF2dDJ3vMnyOvClp26Sg+dM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVIwDQxi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVIwDQxi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C893C4CEE7;
	Mon,  4 Aug 2025 11:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754307627;
	bh=hFks3NyqWVlUlptsrN8TMupvkN80DLByWlaShd7hXuQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PVIwDQxiRvRlC06gQ9gN3GVsDP/ursYqRo8/3qsgUH1rghI4WiGcCSm7pbpmwv7wW
	 N4aXHnxmkWZKAi/J4saC+d6hHAAv4dE4VJDbvXcYxcCqSNM1p7jEo20OnFjn3aXBwB
	 9wiEDboKxk1XDDyvtgo51uvbjbq2a1JEF9CYkoaAKvarNIvfPIgA+H0UqH1qSvCXHE
	 ZMlFvX/l/cd+E0KhIUXh+oOkiNmbujPDMgXIPVXyq71Q3xFTBLGm4vsEiGMEghGT+y
	 NSWBZgtOzjvaskTPGGSS74H2LlPWaNy0Aw9QTteCtBxo9SI47OEUMECxyCWuFvbc9p
	 08o5FxA9d7qkw==
From: Chao Yu <chao@kernel.org>
To: Zorro Lang <zlang@kernel.org>,
	fstests@vger.kernel.org
Cc: jaegeuk@kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v3 3/3] f2fs/017: test mount options for zoned device
Date: Mon,  4 Aug 2025 19:40:16 +0800
Message-ID: <20250804114016.2734919-3-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <20250804114016.2734919-1-chao@kernel.org>
References: <20250804114016.2734919-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As f2fs changes to use new mount APIs, let's add a new testcase
to check mount result for special mount options for zoned device
and their combinations, in order to detect any inconsistency during
mount.

Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 tests/f2fs/017     | 40 ++++++++++++++++++++++++++++++++++++++++
 tests/f2fs/017.out | 21 +++++++++++++++++++++
 2 files changed, 61 insertions(+)
 create mode 100755 tests/f2fs/017
 create mode 100644 tests/f2fs/017.out

diff --git a/tests/f2fs/017 b/tests/f2fs/017
new file mode 100755
index 00000000..cdf42fc8
--- /dev/null
+++ b/tests/f2fs/017
@@ -0,0 +1,40 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
+#
+# FS QA Test No. f2fs/017
+#
+# This testcase tries to check stability of mount result
+# w/ mount options for zoned device and their combination.
+#
+. ./common/preamble
+_begin_fstest auto quick mount
+
+_require_zoned_device "$TEST_DEV"
+_test_unmount >> $seqres.full 2>&1
+
+options=(
+#	mount_option			mkfs_option
+	"background_gc=on"		"blkzone"		\
+	"background_gc=off"		"blkzone"		\
+	"background_gc=sync"		"blkzone"		\
+	"mode=adaptive"			"blkzone"		\
+	"mode=lfs"			"blkzone"		\
+	"mode=fragment:segment"		"blkzone"		\
+	"mode=fragment:block"		"blkzone"		\
+	"discard_unit=block"		"blkzone"		\
+	"discard_unit=segment"		"blkzone"		\
+	"discard_unit=section"		"blkzone"		\
+)
+
+for ((i=0;i<${#options[@]};i=i+2))
+do
+	echo "Option#$i: ${options[$i]} : ${options[$((i+1))]}"
+	_test_mkfs "-m" >> $seqres.full || _fail "mkfs failed"
+	_test_mount "-o ${options[$i]}" >> $seqres.full 2>&1
+	echo $?
+	_test_unmount >> $seqres.full 2>&1
+done
+
+status=0
+exit
diff --git a/tests/f2fs/017.out b/tests/f2fs/017.out
new file mode 100644
index 00000000..c260e0b1
--- /dev/null
+++ b/tests/f2fs/017.out
@@ -0,0 +1,21 @@
+QA output created by 017
+Option#0: background_gc=on : blkzone
+0
+Option#2: background_gc=off : blkzone
+32
+Option#4: background_gc=sync : blkzone
+0
+Option#6: mode=adaptive : blkzone
+32
+Option#8: mode=lfs : blkzone
+0
+Option#10: mode=fragment:segment : blkzone
+32
+Option#12: mode=fragment:block : blkzone
+32
+Option#14: discard_unit=block : blkzone
+0
+Option#16: discard_unit=segment : blkzone
+0
+Option#18: discard_unit=section : blkzone
+0
-- 
2.49.0

