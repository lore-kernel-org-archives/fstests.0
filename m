Received: from mx1.redhat.com ([209.132.183.28]:59929 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754231AbbLDUyM (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 4 Dec 2015 15:54:12 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id D4EDE4C50D
	for <fstests@vger.kernel.org>; Fri,  4 Dec 2015 20:54:11 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tB4KsARg004682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Fri, 4 Dec 2015 15:54:11 -0500
From: Jeff Moyer <jmoyer@redhat.com>
Subject: [patch, v2] dmflakey: don't run for dax mounts
Date: Fri, 04 Dec 2015 15:54:10 -0500
Message-ID: <x49io4e3pfx.fsf@segfault.boston.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi,

There is no sense running dmflakey tests with the dax mount option,
since dmflakey doesn't support it.  Mark these as _notrun so that it is
clear that this type of testing is not happenning for dax.

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

diff --git a/common/dmflakey b/common/dmflakey
index dec85c1..5a45d14 100644
--- a/common/dmflakey
+++ b/common/dmflakey
@@ -21,6 +21,11 @@
 FLAKEY_ALLOW_WRITES=0
 FLAKEY_DROP_WRITES=1
 
+echo $MOUNT_OPTIONS | grep -q dax
+if [ $? -eq 0 ]; then
+	_notrun "Cannot run tests with DAX on dmflakey devices"
+fi
+
 _init_flakey()
 {
 	local BLK_DEV_SIZE=`blockdev --getsz $SCRATCH_DEV`
