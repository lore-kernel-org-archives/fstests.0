Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0867FC6FD19
	for <linux-fstests@archiver.kernel.org>; Mon, 13 Mar 2023 19:04:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCMTEI (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 13 Mar 2023 15:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjCMTEG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 13 Mar 2023 15:04:06 -0400
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [IPv6:2001:bc8:228b:9000::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F3D22787
        for <fstests@vger.kernel.org>; Mon, 13 Mar 2023 12:04:03 -0700 (PDT)
Received: from localhost.localdomain
        by sdfg.com.ar (chasquid) with ESMTPSA
        tls TLS_AES_128_GCM_SHA256
        (over submission, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
        ; Mon, 13 Mar 2023 19:04:01 +0000
From:   Rodrigo Campos <rodrigo@sdfg.com.ar>
To:     fstests@vger.kernel.org
Cc:     Christian Brauner <brauner@kernel.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Rodrigo Campos <rodrigo@sdfg.com.ar>
Subject: [PATCH v3 9/9] vfs: Add tmpfs tests for idmap mounts
Date:   Mon, 13 Mar 2023 20:03:30 +0100
Message-Id: <20230313190330.94229-10-rodrigo@sdfg.com.ar>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313190330.94229-1-rodrigo@sdfg.com.ar>
References: <20230313190330.94229-1-rodrigo@sdfg.com.ar>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patch calls all tests in the suite s_idmapped_mounts, but with a
tmpfs directory mounted inside a userns. This directory is setup as the
mount point for the test that runs nested.

This excercises that tmpfs mounted inside a userns works as expected
regarding idmap mounts.

Signed-off-by: Rodrigo Campos <rodrigo@sdfg.com.ar>
---
 src/vfs/Makefile                |   4 +-
 src/vfs/tmpfs-idmapped-mounts.c | 305 ++++++++++++++++++++++++++++++++
 src/vfs/tmpfs-idmapped-mounts.h |  15 ++
 src/vfs/utils.h                 |   2 +
 src/vfs/vfstest.c               |  13 +-
 tests/tmpfs/001                 |  27 +++
 tests/tmpfs/001.out             |   2 +
 tests/tmpfs/Makefile            |  24 +++
 8 files changed, 389 insertions(+), 3 deletions(-)
 create mode 100644 src/vfs/tmpfs-idmapped-mounts.c
 create mode 100644 src/vfs/tmpfs-idmapped-mounts.h
 create mode 100755 tests/tmpfs/001
 create mode 100644 tests/tmpfs/001.out
 create mode 100644 tests/tmpfs/Makefile

diff --git src/vfs/Makefile src/vfs/Makefile
index 1b0b364b..4841da12 100644
--- src/vfs/Makefile
+++ src/vfs/Makefile
@@ -4,10 +4,10 @@ TOPDIR = ../..
 include $(TOPDIR)/include/builddefs
 
 TARGETS = vfstest mount-idmapped
-CFILES_VFSTEST = vfstest.c btrfs-idmapped-mounts.c idmapped-mounts.c utils.c
+CFILES_VFSTEST = vfstest.c btrfs-idmapped-mounts.c idmapped-mounts.c utils.c tmpfs-idmapped-mounts.c
 CFILES_MOUNT_IDMAPPED = mount-idmapped.c utils.c
 
-HFILES = missing.h utils.h btrfs-idmapped-mounts.h idmapped-mounts.h
+HFILES = missing.h utils.h btrfs-idmapped-mounts.h idmapped-mounts.h tmpfs-idmapped-mounts.h
 LLDLIBS += -pthread
 LDIRT = $(TARGETS)
 
diff --git src/vfs/tmpfs-idmapped-mounts.c src/vfs/tmpfs-idmapped-mounts.c
new file mode 100644
index 00000000..0899aed9
--- /dev/null
+++ src/vfs/tmpfs-idmapped-mounts.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include "../global.h"
+
+#include <dirent.h>
+#include <errno.h>
+#include <fcntl.h>
+#include <getopt.h>
+#include <grp.h>
+#include <limits.h>
+#include <linux/limits.h>
+#include <linux/types.h>
+#include <pthread.h>
+#include <pwd.h>
+#include <sched.h>
+#include <stdbool.h>
+#include <sys/fsuid.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/xattr.h>
+#include <unistd.h>
+
+#include "missing.h"
+#include "utils.h"
+#include "vfstest.h"
+#include "idmapped-mounts.h"
+
+static int tmpfs_nested_mount_setup(const struct vfstest_info *info, int (*test)(const struct vfstest_info *info))
+{
+	char path[PATH_MAX];
+	int fret = -1;
+	struct vfstest_info nested_test_info = *info;
+
+	/* Create mapping for userns
+	 * Make the mapping quite long, so all nested userns that are created by
+	 * any test we call is contained here (otherwise userns creation fails).
+	 */
+	struct mount_attr attr = {
+		.attr_set	= MOUNT_ATTR_IDMAP,
+		.userns_fd	= -EBADF,
+	};
+	attr.userns_fd = get_userns_fd(0, 10000, 200000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out_close;
+	}
+
+	if (!switch_userns(attr.userns_fd, 0, 0, false)) {
+		log_stderr("failure: switch_userns");
+		goto out_close;
+	}
+
+	/* create separate mount namespace */
+	if (unshare(CLONE_NEWNS)) {
+		log_stderr("failure: create new mount namespace");
+		goto out_close;
+	}
+
+	/* We don't want this mount in the parent mount ns */
+	if (sys_mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0)) {
+		log_stderr("failure: mount");
+		goto out_close;
+	}
+
+	/* Create DIR0 to mount there */
+	if (mkdirat(info->t_mnt_fd, DIR0, 0777)) {
+		log_stderr("failure: mkdirat");
+		goto out_close;
+	}
+	if (fchmodat(info->t_mnt_fd, DIR0, 0777, 0)) {
+		log_stderr("failure: fchmodat");
+		goto out_rm;
+	}
+
+	snprintf(path, sizeof(path), "%s/%s", info->t_mountpoint, DIR0);
+	if (sys_mount("tmpfs", path, "tmpfs", 0, NULL)) {
+		log_stderr("failure: mount");
+		goto out_rm;
+	}
+
+	// Create a new info to use for the test we will call.
+	nested_test_info = *info;
+	nested_test_info.t_mountpoint = strdup(path);
+	if (!nested_test_info.t_mountpoint) {
+		log_stderr("failure: strdup");
+		goto out;
+	}
+	nested_test_info.t_mnt_fd = openat(-EBADF, nested_test_info.t_mountpoint, O_CLOEXEC | O_DIRECTORY);
+	if (nested_test_info.t_mnt_fd < 0) {
+		log_stderr("failure: openat");
+		goto out;
+	}
+
+	test_setup(&nested_test_info);
+
+	// Run the test.
+	if ((*test)(&nested_test_info)) {
+		log_stderr("failure: calling test");
+		goto out;
+	}
+
+	test_cleanup(&nested_test_info);
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	snprintf(path, sizeof(path), "%s/" DIR0, info->t_mountpoint);
+	sys_umount2(path, MNT_DETACH);
+out_rm:
+	if (rm_r(info->t_mnt_fd, DIR0))
+		log_stderr("failure: rm_r");
+out_close:
+	safe_close(attr.userns_fd);
+	return fret;
+}
+
+static int tmpfs_acls(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_acls);
+}
+static int tmpfs_create_in_userns(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_create_in_userns);
+}
+static int tmpfs_device_node_in_userns(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_device_node_in_userns);
+}
+static int tmpfs_fsids_mapped(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_fsids_mapped);
+}
+static int tmpfs_fsids_unmapped(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_fsids_unmapped);
+}
+static int tmpfs_expected_uid_gid_idmapped_mounts(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_expected_uid_gid_idmapped_mounts);
+}
+static int tmpfs_fscaps_idmapped_mounts(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_fscaps_idmapped_mounts);
+}
+static int tmpfs_fscaps_idmapped_mounts_in_userns(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_fscaps_idmapped_mounts_in_userns);
+}
+static int tmpfs_fscaps_idmapped_mounts_in_userns_separate_userns(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_fscaps_idmapped_mounts_in_userns_separate_userns);
+}
+
+static int tmpfs_hardlink_crossing_idmapped_mounts(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_hardlink_crossing_idmapped_mounts);
+}
+static int tmpfs_hardlink_from_idmapped_mount(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_hardlink_from_idmapped_mount);
+}
+static int tmpfs_hardlink_from_idmapped_mount_in_userns(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_hardlink_from_idmapped_mount_in_userns);
+}
+
+#ifdef HAVE_LIBURING_H
+static int tmpfs_io_uring_idmapped(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_io_uring_idmapped);
+}
+static int tmpfs_io_uring_idmapped_userns(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_io_uring_idmapped_userns);
+}
+static int tmpfs_io_uring_idmapped_unmapped(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_io_uring_idmapped_unmapped);
+}
+static int tmpfs_io_uring_idmapped_unmapped_userns(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_io_uring_idmapped_unmapped_userns);
+}
+#endif /* HAVE_LIBURING_H */
+
+static int tmpfs_protected_symlinks_idmapped_mounts(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_protected_symlinks_idmapped_mounts);
+}
+static int tmpfs_protected_symlinks_idmapped_mounts_in_userns(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_protected_symlinks_idmapped_mounts_in_userns);
+}
+static int tmpfs_rename_crossing_idmapped_mounts(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_rename_crossing_idmapped_mounts);
+}
+static int tmpfs_rename_from_idmapped_mount(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_rename_from_idmapped_mount);
+}
+static int tmpfs_rename_from_idmapped_mount_in_userns(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_rename_from_idmapped_mount_in_userns);
+}
+static int tmpfs_setattr_truncate_idmapped(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_setattr_truncate_idmapped);
+}
+static int tmpfs_setattr_truncate_idmapped_in_userns(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_setattr_truncate_idmapped_in_userns);
+}
+static int tmpfs_setgid_create_idmapped(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_setgid_create_idmapped);
+}
+static int tmpfs_setgid_create_idmapped_in_userns(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_setgid_create_idmapped_in_userns);
+}
+static int tmpfs_setid_binaries_idmapped_mounts(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_setid_binaries_idmapped_mounts);
+}
+static int tmpfs_setid_binaries_idmapped_mounts_in_userns(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_setid_binaries_idmapped_mounts_in_userns);
+}
+static int tmpfs_setid_binaries_idmapped_mounts_in_userns_separate_userns(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_setid_binaries_idmapped_mounts_in_userns_separate_userns);
+}
+static int tmpfs_sticky_bit_unlink_idmapped_mounts(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_sticky_bit_unlink_idmapped_mounts);
+}
+static int tmpfs_sticky_bit_unlink_idmapped_mounts_in_userns(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_sticky_bit_unlink_idmapped_mounts_in_userns);
+}
+static int tmpfs_sticky_bit_rename_idmapped_mounts(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_sticky_bit_rename_idmapped_mounts);
+}
+static int tmpfs_sticky_bit_rename_idmapped_mounts_in_userns(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_sticky_bit_rename_idmapped_mounts_in_userns);
+}
+static int tmpfs_symlink_idmapped_mounts(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_symlink_idmapped_mounts);
+}
+static int tmpfs_symlink_idmapped_mounts_in_userns(const struct vfstest_info *info)
+{
+	return tmpfs_nested_mount_setup(info, tcore_symlink_idmapped_mounts_in_userns);
+}
+
+static const struct test_struct t_tmpfs[] = {
+	{ tmpfs_acls,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs create operations in user namespace",							      },
+	{ tmpfs_create_in_userns,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs create operations in user namespace",							      },
+	{ tmpfs_device_node_in_userns,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs device node in user namespace",								      },
+	{ tmpfs_expected_uid_gid_idmapped_mounts,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs expected ownership on idmapped mounts",							},
+	{ tmpfs_fscaps_idmapped_mounts,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs fscaps on idmapped mounts",									},
+	{ tmpfs_fscaps_idmapped_mounts_in_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs fscaps on idmapped mounts in user namespace",							},
+	{ tmpfs_fscaps_idmapped_mounts_in_userns_separate_userns,		T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs fscaps on idmapped mounts in user namespace with different id mappings",			},
+	{ tmpfs_fsids_mapped,							T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs mapped fsids",										      },
+	{ tmpfs_fsids_unmapped,							T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs unmapped fsids",										      },
+	{ tmpfs_hardlink_crossing_idmapped_mounts,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs cross idmapped mount hardlink",								},
+	{ tmpfs_hardlink_from_idmapped_mount,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs hardlinks from idmapped mounts",								},
+	{ tmpfs_hardlink_from_idmapped_mount_in_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs hardlinks from idmapped mounts in user namespace",						},
+#ifdef HAVE_LIBURING_H
+	{ tmpfs_io_uring_idmapped,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs io_uring from idmapped mounts",								      },
+	{ tmpfs_io_uring_idmapped_userns,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs io_uring from idmapped mounts in user namespace",					      },
+	{ tmpfs_io_uring_idmapped_unmapped,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs io_uring from idmapped mounts with unmapped ids",					      },
+	{ tmpfs_io_uring_idmapped_unmapped_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs io_uring from idmapped mounts with unmapped ids in user namespace",			      },
+#endif
+	{ tmpfs_protected_symlinks_idmapped_mounts,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs following protected symlinks on idmapped mounts",						},
+	{ tmpfs_protected_symlinks_idmapped_mounts_in_userns,			T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs following protected symlinks on idmapped mounts in user namespace",				},
+	{ tmpfs_rename_crossing_idmapped_mounts,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs cross idmapped mount rename",									},
+	{ tmpfs_rename_from_idmapped_mount,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs rename from idmapped mounts",									},
+	{ tmpfs_rename_from_idmapped_mount_in_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs rename from idmapped mounts in user namespace",						},
+	{ tmpfs_setattr_truncate_idmapped,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs setattr truncate on idmapped mounts",								},
+	{ tmpfs_setattr_truncate_idmapped_in_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs setattr truncate on idmapped mounts in user namespace",					},
+	{ tmpfs_setgid_create_idmapped,						T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs create operations in directories with setgid bit set on idmapped mounts",			},
+	{ tmpfs_setgid_create_idmapped_in_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs create operations in directories with setgid bit set on idmapped mounts in user namespace",	},
+	{ tmpfs_setid_binaries_idmapped_mounts,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs setid binaries on idmapped mounts",								},
+	{ tmpfs_setid_binaries_idmapped_mounts_in_userns,			T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs setid binaries on idmapped mounts in user namespace",						},
+	{ tmpfs_setid_binaries_idmapped_mounts_in_userns_separate_userns,	T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs setid binaries on idmapped mounts in user namespace with different id mappings",		},
+	{ tmpfs_sticky_bit_unlink_idmapped_mounts,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs sticky bit unlink operations on idmapped mounts",						},
+	{ tmpfs_sticky_bit_unlink_idmapped_mounts_in_userns,			T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs sticky bit unlink operations on idmapped mounts in user namespace",				},
+	{ tmpfs_sticky_bit_rename_idmapped_mounts,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs sticky bit rename operations on idmapped mounts",						},
+	{ tmpfs_sticky_bit_rename_idmapped_mounts_in_userns,			T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs sticky bit rename operations on idmapped mounts in user namespace",				},
+	{ tmpfs_symlink_idmapped_mounts,					T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs symlink from idmapped mounts",									},
+	{ tmpfs_symlink_idmapped_mounts_in_userns,				T_REQUIRE_USERNS | T_REQUIRE_IDMAPPED_MOUNTS,	"tmpfs symlink from idmapped mounts in user namespace",						},
+};
+
+
+const struct test_suite s_tmpfs_idmapped_mounts = {
+	.tests = t_tmpfs,
+	.nr_tests = ARRAY_SIZE(t_tmpfs),
+};
diff --git src/vfs/tmpfs-idmapped-mounts.h src/vfs/tmpfs-idmapped-mounts.h
new file mode 100644
index 00000000..038d86a9
--- /dev/null
+++ src/vfs/tmpfs-idmapped-mounts.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __TMPFS_IDMAPPED_MOUNTS_H
+#define __TMPFS_IDMAPPED_MOUNTS_H
+
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
+
+#include "utils.h"
+
+extern const struct test_suite s_tmpfs_idmapped_mounts;
+
+#endif /* __TMPFS_IDMAPPED_MOUNTS_H */
+
diff --git src/vfs/utils.h src/vfs/utils.h
index f1681737..872fd96f 100644
--- src/vfs/utils.h
+++ src/vfs/utils.h
@@ -45,6 +45,8 @@
 #define DIR2 "dir2"
 #define DIR3 "dir3"
 #define DIR1_RENAME "dir1_rename"
+// This directory may be used by tests that call another test.
+#define DIR0 "dir0"
 #define HARDLINK1 "hardlink1"
 #define SYMLINK1 "symlink1"
 #define SYMLINK_USER1 "symlink_user1"
diff --git src/vfs/vfstest.c src/vfs/vfstest.c
index 325f04a1..f842117d 100644
--- src/vfs/vfstest.c
+++ src/vfs/vfstest.c
@@ -23,6 +23,7 @@
 #include <unistd.h>
 
 #include "btrfs-idmapped-mounts.h"
+#include "tmpfs-idmapped-mounts.h"
 #include "idmapped-mounts.h"
 #include "missing.h"
 #include "utils.h"
@@ -2316,6 +2317,7 @@ static void usage(void)
 	fprintf(stderr, "--test-fscaps-regression            Run fscap regression tests\n");
 	fprintf(stderr, "--test-nested-userns                Run nested userns idmapped mount testsuite\n");
 	fprintf(stderr, "--test-btrfs                        Run btrfs specific idmapped mount testsuite\n");
+	fprintf(stderr, "--test-tmpfs                        Run tmpfs specific idmapped mount testsuite\n");
 	fprintf(stderr, "--test-setattr-fix-968219708108     Run setattr regression tests\n");
 	fprintf(stderr, "--test-setxattr-fix-705191b03d50    Run setxattr regression tests\n");
 	fprintf(stderr, "--test-setgid-create-umask          Run setgid with umask tests\n");
@@ -2340,6 +2342,7 @@ static const struct option longopts[] = {
 	{"test-setxattr-fix-705191b03d50",	no_argument,		0,	'j'},
 	{"test-setgid-create-umask",		no_argument,		0,	'u'},
 	{"test-setgid-create-acl",		no_argument,		0,	'l'},
+	{"test-tmpfs",				no_argument,		0,	't'},
 	{NULL,					0,			0,	  0},
 };
 
@@ -2480,7 +2483,7 @@ int main(int argc, char *argv[])
 	bool idmapped_mounts_supported = false, test_btrfs = false,
 	     test_core = false, test_fscaps_regression = false,
 	     test_nested_userns = false, test_setattr_fix_968219708108 = false,
-	     test_setxattr_fix_705191b03d50 = false,
+	     test_setxattr_fix_705191b03d50 = false, test_tmpfs = false,
 	     test_setgid_create_umask = false, test_setgid_create_acl = false;
 
 	init_vfstest_info(&info);
@@ -2529,6 +2532,9 @@ int main(int argc, char *argv[])
 		case 'l':
 			test_setgid_create_acl = true;
 			break;
+		case 't':
+			test_tmpfs = true;
+			break;
 		case 'h':
 			/* fallthrough */
 		default:
@@ -2622,6 +2628,11 @@ int main(int argc, char *argv[])
 			goto out;
 	}
 
+	if (test_tmpfs) {
+		if (!run_suite(&info, &s_tmpfs_idmapped_mounts))
+			goto out;
+	}
+
 	fret = EXIT_SUCCESS;
 
 out:
diff --git tests/tmpfs/001 tests/tmpfs/001
new file mode 100755
index 00000000..37f5439e
--- /dev/null
+++ tests/tmpfs/001
@@ -0,0 +1,27 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2023 Rodrigo Campos Catelin.  All Rights Reserved.
+#
+# FS QA Test 001
+#
+# Test that idmapped mounts behave correctly with tmpfs filesystem.
+#
+. ./common/preamble
+_begin_fstest auto quick idmapped
+
+# get standard environment, filters and checks
+. ./common/filter
+
+# real QA test starts here
+
+_supported_fs tmpfs
+_require_idmapped_mounts
+_require_test
+
+echo "Silence is golden"
+
+$here/src/vfs/vfstest --test-tmpfs --device "$TEST_DEV" \
+	        --mount "$TEST_DIR" --fstype "$FSTYP"
+
+status=$?
+exit
diff --git tests/tmpfs/001.out tests/tmpfs/001.out
new file mode 100644
index 00000000..88678b8e
--- /dev/null
+++ tests/tmpfs/001.out
@@ -0,0 +1,2 @@
+QA output created by 001
+Silence is golden
diff --git tests/tmpfs/Makefile tests/tmpfs/Makefile
new file mode 100644
index 00000000..b464b22b
--- /dev/null
+++ tests/tmpfs/Makefile
@@ -0,0 +1,24 @@
+#
+# Copyright (c) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.
+#
+
+TOPDIR = ../..
+include $(TOPDIR)/include/builddefs
+include $(TOPDIR)/include/buildgrouplist
+
+GENERIC_DIR = generic
+TARGET_DIR = $(PKG_LIB_DIR)/$(TESTS_DIR)/$(GENERIC_DIR)
+DIRT = group.list
+
+default: $(DIRT)
+
+include $(BUILDRULES)
+
+install:
+	$(INSTALL) -m 755 -d $(TARGET_DIR)
+	$(INSTALL) -m 755 $(TESTS) $(TARGET_DIR)
+	$(INSTALL) -m 644 group.list $(TARGET_DIR)
+	$(INSTALL) -m 644 $(OUTFILES) $(TARGET_DIR)
+
+# Nothing.
+install-dev install-lib:
-- 
2.39.2

