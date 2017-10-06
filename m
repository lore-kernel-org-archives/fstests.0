Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50216 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753343AbdJFJ2t (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 6 Oct 2017 05:28:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v969OQ3i018857
        for <fstests@vger.kernel.org>; Fri, 6 Oct 2017 05:28:48 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2de6q41h7v-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <fstests@vger.kernel.org>; Fri, 06 Oct 2017 05:28:48 -0400
Received: from localhost
        by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <fstests@vger.kernel.org> from <chandan@linux.vnet.ibm.com>;
        Fri, 6 Oct 2017 05:28:47 -0400
From: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Subject: [PATCH] overlay/038: Remove af_unix program requirement
Date: Fri,  6 Oct 2017 14:59:33 +0530
Message-Id: <20171006092933.15642-1-chandan@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org, amir73il@gmail.com
Cc: Chandan Rajendra <chandan@linux.vnet.ibm.com>, linux-unionfs@vger.kernel.org, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

overlay/038 does not use src/af_unix program. This commit removes the
corresponding _require_test_program statement.

Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
---
 tests/overlay/038 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/overlay/038 b/tests/overlay/038
index 69fd76a..6079b95 100755
--- a/tests/overlay/038
+++ b/tests/overlay/038
@@ -48,7 +48,6 @@ _supported_fs overlay
 _supported_os Linux
 _require_scratch
 _require_attrs
-_require_test_program "af_unix"
 _require_test_program "t_dir_type"
 
 rm -f $seqres.full
-- 
2.9.5

