Return-Path: <SRS0=EKaY=CU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52F5C2BC11
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 22:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D4D21D7E
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 22:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ca15WBO8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725846AbgIKWP2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Sep 2020 18:15:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34281 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725849AbgIKWPX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Sep 2020 18:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599862520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LQrRoQWQNXkgVMLAtYqwFuNr6mXNCSfseqYGBNnFfQ8=;
        b=Ca15WBO84Oe+tiK4rEPAwLdP0uu8d/90LwiYfSG3Ki0whGAMByqf4fQveiDQFwcMVuSQGy
        /qXFvP3sDiVQ7NSRsOCQwqZrLAoYTshR1BrbUR57uitVuf3fdiRWg39RR9sMUF83o5WWGc
        nk+txXoaSJRWKV7G4ssy/5x0dlT4/i4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-294-WfSEFV1iMKWFdX-hwBIYUw-1; Fri, 11 Sep 2020 18:15:18 -0400
X-MC-Unique: WfSEFV1iMKWFdX-hwBIYUw-1
Received: by mail-wr1-f70.google.com with SMTP id o6so3915692wrp.1
        for <fstests@vger.kernel.org>; Fri, 11 Sep 2020 15:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LQrRoQWQNXkgVMLAtYqwFuNr6mXNCSfseqYGBNnFfQ8=;
        b=tVwsOkTQoCm7Gz4A5GXtAlbtN+KKHHRd0jizxRx/g4J2zEgs5xJUSab4rDhiNFtvHC
         psQ8g24PBOutevesbVQO6YKUykkxH4vi9Mo8fqAqvNkn/SbCCxA+3exY4DNot+KHnJDI
         YdkkFZFoDSJ5/UB4gxwbxCD82acOvp/D7AqOHxEB3EC6bQiKus09f15nB2ZSAVuflDHo
         bz62ZtWkpOKyxbDs5nkwqqv1q/BvMDrOkFD4/8qNwT0T323CCmhWRQMHWOOFIbWIAUpw
         ukuCLBS2vzyaa7LRcmeDXD5GyNLURvix6c1JH5eIQJaG/PherBCmzure6qhvuFezoF5P
         ZzaA==
X-Gm-Message-State: AOAM531qdP033GtppcFOun1Fqjm/47Z8UpoDzNrIqvtbJm/+pSUmI3Er
        6niLtwaGy6ZWCWQJ5MKiffoYuFLxn5fuFOiacvruChpbesG0uP7E+FkWzLAe25wNunFOfktXvc6
        /h8nhJQZ2VWsrdsQsrQ==
X-Received: by 2002:a5d:4151:: with SMTP id c17mr4352115wrq.302.1599862517180;
        Fri, 11 Sep 2020 15:15:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVvZXLWhetGAKpykkUEnU2rMUkMLUgPjzJH+A8rg6EsVXYThYo7MeAldCXg8cNdV0qb9F5Tg==
X-Received: by 2002:a5d:4151:: with SMTP id c17mr4352106wrq.302.1599862517011;
        Fri, 11 Sep 2020 15:15:17 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id t22sm8133913wmt.1.2020.09.11.15.15.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 15:15:16 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com
Subject: [PATCH v2 1/1] generic: add test for boundary in xfs_attr_shortform_verify
Date:   Sat, 12 Sep 2020 00:15:14 +0200
Message-Id: <20200911221514.69318-2-preichl@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911221514.69318-1-preichl@redhat.com>
References: <20200911221514.69318-1-preichl@redhat.com>
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
 tests/generic/609     | 66 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/609.out |  1 +
 tests/generic/group   |  1 +
 3 files changed, 68 insertions(+)
 create mode 100755 tests/generic/609
 create mode 100644 tests/generic/609.out

diff --git a/tests/generic/609 b/tests/generic/609
new file mode 100755
index 00000000..2feb37a2
--- /dev/null
+++ b/tests/generic/609
@@ -0,0 +1,66 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Red Hat, Inc. All Rights Reserved.
+#
+# FS QA Test 609
+#
+# Verify that metadata won't get corrupted when extended attribute
+# name of size one is set.
+#
+# This test excercises the problem fixed in kernel with commit
+# xfs: fix boundary test in xfs_attr_shortform_verify
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
+TESTFILE="${SCRATCH_MNT}/testfile"
+
+_scratch_mkfs > /dev/null 2>&1
+
+_scratch_mount
+
+touch "${TESTFILE}"
+
+"${SETFATTR_PROG}" -n user.a "${TESTFILE}"
+
+# Make sure that changes are written to disk
+echo 3 > /proc/sys/vm/drop_caches
+sleep 3
+
+if [ ! _check_scratch_fs ]
+then
+	echo error detected in filesystem
+	exit
+fi
+
+_scratch_unmount
+
+status=0
+exit
diff --git a/tests/generic/609.out b/tests/generic/609.out
new file mode 100644
index 00000000..f85988af
--- /dev/null
+++ b/tests/generic/609.out
@@ -0,0 +1 @@
+QA output created by 609
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

