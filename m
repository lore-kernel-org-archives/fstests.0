Return-Path: <SRS0=ptrv=YY=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CEBC47E49
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Oct 2019 10:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884E920663
	for <linux-fstests@archiver.kernel.org>; Thu, 31 Oct 2019 10:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="kEONR/HK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfJaKgp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 31 Oct 2019 06:36:45 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:41984 "EHLO
        forwardcorp1o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726892AbfJaKgp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 31 Oct 2019 06:36:45 -0400
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net [IPv6:2a02:6b8:0:1619::119])
        by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 2F09F2E1613;
        Thu, 31 Oct 2019 13:36:42 +0300 (MSK)
Received: from sas1-7fab0cd91cd2.qloud-c.yandex.net (sas1-7fab0cd91cd2.qloud-c.yandex.net [2a02:6b8:c14:3a93:0:640:7fab:cd9])
        by mxbackcorp2j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id NKHMK35vn2-afCKEqT6;
        Thu, 31 Oct 2019 13:36:42 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru; s=default;
        t=1572518202; bh=j3QScrClGWa1bi+F2vcOlLUplMh5tQ7ZXHkq3J2mdNc=;
        h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
        b=kEONR/HK1FMSJONdKIgN8a0v0Z+bCFJJ/znScXwBGDb+RoegocweYf78otqD/wUDc
         5jZoZQwZBoSUtU5KmLVTpSvnNAfXuBCA8cL1m1KX5zkZF/BN/pRwCMs4SCBoKDOKAd
         zrT9ZTwf4A/Jm6z6M60kqGM0vgkJ5gem3W1InFl8=
Authentication-Results: mxbackcorp2j.mail.yandex.net; dkim=pass header.i=@yandex-team.ru
Received: from 95.108.174.193-red.dhcp.yndx.net (95.108.174.193-red.dhcp.yndx.net [95.108.174.193])
        by sas1-7fab0cd91cd2.qloud-c.yandex.net (nwsmtp/Yandex) with ESMTPSA id se9knFQm0Y-afWeDP5a;
        Thu, 31 Oct 2019 13:36:41 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
From:   Dmitry Monakhov <dmonakhov@openvz.org>
To:     fstests@vger.kernel.org
Cc:     jack@suse.cz, Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Subject: [PATCH 2/2] add generic/586 quota stress test
Date:   Thu, 31 Oct 2019 10:36:39 +0000
Message-Id: <20191031103639.3786-2-dmonakhov@openvz.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20191031103639.3786-1-dmonakhov@openvz.org>
References: <20191031103639.3786-1-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>

Regression test for mark_dquot_dirty() vs dqput() race
Stress test quota quota code via fchown(2) loop. In fact fchown
is the best way to produce  a lot of short lived dirty dquot objects.

This test known to t produce non fatal dmesg error on kernel prior to v5.4
Example: "Quota error (device vdb): dqput: Can't write quota structure (error -5). Quota may get out of sync!"

Signed-off-by: Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
---
 tests/generic/586     | 87 +++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/generic/586.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 90 insertions(+)
 create mode 100755 tests/generic/586
 create mode 100755 tests/generic/586.out

diff --git a/tests/generic/586 b/tests/generic/586
new file mode 100755
index 0000000..279eb55
--- /dev/null
+++ b/tests/generic/586
@@ -0,0 +1,87 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 YANDEX LLC.  All Rights Reserved.
+#
+# FS QA Test 586
+#
+# Stress quotasync while other tasks dirty quotas in parallel.
+# Run fchown(2) in a loop is the fastest way to produce dirty quotas
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
+}
+# get standard environment, filters and checks
+. ./common/rc
+. ./common/filter
+. ./common/quota
+
+
+
+
+# real QA test starts here
+_supported_fs generic
+_supported_os Linux
+_require_quota
+_require_scratch
+_require_check_dmesg
+
+nr_proc=$((32 * LOAD_FACTOR))
+runtime=$((60 * TIME_FACTOR))
+
+rm -f $seqres.full
+_scratch_mkfs_sized $((512 * 1024 * 1024)) >> $seqres.full 2>&1
+_scratch_mount "-o quota,user"
+chmod 777 $SCRATCH_MNT
+quotacheck -u $SCRATCH_MNT 2>/dev/null
+quotaon -v -u $SCRATCH_MNT >> $seqres.full 2>&1
+
+# Preparation step: Create all files with uid in range
+# to cache quota in kernel memory
+#mkdir -p $SCRATCH_MNT/q
+#$here/src/chowner $SCRATCH_MNT/q -b 2000 -e 2010 -P
+
+for ((i=0; i < nr_proc; i++))
+do
+    # Spread files to isolated dirs to minimize locking contention
+    mkdir -p $SCRATCH_MNT/chowner/$i
+    # Performs fchown in small uid range [2019,2042] in order stress
+    # quota code
+    $here/src/chowner $SCRATCH_MNT/chowner/$i/test -b 2019 -e 2042 \
+		      -t $((runtime)) &
+    pids="$pids $!"
+done
+
+start=$(date +%s)
+deadline=$((start + runtime))
+i=0
+while true
+do
+    quotasync -u $SCRATCH_MNT
+    now=$(date +%s)
+    [ $now -le $deadline ] || break
+    i=$((i+1))
+done
+echo "Done after $i loops" >> $seqres.full
+
+kill -TERM $pids 2> /dev/null
+wait $pids
+
+# Check for error message that happed due to quota inconsistency
+# Example messages:
+#  "Quota error (device vdb): dqput: Can't write quota structure (error -5). Quota may get out of sync!"
+_dmesg_since_test_start | egrep -e 'Quota error '
+echo "Silence is golden"
+# success, all done
+status=0
+exit
diff --git a/tests/generic/586.out b/tests/generic/586.out
new file mode 100755
index 0000000..3d36442
--- /dev/null
+++ b/tests/generic/586.out
@@ -0,0 +1,2 @@
+QA output created by 586
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 703a1b4..76d7d4f 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -588,3 +588,4 @@
 583 auto quick encrypt
 584 auto quick encrypt
 585 auto quota rw stress
+586 auto quota rw stress
-- 
2.7.4

