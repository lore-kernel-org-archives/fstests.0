Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78BEC433F5
	for <linux-fstests@archiver.kernel.org>; Wed, 12 Jan 2022 09:28:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238686AbiALJ2v (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 12 Jan 2022 04:28:51 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:7899 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S238137AbiALJ2v (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 12 Jan 2022 04:28:51 -0500
IronPort-Data: =?us-ascii?q?A9a23=3A7qbt667Ij+A8d+I7AFJ+4wxRtBHFchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENS0TYHmjMWCm+CMv+PazP8LdEla9u1p04A7ZfczIRrG1Q5pCpnJ55og?=
 =?us-ascii?q?ZCbXIzGdC8cHM8zwvXrFRsht4NHAjX5BJhcokT0+1H9YtANkVEmjfvSHuOlUra?=
 =?us-ascii?q?dUsxMbVQMpBkJ2EsLd9ER0tYAbeiRW2thiPuqyyHtEAbNNw1cbgr435m+RCZH5?=
 =?us-ascii?q?5wejt+3UmsWPpintHeG/5Uc4Ql2yauZdxMUSaEMdgK2qnqq8V23wo/Z109F5tK?=
 =?us-ascii?q?NmbC9fFAIQ6LJIE6FjX8+t6qK20AE/3JtlP1gcqd0hUR/0l1lm/hr1dxLro32R?=
 =?us-ascii?q?wEyIoXCheYcTwJFVSp5OMWq/ZeeeyDl7pTIkReun3zEhq8G4FsNFYEa5eFxDkl?=
 =?us-ascii?q?N+OYeJTRLaQqM78q42662UfV3rtosIdOtP44FvHxkizbDAp4brTrrK0nRzYYAm?=
 =?us-ascii?q?m5u2YYVRrCDD/f1oAFHNHzoCyCj8H9OYH7moNqVuw=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3APgj2ZaHvjQ2WVuA7pLqE1MeALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOHhom6mj+vxG88506faKslwssR0b+OxoW5PwJE80l6QFgrX5VI3KNGbbUQ?=
 =?us-ascii?q?CTXeNfBOXZowHIKmnX8+5x8eNaebFiNduYNzNHpPe/zA6mM9tI+rW6zJw=3D?=
X-IronPort-AV: E=Sophos;i="5.88,282,1635177600"; 
   d="scan'208";a="120270362"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 12 Jan 2022 17:28:49 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 38CC14D169C2;
        Wed, 12 Jan 2022 17:28:49 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Wed, 12 Jan 2022 17:28:47 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Wed, 12 Jan 2022 17:28:47 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>, "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH] generic/670: allow _mread_range() races with reflink_range()
Date:   Wed, 12 Jan 2022 17:28:46 +0800
Message-ID: <20220112092846.1467088-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 38CC14D169C2.AF554
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

mread copies data one-byte-at-a-time, so it may races with
reflink_range() who invalidates page cache of the dest file.
Allow this race by adjusting the egrep regexp.

Reported-by: Darrick J. Wong <djwong@kernel.org>
Suggested-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
---
 tests/generic/670 | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/generic/670 b/tests/generic/670
index 83fbd0b9..4a895d90 100755
--- a/tests/generic/670
+++ b/tests/generic/670
@@ -40,7 +40,10 @@ _cp_reflink $testdir/file1 $testdir/file3
 _scratch_cycle_mount
 
 fbytes() {
-	egrep -v '(61 61 61 61 61 61 61 61 61 61 61 61 61 61 61 61|62 62 62 62 62 62 62 62 62 62 62 62 62 62 62 62)'
+	# Different with generic/164,165, mread copies data from mmapped area
+	# one-byte-at-a-time, which may cause races during reflink_range().
+	# So the result of _mread_range() may be a mix of 61 and 62.
+	egrep -v '((61|62) ){15}(61|62)'
 }
 
 reader() {
-- 
2.34.1



