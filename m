Received: from mail-pf0-f194.google.com ([209.85.192.194]:33262 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933376AbdCKAwh (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 10 Mar 2017 19:52:37 -0500
Received: by mail-pf0-f194.google.com with SMTP id v190so12418539pfb.0
        for <fstests@vger.kernel.org>; Fri, 10 Mar 2017 16:52:36 -0800 (PST)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH 2/2] common/config: don't hard-code SELinux context
Date: Fri, 10 Mar 2017 16:50:48 -0800
Message-Id: <20170311005048.128477-2-ebiggers3@gmail.com>
In-Reply-To: <20170311005048.128477-1-ebiggers3@gmail.com>
References: <20170311005048.128477-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

If SELinux is enabled, xfstests mounts its filesystems with
"-o context=system_u:object_r:nfs_t:s0" so that no SELinux xattrs get
created and interfere with tests.  However, this particular context is
not guaranteed to be available because the context names are a detail of
the SELinux policy.  The SELinux policy on Android systems, for example,
does not have a context with this name.

To fix this, just grab the SELinux context of the root directory.  This
is arbitrary, but it should always provide a valid context.  And any
valid context *should* be okay (i.e. we don't necessarily need a
"liberal" one), since one would likely encounter many other problems if
they were to run xfstests in a confined context with SELinux in
enforcing mode.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 common/config | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/common/config b/common/config
index fb60216c..ab635767 100644
--- a/common/config
+++ b/common/config
@@ -259,11 +259,16 @@ case "$HOSTOS" in
 esac
 
 # SELinux adds extra xattrs which can mess up our expected output.
-# So, mount with a context, and they won't be created
-# # nfs_t is a "liberal" context so we can use it.
+# So, mount with a context, and they won't be created.
+#
+# Since the context= option only accepts contexts defined in the
+# SELinux policy, and different systems may have different policies
+# with different context names, use the context of an existing
+# directory.  (Assume that any valid context is fine, since xfstests
+# should really only be run from an "unconfined" process, or with
+# SELinux in permissive mode.)
 if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
-	SELINUX_MOUNT_OPTIONS="-o context=system_u:object_r:nfs_t:s0"
-	export SELINUX_MOUNT_OPTIONS
+	export SELINUX_MOUNT_OPTIONS="-o context=$(stat -c %C /)"
 fi
 
 # check if mkfs.xfs supports v5 xfs
-- 
2.12.0.246.ga2ecc84866-goog

