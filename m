Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24136C433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 13 Jan 2022 13:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235124AbiAMNYt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 13 Jan 2022 08:24:49 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52086 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235121AbiAMNYs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 13 Jan 2022 08:24:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63C4961CBF
        for <fstests@vger.kernel.org>; Thu, 13 Jan 2022 13:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F17C36AE9;
        Thu, 13 Jan 2022 13:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642080287;
        bh=uxdr+KB/o4cCtMzd7Qc/QQovkhvrF+xg0dUMMPLhEFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CbQsWOYlp6f513SuDPaNtbGeOdpbNwmehqFdm7OOFPw2KV62I198goPxU/MeyCQya
         /Qj7qBqkXQCYWOmoE4061jR0LY8NREKg1LTKxBBXVLj2Y1kc586ijRLgAk9SfPOdIH
         jWbNA2hWyIAKUhAMZMMeWmqUKrW6viX1w6e6pbqHrOtn/M3gFWpt/RdXqlCcccOHSB
         D+3CuMRiCCLKalXfC6cpRgPXOKD2cBM5NfeE4d3FPsJ8NfBY1FmDFA2s7rDZ6p3spi
         U6gKo7FMRGlHXXcA27GTNj3zKFKG5plMo7ui7/paa7SHsxHfWGpmyevvePPaLvVjbv
         TNIhnPMG/y43w==
From:   Christian Brauner <brauner@kernel.org>
To:     fstests@vger.kernel.org, Eryu Guan <guan@eryu.me>
Cc:     Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@digitalocean.com>,
        Christian Brauner <brauner@kernel.org>,
        Eryu Guan <guaneryu@gmail.com>
Subject: [PATCH 2/2] idmapped-mounts: always run generic vfs tests
Date:   Thu, 13 Jan 2022 14:24:21 +0100
Message-Id: <20220113132421.865002-2-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220113132421.865002-1-brauner@kernel.org>
References: <20220113132421.865002-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=19085; h=from:subject; bh=uxdr+KB/o4cCtMzd7Qc/QQovkhvrF+xg0dUMMPLhEFQ=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSQ+UP/36Kut89IClZg3/095dTZP6HB5P9Vr4gxPXq3SufFm rbtMO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACZSLsrI0Nmj3s6S8ale4Va/VMMys4 TGO/4/n0i0Whae1Q8SnuZ9m+G/h1R/Etfv4FkTP4nnvy7kEsqM1L9b2zJ530vjb59uHdLhAgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Make it possible to always run all the tests in the testsuite that don't
require idmapped mounts. Now all filesystems can benefit from the
generic vfs tests that we currently implement. This means setgid
inheritance and other tests will be run for all filesystems not matter
if they support idmapped mounts or not.

Cc: Seth Forshee <sforshee@digitalocean.com>
Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 src/idmapped-mounts/idmapped-mounts.c | 184 ++++++++++++++------------
 tests/generic/633                     |   1 -
 2 files changed, 98 insertions(+), 87 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index a78a901f..5f304108 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -125,6 +125,9 @@ int t_dir1_fd;
 /* temporary buffer */
 char t_buf[PATH_MAX];
 
+/* whether the underlying filesystem supports idmapped mounts */
+bool t_fs_allow_idmap;
+
 static void stash_overflowuid(void)
 {
 	int fd;
@@ -2867,10 +2870,7 @@ out:
 static int fscaps(void)
 {
 	int fret = -1;
-	int file1_fd = -EBADF;
-	struct mount_attr attr = {
-		.attr_set = MOUNT_ATTR_IDMAP,
-	};
+	int file1_fd = -EBADF, fd_userns = -EBADF;
 	pid_t pid;
 
 	file1_fd = openat(t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, 0644);
@@ -2884,8 +2884,8 @@ static int fscaps(void)
 		return 0;
 
 	/* Changing mount properties on a detached mount. */
-	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
-	if (attr.userns_fd < 0) {
+	fd_userns = get_userns_fd(0, 10000, 10000);
+	if (fd_userns < 0) {
 		log_stderr("failure: get_userns_fd");
 		goto out;
 	}
@@ -2901,7 +2901,7 @@ static int fscaps(void)
 		goto out;
 	}
 	if (pid == 0) {
-		if (!switch_userns(attr.userns_fd, 0, 0, false))
+		if (!switch_userns(fd_userns, 0, 0, false))
 			die("failure: switch_userns");
 
 		/*
@@ -2949,7 +2949,7 @@ static int fscaps(void)
 		goto out;
 	}
 	if (pid == 0) {
-		if (!switch_userns(attr.userns_fd, 0, 0, false))
+		if (!switch_userns(fd_userns, 0, 0, false))
 			die("failure: switch_userns");
 
 		if (!expected_dummy_vfs_caps_uid(file1_fd, 0))
@@ -2977,8 +2977,8 @@ static int fscaps(void)
 	fret = 0;
 	log_debug("Ran test");
 out:
-	safe_close(attr.userns_fd);
 	safe_close(file1_fd);
+	safe_close(fd_userns);
 
 	return fret;
 }
@@ -13783,95 +13783,96 @@ static const struct option longopts[] = {
 
 struct t_idmapped_mounts {
 	int (*test)(void);
+	bool require_fs_allow_idmap;
 	const char *description;
 } basic_suite[] = {
-	{ acls,								"posix acls on regular mounts",									},
-	{ create_in_userns,						"create operations in user namespace",								},
-	{ device_node_in_userns,					"device node in user namespace",								},
-	{ expected_uid_gid_idmapped_mounts,				"expected ownership on idmapped mounts",							},
-	{ fscaps,							"fscaps on regular mounts",									},
-	{ fscaps_idmapped_mounts,					"fscaps on idmapped mounts",									},
-	{ fscaps_idmapped_mounts_in_userns,				"fscaps on idmapped mounts in user namespace",							},
-	{ fscaps_idmapped_mounts_in_userns_separate_userns,		"fscaps on idmapped mounts in user namespace with different id mappings",			},
-	{ fsids_mapped,							"mapped fsids",											},
-	{ fsids_unmapped,						"unmapped fsids",										},
-	{ hardlink_crossing_mounts,					"cross mount hardlink",										},
-	{ hardlink_crossing_idmapped_mounts,				"cross idmapped mount hardlink",								},
-	{ hardlink_from_idmapped_mount,					"hardlinks from idmapped mounts",								},
-	{ hardlink_from_idmapped_mount_in_userns,			"hardlinks from idmapped mounts in user namespace",						},
+	{ acls,								true,	"posix acls on regular mounts",									},
+	{ create_in_userns,						true,	"create operations in user namespace",								},
+	{ device_node_in_userns,					true,	"device node in user namespace",								},
+	{ expected_uid_gid_idmapped_mounts,				true,	"expected ownership on idmapped mounts",							},
+	{ fscaps,							false,	"fscaps on regular mounts",									},
+	{ fscaps_idmapped_mounts,					true,	"fscaps on idmapped mounts",									},
+	{ fscaps_idmapped_mounts_in_userns,				true,	"fscaps on idmapped mounts in user namespace",							},
+	{ fscaps_idmapped_mounts_in_userns_separate_userns,		true,	"fscaps on idmapped mounts in user namespace with different id mappings",			},
+	{ fsids_mapped,							true,	"mapped fsids",											},
+	{ fsids_unmapped,						true,	"unmapped fsids",										},
+	{ hardlink_crossing_mounts,					false,	"cross mount hardlink",										},
+	{ hardlink_crossing_idmapped_mounts,				true,	"cross idmapped mount hardlink",								},
+	{ hardlink_from_idmapped_mount,					true,	"hardlinks from idmapped mounts",								},
+	{ hardlink_from_idmapped_mount_in_userns,			true,	"hardlinks from idmapped mounts in user namespace",						},
 #ifdef HAVE_LIBURING_H
-	{ io_uring,							"io_uring",											},
-	{ io_uring_userns,						"io_uring in user namespace",									},
-	{ io_uring_idmapped,						"io_uring from idmapped mounts",								},
-	{ io_uring_idmapped_userns,					"io_uring from idmapped mounts in user namespace",						},
-	{ io_uring_idmapped_unmapped,					"io_uring from idmapped mounts with unmapped ids",						},
-	{ io_uring_idmapped_unmapped_userns,				"io_uring from idmapped mounts with unmapped ids in user namespace",				},
+	{ io_uring,							false,	"io_uring",											},
+	{ io_uring_userns,						false,	"io_uring in user namespace",									},
+	{ io_uring_idmapped,						true,	"io_uring from idmapped mounts",								},
+	{ io_uring_idmapped_userns,					true,	"io_uring from idmapped mounts in user namespace",						},
+	{ io_uring_idmapped_unmapped,					true,	"io_uring from idmapped mounts with unmapped ids",						},
+	{ io_uring_idmapped_unmapped_userns,				true,	"io_uring from idmapped mounts with unmapped ids in user namespace",				},
 #endif
-	{ protected_symlinks,						"following protected symlinks on regular mounts",						},
-	{ protected_symlinks_idmapped_mounts,				"following protected symlinks on idmapped mounts",						},
-	{ protected_symlinks_idmapped_mounts_in_userns,			"following protected symlinks on idmapped mounts in user namespace",				},
-	{ rename_crossing_mounts,					"cross mount rename",										},
-	{ rename_crossing_idmapped_mounts,				"cross idmapped mount rename",									},
-	{ rename_from_idmapped_mount,					"rename from idmapped mounts",									},
-	{ rename_from_idmapped_mount_in_userns,				"rename from idmapped mounts in user namespace",						},
-	{ setattr_truncate,						"setattr truncate",										},
-	{ setattr_truncate_idmapped,					"setattr truncate on idmapped mounts",								},
-	{ setattr_truncate_idmapped_in_userns,				"setattr truncate on idmapped mounts in user namespace",					},
-	{ setgid_create,						"create operations in directories with setgid bit set",						},
-	{ setgid_create_idmapped,					"create operations in directories with setgid bit set on idmapped mounts",			},
-	{ setgid_create_idmapped_in_userns,				"create operations in directories with setgid bit set on idmapped mounts in user namespace",	},
-	{ setid_binaries,						"setid binaries on regular mounts",								},
-	{ setid_binaries_idmapped_mounts,				"setid binaries on idmapped mounts",								},
-	{ setid_binaries_idmapped_mounts_in_userns,			"setid binaries on idmapped mounts in user namespace",						},
-	{ setid_binaries_idmapped_mounts_in_userns_separate_userns,	"setid binaries on idmapped mounts in user namespace with different id mappings",		},
-	{ sticky_bit_unlink,						"sticky bit unlink operations on regular mounts",						},
-	{ sticky_bit_unlink_idmapped_mounts,				"sticky bit unlink operations on idmapped mounts",						},
-	{ sticky_bit_unlink_idmapped_mounts_in_userns,			"sticky bit unlink operations on idmapped mounts in user namespace",				},
-	{ sticky_bit_rename,						"sticky bit rename operations on regular mounts",						},
-	{ sticky_bit_rename_idmapped_mounts,				"sticky bit rename operations on idmapped mounts",						},
-	{ sticky_bit_rename_idmapped_mounts_in_userns,			"sticky bit rename operations on idmapped mounts in user namespace",				},
-	{ symlink_regular_mounts,					"symlink from regular mounts",									},
-	{ symlink_idmapped_mounts,					"symlink from idmapped mounts",									},
-	{ symlink_idmapped_mounts_in_userns,				"symlink from idmapped mounts in user namespace",						},
-	{ threaded_idmapped_mount_interactions,				"threaded operations on idmapped mounts",							},
+	{ protected_symlinks,						false,	"following protected symlinks on regular mounts",						},
+	{ protected_symlinks_idmapped_mounts,				true,	"following protected symlinks on idmapped mounts",						},
+	{ protected_symlinks_idmapped_mounts_in_userns,			true,	"following protected symlinks on idmapped mounts in user namespace",				},
+	{ rename_crossing_mounts,					false,	"cross mount rename",										},
+	{ rename_crossing_idmapped_mounts,				true,	"cross idmapped mount rename",									},
+	{ rename_from_idmapped_mount,					true,	"rename from idmapped mounts",									},
+	{ rename_from_idmapped_mount_in_userns,				true,	"rename from idmapped mounts in user namespace",						},
+	{ setattr_truncate,						false,	"setattr truncate",										},
+	{ setattr_truncate_idmapped,					true,	"setattr truncate on idmapped mounts",								},
+	{ setattr_truncate_idmapped_in_userns,				true,	"setattr truncate on idmapped mounts in user namespace",					},
+	{ setgid_create,						false,	"create operations in directories with setgid bit set",						},
+	{ setgid_create_idmapped,					true,	"create operations in directories with setgid bit set on idmapped mounts",			},
+	{ setgid_create_idmapped_in_userns,				true,	"create operations in directories with setgid bit set on idmapped mounts in user namespace",	},
+	{ setid_binaries,						false,	"setid binaries on regular mounts",								},
+	{ setid_binaries_idmapped_mounts,				true,	"setid binaries on idmapped mounts",								},
+	{ setid_binaries_idmapped_mounts_in_userns,			true,	"setid binaries on idmapped mounts in user namespace",						},
+	{ setid_binaries_idmapped_mounts_in_userns_separate_userns,	true,	"setid binaries on idmapped mounts in user namespace with different id mappings",		},
+	{ sticky_bit_unlink,						false,	"sticky bit unlink operations on regular mounts",						},
+	{ sticky_bit_unlink_idmapped_mounts,				true,	"sticky bit unlink operations on idmapped mounts",						},
+	{ sticky_bit_unlink_idmapped_mounts_in_userns,			true,	"sticky bit unlink operations on idmapped mounts in user namespace",				},
+	{ sticky_bit_rename,						false,	"sticky bit rename operations on regular mounts",						},
+	{ sticky_bit_rename_idmapped_mounts,				true,	"sticky bit rename operations on idmapped mounts",						},
+	{ sticky_bit_rename_idmapped_mounts_in_userns,			true,	"sticky bit rename operations on idmapped mounts in user namespace",				},
+	{ symlink_regular_mounts,					false,	"symlink from regular mounts",									},
+	{ symlink_idmapped_mounts,					true,	"symlink from idmapped mounts",									},
+	{ symlink_idmapped_mounts_in_userns,				true,	"symlink from idmapped mounts in user namespace",						},
+	{ threaded_idmapped_mount_interactions,				true,	"threaded operations on idmapped mounts",							},
 };
 
 struct t_idmapped_mounts fscaps_in_ancestor_userns[] = {
-	{ fscaps_idmapped_mounts_in_userns_valid_in_ancestor_userns,	"fscaps on idmapped mounts in user namespace writing fscap valid in ancestor userns",		},
+	{ fscaps_idmapped_mounts_in_userns_valid_in_ancestor_userns,	true,	"fscaps on idmapped mounts in user namespace writing fscap valid in ancestor userns",		},
 };
 
 struct t_idmapped_mounts t_nested_userns[] = {
-	{ nested_userns,						"test that nested user namespaces behave correctly when attached to idmapped mounts",		},
+	{ nested_userns,						true,	"test that nested user namespaces behave correctly when attached to idmapped mounts",		},
 };
 
 struct t_idmapped_mounts t_btrfs[] = {
-	{ btrfs_subvolumes_fsids_mapped,				"test subvolumes with mapped fsids",								},
-	{ btrfs_subvolumes_fsids_mapped_userns,				"test subvolumes with mapped fsids inside user namespace",					},
-	{ btrfs_subvolumes_fsids_mapped_user_subvol_rm_allowed,		"test subvolume deletion with user_subvol_rm_allowed mount option",				},
-	{ btrfs_subvolumes_fsids_mapped_userns_user_subvol_rm_allowed,	"test subvolume deletion with user_subvol_rm_allowed mount option inside user namespace",	},
-	{ btrfs_subvolumes_fsids_unmapped,				"test subvolumes with unmapped fsids",								},
-	{ btrfs_subvolumes_fsids_unmapped_userns,			"test subvolumes with unmapped fsids inside user namespace",					},
-	{ btrfs_snapshots_fsids_mapped,					"test snapshots with mapped fsids",								},
-	{ btrfs_snapshots_fsids_mapped_userns,				"test snapshots with mapped fsids inside user namespace",					},
-	{ btrfs_snapshots_fsids_mapped_user_subvol_rm_allowed,		"test snapshots deletion with user_subvol_rm_allowed mount option",				},
-	{ btrfs_snapshots_fsids_mapped_userns_user_subvol_rm_allowed,	"test snapshots deletion with user_subvol_rm_allowed mount option inside user namespace",	},
-	{ btrfs_snapshots_fsids_unmapped,				"test snapshots with unmapped fsids",								},
-	{ btrfs_snapshots_fsids_unmapped_userns,			"test snapshots with unmapped fsids inside user namespace",					},
-	{ btrfs_delete_by_spec_id,					"test subvolume deletion by spec id",								},
-	{ btrfs_subvolumes_setflags_fsids_mapped,			"test subvolume flags with mapped fsids",							},
-	{ btrfs_subvolumes_setflags_fsids_mapped_userns,		"test subvolume flags with mapped fsids inside user namespace",					},
-	{ btrfs_subvolumes_setflags_fsids_unmapped,			"test subvolume flags with unmapped fsids",							},
-	{ btrfs_subvolumes_setflags_fsids_unmapped_userns,		"test subvolume flags with unmapped fsids inside user namespace",				},
-	{ btrfs_snapshots_setflags_fsids_mapped,			"test snapshots flags with mapped fsids",							},
-	{ btrfs_snapshots_setflags_fsids_mapped_userns,			"test snapshots flags with mapped fsids inside user namespace",					},
-	{ btrfs_snapshots_setflags_fsids_unmapped,			"test snapshots flags with unmapped fsids",							},
-	{ btrfs_snapshots_setflags_fsids_unmapped_userns,		"test snapshots flags with unmapped fsids inside user namespace",				},
-	{ btrfs_subvolume_lookup_user,					"test unprivileged subvolume lookup",								},
+	{ btrfs_subvolumes_fsids_mapped,				true,	"test subvolumes with mapped fsids",								},
+	{ btrfs_subvolumes_fsids_mapped_userns,				true, 	"test subvolumes with mapped fsids inside user namespace",					},
+	{ btrfs_subvolumes_fsids_mapped_user_subvol_rm_allowed,		true, 	"test subvolume deletion with user_subvol_rm_allowed mount option",				},
+	{ btrfs_subvolumes_fsids_mapped_userns_user_subvol_rm_allowed,	true, 	"test subvolume deletion with user_subvol_rm_allowed mount option inside user namespace",	},
+	{ btrfs_subvolumes_fsids_unmapped,				true, 	"test subvolumes with unmapped fsids",								},
+	{ btrfs_subvolumes_fsids_unmapped_userns,			true, 	"test subvolumes with unmapped fsids inside user namespace",					},
+	{ btrfs_snapshots_fsids_mapped,					true, 	"test snapshots with mapped fsids",								},
+	{ btrfs_snapshots_fsids_mapped_userns,				true, 	"test snapshots with mapped fsids inside user namespace",					},
+	{ btrfs_snapshots_fsids_mapped_user_subvol_rm_allowed,		true, 	"test snapshots deletion with user_subvol_rm_allowed mount option",				},
+	{ btrfs_snapshots_fsids_mapped_userns_user_subvol_rm_allowed,	true, 	"test snapshots deletion with user_subvol_rm_allowed mount option inside user namespace",	},
+	{ btrfs_snapshots_fsids_unmapped,				true, 	"test snapshots with unmapped fsids",								},
+	{ btrfs_snapshots_fsids_unmapped_userns,			true, 	"test snapshots with unmapped fsids inside user namespace",					},
+	{ btrfs_delete_by_spec_id,					true, 	"test subvolume deletion by spec id",								},
+	{ btrfs_subvolumes_setflags_fsids_mapped,			true, 	"test subvolume flags with mapped fsids",							},
+	{ btrfs_subvolumes_setflags_fsids_mapped_userns,		true, 	"test subvolume flags with mapped fsids inside user namespace",					},
+	{ btrfs_subvolumes_setflags_fsids_unmapped,			true, 	"test subvolume flags with unmapped fsids",							},
+	{ btrfs_subvolumes_setflags_fsids_unmapped_userns,		true, 	"test subvolume flags with unmapped fsids inside user namespace",				},
+	{ btrfs_snapshots_setflags_fsids_mapped,			true, 	"test snapshots flags with mapped fsids",							},
+	{ btrfs_snapshots_setflags_fsids_mapped_userns,			true, 	"test snapshots flags with mapped fsids inside user namespace",					},
+	{ btrfs_snapshots_setflags_fsids_unmapped,			true, 	"test snapshots flags with unmapped fsids",							},
+	{ btrfs_snapshots_setflags_fsids_unmapped_userns,		true, 	"test snapshots flags with unmapped fsids inside user namespace",				},
+	{ btrfs_subvolume_lookup_user,					true, 	"test unprivileged subvolume lookup",								},
 };
 
 /* Test for commit 968219708108 ("fs: handle circular mappings correctly"). */
 struct t_idmapped_mounts t_setattr_fix_968219708108[] = {
-	{ setattr_fix_968219708108,					"test that setattr works correctly",								},
+	{ setattr_fix_968219708108,					true,	"test that setattr works correctly",								},
 };
 
 static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
@@ -13883,6 +13884,15 @@ static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
 		int ret;
 		pid_t pid;
 
+		/*
+		 * If the underlying filesystems does not support idmapped
+		 * mounts only run vfs generic tests.
+		 */
+		if (t->require_fs_allow_idmap && !t_fs_allow_idmap) {
+			log_debug("Skipping test %s", t->description);
+			continue;
+		}
+
 		test_setup();
 
 		pid = fork();
@@ -14011,13 +14021,15 @@ int main(int argc, char *argv[])
 	if (t_mnt_fd < 0)
 		die("failed to open %s", t_mountpoint_scratch);
 
-	/*
-	 * Caller just wants to know whether the filesystem we're on supports
-	 * idmapped mounts.
-	 */
+	t_fs_allow_idmap = fs_allow_idmap();
 	if (supported) {
-		if (!fs_allow_idmap())
+		/*
+		 * Caller just wants to know whether the filesystem we're on
+		 * supports idmapped mounts.
+		 */
+		if (!t_fs_allow_idmap)
 			exit(EXIT_FAILURE);
+
 		exit(EXIT_SUCCESS);
 	}
 
diff --git a/tests/generic/633 b/tests/generic/633
index 67501177..38280647 100755
--- a/tests/generic/633
+++ b/tests/generic/633
@@ -15,7 +15,6 @@ _begin_fstest auto quick atime attr cap idmapped io_uring mount perms rw unlink
 # real QA test starts here
 
 _supported_fs generic
-_require_idmapped_mounts
 _require_test
 
 echo "Silence is golden"
-- 
2.32.0

