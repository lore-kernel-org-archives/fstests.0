Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F86C19F28
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Aug 2022 04:52:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbiHCEv6 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 3 Aug 2022 00:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235699AbiHCEvy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Aug 2022 00:51:54 -0400
Received: from mail3.bemta32.messagelabs.com (mail3.bemta32.messagelabs.com [195.245.230.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3AD5721F
        for <fstests@vger.kernel.org>; Tue,  2 Aug 2022 21:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
        s=170520fj; t=1659502309; i=@fujitsu.com;
        bh=5Pmx5LsiEs+FDZsHfxq/QYZNyEqEMmWRUK5iKb6kfrE=;
        h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=YtCrv5iKa8G/3ivJGCHMiNtw5/eK6NuFoEFIctuyxG5BHWT43WN7Ie01mDSBqM/2d
         itTyz3aVm4MP8qqDK2vdLWEcQD3yYtO3v5WJTqldNqANB0i7q4JcEpBPpUzR/lRsLi
         KAdaZTAgCw+JPteuCRK7llhoWKA75jYy4CljKJO1M+uii20elSmsXlbiSVLu5omB/D
         PrIGiiF5CK5aHqXrpIZnrrTQZr8Q6bI1Aekmqnn/Bc7wD0iVysqykdEUYLBgHbbILC
         vkpCAAZ6SX2457zp8QOrxlwd3oAhIcDXUOdDdKmJarmc9xJ9MGKlEq7JSo4k2PNLQq
         nTVUpVr2m5vGw==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRWlGSWpSXmKPExsViZ8MxSffJv5d
  JBr++m1ucbtnL7sDo8XmTXABjFGtmXlJ+RQJrxtHf95gLpvNUTHx+gL2BcQZnFyMnh5DAJUaJ
  U9dLuhi5gOyjTBIzlyxhhXD2MEoc/HyKGaSKTUBH4sKCv6wgtoiArMT/GauZQGxmIHvX8wVsI
  LawgJPEiasf2UFsFgEViRs7D4PZvAIuEo8/7ASrkRBQkJjy8D0zRFxQ4uTMJywQcyQkDr54AR
  TnAKpRkpjZHQ9RXiExa1YbE4StJnH13CbmCYz8s5B0z0LSvYCRaRWjVVJRZnpGSW5iZo6uoYG
  BrqGhqa6hrpGBsV5ilW6iXmqpbnlqcYmuoV5iebFeanGxXnFlbnJOil5easkmRmBAphQznt7B
  uKnvp94hRkkOJiVRXsk/L5OE+JLyUyozEosz4otKc1KLDzHKcHAoSfA6g+QEi1LTUyvSMnOA0
  QGTluDgURLhZQRJ8xYXJOYWZ6ZDpE4x6nKsbTiwl1mIJS8/L1VKnPfqX6AiAZCijNI8uBGwSL
  3EKCslzMvIwMAgxFOQWpSbWYIq/4pRnINRSZh3Gsgqnsy8ErhNr4COYAI6QofrBcgRJYkIKak
  GJsNlz4UPeiRlFR/wnqPyuv/bBMdJNblLdm86Kaja8jB+mcxm9qX3JEK92DaE5F73Cny7KbpQ
  cNmtC8smFdwWMCh+0Hi8nW3bzUXcOp+2XcrTf97BMmmbGY/C3G2TNxyU/hY5x6+g76mrmdH+l
  p8vbB7OeD3nnLv2FlOhgLDzn/Zqcqtvtf3hoqrx/P65gNizx7JCXk7+XRr6em+ta7z35W33t/
  +Oit/ZreEW//X+nL0eHM2W/zftzl5UPWWO4rcYHn4xS6O9pteFFy83j3cMvntH5L6gsfSlMjF
  V9pO+kz+unWpyhnWnzgFP/oMZM19lnKrp/eybYBf6r379Y3m+a0uNH7U/MfvpJJyQbDH32T4l
  luKMREMt5qLiRAB5Wv5HTwMAAA==
X-Env-Sender: ruansy.fnst@fujitsu.com
X-Msg-Ref: server-14.tower-585.messagelabs.com!1659502308!19310!1
X-Originating-IP: [62.60.8.146]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.87.3; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 25165 invoked from network); 3 Aug 2022 04:51:48 -0000
Received: from unknown (HELO n03ukasimr02.n03.fujitsu.local) (62.60.8.146)
  by server-14.tower-585.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP; 3 Aug 2022 04:51:48 -0000
Received: from n03ukasimr02.n03.fujitsu.local (localhost [127.0.0.1])
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTP id 8BE521000CE
        for <fstests@vger.kernel.org>; Wed,  3 Aug 2022 05:51:48 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (R01UKEXCASM126 [10.183.43.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by n03ukasimr02.n03.fujitsu.local (Postfix) with ESMTPS id 7F1AB100077
        for <fstests@vger.kernel.org>; Wed,  3 Aug 2022 05:51:48 +0100 (BST)
Received: from localhost.localdomain (10.167.225.141) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 3 Aug 2022 05:51:46 +0100
From:   Shiyang Ruan <ruansy.fnst@fujitsu.com>
To:     <fstests@vger.kernel.org>
CC:     <ruansy.fnst@fujitsu.com>
Subject: [PATCH v4 0/3] xfs: add memory failure tests for dax mode
Date:   Wed, 3 Aug 2022 04:51:28 +0000
Message-ID: <1659502291-19-1-git-send-email-ruansy.fnst@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.225.141]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This patchset is to verify whether memory failure mechanism still works
with the fsdax-rmap feature.  With this feature, fsdax and reflink can be
used together[1].  So, we also test it for reflinked files in filesystem
mounted with dax option.

[1] https://lore.kernel.org/linux-xfs/20220508143620.1775214-1-ruansy.fnst@fujitsu.com/

Changes since v3:
  1. Update the copyright

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
 tests/xfs/900                   |  50 ++++++++++
 tests/xfs/900.out               |   9 ++
 tests/xfs/901                   |  51 +++++++++++
 tests/xfs/901.out               |   9 ++
 tests/xfs/902                   |  54 +++++++++++
 tests/xfs/902.out               |   9 ++
 9 files changed, 342 insertions(+), 1 deletion(-)
 create mode 100644 src/t_mmap_cow_memory_failure.c
 create mode 100755 tests/xfs/900
 create mode 100644 tests/xfs/900.out
 create mode 100755 tests/xfs/901
 create mode 100644 tests/xfs/901.out
 create mode 100755 tests/xfs/902
 create mode 100644 tests/xfs/902.out

-- 
2.37.1

