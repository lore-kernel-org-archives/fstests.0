Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B7FC43461
	for <linux-fstests@archiver.kernel.org>; Tue, 11 May 2021 07:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A0B61360
	for <linux-fstests@archiver.kernel.org>; Tue, 11 May 2021 07:40:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbhEKHle (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 11 May 2021 03:41:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51694 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230355AbhEKHld (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 May 2021 03:41:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620718827;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jLvRpw740uSxpbForp8IGPc68ioJwqeNeRJlNOmJ/oM=;
        b=Zded/Q/+59ThZWV2YmCx0TJOXeDaNuGnixOt/aI/VkR5Dqy7oMMmCG+WMVpnbK8zewxqq0
        np+CSAG7PazYr6xQa5DETknf3YS5agcRVztP5GpyV1q/R3jdxC5kagvrc1EXuxX9vRXFT2
        EfWp3wU7favLjuy0+a1xEX1qN5TrjUk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-6DEnVF1IM-OYyMsvJ6-yoA-1; Tue, 11 May 2021 03:40:26 -0400
X-MC-Unique: 6DEnVF1IM-OYyMsvJ6-yoA-1
Received: by mail-pf1-f200.google.com with SMTP id h22-20020aa786d60000b029027d0956e914so12356685pfo.23
        for <fstests@vger.kernel.org>; Tue, 11 May 2021 00:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jLvRpw740uSxpbForp8IGPc68ioJwqeNeRJlNOmJ/oM=;
        b=BC34CEj0mYBr8FlswKHoJQCt/8s1BTsLtuMtjZDZr+qkh3FbhUb0454m5VtJZFPuCR
         rZpqz/BzHkJvS2bKizcRisLXU8OJxGxx+r7LtEZ7iXrJGK328aX4AZWWk2WiKJ8OCW5w
         rNpKNDWD4UxdGQUe+Q8vae+WyoxUxteskKQIB5lAprLmWbpxZg9QM5qqJIWnI2zcOptO
         3srr5QojR27DuG7J9juKLJ8tIaygnwGing+WPoQkZsLae1vyIYerxX21aihFSWwSt2cN
         E8I5g60xbk5JV4jUk9jpZjN1ocJ+3aILtkDfNYyU5EwqjME8cfB8SUNkZD44fKko4Qk4
         DS0w==
X-Gm-Message-State: AOAM530BUetlgM+ZdHNvFiScscBLAPEjA9uP8IvxWFGAQnrq0rPj/RlE
        8Jw33zXRFCPQl422YBfP+sIVQyHsJ2ymqphzrnNcL4FIw0kxK1M3G00XYiB7gJ4vH+OYnoJnaOq
        1sjo5GCSAbAnYyOyV3A==
X-Received: by 2002:a17:90b:3689:: with SMTP id mj9mr32347285pjb.154.1620718824959;
        Tue, 11 May 2021 00:40:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrY736YK5QIBaTq1gzx9/OC6dhNX3S8uXuaws8Q2bB82NrNDgFGo06h2TCc/b/Qm9yKe8oXQ==
X-Received: by 2002:a17:90b:3689:: with SMTP id mj9mr32347263pjb.154.1620718824708;
        Tue, 11 May 2021 00:40:24 -0700 (PDT)
Received: from xiangao.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y3sm10820865pfl.153.2021.05.11.00.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:40:24 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, Eryu Guan <guan@eryu.me>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v5 3/3] xfs: stress test for shrinking free space in the last AG
Date:   Tue, 11 May 2021 15:39:45 +0800
Message-Id: <20210511073945.906127-4-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210511073945.906127-1-hsiangkao@redhat.com>
References: <20210511073945.906127-1-hsiangkao@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This adds a stress testcase to shrink free space as much as
possible in the last AG with background fsstress workload.

The expectation is that no crash happens with expected output.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 tests/xfs/991     | 120 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/991.out |   8 ++++
 tests/xfs/group   |   1 +
 3 files changed, 129 insertions(+)
 create mode 100755 tests/xfs/991
 create mode 100644 tests/xfs/991.out

diff --git a/tests/xfs/991 b/tests/xfs/991
new file mode 100755
index 00000000..3561bfab
--- /dev/null
+++ b/tests/xfs/991
@@ -0,0 +1,120 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020-2021 Red Hat, Inc.  All Rights Reserved.
+#
+# FS QA Test 991
+#
+# XFS online shrinkfs stress test
+#
+# This test attempts to shrink unused space as much as possible with
+# background fsstress workload. It will decrease the shrink size if
+# larger size fails. And totally repeat 2 * TIME_FACTOR times.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+create_scratch()
+{
+	_scratch_mkfs_xfs $@ | tee -a $seqres.full | \
+		_filter_mkfs 2>$tmp.mkfs >/dev/null
+	. $tmp.mkfs
+
+	_scratch_mount
+	# fix the reserve block pool to a known size so that the enospc
+	# calculations work out correctly.
+	_scratch_resvblks 1024 > /dev/null 2>&1
+}
+
+fill_scratch()
+{
+	$XFS_IO_PROG -f -c "falloc 0 $1" $SCRATCH_MNT/resvfile
+}
+
+stress_scratch()
+{
+	local procs=3
+	local nops=1000
+	# -w ensures that the only ops are ones which cause write I/O
+	local FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -w \
+		-p $procs -n $nops $FSSTRESS_AVOID`
+	$FSSTRESS_PROG $FSSTRESS_ARGS >> $seqres.full 2>&1
+}
+
+# real QA test starts here
+_supported_fs xfs
+_require_xfs_scratch_shrink
+_require_xfs_io_command "falloc"
+
+rm -f $seqres.full
+_scratch_mkfs_xfs | tee -a $seqres.full | _filter_mkfs 2>$tmp.mkfs
+. $tmp.mkfs	# extract blocksize and data size for scratch device
+
+endsize=`expr 125 \* 1048576`	# stop after shrinking this big
+[ `expr $endsize / $dbsize` -lt $dblocks ] || _notrun "Scratch device too small"
+
+nags=2
+totalcount=$((2 * TIME_FACTOR))
+
+while [ $totalcount -gt 0 ]; do
+	size=`expr 1010 \* 1048576`	# 1010 megabytes initially
+	logblks=$(_scratch_find_xfs_min_logblocks -dsize=${size} -dagcount=${nags})
+
+	create_scratch -lsize=${logblks}b -dsize=${size} -dagcount=${nags}
+
+	for i in `seq 125 -1 90`; do
+		fillsize=`expr $i \* 1048576`
+		out="$(fill_scratch $fillsize 2>&1)"
+		echo "$out" | grep -q 'No space left on device' && continue
+		test -n "${out}" && echo "$out"
+		break
+	done
+
+	# shrink in chunks of this size at most
+	decsize=`expr  41 \* 1048576 + 1 + $RANDOM \* $RANDOM % 1048576`
+
+	while [ $size -gt $endsize ]; do
+		stress_scratch &
+		sleep 1
+
+		decb=`expr $decsize / $dbsize`    # in data blocks
+		while [ $decb -gt 0 ]; do
+			sizeb=`expr $size / $dbsize - $decb`
+
+			$XFS_GROWFS_PROG -D ${sizeb} $SCRATCH_MNT \
+				>> $seqres.full 2>&1 && break
+
+			[ $decb -gt 100 ] && decb=`expr $decb + $RANDOM % 10`
+			decb=`expr $decb / 2`
+		done
+
+		wait
+		[ $decb -eq 0 ] && break
+
+		# get latest dblocks
+		$XFS_INFO_PROG $SCRATCH_MNT 2>&1 | _filter_mkfs 2>$tmp.growfs >/dev/null
+		. $tmp.growfs
+
+		size=`expr $dblocks \* $dbsize`
+		_scratch_unmount
+		_scratch_xfs_repair -n >> $seqres.full 2>&1 || _fail "xfs_repair failed"
+		_scratch_mount
+	done
+
+	_scratch_unmount
+	_scratch_xfs_repair -n >> $seqres.full 2>&1 || _fail "xfs_repair failed"
+	totalcount=`expr $totalcount - 1`
+done
+
+echo "*** done"
+status=0
+exit
diff --git a/tests/xfs/991.out b/tests/xfs/991.out
new file mode 100644
index 00000000..e8209672
--- /dev/null
+++ b/tests/xfs/991.out
@@ -0,0 +1,8 @@
+QA output created by 991
+meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
+data     = bsize=XXX blocks=XXX, imaxpct=PCT
+         = sunit=XXX swidth=XXX, unwritten=X
+naming   =VERN bsize=XXX
+log      =LDEV bsize=XXX blocks=XXX
+realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
+*** done
diff --git a/tests/xfs/group b/tests/xfs/group
index 472c8f9a..53e68bea 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -521,3 +521,4 @@
 538 auto stress
 539 auto quick mount
 990 auto quick growfs shrinkfs
+991 auto growfs shrinkfs ioctl prealloc stress
-- 
2.27.0

