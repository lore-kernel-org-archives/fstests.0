Received: from mx1.redhat.com ([209.132.183.28]:44146 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754281AbbGWQpF (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 23 Jul 2015 12:45:05 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id D4897387D8B
	for <fstests@vger.kernel.org>; Thu, 23 Jul 2015 16:45:04 +0000 (UTC)
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH] xfstests: Allow partial test names for ./check run
Date: Thu, 23 Jul 2015 18:44:49 +0200
Message-Id: <1437669889-18403-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

When running ./check and calling a test with a name, id is enough
to find the test (names added in 03c633bf).

If the full test path is tests/xfs/123-foo-bar, then all these
invocations should work, as long as the given part of the test name
is valid and the three-digits id is here.

./check xfs/123-foo-bar
./check xfs/123-foo
./check xfs/123

Always use full test name in results.

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
 check     | 29 +++++++++++++++++++++--------
 common/rc |  3 ++-
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/check b/check
index a4ee224..4859772 100755
--- a/check
+++ b/check
@@ -563,14 +563,27 @@ for section in $HOST_OPTIONS_SECTIONS; do
 
 	    echo -n "$seqnum"
 
-	    if $showme
-	    then
-		echo
-		continue
-	    elif [ ! -f $seq ]
-	    then
-		echo " - no such test?"
-	    else
+		if $showme; then
+			echo
+			continue
+		elif [ ! -f $seq ]; then
+			# Try to get full name in case the user supplied only seq id
+			# and the test has a name. A bit of hassle to find really
+			# the test and not its sample output or helping files.
+			bname=$(basename $seq)
+			full_seq=$(find $(dirname $seq) -name $bname* -executable |
+				awk '(NR == 1 || length < length(shortest)) { shortest = $0 }\
+					END { print shortest }')
+			if [ -f $full_seq ] \
+				&& [ x$(echo $bname | grep -o "^$VALID_TEST_ID") != x ]; then
+				seq=$full_seq
+				seqnum=${full_seq#*/}
+			fi
+		fi
+
+		if [ ! -f $seq ]; then
+			echo " - no such test?"
+		else
 		# really going to try and run this one
 		#
 		rm -f $seqres.out.bad
diff --git a/common/rc b/common/rc
index 610045e..e9da39d 100644
--- a/common/rc
+++ b/common/rc
@@ -30,7 +30,8 @@ BC=$(which bc 2> /dev/null) || BC=
 #  "[[:alnum:]-]*"
 # e.g. 999-the-mark-of-fstests
 #
-VALID_TEST_NAME="[0-9]\{3\}-\?[[:alnum:]-]*"
+VALID_TEST_ID="[0-9]\{3\}"
+VALID_TEST_NAME="$VALID_TEST_ID-\?[[:alnum:]-]*"
 
 _require_math()
 {
-- 
2.4.3

