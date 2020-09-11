Return-Path: <SRS0=EKaY=CU=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30502C433E2
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 17:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE6AE221E7
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Sep 2020 17:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jUuamIbb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbgIKRUF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Sep 2020 13:20:05 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:26104 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726212AbgIKO4c (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Sep 2020 10:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599835951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ftw0wkNkyZ+gCmw/7Uwf79pQ+LMv0B1cjpPLRsWA8tw=;
        b=jUuamIbbdeqjWEc066KJoAtmTcs1EiVDtX/KfJbKVx0h1z4fUacGtu9SX0IekuaY+NFmWX
        Do5MmNCNnsFYzh6De3hj6mhK1tjaQZEi5iVMDbGszbiV3IByNxpSKIB/Q9++Rfc+yRDLQn
        QM8D739236xSJgcYAb6fg9o/V/cD8jo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-jEEIcp_ZMUWa7lo0dK_8Vg-1; Fri, 11 Sep 2020 09:39:03 -0400
X-MC-Unique: jEEIcp_ZMUWa7lo0dK_8Vg-1
Received: by mail-wr1-f69.google.com with SMTP id 33so3537017wre.0
        for <fstests@vger.kernel.org>; Fri, 11 Sep 2020 06:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ftw0wkNkyZ+gCmw/7Uwf79pQ+LMv0B1cjpPLRsWA8tw=;
        b=eYq8D8N5hT2yPgVZrRJabswT7whfzgjS5Rhzwe1yduLjeVIcK/NtSgnNdgVf5uEWRL
         g3xi7nt/EFNkW7Fb2RYGsp3iYfOMqRA7ppuM8eEmKeLGp5MJ2zG5lKL7TV4x14NygmHa
         YEBmIS6SN7rPp/3JPM68e4WJIo0fgZYyWBC/uF4XPrL9v00hXHMOojD3QOpEcn6MXxCa
         DruBwaDb8dRVXrEOc+y9+BoNd+TlHp8AmPkJE2V6h+evxYEBeDOAv3TyzkNvzAtRWfNa
         nPLl3TQ+laYPrCAcdqBGR2YjcQd4PGbIA7hQpRrTi6aZ/5baWq6+IancyIXldcgKys9L
         wKqA==
X-Gm-Message-State: AOAM533nvz20Xb7K9UGOAwRoHw1ao2tx4rxVMH34ft0tBIRuzXlZPjTy
        90jLXXL8tLzTPDvCfV05sq3Rcab4sqm13bXAH/TogF5/gLe5ovUWOUbNo2TzP8Brf11QsPKnvdD
        jEqKX+cF74nkN7w16Hw==
X-Received: by 2002:adf:ec47:: with SMTP id w7mr2307724wrn.175.1599831538700;
        Fri, 11 Sep 2020 06:38:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx5qkHOLirx78ruGAiG7s3aOFHgwNcMvSKvU6y58+DgCtiC82gKbLX9ynLg7gmlmsg6LblU8A==
X-Received: by 2002:adf:ec47:: with SMTP id w7mr2307706wrn.175.1599831538504;
        Fri, 11 Sep 2020 06:38:58 -0700 (PDT)
Received: from localhost.localdomain.com ([84.19.91.81])
        by smtp.gmail.com with ESMTPSA id t22sm5448342wmt.1.2020.09.11.06.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2020 06:38:57 -0700 (PDT)
From:   Pavel Reichl <preichl@redhat.com>
To:     fstests@vger.kernel.org
Cc:     zlang@redhat.com
Subject: [PATCH 1/1] generic: add test for boundary in xfs_attr_shortform_verify
Date:   Fri, 11 Sep 2020 15:38:55 +0200
Message-Id: <20200911133855.38997-2-preichl@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200911133855.38997-1-preichl@redhat.com>
References: <20200911133855.38997-1-preichl@redhat.com>
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
 tests/generic/609     | 64 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/609.out |  8 ++++++
 tests/generic/group   |  1 +
 3 files changed, 73 insertions(+)
 create mode 100755 tests/generic/609
 create mode 100644 tests/generic/609.out

diff --git a/tests/generic/609 b/tests/generic/609
new file mode 100755
index 00000000..fd632e86
--- /dev/null
+++ b/tests/generic/609
@@ -0,0 +1,64 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2020 Red Hat, Inc. All Rights Reserved.
+#
+# FS QA Test 609
+#
+# Verify that metadata won't get corrupted when extended attribute
+# name of size one is set.
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
+echo "+ create scratch fs"
+_scratch_mkfs > /dev/null 2>&1
+
+echo "+ mount fs image"
+_scratch_mount
+
+echo "+ make test file"
+touch "${TESTFILE}"
+
+echo "+ set file attributes"
+"${SETFATTR_PROG}" -n user.a "${TESTFILE}"
+
+echo 3 > /proc/sys/vm/drop_caches
+sleep 3
+
+echo "+ get file attributes"
+"${GETFATTR_PROG}" --absolute-names -n user.a "${TESTFILE}" | grep "user.a"
+
+echo "+ umount fs image"
+umount "${SCRATCH_MNT}"
+
+status=0
+exit
diff --git a/tests/generic/609.out b/tests/generic/609.out
new file mode 100644
index 00000000..aab84553
--- /dev/null
+++ b/tests/generic/609.out
@@ -0,0 +1,8 @@
+QA output created by 609
++ create scratch fs
++ mount fs image
++ make test file
++ set file attributes
++ get file attributes
+user.a=""
++ umount fs image
diff --git a/tests/generic/group b/tests/generic/group
index aa969bcb..66bfb9dd 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -611,3 +611,4 @@
 606 auto attr quick dax
 607 auto attr quick dax
 608 auto attr quick dax
+609 auto attr
-- 
2.26.2

