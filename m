Received: from szxga06-in.huawei.com ([45.249.212.32]:35504 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727035AbfBTBz7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 19 Feb 2019 20:55:59 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id CA846FC13930E16DB3A2
        for <fstests@vger.kernel.org>; Wed, 20 Feb 2019 09:55:57 +0800 (CST)
From: Yufen Yu <yuyufen@huawei.com>
Subject: [PATCH 1/5] commom/rc: define function _get_max_file_size
Date: Wed, 20 Feb 2019 09:59:51 +0800
Message-ID: <20190220015955.26342-2-yuyufen@huawei.com>
In-Reply-To: <20190220015955.26342-1-yuyufen@huawei.com>
References: <20190220015955.26342-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Define a new function _get_max_file_size to return
the max file size supported by the special filesystem.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 common/rc | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/common/rc b/common/rc
index e5da6484..10ab497d 100644
--- a/common/rc
+++ b/common/rc
@@ -3785,6 +3785,29 @@ _require_scratch_feature()
 	esac
 }
 
+# get filesystem max file size
+_get_max_file_size()
+{
+	case $FSTYP in
+	vfat|jffs2|romfs)
+		echo $((2**32-1)) # 0xFFFFFFFF
+		;;
+	*) # MAX_LFS_FILESIZE
+		case "$(getconf LONG_BIT)" in
+		"32")
+			echo $(( ($(getconf PAGE_SIZE) << ($(getconf LONG_BIT) - 1) ) - 1))
+			;;
+		"64")
+			echo "9223372036854775807"
+			;;
+		*)
+			_fail "sizeof(long) == $(getconf LONG_BIT)?"
+			;;
+		esac
+		;;
+	esac
+}
+
 # The maximum filesystem label length, /not/ including terminating NULL
 _label_get_max()
 {
-- 
2.16.2.dirty
