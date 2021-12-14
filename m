Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF1EC433F5
	for <linux-fstests@archiver.kernel.org>; Tue, 14 Dec 2021 08:19:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbhLNIT0 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 14 Dec 2021 03:19:26 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:12969 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231793AbhLNITZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 14 Dec 2021 03:19:25 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AGBLMdKMMFelaBN7vrR25lcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQfq0zpw0GdWmjYdC2/XPPfYYGTwfIwgYNy+909QuZ6Am99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHi+0SiuFaOC79CAmjP3QH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/kSiAmctgjttLroCYR?=
 =?us-ascii?q?xorP7HXhaIWVBww/yRWZPQWqOCXfSbj2SCU5wicG5f2+N1gF107JpED0vh4DHs?=
 =?us-ascii?q?I9vECLj0JKBeZiIqLLBiTIgV3rp17apC1Y8VE4Tc9pQw1xM0OGfjrK5gmL/cGt?=
 =?us-ascii?q?Nvouv1zIA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AfG0boqG9D4+sBhGHpLqE1MeALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOHhom6mj+vxG88506faKslwssR0b+OxoW5PwJE80l6QFgrX5VI3KNGbbUQ?=
 =?us-ascii?q?CTXeNfBOXZowHIKmnX8+5x8eNaebFiNduYNzNHpPe/zA6mM9tI+rW6zJw=3D?=
X-IronPort-AV: E=Sophos;i="5.88,204,1635177600"; 
   d="scan'208";a="118878464"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 14 Dec 2021 16:19:21 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id E30224D144A0
        for <fstests@vger.kernel.org>; Tue, 14 Dec 2021 16:19:17 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 14 Dec 2021 16:19:17 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 14 Dec 2021 16:19:16 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH v3 00/17] generic: add some mmap CoW tests
Date:   Tue, 14 Dec 2021 16:18:57 +0800
Message-ID: <20211214081914.2478122-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: E30224D144A0.A0348
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Changes since v1:
  - Introduce _require_scratch_delalloc() to check if supports delay allocation
  - Remove useless _require_odirect and _require_cp_reflink in some cases

This series is to add missing mmap CoW tests in some sets of testcases:
Set 1. CoW on shared blocks which are interleaving reflinked by two files.
  - P1:            add mmap test
Set 2. CoW a range covers shared blocks and multiple kind of unshared blocks of
   the destination file.
  - P2 ~ P4, P6:   add mmap test
Set 3. CoW a range covers shared blocks and multiple kind of unshared blocks of
   the source file.
  - P12, P13:      add missing buffered-io and direct-io test for mixed blocks
  - P8 ~ P11, P14: add mmap test
Set 4. races tests
  - P15: race between reflink and mmap reading
  - P16: race between mmap writing to and reflink source file
  - P17: race between mmap writing to and reflink target file

Shiyang Ruan (17):
  generic: add mmap CoW test for ranges of two shared files
  generic: add mmap CoW test for regular&destination extents
  generic: add mmap CoW test for unwritten&destination extents
  generic: add mmap CoW test for holes&destination extents
  common/rc: Introduce _require_scratch_delalloc()
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

 common/rc             | 13 ++++++++
 common/reflink        | 62 +++++++++++++++++++++++++++++++++++++
 tests/generic/194     |  1 +
 tests/generic/195     |  1 +
 tests/generic/199     |  1 +
 tests/generic/200     |  1 +
 tests/generic/293     |  1 +
 tests/generic/295     |  1 +
 tests/generic/540     |  1 +
 tests/generic/541     |  1 +
 tests/generic/542     |  1 +
 tests/generic/543     |  1 +
 tests/generic/900     | 69 +++++++++++++++++++++++++++++++++++++++++
 tests/generic/900.out | 14 +++++++++
 tests/generic/901     | 59 +++++++++++++++++++++++++++++++++++
 tests/generic/901.out | 12 ++++++++
 tests/generic/902     | 59 +++++++++++++++++++++++++++++++++++
 tests/generic/902.out | 12 ++++++++
 tests/generic/903     | 59 +++++++++++++++++++++++++++++++++++
 tests/generic/903.out | 12 ++++++++
 tests/generic/904     | 62 +++++++++++++++++++++++++++++++++++++
 tests/generic/904.out | 12 ++++++++
 tests/generic/905     | 67 ++++++++++++++++++++++++++++++++++++++++
 tests/generic/905.out | 12 ++++++++
 tests/generic/906     | 60 ++++++++++++++++++++++++++++++++++++
 tests/generic/906.out | 12 ++++++++
 tests/generic/907     | 62 +++++++++++++++++++++++++++++++++++++
 tests/generic/907.out | 12 ++++++++
 tests/generic/908     | 62 +++++++++++++++++++++++++++++++++++++
 tests/generic/908.out | 12 ++++++++
 tests/generic/909     | 65 ++++++++++++++++++++++++++++++++++++++
 tests/generic/909.out | 12 ++++++++
 tests/generic/910     | 65 ++++++++++++++++++++++++++++++++++++++
 tests/generic/910.out | 12 ++++++++
 tests/generic/911     | 66 +++++++++++++++++++++++++++++++++++++++
 tests/generic/911.out | 12 ++++++++
 tests/generic/912     | 66 +++++++++++++++++++++++++++++++++++++++
 tests/generic/912.out | 12 ++++++++
 tests/generic/913     | 72 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/913.out |  5 +++
 tests/generic/914     | 64 ++++++++++++++++++++++++++++++++++++++
 tests/generic/914.out |  4 +++
 tests/generic/915     | 64 ++++++++++++++++++++++++++++++++++++++
 tests/generic/915.out |  4 +++
 tests/xfs/172         | 12 +-------
 tests/xfs/223         |  1 +
 tests/xfs/224         |  1 +
 tests/xfs/228         |  1 +
 tests/xfs/230         |  1 +
 tests/xfs/257         |  1 +
 tests/xfs/258         |  1 +
 51 files changed, 1284 insertions(+), 11 deletions(-)
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
2.34.1



