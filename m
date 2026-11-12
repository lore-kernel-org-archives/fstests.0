Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498575;
	b=LyhYqCVAj+m9R2lhUcTBwqvqkzGSTEcN3uxgoK+XkAjJGM/13XoM8ZntHWO0EpmNpfor
	 zxuIb8KoH2RGtuTkvFrc6elaIt8owUyDGsZ1bOpswwG2dGXx8tI8k/XhvzZu1nQzBQf1t
	 +NfWmx9QrR9EcVFxGatq6oKLJ1iXQIX9KYNXYa8LfYjapfKfdIhm//A6z3p3RGqmJUQ82
	 dDryTWyxnNLdYwR+hxeY/M9IsP2gbI1UE+Ioh013KMDdmMKF49JrZow73MAdxeA/MSxQp
	 J0wfWtEJG73e5Ylifi2t6n65L0qXHC2Cs9O9sMPRrehz6rk6TKALjXwlw/bVvt5FoTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498575;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JB9RC+A5BbaSKEWWha0jLo9ULFAdBPRzEEnoru6E9DQ=;
	b=BgxfT3DeQcNpYKIK/u2ezX8Fj1odx/Y5DPIs+Vr3laCltqPrc+Uo0Bc9qxy2dO7tUHM6
	 zOIXfPJv6wGOK49br5DeNkf8x5/zmNSsMkO4kMUSPMU7pZCLgRtucOHkpaCs3Yo9p8gEt
	 /YoSla0AcbVNcfuT5hXeZCURlK6Z73r1kRWrkHfJLdsqzReD3e+rvwtoUwAcBL6GMzeGh
	 czTo7voBh1Oj754rib2NKhP7J96TbuMkMXuCU8N9crLL1WRXJ2yS48ipDbe4UxfrH2Xn4
	 57KpXWaSkOwbeQxshp6IshJaAH0ZAc9prjqcfQdGAu14R24/dv3Z5+y2H3+LeO04Tdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cs.unc.edu;
	spf=pass smtp.mailfrom=cs.unc.edu;
	dkim=pass header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=RpcvTqLC;
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E42F606A32A
	for <fstests@vger.kernel.org>; Thu, 12 Nov 2026 15:49:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E42F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs.unc.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cs.unc.edu header.i=@cs.unc.edu header.a=rsa-sha256 header.s=google header.b=RpcvTqLC
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b33de9d2b1so36734547b3.3
        for <fstests@vger.kernel.org>; Thu, 12 Nov 2026 07:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cs.unc.edu; s=google; t=1794498573; x=1795103373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JB9RC+A5BbaSKEWWha0jLo9ULFAdBPRzEEnoru6E9DQ=;
        b=RpcvTqLCZfaaZBfCfch6W8UhCFu7GYDnR43kqQUnZL9ZxjV/Tc65Id5KCj8AWwYeJN
         j0ebk0vHxJt7lx1+Cvuj7Ju+QFOchRYzErPNT6qwr5YswiIBZCbL6kEUIF31cM9riu/i
         YhEY18D9Zylj/5WE2W9aNC6g1Qrdga1cJNRr9JlriGANAgt4xBjIlVgq1bgZwHM5J3bx
         4CCzWMIpCrrJnVwnulvc9xhsn8GDvls4JkevWYORFd/+4AlUJLSvIU08MkSBQg+TAgmM
         Qs0j85g5b6tajMaVia0/dSjoQHidID+BR6DtKyxTe8PTpmf8ZoQDmuWXrFs9Q1ARwBRj
         Cd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498573; x=1795103373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JB9RC+A5BbaSKEWWha0jLo9ULFAdBPRzEEnoru6E9DQ=;
        b=vnS19M7JT+BMDS18oo7lHA6m3P4o5T7mGpu3pGP2mj7eIS1hEm2ZuAFZkFIdIBIQIW
         roAG+ZTYw/p8M8pqQ2O/KlJOBF1LAYva9g+X28dS/g97ojcNzJ/qIRPwgEy+ZE9cUtHV
         yCXTGqDxPa8ALhbaTAJU7GTGJ3Sv1vEO0MhabnQg/YJNdNzE/lNLYMTcWOkiqX97lHcn
         PHSjlWJKUMszEQSoTXbHIUSlD7FwEeV/aBEF6zdXmAKcxFdAPqECTTNW9+eFEeM/+mnt
         K7/K7Md9ptgdTL0kA6BisfRGcQ602LmrVaQN5JzSQ9uR0qjzFKgCVJXHP47bfTsaa5X5
         LeuQ==
X-Gm-Message-State: APuU4Z/lTw+fHv2EbgwNJqzNLoaKtQ7EDMBxcN5691j3XfDngE4qkGDK
	AOYIwUzNjk0vfasNmqOP4fYubudwOzytmnL1vMM+IQJk2C08wy397RZLCHj1K9FaqWbliUFZUnb
	taqZOlvyklgbTeoCp/d6BmzNkKWXMngdoq3UvrEV72huKOah0l9SMay5QBGHotAMB7X2NzKRxYr
	nFxCCrA0Z9X6MfiAtHfJrreivQvSIB91mCD4hJxrE=
X-Gm-Gg: AYBFou3AE6mXhqVe3uO75Abydx1d2q/rIhoIINjDmyq1fdPKiNJ4ezJrlTcyiyQpy/I
	2NwgvnEtxwu8+o7NQDzoKPsflSZPVNOU8ZMEGE6A0Xjn4pIUjHHkEigxG3feYL75oJvUoWMukXO
	xt2cMs5wt9kyT4Dj5+nheycnPCHtq3aJqv9zmSBvMz9yy7WVvS5mKdXU6iL1hlA4VSmSUz84GyH
	kmBBLynsil4zXhTLavTc8Hwt3oDgx6T+45cvoEN6p+D5N79hNW6+IwcoPvvfX+LFKBQMWWE+RIj
	VDEivO++YirYzot73tLfOY5kMsVWOiAQezcliObzLRb5yCoI4Gkglyf0Ox2moOm98g7tjk9MZYT
	iKuH3XNgmEX3slRD1v5hdfEu5zZCxYUSEFhXY1SrB96htoOc2VBKDj7J3pIjR5cvop1Jg9cT9fR
	Uvj4I5KvSZWCLtjICtXMkbx9U/hUF3wz5BtOGMbpSOQbT4rb1Mb31bcXHFOwB2nnmwnHoHdTAL4
	niw64r7Y45e6AnbX7nvitbwkA2lb5W+X3hWAOrSBIfIuyewI6zDW4TihaTyy9glXHLsOthN5hAU
	vc10p3gXTRtnCebSVpszlvaS7pgofsLJy0VoAVzSqpn4oB+brZX59YUGAOK6yIFYcQMkwgimFw=
	=
X-Received: by 2002:a05:690c:c6c5:b0:8b0:9eb3:dbd1 with SMTP id 00721157ae682-8b3a805c093mr23509097b3.37.1794498573459;
        Thu, 12 Nov 2026 07:49:33 -0800 (PST)
Received: from cobra01.cs.unc.edu (cobra01.cs.unc.edu. [152.2.130.143])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b393409120sm72617317b3.27.2026.11.12.07.49.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:49:33 -0800 (PST)
From: Hengyu Liang <hengyul@cs.unc.edu>
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Maiolino <cem@kernel.org>,
	linux-xfs@vger.kernel.org
Subject: [PATCH] xfs: test that statfs does not report negative free blocks
Date: Thu, 12 Nov 2026 10:49:17 -0500
Message-ID: <20261112154917.751315-1-hengyul@cs.unc.edu>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a regression test for the f_bfree underflow in statfs().

Since kernel commit dd324cb79e54 ("xfs: refactor xfs_fs_statfs"), when
the free block counter is below the number of blocks that are not
available for allocation, statfs() reports f_bfree and f_bavail close
to 2^64, and df prints negative sizes.

The test moves all free blocks into the reserve pool with the resblks
command, then deletes every other file of many single-block files. The
freed blocks refill the reserve pool first, while the free space btrees
grow.

Without the fix, f_bfree is reported as 2^64 - 6 on a filesystem with
4k blocks.

Link: https://lore.kernel.org/linux-xfs/20261112102018.3922571-1-hengyul@cs.unc.edu/
Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>
---
Tested in a VM on xfs for-next 48326a2382d8 (v7.4-rc2) with mkfs.xfs
6.18 defaults, "-m rmapbt=0,reflink=0" and "-b size=1024": the test
fails without the kernel fix and passes with it.

 tests/xfs/842     | 57 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/842.out |  2 ++
 2 files changed, 59 insertions(+)
 create mode 100755 tests/xfs/842
 create mode 100644 tests/xfs/842.out

diff --git a/tests/xfs/842 b/tests/xfs/842
new file mode 100755
index 00000000..c99dd4f3
--- /dev/null
+++ b/tests/xfs/842
@@ -0,0 +1,57 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Hengyu Liang.  All Rights Reserved.
+#
+# FS QA Test No. 842
+#
+# Make sure that statfs() does not report a negative or huge number of free
+# blocks when the free block counter drops below the blocks that are not
+# available for allocation.
+#
+# Move all free blocks into the reserve pool, then free many small extents.
+# The freed blocks refill the reserve pool first, so the free block counter
+# stays the same, while the free space btrees grow.
+#
+. ./common/preamble
+_begin_fstest auto quick
+
+_fixed_by_kernel_commit xxxxxxxxxxxx \
+	"xfs: fix f_bfree underflow in statfs()"
+
+_require_scratch
+_require_xfs_io_command "falloc"
+
+# Only the data device counters are checked.
+_disable_scratch_realtime
+
+_scratch_mkfs >> $seqres.full 2>&1
+_scratch_mount
+_require_xfs_scratch_non_zoned
+
+# A free space btree leaf holds about blksz / 8 records.  Deleting every
+# other file of blksz / 2 single-block files adds blksz / 4 records, which
+# takes a few more leaf blocks.
+blksz=$(_get_block_size $SCRATCH_MNT)
+nr_files=$((blksz / 2))
+_require_fs_space $SCRATCH_MNT $((nr_files * blksz * 2 / 1024))
+
+for ((i = 0; i < nr_files; i++)); do
+	$XFS_IO_PROG -f -c "falloc 0 $blksz" $SCRATCH_MNT/s$i
+done
+
+# Ask for more blocks than the filesystem has, so that the reserve pool takes
+# all free blocks and stays short of its target.
+nr_blocks=$(stat -f -c '%b' $SCRATCH_MNT)
+$XFS_IO_PROG -x -c "resblks $((nr_blocks * 2))" $SCRATCH_MNT >> $seqres.full
+
+find $SCRATCH_MNT -name 's*[13579]' -delete
+_scratch_sync
+
+# Before the fix, f_bfree and f_bavail were 2^64 minus a few blocks.  Some
+# versions of stat print that as a negative number.
+stat -f -c '%b %f %a' $SCRATCH_MNT | tee -a $seqres.full | $AWK_PROG '
+	$2 < 0 || $2 > $1 { print "f_bfree " $2 " out of range, f_blocks " $1 }
+	$3 < 0 || $3 > $1 { print "f_bavail " $3 " out of range, f_blocks " $1 }'
+
+echo "Silence is golden"
+_exit 0
diff --git a/tests/xfs/842.out b/tests/xfs/842.out
new file mode 100644
index 00000000..643d0528
--- /dev/null
+++ b/tests/xfs/842.out
@@ -0,0 +1,2 @@
+QA output created by 842
+Silence is golden

base-commit: 71641219a506ac62bfa231592394265ca812670e
-- 
2.53.0

