Received: from mx1.redhat.com ([209.132.183.28]:54516 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751297AbcESVMY (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 19 May 2016 17:12:24 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 24ACE10B84A
	for <fstests@vger.kernel.org>; Thu, 19 May 2016 21:12:23 +0000 (UTC)
Received: from [IPv6:::1] (ovpn03.gateway.prod.ext.phx2.redhat.com [10.5.9.3])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u4JLCMb1032753
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Thu, 19 May 2016 17:12:22 -0400
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] exclude dmerror tests with mount -o dax
Message-ID: <b8729f80-6d09-6c57-1fb7-4303558fc9a3@redhat.com>
Date: Thu, 19 May 2016 16:12:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Same as we do for dm flakey.  dm can't do dax.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/common/dmerror b/common/dmerror
index 004530d..42c075e 100644
--- a/common/dmerror
+++ b/common/dmerror
@@ -18,6 +18,11 @@
 #
 # common functions for setting up and tearing down a dmerror device
 
+echo $MOUNT_OPTIONS | grep -q dax
+if [ $? -eq 0 ]; then
+	_notrun "Cannot run tests with DAX on dmerror devices"
+fi
+
 _dmerror_init()
 {
 	local dm_backing_dev=$SCRATCH_DEV
