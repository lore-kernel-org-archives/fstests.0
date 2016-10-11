Received: from mx1.redhat.com ([209.132.183.28]:51082 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752138AbcJKJmZ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 11 Oct 2016 05:42:25 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 72946793C3
        for <fstests@vger.kernel.org>; Tue, 11 Oct 2016 09:42:25 +0000 (UTC)
Received: from dhcp-12-101.nay.redhat.com (dhcp-12-101.nay.redhat.com [10.66.12.101])
        by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u9B9gNfT021097
        for <fstests@vger.kernel.org>; Tue, 11 Oct 2016 05:42:24 -0400
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] common/rc: use real device name in _sysfs_dev function
Date: Tue, 11 Oct 2016 17:42:22 +0800
Message-Id: <1476178942-27665-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

_sysfs_dev try to find the major and minor device numbers of
SCRATCH_DEV, by 'stat -c%t $SCRATCH_DEV' and 'stat -c%T
$SCRATCH_DEV'.

But if the SCRATCH_DEV is symlink (e.g: /dev/mapper/
testvg-scratchdev), stat command can't find correct device numbers.
So try to find the real name of the SCRATCH_DEV at first.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 common/rc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 7338779..821922b 100644
--- a/common/rc
+++ b/common/rc
@@ -3818,7 +3818,7 @@ _short_dev()
 
 _sysfs_dev()
 {
-	local _dev=$1
+	local _dev=`_real_dev $1`
 	local _maj=$(stat -c%t $_dev | tr [:lower:] [:upper:])
 	local _min=$(stat -c%T $_dev | tr [:lower:] [:upper:])
 	_maj=$(echo "ibase=16; $_maj" | bc)
-- 
2.7.4

