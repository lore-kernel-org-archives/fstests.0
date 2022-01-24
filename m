Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 539D9C433F5
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Jan 2022 11:11:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbiAXLK7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Jan 2022 06:10:59 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4130 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237220AbiAXLK7 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Jan 2022 06:10:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643022660; x=1674558660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=78Zs28KpKxQ8bPUPZ5jK1PRmnWo6oej03te2uWqoGL8=;
  b=qRiXwsVhfiyi+WJCsEtTaXj1KwKxcNhlUsuXf3LxOpLPz2POSlgorYXV
   2hEd5GwvzapEroVB83gFCeYhOywLar2wy5N5BVqkM2OShR5Cw+Pe17cBw
   fPVqWRIeI+ZLoNGQS3fh9uA1JOKGlNk7YWm2DphW+4CnM9uNQkWlQRf80
   84IwI2zUPbFO05enPBGuhhsKOcekcBdAP6/euILaSs+8eIpwCOQOhqZLV
   gMoZGmZCghPougRXy/NWAj6GANLAkY84aRAJIp4syHkshuJoQPS7ug0Td
   wvP0NBIPakNRw28IVqTpkuHqn93qtfDgwcUf2qFo16V+dC1qzNvc5Ikxu
   g==;
X-IronPort-AV: E=Sophos;i="5.88,311,1635177600"; 
   d="scan'208";a="192220972"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2022 19:10:59 +0800
IronPort-SDR: xKMgqHsZIoRZba5sU++DAh7+6FzQvTzBSa+ADFlf0oNlRkeYpPBP30W07FwwrjfXE8t3om3g3I
 Olk/O43pXMghqoKxuz4zY9SEmtSVrIYhP5htlPd1fLdL7fdSZTSS5B/DH2X9X/YuG/vzPwq4kA
 oyVE+8BEwxgwxPPDTeLin8wuBRHDEj2XDv5gB0j+XA/pbg3SVIyule5HOzhI5ARa/zRLP0RF8u
 vEg6jCD2lheXlEZlo/SXM42INW58l+s2YZORoRV478MsDv1ku3R5Lof3+P+UgZ0PSGsL2h50ok
 Nc8sSGOk2yEuTgNufoUVRZ2i
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 02:44:22 -0800
IronPort-SDR: yRh8g2ck4qpnb6h79EUsURKvB0HcrSMrUsa651tWume6V8njr/xkix5G3oo+hkgdqbUcX90Afw
 MuwpM5KAeuTAtyMPcnzp/2WP0CyQTL27GdUnLPltrwFEyv3U2ESr8rz5MSJB8MDxxQpyt0Ycp9
 BJH5eJ3aT6EG5OgKNvpxy9eBBvW6+sytBuoHXSvSk6A4dHqbN8rFvtPK2fRcpStFhE9cnAqyCH
 YTcQ8NQWW8tIik+W9UaZfkHtLexlWcKzr6Lhtk7mhu+JyEAhJI61hDB04a/H+nWGr7d8Qr3ppK
 fzA=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Jan 2022 03:10:58 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 7/7] generic/204: do xfs unique preparation only for xfs
Date:   Mon, 24 Jan 2022 20:10:50 +0900
Message-Id: <20220124111050.183628-8-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124111050.183628-1-shinichiro.kawasaki@wdc.com>
References: <20220124111050.183628-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The test case generic/204 formats the scratch device to get block size
as a part of preparation. However, this preparation is required only for
xfs. To simplify preparation for other filesystems, do the preparation
only for xfs.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 tests/generic/204 | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/tests/generic/204 b/tests/generic/204
index 40d524d1..ea267760 100755
--- a/tests/generic/204
+++ b/tests/generic/204
@@ -16,17 +16,18 @@ _cleanup()
 	sync
 }
 
-# Import common functions.
-. ./common/filter
-
 # real QA test starts here
 _supported_fs generic
 
 _require_scratch
 
-# get the block size first
-_scratch_mkfs 2> /dev/null | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
-. $tmp.mkfs
+dbsize=4096
+isize=256
+if [ $FSTYP = "xfs" ]; then
+	# get the block size first
+	_scratch_mkfs 2> /dev/null | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
+	. $tmp.mkfs
+fi
 
 # For xfs, we need to handle the different default log sizes that different
 # versions of mkfs create. All should be valid with a 16MB log, so use that.
@@ -37,11 +38,15 @@ _scratch_mkfs 2> /dev/null | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
 SIZE=`expr 115 \* 1024 \* 1024`
 _scratch_mkfs_sized $SIZE $dbsize 2> /dev/null > $tmp.mkfs.raw \
 	|| _fail "mkfs failed"
-cat $tmp.mkfs.raw | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
+
+if [ $FSTYP = "xfs" ]; then
+	cat $tmp.mkfs.raw | _xfs_filter_mkfs 2> $tmp.mkfs > /dev/null
+	# Source $tmp.mkfs to get geometry
+	. $tmp.mkfs
+fi
+
 _scratch_mount
 
-# Source $tmp.mkfs to get geometry
-. $tmp.mkfs
 
 # fix the reserve block pool to a known size so that the enospc calculations
 # work out correctly. Space usages is based 22500 files and 1024 reserved blocks
-- 
2.34.1

