Received: from mx1.redhat.com ([209.132.183.28]:34298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966537AbdDSSJq (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 19 Apr 2017 14:09:46 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 106AF80F9F
        for <fstests@vger.kernel.org>; Wed, 19 Apr 2017 18:09:46 +0000 (UTC)
Received: from [IPv6:::1] (ovpn04.gateway.prod.ext.phx2.redhat.com [10.5.9.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DDECF18987
        for <fstests@vger.kernel.org>; Wed, 19 Apr 2017 18:09:45 +0000 (UTC)
From: Eric Sandeen <sandeen@redhat.com>
Subject: [PATCH] make xfs/293 more robust
Message-ID: <bf7bdb00-59d0-2283-e040-af1e86f14b95@redhat.com>
Date: Wed, 19 Apr 2017 13:09:45 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

xfs/293 is supposed to make sure every command in xfs_io
is documented, but it was missing the inode command because
it's a common word, and depending on how man formatted the
page, the magic "   inode" string could show up and appear
to indicate that documentation is present for the command
when it's not actually there.

Change the test to inspect the manpage source directly, with
the assumption that each documented command will start
with ^\.B.*$COMMAND on a manpage line.

This handles a few different compressed manpage formats -
I don't know if anybody uses bz2 or xz, but hey.

Signed-off-by: Eric Sandeen <sandeen@redhat.com>
---

diff --git a/tests/xfs/293 b/tests/xfs/293
index ade6015..a342cb6 100755
--- a/tests/xfs/293
+++ b/tests/xfs/293
@@ -48,8 +48,24 @@ _supported_os IRIX Linux
 
 echo "Silence is golden"
 
+MANPAGE=`man --path xfs_io`
+
+[ -z "$MANPAGE" ] && _notrun "xfs_io manpage not found"
+
+if `echo $MANPAGE | grep -q .gz$`; then
+	CAT=zcat
+elif `echo $MANPAGE | grep -q .bz2$`; then
+	CAT=bzcat
+elif `echo $MANPAGE | grep -q .xz$`; then
+	CAT=xzcat
+else
+	CAT=cat
+fi
+
+which $CAT &>/dev/null || _notrun "$CAT utility not found"
+
 for COMMAND in `$XFS_IO_PROG -c help | awk '{print $1}' | grep -v "^Use"`; do
-  man xfs_io | col -b | grep -wq "   $COMMAND" || \
+  $CAT `man --path xfs_io` | egrep -q "^\.B.*$COMMAND" || \
 	echo "$COMMAND not documented in the xfs_io manpage"
 done
 

