Received: from cn.fujitsu.com ([59.151.112.132]:61009 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751354AbdGRI2J (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 18 Jul 2017 04:28:09 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
        by cn.fujitsu.com (Postfix) with ESMTP id 736FA46B5D21
        for <fstests@vger.kernel.org>; Tue, 18 Jul 2017 16:28:00 +0800 (CST)
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH] generic/448: don't disable extent zeroing if extent_max_zeroout_kb isn't supported
Date: Tue, 18 Jul 2017 16:27:50 +0800
Message-ID: <1500366470-10647-1-git-send-email-yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

On some old kernel(e.g. v3.5), this case fails because it can not create
extent_max_zeroout_kb file, as below:
  Silence is golden
 +./tests/generic/448: line 54: /sys/fs/ext4/sda5/extent_max_zeroout_kb: No such file or directory
  seek sanity check failed!

The extent_max_zeroout_kb file is introduced by:
  67a5da564f97('ext4: make the zero-out chunk size tunable')

We should only disable extent zeroing when extent_max_zeroout_kb is supported.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 tests/generic/448 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/generic/448 b/tests/generic/448
index 87b99d7..3e92742 100755
--- a/tests/generic/448
+++ b/tests/generic/448
@@ -51,7 +51,8 @@ _require_test_program "seek_sanity_test"
 # Disable extent zeroing for ext4 as that change where holes are created
 if [ "$FSTYP" = "ext4" ]; then
 	DEV=`_short_dev $TEST_DEV`
-	echo 0 >/sys/fs/ext4/$DEV/extent_max_zeroout_kb
+	[ -f /sys/fs/ext4/$DEV/extent_max_zeroout_kb ] \
+	&& echo 0 >/sys/fs/ext4/$DEV/extent_max_zeroout_kb
 fi
 
 $here/src/seek_sanity_test -s 18 -e 18 $BASE_TEST_FILE > $seqres.full 2>&1 ||
-- 
1.8.3.1



