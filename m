Received: from mx1.redhat.com ([209.132.183.28]:34944 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756899AbdAIQtW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 9 Jan 2017 11:49:22 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9167FA4669
        for <fstests@vger.kernel.org>; Mon,  9 Jan 2017 16:49:23 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id v09GnMAp004796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
        for <fstests@vger.kernel.org>; Mon, 9 Jan 2017 11:49:23 -0500
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] xfs/010: explicitly allow corrupted write in xfs_db
Message-ID: <9d52a01a-78db-3ee1-66e7-bddd1f3f9598@redhat.com>
Date: Mon, 9 Jan 2017 10:49:21 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

xfs/010 wants to write corruption and test how xfs_repair
deals, but when:

  xfs: forbid AG btrees with level == 0

is merged to userspace, this new test fails the write verifier
in xfs_db.

Add "-c" to allow the corrupted write, do the corruptions all
in one xfs_db command (so it doesn't have to re-read the
corrupted data on 2nd startup), and filter out the

  "Allowing write of corrupted data and bad CRC"

output from the "write -c" command.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/xfs/010 b/tests/xfs/010
index d350d64..471ec2c 100755
--- a/tests/xfs/010
+++ b/tests/xfs/010
@@ -95,8 +95,11 @@ _corrupt_finobt_root()
 	dev=$1
 
 	# nuke the agi finobt root fields
-	$XFS_DB_PROG -x -c "agi 0" -c "write free_root 0" $dev
-	$XFS_DB_PROG -x -c "agi 0" -c "write free_level 0" $dev
+	$XFS_DB_PROG -x				\
+		-c "agi 0"			\
+		-c "write -c free_root 0"	\
+		-c "write -c free_level 0"	\
+		$dev | grep -v "Allowing write of corrupted"
 }
 
 # real QA test starts here

