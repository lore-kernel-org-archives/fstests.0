Received: from mx1.redhat.com ([209.132.183.28]:44174 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755838AbcEQQg1 (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 17 May 2016 12:36:27 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4B0DC05B1E6
	for <fstests@vger.kernel.org>; Tue, 17 May 2016 16:36:26 +0000 (UTC)
From: Zorro Lang <zlang@redhat.com>
Subject: [PATCH 1/2] common/rc: modify _require_xfs_io_command function
Date: Wed, 18 May 2016 00:36:20 +0800
Message-Id: <1463502981-15593-1-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Zorro Lang <zlang@redhat.com>
List-ID: <fstests@vger.kernel.org>

1. This function try to run $XFS_IO_PROG -c "$command help", that's
wrong. It should be "help $command".

2. The $param can't be used for all command's options, for example
"help pwrite" include:

 -Z N -- zeed the random number generator (used when writing randomly)
         (heh, zorry, the -s/-S arguments were already in use in pwrite)

We should make param="-Z N", not only "-Z". After this patch, we can
run this function as:

  _require_xfs_io_command pwrite -Z N

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 common/rc | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/common/rc b/common/rc
index 51092a0..3b87d7e 100644
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
@@ -1896,7 +1897,7 @@ _require_xfs_io_command()
 			_notrun "xfs_io $command support is missing"
 		;;
 	*)
-		testio=`$XFS_IO_PROG -c "$command help" 2>&1`
+		testio=`$XFS_IO_PROG -c "help $command" 2>&1`
 	esac
 
 	rm -f $testfile 2>&1 > /dev/null
-- 
2.5.5

