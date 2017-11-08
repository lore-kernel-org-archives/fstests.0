Received: from mgwkm03.jp.fujitsu.com ([202.219.69.170]:43451 "EHLO
        mgwkm03.jp.fujitsu.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbdKHEiW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 7 Nov 2017 23:38:22 -0500
From: "Misono, Tomohiro" <misono.tomohiro@jp.fujitsu.com>
Subject: [PATCH] fstests: btrfs: add 'zstd' to compress property filter
Message-ID: <be482613-1e30-d59b-98dc-b882a2df1b0d@jp.fujitsu.com>
Date: Wed, 8 Nov 2017 13:27:00 +0900
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-btrfs <linux-btrfs@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

This fixes the false failure of btrfs/059 when running with the 
mount option '-o compress=zstd'.

Signed-off-by: Tomohiro Misono <misono.tomohiro@jp.fujitsu.com>
---
 common/filter.btrfs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/filter.btrfs b/common/filter.btrfs
index 0cf7f0d3..aaff2278 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -69,7 +69,7 @@ _filter_btrfs_subvol_delete()
 
 _filter_btrfs_compress_property()
 {
-	sed -e "s/compression=\(lzo\|zlib\)/COMPRESSION=XXX/g"
+	sed -e "s/compression=\(lzo\|zlib\|zstd\)/COMPRESSION=XXX/g"
 }
 
 # filter error messages from btrfs prop, optionally verify against $1
-- 
2.13.6

