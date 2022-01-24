Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDF4C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Jan 2022 11:10:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237213AbiAXLKz (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Jan 2022 06:10:55 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4130 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237214AbiAXLKy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Jan 2022 06:10:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643022655; x=1674558655;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=d4ENreMGrlKCk5cIjSx96VRXwooXyBj4UXgKGLLw7K0=;
  b=EqxhghPAI3cgk4jVDmrquMdu93ECyqXzIhX9/+zu4vkqsdPNe0t9L7gR
   yBvYJ953Ebhe187g2Re0hf9qvR8wgrS8uKwvASM/aurApZqwOQJzBMa1x
   qSItMVktclh7cjmJUvh42vGLWimQfl9syeZct2N3ymJrse/dXlaeC2I3Y
   j5H6MAB6oOIR8TJlyrR8o8StS6vx9FcglLMcnednslmgtyYxePmPbap6y
   SLkjpsIwZeryrviICVpcwr+kM/I3NqEnE6W4uxWrrFjQwVCw6FAyKdmYr
   DvRzKsBCpCzDlMctRs82qzRlkI1yPzFNqdAL90fjlX3/2IOITJOOt1VuX
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,311,1635177600"; 
   d="scan'208";a="192220960"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2022 19:10:55 +0800
IronPort-SDR: I+nPlzQxXjpikn3I/svjjYmRb6lM8iE7iGINsDrWHK5+oU6wjfcO2ayBVNWREddGqbP/vI689a
 FDMYNLTRQR07RyNGli4cH3cAM92Lh7PGhMZOaHisa5n1JimCBK0USXPi1Pfv9lonuH7i9sBuSM
 HQDB2NIR3o500qGOWtfcoz34idMwaa1kurFpnazDKJL91ZYZgwMgsJU/8jv9o+Igus7ugQAp/t
 zPDK40fC8EPncu8e6IklnWHmZVjgLzUu3tgSmrG6o3zziQ44my69oZAbwSWdY3I6oP4zQflucl
 SJPqfTimfQmtYGFMQXX9NOMj
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 02:44:17 -0800
IronPort-SDR: lDCrM92RiokE2tJKCNjjc4pNjMGFCEH3LUQQ0Om0WJyD7Qtg9c5uniMwQ47F1HRvqcKLq8PmVr
 Vajuo7gVDFQiybALpb//+ll2yM+bst4LLVUWKj8EoCzlI9TBSsXktgw42u+sS7OKGGfxrerS7w
 OYViaOhs6PHx3mYN45XNIrUyxqA/C5eMb6YuOf+Wvsd0JmeKF1Bmz1cy+7h5eXP0eou0eUr8rS
 nlzATo8lUr1ClHjHgqHCHBV5Byu51PAKYXcndp4NtU8UBxBhu0MyTbatCaMAbZ357/ke7w64zp
 qMs=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Jan 2022 03:10:53 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 2/7] generic/{171,172,173,174,204}: check _scratch_mkfs_sized return code
Date:   Mon, 24 Jan 2022 20:10:45 +0900
Message-Id: <20220124111050.183628-3-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124111050.183628-1-shinichiro.kawasaki@wdc.com>
References: <20220124111050.183628-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The test cases generic/{171,172,173,174,204} call _scratch_mkfs before
_scratch_mkfs_sized, and they do not check return code of
_scratch_mkfs_sized. Even if _scratch_mkfs_sized failed, _scratch_mount
after it cannot detect the sized mkfs failure because _scratch_mkfs
already created a file system on the device. This results in unexpected
test condition of the test cases.

To avoid the unexpected test condition, check return code of
_scratch_mkfs_sized in the test cases.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/generic/171 | 2 +-
 tests/generic/172 | 2 +-
 tests/generic/173 | 2 +-
 tests/generic/174 | 2 +-
 tests/generic/204 | 3 ++-
 5 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tests/generic/171 b/tests/generic/171
index fb2a6f14..f823a454 100755
--- a/tests/generic/171
+++ b/tests/generic/171
@@ -42,7 +42,7 @@ sz_bytes=$((nr_blks * 8 * blksz))
 if [ $sz_bytes -lt $((32 * 1048576)) ]; then
 	sz_bytes=$((32 * 1048576))
 fi
-_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
+_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount >> $seqres.full 2>&1
 rm -rf $testdir
 mkdir $testdir
diff --git a/tests/generic/172 b/tests/generic/172
index ab5122fa..383824b9 100755
--- a/tests/generic/172
+++ b/tests/generic/172
@@ -40,7 +40,7 @@ umount $SCRATCH_MNT
 
 file_size=$((768 * 1024 * 1024))
 fs_size=$((1024 * 1024 * 1024))
-_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1
+_scratch_mkfs_sized $fs_size >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount >> $seqres.full 2>&1
 rm -rf $testdir
 mkdir $testdir
diff --git a/tests/generic/173 b/tests/generic/173
index 0eb313e2..e1493278 100755
--- a/tests/generic/173
+++ b/tests/generic/173
@@ -42,7 +42,7 @@ sz_bytes=$((nr_blks * 8 * blksz))
 if [ $sz_bytes -lt $((32 * 1048576)) ]; then
 	sz_bytes=$((32 * 1048576))
 fi
-_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
+_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount >> $seqres.full 2>&1
 rm -rf $testdir
 mkdir $testdir
diff --git a/tests/generic/174 b/tests/generic/174
index 1505453e..c7a177b8 100755
--- a/tests/generic/174
+++ b/tests/generic/174
@@ -43,7 +43,7 @@ sz_bytes=$((nr_blks * 8 * blksz))
 if [ $sz_bytes -lt $((32 * 1048576)) ]; then
 	sz_bytes=$((32 * 1048576))
 fi
-_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1
+_scratch_mkfs_sized $sz_bytes >> $seqres.full 2>&1 || _fail "mkfs failed"
 _scratch_mount >> $seqres.full 2>&1
 rm -rf $testdir
 mkdir $testdir
diff --git a/tests/generic/204 b/tests/generic/204
index a3dabb71..b5deb443 100755
--- a/tests/generic/204
+++ b/tests/generic/204
@@ -35,7 +35,8 @@ _scratch_mkfs 2> /dev/null | _filter_mkfs 2> $tmp.mkfs > /dev/null
 [ $FSTYP = "xfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -l size=16m -i maxpct=50"
 
 SIZE=`expr 115 \* 1024 \* 1024`
-_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw
+_scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw \
+	|| _fail "mkfs failed"
 cat $tmp.mkfs.raw | _filter_mkfs 2> $tmp.mkfs > /dev/null
 _scratch_mount
 
-- 
2.34.1

