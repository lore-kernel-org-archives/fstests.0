Received: from mail-pf0-f193.google.com ([209.85.192.193]:33235 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933382AbdCKAwc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Mar 2017 19:52:32 -0500
Received: by mail-pf0-f193.google.com with SMTP id v190so12418401pfb.0
        for <fstests@vger.kernel.org>; Fri, 10 Mar 2017 16:52:31 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 1/2] common/quota: remove redundant SELinux detection code
Date: Fri, 10 Mar 2017 16:50:47 -0800
Message-Id: <20170311005048.128477-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

SELINUX_MOUNT_OPTIONS is already set in common/config.  Setting it again
in common/quota is not necessary.  Nor is SELINUX_MOUNT_OPTIONS specific
to quota tests, so common/quota is not the right place for it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 common/quota | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/common/quota b/common/quota
index c48cc70b..f49728c2 100644
--- a/common/quota
+++ b/common/quota
@@ -51,13 +51,6 @@ _require_quota()
 	_notrun "disk quotas not supported by this filesystem type: $FSTYP"
 	;;
     esac
-
-    # SELinux adds extra xattrs which can mess up our expected output.
-    # So, mount with a context, and they won't be created
-    # nfs_t is a "liberal" context so we can use it.
-    if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
-        export SELINUX_MOUNT_OPTIONS="-o context=system_u:object_r:nfs_t:s0"
-    fi
 }
 
 #
-- 
2.12.0.246.ga2ecc84866-goog

