Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12AF1C433F5
	for <linux-fstests@archiver.kernel.org>; Fri, 20 May 2022 01:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344216AbiETBfk (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 19 May 2022 21:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240489AbiETBfk (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 19 May 2022 21:35:40 -0400
Received: from heian.cn.fujitsu.com (mail.cn.fujitsu.com [183.91.158.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18EA29BACD
        for <fstests@vger.kernel.org>; Thu, 19 May 2022 18:35:38 -0700 (PDT)
IronPort-Data: =?us-ascii?q?A9a23=3AKykLZKu9qT4JSsHwSa38CY4xfOfnVEpcMUV32f8?=
 =?us-ascii?q?akzHdYEJGY0x3yWMfW2qGOfaNMzGheN0lPtnioE1XuZXTztIwTwVkrX1gHilAw?=
 =?us-ascii?q?SbnLY7Hdx+vZUt+DSFioHpPtpxYMp+ZRCwNZie0SiyFb/6x/RGQ6YnSHuCmULS?=
 =?us-ascii?q?cY3goLeNZYHxJZSxLyrdRbrFA0YDR7zOl4bsekuWHULOX82cc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTeUtMTKPQPBSVlzxdXK3Kbhpq/3R0i/hkcqFHLxo/ZzahxridzP1XqJW2U?=
 =?us-ascii?q?hZvMKvXhMwTThtZDzpje6ZB/dcrJFDm65DIkRSZIyGEL/JGSRte0Zcj0uhsHWx?=
 =?us-ascii?q?V6ecwNj8AdFaAiviwzbb9TfNj7vnPhuGD0Jg34ykmlG+GS619B82rfkkD3vcAt?=
 =?us-ascii?q?B9YuyyENa+2ixIlVAdS?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AJ1nUf6icNquQ9jVmCf0kxrkiYXBQXjIji2hC?=
 =?us-ascii?q?6mlwRA09TySZ//rBoB19726RtN9xYgBGpTnuAsm9qB/nmaKdgrNhWItKPjOW21?=
 =?us-ascii?q?dARbsKheCJrgEIcBeeygcy78hdmtBFeb/N5EZB/L3HyTj9A9A928OG7aztoe/f?=
 =?us-ascii?q?yk1mRQZsZ7oI1XYBNi+rVl1xWBJdBYc0UL6V5s98rTKmfngNKuuhAH1tZZm6m/?=
 =?us-ascii?q?T70ILhfQUdBwMqrC2HjTaT4rb8FBSCmjcyOgk/p4sfzQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.88,333,1635177600"; 
   d="scan'208";a="124361782"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 20 May 2022 09:35:38 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 3DE9A4D17179
        for <fstests@vger.kernel.org>; Fri, 20 May 2022 09:35:36 +0800 (CST)
Received: from G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1497.23; Fri, 20 May 2022 09:35:36 +0800
Received: from irides.mr.mr (10.167.225.141) by
 G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.209) with Microsoft SMTP Server
 id 15.0.1497.23 via Frontend Transport; Fri, 20 May 2022 09:35:36 +0800
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH v3 0/3] xfs: add memory failure tests for dax mode
Date:   Fri, 20 May 2022 09:35:31 +0800
Message-ID: <20220520013534.2894233-1-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-yoursite-MailScanner-ID: 3DE9A4D17179.ACD24
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: ruansy.fnst@fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patchset is to verify whether memory failure mechanism still works
with the fsdax-rmap feature.  With this feature, fsdax and reflink can be
used together[1].  So, we also test it for reflinked files in filesystem
mounted with dax option.

Memo: (quoted from v2[2]):
> Never mind. I'd like to merge these tests after your kernel patchset about
> "Add reflink&dedupe support for fsdax" be merged at first. To avoid you
> might add/change something. And I need to see the test works on offical
> kernel at least, before merging it. So feel free to ping me, if I forget
> this patchset at that time

[1] https://lore.kernel.org/linux-xfs/20220508143620.1775214-1-ruansy.fnst@fujitsu.com/
[2] https://lore.kernel.org/fstests/20220513031411.2369314-1-ruansy.fnst@fujitsu.com/T/#mb0197877ad9f89e2de009572c02ac1cdd4f7c8a7

Changes since v2:
  1. Fixed typo in .out files

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



