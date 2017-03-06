Received: from mail-pg0-f52.google.com ([74.125.83.52]:35397 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754072AbdCFWOz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 6 Mar 2017 17:14:55 -0500
Received: by mail-pg0-f52.google.com with SMTP id b129so70957115pgc.2
        for <fstests@vger.kernel.org>; Mon, 06 Mar 2017 14:14:30 -0800 (PST)
From: Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] Make SELinux protection conditional
Date: Mon,  6 Mar 2017 14:14:16 -0800
Message-Id: <20170306221416.18520-1-gwendal@chromium.org>
In-Reply-To: <20170127211003.ypphb36xhsn4vczq@thunk.org>
References: <20170127211003.ypphb36xhsn4vczq@thunk.org>
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

When selinux utilities are present, xfstests add options to help circumvent
selinux protection. However, on Chrome OS, it leads to the opposite effect,
when it prevents mount to succeed.

BUG=chromium:669641
TEST=xfstest test ext4/001 completes where it use to display:
common/rc: could not mount /dev/loop29 on /usr/local/autotest/tmp/xfstests_TEST

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 common/config | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/common/config b/common/config
index fb60216c..0c7335ad 100644
--- a/common/config
+++ b/common/config
@@ -35,6 +35,7 @@
 # RMT_TAPE_DEV -    the remote tape device for the xfsdump tests
 # RMT_IRIXTAPE_DEV- the IRIX remote tape device for the xfsdump tests
 # RMT_TAPE_USER -   remote user for tape device
+# SELINUX_MOUNT_OPTIONS - Options to use when SELinux is enabled.
 #
 # - These can be added to $HOST_CONFIG_DIR (witch default to ./config)
 #   below or a separate local configuration file can be used (using
@@ -262,7 +263,7 @@ esac
 # So, mount with a context, and they won't be created
 # # nfs_t is a "liberal" context so we can use it.
 if [ -x /usr/sbin/selinuxenabled ] && /usr/sbin/selinuxenabled; then
-	SELINUX_MOUNT_OPTIONS="-o context=system_u:object_r:nfs_t:s0"
+	: ${SELINUX_MOUNT_OPTIONS:="-o context=system_u:object_r:nfs_t:s0"}
 	export SELINUX_MOUNT_OPTIONS
 fi
 
-- 
2.12.0.rc1.440.g5b76565f74-goog

