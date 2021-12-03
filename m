Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B1AC433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  3 Dec 2021 10:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350527AbhLCKDp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 3 Dec 2021 05:03:45 -0500
Received: from mga11.intel.com ([192.55.52.93]:59240 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232991AbhLCKDo (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 3 Dec 2021 05:03:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="234458543"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="234458543"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 02:00:20 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="513649332"
Received: from quzhi-mobl3.ccr.corp.intel.com (HELO lkp-mouse.ccr.corp.intel.com) ([10.255.29.2])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 02:00:19 -0800
From:   Zhu Yifei <yifeix.zhu@intel.com>
To:     fstests <fstests@vger.kernel.org>, Philip Li <philip.li@intel.com>
Cc:     Zhu Yifei <yifeix.zhu@intel.com>
Subject: [PATCH v1 xfstests-dev] common/populate: remove wrong check
Date:   Fri,  3 Dec 2021 17:54:41 +0800
Message-Id: <20211203095441.56318-1-yifeix.zhu@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

used btree_dir to check dformat, this was a wrong operation

Signed-off-by: Zhu Yifei <yifeix.zhu@intel.com>
---
 common/populate | 1 -
 1 file changed, 1 deletion(-)

diff --git a/common/populate b/common/populate
index 867776cd..8ad561b4 100644
--- a/common/populate
+++ b/common/populate
@@ -605,7 +605,6 @@ _scratch_xfs_populate_check() {
 	__populate_check_xfs_dir "${leafn_dir}" "leafn"
 	__populate_check_xfs_dir "${node_dir}" "node"
 	__populate_check_xfs_dir "${btree_dir}" "btree"
-	__populate_check_xfs_dformat "${btree_dir}" "btree"
 	__populate_check_xfs_dformat "${bdev}" "dev"
 	__populate_check_xfs_dformat "${cdev}" "dev"
 	__populate_check_xfs_dformat "${fifo}" "dev"
-- 
2.20.1

