Return-Path: <SRS0=gdhN=AE=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38230C433E0
	for <linux-fstests@archiver.kernel.org>; Tue, 23 Jun 2020 02:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A99120720
	for <linux-fstests@archiver.kernel.org>; Tue, 23 Jun 2020 02:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHfz/toI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbgFWCFh (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 22 Jun 2020 22:05:37 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20785 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730845AbgFWCFh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 Jun 2020 22:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592877935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=jG69dWtfdhkm1YcjwmIh/6yJednkRVz/Gx+trraO3Mc=;
        b=cHfz/toIfV/ILwZ58rO4vaNMxBs0+tzLeRt5ZLiCKZYAU6em6yNF6BIKaQGnDAZOI7v8DS
        4AGC7LZI6JDesVyadcOUc5y6dtwsNZqu1oJfwzVqRMEMG235En23bvUrNBUih8vdmndVH9
        PPYRh+6PJz9RcIzH1UBDDrvrsC83zl4=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-Wvwa1KDsMKmpZwVx8xMheQ-1; Mon, 22 Jun 2020 22:05:33 -0400
X-MC-Unique: Wvwa1KDsMKmpZwVx8xMheQ-1
Received: by mail-pf1-f197.google.com with SMTP id o19so14702139pfp.6
        for <fstests@vger.kernel.org>; Mon, 22 Jun 2020 19:05:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jG69dWtfdhkm1YcjwmIh/6yJednkRVz/Gx+trraO3Mc=;
        b=p/fhLBSkiF6J38vQSrCIPX60DR1Rr5sW/x67RU35VeD8TSLWT9rv8/3YPxmo23AoTd
         ZzNOC/hf2yYD0j/GcBPHrr9fKUbtfWH6wjLxl9mmnKUGjpCeWfE/d4NR2vOfo6eALc4E
         q7Ev4SYCVx1olH8NwwqULNjkCBkyuwMt3qDP2GtYyZVNPIovDHCvc92KM6/MfGbBUiLn
         Wp9OLm/O3Dvlp7Mhz9MhB0EnY0qYVEw2QY1TsY7uFF+k3PjjTXpWnZwXaMiI2fiGwrEN
         94vcuj50i28mdffdEEJuU9d7U/Ob8yHcs4wilm3lbTnRcZYDS8HNNtex58p2JU/oLYdm
         mcaQ==
X-Gm-Message-State: AOAM530v7pDywU3+3FCDI8E3T5dJgAEIpZrf2o9tcnX+KlKWtUMnppfJ
        VoFNpiYWaZmh6b9c7+w4lf1RHenifkujdUO6udnuHOs/iTZ1B3qRiM6dFMzlYmGRhdoTMW6Szj3
        Bia0EgFgdkmFIHdVPMA==
X-Received: by 2002:a62:ddc4:: with SMTP id w187mr22482203pff.63.1592877932267;
        Mon, 22 Jun 2020 19:05:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwruLk25f/JFmEzGy7OCOoC7o6F1cQ6yvG4KEWKyj1gtAuNI5su0Q9aoPJJ5+Z7gSyWmsLF8w==
X-Received: by 2002:a62:ddc4:: with SMTP id w187mr22482181pff.63.1592877931985;
        Mon, 22 Jun 2020 19:05:31 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id m16sm14908147pfh.187.2020.06.22.19.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 19:05:31 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v2] xfs: add test for CVE-2020-12655
Date:   Tue, 23 Jun 2020 10:04:47 +0800
Message-Id: <20200623020447.5924-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200619134419.30705-1-hsiangkao@redhat.com>
References: <20200619134419.30705-1-hsiangkao@redhat.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add a regression test to see if kernel hangs in order to
look after CVE-2020-12655 and check if the corresponding
fix is applied as well.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
changes since v1:
 add "Metadata corruption" dmesg check as an auxiliary for specific kernel

 tests/xfs/520     | 87 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/520.out |  2 ++
 tests/xfs/group   |  1 +
 3 files changed, 90 insertions(+)
 create mode 100755 tests/xfs/520
 create mode 100644 tests/xfs/520.out

diff --git a/tests/xfs/520 b/tests/xfs/520
new file mode 100755
index 00000000..9e21579e
--- /dev/null
+++ b/tests/xfs/520
@@ -0,0 +1,87 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Red Hat, Inc.  All Rights Reserved.
+#
+# FS QA Test 520
+#
+# Verify kernel doesn't hang when mounting a crafted image
+# with bad agf.freeblks metadata due to CVE-2020-12655.
+#
+# Also, check if
+# commit d0c7feaf8767 ("xfs: add agf freeblocks verify in xfs_agf_verify")
+# is included in the current kernel.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1	# failure is the default!
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+_cleanup()
+{
+	cd /
+	rm -f $tmp.*
+	_scratch_unmount > /dev/null 2>&1
+}
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+# Modify as appropriate.
+_supported_fs xfs
+_supported_os Linux
+_disable_dmesg_check
+_require_check_dmesg
+_require_scratch_nocheck
+
+force_crafted_metadata() {
+	_scratch_mkfs_xfs -f $fsdsopt "$4" >> $seqres.full 2>&1 || _fail "mkfs failed"
+	_scratch_xfs_set_metadata_field "$1" "$2" "$3" >> $seqres.full 2>&1
+	local kmsg="xfs/$seq: testing $1=$2 at $(date +"%F %T")"
+	local mounted=0
+	local hasmsg=0
+
+	echo "${kmsg}" > /dev/kmsg
+	_try_scratch_mount >> $seqres.full 2>&1 && mounted=1
+
+	if [ $mounted -ne 0 ]; then
+		dd if=/dev/zero of=$SCRATCH_MNT/test bs=65536 count=1 >> \
+			$seqres.full 2>&1
+		sync
+	fi
+
+	_dmesg_since_test_start | tac | sed -ne "0,\#${kmsg}#p" | tac | \
+		egrep -q 'Metadata corruption detected at' && hasmsg=1
+
+	_scratch_unmount > /dev/null 2>&1
+	[ $mounted -eq 0 -o $hasmsg -eq 1 ] && return
+	_fail "potential broken kernel"
+}
+
+bigval=100000000
+fsdsopt="-d agcount=1,size=64m"
+
+force_crafted_metadata freeblks 0 "agf 0"
+force_crafted_metadata longest $bigval "agf 0"
+force_crafted_metadata length $bigval "agf 0"
+
+_scratch_mkfs_xfs_supported -m reflink=1 >> $seqres.full 2>&1 && \
+	force_crafted_metadata refcntblocks $bigval "agf 0" "-m reflink=1"
+
+_scratch_mkfs_xfs_supported -m rmapbt=1 >> $seqres.full 2>&1 && \
+	force_crafted_metadata rmapblocks $bigval "agf 0" "-m rmapbt=1"
+
+echo "Silence is golden"
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/520.out b/tests/xfs/520.out
new file mode 100644
index 00000000..2a59b872
--- /dev/null
+++ b/tests/xfs/520.out
@@ -0,0 +1,2 @@
+QA output created by 520
+Silence is golden
diff --git a/tests/xfs/group b/tests/xfs/group
index daf54add..433f04d0 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -517,3 +517,4 @@
 517 auto quick fsmap freeze
 518 auto quick quota
 519 auto quick reflink
+520 auto quick reflink dangerous
-- 
2.18.1

