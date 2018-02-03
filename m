Received: from mx1.redhat.com ([209.132.183.28]:41840 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752838AbeBCS5j (ORCPT <rfc822;fstests@vger.kernel.org>);
        Sat, 3 Feb 2018 13:57:39 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E2FC883F44
        for <fstests@vger.kernel.org>; Sat,  3 Feb 2018 18:57:39 +0000 (UTC)
From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH 1/3] check: Fix exit status
Date: Sat,  3 Feb 2018 19:57:35 +0100
Message-Id: <20180203185737.21025-1-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>
List-ID: <fstests@vger.kernel.org>

Exit with status 1 if there were any failures: using the number of
failed tests as the exit status makes no sense and can easily overwrap.

In addition, clean up a few minor things.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
---
 check | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/check b/check
index 58a2f5cc..546683c5 100755
--- a/check
+++ b/check
@@ -194,6 +194,7 @@ trim_test_list()
 	done
 	grep -v -f $tmp.grep <$tmp.list >$tmp.tmp
 	mv $tmp.tmp $tmp.list
+	rm -f $tmp.grep
 }
 
 
@@ -250,7 +251,7 @@ _prepare_test_list()
 
 	# sort the list of tests into numeric order
 	list=`sort -n $tmp.list | uniq`
-	rm -f $tmp.list $tmp.tmp $tmp.grep
+	rm -f $tmp.list
 
 	if $randomize
 	then
@@ -803,7 +804,6 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	    then
 		bad="$bad $seqnum"
 		n_bad=`expr $n_bad + 1`
-		quick=false
 		tc_status="fail"
 	    fi
 	    if $do_report; then
@@ -822,5 +822,5 @@ for section in $HOST_OPTIONS_SECTIONS; do
 done
 
 interrupt=false
-status=`expr $sum_bad`
+status=`expr $sum_bad != 0`
 exit
-- 
2.14.3

