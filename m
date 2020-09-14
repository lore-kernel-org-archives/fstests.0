Return-Path: <SRS0=R9JC=CX=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C79C43461
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Sep 2020 15:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61CF42076C
	for <linux-fstests@archiver.kernel.org>; Mon, 14 Sep 2020 15:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SO8GfuQo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgINPc2 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 14 Sep 2020 11:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726411AbgINPcV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 14 Sep 2020 11:32:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600097539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lNI9l2O5DEC+WGqBqsR+k9wfYeCOh33pqrCF2O/fGtk=;
        b=SO8GfuQoCN/AD5V0Q1SmoLp/wQWRbGuuBROLtHJ2mnqST3bkhokeAXxZQOgCWpDr03Nleo
        h4p0RPDaelmuZGilOJxDiwqtf1yEu1UsXQwlbDsI3UbvMWdLjrvXtcKzro+eE7xl4op2Zc
        ZJzvwKQCCjCF//FYqHzuKtJU+svDjgg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-zFGIZx5pNKqycGpAOHed5w-1; Mon, 14 Sep 2020 11:32:17 -0400
X-MC-Unique: zFGIZx5pNKqycGpAOHed5w-1
Received: by mail-wr1-f71.google.com with SMTP id l9so5742wrq.20
        for <fstests@vger.kernel.org>; Mon, 14 Sep 2020 08:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lNI9l2O5DEC+WGqBqsR+k9wfYeCOh33pqrCF2O/fGtk=;
        b=bAcQpsUDhrJZgWzi4JMY1af9CqX9WX+KzrES5GR+S7fM27DBbUv/6ABfrxHx7jjZbC
         S98lymW0Pl/sxkwLKBJCUzX9tv1HGA2p/EedcugH6XxM03JeozQdIj7zbPa1lJ+pma+4
         kLCW9CzEfwSM5OUxkIAjdDT0ynYsZqD58epgZ76zaKj7hRm9hAw8moTvOJfAd8wJeYH6
         bt82fp+/oWNasevyKBAs/pH9AVKtzgaIV774Q04hagz23cjbSzX7HiULC+9y+76t4NB1
         CLVBiWI1TIZpuhtHRmZO+biUhTC7hdcBITS9r9yMg7G5rOOHfK6tnQJP5vuHsMHQdT+I
         Dn/w==
X-Gm-Message-State: AOAM530l8XlQFUAU1hc5Cn3AE4eFFWZE6FqqGuijepdZnIIo0zZXXsAX
        Vv3FwQ4NMbrWPmo4Rc30CH+7Z+ZazOWsZIyrjjAtS7fbjXXMIHaQGi7BMsCNMFFo+jHVnAbUWAa
        6EfU1BfM4TRlk/zIxDg==
X-Received: by 2002:adf:e9c1:: with SMTP id l1mr16675052wrn.68.1600097536156;
        Mon, 14 Sep 2020 08:32:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxoYYlJUqaHjDxOqkbN1Ilqxy3kyoSg4Xcdqt4XbC7g5cNdJLLPlgcR5NY1erYQZvrYOv3IOw==
X-Received: by 2002:adf:e9c1:: with SMTP id l1mr16675035wrn.68.1600097535965;
        Mon, 14 Sep 2020 08:32:15 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id c14sm14000582wrm.64.2020.09.14.08.32.15
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 08:32:15 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v4 1/1] generic: add test for boundary in xfs_attr_shortform_verify
Date:   Mon, 14 Sep 2020 17:32:13 +0200
Message-Id: <20200914153213.76894-2-preichl@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914153213.76894-1-preichl@redhat.com>
References: <20200914153213.76894-1-preichl@redhat.com>
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
 tests/generic/611     | 61 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/611.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 64 insertions(+)
 create mode 100755 tests/generic/611
 create mode 100644 tests/generic/611.out

diff --git a/tests/generic/611 b/tests/generic/611
new file mode 100755
index 00000000..283327e4
--- /dev/null
+++ b/tests/generic/611
@@ -0,0 +1,61 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Red Hat, Inc. All Rights Reserved.
+#
+# FS QA Test 611
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
+_scratch_cycle_mount
+
+# If the target bug isn't fixed, getfattr fails
+${GETFATTR_PROG} --absolute-names -n user.a $localfile | grep 'user.a'
+
+# Make sure the filesystem isn't corrupted manually
+_scratch_unmount
+
+status=0
+exit
diff --git a/tests/generic/611.out b/tests/generic/611.out
new file mode 100644
index 00000000..1ab12434
--- /dev/null
+++ b/tests/generic/611.out
@@ -0,0 +1,2 @@
+QA output created by 611
+user.a=""
diff --git a/tests/generic/group b/tests/generic/group
index 8eba6c98..4af4b494 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -613,3 +613,4 @@
 608 auto attr quick dax
 609 auto quick rw
 610 auto quick prealloc zero
+611 auto quick attr
-- 
2.26.2

