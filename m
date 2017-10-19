Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45058 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753120AbdJSNsW (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 Oct 2017 09:48:22 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v9JDheGB012137
        for <fstests@vger.kernel.org>; Thu, 19 Oct 2017 09:48:21 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2dpusq6bbm-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Thu, 19 Oct 2017 09:48:21 -0400
Received: from localhost
        by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Thu, 19 Oct 2017 07:48:20 -0600
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH] overlay/038: Remove usage of _overlay_scratch_unmount
Date: Thu, 19 Oct 2017 19:19:07 +0530
Message-Id: <20171019134907.9987-1-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, amir73il@gmail.com
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, linux-unionfs@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

_overlay_scratch_unmount is not supposed to be invoked directly by
tests. Also, since unmounting scratch fs is optional, this commit
removes invocation of _overlay_scratch_unmount.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 tests/overlay/038 | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tests/overlay/038 b/tests/overlay/038
index 148995b..28c9c4e 100755
--- a/tests/overlay/038
+++ b/tests/overlay/038
@@ -185,8 +185,6 @@ parent_d=$($here/src/t_dir_type $SCRATCH_MNT/test_dir/pure_lower_dir $test_dir_s
 [[ $parent_d == ".. d" ]] || \
 	echo "Pure lower in dir which has another lower layer: Invalid d_ino reported for .."
 
-_overlay_scratch_unmount
-
 echo "Silence is golden"
 status=0
 exit
-- 
2.9.5

