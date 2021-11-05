Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9E7C433EF
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 03:42:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE45660FED
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 03:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhKEDox (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 4 Nov 2021 23:44:53 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:47127 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229587AbhKEDox (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 Nov 2021 23:44:53 -0400
IronPort-Data: =?us-ascii?q?A9a23=3Ah+7EOKOG2sGXUs3vrR25lcFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdQe8gj8l0DQDzmJNWz+HPP6DZGqmfI9/a9+z808C6MKBm99gGjLY11k3ESsS9?=
 =?us-ascii?q?pCt6fd1j6vIF3rLaJWFFSqL1u1GAjX7BJ1yHiC0SiuFaOC79CAljfzQH9IQNca?=
 =?us-ascii?q?fUsxPbV49IMseoUI78wIJqtYAbemRW2thi/uryyHsEAPNNwpPD44hw/nrRCWDE?=
 =?us-ascii?q?xjFkGhwUlQWPZintbJF/pUfJMp3yaqZdxMUTmTId9NWSdovzJnhlo/Y1xwrTN2?=
 =?us-ascii?q?4kLfnaVBMSbnXVeSMoiMOHfH83V4Z/Wpvuko4HKN0hUN/kSiAmctgjttLroCYR?=
 =?us-ascii?q?xorP7HXhaIWVBww/yRWZPQYqeaZeSDl2SCU5wicG5f2+N1gF107JpED0vh4DHs?=
 =?us-ascii?q?I9vECLj0JKBeZiIqLLBiTIgV3rp17apC1Y8VE4Tc9pQw1xM0OGfjrK5gmL/cBt?=
 =?us-ascii?q?Nvouv1zIA=3D=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ASvFSdqFo2bi9pQu9pLqE1MeALOsnbusQ8zAX?=
 =?us-ascii?q?PiFKOHhom6mj+vxG88506faKslwssR0b+OxoW5PwJE80l6QFgrX5VI3KNGbbUQ?=
 =?us-ascii?q?CTXeNfBOXZowHIKmnX8+5x8eNaebFiNduYNzNHpPe/zA6mM9tI+rW6zJw=3D?=
X-IronPort-AV: E=Sophos;i="5.87,210,1631548800"; 
   d="scan'208";a="116916002"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Nov 2021 11:42:13 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id A884E4D10106
        for <fstests@vger.kernel.org>; Fri,  5 Nov 2021 11:42:09 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 5 Nov 2021 11:42:04 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 5 Nov 2021 11:42:02 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 0/5] generic: add a couple of MMAP CoW tests
Date:   Fri, 5 Nov 2021 11:41:55 +0800
Message-ID: <20211105034200.143626-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: A884E4D10106.AE9AF
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

There is a set of CoW tests which is to 
  > Check what happens if we BufferedIO/DIO CoW blocks 2-4 of a page's worth
  > of blocks when the second block is a regular/unwritten/hole/delalloc/all
  > block.
I think a test of MMAP CoW is also needed for these kind of testsets.  So,
add MMAP CoW for each case.

Shiyang Ruan (5):
  generic/xxx: Add MMAP CoW test for 'regular' case
  generic/xxx: Add MMAP CoW test for 'unwritten' case
  generic/xxx: Add MMAP CoW test for 'hole' case
  generic/xxx: Add MMAP CoW test for 'delalloc' case
  generic/xxx: Add MMAP CoW test for 'all' case

 tests/generic/900     |  75 +++++++++++++++++++++++
 tests/generic/900.out |   6 ++
 tests/generic/901     |  76 ++++++++++++++++++++++++
 tests/generic/901.out |   6 ++
 tests/generic/902     |  70 ++++++++++++++++++++++
 tests/generic/902.out |   6 ++
 tests/generic/903     |  76 ++++++++++++++++++++++++
 tests/generic/903.out |   6 ++
 tests/generic/904     | 135 ++++++++++++++++++++++++++++++++++++++++++
 tests/generic/904.out |  82 +++++++++++++++++++++++++
 10 files changed, 538 insertions(+)
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



