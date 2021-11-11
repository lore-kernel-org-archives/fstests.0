Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C11C433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112906162E
	for <linux-fstests@archiver.kernel.org>; Thu, 11 Nov 2021 08:51:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbhKKIyF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 11 Nov 2021 03:54:05 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:34979 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232431AbhKKIyE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Nov 2021 03:54:04 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AvNiUdqgJIHaXUHOR7LzteclIX161fBIKZh0ujC4?=
 =?us-ascii?q?5NGQNrF6WrkVWnWoWWW6DOqyPY2WnKdFxb4jlpkkF6JXQy9BkTVZk/nw8FHgiR?=
 =?us-ascii?q?ejtX4rAdhiqV8+xwmwvdGo+toNGLICowPkcFhcwnT/wdOi+xZVA/fvQHOOlUbe?=
 =?us-ascii?q?cYn0ZqTJME0/NtzoywobVvaY42bBVMyvV0T/Di5W31G2NglaYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57wdAsEX7zTIROTzHFRXsBOgDAb/mprjPl9b6FaNC+7iB3Q9zx14M9QvJqrW?=
 =?us-ascii?q?EEnOLbQsOoAURhECDw4NqpDkFPCCSHm7pbKkxWfLhMAxN0rVinaJ7Yw9P1rDHp?=
 =?us-ascii?q?S7tQGJz0XKBOOneS7xPS8UOYEuyiJBKEHJ6tG4jc5k26fVq1gHPj+r2zxzYcw9?=
 =?us-ascii?q?F8NagpmQJ4yv/YkVAc=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AabgmFqmt+udxsJzGzduWnOc/4WfpDfIQ3DAb?=
 =?us-ascii?q?v31ZSRFFG/Fw9vre+MjzsCWYtN9/Yh8dcK+7UpVoLUm8yXcX2/h1AV7BZniEhI?=
 =?us-ascii?q?LAFugLgrcKqAeQeREWmNQ86Y5QN4B6CPDVSWNxlNvG5mCDeOoI8Z2q97+JiI7l?=
 =?us-ascii?q?o0tQcQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,225,1631548800"; 
   d="scan'208";a="117214015"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Nov 2021 16:51:12 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 0B86D4D10A10
        for <fstests@vger.kernel.org>; Thu, 11 Nov 2021 16:51:10 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 11 Nov 2021 16:51:10 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 11 Nov 2021 16:51:08 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 00/13] generic: add some mmap CoW tests
Date:   Thu, 11 Nov 2021 16:50:53 +0800
Message-ID: <20211111085106.937684-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 0B86D4D10A10.A2AF3
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This series is to add missing mmap CoW tests in three sets of testcases:
Set 1. CoW on shared blocks which are interleaving reflinked by two files.
  - P1:            add mmap test
Set 2. CoW a range covers shared blocks and multiple kind of unshared blocks of
   the destination file.
  - P2 ~ P6:       add mmap test
Set 3. CoW a range covers shared blocks and multiple kind of unshared blocks of
   the source file.
  - P11, P12:      add missing buffered-io and direct-io test for mixed blocks
  - P7 ~ P10, P13: add mmap test

Shiyang Ruan (13):
  generic: add mmap CoW test for ranges of two shared files
  generic: add mmap CoW test for regular&destination extents
  generic: add mmap CoW test for unwritten&destination extents
  generic: add mmap CoW test for holes&destination extents
  generic: add mmap CoW test for delalloc&destination extents
  generic: add mmap CoW test for mixed&destination extents
  generic: add mmap CoW test for regular&source extents
  generic: add mmap CoW test for unwritten&source extents
  generic: add mmap CoW test for holes&source extents
  generic: add mmap CoW test for delalloc&source extents
  generic: add buffered-io CoW test for mixed&source extents
  generic: add direct-io CoW test for mixed&source extents
  generic: add mmap CoW test for mixed&source extents

 common/reflink        | 63 +++++++++++++++++++++++++++++++++++++++
 tests/generic/909     | 69 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/909.out | 14 +++++++++
 tests/generic/910     | 59 ++++++++++++++++++++++++++++++++++++
 tests/generic/910.out | 12 ++++++++
 tests/generic/911     | 59 ++++++++++++++++++++++++++++++++++++
 tests/generic/911.out | 12 ++++++++
 tests/generic/912     | 59 ++++++++++++++++++++++++++++++++++++
 tests/generic/912.out | 12 ++++++++
 tests/generic/913     | 61 ++++++++++++++++++++++++++++++++++++++
 tests/generic/913.out | 12 ++++++++
 tests/generic/914     | 68 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/914.out | 12 ++++++++
 tests/generic/915     | 60 +++++++++++++++++++++++++++++++++++++
 tests/generic/915.out | 12 ++++++++
 tests/generic/916     | 62 ++++++++++++++++++++++++++++++++++++++
 tests/generic/916.out | 12 ++++++++
 tests/generic/917     | 62 ++++++++++++++++++++++++++++++++++++++
 tests/generic/917.out | 12 ++++++++
 tests/generic/918     | 64 +++++++++++++++++++++++++++++++++++++++
 tests/generic/918.out | 12 ++++++++
 tests/generic/919     | 66 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/919.out | 12 ++++++++
 tests/generic/920     | 66 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/920.out | 12 ++++++++
 tests/generic/921     | 67 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/921.out | 12 ++++++++
 27 files changed, 1043 insertions(+)
 create mode 100755 tests/generic/909
 create mode 100644 tests/generic/909.out
 create mode 100755 tests/generic/910
 create mode 100644 tests/generic/910.out
 create mode 100755 tests/generic/911
 create mode 100644 tests/generic/911.out
 create mode 100755 tests/generic/912
 create mode 100644 tests/generic/912.out
 create mode 100755 tests/generic/913
 create mode 100644 tests/generic/913.out
 create mode 100755 tests/generic/914
 create mode 100644 tests/generic/914.out
 create mode 100755 tests/generic/915
 create mode 100644 tests/generic/915.out
 create mode 100755 tests/generic/916
 create mode 100644 tests/generic/916.out
 create mode 100755 tests/generic/917
 create mode 100644 tests/generic/917.out
 create mode 100755 tests/generic/918
 create mode 100644 tests/generic/918.out
 create mode 100755 tests/generic/919
 create mode 100644 tests/generic/919.out
 create mode 100755 tests/generic/920
 create mode 100644 tests/generic/920.out
 create mode 100755 tests/generic/921
 create mode 100644 tests/generic/921.out

-- 
2.33.0



