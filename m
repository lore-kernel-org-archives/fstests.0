Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9338FC433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Oct 2021 07:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A7D060F02
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Oct 2021 07:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232140AbhJ2HCa (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 29 Oct 2021 03:02:30 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:64478 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230252AbhJ2HCa (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Oct 2021 03:02:30 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AUco8RapCzrdDVsOPfq0zioOvbDNeBmIEZxIvgKr?=
 =?us-ascii?q?LsJaIsI5as4F+vjZKDz2HbKmNYGumfdwnOoXi8UpXuMfQmtAwHgFuqi1kQiMRo?=
 =?us-ascii?q?6IpJ/zDcB6oYHn6wu4v7a5fx5xHLIGGdajYd1eEzvuWGuWn/SYUOZ2gHOKmUbe?=
 =?us-ascii?q?cYHApHmeIdQ964f5ds79g6mJXqYjha++9kYuaT/z3YDdJ6RYtWo4nw/7rRCdUg?=
 =?us-ascii?q?RjHkGhwUmrSyhx8lAS2e3E9VPrzLEwqRpfyatE88uWSH44vwFwll1418SvBCvv?=
 =?us-ascii?q?9+lr6WkYMBLDPPwmSkWcQUK+n6vRAjnVqlP9la7xHMgEK49mKt4kZJNFlr4G5T?=
 =?us-ascii?q?xw4eKPKg/g1XQRaEj1lIOtN/7qvzX2X6JXNkhKXLCexqxlpJARsVWECwc55Gn1?=
 =?us-ascii?q?D7uADAC4CYwrFhO+sxr+/DO52iawewGPDVG8Ekig4i2iHUrB9GtaeK5gmLORwh?=
 =?us-ascii?q?F8Y7v2i196HDybBVQdSUQ=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ALqkydanQ4oJAcH9VWtK0cwsXl0/pDfIQ3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzsCWYtN9/Yh8dcK+7UpVoLUm8yXcX2/h1AV7BZniEhI?=
 =?us-ascii?q?LAFugLgrcKqAeQeREWmNQ86Y5QN4B6CPDVSWNxlNvG5mCDeOoI8Z2q97+JiI7l?=
 =?us-ascii?q?o0tQcQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,191,1631548800"; 
   d="scan'208";a="116579745"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Oct 2021 15:00:01 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 437894D0F90D
        for <fstests@vger.kernel.org>; Fri, 29 Oct 2021 15:00:00 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 29 Oct 2021 15:00:00 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 29 Oct 2021 14:59:58 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 3/3] generic/201: fix the description
Date:   Fri, 29 Oct 2021 14:59:43 +0800
Message-ID: <20211029065943.3556529-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211029065943.3556529-1-ruansy.fnst@fujitsu.com>
References: <20211029065943.3556529-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 437894D0F90D.ADBEE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This case is test for 'unlink', and there is no umount operation here.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/201     | 2 +-
 tests/generic/201.out | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/201 b/tests/generic/201
index 9b65445a..2598b44a 100755
--- a/tests/generic/201
+++ b/tests/generic/201
@@ -50,7 +50,7 @@ md5sum $testdir/file1 | _filter_scratch
 md5sum $testdir/file3 | _filter_scratch
 md5sum $testdir/file3.chk | _filter_scratch
 
-echo "CoW and unmount"
+echo "CoW and unlink"
 cowoff=$((filesize / 4))
 cowsz=$((filesize / 2))
 $XFS_IO_PROG -f -c "pwrite -S 0x63 -b $cowsz $cowoff $cowsz" $testdir/file3 >> $seqres.full
diff --git a/tests/generic/201.out b/tests/generic/201.out
index 52669d27..6867704a 100644
--- a/tests/generic/201.out
+++ b/tests/generic/201.out
@@ -5,4 +5,4 @@ Compare files
 bdbcf02ee0aa977795a79d25fcfdccb1  SCRATCH_MNT/test-201/file1
 d3959a68638c50af07f0258e032cb554  SCRATCH_MNT/test-201/file3
 d3959a68638c50af07f0258e032cb554  SCRATCH_MNT/test-201/file3.chk
-CoW and unmount
+CoW and unlink
-- 
2.33.0



