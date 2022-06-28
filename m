Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81A8CCA47F
	for <linux-fstests@archiver.kernel.org>; Tue, 28 Jun 2022 18:25:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231200AbiF1SZ7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 28 Jun 2022 14:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231223AbiF1SZz (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 28 Jun 2022 14:25:55 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12A122127C
        for <fstests@vger.kernel.org>; Tue, 28 Jun 2022 11:25:54 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25SIPnUJ025887
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Jun 2022 14:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656440750; bh=01zh1l+/CwusLEOoMuM+Nt7LBfimHMY7Wsi0Hn+1ARY=;
        h=From:To:Cc:Subject:Date;
        b=QLUmaETeGDjSr2UZSb2p3r+IeE5kRYm3rfYdroPxy6qxerqZYNrH40FZzKvn8+vfE
         onZYKbFSUYapCVMmXmhTTnywVg4u2Gzk2wucmoAY8oUnP0ThtqPnopCLm+EXn3M4Sr
         6hfTV+tJexlfXAgxJpK8hqQvNY7orXBhrDmV2UZiojSEMZti+xm+UbfWSwVl+0bwwi
         mvaOofKrByxGndGXFDq/R4582hZ+kj3pTW5TiBXY2Kgw2AybXRdAKNKOurOK0F00B3
         PoYQr8Jkg0xuMfd6RHYH2MGuvnouYDjg4GKy9tsze4n6r+tgBRo3C/45p298bOrTc1
         sisVWI2fkdhMA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7AD8D15C4311; Tue, 28 Jun 2022 14:25:49 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -v2 0/6] Miscellaneous ext4 test fix ups
Date:   Tue, 28 Jun 2022 14:25:39 -0400
Message-Id: <20220628182545.1834145-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This addresses the review comments of the patch series at:

https://lore.kernel.org/r/20220625030718.1215980-1-tytso@mit.edu

There is also an additional patch to fix test failures when the config
is testing ext4's encrypt feature to address tests which overrides
MKFS_OPTIONS.

Theodore Ts'o (6):
  ext4/050: support indirect as well as extent mapped journals
  ext4/044: skip test if the file system does not have a journal
  ext4/045: _require_dumpe2fs doesn't take any arguments so remove them
  ext4/054: skip test if the dax mount option is enabled
  ext4/055: skip test if dax mount option is used
  ext4: create file systems with the enrypt feature if necessary

 common/rc         |  3 +++
 tests/ext4/003    |  6 ++++-
 tests/ext4/035    |  5 +++-
 tests/ext4/044    |  1 +
 tests/ext4/045    |  2 +-
 tests/ext4/050    | 58 ++++-------------------------------------------
 tests/ext4/054    |  5 ++--
 tests/ext4/055    |  1 +
 tests/ext4/306    |  3 +++
 tests/generic/260 |  5 +++-
 10 files changed, 29 insertions(+), 60 deletions(-)

-- 
2.31.0

