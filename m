Received: from mx2.suse.de ([195.135.220.15]:47570 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730285AbfACKBj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 3 Jan 2019 05:01:39 -0500
From: Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] common/config: Always create RESULT_BASE
Date: Thu,  3 Jan 2019 12:01:35 +0200
Message-Id: <20190103100135.24748-1-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: guaneryu@gmail.com, Nikolay Borisov <nborisov@suse.com>
List-ID: <fstests@vger.kernel.org>

Commit 7fc034868d5d ("common/config: create $RESULT_BASE before dumping kmemleak leaks")
inadvertently broke $RESULT_BASE dir creation since it changed the logic
to only create the directory only if this variable is not explicitly set
by the user. Fix this by ensuring RESULT_BASE is always created.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 common/config | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/common/config b/common/config
index fb664cf0a967..e2da9cfacbb5 100644
--- a/common/config
+++ b/common/config
@@ -663,11 +663,12 @@ get_next_config() {
 	# set default RESULT_BASE
 	if [ -z "$RESULT_BASE" ]; then
 		export RESULT_BASE="$here/results/"
-		mkdir -p ${RESULT_BASE}
-		if [ ! -d ${RESULT_BASE} ]; then
-			echo "failed to create results directory $RESULT_BASE"
-			exit 1
-		fi
+	fi
+
+	mkdir -p ${RESULT_BASE}
+	if [ ! -d ${RESULT_BASE} ]; then
+		echo "failed to create results directory $RESULT_BASE"
+		exit 1
 	fi
 
 	if [ "$FSTYP" == "tmpfs" ]; then
-- 
2.7.4
