Received: from mail-pg0-f67.google.com ([74.125.83.67]:33455 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752375AbdEDA5s (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 May 2017 20:57:48 -0400
Received: by mail-pg0-f67.google.com with SMTP id s62so808922pgc.0
        for <fstests@vger.kernel.org>; Wed, 03 May 2017 17:57:48 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] check: catch updated suspicious RCU usage message in _check_dmesg()
Date: Wed,  3 May 2017 17:57:30 -0700
Message-Id: <20170504005730.29862-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

In the v4.11 kernel, the suspicious RCU usage message uses the word
"ERR" rather than "INFO".  Update _check_dmesg to accept both versions.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 common/rc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 8dafd4bc..257b1903 100644
--- a/common/rc
+++ b/common/rc
@@ -3285,13 +3285,13 @@ _check_dmesg()
 	# use sed \cregexpc address type, since $seqnum contains "/"
 	dmesg | tac | sed -ne "0,\#run fstests $seqnum at $date_time#p" | \
 		tac | $filter >$seqres.dmesg
-	grep -q -e "kernel BUG at" \
+	egrep -q -e "kernel BUG at" \
 	     -e "WARNING:" \
 	     -e "BUG:" \
 	     -e "Oops:" \
 	     -e "possible recursive locking detected" \
 	     -e "Internal error" \
-	     -e "INFO: suspicious RCU usage" \
+	     -e "(INFO|ERR): suspicious RCU usage" \
 	     -e "INFO: possible circular locking dependency detected" \
 	     -e "general protection fault:" \
 	     $seqres.dmesg
-- 
2.13.0.rc1.294.g07d810a77f-goog

