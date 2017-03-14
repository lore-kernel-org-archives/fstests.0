Received: from mail-pf0-f193.google.com ([209.85.192.193]:35109 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750996AbdCNR4B (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Mar 2017 13:56:01 -0400
Received: by mail-pf0-f193.google.com with SMTP id 67so20049151pfg.2
        for <fstests@vger.kernel.org>; Tue, 14 Mar 2017 10:56:01 -0700 (PDT)
From: Eric Biggers <ebiggers3@gmail.com>
Subject: [PATCH v2] common/config: don't hard-code SELinux context
Date: Tue, 14 Mar 2017 10:55:46 -0700
Message-Id: <20170314175546.62834-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: Gwendal Grignou <gwendal@chromium.org>, Theodore Ts'o <tytso@mit.edu>, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

From: Eric Biggers <ebiggers@google.com>

If SELinux is enabled, by default xfstests mounts its filesystems with
"-o context=system_u:object_r:nfs_t:s0" so that no SELinux xattrs get
created and interfere with tests.  However, this particular context is
not guaranteed to be available because the context names are a detail of
the SELinux policy.  The SELinux policy on Android systems, for example,
does not have a context with this name.

To fix this without having to manually override SELINUX_MOUNT_OPTIONS,
just grab the SELinux context of the root directory.  This is arbitrary,
but it should always provide a valid context.  And if for some reason
someone is actually running xfstests in a specific SELinux context that
needs files labeled with a particular context, then they may still
override SELINUX_MOUNT_OPTIONS.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 common/config | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/common/config b/common/config
index 0c7335ad..5bcf114d 100644
--- a/common/config
+++ b/common/config
@@ -260,11 +260,18 @@ case "$HOSTOS" in
 esac
 
 # SELinux adds extra xattrs which can mess up our expected output.
-# So, mount with a context, and they won't be created
-# # nfs_t is a "liberal" context so we can use it.
+# So, mount with a context, and they won't be created.
+#
+# Since the context= option only accepts contexts defined in the SELinux
+# policy, and different systems may have different policies with
+# different context names, use the context of an existing directory.
+# Assume that any valid context is fine, since xfstests should really
+# only be run from an "unconfined" process, or with SELinux in permissive
+# mode.  But if not, just specify your own SELINUX_MOUNT_OPTIONS.
 if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
-	: ${SELINUX_MOUNT_OPTIONS:="-o context=system_u:object_r:nfs_t:s0"}
+	: ${SELINUX_MOUNT_OPTIONS:="-o context=$(stat -c %C /)"}
 	export SELINUX_MOUNT_OPTIONS
+
 fi
 
 # check if mkfs.xfs supports v5 xfs
-- 
2.12.0.367.g23dc2f6d3c-goog

