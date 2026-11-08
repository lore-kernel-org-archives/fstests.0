Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794101982;
	b=21k5h/R37xCZgBmsydma7mJng5d3GnRCytfegDLa4ehHL2GUkW4P8D8R/eP+BkUOg23l
	 YcClbFjLK60y/KufIxXDmEbnXKfnId6dNRbhN9tnUN0JEhrYNAt8dJa61gSL8XrPcM/UZ
	 AZzq7yy+6/AFu2B+kqAEPaQCdgpuEwkoIbYFppiZQMUDKkYWu5n2S9rBQ66Cds8SpLD9X
	 +rqlFk+jfxZ/R7ocqi0Rg5bAEEFrUpoyZZYKItomc9EzDiO2K9GWIHk7x12YqH01u4X04
	 E4V/e62J9iSGQ+xkgl2OUK8CujGQ9W94CiuvORCBS7IecBiAWtH7yRiwd9m5wws/ECw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794101982;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ZLeTlITFAOFZPhutPAGIGwQCM2NSiyP5wkq6aWFFYoY=;
	b=Z55Ep+RNLaVMXWd4pI7ztaXCLiTuqnGE5jJGtOtR6/zgZBPy9D28LT01xiZTSN6bMkzt
	 Dls6E5q40lVoWMakTOZ+Kj3iSWxFtbhhue2oooOQ7O8kDKjLOr3SIgnai/Q8xGMP+O/fk
	 5TMlPz649ZDYrz3rPBGdOWzlBMoAzK4Ki0QSufCCv1tH6efxY8vAlo4ofMq3hMbQV6R/H
	 gz2eRLzgpSRJ1JZchmngqypzTwl1ONAaAqMrRVmhiNw/sSghMBMPIzuFnTwq4V2llqSUS
	 heQsM6AuoFT2KF54fsZhM0h1r6kVsb+BFHFCWT2QQf3Ft1wBddB1dMrO7OBvgBrhDaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oAO4Ppow;
	arc=none smtp.remote-ip=209.85.217.51
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com [209.85.217.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDA0606A326
	for <fstests@vger.kernel.org>; Sun,  8 Nov 2026 01:39:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7BDA0606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oAO4Ppow
Received: by mail-vs1-f51.google.com with SMTP id ada2fe7eead31-7a6e560f580so109122137.1
        for <fstests@vger.kernel.org>; Sat, 07 Nov 2026 17:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794101980; x=1794706780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZLeTlITFAOFZPhutPAGIGwQCM2NSiyP5wkq6aWFFYoY=;
        b=oAO4Ppowjo8eUlF76N/DZJN1tgfjfQ+1MNJri4U0iKNeio2NArPZBfDPAvVw8DCQ7c
         25vWS1cc+XvUst6SBK4T4jdV4SIZMVS99h7xY2DvETcX541RWsF1EBO8Bq7G3s32RBC5
         CPn0Hm+b3LZPL/ehEmNch1HNN+wGHiQx8dyHjMUfr89/vu4LfqL6ew9Y8RpV/skb2+JA
         7uUqdUdZ4c4uGoWxKmKEybnV9VB3p4NLQ6bK5LZb2gDfSBs1fJfD947yQUUkTF2aEtQI
         mgBFJgBFRw9zi6OI+bsBwaQbBlRPNiDzO+K7RqBRocWrcbzt8l748MuF+ovpE/hKTno0
         5m4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794101980; x=1794706780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZLeTlITFAOFZPhutPAGIGwQCM2NSiyP5wkq6aWFFYoY=;
        b=Jxf4A7XIxTPJD4NbuYd3mxAjVymplsaf6pLL9q0YQUVF6uNwAjueLX5d1DvnHdKH6U
         7LrUUmwTI9Mc1osBgqR4g+Q4Nn1I7fzZsQdfiCqIxGlo+si9rIXGhvVzvIdBhd53ESX1
         Gp/C2fP0cf9MRIGpAIICkBQ6ZFVlppEZXzFytEp7s+XJgWfuGP4esIZAFCUCJhnLvbA/
         FzCoXN88t7IMrTvYxLl8RpZmVHbUe9njz7hCAKjPKlGw7WIg7ZAL17Djfgjx32o1GThk
         08ujvqqRD3KuXzxl7bv9D5fou8cQIVbfvUS/BgN6mRi+tj1O6AKghUzeg9yEoIf0P9kc
         lP/Q==
X-Gm-Message-State: APuU4Z/hxqY/dLWOieOU90vmjN/Cq9vT0xnb5CayOOjarf9dfQdkNV7p
	OPx+buj9TQtwpq80X3z7aksvKeeaQ8WdOV+ORG5a+Oybv0qV7ByU08vHOOmLiQ==
X-Gm-Gg: AYBFou1DA0TxT37r7ZAzdiqDP/JtBtXbIgFHWSRMbtz3IsW1FpOs9YxZVjkTNoudhRG
	qcTE+l+2qD43Jly423XrBLo18LoR1ZxmPq49rxHLkBuDQlySntuZ2zSKaFQxjaHWJ2KpjJvU7PX
	YuQowRJsHhgH5cBB16F7R/95w9WYfoLkZ0xrgXOibwZk4DDJXSAIv/NyColcW/yrWsWqI+TCgjS
	CdohtxfJ7eMXDUYhg7IfYR2dAmJ7bgmg8NSBV4R/K2SHT/fyY9rvzcw/8EoOQmPE5xTAdXM0kk3
	8vahb3o9UASr3Y/CRCvk5FdOQDq5tyTrQAJn4bKnHwZxi/Ouy/hL7HAtr6KTmdGVCvuMQMio8Vf
	yDUBsX2GO3nMttrJ5AP5T5Xlp/18MqNREda0chri/X72OJTxdSnTK7IDfgstSUUCKNcue5gjD3I
	OMPcRrW5Gh9f9c7f+SpOYUeh149S4JfOP8vYFN9O8H19YB4p1dMr8gMQcJuf55gIKtjih4tWLRm
	VVZ5yxPGkrhvQyCZfkBCHLrW5jijYVEUSfJR1q4bgJdTn9HdY0O/Fa/UPlkftyxHyBj8131+D+G
	11qk88elifiOPuHHCZpO64JyLSlGviBWIqmt
X-Received: by 2002:a05:6102:38cd:b0:7b4:879c:bb8d with SMTP id ada2fe7eead31-7d2db23ff6amr110544137.37.1794101980344;
        Sat, 07 Nov 2026 17:39:40 -0800 (PST)
Received: from diego.local ([186.151.96.233])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d2db605322sm501538137.7.2026.11.07.17.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 17:39:39 -0800 (PST)
From: Diego Rivera <diego.rivera.cr@gmail.com>
To: fstests@vger.kernel.org
Cc: zlang@kernel.org,
	linux-xfs@vger.kernel.org
Subject: [PATCH fstests] xfs: test xfsdump dump levels above 9
Date: Sat,  7 Nov 2026 19:39:27 -0600
Message-ID: <20261108013927.3185548-1-diego.rivera.cr@gmail.com>
X-Mailer: git-send-email 2.43.0
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

xfsdump used to accept dump levels 0-9 only. Add a test, cribbed from
xfs/064, that dumps a chain of incrementals across that old limit and
up to the new maximum of 254, checks that each one is based on the
previous dump, that a level past the maximum is rejected, that the
inventory records and filters the real levels (with 255 still meaning
"any level" for xfsdump -I level=), and that a cumulative restore of
the whole chain reproduces the original tree.

Add _require_xfsdump_level to common/dump, so the test is skipped with
an xfsdump that does not support the levels it needs. It relies on
xfsdump naming its maximum level when it rejects an out of range -l,
which every version does.

Drafted with an AI coding assistant (Claude); details in the cover
letter of the xfsdump series linked below.

Signed-off-by: Diego Rivera <diego.rivera.cr@gmail.com>
---

Notes:
    Needs the xfsdump series at
    https://lore.kernel.org/linux-xfs/20261108012410.3156325-1-diego.rivera.cr@gmail.com/
    xfs/842 is skipped with released xfsdump.

 common/dump       | 17 ++++++++++
 tests/xfs/842     | 83 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/842.out | 52 +++++++++++++++++++++++++++++
 3 files changed, 152 insertions(+)
 create mode 100755 tests/xfs/842
 create mode 100644 tests/xfs/842.out

diff --git a/common/dump b/common/dump
index 09859006..4d240685 100644
--- a/common/dump
+++ b/common/dump
@@ -80,6 +80,23 @@ _require_legacy_v2_format()
     _notrun "xfsrestore -K option required"
 }
 
+#
+# Require xfsdump to accept dump levels up to and including $1.
+# xfsdump rejects an out of range -l before doing anything else, and
+# names the highest level it supports when it does.
+#
+_require_xfsdump_level()
+{
+    local want="$1"
+    local max=""
+
+    max=`$XFSDUMP_PROG -JF -l 999999 -f /dev/null 2>&1 |
+	sed -n -e 's/.*-l argument must be between 0 and \([0-9]*\).*/\1/p'`
+    [ -n "$max" ] || _notrun "cannot determine xfsdump maximum dump level"
+    [ "$max" -ge "$want" ] || \
+	_notrun "xfsdump dump level $want required (supports 0-$max)"
+}
+
 #
 # do a remote/local mt
 #
diff --git a/tests/xfs/842 b/tests/xfs/842
new file mode 100755
index 00000000..462665dc
--- /dev/null
+++ b/tests/xfs/842
@@ -0,0 +1,83 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2026 Diego Rivera.  All Rights Reserved.
+#
+# FS QA Test No. 842
+#
+# Test multilevel dumps and cumulative restores at dump levels above 9, up
+# to the maximum of 254, and that a level beyond that is rejected.
+# This procedure is cribbed from:
+#     xfs/064: test multilevel dump and restores with hardlinks
+#
+. ./common/preamble
+_begin_fstest dump auto
+
+# Override the default cleanup function.
+_cleanup()
+{
+	_cleanup_dump
+	cd /
+	rm -f $tmp.*
+}
+
+# Import common functions.
+. ./common/filter
+. ./common/dump
+
+_require_scratch
+_require_xfsdump_level 254
+
+_scratch_mkfs_xfs >>$seqres.full
+_scratch_mount
+
+_create_dumpdir_hardlinks 3 >>$seqres.full
+
+# Cross the old limit of 9, then go up to the maximum. Each dump is at a
+# higher level than the one before it, so each is based on the previous one.
+levels="0 1 9 10 11 99 253 254"
+
+echo "Do the incremental dumps"
+for i in $levels; do
+	if [ $i -gt 0 ]; then
+		sleep 2
+		_modify_level $i
+	fi
+
+	_stable_fs
+	sleep 2
+
+	echo "********* level $i ***********" >>$seqres.full
+	_do_dump_file -f $tmp.df.level$i -l $i | \
+		grep -E '^xfsdump: (level|Dump Status)'
+done
+
+echo "Dump at a level beyond the maximum"
+$XFSDUMP_PROG -JF -l 255 -f /dev/null $SCRATCH_MNT 2>&1 | \
+	tee -a $seqres.full | \
+	sed -n -e 's/^.*\(-l argument must be\)/\1/p'
+
+echo "Levels recorded in the inventory"
+$XFSDUMP_PROG -I depth=2 | tee -a $seqres.full | \
+	$AWK_PROG '/level:/ { l = l (l == "" ? "" : " ") $2 } END { print l }'
+echo "Inventory sessions at level 254"
+$XFSDUMP_PROG -I depth=2,level=254 | \
+	$AWK_PROG '/level:/ { l = l (l == "" ? "" : " ") $2 } END { print l }'
+echo "Inventory sessions at level 255 (any level)"
+$XFSDUMP_PROG -I depth=2,level=255 | \
+	$AWK_PROG '/level:/ { l = l (l == "" ? "" : " ") $2 } END { print l }'
+
+echo "Do the cumulative restores"
+_prepare_restore_dir
+for i in $levels; do
+	echo "restoring from df.level$i"
+	_do_restore_file_cum -f $tmp.df.level$i | \
+		grep -E '^xfsrestore: (level|Restore Status)'
+done
+
+echo "Compare the restored tree with the original"
+diff -r $dump_dir $restore_dir/$dump_sdir >>$seqres.full 2>&1 || \
+	echo "restored tree differs from the original"
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/842.out b/tests/xfs/842.out
new file mode 100644
index 00000000..2b4bea03
--- /dev/null
+++ b/tests/xfs/842.out
@@ -0,0 +1,52 @@
+QA output created by 842
+Do the incremental dumps
+xfsdump: level 0 dump of HOSTNAME:SCRATCH_MNT
+xfsdump: Dump Status: SUCCESS
+xfsdump: level 1 incremental dump of HOSTNAME:SCRATCH_MNT based on level 0 dump begun DATE
+xfsdump: Dump Status: SUCCESS
+xfsdump: level 9 incremental dump of HOSTNAME:SCRATCH_MNT based on level 1 dump begun DATE
+xfsdump: Dump Status: SUCCESS
+xfsdump: level 10 incremental dump of HOSTNAME:SCRATCH_MNT based on level 9 dump begun DATE
+xfsdump: Dump Status: SUCCESS
+xfsdump: level 11 incremental dump of HOSTNAME:SCRATCH_MNT based on level 10 dump begun DATE
+xfsdump: Dump Status: SUCCESS
+xfsdump: level 99 incremental dump of HOSTNAME:SCRATCH_MNT based on level 11 dump begun DATE
+xfsdump: Dump Status: SUCCESS
+xfsdump: level 253 incremental dump of HOSTNAME:SCRATCH_MNT based on level 99 dump begun DATE
+xfsdump: Dump Status: SUCCESS
+xfsdump: level 254 incremental dump of HOSTNAME:SCRATCH_MNT based on level 253 dump begun DATE
+xfsdump: Dump Status: SUCCESS
+Dump at a level beyond the maximum
+-l argument must be between 0 and 254
+Levels recorded in the inventory
+0 1 9 10 11 99 253 254
+Inventory sessions at level 254
+254
+Inventory sessions at level 255 (any level)
+0 1 9 10 11 99 253 254
+Do the cumulative restores
+restoring from df.level0
+xfsrestore: level: 0
+xfsrestore: Restore Status: SUCCESS
+restoring from df.level1
+xfsrestore: level: 1
+xfsrestore: Restore Status: SUCCESS
+restoring from df.level9
+xfsrestore: level: 9
+xfsrestore: Restore Status: SUCCESS
+restoring from df.level10
+xfsrestore: level: 10
+xfsrestore: Restore Status: SUCCESS
+restoring from df.level11
+xfsrestore: level: 11
+xfsrestore: Restore Status: SUCCESS
+restoring from df.level99
+xfsrestore: level: 99
+xfsrestore: Restore Status: SUCCESS
+restoring from df.level253
+xfsrestore: level: 253
+xfsrestore: Restore Status: SUCCESS
+restoring from df.level254
+xfsrestore: level: 254
+xfsrestore: Restore Status: SUCCESS
+Compare the restored tree with the original

base-commit: d07dca72d2455f4ba8c660ad4c008541ccccb707
-- 
2.43.0

