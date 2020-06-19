Return-Path: <SRS0=Zm54=AA=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E40AC433E1
	for <linux-fstests@archiver.kernel.org>; Fri, 19 Jun 2020 13:44:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ADAA208C7
	for <linux-fstests@archiver.kernel.org>; Fri, 19 Jun 2020 13:44:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8q3smnp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732718AbgFSNo4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 19 Jun 2020 09:44:56 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51613 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732862AbgFSNoy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 19 Jun 2020 09:44:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592574292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=1IYiSz9fLmD5UzRFZPoo/5ICguqKhHZIv4KcXE0imqQ=;
        b=Z8q3smnp88QhYQfuOj5NfNwACTwIXrw2MV3/2zdpAUUd4Fw9wzk9RcGStnXWGFslcD8Hym
        +Q9IxT4Frnb/j9AL5nblY0St2iNNOi5CBHSdhpniBbAFNsbJTE1Y1Sw5dH12BDjHNSY2Qq
        0B0VsjQSCkrXuKLQkJ+UJ3SupLUq0xI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-230-5bxosp1fOFS15if7Jc7G5A-1; Fri, 19 Jun 2020 09:44:50 -0400
X-MC-Unique: 5bxosp1fOFS15if7Jc7G5A-1
Received: by mail-pl1-f199.google.com with SMTP id j12so6309706pll.16
        for <fstests@vger.kernel.org>; Fri, 19 Jun 2020 06:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1IYiSz9fLmD5UzRFZPoo/5ICguqKhHZIv4KcXE0imqQ=;
        b=Xw2871nCQhwEBOOoS4vSyVCrURi5uUc+5pzDuCRej7YHvBFYd30twRGYa4K4KN8qe7
         Gpi8cyV5ShIhiWXp1aYYo478MlWAfGb5Kndd9kRESnQdzqTs2sPMQ9jGisH88TxFzYE7
         WIkMIazd/F3nZQIkxKDFGVvpE9q97Cd5PucZDxW1d7EuTbaA/1d2Eif60BGK36QLykHL
         A1F/4jxyGCiKRyQkjHghwjtWd97KvlxBvju1QZPQzY9pRHWBFNTV+E9NhKIdRusBa8hM
         +XtT43j0FsMv4f1mQHtI14IGaxaQrha1Mau9ufL2Fuqd9HS5byVhVrU45UGC20vMWVTG
         BI2A==
X-Gm-Message-State: AOAM531BPzI/GT7cA2P0ghcy8cw+B01PTG1TvT0l84MnUAKCnuSCQYfb
        b7pzMnS/8v6ifDaxViJrCbmVRAlAEYZzL9wvFDBkAen94TRcq5ciXAn97MYWVUIUpsGIQMjkk6/
        LSDEGnbODxrhKb8YEhw==
X-Received: by 2002:aa7:87d3:: with SMTP id i19mr7974925pfo.203.1592574288876;
        Fri, 19 Jun 2020 06:44:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy7AQUA9lt1XIS3W5/zNLM8Z63tkKWxFACZQ9HWtJ1dC/q5WFg8kJ5KLwCQvBg2T1G/KeaZjw==
X-Received: by 2002:aa7:87d3:: with SMTP id i19mr7974905pfo.203.1592574288539;
        Fri, 19 Jun 2020 06:44:48 -0700 (PDT)
Received: from xiangao.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id a17sm5279445pjh.31.2020.06.19.06.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 06:44:48 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     fstests <fstests@vger.kernel.org>
Cc:     Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH] xfs: add test for CVE-2020-12655
Date:   Fri, 19 Jun 2020 21:44:19 +0800
Message-Id: <20200619134419.30705-1-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add a regression test to see if kernel hangs in order to
look after CVE-2020-12655 and check if the corresponding
fix is applied as well.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 tests/xfs/520     | 98 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/520.out |  2 +
 tests/xfs/group   |  1 +
 3 files changed, 101 insertions(+)
 create mode 100755 tests/xfs/520
 create mode 100644 tests/xfs/520.out

diff --git a/tests/xfs/520 b/tests/xfs/520
new file mode 100755
index 00000000..28354f8d
--- /dev/null
+++ b/tests/xfs/520
@@ -0,0 +1,98 @@
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
+	_scratch_unmount
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
+
+bigval=100000000
+fsdsopt="-d agcount=1,size=64m"
+
+_require_scratch
+_scratch_mkfs_xfs $fsdsopt >> $seqres.full 2>&1 || _fail "mkfs failed"
+
+# test if forcing agf.freeblks = 0 could cause the kernel livelock.
+_scratch_xfs_set_metadata_field freeblks 0 "agf 0" >> $seqres.full 2>&1
+if _try_scratch_mount >> $seqres.full 2>&1; then
+	echo potential broken kernel, try to reproduce the bug anyway
+	dd if=/dev/zero of=$SCRATCH_MNT/test bs=65536 count=1 >> $seqres.full 2>&1
+	sync
+	_scratch_unmount
+fi
+
+_scratch_mkfs_xfs -f $fsdsopt >> $seqres.full 2>&1 || _fail "mkfs failed"
+
+# test if forcing agf.longest = $bigval shouldn't be mounted.
+_scratch_xfs_set_metadata_field longest $bigval "agf 0" >> $seqres.full 2>&1
+_try_scratch_mount >> $seqres.full 2>&1 && \
+	_fail "potential broken kernel, mount should have failed"
+
+_scratch_mkfs_xfs -f $fsdsopt >> $seqres.full 2>&1 || _fail "mkfs failed"
+
+# test if forcing agf.length = $bigval shouldn't be mounted.
+_scratch_xfs_set_metadata_field length $bigval "agf 0" >> $seqres.full 2>&1
+_try_scratch_mount >> $seqres.full 2>&1 && \
+	_fail "potential broken kernel, mount should have failed"
+
+
+if _scratch_mkfs_xfs_supported -m reflink=1 >> $seqres.full 2>&1; then
+	_scratch_mkfs_xfs -f -m reflink=1 $fsdsopt >> $seqres.full 2>&1 || \
+		_fail "mkfs failed"
+
+	# test if forcing agf.refcntblocks = $bigval shouldn't be mounted.
+	_scratch_xfs_set_metadata_field refcntblocks $bigval "agf 0" >> $seqres.full 2>&1
+	_try_scratch_mount >> $seqres.full 2>&1 && \
+		_fail "potential broken kernel, mount should have failed"
+fi
+
+if _scratch_mkfs_xfs_supported -m rmapbt=1 >> $seqres.full 2>&1; then
+	_scratch_mkfs_xfs -f -m rmapbt=1 $fsdsopt >> $seqres.full 2>&1 || \
+		_fail "mkfs failed"
+
+	# test if forcing agf.rmapblocks = $bigval shouldn't be mounted.
+	_scratch_xfs_set_metadata_field rmapblocks $bigval "agf 0" >> $seqres.full 2>&1
+	_try_scratch_mount >> $seqres.full 2>&1 && \
+		_fail "potential broken kernel, mount should have failed"
+fi
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

