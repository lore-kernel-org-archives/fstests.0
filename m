Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B49EFC43334
	for <linux-fstests@archiver.kernel.org>; Sat, 25 Jun 2022 03:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232345AbiFYDIR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 24 Jun 2022 23:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbiFYDIF (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 24 Jun 2022 23:08:05 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6373060FC
        for <fstests@vger.kernel.org>; Fri, 24 Jun 2022 20:08:04 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25P37YCG010381
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jun 2022 23:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656126455; bh=NDZVyZ5gvfyrcqKY2Brg3MnGgp5+uwqYZsM4M2WU+xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=LU3HM3XMisf31qEER6fgbpfYIlsM4QEhhV6qLCyv8BwKIG/QE7oR99NKLVEb54OxY
         YfLEEP0mEuDqjQz2TbA5g1Ayim0q/fc03fCHa7UgvIB7hbmfHKUyJzdKB3jtrzUTpv
         q6Ljz5NHa1FkZq2xlLFFbGXGBjYW6qC0AaUbEpctD2vxKMzSO5y6BzLFZ7fVR0uqP2
         Cc/2NHhvq4ib/usZNaey79Anm1zg/OfEgvJ+kgeujfucor25SxayjjZ5NQo9vKYQIZ
         /oaXXEtNA8aXbgUIZ1ZqunnZAeD9e7IOrZaMnml69No1TBUdx6157dcf0YL11XsF8N
         IFjRCVpQ/FrKw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CD19415C4316; Fri, 24 Jun 2022 23:07:32 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 5/5] ext4/055: skip test if dax mount option is used
Date:   Fri, 24 Jun 2022 23:07:18 -0400
Message-Id: <20220625030718.1215980-6-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220625030718.1215980-1-tytso@mit.edu>
References: <20220625030718.1215980-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test creates a 1k block file system with the quota feature
enabled.   As such, it is incompatible with DAX.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 tests/ext4/055 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/ext4/055 b/tests/ext4/055
index 8f466f1b..aa15cfe9 100755
--- a/tests/ext4/055
+++ b/tests/ext4/055
@@ -26,6 +26,7 @@ _require_command "$DEBUGFS_PROG" debugfs
 echo "Silence is golden"
 
 # The 1K blocksize is designed for debugfs.
+_exclude_scratch_mount_option dax
 _scratch_mkfs "-F -O quota -b 1024" > $seqres.full 2>&1
 
 # Start from 0, fill block 1 with 6，replace the original 2.
-- 
2.31.0

