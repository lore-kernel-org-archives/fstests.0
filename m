Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C033C433FE
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Nov 2021 03:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0489461501
	for <linux-fstests@archiver.kernel.org>; Mon, 15 Nov 2021 03:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbhKODpS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 14 Nov 2021 22:45:18 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52771 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230179AbhKODoo (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 14 Nov 2021 22:44:44 -0500
IronPort-Data: =?us-ascii?q?A9a23=3ApwtjYq3rbJesrGTbGfbD5c9zkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ1j8rhmdTymQeWTrUaf2Da2OgKd0nPI+wo0xSsJPcz4I2QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM+X9BDpC79SMljPjRGuKmYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2Tgtl308QLu5qrV?=
 =?us-ascii?q?S8nI6/NhP8AFRJfFkmSOIUfoeCbeSHu7ZD7I0ruNiGEL+9VJE8tIYAD5v1fH25?=
 =?us-ascii?q?D77obJSoLYxTFgPi5qI9X4MEEat8LdZGtZd1A/Co7i2yxMBrveribK42i2DOS9?=
 =?us-ascii?q?GxYahhyIMvj?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A0tqV+6pzYqZTmNAjpKI+CXEaV5oXeYIsimQD?=
 =?us-ascii?q?101hICG9E/bo8/xG+c536faaslgssQ4b8+xoVJPgfZq+z+8R3WByB8bAYOCOgg?=
 =?us-ascii?q?LBQ72KhrGSoQEIdRefysdtkY9kc4VbTOb7FEVGi6/BizWQIpINx8am/cmT6dvj?=
 =?us-ascii?q?8w=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.87,235,1631548800"; 
   d="scan'208";a="117401944"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 15 Nov 2021 11:41:13 +0800
Received: from G08CNEXMBPEKD05.g08.fujitsu.local (unknown [10.167.33.204])
        by cn.fujitsu.com (Postfix) with ESMTP id 05A3C4D10A2F
        for <fstests@vger.kernel.org>; Mon, 15 Nov 2021 11:41:11 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD05.g08.fujitsu.local (10.167.33.204) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Mon, 15 Nov 2021 11:41:12 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Mon, 15 Nov 2021 11:41:09 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 0/3] generic: add some race tests for mmap read/write
Date:   Mon, 15 Nov 2021 11:41:05 +0800
Message-ID: <20211115034108.1328167-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 05A3C4D10A2F.A2EA1
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patchset adds the MMAP version for the existed three sets of race tests.
  P1: race between reflink and mmap reading
  P2: race between mmap writing to and reflink source file
  P3: race between mmap writing to and reflink target file

Shiyang Ruan (3):
  generic: add race test between reflink and mmap read
  generic: add race test that mmap write to source of reflink
  generic: add race test that mmap write to target of reflink

 common/reflink        | 11 +++++++
 tests/generic/930     | 72 +++++++++++++++++++++++++++++++++++++++++++
 tests/generic/930.out |  5 +++
 tests/generic/931     | 64 ++++++++++++++++++++++++++++++++++++++
 tests/generic/931.out |  4 +++
 tests/generic/932     | 64 ++++++++++++++++++++++++++++++++++++++
 tests/generic/932.out |  4 +++
 7 files changed, 224 insertions(+)
 create mode 100755 tests/generic/930
 create mode 100644 tests/generic/930.out
 create mode 100755 tests/generic/931
 create mode 100644 tests/generic/931.out
 create mode 100755 tests/generic/932
 create mode 100644 tests/generic/932.out

-- 
2.33.0



