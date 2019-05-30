Received: from mx1.redhat.com ([209.132.183.28]:51166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727201AbfE3Jl4 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 30 May 2019 05:41:56 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36DF82E95A2
        for <fstests@vger.kernel.org>; Thu, 30 May 2019 09:41:56 +0000 (UTC)
From: Murphy Zhou <xzhou@redhat.com>
Subject: [PATCH] generic/517: notrun on NFS due to unaligned dedupe in test
Date: Thu, 30 May 2019 17:41:47 +0800
Message-Id: <20190530094147.14512-1-xzhou@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Murphy Zhou <xzhou@redhat.com>
List-ID: <fstests@vger.kernel.org>

NFSv4.2 could pass _require_scratch_dedupe, since the test offset and
size are aligned, while generic/517 is performing unaligned dedupe.
NFS does not support unaligned dedupe now, returns EINVAL.

Signed-off-by: Murphy Zhou <xzhou@redhat.com>
---
 tests/generic/517 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/generic/517 b/tests/generic/517
index 601bb24e..23665782 100755
--- a/tests/generic/517
+++ b/tests/generic/517
@@ -30,6 +30,7 @@ _cleanup()
 _supported_fs generic
 _supported_os Linux
 _require_scratch_dedupe
+$FSTYP == "nfs"  && _notrun "NFS can't handle unaligned deduplication"
 
 rm -f $seqres.full
 
-- 
2.21.0
