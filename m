Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4D87C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jun 2022 12:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbiF2Mpr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 08:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233424AbiF2Mpp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 08:45:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C782F647
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 05:45:44 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25TCjfKT023604
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 08:45:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656506742; bh=8jk1zU4kks/IlqcTgRrOW9IxGUhBuzL8Xnn42pK6CjA=;
        h=From:To:Cc:Subject:Date;
        b=bDpGknQeSrbk6iRbpE9V4T2IN3Ttt75u7O9uOfujH0b1GgWcZDk2IfkJ7DWrj4CX3
         RNJgXq2L7rgAS5VVZ59ytlXL7pnlqdTI1sVf9ijKn0oaMavqSZPf+5ZJiXqxX8R/x2
         2AonrvyRU3RdZQydHU91DKbY9jZsv8UKS7rDeUhYtn9//YlfzZ999u43eEoGAmpD8f
         3HlsH38XNOtHLeM4puBGmtw6kr985LzRlfDW2VZ75yj8r2bW+apqvJKusBHfCX3OKw
         m5kH7XpeAKCjh/PNwXxYQDcFX34dCw1JmJiTHimx0cLqQ3w/iIYPsvkne7QMab+eua
         JadqA/Nmb+eoA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2E69315C3E94; Wed, 29 Jun 2022 08:45:41 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -v3 0/7] Miscellaneous ext4 test fix ups
Date:   Wed, 29 Jun 2022 08:45:33 -0400
Message-Id: <20220629124540.175775-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Pull in an out-of-tree patch, "ext4/035: skip this test if the scratch
device does not support 1k block sizes" which is needed for the last
patch for this series. "ext4: create file systems with the encrypt
feature as necessary".

Previous versions of these patch series:

https://lore.kernel.org/r/20220625030718.1215980-1-tytso@mit.edu
https://lore.kernel.org/r/20220628182545.1834145-1-tytso@mit.edu

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
 tests/ext4/035    |  8 ++++++-
 tests/ext4/044    |  1 +
 tests/ext4/045    |  2 +-
 tests/ext4/050    | 58 ++++-------------------------------------------
 tests/ext4/054    |  5 ++--
 tests/ext4/055    |  1 +
 tests/ext4/306    |  3 +++
 tests/generic/260 |  5 +++-
 10 files changed, 32 insertions(+), 60 deletions(-)

-- 
2.31.0

