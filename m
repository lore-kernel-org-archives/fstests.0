Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46953 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935253AbaKNN3M (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 14 Nov 2014 08:29:12 -0500
From: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
Subject: [PATCH 4/7] get_group_list changed to more universal get_list_from_file
Date: Fri, 14 Nov 2014 14:27:44 +0100
Message-Id: <1415971667-16873-4-git-send-email-jtulak@redhat.com>
In-Reply-To: <1415971667-16873-1-git-send-email-jtulak@redhat.com>
References: <1415971667-16873-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>, lczerner@redhat.com, david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

This patch changes name of get_group_list and adds one argument to
make it useful not only for groups, but also for environments.  It
works the same, just it takes the file name as an argument instead of
hardcoded 'group'.

Signed-off-by: Jan Ťulák <jtulak@redhat.com>
---
 check | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/check b/check
index a246d92..bdfd877 100755
--- a/check
+++ b/check
@@ -88,12 +88,15 @@ testlist options
 	    exit 0
 }
 
-get_group_list()
+# Get all tests tagged with specified group/environment
+# from a specified file.
+get_list_from_file()
 {
 	grp=$1
+	file=$2
 
 	for d in $SRC_GROUPS $FSTYP; do
-		l=$(sed -n < $SRC_DIR/$d/group \
+		l=$(sed -n < $SRC_DIR/$d/$file \
 			-e 's/#.*//' \
 			-e 's/$/ /' \
 			-e "s;\(^[0-9][0-9][0-9]\).* $grp .*;$SRC_DIR/$d/\1;p")
@@ -162,7 +165,7 @@ _prepare_test_list()
 
 	# Specified groups to include
 	for group in $GROUP_LIST; do
-		list=$(get_group_list $group)
+		list=$(get_list_from_file $group "group")
 		if [ -z "$list" ]; then
 			echo "Group \"$group\" is empty or not defined?"
 			exit 1
@@ -181,7 +184,7 @@ _prepare_test_list()
 
 	# Specified groups to exclude
 	for xgroup in $XGROUP_LIST; do
-		list=$(get_group_list $xgroup)
+		list=$(get_list_from_file $xgroup "group")
 		if [ -z "$list" ]; then
 			echo "Group \"$xgroup\" is empty or not defined?"
 			exit 1
-- 
1.9.3

