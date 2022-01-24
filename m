Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779CAC433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 24 Jan 2022 11:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237218AbiAXLK7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 24 Jan 2022 06:10:59 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:4130 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237220AbiAXLK6 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 24 Jan 2022 06:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1643022659; x=1674558659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PmOAO/z/5SQRJrAaX0rjm1/SDaYQLCQkeqzLnW4Z6gk=;
  b=Wb3wAvOiHUkqE83X8H839SGjNbpi5pWHvz1hfWrgLBf9PlzbWgmvbTR5
   0v9wqbZWYBtJQz8LPp26ZCIU4Yra8M2jR+FIYZWppQfjj2/erOzqrv8SX
   uCY7kevABhtvzVhdj2LqpyNYtl7aUb9ZEpfhFjy2eeHmEx1GgO/f/OvVn
   Y5xs27a+j94Z72PtCOlENKyPcc0M1HuIUqg5hgg/KcWt+remGu5lpARyA
   TFM71j4atZzV0DBi3OJl5U7edW2ecEsO9JN3SrGB2lK63YKRSh1dSXUvr
   pcNbAn2DlImqI10tJ6+tNb9ImaHZ5ss0vKO6Vkoofvwxpo6EE6j2Xl0XN
   g==;
X-IronPort-AV: E=Sophos;i="5.88,311,1635177600"; 
   d="scan'208";a="192220970"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 24 Jan 2022 19:10:59 +0800
IronPort-SDR: qdWuefoH8YaR2X2QBjMT+81YF5TEy3I17+TsMjn1xH68lwJXRO3iWPWUU1E4GcQ1iwN/FDNPrs
 mqL6jI0wuB7gy8XFrxICga/TFiIQ5dimyf4E42Thx3S5ADR6fTh1VjmElHxwDqbPkCtia05ihx
 VLQfUMTZzRKeILnrku1GwdUcLl060DKCS/wullSJOM/NPO21KWP4p8VYx3Nxs5gkK2T31/iHY8
 9Xv35mqhMGfKHd9ZSRjtIkv8LsV15AK4fzdl6FKdjrl7mXGSr7ndtWi0hJx8cxFqPbHU+UjqwJ
 zAssMu29MDX2j21RdDySaSM6
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 02:44:21 -0800
IronPort-SDR: gaXP/s56+EZtti98cfp9wWJ/WbNn2UHAgNKgnKmboHybY5RAFiI6WqQ+mMHMghwPGLKzxMIvkV
 rukq+fYVfQMtgN6T020cDbXTvD8pcGW8/SSoiJNwJmr/x/ixLVLR8FUFpmMkKSNd2Mj29PHebQ
 K2U+DQ+K2Q10Ky/8+IeEUQBwnZIMDtlGZYLnI5YI4Yi0giYMqn2vgTueykxVnVW2n0fhPKHhJM
 JuemWv+40K8VEC1NuqOBf/GPAuqTDEFKpJN0BD2COpSZohuRcgdLZHCN3SgJn1YuhSpBBRq+UD
 G00=
WDCIronportException: Internal
Received: from shindev.dhcp.fujisawa.hgst.com (HELO shindev.fujisawa.hgst.com) ([10.149.52.173])
  by uls-op-cesaip01.wdc.com with ESMTP; 24 Jan 2022 03:10:57 -0800
From:   Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To:     fstests@vger.kernel.org
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 6/7] common: move _xfs_filter_mkfs from common/filter to common/xfs
Date:   Mon, 24 Jan 2022 20:10:49 +0900
Message-Id: <20220124111050.183628-7-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124111050.183628-1-shinichiro.kawasaki@wdc.com>
References: <20220124111050.183628-1-shinichiro.kawasaki@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The helper function _xfs_filter_mkfs works only for xfs. Move it from
common/filter to common/xfs. Also remove useless lines for other
filesystems.

Suggested-by: Naohiro Aota <naohiro.aota@wdc.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 common/filter | 53 ---------------------------------------------------
 common/xfs    | 43 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 53 deletions(-)

diff --git a/common/filter b/common/filter
index 24fd0650..7c71be4f 100644
--- a/common/filter
+++ b/common/filter
@@ -115,59 +115,6 @@ _filter_date()
 	-e 's/[A-Z][a-z][a-z] [A-z][a-z][a-z]  *[0-9][0-9]* [0-9][0-9]:[0-9][0-9]:[0-9][0-9] [0-9][0-9][0-9][0-9]$/DATE/'
 }
 
-# prints filtered output on stdout, values (use eval) on stderr
-# Non XFS filesystems always return a 4k block size and a 256 byte inode.
-_xfs_filter_mkfs()
-{
-    case $FSTYP in
-    xfs)
-	;;
-    *)
-	cat - >/dev/null
-	perl -e 'print STDERR "dbsize=4096\nisize=256\n"'
-	return ;;
-    esac
-
-    echo "_fs_has_crcs=0" >&2
-    set -
-    perl -ne '
-    if (/^meta-data=([\w,|\/.-]+)\s+isize=(\d+)\s+agcount=(\d+), agsize=(\d+) blks/) {
-	print STDERR "ddev=$1\nisize=$2\nagcount=$3\nagsize=$4\n";
-	print STDOUT "meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks\n";
-    }
-    if (/^\s+=\s+sectsz=(\d+)\s+attr=(\d+)/) {
-        print STDERR "sectsz=$1\nattr=$2\n";
-    }
-    if (/^\s+=\s+crc=(\d)/) {
-        print STDERR "_fs_has_crcs=$1\n";
-    }
-    if (/^data\s+=\s+bsize=(\d+)\s+blocks=(\d+), imaxpct=(\d+)/) {
-	print STDERR "dbsize=$1\ndblocks=$2\nimaxpct=$3\n";
-	print STDOUT "data     = bsize=XXX blocks=XXX, imaxpct=PCT\n";
-    }
-    if (/^\s+=\s+sunit=(\d+)\s+swidth=(\d+) blks/) {
-        print STDERR "sunit=$1\nswidth=$2\nunwritten=1\n";
-	print STDOUT "         = sunit=XXX swidth=XXX, unwritten=X\n";
-    }
-    if (/^naming\s+=version\s+(\d+)\s+bsize=(\d+)/) {
-	print STDERR "dirversion=$1\ndirbsize=$2\n";
-	print STDOUT "naming   =VERN bsize=XXX\n";
-    }
-    if (/^log\s+=(internal log|[\w|\/.-]+)\s+bsize=(\d+)\s+blocks=(\d+),\s+version=(\d+)/ ||
-	/^log\s+=(internal log|[\w|\/.-]+)\s+bsize=(\d+)\s+blocks=(\d+)/) {
-	print STDERR "ldev=\"$1\"\nlbsize=$2\nlblocks=$3\nlversion=$4\n";
-	print STDOUT "log      =LDEV bsize=XXX blocks=XXX\n";
-    }
-    if (/^\s+=\s+sectsz=(\d+)\s+sunit=(\d+) blks/) {
-	print STDERR "logsectsz=$1\nlogsunit=$2\n\n";
-    }
-    if (/^realtime\s+=([\w|\/.-]+)\s+extsz=(\d+)\s+blocks=(\d+), rtextents=(\d+)/) {
-	print STDERR "rtdev=$1\nrtextsz=$2\nrtblocks=$3\nrtextents=$4\n";
-	print STDOUT "realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX\n";
-    }'
-}
-
-
 # prints the bits we care about in growfs
 # 
 _filter_growfs()
diff --git a/common/xfs b/common/xfs
index 3435c706..a3da25dd 100644
--- a/common/xfs
+++ b/common/xfs
@@ -1275,3 +1275,46 @@ _require_scratch_xfs_bigtime()
 		_notrun "bigtime feature not advertised on mount?"
 	_scratch_unmount
 }
+
+# prints filtered output on stdout, values (use eval) on stderr
+# Non XFS filesystems always return a 4k block size and a 256 byte inode.
+_xfs_filter_mkfs()
+{
+    echo "_fs_has_crcs=0" >&2
+    set -
+    perl -ne '
+    if (/^meta-data=([\w,|\/.-]+)\s+isize=(\d+)\s+agcount=(\d+), agsize=(\d+) blks/) {
+	print STDERR "ddev=$1\nisize=$2\nagcount=$3\nagsize=$4\n";
+	print STDOUT "meta-data=DDEV isize=XXX agcount=N, agsize=XXX blks\n";
+    }
+    if (/^\s+=\s+sectsz=(\d+)\s+attr=(\d+)/) {
+        print STDERR "sectsz=$1\nattr=$2\n";
+    }
+    if (/^\s+=\s+crc=(\d)/) {
+        print STDERR "_fs_has_crcs=$1\n";
+    }
+    if (/^data\s+=\s+bsize=(\d+)\s+blocks=(\d+), imaxpct=(\d+)/) {
+	print STDERR "dbsize=$1\ndblocks=$2\nimaxpct=$3\n";
+	print STDOUT "data     = bsize=XXX blocks=XXX, imaxpct=PCT\n";
+    }
+    if (/^\s+=\s+sunit=(\d+)\s+swidth=(\d+) blks/) {
+        print STDERR "sunit=$1\nswidth=$2\nunwritten=1\n";
+	print STDOUT "         = sunit=XXX swidth=XXX, unwritten=X\n";
+    }
+    if (/^naming\s+=version\s+(\d+)\s+bsize=(\d+)/) {
+	print STDERR "dirversion=$1\ndirbsize=$2\n";
+	print STDOUT "naming   =VERN bsize=XXX\n";
+    }
+    if (/^log\s+=(internal log|[\w|\/.-]+)\s+bsize=(\d+)\s+blocks=(\d+),\s+version=(\d+)/ ||
+	/^log\s+=(internal log|[\w|\/.-]+)\s+bsize=(\d+)\s+blocks=(\d+)/) {
+	print STDERR "ldev=\"$1\"\nlbsize=$2\nlblocks=$3\nlversion=$4\n";
+	print STDOUT "log      =LDEV bsize=XXX blocks=XXX\n";
+    }
+    if (/^\s+=\s+sectsz=(\d+)\s+sunit=(\d+) blks/) {
+	print STDERR "logsectsz=$1\nlogsunit=$2\n\n";
+    }
+    if (/^realtime\s+=([\w|\/.-]+)\s+extsz=(\d+)\s+blocks=(\d+), rtextents=(\d+)/) {
+	print STDERR "rtdev=$1\nrtextsz=$2\nrtblocks=$3\nrtextents=$4\n";
+	print STDOUT "realtime =RDEV extsz=XXX blocks=XXX, rtextents=XXX\n";
+    }'
+}
-- 
2.34.1

