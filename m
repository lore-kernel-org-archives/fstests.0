Return-Path: <SRS0=iEcW=CV=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B259C43461
	for <linux-fstests@archiver.kernel.org>; Sat, 12 Sep 2020 10:20:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E6642158C
	for <linux-fstests@archiver.kernel.org>; Sat, 12 Sep 2020 10:20:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGsdKu1s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgILKUI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 12 Sep 2020 06:20:08 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:35064 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725825AbgILKUC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 12 Sep 2020 06:20:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599906001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLix2Vq1RLWeLxKaOpV/5QAD/wYJOPzYmP+jSkiP1Nc=;
        b=GGsdKu1su5RmkALhi2S/4iSeTBDCjRegbkwm6DlAGuLoCUS5FkwHcKEA/woLidaT10Nwix
        vpOqbaIBHPmydGfM828bEAD3wJnxw9NPE64rKixIaXh2rPNhQnbNn/I6xUpM7qvq1Jejk0
        bU0BSNJAc3rMSrUo6NdRumJEH6dWZhk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-BbQaBKxdPgCY_fygvzry1w-1; Sat, 12 Sep 2020 06:19:59 -0400
X-MC-Unique: BbQaBKxdPgCY_fygvzry1w-1
Received: by mail-wr1-f70.google.com with SMTP id v5so4203754wrs.17
        for <fstests@vger.kernel.org>; Sat, 12 Sep 2020 03:19:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wLix2Vq1RLWeLxKaOpV/5QAD/wYJOPzYmP+jSkiP1Nc=;
        b=O3Zx83zoHgvVyl3pLaAszpfhQCd5FK/Vc4rGdkY0VrO+OSLt8wWyJuH8wVnQTYTNdD
         naDY3NgdHOL5QPEPBeA2QBzMzJzZttuCNrQfm3SQPGLQyY0gCp6K3MEp1c6PaFpPjyRc
         o3nhmM6/NVn/ZyBDuK/opCeA6us2+xMfikhRaNPF1Gyxucoekzog3KcQaZ2HpMHjBvw0
         +Rk5ibLfNFhFAudYeIZKi3gAYGLx2ctgU+lymAQheYO9GiwK1x9Lg6Z7Mde2wTF53KwH
         6/tedOFt+ntU7tPaEuYaGvXQiDBW7hXZmTO9CHQdJjlKZ1Pmwx6E22L0fwsbk0kQsWRu
         QmMQ==
X-Gm-Message-State: AOAM532F1gw/T7dVxPahFInwqwc5jBjuCtWfMz692CZvpsE9bxue1/Ka
        dbgYWVzTi9ZH+KJYhmtaFTSN+k0JvmMEq6UADXJd+63jmVdOiPE51O1JLjqxQC5TqLChwhR1Rx1
        iV3dA5AJJsLnjnEJ+Xw==
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr5988969wmj.112.1599905997914;
        Sat, 12 Sep 2020 03:19:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEBNWpl/MHv533PF+0LZ7RehQZzRLvfHpXGlVGI1pHn1SXcS4TKo30MITSMQxb/xwtpR7+Bg==
X-Received: by 2002:a7b:cd93:: with SMTP id y19mr5988957wmj.112.1599905997730;
        Sat, 12 Sep 2020 03:19:57 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id 8sm10089805wrl.7.2020.09.12.03.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2020 03:19:56 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhad.com
Subject: [PATCH v3 1/1] generic: add test for boundary in xfs_attr_shortform_verify
Date:   Sat, 12 Sep 2020 12:19:53 +0200
Message-Id: <20200912101953.114089-2-preichl@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200912101953.114089-1-preichl@redhat.com>
References: <20200912101953.114089-1-preichl@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Add a regression test to check that the boundary test
for the fixed-offset parts of xfs_attr_sf_entry
in xfs_attr_shortform_verify is not off by one.

This can be shown by:

touch file
setfattr -n user.a file

With help from Zorro. Thanks very much.

Signed-off-by: Pavel Reichl <preichl@redhat.com>
---
 tests/generic/609     | 63 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/609.out |  4 +++
 tests/generic/group   |  1 +
 3 files changed, 68 insertions(+)
 create mode 100755 tests/generic/609
 create mode 100644 tests/generic/609.out

diff --git a/tests/generic/609 b/tests/generic/609
new file mode 100755
index 00000000..f048b2ba
--- /dev/null
+++ b/tests/generic/609
@@ -0,0 +1,63 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Red Hat, Inc. All Rights Reserved.
+#
+# FS QA Test 609
+#
+# Verify that metadata won't get corrupted when extended attribute
+# name of size one is set.
+#
+# This test verifies the problem fixed in kernel with commit
+# f4020438fab0 ("xfs: fix boundary test in xfs_attr_shortform_verify")
+
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
+. ./common/attr
+
+# remove previous $seqres.full before test
+rm -f $seqres.full
+
+# real QA test starts here
+
+_supported_fs generic
+_supported_os Linux
+_require_scratch
+_require_attrs
+
+_scratch_mkfs > $seqres.full 2>&1
+_scratch_mount
+
+localfile="${SCRATCH_MNT}/testfile"
+
+touch "${localfile}"
+"${SETFATTR_PROG}" -n user.a "${localfile}"
+
+# Make sure that changes are written to disk
+echo 3 > /proc/sys/vm/drop_caches
+sleep 3
+
+# If the target bug isn't fixed, getfattr fails
+${GETFATTR_PROG} --absolute-names -n user.a $localfile | _filter_scratch
+
+# Make sure the filesystem isn't corrupted manually
+_scratch_unmount
+_check_scratch_fs
+
+status=0
+exit
diff --git a/tests/generic/609.out b/tests/generic/609.out
new file mode 100644
index 00000000..d4ae152d
--- /dev/null
+++ b/tests/generic/609.out
@@ -0,0 +1,4 @@
+QA output created by 609
+# file: SCRATCH_MNT/testfile
+user.a=""
+
diff --git a/tests/generic/group b/tests/generic/group
index aa969bcb..6fa83c13 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -611,3 +611,4 @@
 606 auto attr quick dax
 607 auto attr quick dax
 608 auto attr quick dax
+609 auto attr quick
-- 
2.26.2

