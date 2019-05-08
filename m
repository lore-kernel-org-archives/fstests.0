Received: from mx1.redhat.com ([209.132.183.28]:36196 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726371AbfEHDLv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 7 May 2019 23:11:51 -0400
From: Murphy Zhou <xzhou@redhat.com>
Subject: [PATCH] generic/532: do not break golden silence if attributes_mask is 0
Date: Wed,  8 May 2019 11:11:44 +0800
Message-Id: <20190508031144.17895-1-xzhou@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: darrick.wong@oracle.com, Murphy Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

If the filesystem does not support STATX_ATTR, like NFS, setting
both attributes and attributes_mask to 0 seems the right thing to
do. attributes_mask can be 0 only if attributes is also 0.
This situation is covered by the "&" check in the next line.

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 tests/generic/532 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/generic/532 b/tests/generic/532
index ac8b7a89..3f8afa4a 100755
--- a/tests/generic/532
+++ b/tests/generic/532
@@ -44,7 +44,6 @@ check_statx_attributes()
 	echo "MASK:$mask:ATTRS:$attrs:" >> $seqres.full
 
 	test -z "$mask" && _notrun "xfs_io statx command does not support attributes_mask"
-	test $(( mask )) -eq 0 && echo "attributes mask is zero"
 	test $(( attrs & ~(mask) )) -ne 0 && echo "attributes $attrs do not appear in mask $mask"
 }
 
-- 
2.21.0
