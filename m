Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6798AC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 12 May 2022 16:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356710AbiELQxS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 12:53:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356452AbiELQxR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 12:53:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B5EA6E8D9
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 09:53:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E9C8B82732
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 16:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01772C385B8;
        Thu, 12 May 2022 16:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652374394;
        bh=Mhs4Gi2t5EgP8oQonialW5lJ3KsGFJRy4DNaW0UfLNY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLIjaTF5AA0tyUS/te2O1e/lsl/QeQG/PzrDBYVdmnsYNLwz1uOIENW8qFeNm0dw8
         nMOBn1aXSHmB4zdnLlS+QQnDRh6cIqS3lAOeGn3odbU0ZNsPwQLcgEuBVUbSGpWQu5
         ZjYCbea0O0ooLeYhxh4qBiNyk9Za/IqnmFDtbYQg4Rwea2MtfxbSbb+MKlU1RnxJIx
         Bw/cS+5lhN0GI7vsreE/xfcY48OlORoyFyiICW6la5A0dOpUp8jYUFwDe8C2TiT/q3
         hpTk0drNLsdnzPX3LlGwBNv6YlbnZSq1sW4fYSMyZpU08jC1dSN/Wl3h9JeNbbtrOb
         tvtw1Ghn6vn+w==
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2 04/13] vfstest: rename struct t_idmapped_mounts
Date:   Thu, 12 May 2022 18:52:41 +0200
Message-Id: <20220512165250.450989-5-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220512165250.450989-1-brauner@kernel.org>
References: <20220512165250.450989-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4202; h=from:subject; bh=Mhs4Gi2t5EgP8oQonialW5lJ3KsGFJRy4DNaW0UfLNY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTVWrsnrJ30QSSotVfuu31pYeuhPDHr7d/EVmyM2Mhrwms7 3+V0RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQyExgZnpVvuJMS2vTE81xwBvuJti vMq74qPUmTPV/1s/O+msPEUIbfLIqHlzlz+T08/PTu+tI1m9s/mpkvk+wrX/DjifYZwUZtRgA=
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
Acked-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 src/vfs/utils.h   |  6 ++++++
 src/vfs/vfstest.c | 20 ++++++++------------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/src/vfs/utils.h b/src/vfs/utils.h
index a62a4844..c1024646 100644
--- a/src/vfs/utils.h
+++ b/src/vfs/utils.h
@@ -53,6 +53,12 @@
 		__internal_ret__;                             \
 	})
 
+struct test_struct {
+	int (*test)(void);
+	unsigned int support_flags;
+	const char *description;
+};
+
 typedef enum idmap_type_t {
 	ID_TYPE_UID,
 	ID_TYPE_GID
diff --git a/src/vfs/vfstest.c b/src/vfs/vfstest.c
index 7f57b777..e615c4e1 100644
--- a/src/vfs/vfstest.c
+++ b/src/vfs/vfstest.c
@@ -14308,11 +14308,7 @@ static const struct option longopts[] = {
 	{NULL,					0,			0,	  0},
 };
 
-struct t_idmapped_mounts {
-	int (*test)(void);
-	unsigned int support_flags;
-	const char *description;
-} basic_suite[] = {
+struct test_struct basic_suite[] = {
 	{ acls,								T_REQUIRE_IDMAPPED_MOUNTS,	"posix acls on regular mounts",									},
 	{ create_in_userns,						T_REQUIRE_IDMAPPED_MOUNTS,	"create operations in user namespace",								},
 	{ device_node_in_userns,					T_REQUIRE_IDMAPPED_MOUNTS,	"device node in user namespace",								},
@@ -14364,15 +14360,15 @@ struct t_idmapped_mounts {
 	{ threaded_idmapped_mount_interactions,				T_REQUIRE_IDMAPPED_MOUNTS,	"threaded operations on idmapped mounts",							},
 };
 
-struct t_idmapped_mounts fscaps_in_ancestor_userns[] = {
+struct test_struct fscaps_in_ancestor_userns[] = {
 	{ fscaps_idmapped_mounts_in_userns_valid_in_ancestor_userns,	T_REQUIRE_IDMAPPED_MOUNTS,	"fscaps on idmapped mounts in user namespace writing fscap valid in ancestor userns",		},
 };
 
-struct t_idmapped_mounts t_nested_userns[] = {
+struct test_struct t_nested_userns[] = {
 	{ nested_userns,						T_REQUIRE_IDMAPPED_MOUNTS,	"test that nested user namespaces behave correctly when attached to idmapped mounts",		},
 };
 
-struct t_idmapped_mounts t_btrfs[] = {
+struct test_struct t_btrfs[] = {
 	{ btrfs_subvolumes_fsids_mapped,				T_REQUIRE_IDMAPPED_MOUNTS,	"test subvolumes with mapped fsids",								},
 	{ btrfs_subvolumes_fsids_mapped_userns,				T_REQUIRE_IDMAPPED_MOUNTS, 	"test subvolumes with mapped fsids inside user namespace",					},
 	{ btrfs_subvolumes_fsids_mapped_user_subvol_rm_allowed,		T_REQUIRE_IDMAPPED_MOUNTS, 	"test subvolume deletion with user_subvol_rm_allowed mount option",				},
@@ -14398,21 +14394,21 @@ struct t_idmapped_mounts t_btrfs[] = {
 };
 
 /* Test for commit 968219708108 ("fs: handle circular mappings correctly"). */
-struct t_idmapped_mounts t_setattr_fix_968219708108[] = {
+struct test_struct t_setattr_fix_968219708108[] = {
 	{ setattr_fix_968219708108,					T_REQUIRE_IDMAPPED_MOUNTS,	"test that setattr works correctly",								},
 };
 
 /* Test for commit 705191b03d50 ("fs: fix acl translation"). */
-struct t_idmapped_mounts t_setxattr_fix_705191b03d50[] = {
+struct test_struct t_setxattr_fix_705191b03d50[] = {
 	{ setxattr_fix_705191b03d50,					T_REQUIRE_USERNS,		"test that setxattr works correctly for userns mountable filesystems",				},
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
2.34.1

