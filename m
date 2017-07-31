Received: from cn.fujitsu.com ([222.73.24.84]:31055 "EHLO song.cn.fujitsu.com"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1750923AbdGaJhP (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 31 Jul 2017 05:37:15 -0400
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Subject: [PATCH v2] common/config: add acl and user_xattr support for TEST_DEV
Date: Mon, 31 Jul 2017 17:36:56 +0800
Message-ID: <1501493816-29678-1-git-send-email-yangx.jy@cn.fujitsu.com>
In-Reply-To: <20170731085518.GI9167@eguan.usersys.redhat.com>
References: <20170731085518.GI9167@eguan.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: fstests-owner@vger.kernel.org
To: eguan@redhat.com
Cc: fstests@vger.kernel.org, Xiao Yang <yangx.jy@cn.fujitsu.com>
List-ID: <fstests@vger.kernel.org>

On RHEL6.9GA, generic/097 fails for ext4 because _test_cycle_mount()
remount ext4 without the user_xattr option, so extended attributes
are not supported by ext4.

On some old kernels, ext4 filesystem can not be mounted with acl and
user_xattr options by default.  The following patch has enabled these
options by default:
'ea6633369458("ext4: enable acls and user_xattr by default")'

We add acl and user_xattr support in _test_mount_opts(), and it works
normally on all kernels.

Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 common/config | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/common/config b/common/config
index 80598d0..4f7fba8 100644
--- a/common/config
+++ b/common/config
@@ -335,6 +335,10 @@ _test_mount_opts()
 	glusterfs)
 		export TEST_FS_MOUNT_OPTS=$GLUSTERFS_MOUNT_OPTIONS
 		;;
+	ext2|ext3|ext4|ext4dev)
+		# acls & xattrs aren't turned on by default on older ext$FOO
+		export TEST_FS_MOUNT_OPTS="-o acl,user_xattr $EXT_MOUNT_OPTIONS"
+		;;
 	*)
 		;;
 	esac
-- 
1.8.3.1



