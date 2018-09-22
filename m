Received: from mail-wr1-f67.google.com ([209.85.221.67]:39523 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728764AbeIVVRp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 22 Sep 2018 17:17:45 -0400
Received: by mail-wr1-f67.google.com with SMTP id s14-v6so15544737wrw.6
        for <fstests@vger.kernel.org>; Sat, 22 Sep 2018 08:23:48 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH v2] common/rc: fix check for disabled kmemleak
Date: Sat, 22 Sep 2018 18:23:39 +0300
Message-Id: <20180922152339.32023-1-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

With kernel commit b353756b2b71 ("kmemleak: always register debugfs file")
that was merged to v4.19-rc3, the kmemleak debugfs knob exists even if
kmemleak is disabled, but returns EBUSY on write.

Suppress EBUSY errors in tests by disabling _check_kmemleak() calls if the
write to kmemleak knob failed on _init_kmemleak().

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Eryu,

Good suggestion. This approach is much better and also works.

Thanks,
Amir.

Changes from v1:
- Use a file to disable checks instead of hacky chmod a-w

 common/rc | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index ec631ad9..d5bb1fee 100644
--- a/common/rc
+++ b/common/rc
@@ -3508,14 +3508,23 @@ _init_kmemleak()
 {
 	local kern_knob="${DEBUGFS_MNT}/kmemleak"
 
+	# Since kernel v4.19-rc3, the kmemleak knob exists even if kmemleak is
+	# disabled, but returns EBUSY on write. So instead of relying on
+	# existance of writable knob file, we use a test file to indicate that
+	# _check_kmemleak() is enabled only if we actually managed to write to
+	# the knob file.
+	rm -f ${RESULT_BASE}/check_kmemleak
+
 	if [ ! -w "$kern_knob" ]; then
 		return 0
 	fi
 
 	# Disable the automatic scan so that we can control it completely,
 	# then dump all the leaks recorded so far.
-	echo "scan=off" > "$kern_knob"
-	_capture_kmemleak /dev/null
+	if echo "scan=off" > "$kern_knob" 2>/dev/null; then
+		_capture_kmemleak /dev/null
+		touch ${RESULT_BASE}/check_kmemleak
+	fi
 }
 
 # check kmemleak log
@@ -3524,7 +3533,7 @@ _check_kmemleak()
 	local kern_knob="${DEBUGFS_MNT}/kmemleak"
 	local leak_file="${seqres}.kmemleak"
 
-	if [ ! -w "$kern_knob" ]; then
+	if [ ! -f ${RESULT_BASE}/check_kmemleak ]; then
 		return 0
 	fi
 
-- 
2.17.1
