Received: from mx2.suse.de ([195.135.220.15]:47254 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726488AbfADObT (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 4 Jan 2019 09:31:19 -0500
From: Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] Revert "common/config: create $RESULT_BASE before dumping kmemleak leaks"
Date: Fri,  4 Jan 2019 16:31:16 +0200
Message-Id: <20190104143116.5698-1-nborisov@suse.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: guaneryu@gmail.com, Nikolay Borisov <nborisov@suse.com>
List-ID: <fstests@vger.kernel.org>

This commit tried to fix the brokennes of the kmemleak support but it 
inadvertently broke the creation of the RESULT_BASE directory which lead to 
problems creating check.time file. Turns out kmemleak support in xfstests has 
more problems and it needs to be majorly refactor and this commit doesn't 
really solve the problem. For the time being just revert to at least allow 
older configuration files, which have explicitly set RESULT_BASE to work. 

This reverts commit 7fc034868d5dce9aaf3517c9c2197221b9a772e4.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 check         | 7 +++++++
 common/config | 5 -----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/check b/check
index e4d767375b57..77a06b00dbba 100755
--- a/check
+++ b/check
@@ -538,6 +538,13 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		fi
 	fi
 
+	mkdir -p $RESULT_BASE
+	if [ ! -d $RESULT_BASE ]; then
+		echo "failed to create results directory $RESULT_BASE"
+		status=1
+		exit
+	fi
+
 	if $OPTIONS_HAVE_SECTIONS; then
 		echo "SECTION       -- $section"
 	fi
diff --git a/common/config b/common/config
index fb664cf0a967..5b48e1e7323b 100644
--- a/common/config
+++ b/common/config
@@ -663,11 +663,6 @@ get_next_config() {
 	# set default RESULT_BASE
 	if [ -z "$RESULT_BASE" ]; then
 		export RESULT_BASE="$here/results/"
-		mkdir -p ${RESULT_BASE}
-		if [ ! -d ${RESULT_BASE} ]; then
-			echo "failed to create results directory $RESULT_BASE"
-			exit 1
-		fi
 	fi
 
 	if [ "$FSTYP" == "tmpfs" ]; then
-- 
2.12.3
