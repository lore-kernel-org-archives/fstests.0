Received: from mail-wm0-f65.google.com ([74.125.82.65]:34616 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753198AbcLHNew (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 8 Dec 2016 08:34:52 -0500
Received: by mail-wm0-f65.google.com with SMTP id g23so3627194wme.1
        for <fstests@vger.kernel.org>; Thu, 08 Dec 2016 05:34:51 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] common: fix excluding test groups
Date: Thu,  8 Dec 2016 15:34:30 +0200
Message-Id: <1481204070-10881-1-git-send-email-amir73il@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

The -x flag is used to exclude tests that belong to
certain groups from the test args list.

When the test args list is expressed as a match pattern,
-x fails to exclude the tests that match the pattern
and belong to excluded groups.

For example:
$ ./check -n -x xfs/??? | wc -l
341
$ ./check -n -x fuzzers,dangerous_fuzzers xfs/??? | wc -l
341

After the fix:
$ ./check -n -x fuzzers,dangerous_fuzzers xfs/??? | wc -l
315

This bug seems to date back to this git repo epoc.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 check | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/check b/check
index 8f2a1bb..9732460 100755
--- a/check
+++ b/check
@@ -158,11 +158,14 @@ _timestamp()
 _prepare_test_list()
 {
 	unset list
+	touch $tmp.list
 	# Tests specified on the command line
 	if [ -s $tmp.arglist ]; then
-		cat $tmp.arglist > $tmp.list
-	else
-		touch $tmp.list
+		# flatten multi tests line (tests/$fs/???) to 1 test per line
+		list=$(cat $tmp.arglist)
+		for t in $list; do
+			echo "$t" >> $tmp.list
+		done
 	fi
 
 	# Specified groups to include
-- 
2.7.4

