Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8ED5C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 12 May 2022 16:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356462AbiELQxK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 12:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356452AbiELQxJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 12:53:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31AC63EA93
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 09:53:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01B3662014
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 16:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68970C34117;
        Thu, 12 May 2022 16:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652374386;
        bh=ejkBTEojxpvSRZopCnPu4E6QpGqlANXIPIyrf/Blvac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cs8U2F8k81/C1a7hPq7LcNYNcJh4l+i59L0Nt7s3J33JVtp/qXW9FNKAukHX+aQun
         nY9E4g1cyxAgESfY1uTvhsuSJbUyxc6BxOXVMKXWtqCWrJ3f95CDeKpo3fciVWefHU
         /fefYEYua6ptFZV2GYQ74Fy5k9ZXHbB1B20vdwnrD74OVkXP85Vc/Dt+vPJjVl3hwY
         iyI6dGn0HXeILW+VD75/pSpYqJihYyD5+WY96wsSBOkIFBsEKwVLkIrgVBZu4a47/e
         ECqt9uumz5GkB7o00lv2EBfGzWQRGBD8eSDnpBdOC3wWeE0IVjmQ30FnihShTv4Uus
         BrM7CnDpDBuSg==
From:   Christian Brauner <brauner@kernel.org>
To:     Zorro Lang <zlang@redhat.com>, fstests <fstests@vger.kernel.org>
Cc:     Christian Brauner <brauner@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Eryu Guan <guaneryu@gmail.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH v2 01/13] idmapped-mounts: make all tests set their required feature flags
Date:   Thu, 12 May 2022 18:52:38 +0200
Message-Id: <20220512165250.450989-2-brauner@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220512165250.450989-1-brauner@kernel.org>
References: <20220512165250.450989-1-brauner@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9070; h=from:subject; bh=ejkBTEojxpvSRZopCnPu4E6QpGqlANXIPIyrf/Blvac=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMSTVWrvt2uxt7X371I/gzrUPpz+6cX3VtRalq9ntQqruzW5r HF/HdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwk6hEjw0Lv8HCOq/KfGm5vDP05/R GD39PVj/ZkHEs92Lh+79vkdc6MDFc9VG1Oak+9eP3Zh7lrebP7v914c3z2ApOVzqmbvKUOTOMFAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

In commit 858a19c5e9b0 ("idmapped_mounts: Prepare for support for more
features") we introduced a flag argument to check for multiple features
and then decide based on the flag argument whether a test requires a
given feature and skip it if the kernel doesn't provide it.

However, not all tests were ported to the new flag argument and still
use the old infrastructure. Port them all.

Fixes: 858a19c5e9b0 ("idmapped_mounts: Prepare for support for more features")
Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 src/idmapped-mounts/idmapped-mounts.c | 56 +++++++++++++--------------
 src/idmapped-mounts/utils.h           |  4 ++
 2 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index f3873e52..e06185b7 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -14308,10 +14308,6 @@ static const struct option longopts[] = {
 	{NULL,					0,			0,	  0},
 };
 
-/* Flags for which functionality is required by the test */
-#define T_REQUIRE_IDMAPPED_MOUNTS (1U << 0)
-#define T_REQUIRE_USERNS (1U << 1)
-
 struct t_idmapped_mounts {
 	int (*test)(void);
 	unsigned int support_flags;
@@ -14369,46 +14365,46 @@ struct t_idmapped_mounts {
 };
 
 struct t_idmapped_mounts fscaps_in_ancestor_userns[] = {
-	{ fscaps_idmapped_mounts_in_userns_valid_in_ancestor_userns,	true,	"fscaps on idmapped mounts in user namespace writing fscap valid in ancestor userns",		},
+	{ fscaps_idmapped_mounts_in_userns_valid_in_ancestor_userns,	T_REQUIRE_IDMAPPED_MOUNTS,	"fscaps on idmapped mounts in user namespace writing fscap valid in ancestor userns",		},
 };
 
 struct t_idmapped_mounts t_nested_userns[] = {
-	{ nested_userns,						true,	"test that nested user namespaces behave correctly when attached to idmapped mounts",		},
+	{ nested_userns,						T_REQUIRE_IDMAPPED_MOUNTS,	"test that nested user namespaces behave correctly when attached to idmapped mounts",		},
 };
 
 struct t_idmapped_mounts t_btrfs[] = {
-	{ btrfs_subvolumes_fsids_mapped,				true,	"test subvolumes with mapped fsids",								},
-	{ btrfs_subvolumes_fsids_mapped_userns,				true, 	"test subvolumes with mapped fsids inside user namespace",					},
-	{ btrfs_subvolumes_fsids_mapped_user_subvol_rm_allowed,		true, 	"test subvolume deletion with user_subvol_rm_allowed mount option",				},
-	{ btrfs_subvolumes_fsids_mapped_userns_user_subvol_rm_allowed,	true, 	"test subvolume deletion with user_subvol_rm_allowed mount option inside user namespace",	},
-	{ btrfs_subvolumes_fsids_unmapped,				true, 	"test subvolumes with unmapped fsids",								},
-	{ btrfs_subvolumes_fsids_unmapped_userns,			true, 	"test subvolumes with unmapped fsids inside user namespace",					},
-	{ btrfs_snapshots_fsids_mapped,					true, 	"test snapshots with mapped fsids",								},
-	{ btrfs_snapshots_fsids_mapped_userns,				true, 	"test snapshots with mapped fsids inside user namespace",					},
-	{ btrfs_snapshots_fsids_mapped_user_subvol_rm_allowed,		true, 	"test snapshots deletion with user_subvol_rm_allowed mount option",				},
-	{ btrfs_snapshots_fsids_mapped_userns_user_subvol_rm_allowed,	true, 	"test snapshots deletion with user_subvol_rm_allowed mount option inside user namespace",	},
-	{ btrfs_snapshots_fsids_unmapped,				true, 	"test snapshots with unmapped fsids",								},
-	{ btrfs_snapshots_fsids_unmapped_userns,			true, 	"test snapshots with unmapped fsids inside user namespace",					},
-	{ btrfs_delete_by_spec_id,					true, 	"test subvolume deletion by spec id",								},
-	{ btrfs_subvolumes_setflags_fsids_mapped,			true, 	"test subvolume flags with mapped fsids",							},
-	{ btrfs_subvolumes_setflags_fsids_mapped_userns,		true, 	"test subvolume flags with mapped fsids inside user namespace",					},
-	{ btrfs_subvolumes_setflags_fsids_unmapped,			true, 	"test subvolume flags with unmapped fsids",							},
-	{ btrfs_subvolumes_setflags_fsids_unmapped_userns,		true, 	"test subvolume flags with unmapped fsids inside user namespace",				},
-	{ btrfs_snapshots_setflags_fsids_mapped,			true, 	"test snapshots flags with mapped fsids",							},
-	{ btrfs_snapshots_setflags_fsids_mapped_userns,			true, 	"test snapshots flags with mapped fsids inside user namespace",					},
-	{ btrfs_snapshots_setflags_fsids_unmapped,			true, 	"test snapshots flags with unmapped fsids",							},
-	{ btrfs_snapshots_setflags_fsids_unmapped_userns,		true, 	"test snapshots flags with unmapped fsids inside user namespace",				},
-	{ btrfs_subvolume_lookup_user,					true, 	"test unprivileged subvolume lookup",								},
+	{ btrfs_subvolumes_fsids_mapped,				T_REQUIRE_IDMAPPED_MOUNTS,	"test subvolumes with mapped fsids",								},
+	{ btrfs_subvolumes_fsids_mapped_userns,				T_REQUIRE_IDMAPPED_MOUNTS, 	"test subvolumes with mapped fsids inside user namespace",					},
+	{ btrfs_subvolumes_fsids_mapped_user_subvol_rm_allowed,		T_REQUIRE_IDMAPPED_MOUNTS, 	"test subvolume deletion with user_subvol_rm_allowed mount option",				},
+	{ btrfs_subvolumes_fsids_mapped_userns_user_subvol_rm_allowed,	T_REQUIRE_IDMAPPED_MOUNTS, 	"test subvolume deletion with user_subvol_rm_allowed mount option inside user namespace",	},
+	{ btrfs_subvolumes_fsids_unmapped,				T_REQUIRE_IDMAPPED_MOUNTS, 	"test subvolumes with unmapped fsids",								},
+	{ btrfs_subvolumes_fsids_unmapped_userns,			T_REQUIRE_IDMAPPED_MOUNTS, 	"test subvolumes with unmapped fsids inside user namespace",					},
+	{ btrfs_snapshots_fsids_mapped,					T_REQUIRE_IDMAPPED_MOUNTS, 	"test snapshots with mapped fsids",								},
+	{ btrfs_snapshots_fsids_mapped_userns,				T_REQUIRE_IDMAPPED_MOUNTS, 	"test snapshots with mapped fsids inside user namespace",					},
+	{ btrfs_snapshots_fsids_mapped_user_subvol_rm_allowed,		T_REQUIRE_IDMAPPED_MOUNTS, 	"test snapshots deletion with user_subvol_rm_allowed mount option",				},
+	{ btrfs_snapshots_fsids_mapped_userns_user_subvol_rm_allowed,	T_REQUIRE_IDMAPPED_MOUNTS, 	"test snapshots deletion with user_subvol_rm_allowed mount option inside user namespace",	},
+	{ btrfs_snapshots_fsids_unmapped,				T_REQUIRE_IDMAPPED_MOUNTS, 	"test snapshots with unmapped fsids",								},
+	{ btrfs_snapshots_fsids_unmapped_userns,			T_REQUIRE_IDMAPPED_MOUNTS, 	"test snapshots with unmapped fsids inside user namespace",					},
+	{ btrfs_delete_by_spec_id,					T_REQUIRE_IDMAPPED_MOUNTS, 	"test subvolume deletion by spec id",								},
+	{ btrfs_subvolumes_setflags_fsids_mapped,			T_REQUIRE_IDMAPPED_MOUNTS, 	"test subvolume flags with mapped fsids",							},
+	{ btrfs_subvolumes_setflags_fsids_mapped_userns,		T_REQUIRE_IDMAPPED_MOUNTS, 	"test subvolume flags with mapped fsids inside user namespace",					},
+	{ btrfs_subvolumes_setflags_fsids_unmapped,			T_REQUIRE_IDMAPPED_MOUNTS, 	"test subvolume flags with unmapped fsids",							},
+	{ btrfs_subvolumes_setflags_fsids_unmapped_userns,		T_REQUIRE_IDMAPPED_MOUNTS, 	"test subvolume flags with unmapped fsids inside user namespace",				},
+	{ btrfs_snapshots_setflags_fsids_mapped,			T_REQUIRE_IDMAPPED_MOUNTS, 	"test snapshots flags with mapped fsids",							},
+	{ btrfs_snapshots_setflags_fsids_mapped_userns,			T_REQUIRE_IDMAPPED_MOUNTS, 	"test snapshots flags with mapped fsids inside user namespace",					},
+	{ btrfs_snapshots_setflags_fsids_unmapped,			T_REQUIRE_IDMAPPED_MOUNTS, 	"test snapshots flags with unmapped fsids",							},
+	{ btrfs_snapshots_setflags_fsids_unmapped_userns,		T_REQUIRE_IDMAPPED_MOUNTS, 	"test snapshots flags with unmapped fsids inside user namespace",				},
+	{ btrfs_subvolume_lookup_user,					T_REQUIRE_IDMAPPED_MOUNTS, 	"test unprivileged subvolume lookup",								},
 };
 
 /* Test for commit 968219708108 ("fs: handle circular mappings correctly"). */
 struct t_idmapped_mounts t_setattr_fix_968219708108[] = {
-	{ setattr_fix_968219708108,					true,	"test that setattr works correctly",								},
+	{ setattr_fix_968219708108,					T_REQUIRE_IDMAPPED_MOUNTS,	"test that setattr works correctly",								},
 };
 
 /* Test for commit 705191b03d50 ("fs: fix acl translation"). */
 struct t_idmapped_mounts t_setxattr_fix_705191b03d50[] = {
-	{ setxattr_fix_705191b03d50,					false,	"test that setxattr works correctly for userns mountable filesystems",				},
+	{ setxattr_fix_705191b03d50,					T_REQUIRE_USERNS,		"test that setxattr works correctly for userns mountable filesystems",				},
 };
 
 static bool run_test(struct t_idmapped_mounts suite[], size_t suite_size)
diff --git a/src/idmapped-mounts/utils.h b/src/idmapped-mounts/utils.h
index afb3c228..a62a4844 100644
--- a/src/idmapped-mounts/utils.h
+++ b/src/idmapped-mounts/utils.h
@@ -20,6 +20,10 @@
 
 #include "missing.h"
 
+/* Flags for which functionality is required by the test */
+#define T_REQUIRE_IDMAPPED_MOUNTS (1U << 0)
+#define T_REQUIRE_USERNS (1U << 1)
+
 /* Maximum number of nested user namespaces in the kernel. */
 #define MAX_USERNS_LEVEL 32
 
-- 
2.34.1

