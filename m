Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49172 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753801AbeFLGJM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 12 Jun 2018 02:09:12 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3C8E0401EF07
        for <fstests@vger.kernel.org>; Tue, 12 Jun 2018 06:09:12 +0000 (UTC)
Received: from dhcp-12-229.nay.redhat.com (unknown [10.66.12.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 52F081134CA8
        for <fstests@vger.kernel.org>; Tue, 12 Jun 2018 06:09:11 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] common: improve regex in _check_dmesg
Date: Tue, 12 Jun 2018 14:09:06 +0800
Message-Id: <20180612060906.17078-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

A dmesg output as below cause all cases fail:

[  508.002072] EDAC DEBUG: ie31200_check: MC0

Due to it matches `egrep -e "BUG:"` in _check_dmesg. But it's not
a real BUG output, so use "\bBUG:" to avoid this mistake.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index b595a6e0..1945066c 100644
--- a/common/rc
+++ b/common/rc
@@ -3460,7 +3460,7 @@ _check_dmesg()
 	_dmesg_since_test_start | $filter >$seqres.dmesg
 	egrep -q -e "kernel BUG at" \
 	     -e "WARNING:" \
-	     -e "BUG:" \
+	     -e "\bBUG:" \
 	     -e "Oops:" \
 	     -e "possible recursive locking detected" \
 	     -e "Internal error" \
-- 
2.14.4

