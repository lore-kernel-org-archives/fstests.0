Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D74CC4320E
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Sep 2021 12:44:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC9E610E6
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Sep 2021 12:44:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344934AbhIAMpt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Sep 2021 08:45:49 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.4]:50455 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344932AbhIAMoI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Sep 2021 08:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1630500188; i=@fujitsu.com;
        bh=7t1cl61so5rXO3OHqWPlX0HlkbGnj9D+YuLcNFF8pFo=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=HhXTInUoJnA7L92+OMR0m6b+rRNj3ltzIdmg5FB+XYaLCj/xhOiySeh6k5ewfq85G
         EW3vjuEHozTl1bSSY63j64a4UR19dPPA4WMuzEipCq8nV7sty5hLqx+86muQnAKcFB
         N2qLAIR7QYxMNOqdH6lK7gmQAbDxt6CQR+Jjc27qLPb4vqS9zUVC8MgqViuTtMS/ui
         hUp40szi3bmN2WfSHv+AAViLiFRQ0CPmpVP6bozW2DPItFGEgqAYWhoQLKkz+LZRxu
         2FMEcDnvWlnQ664vm3zTCkcY/6BVbk9xe9EWN3KsibIau6vRH5yXQt7DeihSFB+RyT
         A8/QZAGfIFfeA==
Received: from [100.113.2.26] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta.az-a.eu-central-1.aws.symcld.net id 8E/76-29868-C557F216; Wed, 01 Sep 2021 12:43:08 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCIsWRWlGSWpSXmKPExsViZ8MRohtTqp9
  o0NgiY3G6ZS+7A6PH501yAYxRrJl5SfkVCawZM97fZS6Yqlex7dNNpgbGG6pdjFwcQgIdTBIP
  N09nhHB2M0p0rrvL0sXIycEmoCnxrHMBM4gtIiAr8X/GaiYQm1lAXWL5pF9gtrBAosSMY7vA6
  lkEVCS+f/0GVs8r4CnRP38JO4gtIaAgMeXhe6i4oMTJmU9YIOZISBx88YIZokZR4lLHN0YIu0
  Ji1qw2pgmMvLOQtMxC0rKAkWkVo2VSUWZ6RkluYmaOrqGBga6hobGuoa6RsZleYpVuol5qqW5
  yal5JUSJQVi+xvFivuDI3OSdFLy+1ZBMjMMBSChnf7GD8+vqD3iFGSQ4mJVFelkj9RCG+pPyU
  yozE4oz4otKc1OJDjDIcHEoSvLsygHKCRanpqRVpmTnAYIdJS3DwKInwLikESvMWFyTmFmemQ
  6ROMepy7Dw6bxGzEEtefl6qlDjvuhKgIgGQoozSPLgRsMi7xCgrJczLyMDAIMRTkFqUm1mCKv
  +KUZyDUUmYd3Yx0BSezLwSuE2vgI5gAjqC54cOyBEliQgpqQamhryfk2vSeOMy/n8NEek+mnd
  4x44zq4X4T2wUnOY82ZxrvQD7ihKW5aqu0lz6jiq/Zd7IZJySF7BXZZxeJrT8Fc/1ym0ulVpa
  1Rk67eaujC/SreqYzjSElc/j1Ftj7uPfU7DQuF1JSfnppx52blZunotlz072iXn61LKsYozLj
  hVPYOkT1vYW2mAs0fnklja7c06J/mfd5g+Cy1odz3QY5rJHKsvt3xyXMv1Da3v7JdHapzHLZJ
  1/Mi1fHOsuZMTwtnZp+b79m19z8xUvVJzCNkFcsfhJz7m7V2YEne7I4PeUSg9wnTNbRW0pV/u
  E753/HsvrBU6Ui1v/Xec9S6GIQw23at32Q0z9J/mUWIozEg21mIuKEwFkIAtdNwMAAA==
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-232.messagelabs.com!1630500188!4421!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 32469 invoked from network); 1 Sep 2021 12:43:08 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
  by server-6.tower-232.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Sep 2021 12:43:08 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 181Ch5a8026400
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Wed, 1 Sep 2021 13:43:08 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 1 Sep 2021 13:43:03 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v1 1/4] src/idmapped-mounts: Fix an error for the loop initialization declaration
Date:   Wed, 1 Sep 2021 20:43:23 +0800
Message-ID: <1630500206-15545-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 src/idmapped-mounts/idmapped-mounts.c | 30 +++++++++++++--------------
 src/idmapped-mounts/utils.c           |  3 ++-
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/src/idmapped-mounts/idmapped-mounts.c b/src/idmapped-mounts/idmapped-mounts.c
index 40eb2cc6..e83f8b04 100644
--- a/src/idmapped-mounts/idmapped-mounts.c
+++ b/src/idmapped-mounts/idmapped-mounts.c
@@ -8838,6 +8838,7 @@ static int nested_userns(void)
 	int fret = -1;
 	int ret;
 	pid_t pid;
+	unsigned int id;
 	struct list *it, *next;
 	struct userns_hierarchy hierarchy[] = {
 		{ .level = 1, .fd_userns = -EBADF, },
@@ -8979,7 +8980,7 @@ static int nested_userns(void)
 		goto out;
 	}
 
-	for (unsigned int id = 0; id <= id_file_range; id++) {
+	for (id = 0; id <= id_file_range; id++) {
 		char file[256];
 
 		snprintf(file, sizeof(file), DIR1 "/" FILE1 "_%u", id);
@@ -9067,7 +9068,7 @@ static int nested_userns(void)
 	}
 
 	/* Verify that ownership looks correct for callers in the init userns. */
-	for (unsigned int id = 0; id <= id_file_range; id++) {
+	for (id = 0; id <= id_file_range; id++) {
 		bool bret;
 		unsigned int id_level1, id_level2, id_level3;
 		char file[256];
@@ -9117,7 +9118,7 @@ static int nested_userns(void)
 		if (!switch_userns(attr_level1.userns_fd, 0, 0, false))
 			die("failure: switch_userns");
 
-		for (unsigned int id = 0; id <= id_file_range; id++) {
+		for (id = 0; id <= id_file_range; id++) {
 			bool bret;
 			unsigned int id_level1, id_level2, id_level3;
 			char file[256];
@@ -9164,7 +9165,7 @@ static int nested_userns(void)
 		if (!switch_userns(attr_level2.userns_fd, 0, 0, false))
 			die("failure: switch_userns");
 
-		for (unsigned int id = 0; id <= id_file_range; id++) {
+		for (id = 0; id <= id_file_range; id++) {
 			bool bret;
 			unsigned int id_level2, id_level3;
 			char file[256];
@@ -9210,7 +9211,7 @@ static int nested_userns(void)
 		if (!switch_userns(attr_level3.userns_fd, 0, 0, false))
 			die("failure: switch_userns");
 
-		for (unsigned int id = 0; id <= id_file_range; id++) {
+		for (id = 0; id <= id_file_range; id++) {
 			bool bret;
 			unsigned int id_level2, id_level3;
 			char file[256];
@@ -9267,7 +9268,7 @@ static int nested_userns(void)
 		if (setns(attr_level4.userns_fd, CLONE_NEWUSER))
 			die("failure: switch_userns");
 
-		for (unsigned int id = 0; id <= id_file_range; id++) {
+		for (id = 0; id <= id_file_range; id++) {
 			char file[256];
 
 			snprintf(file, sizeof(file), FILE1 "_%u", id);
@@ -9300,7 +9301,7 @@ static int nested_userns(void)
 		if (!switch_userns(attr_level1.userns_fd, 0, 0, false))
 			die("failure: switch_userns");
 
-		for (unsigned int id = 0; id <= id_file_range; id++) {
+		for (id = 0; id <= id_file_range; id++) {
 			bool bret;
 			unsigned int id_level1, id_level2, id_level3, id_new;
 			char file[256];
@@ -9355,7 +9356,7 @@ static int nested_userns(void)
 		if (!switch_userns(attr_level2.userns_fd, 0, 0, false))
 			die("failure: switch_userns");
 
-		for (unsigned int id = 0; id <= id_file_range; id++) {
+		for (id = 0; id <= id_file_range; id++) {
 			bool bret;
 			unsigned int id_level2, id_level3, id_new;
 			char file[256];
@@ -9409,7 +9410,7 @@ static int nested_userns(void)
 		if (!switch_userns(attr_level3.userns_fd, 0, 0, false))
 			die("failure: switch_userns");
 
-		for (unsigned int id = 0; id <= id_file_range; id++) {
+		for (id = 0; id <= id_file_range; id++) {
 			unsigned int id_new;
 			char file[256];
 
@@ -9479,7 +9480,7 @@ static int nested_userns(void)
 		if (setns(attr_level4.userns_fd, CLONE_NEWUSER))
 			die("failure: switch_userns");
 
-		for (unsigned int id = 0; id <= id_file_range; id++) {
+		for (id = 0; id <= id_file_range; id++) {
 			char file[256];
 			unsigned long id_new;
 
@@ -9909,7 +9910,6 @@ static int append_stack(struct btrfs_iter *iter, uint64_t tree_id, size_t path_l
 	if (iter->stack_len >= iter->stack_capacity) {
 		size_t new_capacity = iter->stack_capacity * 2;
 		struct btrfs_stack *new_search_stack;
-
 		new_search_stack = reallocarray(iter->search_stack, new_capacity,
 						sizeof(*iter->search_stack));
 		if (!new_search_stack)
@@ -12932,7 +12932,7 @@ out:
  */
 static int btrfs_subvolume_lookup_user(void)
 {
-	int fret = -1;
+	int fret = -1, i;
 	int dir1_fd = -EBADF, dir2_fd = -EBADF, mnt_fd = -EBADF,
 	    open_tree_fd = -EBADF, tree_fd = -EBADF, userns_fd = -EBADF;
 	int subvolume_fds[BTRFS_SUBVOLUME_SUBVOL4_ID + 1];
@@ -12947,10 +12947,10 @@ static int btrfs_subvolume_lookup_user(void)
 	if (!caps_supported())
 		return 0;
 
-	for (int i = 0; i < ARRAY_SIZE(subvolume_fds); i++)
+	for (i = 0; i < ARRAY_SIZE(subvolume_fds); i++)
 		subvolume_fds[i] = -EBADF;
 
-	for (int i = 0; i < ARRAY_SIZE(subvolume_ids); i++)
+	for (i = 0; i < ARRAY_SIZE(subvolume_ids); i++)
 		subvolume_ids[i] = -EINVAL;
 
 	if (btrfs_create_subvolume(t_mnt_scratch_fd, BTRFS_SUBVOLUME_SUBVOL1)) {
@@ -13312,7 +13312,7 @@ out:
 	safe_close(open_tree_fd);
 	safe_close(tree_fd);
 	safe_close(userns_fd);
-	for (int i = 0; i < ARRAY_SIZE(subvolume_fds); i++)
+	for (i = 0; i < ARRAY_SIZE(subvolume_fds); i++)
 		safe_close(subvolume_fds[i]);
 	snprintf(t_buf, sizeof(t_buf), "%s/%s", t_mountpoint, BTRFS_SUBVOLUME_MNT);
 	sys_umount2(t_buf, MNT_DETACH);
diff --git a/src/idmapped-mounts/utils.c b/src/idmapped-mounts/utils.c
index 6ffd6a23..c2afa8dc 100644
--- a/src/idmapped-mounts/utils.c
+++ b/src/idmapped-mounts/utils.c
@@ -140,11 +140,12 @@ static int map_ids_from_idmap(struct list *idmap, pid_t pid)
 	int fill, left;
 	char mapbuf[4096] = {};
 	bool had_entry = false;
+	idmap_type_t map_type, u_or_g;
 
 	if (list_empty(idmap))
 		return 0;
 
-	for (idmap_type_t map_type = ID_TYPE_UID, u_or_g = 'u';
+	for (map_type = ID_TYPE_UID, u_or_g = 'u';
 	     map_type <= ID_TYPE_GID; map_type++, u_or_g = 'g') {
 		char *pos = mapbuf;
 		int ret;
-- 
2.23.0

