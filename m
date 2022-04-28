Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC4E7C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 28 Apr 2022 15:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348927AbiD1PTs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 28 Apr 2022 11:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348919AbiD1PTr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Apr 2022 11:19:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9297EAF1F1
        for <fstests@vger.kernel.org>; Thu, 28 Apr 2022 08:16:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2FBD6B82DE8
        for <fstests@vger.kernel.org>; Thu, 28 Apr 2022 15:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2DE3C385AF;
        Thu, 28 Apr 2022 15:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651158990;
        bh=QoitQqxwnx8NW6C8v901NMYOU/k3OHQ39C4ImBMAFF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X1n8ztrNQT3ngWqBKWBv9mgwelVx+JshCL3w0SwI4iP17Kr12H8+9xuOQw0XDk0EK
         AcBe2jy+wMH3LyJKgoIRoSqNTM8NrtLSFL7IuTh4o5Muny1PBpK56JxXd7ieOxXt9H
         UCt1cvaJucF9KRbfneOqtYCqE332J88kMeqa1E6D05bm4ordHqrCGIBWcXd7mLKQOT
         iikRZJQO3zeVK+D1+6jlzMzYPlFFhMLsruhy7AXx4Tv25mt1Ngf1gK0XREfFM8BbX0
         MVMpZ7SD1R75TxZBfwDn/ZsliS4SqAjppnHBL8GWCcYAe827yken0XnXJo8MC8o4jn
         6wcC0iZJr14FA==
From:   Christian Brauner <brauner@kernel.org>
To:     Eryu Guan <guaneryu@gmail.com>, Zorro Lang <zlang@redhat.com>,
        fstests <fstests@vger.kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH 03/11] vfstest: rename struct t_idmapped_mounts
Date:   Thu, 28 Apr 2022 17:15:51 +0200
Message-Id: <20220428151559.947144-4-brauner@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220428151559.947144-1-brauner@kernel.org>
References: <20220428151559.947144-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3628; h=from:subject; bh=QoitQqxwnx8NW6C8v901NMYOU/k3OHQ39C4ImBMAFF8=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSRlrV+kuOTJSaUtO7eKdcp/S/2917AhUEFs/9biadffRL6a cPHEx45SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJ8Fgy/K+T5Gv5dba8MlPh0hbPk5 URm0Mj1a9fOcV6dnNnsKmUciTDP10Ohyf8ubc6/eebJRt/07/HEX44NaNJxjor7L1jyGVlNgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The idmapped mounts test suite has grown to cover a lot of generic vfs
functionality that is not concerned with idmapped mounts at all.

As was discussed upstream it's time to rename it to something that
reflects its generic nature.

Rename the basic structure used for the tests from struct
t_idmapped_mounts to struct test_struct.

Cc: Dave Chinner <david@fromorbit.com>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Eryu Guan <guaneryu@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests <fstests@vger.kernel.org>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 src/vfs/utils.h   |  6 ++++++
 src/vfs/vfstest.c | 18 +++++++-----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/src/vfs/utils.h b/src/vfs/utils.h
index afb3c228..06247ec7 100644
--- a/src/vfs/utils.h
+++ b/src/vfs/utils.h
@@ -49,6 +49,12 @@
 		__internal_ret__;                             \
 	})
 
+struct test_struct {
+	int (*test)(void);
+	bool require_fs_allow_idmap;
+	const char *description;
+};
+
 typedef enum idmap_type_t {
 	ID_TYPE_UID,
 	ID_TYPE_GID
diff --git a/src/vfs/vfstest.c b/src/vfs/vfstest.c
index 66768175..4d2fc93e 100644
--- a/src/vfs/vfstest.c
+++ b/src/vfs/vfstest.c
@@ -13829,11 +13829,7 @@ static const struct option longopts[] = {
 	{NULL,					0,			0,	  0},
 };
 
-struct t_idmapped_mounts {
-	int (*test)(void);
-	bool require_fs_allow_idmap;
-	const char *description;
-} basic_suite[] = {
+struct test_struct basic_suite[] = {
 	{ acls,								true,	"posix acls on regular mounts",									},
 	{ create_in_userns,						true,	"create operations in user namespace",								},
 	{ device_node_in_userns,					true,	"device node in user namespace",								},
@@ -13885,15 +13881,15 @@ struct t_idmapped_mounts {
 	{ threaded_idmapped_mount_interactions,				true,	"threaded operations on idmapped mounts",							},
 };
 
-struct t_idmapped_mounts fscaps_in_ancestor_userns[] = {
+struct test_struct fscaps_in_ancestor_userns[] = {
 	{ fscaps_idmapped_mounts_in_userns_valid_in_ancestor_userns,	true,	"fscaps on idmapped mounts in user namespace writing fscap valid in ancestor userns",		},
 };
 
-struct t_idmapped_mounts t_nested_userns[] = {
+struct test_struct t_nested_userns[] = {
 	{ nested_userns,						true,	"test that nested user namespaces behave correctly when attached to idmapped mounts",		},
 };
 
-struct t_idmapped_mounts t_btrfs[] = {
+struct test_struct t_btrfs[] = {
 	{ btrfs_subvolumes_fsids_mapped,				true,	"test subvolumes with mapped fsids",								},
 	{ btrfs_subvolumes_fsids_mapped_userns,				true, 	"test subvolumes with mapped fsids inside user namespace",					},
 	{ btrfs_subvolumes_fsids_mapped_user_subvol_rm_allowed,		true, 	"test subvolume deletion with user_subvol_rm_allowed mount option",				},
@@ -13919,16 +13915,16 @@ struct t_idmapped_mounts t_btrfs[] = {
 };
 
 /* Test for commit 968219708108 ("fs: handle circular mappings correctly"). */
-struct t_idmapped_mounts t_setattr_fix_968219708108[] = {
+struct test_struct t_setattr_fix_968219708108[] = {
 	{ setattr_fix_968219708108,					true,	"test that setattr works correctly",								},
 };
 
-static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
+static bool run_test(struct test_struct suite[], size_t suite_size)
 {
 	int i;
 
 	for (i = 0; i < suite_size; i++) {
-		struct t_idmapped_mounts *t = &suite[i];
+		struct test_struct *t = &suite[i];
 		int ret;
 		pid_t pid;
 
-- 
2.32.0

