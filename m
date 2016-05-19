Received: from mx1.redhat.com ([209.132.183.28]:49804 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751942AbcESVTx (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 19 May 2016 17:19:53 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A85E33B72A
	for <fstests@vger.kernel.org>; Thu, 19 May 2016 21:19:52 +0000 (UTC)
Received: from [IPv6:::1] (ovpn03.gateway.prod.ext.phx2.redhat.com [10.5.9.3])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id u4JLJp5B004187
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Thu, 19 May 2016 17:19:52 -0400
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] filter stripe width details from repair
Message-ID: <0f397d04-157b-4a56-0100-c12628322477@redhat.com>
Date: Thu, 19 May 2016 16:19:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Several golden outputs have:

> Note - stripe unit (0) and width (0) fields have been reset.

but it's entirely possible for this to be non-zero,
which then fails to match and fails the test.

Filter this repair output and fix the golden files.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/common/repair b/common/repair
index 537d943..2b1583b 100644
--- a/common/repair
+++ b/common/repair
@@ -89,6 +89,8 @@ s/(inode chunk) (\d+)\/(\d+)/AGNO\/INO/;
 # sunit/swidth reset messages
 s/^(Note - .*) were copied.*/\1 fields have been reset./;
 s/^(Please) reset (with .*) if necessary/\1 set \2/;
+# And make them generic so we dont depend on geometry
+s/(stripe unit) \(.*\) (and width) \(.*\)/\1 (SU) \2 (SW)/;
 # corrupt sb messages
 s/(superblock) (\d+)/\1 AGNO/;
 s/(AG \#)(\d+)/\1AGNO/;
diff --git a/tests/xfs/030.out.linux b/tests/xfs/030.out.linux
index cf3259f..514ba30 100644
--- a/tests/xfs/030.out.linux
+++ b/tests/xfs/030.out.linux
@@ -39,7 +39,7 @@ Phase 6 - check inode connectivity...
         - traversal finished ...
         - moving disconnected inodes to lost+found ...
 Phase 7 - verify and correct link counts...
-Note - stripe unit (0) and width (0) fields have been reset.
+Note - stripe unit (SU) and width (SW) fields have been reset.
 Please set with mount -o sunit=<value>,swidth=<value>
 done
 Corrupting agf 0 - setting bits to 0
@@ -156,7 +156,7 @@ Phase 6 - check inode connectivity...
         - traversal finished ...
         - moving disconnected inodes to lost+found ...
 Phase 7 - verify and correct link counts...
-Note - stripe unit (0) and width (0) fields have been reset.
+Note - stripe unit (SU) and width (SW) fields have been reset.
 Please set with mount -o sunit=<value>,swidth=<value>
 done
 Corrupting agf 0 - setting bits to -1
diff --git a/tests/xfs/148.out b/tests/xfs/148.out
index 466a55d..c8fb551 100644
--- a/tests/xfs/148.out
+++ b/tests/xfs/148.out
@@ -43,7 +43,7 @@ Phase 6 - check inode connectivity...
         - traversals finished ... 
         - moving disconnected inodes to lost+found ... 
 Phase 7 - verify and correct link counts...
-Note - stripe unit (0) and width (0) fields have been reset.
+Note - stripe unit (SU) and width (SW) fields have been reset.
 Please set with mount -o sunit=<value>,swidth=<value>
 done
 Corrupting agf 0 - setting bits to 0
@@ -186,7 +186,7 @@ Phase 6 - check inode connectivity...
         - traversals finished ... 
         - moving disconnected inodes to lost+found ... 
 Phase 7 - verify and correct link counts...
-Note - stripe unit (0) and width (0) fields have been reset.
+Note - stripe unit (SU) and width (SW) fields have been reset.
 Please set with mount -o sunit=<value>,swidth=<value>
 done
 Corrupting agf 0 - setting bits to -1
diff --git a/tests/xfs/178.out b/tests/xfs/178.out
index 1709863..8e0fc8e 100644
--- a/tests/xfs/178.out
+++ b/tests/xfs/178.out
@@ -37,7 +37,7 @@ Phase 6 - check inode connectivity...
         - traversal finished ...
         - moving disconnected inodes to lost+found ...
 Phase 7 - verify and correct link counts...
-Note - stripe unit (0) and width (0) fields have been reset.
+Note - stripe unit (SU) and width (SW) fields have been reset.
 Please set with mount -o sunit=<value>,swidth=<value>
 done
 repair passed
@@ -73,7 +73,7 @@ Phase 6 - check inode connectivity...
         - traversal finished ...
         - moving disconnected inodes to lost+found ...
 Phase 7 - verify and correct link counts...
-Note - stripe unit (0) and width (0) fields have been reset.
+Note - stripe unit (SU) and width (SW) fields have been reset.
 Please set with mount -o sunit=<value>,swidth=<value>
 done
 repair passed

