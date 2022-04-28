Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38157C4167B
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Apr 2022 15:16:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348963AbiD1PUC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 28 Apr 2022 11:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348950AbiD1PUB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Apr 2022 11:20:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B4FAFB03
        for <fstests@vger.kernel.org>; Thu, 28 Apr 2022 08:16:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11F7361F30
        for <fstests@vger.kernel.org>; Thu, 28 Apr 2022 15:16:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD8DC385AE;
        Thu, 28 Apr 2022 15:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651159004;
        bh=DI91Jk+x6vVn7OH2/LfAQYVjetiglO0xDfYszWy1F3A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WgEL4WK5SMk/77+KkArWmlEgDZqJo8uEGQCmMPuCzilcH8aoHiW0dSQ1HJRXSvhce
         xnDx3NB1RAaka32Sb5fv9ol3jzp4rmXOuqJCwVqZqIJnCncVJcfMGchq+3KLMyHYN/
         g37nV6V5e70nd/zSUavt/o6XosUStX7JJk/NNuW1KwHPx+UV2DORO8kHSIUmKinRpn
         Y9pLkDN11eNbZ89/eoD68wpu7MtLzeXr4G1yUcwA1W9WcRVky36SLEzrHGPDO/uBe0
         zwwf982RjLhOswo0ydAu0vZg5RUT534An/9ee3sd8veg/uUL/YtGyXh6gSLujHVKqw
         bOmTTWi7vAVGQ==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guaneryu@gmail.com>, Zorro Lang <zlang@redhat.com>,
        fstests <fstests@vger.kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 08/11] utils: add struct test_suite
Date:   Thu, 28 Apr 2022 17:15:56 +0200
Message-Id: <20220428151559.947144-9-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220428151559.947144-1-brauner@kernel.org>
References: <20220428151559.947144-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5520; h=from:subject; bh=DI91Jk+x6vVn7OH2/LfAQYVjetiglO0xDfYszWy1F3A=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRlrV/yomrLitrkHbH225dulzPK+uW1Kkk4/lqvpepbz/23 TGXzOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYi18PIcFi6b9Kmmw7y+ydMcfp/MZ mbt2n9JbtcIc+g6+tzXj64dJaR4VnYsVv67qbVE07nc6pGNi1jPbaVT+ARy7llu/O7FuZ1swIA
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
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 src/vfs/utils.h   |  5 +++++
 src/vfs/vfstest.c | 54 +++++++++++++++++++++++++++++++++++------------
 2 files changed, 46 insertions(+), 13 deletions(-)

diff --git a/src/vfs/utils.h b/src/vfs/utils.h
index 3f7cf911..a13efabb 100644
--- a/src/vfs/utils.h
+++ b/src/vfs/utils.h
@@ -198,6 +198,11 @@ struct test_struct {
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
index f6c8c194..e8025e81 100644
--- a/src/vfs/vfstest.c
+++ b/src/vfs/vfstest.c
@@ -13204,7 +13204,7 @@ static const struct option longopts[] = {
 	{NULL,					0,			0,	  0},
 };
 
-struct test_struct basic_suite[] = {
+static const struct test_struct t_basic[] = {
 	{ acls,								true,	"posix acls on regular mounts",									},
 	{ create_in_userns,						true,	"create operations in user namespace",								},
 	{ device_node_in_userns,					true,	"device node in user namespace",								},
@@ -13256,15 +13256,30 @@ struct test_struct basic_suite[] = {
 	{ threaded_idmapped_mount_interactions,				true,	"threaded operations on idmapped mounts",							},
 };
 
-struct test_struct fscaps_in_ancestor_userns[] = {
+static const struct test_suite s_basic = {
+	.tests = t_basic,
+	.nr_tests = ARRAY_SIZE(t_basic),
+};
+
+static const struct test_struct t_fscaps_in_ancestor_userns[] = {
 	{ fscaps_idmapped_mounts_in_userns_valid_in_ancestor_userns,	true,	"fscaps on idmapped mounts in user namespace writing fscap valid in ancestor userns",		},
 };
 
-struct test_struct t_nested_userns[] = {
+static const struct test_suite s_fscaps_in_ancestor_userns = {
+	.tests = t_fscaps_in_ancestor_userns,
+	.nr_tests = ARRAY_SIZE(t_fscaps_in_ancestor_userns),
+};
+
+static const struct test_struct t_nested_userns[] = {
 	{ nested_userns,						true,	"test that nested user namespaces behave correctly when attached to idmapped mounts",		},
 };
 
-struct test_struct t_btrfs[] = {
+static const struct test_suite s_nested_userns = {
+	.tests = t_nested_userns,
+	.nr_tests = ARRAY_SIZE(t_nested_userns),
+};
+
+static const struct test_struct t_btrfs[] = {
 	{ btrfs_subvolumes_fsids_mapped,				true,	"test subvolumes with mapped fsids",								},
 	{ btrfs_subvolumes_fsids_mapped_userns,				true, 	"test subvolumes with mapped fsids inside user namespace",					},
 	{ btrfs_subvolumes_fsids_mapped_user_subvol_rm_allowed,		true, 	"test subvolume deletion with user_subvol_rm_allowed mount option",				},
@@ -13289,11 +13304,21 @@ struct test_struct t_btrfs[] = {
 	{ btrfs_subvolume_lookup_user,					true, 	"test unprivileged subvolume lookup",								},
 };
 
+static const struct test_suite s_btrfs = {
+	.tests = t_btrfs,
+	.nr_tests = ARRAY_SIZE(t_btrfs),
+};
+
 /* Test for commit 968219708108 ("fs: handle circular mappings correctly"). */
-struct test_struct t_setattr_fix_968219708108[] = {
+static const struct test_struct t_setattr_fix_968219708108[] = {
 	{ setattr_fix_968219708108,					true,	"test that setattr works correctly",								},
 };
 
+static const struct test_suite s_setattr_fix_968219708108 = {
+	.tests = t_setattr_fix_968219708108,
+	.nr_tests = ARRAY_SIZE(t_setattr_fix_968219708108),
+};
+
 static bool run_test(struct vfstest_info *info, const struct test_struct suite[], size_t suite_size)
 {
 	int i;
@@ -13336,6 +13361,12 @@ static bool run_test(struct vfstest_info *info, const struct test_struct suite[]
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
@@ -13460,24 +13491,21 @@ int main(int argc, char *argv[])
 
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
 
 	fret = EXIT_SUCCESS;
-- 
2.32.0

