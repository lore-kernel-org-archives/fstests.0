Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750953AbeGJHdP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 10 Jul 2018 03:33:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D7871B796
        for <fstests@vger.kernel.org>; Tue, 10 Jul 2018 07:33:14 +0000 (UTC)
Received: from dhcp-12-245.nay.redhat.com (dhcp-12-245.nay.redhat.com [10.66.12.245])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DDC422156889
        for <fstests@vger.kernel.org>; Tue, 10 Jul 2018 07:33:13 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] generic/499: stop fsx from probing insert range call
Date: Tue, 10 Jul 2018 15:33:05 +0800
Message-Id: <20180710073305.23740-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On some old kernel which supports COLLAPSE_RANGE and ZERO_RANGE,
but doesn't support INSERT_RANGE, this case alway fails as:

   QA output created by 499
  +main: filesystem does not support fallocate mode FALLOC_FL_INSERT_RANGE, disabling!
   Silence is golden

fsx print one more line to break the golden image.

Due to this case don't need to do INSERT_RANGE operations, so use
-I options to prevent fsx from probing INSERT_RANGE call.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

1) I think using -I option of fsx is better than _notrun when find the system
doesn't support INSERT_RANGE.

2) Although PUCH_HOLE isn't needed either, when a system supports COLLAPSE_RANGE
and ZERO_RANGE, it supports PUCH_HOLE too. So I don't use -H option.

Thanks,
Zorro

 tests/generic/499 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/499 b/tests/generic/499
index 99d6d308..a2eac6ab 100755
--- a/tests/generic/499
+++ b/tests/generic/499
@@ -50,7 +50,7 @@ ENDL
 
 victim=$SCRATCH_MNT/a
 touch $victim
-$here/ltp/fsx --replay-ops $tmp.fsxops $victim > $tmp.output || cat $tmp.output
+$here/ltp/fsx -I --replay-ops $tmp.fsxops $victim > $tmp.output || cat $tmp.output
 
 echo "Silence is golden"
 status=0
-- 
2.14.4

