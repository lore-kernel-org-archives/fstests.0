Received: from mail.cn.fujitsu.com ([183.91.158.132]:31873 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754191AbeDPJIC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 16 Apr 2018 05:08:02 -0400
From: yang xu <xuyang.jy@cn.fujitsu.com>
Subject: [PATCH v2] common/xfs: Add require_xfs_db_write_array function
Date: Mon, 16 Apr 2018 17:07:35 +0800
Message-ID: <1523869655-20309-1-git-send-email-xuyang.jy@cn.fujitsu.com>
In-Reply-To: <20180416060005.GJ2932@desktop>
References: <20180416060005.GJ2932@desktop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: david@fromorbit.com, fstests@vger.kernel.org, yang xu <xuyang.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

xfsprogs commit 4222d000ed("db: write via array indexing doesn't
work") fixes a bug that xfs_db write can't support array indexing.
This function will check whether the bug is fixed on the current
xfsprogs.

xfs/444 applies the function, and skips if this bug exists.

Signed-off-by: yang xu <xuyang.jy@cn.fujitsu.com>
---
 common/xfs    | 18 ++++++++++++++++++
 tests/xfs/444 |  1 +
 2 files changed, 19 insertions(+)

diff --git a/common/xfs b/common/xfs
index 3169f87..c4611a1 100644
--- a/common/xfs
+++ b/common/xfs
@@ -701,3 +701,21 @@ _scratch_xfs_set_sb_field()
 {
 	_scratch_xfs_set_metadata_field "$1" "$2" "sb 0"
 }
+
+#Before xfsprogs commit 4222d000ed("db: write via array indexing doesn't work"),
+#xfs_db command to write a specific AGFL index doesn't work.
+_require_xfs_db_write_array()
+{
+	_scratch_xfs_set_metadata_field "bno[32]" "78" "agfl 0" >/dev/null 2>&1
+
+	# Before xfsprogs commit 0ebbf1d58898 ("db: limit AGFL bno
+	# arrayi printing), When asking for a single agfl entry,
+	# the result outputs the entire remainder of the array
+	# starting at the given index.
+	# It is difficult to extract single entry values.
+	# So filter useless information.
+	bno_value=$(_scratch_xfs_get_metadata_field "bno[32]" \
+		"agfl 0" |sed -e 's/ .*$//g' | sed -e 's/^.*://g')
+
+	[ "${bno_value}" != "78" ] && _notrun "xfs_db write can't support array"
+}
diff --git a/tests/xfs/444 b/tests/xfs/444
index 141be52..9700422 100755
--- a/tests/xfs/444
+++ b/tests/xfs/444
@@ -54,6 +54,7 @@ _supported_os Linux
 _require_check_dmesg
 _require_scratch
 _require_test_program "punch-alternating"
+_require_xfs_db_write_array
 
 # This is only a v5 filesystem problem
 _require_scratch_xfs_crc
-- 
1.8.3.1



