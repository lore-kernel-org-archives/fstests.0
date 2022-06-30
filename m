Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D30DC433EF
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Jun 2022 14:46:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235159AbiF3Oqp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiF3Oqp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 30 Jun 2022 10:46:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1011C127
        for <fstests@vger.kernel.org>; Thu, 30 Jun 2022 07:46:43 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25UEkd7w005638
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 10:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656600400; bh=vKtR+RQUNhgRSRUyKgANCy6z500hnOgkSuNxNQJIQHA=;
        h=From:To:Cc:Subject:Date;
        b=X/6A+XK4NtqKCuKaQ8zfz0DrMmhMq/14eBtXbtkkcgS1D6DR4/OyQizo9c7Jjzk8Z
         n1VXTd1imBLP3aNyTCWyx0P9gSHi1tNm+rYc7kTUH1IaycOdMM6/v9NptX88VphR/I
         +jLpE/0rchrppfAJtqZsxa/omyX+OjHUkYOVf26Wsxgd+84J1+KA/5Fzp65AnFDEC2
         imsr0z9iqLpkiidiPN4LjL9GbV5YpvH6ZyMr2MEyPMyJvqBTEZCLz/OYSeQ8tqhSVx
         R/ILwsGeLuPycZx52rSKzCCHbOb3u6PNFxJluoeW+kokfZIDVdbE444nA21Ml5ar2J
         tzUlm8CQ0Y7jg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 425D315C3E94; Thu, 30 Jun 2022 10:46:39 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -v4 0/7] Miscellaneous ext4 test fix ups
Date:   Thu, 30 Jun 2022 10:46:30 -0400
Message-Id: <20220630144637.478568-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Previous versions of this patch series can be found at:

 - v1: https://lore.kernel.org/r/20220625030718.1215980-1-tytso@mit.edu
 - v2: https://lore.kernel.org/r/20220628182545.1834145-1-tytso@mit.edu
 - v3: https://lore.kernel.org/r/20220629124540.175775-1-tytso@mit.edu

This branch is also available at:

	https://github.com/tytso/xfstests for-upstream

Theodore Ts'o (7):
  ext4/050: support indirect as well as extent mapped journals
  ext4/044: skip test if the file system does not have a journal
  ext4/045: _require_dumpe2fs doesn't take any arguments so remove them
  ext4/054: skip test if the dax mount option is enabled
  ext4/055: skip test if dax mount option is used
  ext4/035: skip this test if the scratch device does not support 1k
    block sizes
  ext4: create file systems with the encrypt feature as necessary

 common/rc         |  3 +++
 tests/ext4/003    |  6 ++++-
 tests/ext4/035    |  9 +++++++-
 tests/ext4/044    |  1 +
 tests/ext4/045    |  2 +-
 tests/ext4/050    | 58 ++++-------------------------------------------
 tests/ext4/054    |  5 ++--
 tests/ext4/055    |  1 +
 tests/ext4/306    |  5 +++-
 tests/generic/260 |  3 +++
 10 files changed, 33 insertions(+), 60 deletions(-)

-- 
2.31.0

