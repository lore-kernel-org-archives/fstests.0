Received: from mx2.suse.de ([195.135.220.15]:33502 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728086AbeJLTXP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 12 Oct 2018 15:23:15 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id EA180AEB9
        for <fstests@vger.kernel.org>; Fri, 12 Oct 2018 11:51:08 +0000 (UTC)
From: Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH] common/rc: fix check for yp
Date: Fri, 12 Oct 2018 13:50:55 +0200
Message-Id: <20181012115055.15416-1-jthumshirn@suse.de>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Johannes Thumshirn <jthumshirn@suse.de>
List-ID: <fstests@vger.kernel.org>

Only testing if a domainname is set and ypcat is installed is not a
sufficient criteria to check if NIS is actually active.

Check for a running ypbind in rpcinfo as well.

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 common/rc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index d5bb1feee2c3..1882f970a508 100644
--- a/common/rc
+++ b/common/rc
@@ -1988,7 +1988,9 @@ _yp_active()
 	local dn
 	dn=$(domainname 2>/dev/null)
 	local ypcat=$(type -P ypcat)
-	test -n "${dn}" -a "${dn}" != "(none)" -a "${dn}" != "localdomain" -a -n "${ypcat}"
+	local rpcinfo=$(type -P rpcinfo)
+	test -n "${dn}" -a "${dn}" != "(none)" -a "${dn}" != "localdomain" -a -n "${ypcat}" -a -n "${rpcinfo}" && \
+		"${rpcinfo}" -p localhost 2>/dev/null | grep -q ypbind
 	echo $?
 }
 
-- 
2.16.4
