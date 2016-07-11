Received: from mx1.redhat.com ([209.132.183.28]:47390 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968AbcGKJ0U (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 11 Jul 2016 05:26:20 -0400
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH 3/4] xfstests: remove unused variable
Date: Mon, 11 Jul 2016 11:26:08 +0200
Message-Id: <1468229169-24045-4-git-send-email-jtulak@redhat.com>
In-Reply-To: <1468229169-24045-1-git-send-email-jtulak@redhat.com>
References: <1468229169-24045-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, eguan@redhat.com, Jan Tulak <jtulak@redhat.com>
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

