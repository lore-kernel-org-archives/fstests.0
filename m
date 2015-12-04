Received: from mx1.redhat.com ([209.132.183.28]:50376 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756090AbbLDVSP (ORCPT <rfc822;fstests@vger.kernel.org>);
	Fri, 4 Dec 2015 16:18:15 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id BF63F121030
	for <fstests@vger.kernel.org>; Fri,  4 Dec 2015 21:18:15 +0000 (UTC)
Received: from liberator.sandeen.net (ovpn01.gateway.prod.ext.phx2.redhat.com [10.5.9.1])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP id tB4LIEAm016080
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <fstests@vger.kernel.org>; Fri, 4 Dec 2015 16:18:15 -0500
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] xfs/293: tighten up checks for documented xfs_io commands
Message-ID: <56620316.4090104@redhat.com>
Date: Fri, 4 Dec 2015 15:18:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

Some commands (like "zero") are simple words which commonly
occur in the manpage text even if they aren't documented as
commands.

Grep for "   $COMMAND" instead of the bare word, because
the documented commands show up as indented.

This reveals that the "zero" command is not documented yet.
(It catches "help" too, because it's documented differently;
I'll fix that up in the manpage when I add "zero").

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/xfs/293 b/tests/xfs/293
index d1a2853..ade6015 100755
--- a/tests/xfs/293
+++ b/tests/xfs/293
@@ -49,7 +49,7 @@ _supported_os IRIX Linux
 echo "Silence is golden"
 
 for COMMAND in `$XFS_IO_PROG -c help | awk '{print $1}' | grep -v "^Use"`; do
-  man xfs_io | col -b | grep -wq $COMMAND || \
+  man xfs_io | col -b | grep -wq "   $COMMAND" || \
 	echo "$COMMAND not documented in the xfs_io manpage"
 done
 
