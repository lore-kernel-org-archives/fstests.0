Received: from mail-oi0-f67.google.com ([209.85.218.67]:34702 "EHLO
	mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785AbcAIDzK (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 8 Jan 2016 22:55:10 -0500
Received: by mail-oi0-f67.google.com with SMTP id x140so923455oif.1
        for <fstests@vger.kernel.org>; Fri, 08 Jan 2016 19:55:10 -0800 (PST)
From: Jia He <hejianet@gmail.com>
Subject: [PATCH V2 2/2] fstests: canonicalize the mount points by removing the trailing "/"
Date: Sat,  9 Jan 2016 11:54:53 +0800
Message-Id: <1452311693-27529-3-git-send-email-hejianet@gmail.com>
In-Reply-To: <1452311693-27529-1-git-send-email-hejianet@gmail.com>
References: <1452311693-27529-1-git-send-email-hejianet@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: eguan@redhat.com, Jia He <hejianet@gmail.com>
List-ID: <fstests@vger.kernel.org>

removing all the trailing "/"s of mounting point name by readlink

Suggested-by: Eryu Guan <eguan@redhat.com>
Signed-off-by: Jia He <hejianet@gmail.com>
---
 common/config | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/common/config b/common/config
index e82d279..cb34fd7 100644
--- a/common/config
+++ b/common/config
@@ -551,5 +551,10 @@ if [ -z "$CONFIG_INCLUDED" ]; then
 	[ -z "$FSCK_OPTIONS" ] && _fsck_opts
 fi
 
+# canonicalize the mount points
+# this follows symlinks and removes all trailing "/"s
+export TEST_DIR=`readlink -e "$TEST_DIR"`
+export SCRATCH_MNT=`readlink -e "$SCRATCH_MNT"`
+
 # make sure this script returns success
 /bin/true
-- 
2.1.4

