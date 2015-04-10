Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46035 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932672AbbDJNCj (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 10 Apr 2015 09:02:39 -0400
From: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
Subject: [PATCH 7/7] fstests: environments - enable performance tests in ./check
Date: Fri, 10 Apr 2015 15:02:29 +0200
Message-Id: <1428670949-17524-8-git-send-email-jtulak@redhat.com>
In-Reply-To: <1428670949-17524-1-git-send-email-jtulak@redhat.com>
References: <1428670949-17524-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com
List-ID: <fstests@vger.kernel.org>

Because performance tests can take longer and are usually not needed,
they won't run together with regression tests, but has to be enabled
using -performance flag. With it, only perf tests will run.

Signed-off-by: Jan Ťulák <jtulak@redhat.com>
---
 check | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/check b/check
index c746d71..a80f69b 100755
--- a/check
+++ b/check
@@ -36,6 +36,7 @@ have_test_arg=false
 randomize=false
 export here=`pwd`
 xfile=""
+performance=false
 
 # start the initialisation work now
 iam=check
@@ -70,6 +71,7 @@ check options
     -nfs                test NFS
     -cifs               test CIFS
     -tmpfs              test TMPFS
+    -performance        performance tests
     -l			line mode diff
     -udiff		show unified diff (default)
     -n			show me, do not run tests
@@ -172,8 +174,11 @@ export_filtered_environments()
 get_group_list()
 {
 	grp=$1
-
-	for d in $SRC_GROUPS $FSTYP; do
+	tests="$SRC_GROUPS $FSTYP"
+	if $performance; then
+		tests="$SRC_GROUPS"
+	fi
+	for d in $tests; do
 		l=$(sed -n < $SRC_DIR/$d/group \
 			-e 's/#.*//' \
 			-e 's/$/ /' \
@@ -188,7 +193,11 @@ get_group_list()
 get_all_tests()
 {
 	touch $tmp.list
-	for d in $SRC_GROUPS $FSTYP; do
+	tests="$SRC_GROUPS $FSTYP"
+	if $performance; then
+		tests="$SRC_GROUPS"
+	fi
+	for d in $tests; do
 		ls $SRC_DIR/$d/* | \
 			grep -v "\..*" | \
 			grep "^$SRC_DIR/$d/$VALID_TEST_NAME"| \
@@ -291,6 +300,8 @@ while [ $# -gt 0 ]; do
 	-nfs)	FSTYP=nfs ;;
 	-cifs)	FSTYP=cifs ;;
 	-tmpfs)	FSTYP=tmpfs ;;
+	-performance)	SRC_GROUPS="performance";
+					performance=true;;
 
 	-g)	group=$2 ; shift ;
 		GROUP_LIST="$GROUP_LIST $group"
-- 
2.1.0

