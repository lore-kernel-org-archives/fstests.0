Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0EBC433EF
	for <linux-fstests@archiver.kernel.org>; Fri, 11 Mar 2022 15:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345301AbiCKPTx (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 11 Mar 2022 10:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiCKPTx (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 11 Mar 2022 10:19:53 -0500
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7555D1B0BC7
        for <fstests@vger.kernel.org>; Fri, 11 Mar 2022 07:18:48 -0800 (PST)
IronPort-Data: =?us-ascii?q?A9a23=3A6oPFKK1wPiWo2lymj/bD5c9zkn2cJEfYwER7XOP?=
 =?us-ascii?q?LsXnJ0jhzhTwBmmofX2CFOq2KYTb3fo9+btnko0IA6JbSnIU2QQE+nZ1PZygU8?=
 =?us-ascii?q?JKaX7x1DatR0xu6d5SFFAQ+hyknQoGowPscEzmM9n9BDpC79SMmjfvQH+KlYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5S31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFAdX?=
 =?us-ascii?q?jnKv5c1ERX/jZOg3mZnh+AvDk20Yd4HdplPtT2Pk0MC+7jx2Tgtl308QLu5qrV?=
 =?us-ascii?q?S8nI6/NhP8AFRJfFkmSOIUfouWafCLg6pD7I0ruNiGEL+9VJE8tIYAD5v1fH25?=
 =?us-ascii?q?D77obJSoLYxTFgPi5qI9X4MEEat8LdZGtZd1A/Co7i2yxMBrveribK42i2DOS9?=
 =?us-ascii?q?G5YahhyIMvj?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A1rS+q6sxgA0G5VUC1MCo/0l77skDntV00zEX?=
 =?us-ascii?q?/kB9WHVpmszxra6TdZMgpHvJYVcqKRYdcL+7WJVoLUmxyXcX2/h1AV7BZniEhI?=
 =?us-ascii?q?LAFugLhuGO/9SKIUzDH4BmupuIC5IOauEYE2IK9vrS0U2pFco62tmb/OSNjefa?=
 =?us-ascii?q?9X1kSgZncMhbnn5EIzfeAktrXxNHGJZ8MJKd4/BMrz2mdW9SQd+8AhA+LpD+ju?=
 =?us-ascii?q?yOhJT7egQHGhJizAGPiAmj4Ln8HwPd/jp2aUIo/Ysf?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="122552734"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 11 Mar 2022 23:18:19 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 11EAB4D169FF
        for <fstests@vger.kernel.org>; Fri, 11 Mar 2022 23:18:19 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 11 Mar 2022 23:18:19 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 11 Mar 2022 23:18:18 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [RFC PATCH 0/3] xfs: add memory failure tests for dax mode
Date:   Fri, 11 Mar 2022 23:18:13 +0800
Message-ID: <20220311151816.2174870-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 11EAB4D169FF.A54DA
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patchset is to verify whether memory failure mechanism still works
with the dax-rmap feature[1].  With this feature, dax and reflink can be
used together[2].  So, we also test it for reflinked files in filesystem
mounted with dax option.

[1] https://lore.kernel.org/linux-xfs/20220227120747.711169-1-ruansy.fnst@fujitsu.com/
[2] https://lore.kernel.org/linux-xfs/20210928062311.4012070-1-ruansy.fnst@fujitsu.com/

Shiyang Ruan (3):
  xfs: add memory failure test for dax mode
  xfs: add memory failure test for dax&reflink mode
  xfs: add memory failure test for partly-reflinked&dax file

 .gitignore                      |   1 +
 src/Makefile                    |   3 +-
 src/t_mmap_cow_memory_failure.c | 154 ++++++++++++++++++++++++++++++++
 tests/xfs/900                   |  48 ++++++++++
 tests/xfs/900.out               |   9 ++
 tests/xfs/901                   |  49 ++++++++++
 tests/xfs/901.out               |   9 ++
 tests/xfs/902                   |  52 +++++++++++
 tests/xfs/902.out               |   9 ++
 9 files changed, 333 insertions(+), 1 deletion(-)
 create mode 100644 src/t_mmap_cow_memory_failure.c
 create mode 100755 tests/xfs/900
 create mode 100644 tests/xfs/900.out
 create mode 100755 tests/xfs/901
 create mode 100644 tests/xfs/901.out
 create mode 100755 tests/xfs/902
 create mode 100644 tests/xfs/902.out

-- 
2.35.1



