Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33670 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbbERIry (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 18 May 2015 04:47:54 -0400
Received: by wgjc11 with SMTP id c11so17819473wgj.0
        for <fstests@vger.kernel.org>; Mon, 18 May 2015 01:47:53 -0700 (PDT)
From: Omer Zilberberg <omzg@plexistor.com>
Subject: [PATCH v2] _require_command: fixed typo
Date: Mon, 18 May 2015 11:47:41 +0300
Message-Id: <1431938861-8149-1-git-send-email-omzg@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Omer Zilberberg <omzg@plexistor.com>
List-ID: <fstests@vger.kernel.org>

fixes 9435b92 common: _require_command needs to handle parameters

Also quoted $_command because _require_command may be called with an
empty $1 parameter, e.g.:
_require_command "$MY_UTIL_PROG" my_util  # but $MY_UTIL_PROG is empty

[ -x ] returns true.
[ -x "" ] returns false, as required here.

Signed-off-by: Omer Zilberberg <omzg@plexistor.com>
Reviewed-by: Eric Sandeen <sandeen@redhat.com>

v2: address Eryu's comment regarding quotation
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 6ea107e..68b07b8 100644
--- a/common/rc
+++ b/common/rc
@@ -1299,7 +1299,7 @@ _require_command()
 	fi
 
 	_command=`echo "$1" | awk '{ print $1 }'`
-	if [ ! -x $command ]; then
+	if [ ! -x "$_command" ]; then
 		_notrun "$_name utility required, skipped this test"
 	fi
 }
-- 
1.9.3

