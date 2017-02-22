Received: from mail-lf0-f66.google.com ([209.85.215.66]:35013 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754457AbdBVJsS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Feb 2017 04:48:18 -0500
Received: by mail-lf0-f66.google.com with SMTP id z127so545319lfa.2
        for <fstests@vger.kernel.org>; Wed, 22 Feb 2017 01:48:17 -0800 (PST)
From: Dmitry Monakhov <dmonakhov@openvz.org>
Subject: [PATCH] check: fix incorrect interrupt detection
Date: Wed, 22 Feb 2017 13:48:13 +0400
Message-Id: <1487756893-27717-1-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Dmitry Monakhov <dmonakhov@openvz.org>
List-ID: <fstests@vger.kernel.org>

Currently "Interrupted!" string always appeared in check.log because
flag cleared at very end after summary was dumped already.
It looks strange strange, but it was broken from very beginning 27fba05e (2001-01-15)

- update interrupt flag at the end of a section loop, but before _wrapup
- dump 'Interrupted' to stdout

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
---
 check | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/check b/check
index 5a93c94..5d7f75c 100755
--- a/check
+++ b/check
@@ -405,7 +405,7 @@ _wrapup()
 			echo "Ran:$try" >>$check.log
 		fi
 
-		$interrupt && echo "Interrupted!" >>$check.log
+		$interrupt && echo "Interrupted!" | tee -a $check.log
 
 		if [ ! -z "$notrun" ]; then
 			if [ $brief_test_summary == "false" ]; then
@@ -755,7 +755,9 @@ for section in $HOST_OPTIONS_SECTIONS; do
 
 	    seq="after_$seqnum"
 	done
+	interrupt=false
 	_wrapup
+	interrupt=true
 	echo
 
 	_test_unmount 2> /dev/null
-- 
2.9.3

