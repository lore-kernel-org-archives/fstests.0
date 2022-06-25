Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3552CCA483
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Jun 2022 03:08:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232233AbiFYDIQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jun 2022 23:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbiFYDHi (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jun 2022 23:07:38 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DD768039
        for <fstests@vger.kernel.org>; Fri, 24 Jun 2022 20:07:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25P37Wls010342
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 23:07:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656126454; bh=rirSfUyfhF+hx9r8zPJOfMx2xQO1ptOrWlvTyoXON/k=;
        h=From:To:Cc:Subject:Date;
        b=NpQmTxQaqzVP+ETeegdIX8pY22wxI9V10yoambN+X3ohXfaZJKtC7D3JrSnmcDZMZ
         RXQfSiBCuQIqpvn77M/K6CBySRE5VHEVgxw3SnXrUURPYh03fI8mUXrmadLSQdGMNi
         Ba7dyj8MPJBiLACTt5vNwBGcmfVIritqtlJz3BRaORDvo1zbpeA6IsqM5RPaO/2sv4
         H6sRZwhNzfg9+CConh7QIg6OtacDFSV5LLp51ucbPeWPvQUUUnmDtMrfzeBJ1PaHYk
         fjNX/A3NQz2KPP+U3Rc7O4S/8IeMFbqLs9B2nPeXMKpBgvjRwyUT4AcHI6yfbB4MDI
         IRcGbSKH0wJ6A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C435A15C430E; Fri, 24 Jun 2022 23:07:32 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/5] Misceillaneous ext4 test fix ups
Date:   Fri, 24 Jun 2022 23:07:13 -0400
Message-Id: <20220625030718.1215980-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The first patch has been in my tree for a long time, but I had forgotten
to send it upstream.

The last two patches are a rewrite (in response to comments) of
"ext4/054,ext4/055: don't run when using DAX" which I had sent in late
April.

Theodore Ts'o (5):
  ext4/050: support indirect as well as extent mapped journals
  ext4/044: skip test if the file system does not have a journal
  ext4/045: clean up unnecessary arguments to _require_e2fsprogs
  ext4/054: skip test if the dax mount option is enabled
  ext4/055: skip test if dax mount option is used

 common/rc      |  3 +++
 tests/ext4/044 |  6 ++++++
 tests/ext4/045 |  2 +-
 tests/ext4/050 | 58 +++++---------------------------------------------
 tests/ext4/054 |  5 ++---
 tests/ext4/055 |  1 +
 6 files changed, 18 insertions(+), 57 deletions(-)

-- 
2.31.0

