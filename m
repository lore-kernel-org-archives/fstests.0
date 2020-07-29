Return-Path: <SRS0=d97O=BI=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A89C433DF
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 02:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30CAE2078E
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jul 2020 02:52:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HfgI5zAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731084AbgG2CwI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jul 2020 22:52:08 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:57876 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730407AbgG2CwI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jul 2020 22:52:08 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06T2pd13042039;
        Wed, 29 Jul 2020 02:52:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=/NdHughGeV9CflU4lyXDBQ0ba6sEJFPkAKiBoqNSPwM=;
 b=HfgI5zAlA4B6aOncJzhpo7Yjo6tlyac/v+P+w5wChK1CqSb7ytUcadDkVy2PE7uANVDU
 VwZt9SPQvkXF2xS1nWiyYZz8UEtPBZh6bsA/5on55A2WXFJscfNPWeDNmV0BMSJcqA+n
 C5QNFINN7koX+629aBPZnE+g8ESfV2WCc4tZQQJm+zUe/Ja1TUn4YBU58Q7khFfSYU0/
 g9BETokWEmbCF6JhX2kXnD23P33UIagmrjt0uI3ZwKPBLc4U88h9ecqMtV9TY3yYP9eZ
 ppRHd2uwFTRu4KpbIQWoSjxBFE9zy32iM/lzK9DNW6kwfYtfy6lQ2D1bSZaZtJKvjAHA Vg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32hu1jayf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Jul 2020 02:52:06 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06T2nFhO138456;
        Wed, 29 Jul 2020 02:52:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 32hu5v2uqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 29 Jul 2020 02:52:05 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06T2q4HC024528;
        Wed, 29 Jul 2020 02:52:04 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 28 Jul 2020 19:52:04 -0700
Date:   Tue, 28 Jul 2020 19:52:03 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eryu Guan <guaneryu@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: [PATCH] xfs: test that reflink forces the log if mounted with wsync
Message-ID: <20200729025203.GX7600@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007290020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9696 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 lowpriorityscore=0 malwarescore=0 clxscore=1015 mlxscore=0 impostorscore=0
 phishscore=0 adultscore=0 suspectscore=1 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007290020
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

A code inspection revealed that reflink does not force the log to disk
even if the filesystem is mounted with wsync.  Add a regression test for
commit 5833112df7e9a ("xfs: reflink should force the log out if mounted
with wsync").

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tests/xfs/914     |   65 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 tests/xfs/914.out |    7 ++++++
 tests/xfs/group   |    1 +
 3 files changed, 73 insertions(+)
 create mode 100755 tests/xfs/914
 create mode 100644 tests/xfs/914.out

diff --git a/tests/xfs/914 b/tests/xfs/914
new file mode 100755
index 00000000..b835394a
--- /dev/null
+++ b/tests/xfs/914
@@ -0,0 +1,65 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2020, Oracle and/or its affiliates.  All Rights Reserved.
+#
+# FS QA Test No. 914
+#
+# Make sure that reflink forces the log out if we mount with wsync.  We test
+# that it actually forced the log by immediately shutting down the fs without
+# flushing the log and then remounting to check file contents.
+
+seq=`basename $0`
+seqres=$RESULT_DIR/$seq
+echo "QA output created by $seq"
+
+here=`pwd`
+tmp=/tmp/$$
+status=1    # failure is the default!
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
+. ./common/reflink
+
+# real QA test starts here
+_supported_fs xfs
+_supported_os Linux
+_require_scratch_reflink
+_require_cp_reflink
+
+rm -f $seqres.full
+
+# Format filesystem and set up quota limits
+_scratch_mkfs > $seqres.full
+_scratch_mount -o wsync >> $seqres.full
+
+# Set up initial files
+$XFS_IO_PROG -f -c 'pwrite -S 0x58 0 1m -b 1m' $SCRATCH_MNT/a >> $seqres.full
+$XFS_IO_PROG -f -c 'pwrite -S 0x59 0 1m -b 1m' $SCRATCH_MNT/c >> $seqres.full
+_cp_reflink $SCRATCH_MNT/a $SCRATCH_MNT/e
+_cp_reflink $SCRATCH_MNT/c $SCRATCH_MNT/d
+touch $SCRATCH_MNT/b
+sync
+
+# Test that setting the reflink flag on the dest file forces the log
+echo "test reflink flag not set"
+$XFS_IO_PROG -x -c "reflink $SCRATCH_MNT/a" -c 'shutdown' $SCRATCH_MNT/b >> $seqres.full
+_scratch_cycle_mount wsync
+md5sum $SCRATCH_MNT/a $SCRATCH_MNT/b | _filter_scratch
+
+# Test forcing the log even if both files are already reflinked
+echo "test reflink flag already set"
+$XFS_IO_PROG -x -c "reflink $SCRATCH_MNT/a" -c 'shutdown' $SCRATCH_MNT/d >> $seqres.full
+_scratch_cycle_mount wsync
+md5sum $SCRATCH_MNT/a $SCRATCH_MNT/d | _filter_scratch
+
+# success, all done
+status=0
+exit
diff --git a/tests/xfs/914.out b/tests/xfs/914.out
new file mode 100644
index 00000000..6b19fc65
--- /dev/null
+++ b/tests/xfs/914.out
@@ -0,0 +1,7 @@
+QA output created by 914
+test reflink flag not set
+310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
+310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/b
+test reflink flag already set
+310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/a
+310f146ce52077fcd3308dcbe7632bb2  SCRATCH_MNT/d
diff --git a/tests/xfs/group b/tests/xfs/group
index d6e8d1c3..a3d87124 100644
--- a/tests/xfs/group
+++ b/tests/xfs/group
@@ -518,3 +518,4 @@
 518 auto quick quota
 519 auto quick reflink
 520 auto quick reflink
+914 auto quick reflink
