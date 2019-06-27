Received: from mail-pf1-f194.google.com ([209.85.210.194]:34119 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfF0JC2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 27 Jun 2019 05:02:28 -0400
From: Murphy Zhou <jencce.kernel@gmail.com>
Subject: [PATCH] generic/486: filter out irrelevant attrs
Date: Thu, 27 Jun 2019 17:00:59 +0800
Message-Id: <20190627090100.18542-1-jencce.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, linux-unionfs@vger.kernel.org, miklos@szeredi.hu, Murphy Zhou <jencce.kernel@gmail.com>
List-ID: <fstests@vger.kernel.org>

In some setup, there could be extra attrs printed, like selinux.
They are breaking golden output and irrelevant for this test.
So focus on the attr we are testing on to avoid false alarm.
Print the output to .full for debug.

Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
---
 tests/generic/486 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/generic/486 b/tests/generic/486
index ff115a07..ea571efe 100755
--- a/tests/generic/486
+++ b/tests/generic/486
@@ -46,10 +46,12 @@ _scratch_mkfs >>$seqres.full 2>&1
 _scratch_mount >>$seqres.full 2>&1
 
 filter_attr_output() {
-	_filter_scratch | sed -e 's/has a [0-9]* byte value/has a NNNN byte value/g'
+	_filter_scratch | grep world | \
+		sed -e 's/has a [0-9]* byte value/has a NNNN byte value/g'
 }
 
 ./src/attr_replace_test $SCRATCH_MNT/hello
+$ATTR_PROG -l $SCRATCH_MNT/hello >>$seqres.full 2>&1
 $ATTR_PROG -l $SCRATCH_MNT/hello | filter_attr_output
 
 status=0
-- 
2.21.0
