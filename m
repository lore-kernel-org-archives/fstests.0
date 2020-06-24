Return-Path: <SRS0=2U3A=AF=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17980C433E0
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Jun 2020 01:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D55022073E
	for <linux-fstests@archiver.kernel.org>; Wed, 24 Jun 2020 01:07:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJ7mdSoG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387916AbgFXBHT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:07:19 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54193 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387890AbgFXBHT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 23 Jun 2020 21:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592960837;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=VNqQarYqkyB92A5Ii1Kht36J68Yao1MgQGq01LdrZ9E=;
        b=fJ7mdSoG135kR+G0wI6M5Kt1rYcPCKjnLywwqShle2OIReLSnds6sI+wbkLA4mRXESDc92
        V7wBqkB2+3kNEyGobmxItUdSYxTQiPaExCBKw45/qgj52wPo3WSCaGUfIOX6EhGyUgF1dG
        X0n5E4aDzf6O5DrsIKEdvxBETD8Ip0g=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-vJaI9gngMXe8GSuWe9DY-Q-1; Tue, 23 Jun 2020 21:07:15 -0400
X-MC-Unique: vJaI9gngMXe8GSuWe9DY-Q-1
Received: by mail-pj1-f70.google.com with SMTP id q12so316612pjp.4
        for <fstests@vger.kernel.org>; Tue, 23 Jun 2020 18:07:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VNqQarYqkyB92A5Ii1Kht36J68Yao1MgQGq01LdrZ9E=;
        b=bIMZfxa7QmjIXF8CvKzT1O2amPkoSmRF65EtqCTGgN5ipF06YefFeKIv7e1+33s9u5
         AEYGbPElpr1gYytIA23hC9+MTR/zvHA+iCEyKTJu+iyXaTYdyiMTwiMuiWa/WRuvRpW0
         nZ5CVqEP+O1wb52KKAyfFVQ62P4w8/9XLSz4k8z+kTlQ0I4DvO66ae8irHpdaj5wV0No
         lBTmyUcUZRmpZijMaI9INyhYWDos8Z9AX2bbo87aNRNd9Yvi0f8B1d66P/am7s2onP4Q
         1M4BMm5xKIwXwAsT+eanEhl51w/NXQL14V0mcgPoZJMzDr5I+81vngxO0z1unj8cBFxE
         XxvQ==
X-Gm-Message-State: AOAM531y60rqtYyyqgiKIaj6qy4kGPsPA186lONYDe5p0mZYwx7xxm9Y
        ujW2DrP1Gm82SO5lhfOuqP6HtQFBgV0W76bNtlQp6aLnSnJsrlNySkyb7XccbgrevBjfg7z2a3p
        1ESpXoWCO7VS4TXliPw==
X-Received: by 2002:a63:e50a:: with SMTP id r10mr19220212pgh.285.1592960834429;
        Tue, 23 Jun 2020 18:07:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrBLFQ+a/4PgVGbDagEkQ4NcEuFIGsw5E9PRP6mGLp9U6PRDuwGSgE+50qVzegBeivK8binQ==
X-Received: by 2002:a63:e50a:: with SMTP id r10mr19220190pgh.285.1592960834131;
        Tue, 23 Jun 2020 18:07:14 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id s13sm18784020pfc.136.2020.06.23.18.07.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 18:07:13 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v3] xfs: add test for CVE-2020-12655
Date:   Wed, 24 Jun 2020 09:06:30 +0800
Message-Id: <20200624010630.4728-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200623020447.5924-1-hsiangkao@redhat.com>
References: <20200623020447.5924-1-hsiangkao@redhat.com>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add a regression test to see if kernel hangs in order to
look after CVE-2020-12655 and check if the corresponding
fix is applied as well.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
changes since v2:
 - print mounted, hasmsg out if fails (Darrick);

 - remove dangerous group since the fix has been
   in kernel for a while (Darrick)

 tests/xfs/520     | 86 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/520.out |  2 ++
 tests/xfs/group   |  1 +
 3 files changed, 89 insertions(+)
 create mode 100755 tests/xfs/520
 create mode 100644 tests/xfs/520.out

diff --git a/tests/xfs/520 b/tests/xfs/520
new file mode 100755
index 00000000..bdc05f7a
--- /dev/null
+++ b/tests/xfs/520
@@ -0,0 +1,86 @@
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
+	[ $mounted -eq 0 -o $hasmsg -eq 1 ] || \
+		_fail "potential broken kernel (mounted=${mounted},hasmsg=${hasmsg})"
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
index daf54add..d6e8d1c3 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -517,3 +517,4 @@
 517 auto quick fsmap freeze
 518 auto quick quota
 519 auto quick reflink
+520 auto quick reflink
-- 
2.18.1

