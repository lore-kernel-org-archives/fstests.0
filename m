Received: from mx1.redhat.com ([209.132.183.28]:43762 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753246AbbFSJsW (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 19 Jun 2015 05:48:22 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 60FDE38887D
	for <fstests@vger.kernel.org>; Fri, 19 Jun 2015 09:48:22 +0000 (UTC)
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 1/3] fstests: move _check_dmesg to common/rc
Date: Fri, 19 Jun 2015 17:33:37 +0800
Message-Id: <1434706419-5589-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Move _check_dmesg to common/rc so that tests could call it directly.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 check     | 32 +++-----------------------------
 common/rc | 27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 29 deletions(-)

diff --git a/check b/check
index a300130..866b706 100755
--- a/check
+++ b/check
@@ -396,32 +396,6 @@ _check_filesystems()
 	fi
 }
 
-_check_dmesg()
-{
-	if [ ! -f ${RESULT_DIR}/check_dmesg ]; then
-		return
-	fi
-	rm -f ${RESULT_DIR}/check_dmesg
-
-	# search the dmesg log of last run of $seqnum for possible failures
-	# use sed \cregexpc address type, since $seqnum contains "/"
-	dmesg | tac | sed -ne "0,\#run fstests $seqnum at $date_time#p" | \
-		tac >$seqres.dmesg
-	grep -q -e "kernel BUG at" \
-	     -e "WARNING:" \
-	     -e "BUG:" \
-	     -e "Oops:" \
-	     -e "possible recursive locking detected" \
-	     $seqres.dmesg
-	if [ $? -eq 0 ]; then
-		echo "_check_dmesg: something found in dmesg (see $seqres.dmesg)"
-		err=true
-	else
-		rm -f $seqres.dmesg
-	fi
-}
-
-
 _prepare_test_list
 
 if $OPTIONS_HAVE_SECTIONS; then
@@ -542,7 +516,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 
 	    # the filename for the test and the name output are different.
 	    # we don't include the tests/ directory in the name output.
-	    seqnum=`echo $seq | sed -e "s;$SRC_DIR/;;"`
+	    export seqnum=`echo $seq | sed -e "s;$SRC_DIR/;;"`
 
 	    # Similarly, the result directory needs to replace the tests/
 	    # part of the test location.
@@ -593,7 +567,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		[ ! -x $seq ] && chmod u+x $seq # ensure we can run it
 		$LOGGER_PROG "run xfstest $seqnum"
 		if [ -w /dev/kmsg ]; then
-			date_time=`date +"%F %T"`
+			export date_time=`date +"%F %T"`
 			echo "run fstests $seqnum at $date_time" > /dev/kmsg
 			# _check_dmesg depends on this log in dmesg
 			touch ${RESULT_DIR}/check_dmesg
@@ -663,7 +637,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		    try="$try $seqnum"
 		    n_try=`expr $n_try + 1`
 		    _check_filesystems
-		    _check_dmesg
+		    _check_dmesg || err=true
 		fi
 
 	    fi
diff --git a/common/rc b/common/rc
index 610045e..141ab5c 100644
--- a/common/rc
+++ b/common/rc
@@ -2936,6 +2936,33 @@ _get_device_size()
 	grep `_short_dev $1` /proc/partitions | awk '{print $3}'
 }
 
+# check dmesg log for WARNING/Oops/etc.
+_check_dmesg()
+{
+	if [ ! -f ${RESULT_DIR}/check_dmesg ]; then
+		return 0
+	fi
+	rm -f ${RESULT_DIR}/check_dmesg
+
+	# search the dmesg log of last run of $seqnum for possible failures
+	# use sed \cregexpc address type, since $seqnum contains "/"
+	dmesg | tac | sed -ne "0,\#run fstests $seqnum at $date_time#p" | \
+		tac >$seqres.dmesg
+	grep -q -e "kernel BUG at" \
+	     -e "WARNING:" \
+	     -e "BUG:" \
+	     -e "Oops:" \
+	     -e "possible recursive locking detected" \
+	     $seqres.dmesg
+	if [ $? -eq 0 ]; then
+		echo "_check_dmesg: something found in dmesg (see $seqres.dmesg)"
+		return 1
+	else
+		rm -f $seqres.dmesg
+		return 0
+	fi
+}
+
 # don't check dmesg log after test
 _disable_dmesg_check()
 {
-- 
1.8.3.1

