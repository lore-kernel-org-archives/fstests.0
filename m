Return-Path: <SRS0=PSS3=C2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A191C2BBD1
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Sep 2020 14:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356EE21734
	for <linux-fstests@archiver.kernel.org>; Thu, 17 Sep 2020 14:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GxieKqna"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbgIQO1g (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 17 Sep 2020 10:27:36 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:14453 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgIQOZe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 17 Sep 2020 10:25:34 -0400
X-Greylist: delayed 395 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 10:25:34 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1600352735; x=1631888735;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2MhW77oV8btirfWfFIKBYhQGaaBDhy1fd69LnN2i+xA=;
  b=GxieKqnatBxTvUhY4zwgyTja1oiUeRrrEGwhWJTW3gRW42Exgv2c+8pD
   a4kz7ZjEPyt2+LhM4FXZ6+aDmx92qhRgrTYThgloTGi2l55RjuVHyj8Kh
   UCuC6ghFhd1NzCul9iPSGCYcCLT9V9xyyzM9+S4SdwtXF2SoHwJEd6hD1
   Pr484ShcMfn6KzMoD4skKcRpymtzYOck6qinTeGm1znDYGLnVNyDA1o5f
   p7JGguGnOCFBhVFYIkUs9f6yoVfKIpRj9tmhpIXXe8ZEmb5/JjAOEP3Uz
   PTiBpZcq2Dzvi5HaEKTW1QAE8b5Pq7mGMhMJg9xlNoI5EhECb/cw6seA/
   Q==;
IronPort-SDR: FbR+bcugjQYrEROFYG3fPglSnU9Rada7yMSIoZ2KYCtMwQNJZsV/Wozd8HOxBJSHE85myKBy/6
 btLnZpcxIYM/3zVpnebkiigEV6y78wJEhHTgukCq4wjx0OwbgKs9G7yjImBPDKdpS4YNob+ki1
 5xrNR9dfxvy8W/FRtxglDAsZXfbFBBiItrPPkKTuwC9eBlVK4BOVpqtpPphQmPU6Riq0IbSYMS
 Gl2Ogh45Wp8cdy2Y4KPbfjWULYkAYFfahOKrwn0Ks2iuQrQs3KVAIXwSWbTVcLI3eU5UkbBWhF
 Qjw=
X-IronPort-AV: E=Sophos;i="5.76,437,1592841600"; 
   d="scan'208";a="147638775"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 17 Sep 2020 22:14:01 +0800
IronPort-SDR: SvbERTDKonVVshoKMq+/bI753In2W9vxBEBJ1gsvXYfwEjlcRYm2K+l5lrg0W0P4Nzb/2gUr0m
 CNQw3Ac2tF4Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2020 07:00:14 -0700
IronPort-SDR: jr3kRM/333wMLiHcd3GluVGxz/zGxef56AhH4KaTET9ME33pmzylY79BpRxeK6LmCzNIb3VoO6
 /5fR+J2V5hZg==
WDCIronportException: Internal
Received: from unknown (HELO redsun60.ssa.fujisawa.hgst.com) ([10.149.66.36])
  by uls-op-cesaip01.wdc.com with ESMTP; 17 Sep 2020 07:14:00 -0700
From:   Johannes Thumshirn <johannes.thumshirn@wdc.com>
To:     linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Cc:     Anand Jain <anand.jain@oracle.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH] btrfs: remove stale test for alien devices
Date:   Thu, 17 Sep 2020 23:13:53 +0900
Message-Id: <20200917141353.28566-1-johannes.thumshirn@wdc.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

btrfs/198 is supposed to be a test for the patch
"btrfs: remove identified alien device in open_fs_devices" but this patch
was never merged in btrfs.

Remove the test from fstests as it is constantly failing.

Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 tests/btrfs/198   | 77 -----------------------------------------------
 tests/btrfs/group |  1 -
 2 files changed, 78 deletions(-)
 delete mode 100755 tests/btrfs/198

diff --git a/tests/btrfs/198 b/tests/btrfs/198
deleted file mode 100755
index 2df075e27134..000000000000
--- a/tests/btrfs/198
+++ /dev/null
@@ -1,77 +0,0 @@
-#! /bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2019 Oracle.  All Rights Reserved.
-#
-# FS QA Test 198
-#
-# Test stale and alien non-btrfs device in the fs devices list.
-#  Bug fixed in:
-#    btrfs: remove identified alien device in open_fs_devices
-#
-seq=`basename $0`
-seqres=$RESULT_DIR/$seq
-echo "QA output created by $seq"
-
-here=`pwd`
-tmp=/tmp/$$
-status=1	# failure is the default!
-trap "_cleanup; exit \$status" 0 1 2 3 15
-
-_cleanup()
-{
-	cd /
-	rm -f $tmp.*
-}
-
-# get standard environment, filters and checks
-. ./common/rc
-. ./common/filter
-. ./common/filter.btrfs
-
-# remove previous $seqres.full before test
-rm -f $seqres.full
-
-# real QA test starts here
-_supported_fs btrfs
-_supported_os Linux
-_require_command "$WIPEFS_PROG" wipefs
-_require_scratch
-_require_scratch_dev_pool 4
-
-workout()
-{
-	raid=$1
-	device_nr=$2
-
-	echo $raid
-	_scratch_dev_pool_get $device_nr
-
-	_scratch_pool_mkfs "-d$raid -m$raid" >> $seqres.full 2>&1 || \
-							_fail "mkfs failed"
-
-	# Make device_1 a free btrfs device for the raid created above by
-	# clearing its superblock
-
-	# don't test with the first device as auto fs check (_check_scratch_fs)
-	# picks the first device
-	device_1=$(echo $SCRATCH_DEV_POOL | awk '{print $2}')
-	$WIPEFS_PROG -a $device_1 >> $seqres.full 2>&1
-
-	device_2=$(echo $SCRATCH_DEV_POOL | awk '{print $1}')
-	_mount -o degraded $device_2 $SCRATCH_MNT
-	# Check if missing device is reported as in the 196.out
-	$BTRFS_UTIL_PROG filesystem show -m $SCRATCH_MNT | \
-						_filter_btrfs_filesystem_show
-
-	_scratch_unmount
-	_scratch_dev_pool_put
-}
-
-workout "raid1" "2"
-workout "raid5" "3"
-workout "raid6" "4"
-workout "raid10" "4"
-
-# success, all done
-status=0
-exit
diff --git a/tests/btrfs/group b/tests/btrfs/group
index 1b5fa695a9f7..d5330cd85cd5 100644
--- a/tests/btrfs/group
+++ b/tests/btrfs/group
@@ -199,7 +199,6 @@
 195 auto volume balance
 196 auto metadata log volume
 197 auto quick volume
-198 auto quick volume
 199 auto quick trim
 200 auto quick send clone
 201 auto quick punch log
-- 
2.26.2

