Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E4C7C4332F
	for <linux-fstests@archiver.kernel.org>; Fri, 13 May 2022 03:14:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376690AbiEMDO0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 12 May 2022 23:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376687AbiEMDOX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 12 May 2022 23:14:23 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6DD0293B45
        for <fstests@vger.kernel.org>; Thu, 12 May 2022 20:14:22 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AnpqqVq/HK44s6GWaU2/dDrUDnHyTJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUpxgWAOxmAdCz/VPvyLNDD9fNxxPoTn9xxVuJDXy95qTldlrnsFo1Bi8?=
 =?us-ascii?q?5ScXYvDRqvT04J+FuWaFQQ/qZx2huDodKjYdVeB4Ef9WlTdhSMkj/vQHOKlULe?=
 =?us-ascii?q?s1h1ZHmeIdg9w0HqPpMZp2uaEsfDha++8kYuaT//3YTdJ6BYoWo4g0J9vnTs01?=
 =?us-ascii?q?BjEVJz0iXRlDRxDlAe2e3D4l/vzL4npR5fzatE88uJX24/+IL+FEmPxp3/BC/u?=
 =?us-ascii?q?ulPD1b08LXqXPewOJjxK6WYD72l4b+HN0if19aZLwam8O49mNt8pswdNWpNq+T?=
 =?us-ascii?q?xw1FqPRmuUBSAQeGCZ7VUFD0OadfSLn6pHPliUqdFOpmZ2CFnoeM5YE9/1rGkl?=
 =?us-ascii?q?Q+vECbjMAdBaOg6Sx2r3TdwXGrqzPN+GyZMVG5C4mlmqfUJ4brVn4a/2izbdlM?=
 =?us-ascii?q?P0Y3aiixcrjWvc=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AKBEeAqkJagsJZ9UzeadnXK6B3xrpDfIQ3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzsCWYtN9/Yh8dcK+7UpVoLUm8yXcX2/h1AV7BZniEhI?=
 =?us-ascii?q?LAFugLgrcKqAeQeREWmNQ86Y5QN4B6CPDVSWNxlNvG5mCDeOoI8Z2q97+JiI7l?=
 =?us-ascii?q?o0tQcQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124203541"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 13 May 2022 11:14:17 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id E62A94D17197
        for <fstests@vger.kernel.org>; Fri, 13 May 2022 11:14:13 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 13 May 2022 11:14:14 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 13 May 2022 11:14:12 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH v2 0/3] xfs: add memory failure tests for dax mode
Date:   Fri, 13 May 2022 11:14:08 +0800
Message-ID: <20220513031411.2369314-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: E62A94D17197.ACA24
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patchset is to verify whether memory failure mechanism still works
with the fsdax-rmap feature.  With this feature, fsdax and reflink can be
used together[1].  So, we also test it for reflinked files in filesystem
mounted with dax option.

[1] https://lore.kernel.org/linux-xfs/20220508143620.1775214-1-ruansy.fnst@fujitsu.com/

Changes since v1:
  1. Fixed typo
  2. Use `sysconf(_SC_PAGESIZE)` as page size, instead of the fixed 4KiB
  3. Use `$(get_page_size)` in testcase
  4. Unify the style of comments => /* */

Shiyang Ruan (3):
  xfs: add memory failure test for dax mode
  xfs: add memory failure test for dax&reflink mode
  xfs: add memory failure test for partly-reflinked&dax file

 .gitignore                      |   1 +
 src/Makefile                    |   3 +-
 src/t_mmap_cow_memory_failure.c | 157 ++++++++++++++++++++++++++++++++
 tests/xfs/900                   |  48 ++++++++++
 tests/xfs/900.out               |   9 ++
 tests/xfs/901                   |  49 ++++++++++
 tests/xfs/901.out               |   9 ++
 tests/xfs/902                   |  52 +++++++++++
 tests/xfs/902.out               |   9 ++
 9 files changed, 336 insertions(+), 1 deletion(-)
 create mode 100644 src/t_mmap_cow_memory_failure.c
 create mode 100755 tests/xfs/900
 create mode 100644 tests/xfs/900.out
 create mode 100755 tests/xfs/901
 create mode 100644 tests/xfs/901.out
 create mode 100755 tests/xfs/902
 create mode 100644 tests/xfs/902.out

-- 
2.35.1



