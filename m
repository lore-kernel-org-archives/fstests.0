Return-Path: <fstests-owner@vger.kernel.org>
Received: from sandeen.net ([63.231.237.45]:41102 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751262AbaFMVKg (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 13 Jun 2014 17:10:36 -0400
Message-ID: <539B68D2.2000300@sandeen.net>
Date: Fri, 13 Jun 2014 16:10:42 -0500
From: Eric Sandeen <sandeen@sandeen.net>
MIME-Version: 1.0
Subject: [PATCH] xfs/279: use MKFS_XFS_PROG, not hardcoded path
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: xfstests-owner@vger.kernel.org
To: xfs-oss <xfs@oss.sgi.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

I'm really not sure why this wasn't this way from the start.
On some systems it's in /usr/sbin, and the test fails.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/xfs/279 b/tests/xfs/279
index 872f8be..cde7d21 100755
--- a/tests/xfs/279
+++ b/tests/xfs/279
@@ -62,7 +62,7 @@ _check_mkfs()
 {
 	echo "===================" 
 	echo "mkfs with opts: $@" | sed -e "s,/dev/sd.,DEVICE,"
-	/sbin/mkfs.xfs $@ 2>/dev/null > $tmp.mkfs.full
+	$MKFS_XFS_PROG $@ 2>/dev/null > $tmp.mkfs.full
 	if [ $? -ne 0 ]; then
 		echo "Failed."
 		return

