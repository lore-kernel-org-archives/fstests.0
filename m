Received: from mx1.redhat.com ([209.132.183.28]:34010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751746AbdJaI3z (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 31 Oct 2017 04:29:55 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] common/rc: insert a line to dmesg on intentional WARNINGs
Date: Tue, 31 Oct 2017 16:29:20 +0800
Message-Id: <20171031082920.31182-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Fengguang Wu <fengguang.wu@intel.com>, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

We already filtered out intentional WARNINGs from dmesg in
_check_dmesg(), but 3rd party dmesg parsers, e.g. LKP 0day test
robot, don't know that it's not a test failure in such cases.

So per Fengguang's request, insert a message to dmesg to indicate
that the WARNINGs in this test are intentional, external dmesg
parsers could take proper actions based on this message.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/rc | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/common/rc b/common/rc
index e2a8229f08bc..80fb47c74028 100644
--- a/common/rc
+++ b/common/rc
@@ -3295,12 +3295,21 @@ _check_dmesg()
 	# default filter is a simple cat command, caller could provide a
 	# customized filter and pass the name through the first argument, to
 	# filter out intentional WARNINGs or Oopses
-	filter=${1:-cat}
+	local filter=${1:-cat}
+	local changed=false
 
 	# search the dmesg log of last run of $seqnum for possible failures
 	# use sed \cregexpc address type, since $seqnum contains "/"
 	dmesg | tac | sed -ne "0,\#run fstests $seqnum at $date_time#p" | \
-		tac | $filter >$seqres.dmesg
+		tac >$seqres.dmesg.orig
+
+	# check if $filter filtered out intentional warnings
+	cat $seqres.dmesg.orig  | $filter > $seqres.dmesg
+	if ! diff $seqres.dmesg.orig $seqres.dmesg >/dev/null 2>&1; then
+		changed=true
+	fi
+	rm -f $seqres.dmesg.orig
+
 	egrep -q -e "kernel BUG at" \
 	     -e "WARNING:" \
 	     -e "BUG:" \
@@ -3311,13 +3320,20 @@ _check_dmesg()
 	     -e "INFO: possible circular locking dependency detected" \
 	     -e "general protection fault:" \
 	     $seqres.dmesg
+
 	if [ $? -eq 0 ]; then
 		_dump_err "_check_dmesg: something found in dmesg (see $seqres.dmesg)"
 		return 1
-	else
-		rm -f $seqres.dmesg
-		return 0
 	fi
+
+	# test passed dmesg check, then insert a PLEASE IGNORE message to dmesg
+	# if $changed is true, to let 3rd party dmesg parser, e.g. 0day test
+	# robot, know that it's not a test failure
+	if $changed; then
+		echo "fstests $seqnum: INTENTIONAL WARNINGS, PLEASE IGNORE" > /dev/kmsg
+	fi
+	rm -f $seqres.dmesg
+	return 0
 }
 
 # don't check dmesg log after test
-- 
2.13.6

