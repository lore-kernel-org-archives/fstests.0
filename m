Received: from szxga04-in.huawei.com ([45.249.212.190]:3166 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbfI0KHK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 27 Sep 2019 06:07:10 -0400
From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] common/casefold: support f2fs
Date: Fri, 27 Sep 2019 18:06:27 +0800
Message-ID: <20190927100627.9086-2-yuchao0@huawei.com>
In-Reply-To: <20190927100627.9086-1-yuchao0@huawei.com>
References: <20190927100627.9086-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Chao Yu <yuchao0@huawei.com>
List-ID: <fstests@vger.kernel.org>

Now, f2fs has ported casefold feature from ext4, let's enable the
testcase.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 common/casefold | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/casefold b/common/casefold
index 2a7ab3eb..9172d818 100644
--- a/common/casefold
+++ b/common/casefold
@@ -9,6 +9,9 @@ _has_casefold_kernel_support()
 	ext4)
 		test -f '/sys/fs/ext4/features/casefold'
 		;;
+	f2fs)
+		test -f '/sys/fs/f2fs/features/casefold'
+		;;
 	*)
 		# defaults to unsupported
 		false
@@ -46,6 +49,9 @@ _scratch_mkfs_casefold()
 	ext4)
 		_scratch_mkfs -O casefold $*
 		;;
+	f2fs)
+		_scratch_mkfs -C utf8 $*
+		;;
 	*)
 		_notrun "Don't know how to mkfs with casefold support on $FSTYP"
 		;;
@@ -58,6 +64,9 @@ _scratch_mkfs_casefold_strict()
 	ext4)
 		_scratch_mkfs -O casefold -E encoding_flags=strict
 		;;
+	f2fs)
+		_scratch_mkfs -C utf8:strict
+		;;
 	*)
 		_notrun "Don't know how to mkfs with casefold-strict support on $FSTYP"
 		;;
-- 
2.18.0.rc1
