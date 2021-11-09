Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196BDC433EF
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Nov 2021 03:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E91ED61284
	for <linux-fstests@archiver.kernel.org>; Tue,  9 Nov 2021 03:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237157AbhKIDYF (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 8 Nov 2021 22:24:05 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:60417 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236908AbhKIDYE (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 8 Nov 2021 22:24:04 -0500
IronPort-Data: =?us-ascii?q?A9a23=3AqbiQWq3hrsN8GuLDnvbD5c9zkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJhzsm1WACmGIdXWCAb/mJN2X9eox3Otmw8kNU6sfQm4c2QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM+X9BDpC79SMljPjQF+KlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2Tgtl308QLu5qrV?=
 =?us-ascii?q?S8nI6/NhP8AFRJfFkmSOIUfoeCfcCHu6Zb7I0ruNiGEL+9VJE8tIYAD5v1fH25?=
 =?us-ascii?q?D77obJSoLYxTFgPi5qI9X4MEEat8LdZGtZd1A/Co7i2yxMBrveribK42i2DOS9?=
 =?us-ascii?q?G5YahhyIMvj?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AgrUGxKw6p5st7AjQ706tKrPwEL1zdoMgy1kn?=
 =?us-ascii?q?xilNoH1uA6ilfqWV8cjzuiWbtN9vYhsdcLy7WZVoIkmskKKdg7NhXotKNTOO0A?=
 =?us-ascii?q?SVxepZnOnfKlPbexHWx6p00KdMV+xEAsTsMF4St63HyTj9P9E+4NTvysyVuds?=
 =?us-ascii?q?=3D?=
X-IronPort-AV: E=Sophos;i="5.87,219,1631548800"; 
   d="scan'208";a="117091902"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 09 Nov 2021 11:21:17 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 6ACC64D10A06
        for <fstests@vger.kernel.org>; Tue,  9 Nov 2021 11:21:14 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Tue, 9 Nov 2021 11:21:14 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Tue, 9 Nov 2021 11:21:12 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v3 0/5] generic: add a couple of MMAP CoW tests
Date:   Tue, 9 Nov 2021 11:21:05 +0800
Message-ID: <20211109032110.499427-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 6ACC64D10A06.AE3DE
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

There is a set of CoW tests which is to 
  > Check what happens if we BufferedIO/DIO CoW blocks 2-4 of a page's worth
  > of blocks when the second block is a regular/unwritten/hole/delalloc/mixed
  > block.
I think a test of MMAP CoW is also needed for these kind of testsets.  So,
add MMAP CoW for each case.

Changes from V2:
  - remove overrided _leanup() because these are tests on scratch device
  - not run when delalloc block not acutally exists in cases contains 'delalloc'
  - remove redundant tests in 'mixed' case
==
Shiyang Ruan (5):
  generic: add mmap CoW test for 'regular' case
  generic: add mmap CoW test for 'unwritten' case
  generic: add mmap CoW test for 'hole' case
  generic: add mmap CoW test for 'delalloc' case
  generic: add mmap CoW test for 'mixed' case

 tests/generic/900     |  68 ++++++++++++++++++++++
 tests/generic/900.out |   6 ++
 tests/generic/901     |  69 ++++++++++++++++++++++
 tests/generic/901.out |   6 ++
 tests/generic/902     |  63 ++++++++++++++++++++
 tests/generic/902.out |   6 ++
 tests/generic/903     |  73 +++++++++++++++++++++++
 tests/generic/903.out |   6 ++
 tests/generic/904     | 132 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/904.out |  62 ++++++++++++++++++++
 10 files changed, 491 insertions(+)
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

-- 
2.33.0



