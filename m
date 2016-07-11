Received: from mx1.redhat.com ([209.132.183.28]:47386 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968AbcGKJ0S (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 11 Jul 2016 05:26:18 -0400
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH 2/4] fstests: filename handling for extended names in ./check was on a wrong place
Date: Mon, 11 Jul 2016 11:26:07 +0200
Message-Id: <1468229169-24045-3-git-send-email-jtulak@redhat.com>
In-Reply-To: <1468229169-24045-1-git-send-email-jtulak@redhat.com>
References: <1468229169-24045-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, eguan@redhat.com, Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

The code handling "./check foo/123", when the real test is "foo/123-bar-baz"
was moved at the earliest position, so everything working with the test name or
path will know the full name. Thus, no "123" and "123-bar-baz" mix is possible.

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
 check | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/check b/check
index 5be183f..ef6bd47 100755
--- a/check
+++ b/check
@@ -543,6 +543,20 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	for seq in $list
 	do
 	    err=false
+	    if [ ! -f $seq ]; then
+	        # Try to get full name in case the user supplied only seq id
+	        # and the test has a name. A bit of hassle to find really
+	        # the test and not its sample output or helping files.
+	        bname=$(basename $seq)
+	        full_seq=$(find $(dirname $seq) -name $bname* -executable |
+	            awk '(NR == 1 || length < length(shortest)) { shortest = $0 }\
+	            	END { print shortest }')
+	        if [ -f $full_seq ] \
+	            && [ x$(echo $bname | grep -o "^$VALID_TEST_ID") != x ]; then
+	            seq=$full_seq
+	            seqnum=${full_seq#*/}
+	        fi
+	    fi
 
 	    # the filename for the test and the name output are different.
 	    # we don't include the tests/ directory in the name output.
@@ -566,19 +580,6 @@ for section in $HOST_OPTIONS_SECTIONS; do
 		if $showme; then
 			echo
 			continue
-		elif [ ! -f $seq ]; then
-			# Try to get full name in case the user supplied only seq id
-			# and the test has a name. A bit of hassle to find really
-			# the test and not its sample output or helping files.
-			bname=$(basename $seq)
-			full_seq=$(find $(dirname $seq) -name $bname* -executable |
-				awk '(NR == 1 || length < length(shortest)) { shortest = $0 }\
-					END { print shortest }')
-			if [ -f $full_seq ] \
-				&& [ x$(echo $bname | grep -o "^$VALID_TEST_ID") != x ]; then
-				seq=$full_seq
-				seqnum=${full_seq#*/}
-			fi
 		fi
 
 		if [ ! -f $seq ]; then
-- 
2.5.5

