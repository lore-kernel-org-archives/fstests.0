Received: from mx2.suse.de ([195.135.220.15]:36732 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729004AbeLUJQS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 21 Dec 2018 04:16:18 -0500
From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v2] common/config: create $RESULT_BASE before dumping kmemleak leaks
Date: Fri, 21 Dec 2018 10:16:12 +0100
Message-Id: <20181221091612.8504-1-jthumshirn@suse.de>
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

Create the ${RESULT_BASE} just after assigning the default value in
get_next_config()

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

---
Changes to v1:
* Move mkdir to get_next_config() in common/config

I assumed Darrick's R-b is still valid after this change
---
 common/config | 1 +
 1 file changed, 1 insertion(+)

diff --git a/common/config b/common/config
index a87cb4a2bdd5..a776558deb7e 100644
--- a/common/config
+++ b/common/config
@@ -657,6 +657,7 @@ get_next_config() {
 	# set default RESULT_BASE
 	if [ -z "$RESULT_BASE" ]; then
 		export RESULT_BASE="$here/results/"
+		mkdir -p ${RESULT_BASE}
 	fi
 
 	if [ "$FSTYP" == "tmpfs" ]; then
-- 
2.16.4
