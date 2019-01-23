Received: from mx1.redhat.com ([209.132.183.28]:55728 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726228AbfAWHfH (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 23 Jan 2019 02:35:07 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D1DB983F3D
        for <fstests@vger.kernel.org>; Wed, 23 Jan 2019 07:35:07 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.66.13.9])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0767B662EC
        for <fstests@vger.kernel.org>; Wed, 23 Jan 2019 07:35:06 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v4 2/2] common/dump: disable splice from FSSTRESS_AVOID
Date: Wed, 23 Jan 2019 15:34:55 +0800
Message-Id: <20190123073455.24539-2-zlang@redhat.com>
In-Reply-To: <20190123073455.24539-1-zlang@redhat.com>
References: <20190123073455.24539-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

New fsstress operation breaks fs dump/restore testing which use
fsstress, e.g xfs/068.

In _create_dumpdir_stress_num, disable splice in fsstress so that we
dump exactly the same set of files and directories no matter how the
xfs is configured.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

V4 only changed this patch. Ealier patch tried to change xfs/086.out,
this patche add splice into FSSTRESS_AVOID for dump/restore testing.

Thanks,
Zorro

 common/dump | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/common/dump b/common/dump
index 4d1a1607..b17771b9 100644
--- a/common/dump
+++ b/common/dump
@@ -310,6 +310,9 @@ _create_dumpdir_stress_num()
     if $FSSTRESS_PROG | grep -q copyrange; then
         FSSTRESS_AVOID="-f copyrange=0 $FSSTRESS_AVOID"
     fi
+    if $FSSTRESS_PROG | grep -q splice; then
+        FSSTRESS_AVOID="-f splice=0 $FSSTRESS_AVOID"
+    fi
 
     echo ""
     echo "-----------------------------------------------"
-- 
2.17.2
