Received: from mail.cn.fujitsu.com ([183.91.158.132]:61098 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751114AbdIKJZv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 11 Sep 2017 05:25:51 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 6FD2F47278E8
        for <fstests@vger.kernel.org>; Mon, 11 Sep 2017 17:25:49 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] generic/456: add check for fallocate flags
Date: Mon, 11 Sep 2017 17:25:46 +0800
Message-ID: <1505121946-4900-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

On RHEL6.9GA, this case could not emulate a crash and passed due
to unsupported collapse_range and zero_range instead of no bug.

We added check for fallocate flags to avoid confusion.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/generic/456 | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/generic/456 b/tests/generic/456
index 8debd3f..b72acea 100755
--- a/tests/generic/456
+++ b/tests/generic/456
@@ -67,11 +67,16 @@ write 0x3e5ec 0x1a14 0x21446
 zero_range 0x20fac 0x6d9c 0x40000 keep_size
 mapwrite 0x216ad 0x274f 0x40000
 EOF
-run_check $here/ltp/fsx -d --replay-ops $fsxops $SCRATCH_MNT/testfile
+touch $tmp.dupops
+run_check $here/ltp/fsx -d --replay-ops $fsxops --record-ops=$tmp.dupops $SCRATCH_MNT/testfile
 
 _flakey_drop_and_remount
 _unmount_flakey
 _cleanup_flakey
+
+ops_name=$(awk '/skip/ {printf "%s ", $2}' $tmp.dupops)
+[ -n "$ops_name" ] && _notrun "fallocate does not support $ops_name"
+
 _check_scratch_fs
 
 echo "Silence is golden"
-- 
1.8.3.1



