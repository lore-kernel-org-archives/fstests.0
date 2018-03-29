Received: from mx1.redhat.com ([209.132.183.28]:44056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750979AbeC2P12 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 29 Mar 2018 11:27:28 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6098095657
        for <fstests@vger.kernel.org>; Thu, 29 Mar 2018 15:27:28 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH] common/rc: improve checks for YP/NIS
Date: Thu, 29 Mar 2018 11:27:25 -0400
Message-Id: <034cdb8e88cf9b333843da73f361b7cfbbcb5f66.1522336962.git.bcodding@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: smayhew@redhat.com
List-ID: <fstests@vger.kernel.org>

At the 2018 spring NFS BAT, we have a number of systems that return a valid
string from `domainaname`, but don't have the ypcat binary.  If we don't have
the yp-tools package installed, we're not going to be able to use ypcat, so
check for it and bail out.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 common/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 931767498f62..1b52fb3609c1 100644
--- a/common/rc
+++ b/common/rc
@@ -2023,7 +2023,8 @@ _yp_active()
 {
 	local dn
 	dn=$(domainname 2>/dev/null)
-	test -n "${dn}" -a "${dn}" != "(none)" -a "${dn}" != "localdomain"
+	ypcat=$(type -P ypcat)
+	test -n "${dn}" -a "${dn}" != "(none)" -a "${dn}" != "localdomain" -a -n "${ypcat}"
 	echo $?
 }
 
-- 
2.9.3

