Received: from mail-wm0-f66.google.com ([74.125.82.66]:33095 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbdABNXQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 2 Jan 2017 08:23:16 -0500
Received: by mail-wm0-f66.google.com with SMTP id u144so82060444wmu.0
        for <fstests@vger.kernel.org>; Mon, 02 Jan 2017 05:23:15 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH 1/2] check: factor out get_sub_group_list() helper
Date: Mon,  2 Jan 2017 15:22:58 +0200
Message-Id: <1483363379-10210-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

This helper gets a list of tests that belong to a group
under a specific tests subdir.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 check | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/check b/check
index cf6379b..faf6281 100755
--- a/check
+++ b/check
@@ -87,19 +87,30 @@ testlist options
 	    exit 0
 }
 
+get_sub_group_list()
+{
+	local d=$1
+	local grp=$2
+
+	test -s "$SRC_DIR/$d/group" || return 1
+
+	local grpl=$(sed -n < $SRC_DIR/$d/group \
+		-e 's/#.*//' \
+		-e 's/$/ /' \
+		-e "s;^\($VALID_TEST_NAME\).* $grp .*;$SRC_DIR/$d/\1;p")
+	echo $grpl
+}
+
 get_group_list()
 {
-	grp=$1
+	local grp=$1
+	local grpl=""
 
 	for d in $SRC_GROUPS $FSTYP; do
 		if ! test -d "$SRC_DIR/$d" ; then
 			continue
 		fi
-		l=$(sed -n < $SRC_DIR/$d/group \
-			-e 's/#.*//' \
-			-e 's/$/ /' \
-			-e "s;^\($VALID_TEST_NAME\).* $grp .*;$SRC_DIR/$d/\1;p")
-		grpl="$grpl $l"
+		grpl="$grpl $(get_sub_group_list $d $grp)"
 	done
 	echo $grpl
 }
-- 
2.7.4

