Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A41DBC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 14 Apr 2022 02:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbiDNChU (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 13 Apr 2022 22:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239519AbiDNChT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 13 Apr 2022 22:37:19 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A54F618381
        for <fstests@vger.kernel.org>; Wed, 13 Apr 2022 19:34:54 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3Awi+8NqjqBubkR3aIHIkLqz9NX161fRIKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkUBzWVKWWCGb6uCajPyfNp2bYri8x4OucTRnNBkGwY5+3w8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOixxZVA/fvQHOCkUra?=
 =?us-ascii?q?dYnkZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14NFMqI28D?=
 =?us-ascii?q?wkvJbHklvkfUgVDDmd1OqguFLrveCLk7JDOnhKdG5fr67A0ZK0sBqUW4fp6Gn1?=
 =?us-ascii?q?V3eIXJSpLbR2Zge+yhrWhRYFRam4LRCXwFNpH/Cg+kneCVrB7Ka0vip7ivbdwt?=
 =?us-ascii?q?ArcTOgXdRoGW/ckVA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A8iizUqG9wBz0avFNpLqEAseALOsnbusQ8zAX?=
 =?us-ascii?q?P0AYc31om6uj5qeTdZUgpHnJYVkqKRIdcLy7V5VoIkmskaKdg7NhX4tKNTOO0A?=
 =?us-ascii?q?DDQe1fBODZowEIdReRygck79YET0FhMqyLMXFKydb9/BKjE8sthP2O8KWTj+/Y?=
 =?us-ascii?q?yHt3JDsaE51I3kNoDBqBCE1qSE1jDZo9LpCV4c1KvH6OYnISB/7LfUUtbqzSoc?=
 =?us-ascii?q?HRjpL6bVojDx4j0gOHijSl8/rbPnGjr24jbw8=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="123545973"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Apr 2022 10:34:53 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id AA22B4D1716B
        for <fstests@vger.kernel.org>; Thu, 14 Apr 2022 10:34:50 +0800 (CST)
Received: from G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 14 Apr 2022 10:34:50 +0800
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXJMPEKD02.g08.fujitsu.local (10.167.33.202) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 14 Apr 2022 10:34:50 +0800
Received: from fedora.g08.fujitsu.local (10.167.223.59) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 14 Apr 2022 10:34:48 +0800
From:   Liu Yiding <liuyd.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     Liu Yiding <liuyd.fnst@fujitsu.com>
Subject: [PATCH] common/rc: Skip virtiofs when _require_exportfs
Date:   Thu, 14 Apr 2022 10:34:47 +0800
Message-ID: <20220414023447.1575844-1-liuyd.fnst@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: AA22B4D1716B.AF0EC
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: liuyd.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

open_by_handle_at(2) is not supported by virtio-fs.
Reference:
https://gitlab.com/virtio-fs/qemu/-/issues/10

Signed-off-by: Liu Yiding <liuyd.fnst@fujitsu.com>
---
 common/rc | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/common/rc b/common/rc
index 17629801..5617afc1 100644
--- a/common/rc
+++ b/common/rc
@@ -3587,6 +3587,8 @@ _require_freeze()
 _require_exportfs()
 {
 	_require_test_program "open_by_handle"
+	[ $FSTYP == "virtiofs" ] && \
+		_notrun "$FSTYP doesn't support open_by_handle_at(2)"
 	mkdir -p "$TEST_DIR"/exportfs_test
 	$here/src/open_by_handle -c "$TEST_DIR"/exportfs_test 2>&1 \
 		|| _notrun "$FSTYP does not support NFS export"
-- 
2.31.1



