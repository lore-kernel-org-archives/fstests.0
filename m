Received: from szxga06-in.huawei.com ([45.249.212.32]:41592 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726020AbfBZOHp (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 26 Feb 2019 09:07:45 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id D516F9F16C94CD03FF20
        for <fstests@vger.kernel.org>; Tue, 26 Feb 2019 22:07:42 +0800 (CST)
From: Yufen Yu <yuyufen@huawei.com>
Subject: [PATCH v2 1/2] commom/rc: use the common function get_max_file_size
Date: Tue, 26 Feb 2019 22:11:53 +0800
Message-ID: <20190226141154.142271-2-yuyufen@huawei.com>
In-Reply-To: <20190226141154.142271-1-yuyufen@huawei.com>
References: <20190226141154.142271-1-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Move the function get_max_file_size() of generci/485 to common/rc,
and add the max filesize limit to generic/299.

Signed-off-by: Yufen Yu <yuyufen@huawei.com>
---
 common/rc         | 23 +++++++++++++++++++++++
 tests/generic/299 |  5 +++++
 tests/generic/485 | 23 -----------------------
 3 files changed, 28 insertions(+), 23 deletions(-)

diff --git a/common/rc b/common/rc
index e5da6484..987f3e23 100644
--- a/common/rc
+++ b/common/rc
@@ -3785,6 +3785,29 @@ _require_scratch_feature()
 	esac
 }
 
+# Get the maximum size of a file in $TEST_DIR (s_maxbytes).  On ext4 this will
+# be UINT32_MAX * block_size, but other filesystems may allow up to LLONG_MAX.
+get_max_file_size()
+{
+	local testfile=$TEST_DIR/maxfilesize.$seq
+	local l=0
+	local r=9223372036854775807 # LLONG_MAX
+
+	rm -f $testfile
+	while (( l < r )); do
+		# Use _math() to avoid signed integer overflow.
+		local m=$(_math "($l + $r + 1) / 2")
+		if $XFS_IO_PROG -f -c "truncate $m" $testfile \
+			|& grep -q 'File too large'
+		then
+			r=$(( m - 1 ))
+		else
+			l=$m
+		fi
+	done
+	echo $l
+}
+
 # The maximum filesystem label length, /not/ including terminating NULL
 _label_get_max()
 {
diff --git a/tests/generic/299 b/tests/generic/299
index c4d74fc8..494bf61c 100755
--- a/tests/generic/299
+++ b/tests/generic/299
@@ -33,6 +33,11 @@ NUM_JOBS=$((4*LOAD_FACTOR))
 BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
 FILE_SIZE=$((BLK_DEV_SIZE * 512))
 
+max_file_size=$(get_max_file_size)
+if [ $max_file_size -lt $FILE_SIZE ]; then
+	FILE_SIZE=$max_file_size
+fi
+
 cat >$fio_config <<EOF
 ###########
 # $seq test fio activity
diff --git a/tests/generic/485 b/tests/generic/485
index e88ac2e4..d55535c2 100755
--- a/tests/generic/485
+++ b/tests/generic/485
@@ -37,29 +37,6 @@ _require_xfs_io_command "falloc" "-k"
 _require_xfs_io_command "finsert"
 _require_xfs_io_command "truncate"
 
-# Get the maximum size of a file in $TEST_DIR (s_maxbytes).  On ext4 this will
-# be UINT32_MAX * block_size, but other filesystems may allow up to LLONG_MAX.
-get_max_file_size()
-{
-	local testfile=$TEST_DIR/maxfilesize.$seq
-	local l=0
-	local r=9223372036854775807 # LLONG_MAX
-
-	rm -f $testfile
-	while (( l < r )); do
-		# Use _math() to avoid signed integer overflow.
-		local m=$(_math "($l + $r + 1) / 2")
-		if $XFS_IO_PROG -f -c "truncate $m" $testfile \
-			|& grep -q 'File too large'
-		then
-			r=$(( m - 1 ))
-		else
-			l=$m
-		fi
-	done
-	echo $l
-}
-
 block_size=$(_get_file_block_size $TEST_DIR)
 max_file_size=$(get_max_file_size)
 max_blocks=$((max_file_size / block_size))
-- 
2.16.2.dirty
