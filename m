Return-Path: <SRS0=C4aD=EO=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17E1CC388F9
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Nov 2020 12:26:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17FF206D4
	for <linux-fstests@archiver.kernel.org>; Sun,  8 Nov 2020 12:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JHk6XEb7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727570AbgKHM0m (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 8 Nov 2020 07:26:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726210AbgKHM0m (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 8 Nov 2020 07:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604838400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wvDrZQKGeopbJ3KhJ30MevGVCbWzPenbW3Q+wlPrFjk=;
        b=JHk6XEb7vfEBVx8CG/LgNuTEwf5Ba2u5gA1wjPJ3Zz7nh54niveKLs3cREZbZg6u3qTZgA
        3X3/YQwHFxM7TGmuJy6n5NjPl+d43gaW7kFk/wvfBNQYqIgIjefLcySYnhE7fmTVs4SoyN
        GMENOnlD3PlyUTrhVGwjH6FaC2/5WOo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-VNUp1v_4MEeb3d4UG-Zg_A-1; Sun, 08 Nov 2020 07:26:39 -0500
X-MC-Unique: VNUp1v_4MEeb3d4UG-Zg_A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 473AB1005E65
        for <fstests@vger.kernel.org>; Sun,  8 Nov 2020 12:26:38 +0000 (UTC)
Received: from bogon.redhat.com (ovpn-12-53.pek2.redhat.com [10.72.12.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E4A95B4CB
        for <fstests@vger.kernel.org>; Sun,  8 Nov 2020 12:26:37 +0000 (UTC)
From:   Zorro Lang <zlang@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH 2/3] generic: fsx IO_URING soak tests
Date:   Sun,  8 Nov 2020 20:26:22 +0800
Message-Id: <20201108122623.12980-3-zlang@redhat.com>
In-Reply-To: <20201108122623.12980-1-zlang@redhat.com>
References: <20201108122623.12980-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

After fsx supports IO_URING read/write, add a test to do IO_URING
soak test of fsx.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 common/rc             | 16 ++++++++++++
 tests/generic/613     | 59 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/613.out |  2 ++
 tests/generic/group   |  1 +
 4 files changed, 78 insertions(+)
 create mode 100755 tests/generic/613
 create mode 100644 tests/generic/613.out

diff --git a/common/rc b/common/rc
index aa5a7409..b6b39eba 100644
--- a/common/rc
+++ b/common/rc
@@ -1984,6 +1984,22 @@ _require_aiodio()
     _require_odirect
 }
 
+# this test requires that the kernel supports IO_URING
+_require_io_uring()
+{
+	$here/src/feature -R
+	case $? in
+	0)
+		;;
+	1)
+		_notrun "kernel does not support IO_URING"
+		;;
+	*)
+		_fail "unexpected error testing for IO_URING support"
+		;;
+	esac
+}
+
 # this test requires that a test program exists under src/
 # $1 - command (require)
 #
diff --git a/tests/generic/613 b/tests/generic/613
new file mode 100755
index 00000000..dc64e67a
--- /dev/null
+++ b/tests/generic/613
@@ -0,0 +1,59 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Red Hat Inc.  All Rights Reserved.
+#
+# FS QA Test No. 613
+#
+# IO_URING soak buffered fsx test, copy from generic/522 but reduce the number
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
+_require_io_uring
+
+# Run fsx for 100 thousand ops or more
+nr_ops=$((100000 * TIME_FACTOR))
+op_sz=$((128000 * LOAD_FACTOR))
+file_sz=$((600000 * LOAD_FACTOR))
+fsx_file=$TEST_DIR/fsx.$seq
+
+fsx_args=(-S 0)
+fsx_args+=(-U)
+fsx_args+=(-q)
+fsx_args+=(-N $nr_ops)
+fsx_args+=(-p $((nr_ops / 100)))
+fsx_args+=(-o $op_sz)
+fsx_args+=(-l $file_sz)
+
+run_fsx "${fsx_args[@]}" | sed -e '/^fsx.*/d'
+
+# success, all done
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/613.out b/tests/generic/613.out
new file mode 100644
index 00000000..64524cf1
--- /dev/null
+++ b/tests/generic/613.out
@@ -0,0 +1,2 @@
+QA output created by 613
+Silence is golden
diff --git a/tests/generic/group b/tests/generic/group
index aa969bcb..348cc2bd 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -611,3 +611,4 @@
 606 auto attr quick dax
 607 auto attr quick dax
 608 auto attr quick dax
+613 auto rw io_uring
-- 
2.25.4

