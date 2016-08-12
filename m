Received: from mx1.redhat.com ([209.132.183.28]:34608 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751372AbcHLWq4 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 12 Aug 2016 18:46:56 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8214A81112
	for <fstests@vger.kernel.org>; Fri, 12 Aug 2016 22:46:55 +0000 (UTC)
Received: from [IPv6:::1] (ovpn03.gateway.prod.ext.phx2.redhat.com [10.5.9.3])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u7CMksd5017172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Fri, 12 Aug 2016 18:46:55 -0400
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] add prjquota to _qmount_option() filter
Message-ID: <b8fc0176-e023-42d0-717c-925999aa2ed0@redhat.com>
Date: Fri, 12 Aug 2016 17:46:54 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

_qmount_option() did not properly filter the
"prjquota" mount option along with the "pquota"
variant, as it does for the other types.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/common/quota b/common/quota
index 32777a9..d91062a 100644
--- a/common/quota
+++ b/common/quota
@@ -190,6 +190,7 @@ _qmount_option()
 		-e 's/gquota/QUOTA/g'      \
 		-e 's/grpquota/QUOTA/g'    \
 		-e 's/pquota/QUOTA/g'      \
+		-e 's/prjquota/QUOTA/g'      \
 		-e 's/quota/QUOTA/g'       \
 		-e 's/uqnoenforce/QUOTA/g' \
 		-e 's/gqnoenforce/QUOTA/g' \

