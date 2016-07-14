Received: from mx1.redhat.com ([209.132.183.28]:40096 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751426AbcGNMnw (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 Jul 2016 08:43:52 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F52EC02C6BA
	for <fstests@vger.kernel.org>; Thu, 14 Jul 2016 12:43:41 +0000 (UTC)
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH 2/6] fstests: filename handling for extended names in ./check was on a wrong place
Date: Thu, 14 Jul 2016 14:43:30 +0200
Message-Id: <1468500214-6237-3-git-send-email-jtulak@redhat.com>
In-Reply-To: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
References: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

The code handling "./check foo/123", when the real test is "foo/123-bar-baz"
was moved to the earliest position, so everything working with the test name or
path will know the full name. Thus, no "123" and "123-bar-baz" mix is possible.

An example of this issue is $testname.notrun file. When _notrun "foo" was run
during ./check foo/$name command, it created $name.notrun. But few lines later,
it wanted $fullname.notrun. So if you did ./check foo/999, but the file was
999-bar-baz, then you got comparing outputs (and most likely a fail) instead of
a skip.

Another example of this mix is in xfstests output:
./check xfs/999
[...]
xfs/999 0s ... 0s
Ran: xfs/999-test-case

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
UPDATE:
Just more explanation in the commit message.

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

