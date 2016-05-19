Received: from mx1.redhat.com ([209.132.183.28]:39710 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751467AbcESEbE (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 19 May 2016 00:31:04 -0400
Received: from int-mx11.intmail.prod.int.phx2.redhat.com (int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2A3506F670
	for <fstests@vger.kernel.org>; Thu, 19 May 2016 04:31:03 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH v2] common/rc: _require_xfs_io_command can't analyze multi-parameters
Date: Thu, 19 May 2016 12:30:59 +0800
Message-Id: <1463632259-19948-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

The $param can't be used for all command's options, for example
"help pwrite" include:

 -Z N -- zeed the random number generator (used when writing randomly)
         (heh, zorry, the -s/-S arguments were already in use in pwrite)

We should make param="-Z N", not only "-Z". After this patch, we can
run this function as:

  _require_xfs_io_command pwrite -Z N

Signed-off-by: Zorro Lang <zlang@redhat.com>
---

Hi,

I did 2 changes in "[PATCH 1/2] common/rc: modify _require_xfs_io_command
function":
1. change "$command help" to "help $command"
2. change "param=$2" to "shift; param=\"$*\""

V2 patch give up the 1st change (Dave explained why we don't change that),
remain the 2nd change as below.

Thanks,
Zorro

 common/rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/rc b/common/rc
index 51092a0..9c532cc 100644
--- a/common/rc
+++ b/common/rc
@@ -1874,7 +1874,8 @@ _require_xfs_io_command()
 		exit 1
 	fi
 	command=$1
-	param=$2
+	shift
+	param="$*"
 
 	testfile=$TEST_DIR/$$.xfs_io
 	case $command in
-- 
2.5.5

