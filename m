Received: from mail-pg0-f68.google.com ([74.125.83.68]:33534 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751393AbdCACar (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Feb 2017 21:30:47 -0500
Received: by mail-pg0-f68.google.com with SMTP id x17so3950481pgi.0
        for <fstests@vger.kernel.org>; Tue, 28 Feb 2017 18:30:04 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH] common/rc: accept "localdomain" to mean YP/NIS disabled
Date: Tue, 28 Feb 2017 14:09:36 -0800
Message-Id: <20170228220936.89655-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

When asked to 'cat' the passwd or group files, currently xfstests runs
the 'domainname' program to get what the kernel thinks the domainname
is.  It seems that traditionally this has been "(none)" if YP/NIS is not
in use.  However, Android devices use a different convention which is to
set the domainname to "localdomain".  Therefore, this patch updates
xfstests to accept both conventions to indicate YP/NIS disabled.  This
stops a number of tests from failing when run on Android.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 8f233346..aa78d4b2 100644
--- a/common/rc
+++ b/common/rc
@@ -1792,7 +1792,7 @@ _yp_active()
 {
 	local dn
 	dn=$(domainname 2>/dev/null)
-	test -n "${dn}" -a "${dn}" != "(none)"
+	test -n "${dn}" -a "${dn}" != "(none)" -a "${dn}" != "localdomain"
 	echo $?
 }
 
-- 
2.11.0.483.g087da7b7c-goog

