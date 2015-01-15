Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36158 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219AbbAOJbD (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 15 Jan 2015 04:31:03 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t0F9V2xG029822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Thu, 15 Jan 2015 04:31:02 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 2/3] check: check dmesg log after each test
Date: Thu, 15 Jan 2015 17:30:30 +0800
Message-Id: <1421314231-11076-3-git-send-email-eguan@redhat.com>
In-Reply-To: <1421314231-11076-1-git-send-email-eguan@redhat.com>
References: <1421314231-11076-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Check kernel BUG, WARNING etc. in dmesg log after each test and fail the
test if something is found. dmesg log can be found at result dir.

This check now depends on the logging of running tests in dmesg, so this
check can be done without clearing dmesg buffer nor dumping all dmesg to
a file, which can potentially eat all free space on testing host.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 check | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/check b/check
index 3d42a8b..0830e0c 100755
--- a/check
+++ b/check
@@ -397,6 +397,32 @@ _check_filesystems()
 	fi
 }
 
+_check_dmesg()
+{
+	if [ ! -f ${RESULT_DIR}/check_dmesg ]; then
+		return
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
+		err=true
+	else
+		rm -f $seqres.dmesg
+	fi
+}
+
+
 _prepare_test_list
 
 if $OPTIONS_HAVE_SECTIONS; then
@@ -564,6 +590,8 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		if [ -w /dev/kmsg ]; then
 			date_time=`date +"%F %T"`
 			echo "run fstests $seqnum at $date_time" > /dev/kmsg
+			# _check_dmesg depends on this log in dmesg
+			touch ${RESULT_DIR}/check_dmesg
 		fi
 		./$seq >$tmp.rawout 2>&1
 		sts=$?
@@ -630,6 +658,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		    try="$try $seqnum"
 		    n_try=`expr $n_try + 1`
 		    _check_filesystems
+		    _check_dmesg
 		fi
 
 	    fi
-- 
2.1.0

