Received: from mx1.redhat.com ([209.132.183.28]:39918 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751384AbcGNMnn (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 14 Jul 2016 08:43:43 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6731C05AA49
	for <fstests@vger.kernel.org>; Thu, 14 Jul 2016 12:43:42 +0000 (UTC)
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH 3/6] xfstests: remove unused variable
Date: Thu, 14 Jul 2016 14:43:31 +0200
Message-Id: <1468500214-6237-4-git-send-email-jtulak@redhat.com>
In-Reply-To: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
References: <1468500214-6237-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

After the previous patch moved few lines of code, one seqnum assignment is now
immediately overwritten by another. Remove the useless one.

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
 check | 1 -
 1 file changed, 1 deletion(-)

diff --git a/check b/check
index ef6bd47..58d8869 100755
--- a/check
+++ b/check
@@ -554,7 +554,6 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	        if [ -f $full_seq ] \
 	            && [ x$(echo $bname | grep -o "^$VALID_TEST_ID") != x ]; then
 	            seq=$full_seq
-	            seqnum=${full_seq#*/}
 	        fi
 	    fi
 
-- 
2.5.5

