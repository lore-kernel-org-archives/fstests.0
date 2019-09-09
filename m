Received: from mail.cn.fujitsu.com ([183.91.158.132]:60684 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726341AbfIKDoA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 10 Sep 2019 23:44:00 -0400
Received: from G08CNEXCHPEKD02.g08.fujitsu.local (unknown [10.167.33.83])
        by cn.fujitsu.com (Postfix) with ESMTP id 899014CE030A
        for <fstests@vger.kernel.org>; Wed, 11 Sep 2019 11:43:46 +0800 (CST)
From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH v2] generic/566: use _require_xfs_quota_foreign and remove -f option
Date: Tue, 10 Sep 2019 06:11:43 +0800
Message-ID: <1568067103-17616-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
In-Reply-To: <20190910042851.ybwqgmh2a4xue3f4@XZHOUW.usersys.redhat.com>
References: <20190910042851.ybwqgmh2a4xue3f4@XZHOUW.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

xfstests should decide if xfs_quota needs the -f option by _require_xfs_quota_foreign,
not write the -f option after $XFS_QUOTA_PROG manually. The later way will cause
unexpected error on an old system which xfsprogs doesn't support the -f option.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Tested-by: Murphy Zhou <jencce.kernel@gmail.com>
Acked-by: Murphy Zhou <jencce.kernel@gmail.com>
Acked-by: Zorro Lang <zlang@redhat.com>
---
 tests/generic/566 | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/generic/566 b/tests/generic/566
index e8491e54..44f71cce 100755
--- a/tests/generic/566
+++ b/tests/generic/566
@@ -34,6 +34,7 @@ _supported_os Linux
 _supported_fs generic
 _require_scratch
 _require_quota
+_require_xfs_quota_foreign
 _require_user
 
 rm -f $seqres.full
@@ -45,13 +46,13 @@ _qmount
 dir="$SCRATCH_MNT/dummy"
 mkdir -p $dir
 chown $qa_user $dir
-$XFS_QUOTA_PROG -x -f -c "limit -g bsoft=100k bhard=100k $qa_user" $SCRATCH_MNT
+$XFS_QUOTA_PROG -x -c "limit -g bsoft=100k bhard=100k $qa_user" $SCRATCH_MNT
 
 $XFS_IO_PROG -f -c 'pwrite -S 0x58 0 1m' $dir/foo >> $seqres.full
 chown $qa_user "${dir}/foo"
 _user_do "chgrp $qa_user ${dir}/foo" 2>&1 | _filter_scratch
 ls -la ${dir} >> $seqres.full
-$XFS_QUOTA_PROG -x -f -c 'report -hag' $SCRATCH_MNT >> $seqres.full
+$XFS_QUOTA_PROG -x -c 'report -hag' $SCRATCH_MNT >> $seqres.full
 
 # success, all done
 status=0
-- 
2.18.1
