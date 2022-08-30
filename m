Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28E42ECAAA1
	for <linux-fstests@archiver.kernel.org>; Tue, 30 Aug 2022 10:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiH3KPy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 30 Aug 2022 06:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbiH3KPb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 30 Aug 2022 06:15:31 -0400
Received: from mail1.bemta37.messagelabs.com (mail1.bemta37.messagelabs.com [85.158.142.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02084E68C7
        for <fstests@vger.kernel.org>; Tue, 30 Aug 2022 03:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1661854367; i=@fujitsu.com;
        bh=BEj0B1YC/U6NSSY+hg4Q8JXRIYc+zV8io3Iyclw7qC0=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=S7gCAc16KOEMXBuLwJxllsEgeidPq4N7ucBf7x4CmZKtPxii1YLHxZLY8FVnI4mEx
         OD/gVJQ8x2xnnIHdwvwerEQcZm5QBfnTabCvlq4yYVtqwTCMqK82c04eVYaEP37gsz
         O900B5nWn9J1F301jy5jahSzCEwY5NPBeV1I3RMNLdAAOFcLwnVe3YDNTAlKvcVr3Q
         D2/BON+8ouXTEfJ1VCEylA3R/3Iq9tcypD5afK8KQputYZxWvtTQk0Ys3KHvrsfrhx
         L85KTHk1GcC5om4SqSiGAs7QLVqnnXCBO0DlC1w1gd0CZhqPFfCISYe3Ssg2FmsL5L
         KErtYyQmNy00Q==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRWlGSWpSXmKPExsViZ8ORqDvvEW+
  ywfYH6havD39itDjdspfdgclj06pONo/Pm+QCmKJYM/OS8isSWDP+3P3AXtA/nbli+9W8BsZf
  x5i6GLk4hAS2MEocnzeJFcJZwSSx7eB/qMxeRolrjTeBHE4ONgFNiWedC5hBbBEBWYn/M1aDx
  ZkFbCXe/fjHBmILC1hLnJ2ykgXEZhFQlZi5+hl7FyMHB6+Ah8Sm1ykgYQkBBYkpD9+DjeEU8J
  R4vKGBHcQWEiiT+HxiCVicV0BQ4uTMJywQ4yUkDr54wQzRqyhxqeMbI8hICYFKiRuPUyHCahJ
  Xz21insAoOAtJ9ywk3QsYmVYx2iYVZaZnlOQmZuboGhoY6BoamgJpI11DU2O9xCrdRL3UUt28
  /KKSDF1DvcTyYr3U4mK94src5JwUvbzUkk2MwOBOKU6buYNxy75feocYJTmYlER5G7bxJgvxJ
  eWnVGYkFmfEF5XmpBYfYpTh4FCS4NUFxouQYFFqempFWmYOMNJg0hIcPEoivCfvA6V5iwsSc4
  sz0yFSpxh1OabO/refWYglLz8vVUqct+whUJEASFFGaR7cCFjUX2KUlRLmZWRgYBDiKUgtys0
  sQZV/xSjOwagkzOsEMoUnM68EbtMroCOYgI54uIQb5IiSRISUVAOT85SLc/2r9m/ks7izZ1MQ
  z4bDISkmCybXJDJ9EIg8Uvjsqdzl/NXn889u+NTVFDiHW+9w7rXHlp9tF6j2uE6TW8d/485cl
  used2YsFvf2Zj29ce6Fd1sTp6ucX7Lud23p41WiOo5Vd6o127+s/LlGMiFHZ6vouin7Uy12TU
  gMqTvMnfBAasr/DzoGGlXbJt56fInr6MbHm8pXzTzdOEO72Tt/7SmRlY84C2f/v5C16Zz0qvI
  lN4KvZ9WH5l2zt5YOePm1V6zmzdrXLn/0p7Hs+FRzoPfAoeqEz5Wav22930qql0b/PaH7nqXa
  +GD6vYVVc/POmc1eeinp9SevkMC5rxLFXNV0JFqfPNa3spI4UqvEUpyRaKjFXFScCAB49IAXd
  QMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-14.tower-732.messagelabs.com!1661854366!291734!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 30359 invoked from network); 30 Aug 2022 10:12:46 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
  by server-14.tower-732.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 30 Aug 2022 10:12:46 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id EF05C100191;
        Tue, 30 Aug 2022 11:12:45 +0100 (BST)
Received: from R01UKEXCASM223.r01.fujitsu.local (R01UKEXCASM223 [10.182.185.121])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id E0C01100043;
        Tue, 30 Aug 2022 11:12:45 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Tue, 30 Aug 2022 11:12:43 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <brauner@kernel.org>, Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v3 2/2] vfs: Add new setgid_create_acl test
Date:   Tue, 30 Aug 2022 19:13:23 +0800
Message-ID: <1661858003-2181-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1661858003-2181-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <20220829135225.wscmhw4dqkzitcvf@wittgenste>
 <1661858003-2181-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD08.g08.fujitsu.local (10.167.33.83) To
 R01UKEXCASM223.r01.fujitsu.local (10.182.185.121)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The current_umask() is stripped from the mode directly in the vfs if the
filesystem either doesn't support acls or the filesystem has been
mounted without posic acl support.

If the filesystem does support acls then current_umask() stripping is
deferred to posix_acl_create(). So when the filesystem calls
posix_acl_create() and there are no acls set or not supported then
current_umask() will be stripped.

If the parent directory has a default acl then permissions are based off
of that and current_umask() is ignored. Specifically, if the ACL has an
ACL_MASK entry, the group permissions correspond to the permissions of
the ACL_MASK entry. Otherwise, if the ACL has no ACL_MASK entry, the
group permissions correspond to the permissions of the ACL_GROUP_OBJ
entry.

Here we only use setfacl to set default acl or add ACL_MASK to check
whether inode strip  S_ISGID works correctly.

Like umask test, this patch is also designed to test kernel patchset behaviour
"move S_ISGID stripping into the vfs* helper"

Tested-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/vfs/idmapped-mounts.c | 907 ++++++++++++++++++++++++++++++++++----
 src/vfs/idmapped-mounts.h |   1 +
 src/vfs/vfstest.c         | 356 ++++++++++++++-
 tests/generic/999         |  33 ++
 tests/generic/999.out     |   2 +
 5 files changed, 1218 insertions(+), 81 deletions(-)
 create mode 100755 tests/generic/999
 create mode 100644 tests/generic/999.out

diff --git a/src/vfs/idmapped-mounts.c b/src/vfs/idmapped-mounts.c
index 01a5fbd4..c010dfa1 100644
--- a/src/vfs/idmapped-mounts.c
+++ b/src/vfs/idmapped-mounts.c
@@ -7664,7 +7664,6 @@ out:
 	return fret;
 }
 
-
 /* The current_umask() is stripped from the mode directly in the vfs if the
  * filesystem either doesn't support acls or the filesystem has been
  * mounted without posic acl support.
@@ -8114,94 +8113,842 @@ out:
 	return fret;
 }
 
-static const struct test_struct t_idmapped_mounts[] = {
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
-#ifdef HAVE_LIBURING_H
-	{ io_uring_idmapped,						true,	"io_uring from idmapped mounts",								},
-	{ io_uring_idmapped_userns,					true,	"io_uring from idmapped mounts in user namespace",						},
-	{ io_uring_idmapped_unmapped,					true,	"io_uring from idmapped mounts with unmapped ids",						},
-	{ io_uring_idmapped_unmapped_userns,				true,	"io_uring from idmapped mounts with unmapped ids in user namespace",				},
-#endif
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
-};
+/*
+ * If the parent directory has a default acl then permissions are based off
+ * of that and current_umask() is ignored. Specifically, if the ACL has an
+ * ACL_MASK entry, the group permissions correspond to the permissions of
+ * the ACL_MASK entry. Otherwise, if the ACL has no ACL_MASK entry, the
+ * group permissions correspond to the permissions of the ACL_GROUP_OBJ
+ * entry.
+ *
+ * Use setfacl to check whether inode strip S_ISGID works correctly under
+ * the above two situations when enabling idmapped.
+ *
+ * Test for commit
+ * 1639a49ccdce ("fs: move S_ISGID stripping into the vfs_*() helpers").
+ */
+static int setgid_create_acl_idmapped(const struct vfstest_info *info)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+	int tmpfile_fd = -EBADF;
+	bool supported = false;
+	char path[PATH_MAX];
+	mode_t mode;
 
-const struct test_suite s_idmapped_mounts = {
-	.tests		= t_idmapped_mounts,
-	.nr_tests	= ARRAY_SIZE(t_idmapped_mounts),
-};
+	if (!caps_supported())
+		return 0;
 
-static const struct test_struct t_fscaps_in_ancestor_userns[] = {
-	{ fscaps_idmapped_mounts_in_userns_valid_in_ancestor_userns,	true,	"fscaps on idmapped mounts in user namespace writing fscap valid in ancestor userns",		},
-};
+	if (fchmod(info->t_dir1_fd, S_IRUSR |
+			      S_IWUSR |
+			      S_IRGRP |
+			      S_IWGRP |
+			      S_IROTH |
+			      S_IWOTH |
+			      S_IXUSR |
+			      S_IXGRP |
+			      S_IXOTH |
+			      S_ISGID), 0) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
 
-const struct test_suite s_fscaps_in_ancestor_userns = {
-	.tests		= t_fscaps_in_ancestor_userns,
-	.nr_tests	= ARRAY_SIZE(t_fscaps_in_ancestor_userns),
-};
+	/* Verify that the sid bits got raised. */
+	if (!is_setgid(info->t_dir1_fd, "", AT_EMPTY_PATH)) {
+		log_stderr("failure: is_setgid");
+		goto out;
+	}
 
-static const struct test_struct t_nested_userns[] = {
-	{ nested_userns,						T_REQUIRE_IDMAPPED_MOUNTS,	"test that nested user namespaces behave correctly when attached to idmapped mounts",		},
-};
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
 
-const struct test_suite s_nested_userns = {
-	.tests = t_nested_userns,
-	.nr_tests = ARRAY_SIZE(t_nested_userns),
-};
+	open_tree_fd = sys_open_tree(info->t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
 
-/* Test for commit 968219708108 ("fs: handle circular mappings correctly"). */
-static const struct test_struct t_setattr_fix_968219708108[] = {
-	{ setattr_fix_968219708108,					T_REQUIRE_IDMAPPED_MOUNTS,	"test that setattr works correctly",								},
-};
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
 
-const struct test_suite s_setattr_fix_968219708108 = {
-	.tests = t_setattr_fix_968219708108,
-	.nr_tests = ARRAY_SIZE(t_setattr_fix_968219708108),
-};
+	supported = openat_tmpfile_supported(open_tree_fd);
 
-/* Test for commit 705191b03d50 ("fs: fix acl translation"). */
-static const struct test_struct t_setxattr_fix_705191b03d50[] = {
-	{ setxattr_fix_705191b03d50,					T_REQUIRE_USERNS,	"test that setxattr works correctly for userns mountable filesystems",				},
-};
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		umask(S_IXGRP);
+		mode = umask(S_IXGRP);
+		if (!(mode & S_IXGRP))
+			die("failure: umask");
 
-const struct test_suite s_setxattr_fix_705191b03d50 = {
-	.tests = t_setxattr_fix_705191b03d50,
-	.nr_tests = ARRAY_SIZE(t_setxattr_fix_705191b03d50),
-};
+		/* The group permissions correspond to the permissions of the
+		 * ACL_MASK entry. Use setfacl to set ACL mask(m) as rw, so now
+		 * the group permissions is rw. Also, umask doesn't affect
+		 * group permissions because umask will be ignored if having
+		 * acl.
+		 */
+		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rw,o::rwx,m:rw %s/%s", info->t_mountpoint, T_DIR1);
+		if (system(t_buf))
+			die("failure: system");
 
-static const struct test_struct t_setgid_create_umask_idmapped_mounts[] = {
-	{ setgid_create_umask_idmapped,					T_REQUIRE_IDMAPPED_MOUNTS,	"create operations by using umask in directories with setgid bit set on idmapped mount",		},
-	{ setgid_create_umask_idmapped_in_userns,			T_REQUIRE_IDMAPPED_MOUNTS,	"create operations by using umask in directories with setgid bit set on idmapped mount inside userns",	},
-};
+		if (!switch_ids(10000, 11000))
+			die("failure: switch fsids");
 
-const struct test_suite s_setgid_create_umask_idmapped_mounts = {
-	.tests = t_setgid_create_umask_idmapped_mounts,
-	.nr_tests = ARRAY_SIZE(t_setgid_create_umask_idmapped_mounts),
+		/* create regular file via open() */
+		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
+		if (file1_fd < 0)
+			die("failure: create");
+
+		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
+		 * bit needs to be stripped.
+		 */
+		if (is_setgid(open_tree_fd, FILE1, 0))
+			die("failure: is_setgid");
+
+		if (is_ixgrp(open_tree_fd, FILE1, 0))
+			die("failure: is_ixgrp");
+
+		/* create directory */
+		if (mkdirat(open_tree_fd, DIR1, 0000))
+			die("failure: create");
+
+		if (xfs_irix_sgid_inherit_enabled(info->t_fstype)) {
+			/* We're not in_group_p(). */
+			if (is_setgid(open_tree_fd, DIR1, 0))
+				die("failure: is_setgid");
+		} else {
+			/* Directories always inherit the setgid bit. */
+			if (!is_setgid(open_tree_fd, DIR1, 0))
+				die("failure: is_setgid");
+		}
+
+		if (is_ixgrp(open_tree_fd, DIR1, 0))
+			die("failure: is_ixgrp");
+
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		if (is_ixgrp(open_tree_fd, FILE2, 0))
+			die("failure: is_ixgrp");
+
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
+		if (is_ixgrp(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_ixgrp");
+
+		/*
+		 * In setgid directories newly created files always inherit the
+		 * gid from the parent directory. Verify that the file is owned
+		 * by gid 10000, not by gid 11000.
+		 */
+		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		/*
+		 * In setgid directories newly created directories always
+		 * inherit the gid from the parent directory. Verify that the
+		 * directory is owned by gid 10000, not by gid 11000.
+		 */
+		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, open_tree_fd, FILE3, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (is_setgid(open_tree_fd, FILE3, 0))
+				die("failure: is_setgid");
+			if (is_ixgrp(open_tree_fd, FILE3, 0))
+				die("failure: is_ixgrp");
+			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 10000, 10000))
+				die("failure: check ownership");
+			if (unlinkat(open_tree_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		umask(S_IXGRP);
+		mode = umask(S_IXGRP);
+		if (!(mode & S_IXGRP))
+			die("failure: umask");
+
+		/* The group permissions correspond to the permissions of the
+		 * ACL_GROUP_OBJ entry. Don't use setfacl to set ACL_MASK, so
+		 * the group permissions is equal to ACL_GROUP_OBJ(g)
+		 * entry(rwx). Also, umask doesn't affect group permissions
+		 * because umask will be ignored if having acl.
+		 */
+		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rwx,o::rwx, %s/%s", info->t_mountpoint, T_DIR1);
+		if (system(t_buf))
+			die("failure: system");
+
+		if (!switch_ids(10000, 11000))
+			die("failure: switch fsids");
+
+		/* create regular file via open() */
+		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
+		if (file1_fd < 0)
+			die("failure: create");
+
+		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
+		 * bit needs to be stripped.
+		 */
+		if (is_setgid(open_tree_fd, FILE1, 0))
+			die("failure: is_setgid");
+
+		if (!is_ixgrp(open_tree_fd, FILE1, 0))
+			die("failure: is_ixgrp");
+
+		/* create directory */
+		if (mkdirat(open_tree_fd, DIR1, 0000))
+			die("failure: create");
+
+		if (xfs_irix_sgid_inherit_enabled(info->t_fstype)) {
+			/* We're not in_group_p(). */
+			if (is_setgid(open_tree_fd, DIR1, 0))
+				die("failure: is_setgid");
+		} else {
+			/* Directories always inherit the setgid bit. */
+			if (!is_setgid(open_tree_fd, DIR1, 0))
+				die("failure: is_setgid");
+		}
+
+		if (is_ixgrp(open_tree_fd, DIR1, 0))
+			die("failure: is_ixgrp");
+
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		if (!is_ixgrp(open_tree_fd, FILE2, 0))
+			die("failure: is_ixgrp");
+
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
+		if (!is_ixgrp(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_ixgrp");
+
+		/*
+		 * In setgid directories newly created files always inherit the
+		 * gid from the parent directory. Verify that the file is owned
+		 * by gid 10000, not by gid 11000.
+		 */
+		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		/*
+		 * In setgid directories newly created directories always
+		 * inherit the gid from the parent directory. Verify that the
+		 * directory is owned by gid 10000, not by gid 11000.
+		 */
+		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 10000, 10000))
+			die("failure: check ownership");
+
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, open_tree_fd, FILE3, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (is_setgid(open_tree_fd, FILE3, 0))
+				die("failure: is_setgid");
+			if (!is_ixgrp(open_tree_fd, FILE3, 0))
+				die("failure: is_ixgrp");
+			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 10000, 10000))
+				die("failure: check ownership");
+			if (unlinkat(open_tree_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+/*
+ * If the parent directory has a default acl then permissions are based off
+ * of that and current_umask() is ignored. Specifically, if the ACL has an
+ * ACL_MASK entry, the group permissions correspond to the permissions of
+ * the ACL_MASK entry. Otherwise, if the ACL has no ACL_MASK entry, the
+ * group permissions correspond to the permissions of the ACL_GROUP_OBJ
+ * entry.
+ *
+ * Use setfacl to check whether inode strip S_ISGID works correctly under
+ * the above two situations when enabling userns and idmapped feature.
+ *
+ * Test for commit
+ * 1639a49ccdce ("fs: move S_ISGID stripping into the vfs_*() helpers").
+ */
+static int setgid_create_acl_idmapped_in_userns(const struct vfstest_info *info)
+{
+	int fret = -1;
+	int file1_fd = -EBADF, open_tree_fd = -EBADF;
+	struct mount_attr attr = {
+		.attr_set = MOUNT_ATTR_IDMAP,
+	};
+	pid_t pid;
+	int tmpfile_fd = -EBADF;
+	bool supported = false;
+	char path[PATH_MAX];
+	mode_t mode;
+
+	if (!caps_supported())
+		return 0;
+
+	if (fchmod(info->t_dir1_fd, S_IRUSR |
+			      S_IWUSR |
+			      S_IRGRP |
+			      S_IWGRP |
+			      S_IROTH |
+			      S_IWOTH |
+			      S_IXUSR |
+			      S_IXGRP |
+			      S_IXOTH |
+			      S_ISGID), 0) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* Verify that the sid bits got raised. */
+	if (!is_setgid(info->t_dir1_fd, "", AT_EMPTY_PATH)) {
+		log_stderr("failure: is_setgid");
+		goto out;
+	}
+
+	/* Changing mount properties on a detached mount. */
+	attr.userns_fd	= get_userns_fd(0, 10000, 10000);
+	if (attr.userns_fd < 0) {
+		log_stderr("failure: get_userns_fd");
+		goto out;
+	}
+
+	open_tree_fd = sys_open_tree(info->t_dir1_fd, "",
+				     AT_EMPTY_PATH |
+				     AT_NO_AUTOMOUNT |
+				     AT_SYMLINK_NOFOLLOW |
+				     OPEN_TREE_CLOEXEC |
+				     OPEN_TREE_CLONE);
+	if (open_tree_fd < 0) {
+		log_stderr("failure: sys_open_tree");
+		goto out;
+	}
+
+	if (sys_mount_setattr(open_tree_fd, "", AT_EMPTY_PATH, &attr, sizeof(attr))) {
+		log_stderr("failure: sys_mount_setattr");
+		goto out;
+	}
+
+	supported = openat_tmpfile_supported(open_tree_fd);
+
+	/*
+	 * Below we verify that setgid inheritance for a newly created file or
+	 * directory works correctly. As part of this we need to verify that
+	 * newly created files or directories inherit their gid from their
+	 * parent directory. So we change the parent directorie's gid to 1000
+	 * and create a file with fs{g,u}id 0 and verify that the newly created
+	 * file and directory inherit gid 1000, not 0.
+	 */
+	if (fchownat(info->t_dir1_fd, "", -1, 1000, AT_SYMLINK_NOFOLLOW | AT_EMPTY_PATH)) {
+		log_stderr("failure: fchownat");
+		goto out;
+	}
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		umask(S_IXGRP);
+		mode = umask(S_IXGRP);
+		if (!(mode & S_IXGRP))
+			die("failure: umask");
+
+		/* The group permissions correspond to the permissions of the
+		 * ACL_MASK entry. Use setfacl to set ACL mask(m) as rw, so now
+		 * the group permissions is rw. Also, umask doesn't affect
+		 * group permissions because umask will be ignored if having
+		 * acl.
+		 */
+		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rw,o::rwx,m:rw %s/%s", info->t_mountpoint, T_DIR1);
+		if (system(t_buf))
+			die("failure: system");
+
+		if (!caps_supported()) {
+			log_debug("skip: capability library not installed");
+			exit(EXIT_SUCCESS);
+		}
+
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (!caps_down_fsetid())
+			die("failure: caps_down_fsetid");
+
+		/* create regular file via open() */
+		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
+		if (file1_fd < 0)
+			die("failure: create");
+
+		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
+		 * bit needs to be stripped.
+		 */
+		if (is_setgid(open_tree_fd, FILE1, 0))
+			die("failure: is_setgid");
+
+		if (is_ixgrp(open_tree_fd, FILE1, 0))
+			die("failure: is_ixgrp");
+
+		/* create directory */
+		if (mkdirat(open_tree_fd, DIR1, 0000))
+			die("failure: create");
+
+		if (xfs_irix_sgid_inherit_enabled(info->t_fstype)) {
+			/* We're not in_group_p(). */
+			if (is_setgid(open_tree_fd, DIR1, 0))
+				die("failure: is_setgid");
+		} else {
+			/* Directories always inherit the setgid bit. */
+			if (!is_setgid(open_tree_fd, DIR1, 0))
+				die("failure: is_setgid");
+		}
+
+		if (is_ixgrp(open_tree_fd, DIR1, 0))
+			die("failure: is_ixgrp");
+
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		if (is_ixgrp(open_tree_fd, FILE2, 0))
+			die("failure: is_ixgrp");
+
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
+		if (is_ixgrp(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_ixgrp");
+
+		/*
+		 * In setgid directories newly created files always inherit the
+		 * gid from the parent directory. Verify that the file is owned
+		 * by gid 1000, not by gid 0.
+		 */
+		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 1000))
+			die("failure: check ownership");
+
+		/*
+		 * In setgid directories newly created directories always
+		 * inherit the gid from the parent directory. Verify that the
+		 * directory is owned by gid 1000, not by gid 0.
+		 */
+		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 1000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 0, 1000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 0, 1000))
+			die("failure: check ownership");
+
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, open_tree_fd, FILE3, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (is_setgid(open_tree_fd, FILE3, 0))
+				die("failure: is_setgid");
+			if (is_ixgrp(open_tree_fd, FILE3, 0))
+				die("failure: is_ixgrp");
+			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 0, 1000))
+				die("failure: check ownership");
+			if (unlinkat(open_tree_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		umask(S_IXGRP);
+		mode = umask(S_IXGRP);
+		if (!(mode & S_IXGRP))
+			die("failure: umask");
+
+		/* The group permissions correspond to the permissions of the
+		 * ACL_GROUP_OBJ entry. Don't use setfacl to set ACL_MASK, so
+		 * the group permissions is equal to ACL_GROUP_OBJ(g)
+		 * entry(rwx). Also, umask doesn't affect group permissions
+		 * because umask will be ignored if having acl.
+		 */
+		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rwx,o::rwx, %s/%s", info->t_mountpoint, T_DIR1);
+		if (system(t_buf))
+			die("failure: system");
+
+		if (!caps_supported()) {
+			log_debug("skip: capability library not installed");
+			exit(EXIT_SUCCESS);
+		}
+
+		if (!switch_userns(attr.userns_fd, 0, 0, false))
+			die("failure: switch_userns");
+
+		if (!caps_down_fsetid())
+			die("failure: caps_down_fsetid");
+
+		/* create regular file via open() */
+		file1_fd = openat(open_tree_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
+		if (file1_fd < 0)
+			die("failure: create");
+
+		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
+		 * bit needs to be stripped.
+		 */
+		if (is_setgid(open_tree_fd, FILE1, 0))
+			die("failure: is_setgid");
+
+		if (!is_ixgrp(open_tree_fd, FILE1, 0))
+			die("failure: is_ixgrp");
+
+		/* create directory */
+		if (mkdirat(open_tree_fd, DIR1, 0000))
+			die("failure: create");
+
+		if (xfs_irix_sgid_inherit_enabled(info->t_fstype)) {
+			/* We're not in_group_p(). */
+			if (is_setgid(open_tree_fd, DIR1, 0))
+				die("failure: is_setgid");
+		} else {
+			/* Directories always inherit the setgid bit. */
+			if (!is_setgid(open_tree_fd, DIR1, 0))
+				die("failure: is_setgid");
+		}
+
+		if (is_ixgrp(open_tree_fd, DIR1, 0))
+			die("failure: is_ixgrp");
+
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(open_tree_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		if (!is_ixgrp(open_tree_fd, FILE2, 0))
+			 die("failure: is_ixgrp");
+		/* create a whiteout device via mknodat() vfs_mknod */
+		if (mknodat(open_tree_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(open_tree_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
+		if (!is_ixgrp(open_tree_fd, CHRDEV1, 0))
+			 die("failure: is_ixgrp");
+
+		/*
+		 * In setgid directories newly created files always inherit the
+		 * gid from the parent directory. Verify that the file is owned
+		 * by gid 1000, not by gid 0.
+		 */
+		if (!expected_uid_gid(open_tree_fd, FILE1, 0, 0, 1000))
+			die("failure: check ownership");
+
+		/*
+		 * In setgid directories newly created directories always
+		 * inherit the gid from the parent directory. Verify that the
+		 * directory is owned by gid 1000, not by gid 0.
+		 */
+		if (!expected_uid_gid(open_tree_fd, DIR1, 0, 0, 1000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, FILE2, 0, 0, 1000))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(open_tree_fd, CHRDEV1, 0, 0, 1000))
+			die("failure: check ownership");
+
+		if (unlinkat(open_tree_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(open_tree_fd, CHRDEV1, 0))
+			die("failure: delete");
+
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(open_tree_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			snprintf(path, PATH_MAX,  "/proc/self/fd/%d", tmpfile_fd);
+			if (linkat(AT_FDCWD, path, open_tree_fd, FILE3, AT_SYMLINK_FOLLOW))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (is_setgid(open_tree_fd, FILE3, 0))
+				die("failure: is_setgid");
+			if (!is_ixgrp(open_tree_fd, FILE3, 0))
+				die("failure: is_ixgrp");
+			if (!expected_uid_gid(open_tree_fd, FILE3, 0, 0, 1000))
+				die("failure: check ownership");
+			if (unlinkat(open_tree_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(attr.userns_fd);
+	safe_close(file1_fd);
+	safe_close(open_tree_fd);
+
+	return fret;
+}
+
+static const struct test_struct t_idmapped_mounts[] = {
+	{ acls,                                                         true,   "posix acls on regular mounts",                                                                 },
+	{ create_in_userns,                                             true,   "create operations in user namespace",                                                          },
+	{ device_node_in_userns,                                        true,   "device node in user namespace",                                                                },
+	{ expected_uid_gid_idmapped_mounts,				true,	"expected ownership on idmapped mounts",							},
+	{ fscaps_idmapped_mounts,					true,	"fscaps on idmapped mounts",									},
+	{ fscaps_idmapped_mounts_in_userns,				true,	"fscaps on idmapped mounts in user namespace",							},
+	{ fscaps_idmapped_mounts_in_userns_separate_userns,		true,	"fscaps on idmapped mounts in user namespace with different id mappings",			},
+	{ fsids_mapped,                                                 true,   "mapped fsids",                                                                                 },
+	{ fsids_unmapped,                                               true,   "unmapped fsids",                                                                               },
+	{ hardlink_crossing_idmapped_mounts,				true,	"cross idmapped mount hardlink",								},
+	{ hardlink_from_idmapped_mount,					true,	"hardlinks from idmapped mounts",								},
+	{ hardlink_from_idmapped_mount_in_userns,			true,	"hardlinks from idmapped mounts in user namespace",						},
+#ifdef HAVE_LIBURING_H
+	{ io_uring_idmapped,						true,	"io_uring from idmapped mounts",								},
+	{ io_uring_idmapped_userns,					true,	"io_uring from idmapped mounts in user namespace",						},
+	{ io_uring_idmapped_unmapped,					true,	"io_uring from idmapped mounts with unmapped ids",						},
+	{ io_uring_idmapped_unmapped_userns,				true,	"io_uring from idmapped mounts with unmapped ids in user namespace",				},
+#endif
+	{ protected_symlinks_idmapped_mounts,				true,	"following protected symlinks on idmapped mounts",						},
+	{ protected_symlinks_idmapped_mounts_in_userns,			true,	"following protected symlinks on idmapped mounts in user namespace",				},
+	{ rename_crossing_idmapped_mounts,				true,	"cross idmapped mount rename",									},
+	{ rename_from_idmapped_mount,					true,	"rename from idmapped mounts",									},
+	{ rename_from_idmapped_mount_in_userns,				true,	"rename from idmapped mounts in user namespace",						},
+	{ setattr_truncate_idmapped,					true,	"setattr truncate on idmapped mounts",								},
+	{ setattr_truncate_idmapped_in_userns,				true,	"setattr truncate on idmapped mounts in user namespace",					},
+	{ setgid_create_idmapped,					true,	"create operations in directories with setgid bit set on idmapped mounts",			},
+	{ setgid_create_idmapped_in_userns,				true,	"create operations in directories with setgid bit set on idmapped mounts in user namespace",	},
+	{ setid_binaries_idmapped_mounts,				true,	"setid binaries on idmapped mounts",								},
+	{ setid_binaries_idmapped_mounts_in_userns,			true,	"setid binaries on idmapped mounts in user namespace",						},
+	{ setid_binaries_idmapped_mounts_in_userns_separate_userns,	true,	"setid binaries on idmapped mounts in user namespace with different id mappings",		},
+	{ sticky_bit_unlink_idmapped_mounts,				true,	"sticky bit unlink operations on idmapped mounts",						},
+	{ sticky_bit_unlink_idmapped_mounts_in_userns,			true,	"sticky bit unlink operations on idmapped mounts in user namespace",				},
+	{ sticky_bit_rename_idmapped_mounts,				true,	"sticky bit rename operations on idmapped mounts",						},
+	{ sticky_bit_rename_idmapped_mounts_in_userns,			true,	"sticky bit rename operations on idmapped mounts in user namespace",				},
+	{ symlink_idmapped_mounts,					true,	"symlink from idmapped mounts",									},
+	{ symlink_idmapped_mounts_in_userns,				true,	"symlink from idmapped mounts in user namespace",						},
+};
+
+const struct test_suite s_idmapped_mounts = {
+	.tests		= t_idmapped_mounts,
+	.nr_tests	= ARRAY_SIZE(t_idmapped_mounts),
+};
+
+static const struct test_struct t_fscaps_in_ancestor_userns[] = {
+	{ fscaps_idmapped_mounts_in_userns_valid_in_ancestor_userns,	true,	"fscaps on idmapped mounts in user namespace writing fscap valid in ancestor userns",		},
+};
+
+const struct test_suite s_fscaps_in_ancestor_userns = {
+	.tests		= t_fscaps_in_ancestor_userns,
+	.nr_tests	= ARRAY_SIZE(t_fscaps_in_ancestor_userns),
+};
+
+static const struct test_struct t_nested_userns[] = {
+	{ nested_userns,						T_REQUIRE_IDMAPPED_MOUNTS,	"test that nested user namespaces behave correctly when attached to idmapped mounts",		},
+};
+
+const struct test_suite s_nested_userns = {
+	.tests = t_nested_userns,
+	.nr_tests = ARRAY_SIZE(t_nested_userns),
+};
+
+/* Test for commit 968219708108 ("fs: handle circular mappings correctly"). */
+static const struct test_struct t_setattr_fix_968219708108[] = {
+	{ setattr_fix_968219708108,					T_REQUIRE_IDMAPPED_MOUNTS,	"test that setattr works correctly",								},
+};
+
+const struct test_suite s_setattr_fix_968219708108 = {
+	.tests = t_setattr_fix_968219708108,
+	.nr_tests = ARRAY_SIZE(t_setattr_fix_968219708108),
+};
+
+/* Test for commit 705191b03d50 ("fs: fix acl translation"). */
+static const struct test_struct t_setxattr_fix_705191b03d50[] = {
+	{ setxattr_fix_705191b03d50,					T_REQUIRE_USERNS,	"test that setxattr works correctly for userns mountable filesystems",				},
+};
+
+const struct test_suite s_setxattr_fix_705191b03d50 = {
+	.tests = t_setxattr_fix_705191b03d50,
+	.nr_tests = ARRAY_SIZE(t_setxattr_fix_705191b03d50),
+};
+
+static const struct test_struct t_setgid_create_umask_idmapped_mounts[] = {
+	{ setgid_create_umask_idmapped,					T_REQUIRE_IDMAPPED_MOUNTS,	"create operations by using umask in directories with setgid bit set on idmapped mount",		},
+	{ setgid_create_umask_idmapped_in_userns,			T_REQUIRE_IDMAPPED_MOUNTS,	"create operations by using umask in directories with setgid bit set on idmapped mount inside userns",	},
+};
+
+const struct test_suite s_setgid_create_umask_idmapped_mounts = {
+	.tests = t_setgid_create_umask_idmapped_mounts,
+	.nr_tests = ARRAY_SIZE(t_setgid_create_umask_idmapped_mounts),
+};
+
+static const struct test_struct t_setgid_create_acl_idmapped_mounts[] = {
+	{ setgid_create_acl_idmapped,					T_REQUIRE_IDMAPPED_MOUNTS,	"create operations by using acl in directories with setgid bit set on idmapped mount",                },
+	{ setgid_create_acl_idmapped_in_userns,				T_REQUIRE_IDMAPPED_MOUNTS,	"create operations by using acl in directories with setgid bit set on idmapped mount inside userns",  },
+};
+
+const struct test_suite s_setgid_create_acl_idmapped_mounts = {
+	.tests = t_setgid_create_acl_idmapped_mounts,
+	.nr_tests = ARRAY_SIZE(t_setgid_create_acl_idmapped_mounts),
 };
diff --git a/src/vfs/idmapped-mounts.h b/src/vfs/idmapped-mounts.h
index a9fb31ea..3b0f0825 100644
--- a/src/vfs/idmapped-mounts.h
+++ b/src/vfs/idmapped-mounts.h
@@ -15,5 +15,6 @@ extern const struct test_suite s_nested_userns;
 extern const struct test_suite s_setattr_fix_968219708108;
 extern const struct test_suite s_setxattr_fix_705191b03d50;
 extern const struct test_suite s_setgid_create_umask_idmapped_mounts;
+extern const struct test_suite s_setgid_create_acl_idmapped_mounts;
 
 #endif /* __IDMAPPED_MOUNTS_H */
diff --git a/src/vfs/vfstest.c b/src/vfs/vfstest.c
index d430807c..20ade869 100644
--- a/src/vfs/vfstest.c
+++ b/src/vfs/vfstest.c
@@ -27,6 +27,8 @@
 #include "missing.h"
 #include "utils.h"
 
+static char t_buf[PATH_MAX];
+
 static void init_vfstest_info(struct vfstest_info *info)
 {
 	info->t_overflowuid		= 65534;
@@ -1912,6 +1914,336 @@ out:
 	return fret;
 }
 
+/*
+ * If the parent directory has a default acl then permissions are based off
+ * of that and current_umask() is ignored. Specifically, if the ACL has an
+ * ACL_MASK entry, the group permissions correspond to the permissions of
+ * the ACL_MASK entry. Otherwise, if the ACL has no ACL_MASK entry, the
+ * group permissions correspond to the permissions of the ACL_GROUP_OBJ
+ * entry.
+ *
+ * Use setfacl to check whether inode strip S_ISGID works correctly under
+ * the above two situations.
+ *
+ * Test for commit
+ * 1639a49ccdce ("fs: move S_ISGID stripping into the vfs_*() helpers").
+ */
+static int setgid_create_acl(const struct vfstest_info *info)
+{
+	int fret = -1;
+	int file1_fd = -EBADF;
+	int tmpfile_fd = -EBADF;
+	pid_t pid;
+	bool supported = false;
+	mode_t mode;
+
+	if (!caps_supported())
+		return 0;
+
+	if (fchmod(info->t_dir1_fd, S_IRUSR |
+			      S_IWUSR |
+			      S_IRGRP |
+			      S_IWGRP |
+			      S_IROTH |
+			      S_IWOTH |
+			      S_IXUSR |
+			      S_IXGRP |
+			      S_IXOTH |
+			      S_ISGID), 0) {
+		log_stderr("failure: fchmod");
+		goto out;
+	}
+
+	/* Verify that the setgid bit got raised. */
+	if (!is_setgid(info->t_dir1_fd, "", AT_EMPTY_PATH)) {
+		log_stderr("failure: is_setgid");
+		goto out;
+	}
+
+	supported = openat_tmpfile_supported(info->t_dir1_fd);
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		umask(S_IXGRP);
+		mode = umask(S_IXGRP);
+		if (!(mode & S_IXGRP))
+			die("failure: umask");
+
+		/* The group permissions correspond to the permissions of the
+		 * ACL_MASK entry. Use setfacl to set ACL mask(m) as rw, so now
+		 * the group permissions is rw. Also, umask doesn't affect
+		 * group permissions because umask will be ignored if having
+		 * acl.
+		 */
+		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rw,o::rwx,m:rw %s/%s", info->t_mountpoint, T_DIR1);
+		if (system(t_buf))
+			die("failure: system");
+
+		if (!switch_ids(0, 10000))
+			die("failure: switch_ids");
+
+		if (!caps_down_fsetid())
+			die("failure: caps_down_fsetid");
+
+		/* create regular file via open() */
+		file1_fd = openat(info->t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
+		if (file1_fd < 0)
+			die("failure: create");
+
+		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
+		 * bit needs to be stripped.
+		 */
+		if (is_setgid(info->t_dir1_fd, FILE1, 0))
+			die("failure: is_setgid");
+
+		if (is_ixgrp(info->t_dir1_fd, FILE1, 0))
+			die("failure: is_ixgrp");
+
+		/* create directory */
+		if (mkdirat(info->t_dir1_fd, DIR1, 0000))
+			die("failure: create");
+
+		if (xfs_irix_sgid_inherit_enabled(info->t_fstype)) {
+			/* We're not in_group_p(). */
+			if (is_setgid(info->t_dir1_fd, DIR1, 0))
+				die("failure: is_setgid");
+		} else {
+			/* Directories always inherit the setgid bit. */
+			if (!is_setgid(info->t_dir1_fd, DIR1, 0))
+				die("failure: is_setgid");
+		}
+
+		if (is_ixgrp(info->t_dir1_fd, DIR1, 0))
+			die("failure: is_ixgrp");
+
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(info->t_dir1_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(info->t_dir1_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		if (is_ixgrp(info->t_dir1_fd, FILE2, 0))
+			die("failure: is_ixgrp");
+
+		/* create a character device via mknodat() vfs_mknod */
+		if (mknodat(info->t_dir1_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, makedev(5, 1)))
+			die("failure: mknodat");
+
+		if (is_setgid(info->t_dir1_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
+		if (is_ixgrp(info->t_dir1_fd, CHRDEV1, 0))
+			die("failure: is_ixgrp");
+
+		/*
+		 * In setgid directories newly created files always inherit the
+		 * gid from the parent directory. Verify that the file is owned
+		 * by gid 0, not by gid 10000.
+		 */
+		if (!expected_uid_gid(info->t_dir1_fd, FILE1, 0, 0, 0))
+			die("failure: check ownership");
+
+		/*
+		 * In setgid directories newly created directories always
+		 * inherit the gid from the parent directory. Verify that the
+		 * directory is owned by gid 0, not by gid 10000.
+		 */
+		if (!expected_uid_gid(info->t_dir1_fd, DIR1, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(info->t_dir1_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(info->t_dir1_fd, CHRDEV1, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (unlinkat(info->t_dir1_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(info->t_dir1_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
+		if (unlinkat(info->t_dir1_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(info->t_dir1_fd, CHRDEV1, 0))
+			die("failure: delete");
+
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(info->t_dir1_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			if (linkat(tmpfile_fd, "", info->t_dir1_fd, FILE3, AT_EMPTY_PATH))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (is_setgid(info->t_dir1_fd, FILE3, 0))
+				die("failure: is_setgid");
+			if (is_ixgrp(info->t_dir1_fd, FILE3, 0))
+				die("failure: is_ixgrp");
+			if (!expected_uid_gid(info->t_dir1_fd, FILE3, 0, 0, 0))
+				die("failure: check ownership");
+			if (unlinkat(info->t_dir1_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	pid = fork();
+	if (pid < 0) {
+		log_stderr("failure: fork");
+		goto out;
+	}
+	if (pid == 0) {
+		umask(S_IXGRP);
+		mode = umask(S_IXGRP);
+		if (!(mode & S_IXGRP))
+			die("failure: umask");
+
+		/* The group permissions correspond to the permissions of the
+		 * ACL_GROUP_OBJ entry. Don't use setfacl to set ACL_MASK, so
+		 * the group permissions is equal to ACL_GROUP_OBJ(g)
+		 * entry(rwx). Also, umask doesn't affect group permissions
+		 * because umask will be ignored if having acl.
+		 */
+		snprintf(t_buf, sizeof(t_buf), "setfacl -d -m u::rwx,g::rwx,o::rwx, %s/%s", info->t_mountpoint, T_DIR1);
+		if (system(t_buf))
+			die("failure: system");
+
+		if (!switch_ids(0, 10000))
+			die("failure: switch_ids");
+
+		if (!caps_down_fsetid())
+			die("failure: caps_down_fsetid");
+
+		/* create regular file via open() */
+		file1_fd = openat(info->t_dir1_fd, FILE1, O_CREAT | O_EXCL | O_CLOEXEC, S_IXGRP | S_ISGID);
+		if (file1_fd < 0)
+			die("failure: create");
+
+		/* Neither in_group_p() nor capable_wrt_inode_uidgid() so setgid
+		 * bit needs to be stripped.
+		 */
+		if (is_setgid(info->t_dir1_fd, FILE1, 0))
+			die("failure: is_setgid");
+
+		if (!is_ixgrp(info->t_dir1_fd, FILE1, 0))
+			die("failure: is_ixgrp");
+
+		/* create directory */
+		if (mkdirat(info->t_dir1_fd, DIR1, 0000))
+			die("failure: create");
+
+		if (xfs_irix_sgid_inherit_enabled(info->t_fstype)) {
+			/* We're not in_group_p(). */
+			if (is_setgid(info->t_dir1_fd, DIR1, 0))
+				die("failure: is_setgid");
+		} else {
+			/* Directories always inherit the setgid bit. */
+			if (!is_setgid(info->t_dir1_fd, DIR1, 0))
+				die("failure: is_setgid");
+		}
+
+		if (is_ixgrp(info->t_dir1_fd, DIR1, 0))
+			die("failure: is_ixgrp");
+
+		/* create a special file via mknodat() vfs_create */
+		if (mknodat(info->t_dir1_fd, FILE2, S_IFREG | S_ISGID | S_IXGRP, 0))
+			die("failure: mknodat");
+
+		if (is_setgid(info->t_dir1_fd, FILE2, 0))
+			die("failure: is_setgid");
+
+		if (!is_ixgrp(info->t_dir1_fd, FILE2, 0))
+			die("failure: is_ixgrp");
+
+		/* create a character device via mknodat() vfs_mknod */
+		if (mknodat(info->t_dir1_fd, CHRDEV1, S_IFCHR | S_ISGID | S_IXGRP, makedev(5, 1)))
+			die("failure: mknodat");
+
+		if (is_setgid(info->t_dir1_fd, CHRDEV1, 0))
+			die("failure: is_setgid");
+
+		if (!is_ixgrp(info->t_dir1_fd, CHRDEV1, 0))
+			die("failure: is_ixgrp");
+
+		/*
+		 * In setgid directories newly created files always inherit the
+		 * gid from the parent directory. Verify that the file is owned
+		 * by gid 0, not by gid 10000.
+		 */
+		if (!expected_uid_gid(info->t_dir1_fd, FILE1, 0, 0, 0))
+			die("failure: check ownership");
+
+		/*
+		 * In setgid directories newly created directories always
+		 * inherit the gid from the parent directory. Verify that the
+		 * directory is owned by gid 0, not by gid 10000.
+		 */
+		if (!expected_uid_gid(info->t_dir1_fd, DIR1, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(info->t_dir1_fd, FILE2, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (!expected_uid_gid(info->t_dir1_fd, CHRDEV1, 0, 0, 0))
+			die("failure: check ownership");
+
+		if (unlinkat(info->t_dir1_fd, FILE1, 0))
+			die("failure: delete");
+
+		if (unlinkat(info->t_dir1_fd, DIR1, AT_REMOVEDIR))
+			die("failure: delete");
+
+		if (unlinkat(info->t_dir1_fd, FILE2, 0))
+			die("failure: delete");
+
+		if (unlinkat(info->t_dir1_fd, CHRDEV1, 0))
+			die("failure: delete");
+
+		/* create tmpfile via filesystem tmpfile api */
+		if (supported) {
+			tmpfile_fd = openat(info->t_dir1_fd, ".", O_TMPFILE | O_RDWR, S_IXGRP | S_ISGID);
+			if (tmpfile_fd < 0)
+				die("failure: create");
+			/* link the temporary file into the filesystem, making it permanent */
+			if (linkat(tmpfile_fd, "", info->t_dir1_fd, FILE3, AT_EMPTY_PATH))
+				die("failure: linkat");
+			if (close(tmpfile_fd))
+				die("failure: close");
+			if (is_setgid(info->t_dir1_fd, FILE3, 0))
+				die("failure: is_setgid");
+			if (!is_ixgrp(info->t_dir1_fd, FILE3, 0))
+				die("failure: is_ixgrp");
+			if (!expected_uid_gid(info->t_dir1_fd, FILE3, 0, 0, 0))
+				die("failure: check ownership");
+			if (unlinkat(info->t_dir1_fd, FILE3, 0))
+				die("failure: delete");
+		}
+
+		exit(EXIT_SUCCESS);
+	}
+	if (wait_for_pid(pid))
+		goto out;
+
+	fret = 0;
+	log_debug("Ran test");
+out:
+	safe_close(file1_fd);
+
+	return fret;
+}
+
 static int setattr_truncate(const struct vfstest_info *info)
 {
 	int fret = -1;
@@ -1987,6 +2319,7 @@ static void usage(void)
 	fprintf(stderr, "--test-setattr-fix-968219708108     Run setattr regression tests\n");
 	fprintf(stderr, "--test-setxattr-fix-705191b03d50    Run setxattr regression tests\n");
 	fprintf(stderr, "--test-setgid-create-umask          Run setgid with umask tests\n");
+	fprintf(stderr, "--test-setgid-create-acl            Run setgid with acl tests\n");
 
 	_exit(EXIT_SUCCESS);
 }
@@ -2006,6 +2339,7 @@ static const struct option longopts[] = {
 	{"test-setattr-fix-968219708108",	no_argument,		0,	'i'},
 	{"test-setxattr-fix-705191b03d50",	no_argument,		0,	'j'},
 	{"test-setgid-create-umask",		no_argument,		0,	'u'},
+	{"test-setgid-create-acl",		no_argument,		0,	'l'},
 	{NULL,					0,			0,	  0},
 };
 
@@ -2040,6 +2374,15 @@ static const struct test_suite s_setgid_create_umask = {
 	.nr_tests = ARRAY_SIZE(t_setgid_create_umask),
 };
 
+static const struct test_struct t_setgid_create_acl[] = {
+	{ setgid_create_acl,						0,			"create operations in directories with setgid bit set under posix acl",				},
+};
+
+static const struct test_suite s_setgid_create_acl = {
+	.tests = t_setgid_create_acl,
+	.nr_tests = ARRAY_SIZE(t_setgid_create_acl),
+};
+
 static bool run_test(struct vfstest_info *info, const struct test_struct suite[], size_t suite_size)
 {
 	int i;
@@ -2138,7 +2481,7 @@ int main(int argc, char *argv[])
 	     test_core = false, test_fscaps_regression = false,
 	     test_nested_userns = false, test_setattr_fix_968219708108 = false,
 	     test_setxattr_fix_705191b03d50 = false,
-	     test_setgid_create_umask = false;
+	     test_setgid_create_umask = false, test_setgid_create_acl = false;
 
 	init_vfstest_info(&info);
 
@@ -2183,6 +2526,9 @@ int main(int argc, char *argv[])
 		case 'u':
 			test_setgid_create_umask = true;
 			break;
+		case 'l':
+			test_setgid_create_acl = true;
+			break;
 		case 'h':
 			/* fallthrough */
 		default:
@@ -2268,6 +2614,14 @@ int main(int argc, char *argv[])
 			goto out;
 	}
 
+	if (test_setgid_create_acl) {
+		if (!run_suite(&info, &s_setgid_create_acl))
+			goto out;
+
+		if (!run_suite(&info, &s_setgid_create_acl_idmapped_mounts))
+			goto out;
+	}
+
 	fret = EXIT_SUCCESS;
 
 out:
diff --git a/tests/generic/999 b/tests/generic/999
new file mode 100755
index 00000000..0c73e90e
--- /dev/null
+++ b/tests/generic/999
@@ -0,0 +1,33 @@
+#! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2022 Fujitsu Limited. All Rights Reserved.
+#
+# FS QA Test No. 999
+#
+# Test S_ISGID stripping whether works correctly when call process
+# uses posix acl.
+#
+# It is also a regression test for
+# commit 1639a49ccdce ("fs: move S_ISGID stripping into the vfs_*() helpers")
+
+. ./common/preamble
+_begin_fstest auto quick cap acl idmapped mount perms rw unlink
+
+# Import common functions.
+. ./common/filter
+. ./common/attr
+
+# real QA test starts here
+
+_supported_fs generic
+_require_test
+_require_acls
+_fixed_by_kernel_commit 1639a49ccdce \
+	"fs: move S_ISGID stripping into the vfs_*() helpers"
+
+$here/src/vfs/vfstest --test-setgid-create-acl \
+        --device "$TEST_DEV" --mount "$TEST_DIR" --fstype "$FSTYP"
+
+echo "Silence is golden"
+status=0
+exit
diff --git a/tests/generic/999.out b/tests/generic/999.out
new file mode 100644
index 00000000..3b276ca8
--- /dev/null
+++ b/tests/generic/999.out
@@ -0,0 +1,2 @@
+QA output created by 999
+Silence is golden
-- 
2.27.0

