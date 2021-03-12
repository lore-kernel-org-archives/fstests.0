Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6424C433E6
	for <linux-fstests@archiver.kernel.org>; Fri, 12 Mar 2021 13:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7329864FB8
	for <linux-fstests@archiver.kernel.org>; Fri, 12 Mar 2021 13:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhCLNYM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 12 Mar 2021 08:24:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:60985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230077AbhCLNXz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 12 Mar 2021 08:23:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615555434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=J85YGIiJ9+N6Z6fAeTMoC1H7a36uIHonwIOiKXQii6c=;
        b=WIB30SWqnNfMDCcpkUmTueeqZeEONGYIsIDB/w4XCLixwvRSXPoOsWV9Fn2tPtOSRB0D5Q
        sqKrC8FsyPGCtdT9sPERTcRoHYZqW7zvshvBJXZS/ufISCyoEwz68nipv13s6mLHuPsoP1
        vDOnkKj5kCeblOP+S5wN/H0ng3jSr1E=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-226-IEUIwPMOOYSrq_2vLA2-fA-1; Fri, 12 Mar 2021 08:23:53 -0500
X-MC-Unique: IEUIwPMOOYSrq_2vLA2-fA-1
Received: by mail-pl1-f197.google.com with SMTP id n12so11133318plf.12
        for <fstests@vger.kernel.org>; Fri, 12 Mar 2021 05:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J85YGIiJ9+N6Z6fAeTMoC1H7a36uIHonwIOiKXQii6c=;
        b=OBCddxYPaCme511S78yXw3+GRiiwIjMmrRwkaWZXar3Ite+w3Ms/rc7BoYEmrO+Ngi
         k5kiApQenKYk0i6Dll1wzb5CQHqapakHY8bBn/xaDZFqeenZIBbOFZ4CFOgT0ktpdBnl
         ka2fPSNmyjcUkG7Mv2hn2Z/QPzhgIddHNO7S0zcpb4IBGPTU8gDEembYe6uLEm5fLUPT
         WwXehs44yjx0jnvY/i0ZK2PeLQjaqKx0pw+QwWhbHfNtZf7/NhRAWCaxNHwAHWNwcfQG
         xVPtOulZSDgkrOO4QIVnoqFSoGTWjZojutbYgBGxUaaljTTbZx7L965vWFS+xfDTZ/dL
         O4ag==
X-Gm-Message-State: AOAM5320xffZcZD64Xzm4jftn+vFGTDMUHoo9qRqjucErp1UX5TUEyRV
        kO+5WlQaxKVucjGWIit3djk+Wf6LVP8A5UxTEx2jOQ6nuKKSLmku+/JF3x9pL0mmJD2I0RExEip
        0ThbPk55LSbZmlmqA5g==
X-Received: by 2002:a63:e511:: with SMTP id r17mr11841904pgh.163.1615555432438;
        Fri, 12 Mar 2021 05:23:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxnHTU16ulwKp/B+gSFqXP9/JWvt0dlPozfBRfwl+Ohda2jeUOMLWrfanRs0priEAGxdzhMuA==
X-Received: by 2002:a63:e511:: with SMTP id r17mr11841892pgh.163.1615555432248;
        Fri, 12 Mar 2021 05:23:52 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j17sm5428234pfn.70.2021.03.12.05.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 05:23:51 -0800 (PST)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, Gao Xiang <hsiangkao@redhat.com>
Subject: [RFC PATCH v2 3/3] xfs: stress test for shrinking free space in the last AG
Date:   Fri, 12 Mar 2021 21:23:00 +0800
Message-Id: <20210312132300.259226-4-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210312132300.259226-1-hsiangkao@redhat.com>
References: <20210312132300.259226-1-hsiangkao@redhat.com>
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
Note that I don't use _fill_fs instead, since fill_scratch here mainly to
eat 125M to make fsstress more effectively, rather than fill data as
much as possible.

 tests/xfs/991     | 121 ++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/991.out |   8 +++
 tests/xfs/group   |   1 +
 3 files changed, 130 insertions(+)
 create mode 100755 tests/xfs/991
 create mode 100644 tests/xfs/991.out

diff --git a/tests/xfs/991 b/tests/xfs/991
new file mode 100755
index 00000000..22a5ac81
--- /dev/null
+++ b/tests/xfs/991
@@ -0,0 +1,121 @@
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
+	if ! _try_scratch_mount 2>/dev/null; then
+		echo "failed to mount $SCRATCH_DEV"
+		exit 1
+	fi
+
+	# fix the reserve block pool to a known size so that the enospc
+	# calculations work out correctly.
+	_scratch_resvblks 1024 > /dev/null 2>&1
+}
+
+fill_scratch()
+{
+	$XFS_IO_PROG -f -c "resvsp 0 ${1}" $SCRATCH_MNT/resvfile
+}
+
+stress_scratch()
+{
+	procs=3
+	nops=$((1000 * LOAD_FACTOR))
+	# -w ensures that the only ops are ones which cause write I/O
+	FSSTRESS_ARGS=`_scale_fsstress_args -d $SCRATCH_MNT -w -p $procs \
+	    -n $nops $FSSTRESS_AVOID`
+	$FSSTRESS_PROG $FSSTRESS_ARGS >> $seqres.full 2>&1 &
+}
+
+# real QA test starts here
+_supported_fs xfs
+_require_scratch
+_require_xfs_shrink
+_require_xfs_io_command "falloc"
+
+rm -f $seqres.full
+_scratch_mkfs_xfs | tee -a $seqres.full | _filter_mkfs 2>$tmp.mkfs
+. $tmp.mkfs	# extract blocksize and data size for scratch device
+
+decsize=`expr  42 \* 1048576`	# shrink in chunks of this size at most
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
+	while [ $size -gt $endsize ]; do
+		stress_scratch
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
+		_scratch_cycle_mount
+	done
+
+	_scratch_unmount
+	_repair_scratch_fs >> $seqres.full
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
index a7981b67..b479ed3a 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -526,3 +526,4 @@
 526 auto quick mkfs
 527 auto quick quota
 990 auto quick growfs
+991 auto quick growfs
-- 
2.27.0

