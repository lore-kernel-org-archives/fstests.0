Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D06EC433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 30 Oct 2021 08:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13BBE61040
	for <linux-fstests@archiver.kernel.org>; Sat, 30 Oct 2021 08:34:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229546AbhJ3Ih0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 30 Oct 2021 04:37:26 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:2922 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231364AbhJ3Ih0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 30 Oct 2021 04:37:26 -0400
IronPort-Data: =?us-ascii?q?A9a23=3ALmSQpqxNcC8+7EY9iYp6t+cexCrEfRIJ4+MujC/?=
 =?us-ascii?q?XYbTApDJz1TwGnWUcWm6AbKyNY2Ghco8lOY3g/RwEv5DRmNI2HQtv/xmBbVoQ9?=
 =?us-ascii?q?5OdWo7xwmQcns+qBpSaChohtq3yU/GYRCwPZiKa9kjF3oTJ9yEmjPjQHOukU4Y?=
 =?us-ascii?q?oBwgqLeNaYHZ44f5cs75h6mJYqYDR7zKl4bsekeWGULOW82Ic3lYv1k62gEgHU?=
 =?us-ascii?q?MIeF98vlgdWifhj5DcynpSOZX4VDfnZw3DQGuG4EgMmLtsvwo1V/kuBl/ssIti?=
 =?us-ascii?q?j1LjmcEwWWaOUNg+L4pZUc/H6xEEc+WppieBmXBYfQR4/ZzGhhc14zs5c85K2U?=
 =?us-ascii?q?hsBMLDOmfgGTl9TFCQW0ahuoeaZfyLg7JbMp6HBWz62qxl0N2k6P5If/OlfAmx?=
 =?us-ascii?q?U8/EcbjcXYXirifmqzamnUcFyick5asrmJoUSvjdn1z6xMBqMafgvWI2TvZkBg?=
 =?us-ascii?q?mh23ZsIQJ7jiwMiQWIHRHz9j9dnZz/70K4Dodo=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A95ucPqsGyzpLJ4PP+L72sTwf7skDktV00zEX?=
 =?us-ascii?q?/kB9WHVpmszxra6TdZMgpHnJYVcqKQgdcL+7WJVoLUmxyXcx2/h1AV7AZniAhI?=
 =?us-ascii?q?LLFvAA0WKK+VSJcEeSygce79YFT0EUMrzN5DZB4voSmDPIcerI3uP3jZyAtKPP?=
 =?us-ascii?q?yWt3VwF2Z+VF5wd9MAySFUp7X2B9dOEEPavZ9sxavCChZHhSSsy6A0MOV+/Fq8?=
 =?us-ascii?q?aOu4nhZXc9dmQawTjLnTW186T7DhTd+h8fVglEybAk/XOAsyGR3NTaj82G?=
X-IronPort-AV: E=Sophos;i="5.87,194,1631548800"; 
   d="scan'208";a="116627527"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Oct 2021 16:34:54 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 582F34D0F90F;
        Sat, 30 Oct 2021 16:34:52 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sat, 30 Oct 2021 16:34:53 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sat, 30 Oct 2021 16:34:52 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sat, 30 Oct 2021 16:34:49 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 3/3] generic/201: fix the description
Date:   Sat, 30 Oct 2021 16:34:33 +0800
Message-ID: <20211030083433.3616711-4-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211030083433.3616711-1-ruansy.fnst@fujitsu.com>
References: <20211030083433.3616711-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 582F34D0F90F.AFE10
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This case is test for 'unlink', and there is no umount operation here.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
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



