Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA0F9C4338F
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Aug 2021 18:21:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 993CC613A5
	for <linux-fstests@archiver.kernel.org>; Mon, 23 Aug 2021 18:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhHWSWV (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 23 Aug 2021 14:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231402AbhHWSWV (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 23 Aug 2021 14:22:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F0DB6138B;
        Mon, 23 Aug 2021 18:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629742898;
        bh=rt+7pl1ztNsGgrM0LBmTN9/PHoNtETeVBMCpJEegGFo=;
        h=Date:From:To:Cc:Subject:From;
        b=KB8BZD75b6W0AWhoCAmZYBNpmu+bK1pxxQH6COv+cB3dI+4zDJTczlsqL67pNNeHn
         UL89wQ637G4ESLmK4km6yoE3GEhJDOR0phDUKmJVwoQ/4PkxA92XyiIdCExcOn0TVt
         I+PGA4dX5HU5mZCuHPP1VcWy4tICyCw9F8OUPZTuIMbhaxbsVpWLKc6xl9FZ3CC8BG
         0dJSYqzNyhyXKsfXuKqjjCo9FxK3fD+uU00hQHrF2GkgkBS4g25m0NkEwlaM2+VjMF
         eVMDAwBSos8jQzgfL9RvwozBjtSsZg4PEJgm/5EJNkUhwi1KeiQys/xgRDZAeClWXM
         bOIswTGxg+rGg==
Date:   Mon, 23 Aug 2021 11:21:38 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org
Subject: [PATCH] idmap: override btrfs_ioctl_vol_args_v2 if system header
 doesn't have subvolid
Message-ID: <20210823182138.GF12612@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

The struct btrfs_ioctl_vol_args_v2 in /usr/include/linux/btrfs.h on my
system predates the inclusion of the "subvolid" field.  This causes the
following build failure:

idmapped-mounts.c: In function 'btrfs_delete_subvolume_id':
idmapped-mounts.c:9730:6: error: 'struct btrfs_ioctl_vol_args_v2' has no member named 'subvolid'
 9730 |  args.subvolid = subvolid;
      |      ^

Since this source file contains its own more uptodate copy of that
structure, add some more autoconf/cpp magic so that we can override the
struct definition if the system header doesn't have the desired field.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 configure.ac                          |    2 +-
 src/idmapped-mounts/idmapped-mounts.c |    6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4117a302..36960910 100644
--- a/configure.ac
+++ b/configure.ac
@@ -79,7 +79,7 @@ AC_CHECK_TYPES([struct btrfs_ioctl_ino_lookup_args], [], [], [[#include <linux/b
 AC_CHECK_TYPES([struct btrfs_ioctl_ino_lookup_user_args], [], [], [[#include <linux/btrfs.h>]])
 AC_CHECK_TYPES([struct btrfs_ioctl_get_subvol_rootref_args], [], [], [[#include <linux/btrfs.h>]])
 AC_CHECK_HEADERS([linux/btrfs.h linux/btrfs_tree.h])
-
+AC_CHECK_MEMBERS([struct btrfs_ioctl_vol_args_v2.subvolid], [], [], [[#include <linux/btrfs.h>]])
 
 AC_CONFIG_HEADER(include/config.h)
 AC_CONFIG_FILES([include/builddefs])
diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 78b7cc09..40eb2cc6 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -23,7 +23,11 @@
 #include <unistd.h>
 
 #ifdef HAVE_LINUX_BTRFS_H
+# ifndef HAVE_STRUCT_BTRFS_IOCTL_VOL_ARGS_V2_SUBVOLID
+#  define btrfs_ioctl_vol_args_v2 override_btrfs_ioctl_vol_args_v2
+# endif
 #include <linux/btrfs.h>
+# undef btrfs_ioctl_vol_args_v2
 #endif
 
 #ifdef HAVE_LINUX_BTRFS_TREE_H
@@ -9570,7 +9574,7 @@ struct btrfs_qgroup_inherit {
 };
 #endif
 
-#ifndef HAVE_STRUCT_BTRFS_IOCTL_VOL_ARGS_V2
+#if !defined(HAVE_STRUCT_BTRFS_IOCTL_VOL_ARGS_V2) || !defined(HAVE_STRUCT_BTRFS_IOCTL_VOL_ARGS_V2_SUBVOLID)
 
 #ifndef BTRFS_SUBVOL_NAME_MAX
 #define BTRFS_SUBVOL_NAME_MAX 4039
