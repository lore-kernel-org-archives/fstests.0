Received: from mx2.suse.de ([195.135.220.15]:60586 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728966AbeLTMw1 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 20 Dec 2018 07:52:27 -0500
From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] common/rc: create $RESULT_BASE before dumping kmemleak leaks
Date: Thu, 20 Dec 2018 13:52:22 +0100
Message-Id: <20181220125222.12041-1-jthumshirn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>
List-ID: <fstests@vger.kernel.org>

In _init_kmemleak() we're touching a check_kmemleak file in ${RESULT_BASE}
if ${DEBUGFS_MNT/kmemleak} exists as a marker that we have to check for
kmemleak output after running a test.

In 'check' we're calling _init_kmemleak() at around 60% of the file, but
${RESULT_BASE} is created later at around 62% of the file, causing the
'touch' in _init_kmemleak() to fail.

The workaround to this is creating ${RESULT_BASE} before touching
${RESULT_BASE}/check_kmemleak to always have the marker.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 common/rc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/rc b/common/rc
index e5da648466eb..5565b63e07ed 100644
--- a/common/rc
+++ b/common/rc
@@ -3528,6 +3528,7 @@ _init_kmemleak()
 	# then dump all the leaks recorded so far.
 	if echo "scan=off" > "$kern_knob" 2>/dev/null; then
 		_capture_kmemleak /dev/null
+		mkdir -p ${RESULT_BASE}
 		touch ${RESULT_BASE}/check_kmemleak
 	fi
 }
-- 
2.16.4
