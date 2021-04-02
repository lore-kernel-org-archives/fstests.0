Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB7CC43461
	for <linux-fstests@archiver.kernel.org>; Fri,  2 Apr 2021 09:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDACE60FE6
	for <linux-fstests@archiver.kernel.org>; Fri,  2 Apr 2021 09:50:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234207AbhDBJut (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 2 Apr 2021 05:50:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234482AbhDBJut (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 2 Apr 2021 05:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617357048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eZmCo68pLsRQMxydSQmBF2SVLlLDb6V2Qpmq+6Mw1Gk=;
        b=G8ldqEOi0fl08zjubunaMreTzgWbHPK1KiP606e+qaaSuEBftXeQ/UVD/LfRMOHNUpEbUW
        GBNXRMJfwFujPx4EalKT4zvKA/Io8yl2w6WU4criFMlYW4vANoWmt5Lusybi1b5HI6WZxG
        5ht/X7Asq90WGEPSYObaMoItn8dryIE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-uEFUS1atPzulnwHz1prw_w-1; Fri, 02 Apr 2021 05:50:44 -0400
X-MC-Unique: uEFUS1atPzulnwHz1prw_w-1
Received: by mail-pf1-f199.google.com with SMTP id g205so5032772pfb.15
        for <fstests@vger.kernel.org>; Fri, 02 Apr 2021 02:50:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eZmCo68pLsRQMxydSQmBF2SVLlLDb6V2Qpmq+6Mw1Gk=;
        b=ICWIuWQQv1A/sJ0dUpAE5w0SfEX7lg5I8psuMupNnXJ1HCmx8v0MXOPKuPM/hKUIZJ
         LnuqXc1fri8qQpoBGLO3itkybp5NaudlmjYaoeFzIJV/XppVJKBKIhVqjphPKgWbeuIh
         cU+oE04JPjkbkmQhxpYpiYlXeTQwIZP0b+RNvPjpu3o/xE0nN/HFtXMXDDs5Gq1Y4pXU
         YVsIrOVY7xkRzqdBH5IPVZs8gIN1UAnQ/7zA8BrjQOccgczcwmV2QcNYiu1Zdlfup7Hh
         Kkvzd3dNVAZB8kNh8CC+sYNxW/7aEJx4KW9MgJA/93t0XsS5lXSDrHUQCSlOker3/Hw0
         RMFg==
X-Gm-Message-State: AOAM533RX0tL2YxsJb8gRxjBUPIoFT9D0jpEkrRB62h9bPqbbkmrRWK2
        E4O0ajtQqdV+h1reXKjc5fsWWJ8tzQztYggs9D3qloMRM7tR4gzhX/C+c7V5XLhy9UubSk3Wg6D
        kPsvMbguJL82uaBTbgg==
X-Received: by 2002:a05:6a00:1350:b029:227:7a8b:99c9 with SMTP id k16-20020a056a001350b02902277a8b99c9mr11496131pfu.73.1617357043484;
        Fri, 02 Apr 2021 02:50:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6gLwpYivSKA/oUqSJXpW10nEvuW6C9UeJ14UDcYopNJBAc/UckrVppG/ZjjAnvGaFwxn3yg==
X-Received: by 2002:a05:6a00:1350:b029:227:7a8b:99c9 with SMTP id k16-20020a056a001350b02902277a8b99c9mr11496113pfu.73.1617357043225;
        Fri, 02 Apr 2021 02:50:43 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id l124sm7730354pfl.195.2021.04.02.02.50.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 02:50:42 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, Eryu Guan <guan@eryu.me>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v4 2/3] xfs: basic functionality test for shrinking free space in the last AG
Date:   Fri,  2 Apr 2021 17:49:36 +0800
Message-Id: <20210402094937.4072606-3-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210402094937.4072606-1-hsiangkao@redhat.com>
References: <20210402094937.4072606-1-hsiangkao@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add basic test to make sure the functionality works as expected.

Signed-off-by: Gao Xiang <hsiangkao@redhat.com>
---
 tests/xfs/990     | 73 +++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/990.out | 12 ++++++++
 tests/xfs/group   |  1 +
 3 files changed, 86 insertions(+)
 create mode 100755 tests/xfs/990
 create mode 100644 tests/xfs/990.out

diff --git a/tests/xfs/990 b/tests/xfs/990
new file mode 100755
index 00000000..322b09e1
--- /dev/null
+++ b/tests/xfs/990
@@ -0,0 +1,73 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2021 Red Hat, Inc.  All Rights Reserved.
+#
+# FS QA Test 990
+#
+# XFS shrinkfs basic functionality test
+#
+# This test attempts to shrink with a small size (512K), half AG size and
+# an out-of-bound size (agsize + 1) to observe if it works as expected.
+#
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1    # failure is the default!
+trap "rm -f $tmp.*; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+
+test_shrink()
+{
+	$XFS_GROWFS_PROG -D"$1" $SCRATCH_MNT >> $seqres.full 2>&1
+	ret=$?
+
+	_scratch_unmount
+	_check_scratch_fs
+	_scratch_mount
+
+	$XFS_INFO_PROG $SCRATCH_MNT 2>&1 | _filter_mkfs 2>$tmp.growfs >/dev/null
+	. $tmp.growfs
+	[ $ret -eq 0 -a $1 -eq $dblocks ]
+}
+
+# real QA test starts here
+_supported_fs xfs
+_require_xfs_scratch_shrink
+
+rm -f $seqres.full
+echo "Format and mount"
+
+# agcount = 1 is forbidden on purpose, and need to ensure shrinking to
+# 2 AGs isn't fensible yet. So agcount = 3 is the minimum number now.
+_scratch_mkfs -dsize="$((512 * 1024 * 1024))" -dagcount=3 2>&1 | \
+	tee -a $seqres.full | _filter_mkfs 2>$tmp.mkfs
+. $tmp.mkfs
+t_dblocks=$dblocks
+_scratch_mount >> $seqres.full
+
+echo "Shrink fs (small size)"
+test_shrink $((t_dblocks-512*1024/dbsize)) || \
+	_fail "Shrink fs (small size) failure"
+
+echo "Shrink fs (half AG)"
+test_shrink $((t_dblocks-agsize/2)) || \
+	_fail "Shrink fs (half AG) failure"
+
+echo "Shrink fs (out-of-bound)"
+test_shrink $((t_dblocks-agsize-1)) && \
+	_fail "Shrink fs (out-of-bound) failure"
+[ $dblocks -ne $((t_dblocks-agsize/2)) ] && \
+	_fail "dblocks changed after shrinking failure"
+
+$XFS_INFO_PROG $SCRATCH_MNT >> $seqres.full
+echo "*** done"
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/990.out b/tests/xfs/990.out
new file mode 100644
index 00000000..812f89ef
--- /dev/null
+++ b/tests/xfs/990.out
@@ -0,0 +1,12 @@
+QA output created by 990
+Format and mount
+meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks
+data     = bsize=XXX blocks=XXX, imaxpct=PCT
+         = sunit=XXX swidth=XXX, unwritten=X
+naming   =VERN bsize=XXX
+log      =LDEV bsize=XXX blocks=XXX
+realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX
+Shrink fs (small size)
+Shrink fs (half AG)
+Shrink fs (out-of-bound)
+*** done
diff --git a/tests/xfs/group b/tests/xfs/group
index fe83f82d..472c8f9a 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -520,3 +520,4 @@
 537 auto quick
 538 auto stress
 539 auto quick mount
+990 auto quick growfs shrinkfs
-- 
2.27.0

