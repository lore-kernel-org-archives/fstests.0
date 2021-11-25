Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58E13C433F5
	for <linux-fstests@archiver.kernel.org>; Thu, 25 Nov 2021 07:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhKYHxM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 25 Nov 2021 02:53:12 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:61265 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234057AbhKYHvM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Nov 2021 02:51:12 -0500
IronPort-Data: =?us-ascii?q?A9a23=3Am3g1gKD0V0vxjRVW/zXhw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fDQG51jwigjxTnGoYUGGHPKneNGCkLYpzbYWzpB5XuZGAx9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkERcwmj/3auK49CAmiPnRLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9NljyPhME3xtNWqbS+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZPIWqeeZfiLXXcu7iheun2HX6/t1EEwtIZYw5Ol6Gyd?=
 =?us-ascii?q?N+OYeJTRLaQqM799aaprTpvJE35xldZe0ethE/CwI8N0QNt5+KbirfkkAzYYwM?=
 =?us-ascii?q?O8Mu/1z?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AODZ8ua3KjOd84vEI+b7lHgqjBJwkLtp133Aq?=
 =?us-ascii?q?2lEZdPWaSKylf4vEpoVj6faUskd3ZJhOo6HjBEDtex3hHL9OkPEs1NSZLW3bUQ?=
 =?us-ascii?q?mTXeRfBYqL+UyaJ8SWzIc0vpuIGJIOa+EYemIXsS+V2miF+qwbquVviJrY49s2?=
 =?us-ascii?q?k00dNz2CEJsM0+/FYTz1LnFL?=
X-IronPort-AV: E=Sophos;i="5.87,262,1631548800"; 
   d="scan'208";a="117890672"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 25 Nov 2021 15:47:59 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id D22A94D138C2
        for <fstests@vger.kernel.org>; Thu, 25 Nov 2021 15:47:56 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Thu, 25 Nov 2021 15:47:57 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Thu, 25 Nov 2021 15:47:55 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2 00/16] generic: add some mmap CoW tests
Date:   Thu, 25 Nov 2021 15:47:36 +0800
Message-ID: <20211125074752.274176-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: D22A94D138C2.AFE99
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Changes since v1:
  - Replace 'xxx' in each header with real sequence number
  - Combine two patchsets together because they both aim to add mmap tests

This series is to add missing mmap CoW tests in some sets of testcases:
Set 1. CoW on shared blocks which are interleaving reflinked by two files.
  - P1:            add mmap test
Set 2. CoW a range covers shared blocks and multiple kind of unshared blocks of
   the destination file.
  - P2 ~ P6:       add mmap test
Set 3. CoW a range covers shared blocks and multiple kind of unshared blocks of
   the source file.
  - P11, P12:      add missing buffered-io and direct-io test for mixed blocks
  - P7 ~ P10, P13: add mmap test
Set 4. races tests
  - P14: race between reflink and mmap reading
  - P15: race between mmap writing to and reflink source file
  - P16: race between mmap writing to and reflink target file


Shiyang Ruan (16):
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
  generic: add race test between reflink and mmap read
  generic: add race test that mmap write to source of reflink
  generic: add race test that mmap write to target of reflink

 common/reflink        | 74 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/900     | 69 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/900.out | 14 ++++++++
 tests/generic/901     | 59 ++++++++++++++++++++++++++++++++++
 tests/generic/901.out | 12 +++++++
 tests/generic/902     | 59 ++++++++++++++++++++++++++++++++++
 tests/generic/902.out | 12 +++++++
 tests/generic/903     | 59 ++++++++++++++++++++++++++++++++++
 tests/generic/903.out | 12 +++++++
 tests/generic/904     | 61 +++++++++++++++++++++++++++++++++++
 tests/generic/904.out | 12 +++++++
 tests/generic/905     | 68 +++++++++++++++++++++++++++++++++++++++
 tests/generic/905.out | 12 +++++++
 tests/generic/906     | 60 +++++++++++++++++++++++++++++++++++
 tests/generic/906.out | 12 +++++++
 tests/generic/907     | 62 ++++++++++++++++++++++++++++++++++++
 tests/generic/907.out | 12 +++++++
 tests/generic/908     | 62 ++++++++++++++++++++++++++++++++++++
 tests/generic/908.out | 12 +++++++
 tests/generic/909     | 64 +++++++++++++++++++++++++++++++++++++
 tests/generic/909.out | 12 +++++++
 tests/generic/910     | 66 ++++++++++++++++++++++++++++++++++++++
 tests/generic/910.out | 12 +++++++
 tests/generic/911     | 66 ++++++++++++++++++++++++++++++++++++++
 tests/generic/911.out | 12 +++++++
 tests/generic/912     | 67 +++++++++++++++++++++++++++++++++++++++
 tests/generic/912.out | 12 +++++++
 tests/generic/913     | 72 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/913.out |  5 +++
 tests/generic/914     | 64 +++++++++++++++++++++++++++++++++++++
 tests/generic/914.out |  4 +++
 tests/generic/915     | 64 +++++++++++++++++++++++++++++++++++++
 tests/generic/915.out |  4 +++
 33 files changed, 1267 insertions(+)
 create mode 100755 tests/generic/900
 create mode 100644 tests/generic/900.out
 create mode 100755 tests/generic/901
 create mode 100644 tests/generic/901.out
 create mode 100755 tests/generic/902
 create mode 100644 tests/generic/902.out
 create mode 100755 tests/generic/903
 create mode 100644 tests/generic/903.out
 create mode 100755 tests/generic/904
 create mode 100644 tests/generic/904.out
 create mode 100755 tests/generic/905
 create mode 100644 tests/generic/905.out
 create mode 100755 tests/generic/906
 create mode 100644 tests/generic/906.out
 create mode 100755 tests/generic/907
 create mode 100644 tests/generic/907.out
 create mode 100755 tests/generic/908
 create mode 100644 tests/generic/908.out
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

-- 
2.34.0



