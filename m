Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44544 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933057AbeGFPhj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 6 Jul 2018 11:37:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A89693466F
        for <fstests@vger.kernel.org>; Fri,  6 Jul 2018 15:37:38 +0000 (UTC)
Received: from coeurl.usersys.redhat.com (ovpn-120-167.rdu2.redhat.com [10.10.120.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9CE122026D68
        for <fstests@vger.kernel.org>; Fri,  6 Jul 2018 15:37:38 +0000 (UTC)
From: Scott Mayhew <smayhew@redhat.com>
Subject: [PATCH] nfs/001: ignore the header in nfs4_getfacl output
Date: Fri,  6 Jul 2018 11:37:38 -0400
Message-Id: <20180706153738.958-1-smayhew@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

nfs4-acl-tools commit 6630629bb661 ("nfs4_getfacl: Add support to
accept more paths") added a header to the nfs4_getfacl output.  Make
sure the test is only counting the number of ACEs.

Signed-off-by: Scott Mayhew <smayhew@redhat.com>
---
 tests/nfs/001 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/nfs/001 b/tests/nfs/001
index d7a79cb0..23d5c98c 100755
--- a/tests/nfs/001
+++ b/tests/nfs/001
@@ -55,7 +55,7 @@ $NFS4_SETFACL_PROG -S $acltest.list $acltest.file
 
 # Dump ACL, expect correct number of ACE entries
 $NFS4_GETFACL_PROG $acltest.file >>$seqres.full 2>&1
-$NFS4_GETFACL_PROG $acltest.file | wc -l
+$NFS4_GETFACL_PROG $acltest.file | grep -c "^A"
 
 # success, all done
 status=0
-- 
2.14.4

