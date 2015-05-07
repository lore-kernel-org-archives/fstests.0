Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-wg0-f41.google.com ([74.125.82.41]:34899 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbbEGQIw (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 7 May 2015 12:08:52 -0400
Received: by wgyo15 with SMTP id o15so48510692wgy.2
        for <fstests@vger.kernel.org>; Thu, 07 May 2015 09:08:51 -0700 (PDT)
From: Omer Zilberberg <omzg@plexistor.com>
Subject: [PATCH] _require_command: fixed typo
Date: Thu,  7 May 2015 19:08:36 +0300
Message-Id: <1431014916-1951-1-git-send-email-omzg@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Omer Zilberberg <omzg@plexistor.com>
List-ID: <fstests@vger.kernel.org>

fixes 9435b92 common: _require_command needs to handle parameters

Signed-off-by: Omer Zilberberg <omzg@plexistor.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 6ea107e..cd0f3e6 100644
--- a/common/rc
+++ b/common/rc
@@ -1299,7 +1299,7 @@ _require_command()
 	fi
 
 	_command=`echo "$1" | awk '{ print $1 }'`
-	if [ ! -x $command ]; then
+	if [ ! -x $_command ]; then
 		_notrun "$_name utility required, skipped this test"
 	fi
 }
-- 
1.9.3

