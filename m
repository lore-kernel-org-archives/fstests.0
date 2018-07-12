Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53958 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726725AbeGLQJo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 12 Jul 2018 12:09:44 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 40653C32E
        for <fstests@vger.kernel.org>; Thu, 12 Jul 2018 15:59:34 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-95.pek2.redhat.com [10.72.12.95])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AC4E01C703
        for <fstests@vger.kernel.org>; Thu, 12 Jul 2018 15:59:32 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH] generic/062: filter redundant output by getfattr
Date: Thu, 12 Jul 2018 23:59:26 +0800
Message-Id: <20180712155926.21722-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

When getfattr dumps values of all extended attributes (-d option),
it doesn't print empty extended attributes. e.g: user.name. But
from attr-2.4.48 this behavior is changed,  new getfattr prints
user.name="".

The {=""} will break the golden image, so filter the redundant =""
at the end if it has.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

This's a bad news. Latest attr package attr-2.4.48 changed his
behavior as above. And this's different with attr-2.4.47.

With old attr:
# setfattr -h -n user.name testfile
# getfattr -d -n user.name testfile                                                                                                                                     
# file: testfile                               
user.name

With new attr:
# setfattr -h -n user.name testfile
# getfattr -d -n user.name testfile                                                                                                                                     
# file: testfile                               
user.name=""

Note: -d option is necessary

This little difference will break golden image. So this's the problem.
If you have better idea than this patch, please tell me.

Thanks,
Zorro


 tests/generic/062 | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/generic/062 b/tests/generic/062
index df67960d..4fc2dc46 100755
--- a/tests/generic/062
+++ b/tests/generic/062
@@ -29,9 +29,13 @@ _cleanup()
 }
 trap "_cleanup; exit \$status" 0 1 2 3 15
 
+# When getfattr dump values of all extended attributes, it print empty attr
+# as user.name before, but new getfattr print it as user.name="". For match
+# the golden image, filter the redundant ="" at the end.
 getfattr()
 {
-    $GETFATTR_PROG --absolute-names -dh $@ 2>&1 | _filter_scratch
+    $GETFATTR_PROG --absolute-names -dh $@ 2>&1 | _filter_scratch | \
+	sed -e 's/=\"\"//'
 }
 
 setfattr()
-- 
2.14.4

