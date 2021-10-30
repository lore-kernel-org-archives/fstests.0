Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB399C433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 30 Oct 2021 08:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A38600D4
	for <linux-fstests@archiver.kernel.org>; Sat, 30 Oct 2021 08:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhJ3IhU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 30 Oct 2021 04:37:20 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:2922 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229546AbhJ3IhU (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 30 Oct 2021 04:37:20 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AywiRza/P2PLsgeW92LDuDrUDqXyTJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUomgTUFxzcYCG6HP/6CNzamLdwlPdu08RgB7MDXnYQ2SldlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4EfyWlTdhSMkj/jRHuCtULW?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt8pswdNWpNq+T?=
 =?us-ascii?q?xw1FqPRmuUBSAQeGCZ7VUFD0Oaefybl7pHJlyUqdFOpmZ2CFnoeMY8H/eB4KWJ?=
 =?us-ascii?q?D7/oVLHYKdB/rr+yt3L+gVvJEmMsuNo/oMZkZt3UmyivWZcvK67irr77ivIceh?=
 =?us-ascii?q?WlvwJsVW6u2WibQUhI3BDyoXvGFEg5/5EoCodqV?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AcLe5B67M7kwBCpr6+APXwCzXdLJyesId70hD?=
 =?us-ascii?q?6qhwISY6TiX+rbHJoB17726MtN9/YhEdcLy7VJVoBEmskKKdgrNhWotKPjOW21?=
 =?us-ascii?q?dARbsKheCJrgEIWReOktK1vp0AT0ERMrLN5CBB/KTHCReDYqsd6ejC4Ka1nv3f?=
 =?us-ascii?q?0nsoaQlrbptr5wB/Bh3zKDwMeCB2QYo+CIGH5tdK4x6peXEsZMy9AXUfG8fZod?=
 =?us-ascii?q?mjruOdXTc2Qw4g9BKVjS6lrJrzEx2j1B8YVD9VhZcOmFK16zDE2g=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,194,1631548800"; 
   d="scan'208";a="116627520"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Oct 2021 16:34:48 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 1663F4D0F90F;
        Sat, 30 Oct 2021 16:34:45 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sat, 30 Oct 2021 16:34:40 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sat, 30 Oct 2021 16:34:37 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2 1/3] generic/138,139,140: fix the name for check file
Date:   Sat, 30 Oct 2021 16:34:31 +0800
Message-ID: <20211030083433.3616711-2-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211030083433.3616711-1-ruansy.fnst@fujitsu.com>
References: <20211030083433.3616711-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 1663F4D0F90F.A4F7D
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The original 'file3' is used to check if the result after operation on
file2 is correct.  So, rename it to be 'file2.chk' to make it easier to
understand.

Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 tests/generic/138     | 54 +++++++++++++++++++++----------------------
 tests/generic/138.out |  8 +++----
 tests/generic/139     | 54 +++++++++++++++++++++----------------------
 tests/generic/139.out |  8 +++----
 tests/generic/140     | 54 +++++++++++++++++++++----------------------
 tests/generic/140.out |  8 +++----
 6 files changed, 93 insertions(+), 93 deletions(-)

diff --git a/tests/generic/138 b/tests/generic/138
index 1037ed3e..d061ac34 100755
--- a/tests/generic/138
+++ b/tests/generic/138
@@ -35,37 +35,37 @@ echo "Create the original files"
 blksz=65536
 _pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file3 >> $seqres.full
+_pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file2.chk >> $seqres.full
 _test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
-md5sum $testdir/file3 | _filter_test_dir
+md5sum $testdir/file2.chk | _filter_test_dir
 
-cmp -s $testdir/file1 $testdir/file2 || echo "Files 1-2 do not match"
-cmp -s $testdir/file1 $testdir/file3 || echo "Files 1-3 do not match"
-cmp -s $testdir/file2 $testdir/file3 || echo "Files 2-3 do not match"
+cmp -s $testdir/file1 $testdir/file2 || echo "file1 and file2 do not match"
+cmp -s $testdir/file1 $testdir/file2.chk || echo "file1 and file2.chk do not match"
+cmp -s $testdir/file2 $testdir/file2.chk || echo "file1 and file2.chk do not match"
 
 echo "pagecache CoW the second file"
 _pwrite_byte 0x62 0 17 $testdir/file2 >> $seqres.full
-_pwrite_byte 0x62 0 17 $testdir/file3 >> $seqres.full
+_pwrite_byte 0x62 0 17 $testdir/file2.chk >> $seqres.full
 
 _pwrite_byte 0x62 $((blksz * 16 - 34)) 17 $testdir/file2 >> $seqres.full
-_pwrite_byte 0x62 $((blksz * 16 - 34)) 17 $testdir/file3 >> $seqres.full
+_pwrite_byte 0x62 $((blksz * 16 - 34)) 17 $testdir/file2.chk >> $seqres.full
 
 _pwrite_byte 0x62 $((blksz * 48 - 8)) 17 $testdir/file2 >> $seqres.full
-_pwrite_byte 0x62 $((blksz * 48 - 8)) 17 $testdir/file3 >> $seqres.full
+_pwrite_byte 0x62 $((blksz * 48 - 8)) 17 $testdir/file2.chk >> $seqres.full
 _test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
-md5sum $testdir/file3 | _filter_test_dir
+md5sum $testdir/file2.chk | _filter_test_dir
 
-cmp -s $testdir/file1 $testdir/file2 || echo "Files 1-2 do not match (intentional)"
-cmp -s $testdir/file1 $testdir/file3 || echo "Files 1-3 do not match (intentional)"
-cmp -s $testdir/file2 $testdir/file3 || echo "Files 2-3 do not match"
+cmp -s $testdir/file1 $testdir/file2 || echo "file1 and file2 do not match (intentional)"
+cmp -s $testdir/file1 $testdir/file2.chk || echo "file1 and file2.chk do not match (intentional)"
+cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk do not match"
 
 echo "Compare the CoW'd section to the before file"
 _compare_range $testdir/file1 0 $testdir/file2 0 17 \
@@ -80,47 +80,47 @@ _compare_range  $testdir/file1 $((blksz * 48 - 8)) \
        || echo "End sections do not match (intentional)"
 
 echo "Compare the CoW'd section to the after file"
-_compare_range $testdir/file2 0 $testdir/file3 0 17 \
+_compare_range $testdir/file2 0 $testdir/file2.chk 0 17 \
        || echo "Start sections do not match"
 
 _compare_range  $testdir/file2 $((blksz * 16 - 34)) \
-		$testdir/file3 $((blksz * 16 - 34)) 17 \
+		$testdir/file2.chk $((blksz * 16 - 34)) 17 \
        || echo "Middle sections do not match"
 
 _compare_range  $testdir/file2 $((blksz * 48 - 8)) \
-		$testdir/file3 $((blksz * 48 - 8)) 17 \
+		$testdir/file2.chk $((blksz * 48 - 8)) 17 \
        || echo "End sections do not match"
 
 echo "Compare the not CoW'd sections"
 _compare_range $testdir/file1 18 $testdir/file2 18 17 \
-       || echo "Start sections of 1-2 do not match"
+       || echo "Start sections of file1 and file2 do not match"
 
-_compare_range $testdir/file2 18 $testdir/file3 18 17 \
-       || echo "Start sections of 2-3 do not match"
+_compare_range $testdir/file2 18 $testdir/file2.chk 18 17 \
+       || echo "Start sections of file2 and file2.chk do not match"
 
 _compare_range  $testdir/file1 $((blksz * 16 - 17)) \
 		$testdir/file2 $((blksz * 16 - 17)) 82 \
-       || echo "Middle sections of 1-2 do not match"
+       || echo "Middle sections of file1 and file2 do not match"
 
 _compare_range  $testdir/file2 $((blksz * 16 - 17)) \
-		$testdir/file3 $((blksz * 16 - 17)) 82 \
-       || echo "Middle sections of 2-3 do not match"
+		$testdir/file2.chk $((blksz * 16 - 17)) 82 \
+       || echo "Middle sections of file2 and file2.chk do not match"
 
 _compare_range  $testdir/file1 $((blksz * 48 - 108)) \
 		$testdir/file2 $((blksz * 48 - 108)) 100 \
-       || echo "End sections of 1-2 do not match"
+       || echo "End sections of file1 and file2 do not match"
 
 _compare_range  $testdir/file2 $((blksz * 48 - 108)) \
-		$testdir/file3 $((blksz * 48 - 108)) 100 \
-       || echo "End sections of 2-3 do not match"
+		$testdir/file2.chk $((blksz * 48 - 108)) 100 \
+       || echo "End sections of file2 and file2.chk do not match"
 
 _compare_range  $testdir/file1 $((blksz * 14)) \
 		$testdir/file2 $((blksz * 14)) $blksz \
-       || echo "Untouched sections of 1-2 do not match"
+       || echo "Untouched sections of file1 and file2 do not match"
 
 _compare_range  $testdir/file2 $((blksz * 14)) \
-		$testdir/file3 $((blksz * 14)) $blksz \
-       || echo "Untouched sections of 2-3 do not match"
+		$testdir/file2.chk $((blksz * 14)) $blksz \
+       || echo "Untouched sections of file2 and file2.chk do not match"
 
 # success, all done
 status=0
diff --git a/tests/generic/138.out b/tests/generic/138.out
index b0cafabe..60cd876e 100644
--- a/tests/generic/138.out
+++ b/tests/generic/138.out
@@ -3,14 +3,14 @@ Create the original files
 Compare files
 60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-138/file1
 60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-138/file2
-60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-138/file3
+60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-138/file2.chk
 pagecache CoW the second file
 Compare files
 60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-138/file1
 4a879c2f322121f6f4b8ebede1909a7c  TEST_DIR/test-138/file2
-4a879c2f322121f6f4b8ebede1909a7c  TEST_DIR/test-138/file3
-Files 1-2 do not match (intentional)
-Files 1-3 do not match (intentional)
+4a879c2f322121f6f4b8ebede1909a7c  TEST_DIR/test-138/file2.chk
+file1 and file2 do not match (intentional)
+file1 and file2.chk do not match (intentional)
 Compare the CoW'd section to the before file
 Start sections do not match (intentional)
 Middle sections do not match (intentional)
diff --git a/tests/generic/139 b/tests/generic/139
index 6422f66a..0bbc222c 100755
--- a/tests/generic/139
+++ b/tests/generic/139
@@ -36,37 +36,37 @@ echo "Create the original files"
 blksz=65536
 _pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file3 >> $seqres.full
+_pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file2.chk >> $seqres.full
 _test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
-md5sum $testdir/file3 | _filter_test_dir
+md5sum $testdir/file2.chk | _filter_test_dir
 
-cmp -s $testdir/file1 $testdir/file2 || echo "Files 1-2 should match"
-cmp -s $testdir/file1 $testdir/file3 || echo "Files 1-3 should match"
-cmp -s $testdir/file2 $testdir/file3 || echo "Files 2-3 should match"
+cmp -s $testdir/file1 $testdir/file2 || echo "file1 and file2 should match"
+cmp -s $testdir/file1 $testdir/file2.chk || echo "file1 and file2.chk should match"
+cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk should match"
 
 echo "directio CoW the second file"
 _pwrite_byte 0x62 0 $blksz $testdir/file2 -d >> $seqres.full
-_pwrite_byte 0x62 0 $blksz $testdir/file3 -d >> $seqres.full
+_pwrite_byte 0x62 0 $blksz $testdir/file2.chk -d >> $seqres.full
 
 _pwrite_byte 0x62 $((blksz * 16 - 512)) 512 $testdir/file2 -d >> $seqres.full
-_pwrite_byte 0x62 $((blksz * 16 - 512)) 512 $testdir/file3 -d >> $seqres.full
+_pwrite_byte 0x62 $((blksz * 16 - 512)) 512 $testdir/file2.chk -d >> $seqres.full
 
 _pwrite_byte 0x62 $((blksz * 48)) $blksz $testdir/file2 -d >> $seqres.full
-_pwrite_byte 0x62 $((blksz * 48)) $blksz $testdir/file3 -d >> $seqres.full
+_pwrite_byte 0x62 $((blksz * 48)) $blksz $testdir/file2.chk -d >> $seqres.full
 _test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
-md5sum $testdir/file3 | _filter_test_dir
+md5sum $testdir/file2.chk | _filter_test_dir
 
-cmp -s $testdir/file1 $testdir/file2 || echo "Files 1-2 should not match (intentional)"
-cmp -s $testdir/file1 $testdir/file3 || echo "Files 1-3 should not match (intentional)"
-cmp -s $testdir/file2 $testdir/file3 || echo "Files 2-3 should match"
+cmp -s $testdir/file1 $testdir/file2 || echo "file1 and file2 should not match (intentional)"
+cmp -s $testdir/file1 $testdir/file2.chk || echo "file1 and file2.chk should not match (intentional)"
+cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk should match"
 
 echo "Compare the CoW'd section to the before file"
 _compare_range $testdir/file1 0 $testdir/file2 0 $blksz \
@@ -81,46 +81,46 @@ _compare_range  $testdir/file1 $((blksz * 48 - 512)) \
        || echo "End sections do not match (intentional)"
 
 echo "Compare the CoW'd section to the after file"
-_compare_range $testdir/file2 0 $testdir/file3 0 $blksz \
+_compare_range $testdir/file2 0 $testdir/file2.chk 0 $blksz \
        || echo "Start sections do not match"
 
 _compare_range  $testdir/file2 $((blksz * 16 - 512)) \
-		$testdir/file3 $((blksz * 16 - 512)) 512 \
+		$testdir/file2.chk $((blksz * 16 - 512)) 512 \
        || echo "Middle sections do not match"
 
 _compare_range  $testdir/file2 $((blksz * 48 - 512)) \
-		$testdir/file3 $((blksz * 48 - 512)) $blksz \
+		$testdir/file2.chk $((blksz * 48 - 512)) $blksz \
        || echo "End sections do not match"
 
 echo "Compare the not CoW'd sections"
 _compare_range $testdir/file1 $blksz $testdir/file2 $blksz 512 \
-       || echo "Start sections of 1-2 do not match"
-_compare_range $testdir/file2 $blksz $testdir/file3 $blksz 512 \
-       || echo "Start sections of 2-3 do not match"
+       || echo "Start sections of file1 and file2 do not match"
+_compare_range $testdir/file2 $blksz $testdir/file2.chk $blksz 512 \
+       || echo "Start sections of file2 and file2.chk do not match"
 
 _compare_range  $testdir/file1 $((blksz * 16 - 1024)) \
 		$testdir/file2 $((blksz * 16 - 1024)) 512 \
-       || echo "Middle sections of 1-2 do not match"
+       || echo "Middle sections of file1 and file2 do not match"
 
 _compare_range  $testdir/file2 $((blksz * 16 - 1024)) \
-		$testdir/file3 $((blksz * 16 - 1024)) 512 \
-       || echo "Middle sections of 2-3 do not match"
+		$testdir/file2.chk $((blksz * 16 - 1024)) 512 \
+       || echo "Middle sections of file2 and file2.chk do not match"
 
 _compare_range  $testdir/file1 $((blksz * 48 - 1024)) \
 		$testdir/file2 $((blksz * 48 - 1024)) 512 \
-       || echo "End sections of 1-2 do not match"
+       || echo "End sections of file1 and file2 do not match"
 
 _compare_range  $testdir/file2 $((blksz * 48 - 1024)) \
-		$testdir/file3 $((blksz * 48 - 1024)) 512 \
-       || echo "End sections of 2-3 do not match"
+		$testdir/file2.chk $((blksz * 48 - 1024)) 512 \
+       || echo "End sections of file2 and file2.chk do not match"
 
 _compare_range  $testdir/file1 $((blksz * 16)) \
 		$testdir/file2 $((blksz * 16)) 512 \
-       || echo "Untouched sections of 1-2 do not match"
+       || echo "Untouched sections of file1 and file2 do not match"
 
 _compare_range  $testdir/file2 $((blksz * 16)) \
-		$testdir/file3 $((blksz * 16)) 512 \
-       || echo "Untouched sections of 2-3 do not match"
+		$testdir/file2.chk $((blksz * 16)) 512 \
+       || echo "Untouched sections of file2 and file2.chk do not match"
 
 # success, all done
 status=0
diff --git a/tests/generic/139.out b/tests/generic/139.out
index 28d04f5f..56d6c9f9 100644
--- a/tests/generic/139.out
+++ b/tests/generic/139.out
@@ -3,14 +3,14 @@ Create the original files
 Compare files
 60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-139/file1
 60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-139/file2
-60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-139/file3
+60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-139/file2.chk
 directio CoW the second file
 Compare files
 60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-139/file1
 ff5626fb6c71b242d6b1a43de25c9a85  TEST_DIR/test-139/file2
-ff5626fb6c71b242d6b1a43de25c9a85  TEST_DIR/test-139/file3
-Files 1-2 should not match (intentional)
-Files 1-3 should not match (intentional)
+ff5626fb6c71b242d6b1a43de25c9a85  TEST_DIR/test-139/file2.chk
+file1 and file2 should not match (intentional)
+file1 and file2.chk should not match (intentional)
 Compare the CoW'd section to the before file
 Start sections do not match (intentional)
 Middle sections do not match (intentional)
diff --git a/tests/generic/140 b/tests/generic/140
index 6cba5791..52cf07dc 100755
--- a/tests/generic/140
+++ b/tests/generic/140
@@ -35,37 +35,37 @@ echo "Create the original files"
 blksz=65536
 _pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file1 >> $seqres.full
 _cp_reflink $testdir/file1 $testdir/file2 >> $seqres.full
-_pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file3 >> $seqres.full
+_pwrite_byte 0x61 0 $((blksz * 48 - 3)) $testdir/file2.chk >> $seqres.full
 _test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
-md5sum $testdir/file3 | _filter_test_dir
+md5sum $testdir/file2.chk | _filter_test_dir
 
-cmp -s $testdir/file1 $testdir/file2 || echo "Files 1-2 do not match"
-cmp -s $testdir/file1 $testdir/file3 || echo "Files 1-3 do not match"
-cmp -s $testdir/file2 $testdir/file3 || echo "Files 2-3 do not match"
+cmp -s $testdir/file1 $testdir/file2 || echo "file1 and file2 do not match"
+cmp -s $testdir/file1 $testdir/file2.chk || echo "file1 and file2.chk do not match"
+cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk do not match"
 
 echo "mmap CoW the second file"
 _mwrite_byte 0x62 0 17 $((blksz * 48 - 3)) $testdir/file2 >> $seqres.full
-_mwrite_byte 0x62 0 17 $((blksz * 48 - 3)) $testdir/file3 >> $seqres.full
+_mwrite_byte 0x62 0 17 $((blksz * 48 - 3)) $testdir/file2.chk >> $seqres.full
 
 _mwrite_byte 0x62 $((blksz * 16 - 34)) 17 $((blksz * 48 - 3)) $testdir/file2 >> $seqres.full
-_mwrite_byte 0x62 $((blksz * 16 - 34)) 17 $((blksz * 48 - 3)) $testdir/file3 >> $seqres.full
+_mwrite_byte 0x62 $((blksz * 16 - 34)) 17 $((blksz * 48 - 3)) $testdir/file2.chk >> $seqres.full
 
 _mwrite_byte 0x62 $((blksz * 48 - 20)) 17 $((blksz * 48 - 3)) $testdir/file2 >> $seqres.full
-_mwrite_byte 0x62 $((blksz * 48 - 20)) 17 $((blksz * 48 - 3)) $testdir/file3 >> $seqres.full
+_mwrite_byte 0x62 $((blksz * 48 - 20)) 17 $((blksz * 48 - 3)) $testdir/file2.chk >> $seqres.full
 _test_cycle_mount
 
 echo "Compare files"
 md5sum $testdir/file1 | _filter_test_dir
 md5sum $testdir/file2 | _filter_test_dir
-md5sum $testdir/file3 | _filter_test_dir
+md5sum $testdir/file2.chk | _filter_test_dir
 
-cmp -s $testdir/file1 $testdir/file2 || echo "Files 1-2 do not match (intentional)"
-cmp -s $testdir/file1 $testdir/file3 || echo "Files 1-3 do not match (intentional)"
-cmp -s $testdir/file2 $testdir/file3 || echo "Files 2-3 do not match"
+cmp -s $testdir/file1 $testdir/file2 || echo "file1 and file2 do not match (intentional)"
+cmp -s $testdir/file1 $testdir/file2.chk || echo "file1 and file2.chk do not match (intentional)"
+cmp -s $testdir/file2 $testdir/file2.chk || echo "file2 and file2.chk do not match"
 
 echo "Compare the CoW'd section to the before file"
 _compare_range $testdir/file1 0 $testdir/file2 0 17 \
@@ -80,47 +80,47 @@ _compare_range  $testdir/file1 $((blksz * 48 - 20)) \
        || echo "End sections do not match (intentional)"
 
 echo "Compare the CoW'd section to the after file"
-_compare_range $testdir/file2 0 $testdir/file3 0 17 \
+_compare_range $testdir/file2 0 $testdir/file2.chk 0 17 \
        || echo "Start sections do not match"
 
 _compare_range  $testdir/file2 $((blksz * 16 - 34)) \
-		$testdir/file3 $((blksz * 16 - 34)) 17 \
+		$testdir/file2.chk $((blksz * 16 - 34)) 17 \
        || echo "Middle sections do not match"
 
 _compare_range  $testdir/file2 $((blksz * 48 - 20)) \
-		$testdir/file3 $((blksz * 48 - 20)) 17 \
+		$testdir/file2.chk $((blksz * 48 - 20)) 17 \
        || echo "End sections do not match"
 
 echo "Compare the not CoW'd sections"
 _compare_range $testdir/file1 18 $testdir/file2 18 17 \
-       || echo "Start sections of 1-2 do not match"
+       || echo "Start sections of file1 and file2 do not match"
 
-_compare_range $testdir/file2 18 $testdir/file3 18 17 \
-       || echo "Start sections of 2-3 do not match"
+_compare_range $testdir/file2 18 $testdir/file2.chk 18 17 \
+       || echo "Start sections of file2 and file2.chk do not match"
 
 _compare_range  $testdir/file1 $((blksz * 16 - 17)) \
 		$testdir/file2 $((blksz * 16 - 17)) 82 \
-       || echo "Middle sections of 1-2 do not match"
+       || echo "Middle sections of file1 and file2 do not match"
 
 _compare_range  $testdir/file2 $((blksz * 16 - 17)) \
-		$testdir/file3 $((blksz * 16 - 17)) 82 \
-       || echo "Middle sections of 2-3 do not match"
+		$testdir/file2.chk $((blksz * 16 - 17)) 82 \
+       || echo "Middle sections of file2 and file2.chk do not match"
 
 _compare_range  $testdir/file1 $((blksz * 48 - 120)) \
 		$testdir/file2 $((blksz * 48 - 120)) 100 \
-       || echo "End sections of 1-2 do not match"
+       || echo "End sections of file1 and file2 do not match"
 
 _compare_range  $testdir/file2 $((blksz * 48 - 120)) \
-		$testdir/file3 $((blksz * 48 - 120)) 100 \
-       || echo "End sections of 2-3 do not match"
+		$testdir/file2.chk $((blksz * 48 - 120)) 100 \
+       || echo "End sections of file2 and file2.chk do not match"
 
 _compare_range  $testdir/file1 $((blksz * 14)) \
 		$testdir/file2 $((blksz * 14)) $blksz \
-       || echo "Untouched sections of 1-2 do not match"
+       || echo "Untouched sections of file1 and file2 do not match"
 
 _compare_range  $testdir/file2 $((blksz * 14)) \
-		$testdir/file3 $((blksz * 14)) $blksz \
-       || echo "Untouched sections of 2-3 do not match"
+		$testdir/file2.chk $((blksz * 14)) $blksz \
+       || echo "Untouched sections of file2 and file2.chk do not match"
 
 # success, all done
 status=0
diff --git a/tests/generic/140.out b/tests/generic/140.out
index 51a5b854..89389001 100644
--- a/tests/generic/140.out
+++ b/tests/generic/140.out
@@ -3,14 +3,14 @@ Create the original files
 Compare files
 60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-140/file1
 60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-140/file2
-60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-140/file3
+60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-140/file2.chk
 mmap CoW the second file
 Compare files
 60ebe700450b6015c17fa15cacb9493b  TEST_DIR/test-140/file1
 795ecfd281dbda4916431376228e4187  TEST_DIR/test-140/file2
-795ecfd281dbda4916431376228e4187  TEST_DIR/test-140/file3
-Files 1-2 do not match (intentional)
-Files 1-3 do not match (intentional)
+795ecfd281dbda4916431376228e4187  TEST_DIR/test-140/file2.chk
+file1 and file2 do not match (intentional)
+file1 and file2.chk do not match (intentional)
 Compare the CoW'd section to the before file
 Start sections do not match (intentional)
 Middle sections do not match (intentional)
-- 
2.33.0



