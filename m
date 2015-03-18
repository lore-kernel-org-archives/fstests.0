Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55472 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754670AbbCRSLa (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 18 Mar 2015 14:11:30 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t2IIBTjV000409
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Wed, 18 Mar 2015 14:11:29 -0400
From: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
Subject: [PATCH 3/6] new: environments - add option for skipping output diff from a test
Date: Wed, 18 Mar 2015 19:10:27 +0100
Message-Id: <1426702230-22085-4-git-send-email-jtulak@redhat.com>
In-Reply-To: <1426702230-22085-1-git-send-email-jtulak@redhat.com>
References: <1426702230-22085-1-git-send-email-jtulak@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: =?UTF-8?q?Jan=20=C5=A4ul=C3=A1k?= <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

The performance tests has no "right" output for diff.
Thus, this patch allows tests to opt-out of output diffs and to
have their full output always saved into the results directory.

Changes are both in check script and common/rc.

Signed-off-by: Jan Ťulák <jtulak@redhat.com>
---
 check     | 20 ++++++++++++++++++--
 common/rc | 16 ++++++++++++++++
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/check b/check
index fc95d06..39a9d05 100755
--- a/check
+++ b/check
@@ -714,12 +714,21 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		    cat $seqres.notrun
 		    notrun="$notrun $seqnum"
 		else
+		    # Check for diff skip.
+		    # Some tests, like performance ones, has no "right" output,
+		    # so there is no reason to diff it. It is saved instead.
+		    skip_diff=false
+		    if [ -f $seqres.no_output_check ];then
+		        skip_diff=true
+		        rm $seqres.no_output_check
+		    fi
+
 		    if [ $sts -ne 0 ]
 		    then
 			echo -n " [failed, exit status $sts]"
 			err=true
 		    fi
-		    if [ ! -f $seq.out ]
+		    if [ ! -f $seq.out -a $skip_diff = false ]
 		    then
 			echo " - no qualified output"
 			err=true
@@ -728,7 +737,8 @@ for section in $HOST_OPTIONS_SECTIONS; do
 			# coreutils 8.16+ changed quote formats in error messages from
 			# `foo' to 'foo'. Filter old versions to match the new version.
 			sed -i "s/\`/\'/g" $tmp.out
-			if diff $seq.out $tmp.out >/dev/null 2>&1
+			if (test $skip_diff = true) \
+				|| diff $seq.out $tmp.out >/dev/null 2>&1
 			then
 			    if $err
 			    then
@@ -737,6 +747,12 @@ for section in $HOST_OPTIONS_SECTIONS; do
 				echo "$seqnum `expr $stop - $start`" >>$tmp.time
 				echo -n " `expr $stop - $start`s"
 			    fi
+			    # if diff was skipped, we want to have the output saved
+			    if test $skip_diff = true
+			    then
+			        mv $tmp.out $seqres.out
+			        echo -n " Output saved per request of the test."
+			    fi
 			    echo ""
 			else
 			    echo " - output mismatch (see $seqres.out.bad)"
diff --git a/common/rc b/common/rc
index 7f786f4..ef32da8 100644
--- a/common/rc
+++ b/common/rc
@@ -75,6 +75,22 @@ _get_lists_intersect()
 	echo $intersect
 }
 
+# Tell the check script that it should not check output
+# of a test, but should always save it.
+#
+_disable_output_check()
+{
+	touch $seqres.no_output_check
+}
+
+# Tell the check script that it should check output
+# of a test. Revert the effect of "_disable_output_check()" call.
+#
+_enable_output_check()
+{
+	rm $seqres.no_output_check
+}
+
 dd()
 {
    if [ "$HOSTOS" == "Linux" ]
-- 
2.1.0

