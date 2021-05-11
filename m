Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4565C433ED
	for <linux-fstests@archiver.kernel.org>; Tue, 11 May 2021 07:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D44260FDB
	for <linux-fstests@archiver.kernel.org>; Tue, 11 May 2021 07:40:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbhEKHlc (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 11 May 2021 03:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27223 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230386AbhEKHla (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 May 2021 03:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620718824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BZgYovHYVMprOpKlke7fnJ9US28+nvTueCAME8/fMeA=;
        b=N6zVsv7/ZOc03PNjPPIgikvYRYtXWVjNqNhKFW7/qQKRoRTqcFWoh/JZqer20J57iXgHEB
        ySm7Wr8UvUTtSNQ+XKlGOotQEiE5Jxe0VUaOJXfk8owsh2HdtsdE8XJcu/IfEK4v8iYcl3
        DSNoXfFSgzOyX/mPV2qDPZb1DJMnPhA=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-L1VR0ofJO8G7jV7GkbK_NQ-1; Tue, 11 May 2021 03:40:22 -0400
X-MC-Unique: L1VR0ofJO8G7jV7GkbK_NQ-1
Received: by mail-pf1-f197.google.com with SMTP id g144-20020a6252960000b029023d959faca6so12388184pfb.9
        for <fstests@vger.kernel.org>; Tue, 11 May 2021 00:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BZgYovHYVMprOpKlke7fnJ9US28+nvTueCAME8/fMeA=;
        b=NNX098+1dsbs+HHUFl2qt/e091qqh0D2yKajRmntouYtdTOxUIaOlSceQ0wR71d6Er
         AKn5hvr6llw9xogOrpFrrjnZyLmW8Sru+0rNzM+s53nsG2hG/oOPWCzBAEa6GS5f7Z2F
         tAUaGj8a7zCY7BSM9gQFjq5BSWUCzK2ltKYVfqgoTzjNmLRVVQ9F7Yz/iCP1/UHwpy23
         ZM7L32bLjzRqGy0vYkkA1CZF0+uELSAcU/e7uvKl7SdiLSxuTFsyISz3ZREkE/OKsUJ1
         xMSkzb9khcKvErHabQLIZ2dvhadaFXU4jCjhT66oruTxk1C4D4HHws68j6DTHr6S6lf4
         UNIw==
X-Gm-Message-State: AOAM533C28rs0ip1Ny7OzT0hXBMRB3+/5kJ4wvQWfa3TLIIs1OIkZg03
        fjLXIzQZilxv3FclodfrLjO3AIXbn0qR2bbgbqlFkKF3XY3MTCSXvsTIojftHTHOhyP+xH87p3Y
        Dmu1ZkyWF0rdmYfEOMw==
X-Received: by 2002:a05:6a00:c81:b029:2cb:6db9:dfa9 with SMTP id a1-20020a056a000c81b02902cb6db9dfa9mr305510pfv.8.1620718821211;
        Tue, 11 May 2021 00:40:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy77FF/Yv49Ara22BlO+Kk34GK8NOpLqC9GdbI9/yOgv96OKLxMF5ElsMKBGAbjAX6lZ+bVhQ==
X-Received: by 2002:a05:6a00:c81:b029:2cb:6db9:dfa9 with SMTP id a1-20020a056a000c81b02902cb6db9dfa9mr305491pfv.8.1620718820949;
        Tue, 11 May 2021 00:40:20 -0700 (PDT)
Received: from xiangao.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y3sm10820865pfl.153.2021.05.11.00.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 00:40:20 -0700 (PDT)
From:   Gao Xiang <hsiangkao@redhat.com>
To:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Zorro Lang <zlang@redhat.com>, Eryu Guan <guan@eryu.me>,
        Gao Xiang <hsiangkao@redhat.com>
Subject: [PATCH v5 2/3] xfs: basic functionality test for shrinking free space in the last AG
Date:   Tue, 11 May 2021 15:39:44 +0800
Message-Id: <20210511073945.906127-3-hsiangkao@redhat.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210511073945.906127-1-hsiangkao@redhat.com>
References: <20210511073945.906127-1-hsiangkao@redhat.com>
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
index 00000000..ec2592f6
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
+# 2 AGs isn't feasible yet. So agcount = 3 is the minimum number now.
+_scratch_mkfs -dsize="$((512 * 1024 * 1024))" -dagcount=3 2>&1 | \
+	tee -a $seqres.full | _filter_mkfs 2>$tmp.mkfs
+. $tmp.mkfs
+t_dblocks=$dblocks
+_scratch_mount >> $seqres.full
+
+echo "Shrink fs (small size)"
+test_shrink $((t_dblocks-512*1024/dbsize)) || \
+	echo "Shrink fs (small size) failure"
+
+echo "Shrink fs (half AG)"
+test_shrink $((t_dblocks-agsize/2)) || \
+	echo "Shrink fs (half AG) failure"
+
+echo "Shrink fs (out-of-bound)"
+test_shrink $((t_dblocks-agsize-1)) && \
+	echo "Shrink fs (out-of-bound) failure"
+[ $dblocks -ne $((t_dblocks-agsize/2)) ] && \
+	echo "dblocks changed after shrinking failure"
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

