Received: from mx1.redhat.com ([209.132.183.28]:50728 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752968AbcGKJ0V (ORCPT <rfc822;fstests@vger.kernel.org>);
	Mon, 11 Jul 2016 05:26:21 -0400
From: Jan Tulak <jtulak@redhat.com>
Subject: [PATCH 4/4] xfstests: filename handling - fix early wildcard expansion
Date: Mon, 11 Jul 2016 11:26:09 +0200
Message-Id: <1468229169-24045-5-git-send-email-jtulak@redhat.com>
In-Reply-To: <1468229169-24045-1-git-send-email-jtulak@redhat.com>
References: <1468229169-24045-1-git-send-email-jtulak@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: david@fromorbit.com, eguan@redhat.com, Jan Tulak <jtulak@redhat.com>
List-ID: <fstests@vger.kernel.org>

Add quotation marks around the wildcarded name.

Signed-off-by: Jan Tulak <jtulak@redhat.com>
---
 check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/check b/check
index 58d8869..5ff897b 100755
--- a/check
+++ b/check
@@ -548,7 +548,7 @@ for section in $HOST_OPTIONS_SECTIONS; do
 	        # and the test has a name. A bit of hassle to find really
 	        # the test and not its sample output or helping files.
 	        bname=$(basename $seq)
-	        full_seq=$(find $(dirname $seq) -name $bname* -executable |
+	        full_seq=$(find $(dirname $seq) -name "$bname*" -executable |
 	            awk '(NR == 1 || length < length(shortest)) { shortest = $0 }\
 	            	END { print shortest }')
 	        if [ -f $full_seq ] \
-- 
2.5.5

