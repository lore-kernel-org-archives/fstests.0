Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F4138AC7B
	for <fstests@vger.kernel.org>; Wed, 29 Jul 2026 02:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785293714; cv=none; b=dYGzw0JLztx8I4DHYJzNo/5UkCDht2+fpVX2PAknzGMY5KodQSxmXlshTsZm3ltCZHYY3HOftS+jllBHwemFeiB82uq0JBd/b2PQzS30fQEZKLIBFBFlKzkPurgJSHIeeRCCsP/vB+ej0PKy0fzzS6ObwAQDvXbstH1z09OVMc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785293714; c=relaxed/simple;
	bh=9sx8KpJQ8zZQIkq2TbqTseJ6M3MToG8lQm26RBQHbHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hdsRogeYLukZbCkGCoOPWTo0ZjIyisUqmhSVbLKXXMIdu6FAF0xnzWS13KgRpwhCggb8RSChnNWjDAK4KrIN/VhbjR5BLIlKaJV/IWJOrtKdvbPm9MZabc9rNxDTBzpqTHfyAGI1rbFGVFe5OQzcxRCboa/cPuFkmjsx/600Uqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ob7aGGxV; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob7aGGxV"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2caea3f742bso6827205ad.0
        for <fstests@vger.kernel.org>; Tue, 28 Jul 2026 19:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785293712; x=1785898512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eXPU/pRau728ab5U6cQmQyA1jJ+oymXCadSZuiVyCcg=;
        b=Ob7aGGxV/iN17P+Zh1fvCj0WZif1NW5tAwx6C1X9Gv3+aPW2cINQYBWTyYEO/R/F77
         iuZSQGJc7BjwCd9o7ZHoQxlFIEo76pE/O0IYnTcGIE8/fwXtfoNCHVjg83YoaWQsD+rS
         j1kaVasv3jQDlaTKjhhgAyrxjA7diQJhzM9Y+3IKB7ZCyRzxgNEfEA5Lm4UA8z7FIcLF
         Jpu1Ia62tbrXQp+rkfQ87dWMBrsTdnJZIX2FkGqJcyUhBxSVIejnPuNXmOAASb4T3kn/
         8KLGXNNx0pM1bIZluFZm0Xjwp5xrCtEwwLuLlzKCUoBK01lD2hNqEwG7E4B6QyJW/kx9
         mlaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785293712; x=1785898512;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eXPU/pRau728ab5U6cQmQyA1jJ+oymXCadSZuiVyCcg=;
        b=drBwedXWOuzijI5qOA7KAoE+BbiGoDiq20ed9dalHiD0ZOelxtaEe3vRm3sQ8Jeuro
         kzU4fS+17W/EsIe2k39zXOUiYllrekOoa9lvJZqymBlePK6Uw4DDNQxwc1JZ/GRkc0x2
         Gt6BqMESnATTFmGf8GOqqOQgt8vDNnfXpEJ4jGb2a1/AxA3I4vSM1OfUJ9BR6gAHiKha
         s6h+7FIQYZZTIBTx6vYDencHpeDomzsVi0FVguDc3LTkakv1FbVLy+kY3Ier7Hr9P4pw
         MI+r2nJRnIo5B5PEwTJMp1DOB5LwqmmOSNbbfuLvI0gJK0ZDDf2oZCTZnkZREQeoPbqX
         rktA==
X-Forwarded-Encrypted: i=1; AHgh+RosjQ+WZ6oy0LuUtiS9ULDJVHJ4HhXp/op5nV8asDmj/0FibUtXqAYn4jllMu319zO0XvXWCMvz@vger.kernel.org
X-Gm-Message-State: AOJu0YxogppuNlvJnlJYbS9qlj6raleWtvDCWxmt2G26MDx9xg4ouPt0
	s5mnah4mFKpyNd6mdV297u/W2F9sjMSfreSOfM5Dk6fDXk4eMcwFUzER3vGUeN/sE1V2IdQc
X-Gm-Gg: AR+sD132A1UAE8E732Dp3UVBbAO1XaUvgYSSTZu8T8/ckwNPL/OeZLCnaXFCm//9lfu
	h0y1I8FQ6AD7yBqDNv6u0x9N2HmnoXDJ6gTUQKZtG37Uux1khPPWVtZv+/A/HWvIwaqFQ0adytJ
	/jIwAEEUWhNVH3uE9YONuYliJi4LQdtUcLV1551nw1F4/i4YNFDJlKiw0cLiTV+Rkh8Ff6otsGV
	zHStafH9aoTqWwDd8FNGR2TBA4lL6VlJlMK1cP9iZGtcT2mprWq8zLNYtoNMPT0GQbGZOAOaa3E
	JAGaRyRigk6LYq/vxUAYJDAFUl6MwhQtW6fEeMOVxY2aHvBnkp6rNFzRun/uRCp7gSuMk5LPvnA
	e3sQ19CLcvp1JyKcWEpMXH5vkKUrmh8vZjIGPhH6QLAZAL3YkWLHvPC1l/p4Pw3qDaTMmpta0sb
	HetF/FeOI5Tjx25k683SPG+HLJFltRjQ+8k9IxbtqxKnVoEw0mTaLfDJtMRraUkgUdiTeeW/9yJ
	b38D3zACmNLUsjFZkI1VCTtv4VqFwk=
X-Received: by 2002:a17:903:38c3:b0:2c9:b396:1a55 with SMTP id d9443c01a7336-2d015af7f8cmr59186925ad.12.1785293712040;
        Tue, 28 Jul 2026 19:55:12 -0700 (PDT)
Received: from JIAPENGLIN-MC0.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bc9fe9sm3999745ad.51.2026.07.28.19.55.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 19:55:11 -0700 (PDT)
From: Lin Jiapeng <ljp1205831794@gmail.com>
X-Google-Original-From: Lin Jiapeng <jiapenglin@tencent.com>
To: zlang@kernel.org,
	hch@lst.de
Cc: linux-xfs@vger.kernel.org,
	fstests@vger.kernel.org,
	djwong@kernel.org,
	jiapenglin@tencent.com
Subject: [PATCH v2] xfs/842: verify CoW after exchangerange with FILE1_WRITTEN on shared extents
Date: Wed, 29 Jul 2026 10:54:54 +0800
Message-ID: <20260729025504.54586-1-jiapenglin@tencent.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a full-file exchangerange is requested with FILE1_WRITTEN for a
fully sparse donor file, every mapping pair is skipped, so no extents
actually move.  However, the kernel decides to swap the reflink inode
flag based on the request geometry alone, so the target file used to
lose its reflink flag to the donor while still owning shared extents.
A subsequent write then took the non-reflink write path and modified
the shared physical blocks in place, silently corrupting the other
file sharing them:

 --- tests/xfs/842.out
 +++ results/xfs/842.out.bad
 @@ -1,4 +1,5 @@
  QA output created by 842
 +vX.reflink = 0
  vX.reflink = 1
 -vX.reflink = 1
 +orig changed: md5 e6065c4aa2ab1603008fc18410f579d4 -> 32c5189478e6bafa1cc76423f06c88f2 (write hit shared blocks in place)
  Silence is golden

This test clones a file so that both share extents, swaps the clone
against a sparse donor with FILE1_WRITTEN, and then checks the defect
twice.  First it inspects the inodes directly with xfs_db: the clone
must still be flagged reflink after the exchange (the donor carrying
the flag too is the conservative outcome of the fix and is harmless).
Then it writes to the clone and verifies after a mount cycle that the
original file's data is intact, i.e. the write was redirected through
CoW.

The kernel fix "xfs: fix exchange-range reflink flag clearing issue
with INO1_WRITTEN" refuses the reflink flag exchange whenever
FILE1_WRITTEN is requested, which makes this test pass.

Reported-by: Lin Jiapeng(TencentOS Red Team) <jiapenglin@tencent.com>
Link: https://lore.kernel.org/r/amgekiNKKoAdACnc@infradead.org
Suggested-by: Christoph Hellwig <hch@lst.de>
Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Lin Jiapeng <jiapenglin@tencent.com>
---
 tests/xfs/842     | 65 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/842.out |  4 +++
 2 files changed, 69 insertions(+)
 create mode 100755 tests/xfs/842
 create mode 100644 tests/xfs/842.out

diff --git a/tests/xfs/842 b/tests/xfs/842
new file mode 100755
index 0000000..c4c2be9
--- /dev/null
+++ b/tests/xfs/842
@@ -0,0 +1,65 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Tencent.  All Rights Reserved.
+#
+# FS QA Test No. 842
+#
+# Make sure that a full-file exchangerange under FILE1_WRITTEN does not strip
+# the reflink flag from a file that still owns shared extents.  When the
+# donor file is fully sparse, every mapping pair is skipped, so no extents
+# actually move; the target file must keep its reflink flag, and a later
+# write must go through CoW instead of modifying the shared blocks in place.
+
+. ./common/preamble
+_begin_fstest auto quick fiexchange
+
+# Import common functions.
+. ./common/filter
+. ./common/reflink
+
+_require_xfs_io_command exchangerange
+_require_scratch_reflink
+_require_scratch
+
+_scratch_mkfs >> $seqres.full
+_scratch_mount
+
+# Create the original file with a known pattern and clone it, so that both
+# files share the same extents.
+_pwrite_byte 0x41 0 1m $SCRATCH_MNT/orig >> $seqres.full
+_reflink $SCRATCH_MNT/orig $SCRATCH_MNT/clone >> $seqres.full
+
+# Create a fully sparse donor file of the same size.
+$XFS_IO_PROG -f -c 'truncate 1m' $SCRATCH_MNT/donor
+
+md5_before=$(md5sum $SCRATCH_MNT/orig | awk '{print $1}')
+
+# Swap the clone against the sparse donor, claiming the donor is fully
+# written (-w).  Every donor mapping is a hole, so all pairs are skipped
+# and the clone keeps its shared extents in place.
+$XFS_IO_PROG -c "exchangerange -f -w $SCRATCH_MNT/donor" $SCRATCH_MNT/clone \
+	>> $seqres.full
+
+# Directly confirm the inode flag state after the exchange: the clone
+# must still be flagged reflink.  The donor may also carry the flag, which
+# is the conservative outcome of refusing the flag exchange under
+# FILE1_WRITTEN; the extra flag is harmless and can be dropped later by
+# the regular reflink flag cleanup path.
+_scratch_unmount
+_scratch_xfs_db -c "path /clone" -c print -c "path /donor" -c print | \
+	grep reflink | sed -e 's/^v[0-9]*/vX/g'
+_scratch_mount
+
+# Overwrite part of the clone.  With the reflink flag correctly retained,
+# this must go through CoW and leave the shared blocks of orig untouched.
+_pwrite_byte 0x42 0 64k $SCRATCH_MNT/clone >> $seqres.full
+_scratch_cycle_mount
+
+md5_after=$(md5sum $SCRATCH_MNT/orig | awk '{print $1}')
+
+test "$md5_before" != "$md5_after" && \
+	echo "orig changed: md5 $md5_before -> $md5_after (write hit shared blocks in place)"
+
+echo Silence is golden
+status=0
+exit
diff --git a/tests/xfs/842.out b/tests/xfs/842.out
new file mode 100644
index 0000000..1e6345a
--- /dev/null
+++ b/tests/xfs/842.out
@@ -0,0 +1,4 @@
+QA output created by 842
+vX.reflink = 1
+vX.reflink = 1
+Silence is golden
-- 
2.50.1 (Apple Git-155)

