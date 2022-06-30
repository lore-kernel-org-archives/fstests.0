Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F10D5CCA47B
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Jun 2022 14:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiF3Oqs (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233782AbiF3Oqp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 30 Jun 2022 10:46:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E561C900
        for <fstests@vger.kernel.org>; Thu, 30 Jun 2022 07:46:44 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25UEkdq7005649
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 10:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656600400; bh=1+Vnv4j89PKGRYGm1qoLshwFGEmKo3YRJsS/explSso=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=nwfq2Ooy+VzgcCiO+dahnQsCUGmogJ4SlQflCXNL+O3UOC79gYbPUc1lG1gLbA99d
         eI7NEhPhyxoH43OKJYz6cABSVtNP4rLIs4zqt/OVxU2iK1qaS20GSC4omPXh5fRHxY
         3uslqoa4bXdoFq1K4bvIM/dYMohT8Mh8MqGcFxcqRaC1Jmu8MuJZyy1owdcDGZmDbc
         9aaKCamSzYYmcD6esm9b6FYWJURD0NnR47VwcCrXmu8wCHxZXsnnjrndZmPpb9f5FK
         mchO12Jm1CTXYeG+k9T0B8cu7BJjEEG6a9enA7RPNua1aUPDkGzV+LUVM+oy9cs9Sk
         5bGY3I/olr9wg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4866015C432E; Thu, 30 Jun 2022 10:46:39 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Zorro Lang <zlang@redhat.com>
Subject: [PATCH -v4 3/7] ext4/045: _require_dumpe2fs doesn't take any arguments so remove them
Date:   Thu, 30 Jun 2022 10:46:33 -0400
Message-Id: <20220630144637.478568-4-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220630144637.478568-1-tytso@mit.edu>
References: <20220630144637.478568-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Zorro Lang <zlang@redhat.com>
---
 tests/ext4/045 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/ext4/045 b/tests/ext4/045
index ee7c0de3..4f0ad4aa 100755
--- a/tests/ext4/045
+++ b/tests/ext4/045
@@ -22,7 +22,7 @@ _supported_fs ext4
 _require_scratch
 _require_test_program "t_create_short_dirs"
 _require_test_program "t_create_long_dirs"
-_require_dumpe2fs "$DUMPE2FS_PROG" dumpe2fs
+_require_dumpe2fs
 
 echo "Silence is golden"
 
-- 
2.31.0

