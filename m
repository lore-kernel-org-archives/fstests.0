Return-Path: <fstests-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37072 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751570AbbAOJbJ (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 15 Jan 2015 04:31:09 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id t0F9V9vg009502
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <fstests@vger.kernel.org>; Thu, 15 Jan 2015 04:31:09 -0500
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH 3/3] common: add _disable_dmesg_check function
Date: Thu, 15 Jan 2015 17:30:31 +0800
Message-Id: <1421314231-11076-4-git-send-email-eguan@redhat.com>
In-Reply-To: <1421314231-11076-1-git-send-email-eguan@redhat.com>
References: <1421314231-11076-1-git-send-email-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Introduce _disable_dmesg_check function, which can be called by tests
that generate WARNINGs etc. on purpose, so the tests won't fail
_dmesg_check.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 common/rc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/common/rc b/common/rc
index 5ce3322..edd22bf 100644
--- a/common/rc
+++ b/common/rc
@@ -2805,6 +2805,12 @@ _get_device_size()
 	grep `_short_dev $1` /proc/partitions | awk '{print $3}'
 }
 
+# don't check dmesg log after test
+_disable_dmesg_check()
+{
+	rm -f ${RESULT_DIR}/check_dmesg
+}
+
 init_rc()
 {
 	if [ "$iam" == new ]
-- 
2.1.0

