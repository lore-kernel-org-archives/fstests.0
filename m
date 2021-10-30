Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5FFC433F5
	for <linux-fstests@archiver.kernel.org>; Sat, 30 Oct 2021 08:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC1B4600D4
	for <linux-fstests@archiver.kernel.org>; Sat, 30 Oct 2021 08:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhJ3IhO (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sat, 30 Oct 2021 04:37:14 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:2922 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229546AbhJ3IhO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 30 Oct 2021 04:37:14 -0400
IronPort-Data: =?us-ascii?q?A9a23=3AvaWY1KBoa7KkEhVW/zXhw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fBwGxhzki3zVWy2cZXz3UbK2CNGr0fd8jaNuw9UgD656Ax9UxeLYW3SszFioV8?=
 =?us-ascii?q?6IpJjg4wn/YZnrUdouaJK5ex512huLocYZkERcwmj/3auK49CEmhPnTLlbBILW?=
 =?us-ascii?q?s1h5ZFFYMpBgJ2UoLd94R2uaEsPDha++/kYqaT/73ZDdJ7wVJ3lc8sMpvnv/AU?=
 =?us-ascii?q?MPa41v0tnRmDRxCUcS3e3M9VPrzLonpR5f0rxU9IwK0ewrD5OnREmLx9BFrBM6?=
 =?us-ascii?q?nk6rgbwsBRbu60Qqm0yIQAvb9xEMZ4HFaPqUTbZLwbW9NljyPhME3xtNWqbS+V?=
 =?us-ascii?q?AUoIrbR3u8aVnG0FgknZPMYouCaeCTXXcu7iheun2HX6/t1EEwtIZYw5Ol6Gyd?=
 =?us-ascii?q?N+OYeJTRLaQqM799aaprTpvJE35xldZe0ethE/CwI8N0QNt5+KbirfkkAzYYwM?=
 =?us-ascii?q?O8Mu/1z?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3ACjRkXa1K54q4ZrFc97M+TAqjBKkkLtp133Aq?=
 =?us-ascii?q?2lEZdPUzSKylfqGV/cjzuiWatN98YhwdcLO7UpVoI0mslqKdiLN5VdyftWHdyQ?=
 =?us-ascii?q?mVxepZg7cKrQeNJxHD?=
X-IronPort-AV: E=Sophos;i="5.87,194,1631548800"; 
   d="scan'208";a="116627514"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 30 Oct 2021 16:34:42 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id E659A4D0DC96
        for <fstests@vger.kernel.org>; Sat, 30 Oct 2021 16:34:38 +0800 (CST)
Received: from G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.85) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Sat, 30 Oct 2021 16:34:39 +0800
Received: from irides.mr.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD09.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Sat, 30 Oct 2021 16:34:37 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
Subject: [PATCH v2 0/3] Random fixes for generic
Date:   Sat, 30 Oct 2021 16:34:30 +0800
Message-ID: <20211030083433.3616711-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: E659A4D0DC96.A1508
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patchset fixes some description or typo found in generic during me
reading the testcase.

Changes form V1:
  1. Update another typo.

==
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
 tests/generic/270     |  4 ++--
 11 files changed, 99 insertions(+), 100 deletions(-)

-- 
2.33.0



