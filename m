Received: from mail.cn.fujitsu.com ([183.91.158.132]:9384 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729305AbeKWQqd (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Nov 2018 11:46:33 -0500
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2] common/rc: Add _require_filefrag_options() to check options for filefrag
Date: Fri, 23 Nov 2018 13:24:23 +0800
Message-ID: <1542950663-7784-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20181123051251.GJ3889@desktop>
References: <20181123051251.GJ3889@desktop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: guaneryu@gmail.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

In generic/519, filefrag command use FIBMAP ioctl(-B option) to print
output in extent format(-e option) on purpose and sync file(-s option),
so add _require_filefrag_options() to check if the command supports
all of these options.

References:
1) filefrag supports -e option by commit 2508eaa since e2fsprogs v1.42.7.
2) filefrag supports -B option by commit 5d5e01d since e2fsprogs v1.41.9.
3) filefrag supports -s option by commit e62847c since e2fsprogs v1.41.6.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/rc         | 15 ++++++++++++++-
 tests/generic/519 |  2 +-
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index ecb1738..e5da648 100644
--- a/common/rc
+++ b/common/rc
@@ -3843,10 +3843,23 @@ _require_scratch_btime()
 	_scratch_unmount
 }
 
-_require_fibmap()
+_require_filefrag_options()
 {
 	_require_command "$FILEFRAG_PROG" filefrag
 
+	local options=$1
+	local file="$TEST_DIR/options_testfile"
+
+	echo "XX" > $file
+	${FILEFRAG_PROG} -$options $file 2>&1 | grep -q "invalid option" && \
+		_notrun "filefrag doesn't support $options option"
+	rm -f $file
+}
+
+_require_fibmap()
+{
+	_require_filefrag_options "B"
+
 	local file="$TEST_DIR/fibmap_testfile"
 
 	echo "XX" > $file
diff --git a/tests/generic/519 b/tests/generic/519
index 229c5b4..d1a3c17 100755
--- a/tests/generic/519
+++ b/tests/generic/519
@@ -33,8 +33,8 @@ rm -f $seqres.full
 _supported_fs generic
 _supported_os Linux
 _require_scratch
-_require_command "$FILEFRAG_PROG" filefrag
 _require_fibmap
+_require_filefrag_options "es"
 
 testfile="$SCRATCH_MNT/$seq-testfile"
 
-- 
1.8.3.1
