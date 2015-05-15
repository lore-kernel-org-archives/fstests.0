Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48363 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423102AbbEONgt (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 15 May 2015 09:36:49 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t4FDan7T026259
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Fri, 15 May 2015 09:36:49 -0400
Received: from plato.andrewprice.me.uk.com (ovpn-116-107.ams2.redhat.com [10.36.116.107])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id t4FDakLJ015736
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Fri, 15 May 2015 09:36:49 -0400
From: Andrew Price <anprice@redhat.com>
Subject: [PATCH 2/3] generic/group: add generic/082 to the quota group
Date: Fri, 15 May 2015 14:36:43 +0100
Message-Id: <1431697004-3032-2-git-send-email-anprice@redhat.com>
In-Reply-To: <1431697004-3032-1-git-send-email-anprice@redhat.com>
References: <1431697004-3032-1-git-send-email-anprice@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

generic/082 is a quota test so it should be in this group.

Signed-off-by: Andrew Price <anprice@redhat.com>
---
 tests/generic/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/generic/group b/tests/generic/group
index b6f4b01..e715869 100644
--- a/tests/generic/group
+++ b/tests/generic/group
@@ -84,7 +84,7 @@
 079 acl attr ioctl metadata auto quick
 080 auto quick
 081 auto quick
-082 auto quick
+082 auto quick quota
 083 rw auto enospc stress
 084 auto metadata quick
 085 auto freeze mount
-- 
2.1.0

