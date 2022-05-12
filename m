Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BDD9C433FE
	for <linux-fstests@archiver.kernel.org>; Thu, 12 May 2022 16:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356711AbiELQx3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 12:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356714AbiELQx3 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 12:53:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF24F268677
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 09:53:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C33862014
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 16:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8F6C34100;
        Thu, 12 May 2022 16:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652374406;
        bh=jjUXdSMgZ8h248Sn6rE0VZFQA4f1HbQNHpTnKtCFmic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZQubGDx2/8XbbBmy83NfCgMY4cR2lQRWzgi2ZdIzj8q5FYHdJtHqL/ndmzGl3CEp
         Vmo7DTawBVHAZBQGjFh1qdSca6O8PGvuSGFwGq4OxhayfPweL97/4iG+pF/qGw4Xen
         JBIel1ys2sdjQ+caNFZoNOtVk3hEMZmhYEp80lIOIqsu49Qw4r42cneTKNo8JUMuiW
         DC14mN2MjFp2dcaz1+M/7EIdV3qUJI46TNPMBDM8wdBHUXXrQv3r8sj3ly8KNpJ00W
         tPiyyf5LUpadgHuZuqcgwu8CsEl9wuzl1/LN9jhM5R+BZ/+r1iqtiuB2nFv7NCFsj2
         cNftw/hKCzjuA==
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2 09/13] utils: add struct test_suite
Date:   Thu, 12 May 2022 18:52:46 +0200
Message-Id: <20220512165250.450989-10-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220512165250.450989-1-brauner@kernel.org>
References: <20220512165250.450989-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6627; h=from:subject; bh=jjUXdSMgZ8h248Sn6rE0VZFQA4f1HbQNHpTnKtCFmic=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTVWnv2rj6rwV1drlHwO+j6pA2W2/hc7psvqY30433I5N7H GNffUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJFILUaGFzligjPCTRf+LLTRuWBxXv W2yN3rnsIHFZ2Y131Suc63keF/lNvhmVJpPZrb5xd7fX8Q/fry9Iy9q2aGmfvNsvu/99QeDgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Provide a convenient wrapper struct which provides the tests and the
number of tests. The struct can be kept local to each source file so we
are sure that the tests and number of tests is correct.

In vfstest.c we provide a run_suite() function which expects a struct
test_suite and runs the tests provided by that suite.

Cc: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests <fstests@vger.kernel.org>
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 src/vfs/utils.h   |  5 ++++
 src/vfs/vfstest.c | 66 +++++++++++++++++++++++++++++++++++------------
 2 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/src/vfs/utils.h b/src/vfs/utils.h
index d8ec3c5e..226daea7 100644
--- a/src/vfs/utils.h
+++ b/src/vfs/utils.h
@@ -205,6 +205,11 @@ struct test_struct {
 	const char *description;
 };
 
+struct test_suite {
+	size_t nr_tests;
+	const struct test_struct *tests;
+};
+
 typedef enum idmap_type_t {
 	ID_TYPE_UID,
 	ID_TYPE_GID
diff --git a/src/vfs/vfstest.c b/src/vfs/vfstest.c
index 1d71b25b..6e14cff9 100644
--- a/src/vfs/vfstest.c
+++ b/src/vfs/vfstest.c
@@ -13633,7 +13633,7 @@ static const struct option longopts[] = {
 	{NULL,					0,			0,	  0},
 };
 
-struct test_struct basic_suite[] = {
+static const struct test_struct t_basic[] = {
 	{ acls,								T_REQUIRE_IDMAPPED_MOUNTS,	"posix acls on regular mounts",									},
 	{ create_in_userns,						T_REQUIRE_IDMAPPED_MOUNTS,	"create operations in user namespace",								},
 	{ device_node_in_userns,					T_REQUIRE_IDMAPPED_MOUNTS,	"device node in user namespace",								},
@@ -13685,15 +13685,30 @@ struct test_struct basic_suite[] = {
 	{ threaded_idmapped_mount_interactions,				T_REQUIRE_IDMAPPED_MOUNTS,	"threaded operations on idmapped mounts",							},
 };
 
-struct test_struct fscaps_in_ancestor_userns[] = {
+static const struct test_suite s_basic = {
+	.tests = t_basic,
+	.nr_tests = ARRAY_SIZE(t_basic),
+};
+
+static const struct test_struct t_fscaps_in_ancestor_userns[] = {
 	{ fscaps_idmapped_mounts_in_userns_valid_in_ancestor_userns,	T_REQUIRE_IDMAPPED_MOUNTS,	"fscaps on idmapped mounts in user namespace writing fscap valid in ancestor userns",		},
 };
 
-struct test_struct t_nested_userns[] = {
+static const struct test_suite s_fscaps_in_ancestor_userns = {
+	.tests = t_fscaps_in_ancestor_userns,
+	.nr_tests = ARRAY_SIZE(t_fscaps_in_ancestor_userns),
+};
+
+static const struct test_struct t_nested_userns[] = {
 	{ nested_userns,						T_REQUIRE_IDMAPPED_MOUNTS,	"test that nested user namespaces behave correctly when attached to idmapped mounts",		},
 };
 
-struct test_struct t_btrfs[] = {
+static const struct test_suite s_nested_userns = {
+	.tests = t_nested_userns,
+	.nr_tests = ARRAY_SIZE(t_nested_userns),
+};
+
+static const struct test_struct t_btrfs[] = {
 	{ btrfs_subvolumes_fsids_mapped,				T_REQUIRE_IDMAPPED_MOUNTS,	"test subvolumes with mapped fsids",								},
 	{ btrfs_subvolumes_fsids_mapped_userns,				T_REQUIRE_IDMAPPED_MOUNTS, 	"test subvolumes with mapped fsids inside user namespace",					},
 	{ btrfs_subvolumes_fsids_mapped_user_subvol_rm_allowed,		T_REQUIRE_IDMAPPED_MOUNTS, 	"test subvolume deletion with user_subvol_rm_allowed mount option",				},
@@ -13718,14 +13733,29 @@ struct test_struct t_btrfs[] = {
 	{ btrfs_subvolume_lookup_user,					T_REQUIRE_IDMAPPED_MOUNTS, 	"test unprivileged subvolume lookup",								},
 };
 
+static const struct test_suite s_btrfs = {
+	.tests = t_btrfs,
+	.nr_tests = ARRAY_SIZE(t_btrfs),
+};
+
 /* Test for commit 968219708108 ("fs: handle circular mappings correctly"). */
-struct test_struct t_setattr_fix_968219708108[] = {
+static const struct test_struct t_setattr_fix_968219708108[] = {
 	{ setattr_fix_968219708108,					T_REQUIRE_IDMAPPED_MOUNTS,	"test that setattr works correctly",								},
 };
 
+static const struct test_suite s_setattr_fix_968219708108 = {
+	.tests = t_setattr_fix_968219708108,
+	.nr_tests = ARRAY_SIZE(t_setattr_fix_968219708108),
+};
+
 /* Test for commit 705191b03d50 ("fs: fix acl translation"). */
-struct test_struct t_setxattr_fix_705191b03d50[] = {
-	{ setxattr_fix_705191b03d50,					T_REQUIRE_USERNS,		"test that setxattr works correctly for userns mountable filesystems",				},
+static const struct test_struct t_setxattr_fix_705191b03d50[] = {
+	{ setxattr_fix_705191b03d50,					T_REQUIRE_USERNS,	"test that setxattr works correctly for userns mountable filesystems",				},
+};
+
+static const struct test_suite s_setxattr_fix_705191b03d50 = {
+	.tests = t_setxattr_fix_705191b03d50,
+	.nr_tests = ARRAY_SIZE(t_setxattr_fix_705191b03d50),
 };
 
 static bool run_test(struct vfstest_info *info, const struct test_struct suite[], size_t suite_size)
@@ -13772,6 +13802,12 @@ static bool run_test(struct vfstest_info *info, const struct test_struct suite[]
 	return true;
 }
 
+static inline bool run_suite(struct vfstest_info *info,
+			     const struct test_suite *suite)
+{
+	return run_test(info, suite->tests, suite->nr_tests);
+}
+
 static bool fs_allow_idmap(const struct vfstest_info *info)
 {
 	int ret;
@@ -13913,29 +13949,25 @@ int main(int argc, char *argv[])
 
 	fret = EXIT_FAILURE;
 
-	if (test_core && !run_test(&info, basic_suite, ARRAY_SIZE(basic_suite)))
+	if (test_core && !run_suite(&info, &s_basic))
 		goto out;
 
 	if (test_fscaps_regression &&
-	    !run_test(&info, fscaps_in_ancestor_userns,
-		      ARRAY_SIZE(fscaps_in_ancestor_userns)))
+	    !run_suite(&info, &s_fscaps_in_ancestor_userns))
 		goto out;
 
-	if (test_nested_userns &&
-	    !run_test(&info, t_nested_userns, ARRAY_SIZE(t_nested_userns)))
+	if (test_nested_userns && !run_suite(&info, &s_nested_userns))
 		goto out;
 
-	if (test_btrfs && !run_test(&info, t_btrfs, ARRAY_SIZE(t_btrfs)))
+	if (test_btrfs && !run_suite(&info, &s_btrfs))
 		goto out;
 
 	if (test_setattr_fix_968219708108 &&
-	    !run_test(&info, t_setattr_fix_968219708108,
-		      ARRAY_SIZE(t_setattr_fix_968219708108)))
+	    !run_suite(&info, &s_setattr_fix_968219708108))
 		goto out;
 
 	if (test_setxattr_fix_705191b03d50 &&
-	    !run_test(&info, t_setxattr_fix_705191b03d50,
-		      ARRAY_SIZE(t_setxattr_fix_705191b03d50)))
+	    !run_suite(&info, &s_setxattr_fix_705191b03d50))
 		goto out;
 
 	fret = EXIT_SUCCESS;
-- 
2.34.1

