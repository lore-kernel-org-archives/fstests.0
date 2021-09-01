Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F7AFC19F38
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Sep 2021 12:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 360C661131
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Sep 2021 12:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344382AbhIAMps (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Sep 2021 08:45:48 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.112]:10178 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344934AbhIAMoI (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Sep 2021 08:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1630500188; i=@fujitsu.com;
        bh=Xp2G3THIC+Nbq2CoiRpE9dupwCKKJwvwQi/RG4ZFfOQ=;
        h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=l3SOfLvva8xxg566JuT4OaT5YiFcChUDFhYHWDC+WDvzaP9gImC34Fd1lxdLPBcyg
         T0Z1rgthtHt2ByM4Tkb7AW6Q8697LUQpSnmWtu1oXRauNRyi3KcEHqEbcufOl0dNGM
         oUmfgzcDwBFvyxWr6nzK6BfuVLIc2QoTU+sIFnnKV82G/2KAZktItw7NwJ7/3T7cjw
         qwqPZOk6D+FsBTNuHHLyw0zuyA9IYW/Jn5QnnbGduAcvbw8xHpzSJJZ7AbkRv1djPE
         /vSGpDFkGf2vVNMiuATmGvm0FYu6yUbJKwEAwE4PmvDlJJEv7R/25KbqPt9/QMF8ih
         g3A8VOFsfVTqA==
Received: from [100.113.7.47] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-1.bemta.az-b.eu-central-1.aws.symcld.net id 64/E1-23595-C557F216; Wed, 01 Sep 2021 12:43:08 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAIsWRWlGSWpSXmKPExsViZ8MRohtTqp9
  o8OOlnMXplr3sDowenzfJBTBGsWbmJeVXJLBm3N/QxlSwU6Ri09XbzA2Mp4S6GLk4hAQ6mCQe
  9n1nhXB2M0o8W/SHrYuRk4NNQFPiWecCZhBbREBW4v+M1UwgNrOAusTySb/AbGGBMInr8z+xg
  NgsAioS3RcfgMV5BTwlpu6eywhiSwgoSEx5+B5sDqeAl8TvVZfA6oWAaia+/QtVLyhxcuYTFo
  j5EhIHX7xghuhVlLjU8Q1qToXErFltTBMY+WchaZmFpGUBI9MqRsukosz0jJLcxMwcXUMDA11
  DQ2NdcyDLVC+xSjdJL7VUNzk1r6QoESirl1herFdcmZuck6KXl1qyiREYkCmF7Jk7GCe/+aB3
  iFGSg0lJlJclUj9RiC8pP6UyI7E4I76oNCe1+BCjDAeHkgTvrgygnGBRanpqRVpmDjA6YNISH
  DxKIrxLCoHSvMUFibnFmekQqVOMilLivOtKgBICIImM0jy4NlhEXmKUlRLmZWRgYBDiKUgtys
  0sQZV/xSjOwagkzDu7GGgKT2ZeCdz0V0CLmYAW8/zQAVlckoiQkmpg0pR0kUzumLR/etklgR9
  rT0n7Cy5S/hD9tulGOItr5cHrrQcs9mffFPOUMtiro5Y3Ucrx0DGXmKpXcjffl3ELPNVyWvZF
  yiz4yquPW/NmbG5dGPWbwSTodL+M/9QZ/epHrnbbJzwPnnCV8Um9Ys0j9tnNtVUFCrXNfV/vn
  Shbw/xR5tLj17ph8/U2JHpv5FaOfhjI4Rgp/GfdO37JmSs/8x/sWc5j+c5o+WQTI8faoAQxIe
  P1XWxOHGt8xIyPPvCNvrZvUVqRwBn/vxuvu8w+w2t81HzlXM51QTnh6+u7/6bf2HP7xmFPe4V
  3DvP0hR8fqmE2SdX9xXy7JeOUxOsvC1xWfI90y3y8sfds0q5iJZbijERDLeai4kQA8hExt0MD
  AAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-19.tower-245.messagelabs.com!1630500188!17231!1
X-Originating-IP: [62.60.8.84]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.81.4; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 26118 invoked from network); 1 Sep 2021 12:43:08 -0000
Received: from unknown (HELO mailhost3.uk.fujitsu.com) (62.60.8.84)
  by server-19.tower-245.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 1 Sep 2021 12:43:08 -0000
Received: from R01UKEXCASM126.r01.fujitsu.local ([10.183.43.178])
        by mailhost3.uk.fujitsu.com (8.14.5/8.14.5) with ESMTP id 181Ch5a9026400
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL)
        for <fstests@vger.kernel.org>; Wed, 1 Sep 2021 13:43:08 +0100
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 1 Sep 2021 13:43:06 +0100
From:   Yang Xu <xuyang2018.jy@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Yang Xu <xuyang2018.jy@fujitsu.com>
Subject: [PATCH v1 2/4] configure.ac: Fix uncorrect detection because of linux/btrfs.h
Date:   Wed, 1 Sep 2021 20:43:24 +0800
Message-ID: <1630500206-15545-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1630500206-15545-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1630500206-15545-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On old distros, we can't detect some btrfs structs because of undeclared 'NULL' in
btrfs_err_str function. This function has been removed after kernel
commit 68598d2ea8863 ("btrfs: remove btrfs_err_str function from uapi/linux/btrfs.h").

Fix this bug in xfstests layer by adding stddef.h because NULL is defined in stddef.h(it is
in /usr/lib/gcc*/ directory).

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 configure.ac | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/configure.ac b/configure.ac
index 78e9d945..0b55455a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -69,15 +69,39 @@ AC_PACKAGE_WANT_LIBBTRFSUTIL
 AC_HAVE_COPY_FILE_RANGE
 AC_CHECK_FUNCS([renameat2])
 AC_CHECK_TYPES([struct mount_attr], [], [], [[#include <linux/mount.h>]])
-AC_CHECK_TYPES([struct btrfs_qgroup_limit], [], [], [[#include <linux/btrfs.h>]])
-AC_CHECK_TYPES([struct btrfs_qgroup_inherit], [], [], [[#include <linux/btrfs.h>]])
-AC_CHECK_TYPES([struct btrfs_ioctl_vol_args], [], [], [[#include <linux/btrfs.h>]])
-AC_CHECK_TYPES([struct btrfs_ioctl_vol_args_v2], [], [], [[#include <linux/btrfs.h>]])
-AC_CHECK_TYPES([struct btrfs_ioctl_ino_lookup_args], [], [], [[#include <linux/btrfs.h>]])
-AC_CHECK_TYPES([struct btrfs_ioctl_ino_lookup_user_args], [], [], [[#include <linux/btrfs.h>]])
-AC_CHECK_TYPES([struct btrfs_ioctl_get_subvol_rootref_args], [], [], [[#include <linux/btrfs.h>]])
+AC_CHECK_TYPES([struct btrfs_qgroup_limit], [], [], [[
+#include <stddef.h>
+#include <linux/btrfs.h>
+]])
+AC_CHECK_TYPES([struct btrfs_qgroup_inherit], [], [], [[
+#include <stddef.h>
+#include <linux/btrfs.h>
+]])
+AC_CHECK_TYPES([struct btrfs_ioctl_vol_args], [], [], [[
+#include <stddef.h>
+#include <linux/btrfs.h>
+]])
+AC_CHECK_TYPES([struct btrfs_ioctl_vol_args_v2], [], [], [[
+#include <stddef.h>
+#include <linux/btrfs.h>
+]])
+AC_CHECK_TYPES([struct btrfs_ioctl_ino_lookup_args], [], [], [[
+#include <stddef.h>
+#include <linux/btrfs.h>
+]])
+AC_CHECK_TYPES([struct btrfs_ioctl_ino_lookup_user_args], [], [], [[
+#include <stddef.h>
+#include <linux/btrfs.h>
+]])
+AC_CHECK_TYPES([struct btrfs_ioctl_get_subvol_rootref_args], [], [], [[
+#include <stddef.h>
+#include <linux/btrfs.h>
+]])
 AC_CHECK_HEADERS([linux/btrfs.h linux/btrfs_tree.h])
-AC_CHECK_MEMBERS([struct btrfs_ioctl_vol_args_v2.subvolid], [], [], [[#include <linux/btrfs.h>]])
+AC_CHECK_MEMBERS([struct btrfs_ioctl_vol_args_v2.subvolid], [], [], [[
+#include <stddef.h>
+#include <linux/btrfs.h>
+]])
 
 AC_CONFIG_HEADER(include/config.h)
 AC_CONFIG_FILES([include/builddefs])
-- 
2.23.0

