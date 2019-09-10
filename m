Received: from mx1.redhat.com ([209.132.183.28]:33002 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726849AbfIJLgS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 10 Sep 2019 07:36:18 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3B93030860C7
        for <fstests@vger.kernel.org>; Tue, 10 Sep 2019 11:36:18 +0000 (UTC)
Received: from dhcp-12-171.nay.redhat.com (dhcp-12-171.nay.redhat.com [10.66.12.171])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6D7151001948
        for <fstests@vger.kernel.org>; Tue, 10 Sep 2019 11:36:17 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] generic/566: use _require_xfs_quota_foreign to replace the hard -f option
Date: Tue, 10 Sep 2019 19:36:11 +0800
Message-Id: <20190910113611.31247-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

xfstests should decide if xfs_quota need the -f option by
_require_xfs_quota_foreign, not write the -f option after
$XFS_QUOTA_PROG manually. The later way will cause unexpected
error on an old system which xfsprogs doesn't support the -f option.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 tests/generic/566 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/generic/566 b/tests/generic/566
index e8491e54..fb239a00 100755
--- a/tests/generic/566
+++ b/tests/generic/566
@@ -34,6 +34,7 @@ _supported_os Linux
 _supported_fs generic
 _require_scratch
 _require_quota
+_require_xfs_quota_foreign
 _require_user
 
 rm -f $seqres.full
@@ -45,7 +46,7 @@ _qmount
 dir="$SCRATCH_MNT/dummy"
 mkdir -p $dir
 chown $qa_user $dir
-$XFS_QUOTA_PROG -x -f -c "limit -g bsoft=100k bhard=100k $qa_user" $SCRATCH_MNT
+$XFS_QUOTA_PROG -x -c "limit -g bsoft=100k bhard=100k $qa_user" $SCRATCH_MNT
 
 $XFS_IO_PROG -f -c 'pwrite -S 0x58 0 1m' $dir/foo >> $seqres.full
 chown $qa_user "${dir}/foo"
-- 
2.20.1
