Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D950C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Oct 2021 06:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74DA860ED5
	for <linux-fstests@archiver.kernel.org>; Fri, 29 Oct 2021 06:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhJ2HCZ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 29 Oct 2021 03:02:25 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:64478 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232024AbhJ2HCY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 29 Oct 2021 03:02:24 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AKLrY3aIh4bKxckgsFE+RzZclxSXFcZb7ZxGrkP8?=
 =?us-ascii?q?bfHDo12kj1WZVnGoWWjzTMvmLZ2T3Kd8nPoXn/E1SvJbTyoNqS1BcGVNFFSwT8?=
 =?us-ascii?q?ZWfbTi6wuYcBwvLd4ubChsPA/w2MrEsF+hpCC+DzvuRGuK59yAljfvYHuGU5NP?=
 =?us-ascii?q?sYUideyc1EU/Ntjozw4bVsqYw6TSIK1vlVeHa+qUzC3f5s9JACV/43orYwP9ZU?=
 =?us-ascii?q?FsejxtD1rA2TagjUFYzDBD5BrpHTU26ByOQroW5goeHq+j/ILGRpgs1/j8mDJW?=
 =?us-ascii?q?rj7T6blYXBLXVOGBiiFIPA+773EcE/Xd0j87XN9JFAatToy+UltZq2ZNDs4esY?=
 =?us-ascii?q?Qk0PKzQg/lbWB5de817FfQfpuKYcCfk7qR/yGWDKRMA2c5GAloqMJYE4c5pDmx?=
 =?us-ascii?q?Us/8VMjYAalaEne3e/V4RYoGAnex6dI+yYtxZ4SomkFnk4T8dacira833CRVwh?=
 =?us-ascii?q?V/cXvxzIMs=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A1AtH466+p6SJRZVjUAPXwPTXdLJyesId70hD?=
 =?us-ascii?q?6qkRc20wTiX8ra2TdZsguyMc9wx6ZJhNo7G90cq7MBbhHPxOkOos1N6ZNWGIhI?=
 =?us-ascii?q?LCFvAB0WKN+V3dMhy73utc+IMlSKJmFeD3ZGIQse/KpCW+DPYsqePqzJyV?=
X-IronPort-AV: E=Sophos;i="5.87,191,1631548800"; 
   d="scan'208";a="116579737"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 29 Oct 2021 14:59:55 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id D1E314D0F910
        for <fstests@vger.kernel.org>; Fri, 29 Oct 2021 14:59:52 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 29 Oct 2021 14:59:48 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 29 Oct 2021 14:59:45 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH 0/3] Random fixes for generic
Date:   Fri, 29 Oct 2021 14:59:40 +0800
Message-ID: <20211029065943.3556529-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: D1E314D0F910.A020F
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patchset fixes some description or typo found in generic during me
reading the testcase.


Shiyang Ruan (3):
  generic/138,139,140: fix the name for check file
  generic: fix description or typo in head comment
  generic/201: fix the description

 tests/generic/138     | 54 +++++++++++++++++++++----------------------
 tests/generic/138.out |  8 +++----
 tests/generic/139     | 54 +++++++++++++++++++++----------------------
 tests/generic/139.out |  8 +++----
 tests/generic/140     | 54 +++++++++++++++++++++----------------------
 tests/generic/140.out |  8 +++----
 tests/generic/155     |  3 +--
 tests/generic/201     |  2 +-
 tests/generic/201.out |  2 +-
 tests/generic/269     |  2 +-
 tests/generic/270     |  2 +-
 11 files changed, 98 insertions(+), 99 deletions(-)

-- 
2.33.0



