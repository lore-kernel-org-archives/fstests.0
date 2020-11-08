Return-Path: <SRS0=C4aD=EO=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616AEC5517A
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Nov 2020 12:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28918206ED
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Nov 2020 12:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aitXudJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgKHM0o (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 8 Nov 2020 07:26:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28229 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgKHM0o (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Nov 2020 07:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604838403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ER/NyJGpQwUqZJM97xFSHkujono1u03XWWtdABECXhQ=;
        b=aitXudJsTua5/Ku5ItLkBKboORCNfKAr2WlDUvyMxMF8Dei968M4N/keKhc4ZfIJdtqEAX
        NIl7WyehVmx1jtBjrszfzgJpPtyQuMwJZMeqEBQq3fBvje3rv+QDzZFcmp5JH4Skx5SJuq
        4bPOgehBIP4qpWFC4RfnL7/nsYSlNCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-wFRD_3YZOwOSCDx5H78Ylg-1; Sun, 08 Nov 2020 07:26:41 -0500
X-MC-Unique: wFRD_3YZOwOSCDx5H78Ylg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA4C08014D9
        for <fstests@vger.kernel.org>; Sun,  8 Nov 2020 12:26:40 +0000 (UTC)
Received: from bogon.redhat.com (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AE1F75B4B5
        for <fstests@vger.kernel.org>; Sun,  8 Nov 2020 12:26:39 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 3/3] generic: fsx IO_URING direct-IO soak tests
Date:   Sun,  8 Nov 2020 20:26:23 +0800
Message-Id: <20201108122623.12980-4-zlang@redhat.com>
In-Reply-To: <20201108122623.12980-1-zlang@redhat.com>
References: <20201108122623.12980-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

After fsx supports IO_URING read/write, add a test to do IO_URING
direct-IO test by fsx

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/generic/614     | 65 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/614.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 68 insertions(+)
 create mode 100755 tests/generic/614
 create mode 100644 tests/generic/614.out

diff --git a/tests/generic/614 b/tests/generic/614
new file mode 100755
index 00000000..3f07f204
--- /dev/null
+++ b/tests/generic/614
@@ -0,0 +1,65 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Red Hat Inc.  All Rights Reserved.
+#
+# FS QA Test No. 614
+#
+# IO_URING soak direct-IO fsx test, copy from generic/521 but reduce the number
+# fsx ops to limit the testing time to be an auto group test.
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
+_supported_fs generic
+_supported_os Linux
+_require_test
+_require_odirect
+_require_io_uring
+
+# Run fsx for 20 thousand ops or more
+nr_ops=$((20000 * TIME_FACTOR))
+op_sz=$((128000 * LOAD_FACTOR))
+file_sz=$((600000 * LOAD_FACTOR))
+fsx_file=$TEST_DIR/fsx.$seq
+min_dio_sz=$(_min_dio_alignment)
+
+fsx_args=(-S 0)
+fsx_args+=(-U)
+fsx_args+=(-q)
+fsx_args+=(-N $nr_ops)
+fsx_args+=(-p $((nr_ops / 100)))
+fsx_args+=(-o $op_sz)
+fsx_args+=(-l $file_sz)
+fsx_args+=(-r $min_dio_sz)
+fsx_args+=(-t $min_dio_sz)
+fsx_args+=(-w $min_dio_sz)
+fsx_args+=(-Z)
+
+run_fsx "${fsx_args[@]}" | sed -e '/^fsx.*/d'
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/614.out b/tests/generic/614.out
new file mode 100644
index 00000000..3db70236
--- /dev/null
+++ b/tests/generic/614.out
@@ -0,0 +1,2 @@
+QA output created by 614
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index 348cc2bd..79d386ca 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -612,3 +612,4 @@
 607 auto attr quick dax
 608 auto attr quick dax
 613 auto rw io_uring
+614 auto rw io_uring
-- 
2.25.4

