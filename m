Return-Path: <SRS0=6hky=CY=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF2DC43461
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Sep 2020 13:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC38206DB
	for <linux-fstests@archiver.kernel.org>; Tue, 15 Sep 2020 13:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QuTWWbh4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgIONbx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 15 Sep 2020 09:31:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44052 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726641AbgION1T (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 15 Sep 2020 09:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600176419;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5blV0B++OJVQH94CSqAygrwnPUNnoKD+sLks38+YnG0=;
        b=QuTWWbh4Eg4wFdNDvu71ZcA+ms/e5C65lzKDg89l953b1DWemOwVOG4Znh2oSwKkEZz9r+
        syb0p0suw/ok3JLYr6JDc0fqPMZQqDbhTYbmXhctNgTtzuTsdWaR7CMrldkvBvp73z6pct
        LIgd8ZXGU+c9oQ1lmvakFwRNpivD6dY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-hO6GPSiBN_y0jOfLCDGMqA-1; Tue, 15 Sep 2020 09:26:57 -0400
X-MC-Unique: hO6GPSiBN_y0jOfLCDGMqA-1
Received: by mail-wr1-f71.google.com with SMTP id x15so1220302wrm.7
        for <fstests@vger.kernel.org>; Tue, 15 Sep 2020 06:26:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5blV0B++OJVQH94CSqAygrwnPUNnoKD+sLks38+YnG0=;
        b=s+ZNqRnX7ZHfhdkQdNFnF7PhVkz/cMuz8Tr89CLd6UbPep65unlxfMs/Z7N3ogiqur
         PQ5JIqKZE8c5RRA2TPoA5/XVGJqouqb5zjcn0Qx7sHnRc8ITOG9Taomtmge71EHRtQAl
         RyA9DTd1qhEbw9yrtRTrJnvBQbsHLPiSEP/5lboz6sE70kfsG/aRQnTfvPzw0+e7No0s
         2rIeBQQ+8R680ApVE8BRrkZqHhX1ldzs5rjqNygcgUfDCrkwa36uxNCEeld+cn/qKNd/
         cirR8RGwAbGP6KW4NROEJh3M7b/GBxlABYSvJJbiV1e9ObSy1vsPkJRyBw6ij9e2g9cU
         nOWg==
X-Gm-Message-State: AOAM5332V82doNh66dCt/1568h2A4uRi4he7X9STy2KC7183xbfdAXFW
        z32z6NM3hz6yywRAmCYsbrPI+IgnyUX+KIARrbERenx68mL6dbohxWzHvu9ZxHmnOtuoPcdIx0i
        vqUHBYlf2DSiU5UgPBA==
X-Received: by 2002:a1c:6341:: with SMTP id x62mr4810683wmb.70.1600176416017;
        Tue, 15 Sep 2020 06:26:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzH5k67VU0VJAZDEHXi8OF71kk59WDbA8zs3bDCJ2P7oZSiTXKsOgZB/KrENH/J3VF57uTChQ==
X-Received: by 2002:a1c:6341:: with SMTP id x62mr4810669wmb.70.1600176415827;
        Tue, 15 Sep 2020 06:26:55 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id q15sm25375832wrr.8.2020.09.15.06.26.54
        for <fstests@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 06:26:54 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Subject: [PATCH v5 1/1] generic: add test for boundary in xfs_attr_shortform_verify
Date:   Tue, 15 Sep 2020 15:26:51 +0200
Message-Id: <20200915132651.238212-2-preichl@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200915132651.238212-1-preichl@redhat.com>
References: <20200915132651.238212-1-preichl@redhat.com>
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
 tests/generic/611     | 58 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/611.out |  2 ++
 tests/generic/group   |  1 +
 3 files changed, 61 insertions(+)
 create mode 100755 tests/generic/611
 create mode 100644 tests/generic/611.out

diff --git a/tests/generic/611 b/tests/generic/611
new file mode 100755
index 00000000..069db6f9
--- /dev/null
+++ b/tests/generic/611
@@ -0,0 +1,58 @@
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

