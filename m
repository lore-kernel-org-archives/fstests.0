Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4BEC678D5
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Mar 2023 11:14:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbjCHLOU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Mar 2023 06:14:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjCHLON (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Mar 2023 06:14:13 -0500
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68F683155
        for <fstests@vger.kernel.org>; Wed,  8 Mar 2023 03:14:07 -0800 (PST)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Wed, 08 Mar 2023 11:14:05 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH v2 7/9] vfs: Make idmapped core tests public
Date:   Wed,  8 Mar 2023 12:13:41 +0100
Message-Id: <20230308111343.510970-8-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308111343.510970-1-rodrigo@sdfg.com.ar>
References: <20230308111343.510970-1-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Tests on the suite s_idmapped_mounts are made public, future patches
for tmpfs will call them.

While making them public, we add a "tcore_" prefix so we don't make so
generic names public.

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
Reviewed-by: Christian Brauner <brauner@kernel.org>
---
 src/vfs/idmapped-mounts.c | 136 +++++++++++++++++++-------------------
 src/vfs/idmapped-mounts.h |  38 +++++++++++
 2 files changed, 106 insertions(+), 68 deletions(-)

diff --git src/vfs/idmapped-mounts.c src/vfs/idmapped-mounts.c
index eb0df938..547182fe 100644
--- src/vfs/idmapped-mounts.c
+++ src/vfs/idmapped-mounts.c
@@ -28,7 +28,7 @@
 
 static char t_buf[PATH_MAX];
 
-static int acls(const struct vfstest_info *info)
+int tcore_acls(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int dir1_fd = -EBADF, open_tree_fd = -EBADF;
@@ -254,7 +254,7 @@ out:
 }
 
 /* Validate that basic file operations on idmapped mounts from a user namespace. */
-static int create_in_userns(const struct vfstest_info *info)
+int tcore_create_in_userns(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd = -EBADF;
@@ -372,7 +372,7 @@ out:
 /* Validate that a caller whose fsids map into the idmapped mount within it's
  * user namespace cannot create any device nodes.
  */
-static int device_node_in_userns(const struct vfstest_info *info)
+int tcore_device_node_in_userns(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int open_tree_fd = -EBADF;
@@ -431,7 +431,7 @@ out:
 	return fret;
 }
 
-static int fsids_mapped(const struct vfstest_info *info)
+int tcore_fsids_mapped(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, hardlink_target_fd = -EBADF, open_tree_fd = -EBADF;
@@ -563,7 +563,7 @@ out:
 }
 
 /* Validate that basic file operations on idmapped mounts. */
-static int fsids_unmapped(const struct vfstest_info *info)
+int tcore_fsids_unmapped(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, hardlink_target_fd = -EBADF, open_tree_fd = -EBADF;
@@ -733,7 +733,7 @@ out:
 }
 
 /* Validate that changing file ownership works correctly on idmapped mounts. */
-static int expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
+int tcore_expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd1 = -EBADF, open_tree_fd2 = -EBADF;
@@ -1451,7 +1451,7 @@ out:
 	return fret;
 }
 
-static int fscaps_idmapped_mounts(const struct vfstest_info *info)
+int tcore_fscaps_idmapped_mounts(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, file1_fd2 = -EBADF, open_tree_fd = -EBADF;
@@ -1599,7 +1599,7 @@ out:
 	return fret;
 }
 
-static int fscaps_idmapped_mounts_in_userns(const struct vfstest_info *info)
+int tcore_fscaps_idmapped_mounts_in_userns(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, file1_fd2 = -EBADF, open_tree_fd = -EBADF;
@@ -1812,7 +1812,7 @@ out:
 	return fret;
 }
 
-static int fscaps_idmapped_mounts_in_userns_separate_userns(const struct vfstest_info *info)
+int tcore_fscaps_idmapped_mounts_in_userns_separate_userns(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, file1_fd2 = -EBADF, open_tree_fd = -EBADF;
@@ -1961,7 +1961,7 @@ out:
 	return fret;
 }
 
-static int hardlink_crossing_idmapped_mounts(const struct vfstest_info *info)
+int tcore_hardlink_crossing_idmapped_mounts(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd1 = -EBADF, open_tree_fd2 = -EBADF;
@@ -2061,7 +2061,7 @@ out:
 	return fret;
 }
 
-static int hardlink_from_idmapped_mount(const struct vfstest_info *info)
+int tcore_hardlink_from_idmapped_mount(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd = -EBADF;
@@ -2130,7 +2130,7 @@ out:
 	return fret;
 }
 
-static int hardlink_from_idmapped_mount_in_userns(const struct vfstest_info *info)
+int tcore_hardlink_from_idmapped_mount_in_userns(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd = -EBADF;
@@ -2207,7 +2207,7 @@ out:
 
 
 #ifdef HAVE_LIBURING_H
-static int io_uring_idmapped(const struct vfstest_info *info)
+int tcore_io_uring_idmapped(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd = -EBADF;
@@ -2338,7 +2338,7 @@ out_unmap:
  * In no circumstances, even with recorded credentials can it be allowed to
  * open the file.
  */
-static int io_uring_idmapped_unmapped(const struct vfstest_info *info)
+int tcore_io_uring_idmapped_unmapped(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd = -EBADF;
@@ -2453,7 +2453,7 @@ out_unmap:
 	return fret;
 }
 
-static int io_uring_idmapped_userns(const struct vfstest_info *info)
+int tcore_io_uring_idmapped_userns(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd = -EBADF;
@@ -2624,7 +2624,7 @@ out_unmap:
 	return fret;
 }
 
-static int io_uring_idmapped_unmapped_userns(const struct vfstest_info *info)
+int tcore_io_uring_idmapped_unmapped_userns(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd = -EBADF;
@@ -2746,7 +2746,7 @@ out_unmap:
 #endif /* HAVE_LIBURING_H */
 
 /* Validate that protected symlinks work correctly on idmapped mounts. */
-static int protected_symlinks_idmapped_mounts(const struct vfstest_info *info)
+int tcore_protected_symlinks_idmapped_mounts(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int dir_fd = -EBADF, fd = -EBADF, open_tree_fd = -EBADF;
@@ -2987,7 +2987,7 @@ out:
 /* Validate that protected symlinks work correctly on idmapped mounts inside a
  * user namespace.
  */
-static int protected_symlinks_idmapped_mounts_in_userns(const struct vfstest_info *info)
+int tcore_protected_symlinks_idmapped_mounts_in_userns(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int dir_fd = -EBADF, fd = -EBADF, open_tree_fd = -EBADF;
@@ -3234,7 +3234,7 @@ out:
 	return fret;
 }
 
-static int rename_crossing_idmapped_mounts(const struct vfstest_info *info)
+int tcore_rename_crossing_idmapped_mounts(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd1 = -EBADF, open_tree_fd2 = -EBADF;
@@ -3332,7 +3332,7 @@ out:
 	return fret;
 }
 
-static int rename_from_idmapped_mount(const struct vfstest_info *info)
+int tcore_rename_from_idmapped_mount(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd = -EBADF;
@@ -3399,7 +3399,7 @@ out:
 	return fret;
 }
 
-static int rename_from_idmapped_mount_in_userns(const struct vfstest_info *info)
+int tcore_rename_from_idmapped_mount_in_userns(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd = -EBADF;
@@ -3474,7 +3474,7 @@ out:
 	return fret;
 }
 
-static int setattr_truncate_idmapped(const struct vfstest_info *info)
+int tcore_setattr_truncate_idmapped(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd = -EBADF;
@@ -3588,7 +3588,7 @@ out:
 	return fret;
 }
 
-static int setattr_truncate_idmapped_in_userns(const struct vfstest_info *info)
+int tcore_setattr_truncate_idmapped_in_userns(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd = -EBADF;
@@ -3780,7 +3780,7 @@ out:
 	return fret;
 }
 
-static int setgid_create_idmapped(const struct vfstest_info *info)
+int tcore_setgid_create_idmapped(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd = -EBADF;
@@ -3956,7 +3956,7 @@ out:
 	return fret;
 }
 
-static int setgid_create_idmapped_in_userns(const struct vfstest_info *info)
+int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd = -EBADF;
@@ -4359,7 +4359,7 @@ out:
 }
 
 /* Validate that setid transitions are handled correctly on idmapped mounts. */
-static int setid_binaries_idmapped_mounts(const struct vfstest_info *info)
+int tcore_setid_binaries_idmapped_mounts(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, exec_fd = -EBADF, open_tree_fd = -EBADF;
@@ -4498,7 +4498,7 @@ out:
  * running in a user namespace where the uid and gid of the setid binary have no
  * mapping.
  */
-static int setid_binaries_idmapped_mounts_in_userns(const struct vfstest_info *info)
+int tcore_setid_binaries_idmapped_mounts_in_userns(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, exec_fd = -EBADF, open_tree_fd = -EBADF;
@@ -4776,7 +4776,7 @@ out:
  * running in a user namespace where the uid and gid of the setid binary have no
  * mapping.
  */
-static int setid_binaries_idmapped_mounts_in_userns_separate_userns(const struct vfstest_info *info)
+int tcore_setid_binaries_idmapped_mounts_in_userns_separate_userns(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, exec_fd = -EBADF, open_tree_fd = -EBADF;
@@ -5069,7 +5069,7 @@ out:
 	return fret;
 }
 
-static int sticky_bit_unlink_idmapped_mounts(const struct vfstest_info *info)
+int tcore_sticky_bit_unlink_idmapped_mounts(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int dir_fd = -EBADF, open_tree_fd = -EBADF;
@@ -5362,7 +5362,7 @@ out:
 /* Validate that the sticky bit behaves correctly on idmapped mounts for unlink
  * operations in a user namespace.
  */
-static int sticky_bit_unlink_idmapped_mounts_in_userns(const struct vfstest_info *info)
+int tcore_sticky_bit_unlink_idmapped_mounts_in_userns(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int dir_fd = -EBADF, open_tree_fd = -EBADF;
@@ -5703,7 +5703,7 @@ out:
 	return fret;
 }
 
-static int sticky_bit_rename_idmapped_mounts(const struct vfstest_info *info)
+int tcore_sticky_bit_rename_idmapped_mounts(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int dir_fd = -EBADF, open_tree_fd = -EBADF;
@@ -5960,7 +5960,7 @@ out:
 /* Validate that the sticky bit behaves correctly on idmapped mounts for unlink
  * operations in a user namespace.
  */
-static int sticky_bit_rename_idmapped_mounts_in_userns(const struct vfstest_info *info)
+int tcore_sticky_bit_rename_idmapped_mounts_in_userns(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int dir_fd = -EBADF, open_tree_fd = -EBADF;
@@ -6264,7 +6264,7 @@ out:
 	return fret;
 }
 
-static int symlink_idmapped_mounts(const struct vfstest_info *info)
+int tcore_symlink_idmapped_mounts(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd = -EBADF;
@@ -6349,7 +6349,7 @@ out:
 	return fret;
 }
 
-static int symlink_idmapped_mounts_in_userns(const struct vfstest_info *info)
+int tcore_symlink_idmapped_mounts_in_userns(const struct vfstest_info *info)
 {
 	int fret = -1;
 	int file1_fd = -EBADF, open_tree_fd = -EBADF;
@@ -8852,42 +8852,42 @@ out:
 }
 
 static const struct test_struct t_idmapped_mounts[] = {
-	{ acls,                                                         true,   "posix acls on regular mounts",                                                                 },
-	{ create_in_userns,                                             true,   "create operations in user namespace",                                                          },
-	{ device_node_in_userns,                                        true,   "device node in user namespace",                                                                },
-	{ expected_uid_gid_idmapped_mounts,				true,	"expected ownership on idmapped mounts",							},
-	{ fscaps_idmapped_mounts,					true,	"fscaps on idmapped mounts",									},
-	{ fscaps_idmapped_mounts_in_userns,				true,	"fscaps on idmapped mounts in user namespace",							},
-	{ fscaps_idmapped_mounts_in_userns_separate_userns,		true,	"fscaps on idmapped mounts in user namespace with different id mappings",			},
-	{ fsids_mapped,                                                 true,   "mapped fsids",                                                                                 },
-	{ fsids_unmapped,                                               true,   "unmapped fsids",                                                                               },
-	{ hardlink_crossing_idmapped_mounts,				true,	"cross idmapped mount hardlink",								},
-	{ hardlink_from_idmapped_mount,					true,	"hardlinks from idmapped mounts",								},
-	{ hardlink_from_idmapped_mount_in_userns,			true,	"hardlinks from idmapped mounts in user namespace",						},
+	{ tcore_acls,                                                         true,   "posix acls on regular mounts",                                                                 },
+	{ tcore_create_in_userns,                                             true,   "create operations in user namespace",                                                          },
+	{ tcore_device_node_in_userns,                                        true,   "device node in user namespace",                                                                },
+	{ tcore_expected_uid_gid_idmapped_mounts,				true,	"expected ownership on idmapped mounts",							},
+	{ tcore_fscaps_idmapped_mounts,					true,	"fscaps on idmapped mounts",									},
+	{ tcore_fscaps_idmapped_mounts_in_userns,				true,	"fscaps on idmapped mounts in user namespace",							},
+	{ tcore_fscaps_idmapped_mounts_in_userns_separate_userns,		true,	"fscaps on idmapped mounts in user namespace with different id mappings",			},
+	{ tcore_fsids_mapped,                                                 true,   "mapped fsids",                                                                                 },
+	{ tcore_fsids_unmapped,                                               true,   "unmapped fsids",                                                                               },
+	{ tcore_hardlink_crossing_idmapped_mounts,				true,	"cross idmapped mount hardlink",								},
+	{ tcore_hardlink_from_idmapped_mount,					true,	"hardlinks from idmapped mounts",								},
+	{ tcore_hardlink_from_idmapped_mount_in_userns,			true,	"hardlinks from idmapped mounts in user namespace",						},
 #ifdef HAVE_LIBURING_H
-	{ io_uring_idmapped,						true,	"io_uring from idmapped mounts",								},
-	{ io_uring_idmapped_userns,					true,	"io_uring from idmapped mounts in user namespace",						},
-	{ io_uring_idmapped_unmapped,					true,	"io_uring from idmapped mounts with unmapped ids",						},
-	{ io_uring_idmapped_unmapped_userns,				true,	"io_uring from idmapped mounts with unmapped ids in user namespace",				},
+	{ tcore_io_uring_idmapped,						true,	"io_uring from idmapped mounts",								},
+	{ tcore_io_uring_idmapped_userns,					true,	"io_uring from idmapped mounts in user namespace",						},
+	{ tcore_io_uring_idmapped_unmapped,					true,	"io_uring from idmapped mounts with unmapped ids",						},
+	{ tcore_io_uring_idmapped_unmapped_userns,				true,	"io_uring from idmapped mounts with unmapped ids in user namespace",				},
 #endif
-	{ protected_symlinks_idmapped_mounts,				true,	"following protected symlinks on idmapped mounts",						},
-	{ protected_symlinks_idmapped_mounts_in_userns,			true,	"following protected symlinks on idmapped mounts in user namespace",				},
-	{ rename_crossing_idmapped_mounts,				true,	"cross idmapped mount rename",									},
-	{ rename_from_idmapped_mount,					true,	"rename from idmapped mounts",									},
-	{ rename_from_idmapped_mount_in_userns,				true,	"rename from idmapped mounts in user namespace",						},
-	{ setattr_truncate_idmapped,					true,	"setattr truncate on idmapped mounts",								},
-	{ setattr_truncate_idmapped_in_userns,				true,	"setattr truncate on idmapped mounts in user namespace",					},
-	{ setgid_create_idmapped,					true,	"create operations in directories with setgid bit set on idmapped mounts",			},
-	{ setgid_create_idmapped_in_userns,				true,	"create operations in directories with setgid bit set on idmapped mounts in user namespace",	},
-	{ setid_binaries_idmapped_mounts,				true,	"setid binaries on idmapped mounts",								},
-	{ setid_binaries_idmapped_mounts_in_userns,			true,	"setid binaries on idmapped mounts in user namespace",						},
-	{ setid_binaries_idmapped_mounts_in_userns_separate_userns,	true,	"setid binaries on idmapped mounts in user namespace with different id mappings",		},
-	{ sticky_bit_unlink_idmapped_mounts,				true,	"sticky bit unlink operations on idmapped mounts",						},
-	{ sticky_bit_unlink_idmapped_mounts_in_userns,			true,	"sticky bit unlink operations on idmapped mounts in user namespace",				},
-	{ sticky_bit_rename_idmapped_mounts,				true,	"sticky bit rename operations on idmapped mounts",						},
-	{ sticky_bit_rename_idmapped_mounts_in_userns,			true,	"sticky bit rename operations on idmapped mounts in user namespace",				},
-	{ symlink_idmapped_mounts,					true,	"symlink from idmapped mounts",									},
-	{ symlink_idmapped_mounts_in_userns,				true,	"symlink from idmapped mounts in user namespace",						},
+	{ tcore_protected_symlinks_idmapped_mounts,				true,	"following protected symlinks on idmapped mounts",						},
+	{ tcore_protected_symlinks_idmapped_mounts_in_userns,			true,	"following protected symlinks on idmapped mounts in user namespace",				},
+	{ tcore_rename_crossing_idmapped_mounts,				true,	"cross idmapped mount rename",									},
+	{ tcore_rename_from_idmapped_mount,					true,	"rename from idmapped mounts",									},
+	{ tcore_rename_from_idmapped_mount_in_userns,				true,	"rename from idmapped mounts in user namespace",						},
+	{ tcore_setattr_truncate_idmapped,					true,	"setattr truncate on idmapped mounts",								},
+	{ tcore_setattr_truncate_idmapped_in_userns,				true,	"setattr truncate on idmapped mounts in user namespace",					},
+	{ tcore_setgid_create_idmapped,					true,	"create operations in directories with setgid bit set on idmapped mounts",			},
+	{ tcore_setgid_create_idmapped_in_userns,				true,	"create operations in directories with setgid bit set on idmapped mounts in user namespace",	},
+	{ tcore_setid_binaries_idmapped_mounts,				true,	"setid binaries on idmapped mounts",								},
+	{ tcore_setid_binaries_idmapped_mounts_in_userns,			true,	"setid binaries on idmapped mounts in user namespace",						},
+	{ tcore_setid_binaries_idmapped_mounts_in_userns_separate_userns,	true,	"setid binaries on idmapped mounts in user namespace with different id mappings",		},
+	{ tcore_sticky_bit_unlink_idmapped_mounts,				true,	"sticky bit unlink operations on idmapped mounts",						},
+	{ tcore_sticky_bit_unlink_idmapped_mounts_in_userns,			true,	"sticky bit unlink operations on idmapped mounts in user namespace",				},
+	{ tcore_sticky_bit_rename_idmapped_mounts,				true,	"sticky bit rename operations on idmapped mounts",						},
+	{ tcore_sticky_bit_rename_idmapped_mounts_in_userns,			true,	"sticky bit rename operations on idmapped mounts in user namespace",				},
+	{ tcore_symlink_idmapped_mounts,					true,	"symlink from idmapped mounts",									},
+	{ tcore_symlink_idmapped_mounts_in_userns,				true,	"symlink from idmapped mounts in user namespace",						},
 };
 
 const struct test_suite s_idmapped_mounts = {
diff --git src/vfs/idmapped-mounts.h src/vfs/idmapped-mounts.h
index 3b0f0825..4a2c7b39 100644
--- src/vfs/idmapped-mounts.h
+++ src/vfs/idmapped-mounts.h
@@ -17,4 +17,42 @@ extern const struct test_suite s_setxattr_fix_705191b03d50;
 extern const struct test_suite s_setgid_create_umask_idmapped_mounts;
 extern const struct test_suite s_setgid_create_acl_idmapped_mounts;
 
+/* Core tests */
+int tcore_acls(const struct vfstest_info *info);
+int tcore_create_in_userns(const struct vfstest_info *info);
+int tcore_device_node_in_userns(const struct vfstest_info *info);
+int tcore_fsids_mapped(const struct vfstest_info *info);
+int tcore_fsids_unmapped(const struct vfstest_info *info);
+int tcore_expected_uid_gid_idmapped_mounts(const struct vfstest_info *info);
+int tcore_fscaps_idmapped_mounts(const struct vfstest_info *info);
+int tcore_fscaps_idmapped_mounts_in_userns(const struct vfstest_info *info);
+int tcore_fscaps_idmapped_mounts_in_userns_separate_userns(const struct vfstest_info *info);
+int tcore_hardlink_crossing_idmapped_mounts(const struct vfstest_info *info);
+int tcore_hardlink_from_idmapped_mount(const struct vfstest_info *info);
+int tcore_hardlink_from_idmapped_mount_in_userns(const struct vfstest_info *info);
+#ifdef HAVE_LIBURING_H
+int tcore_io_uring_idmapped(const struct vfstest_info *info);
+int tcore_io_uring_idmapped_userns(const struct vfstest_info *info);
+int tcore_io_uring_idmapped_unmapped(const struct vfstest_info *info);
+int tcore_io_uring_idmapped_unmapped_userns(const struct vfstest_info *info);
+#endif
+int tcore_protected_symlinks_idmapped_mounts(const struct vfstest_info *info);
+int tcore_protected_symlinks_idmapped_mounts_in_userns(const struct vfstest_info *info);
+int tcore_rename_crossing_idmapped_mounts(const struct vfstest_info *info);
+int tcore_rename_from_idmapped_mount(const struct vfstest_info *info);
+int tcore_rename_from_idmapped_mount_in_userns(const struct vfstest_info *info);
+int tcore_setattr_truncate_idmapped(const struct vfstest_info *info);
+int tcore_setattr_truncate_idmapped_in_userns(const struct vfstest_info *info);
+int tcore_setgid_create_idmapped(const struct vfstest_info *info);
+int tcore_setgid_create_idmapped_in_userns(const struct vfstest_info *info);
+int tcore_setid_binaries_idmapped_mounts(const struct vfstest_info *info);
+int tcore_setid_binaries_idmapped_mounts_in_userns(const struct vfstest_info *info);
+int tcore_setid_binaries_idmapped_mounts_in_userns_separate_userns(const struct vfstest_info *info);
+int tcore_sticky_bit_unlink_idmapped_mounts(const struct vfstest_info *info);
+int tcore_sticky_bit_unlink_idmapped_mounts_in_userns(const struct vfstest_info *info);
+int tcore_sticky_bit_rename_idmapped_mounts(const struct vfstest_info *info);
+int tcore_sticky_bit_rename_idmapped_mounts_in_userns(const struct vfstest_info *info);
+int tcore_symlink_idmapped_mounts(const struct vfstest_info *info);
+int tcore_symlink_idmapped_mounts_in_userns(const struct vfstest_info *info);
+
 #endif /* __IDMAPPED_MOUNTS_H */
-- 
2.39.2

