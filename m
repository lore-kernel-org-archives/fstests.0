Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B53C43334
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Jun 2022 14:46:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiF3Oqt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiF3Oqq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 30 Jun 2022 10:46:46 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ADA71C12A
        for <fstests@vger.kernel.org>; Thu, 30 Jun 2022 07:46:46 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25UEkeW6005677
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 10:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656600402; bh=yf7Y0BGdOqfJn7l0dlt2/87VQnD1Mws0E4mKBd/PwtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=VZ0cADXvGMSUiFE6Omq3ly5wxLaGTIOKq7qya4IQFKFUiNASN6jB3DUVqRIYXlmRJ
         /BcoHqf/My9r1lMzvecaxgjmFiTthMjkUiZ+O5X3u05CNsyFW+JDcJa9SVdBCiy1eB
         d90KivtsqMFQHo/gpcXYTw1GEtrgWbDKyZ0DBwB0cVbMsspkp6KI96sylc/97M9Qy8
         a524hOP8P6k/XQL/tjdJSNfuOPmj2WOn45uuGhc8MzA+2F0pWTaGJGeEqyOrQnMmr9
         /W9fbhyqkqaxRyL5cFAVbOOOdq6Xd+3WsrDxddZiB87dBlKG1LpZ6R9SWj/vaZcBJ+
         jotM7gEpMETQQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4C9C215C4330; Thu, 30 Jun 2022 10:46:39 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Zorro Lang <zlang@redhat.com>
Subject: [PATCH -v4 5/7] ext4/055: skip test if dax mount option is used
Date:   Thu, 30 Jun 2022 10:46:35 -0400
Message-Id: <20220630144637.478568-6-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220630144637.478568-1-tytso@mit.edu>
References: <20220630144637.478568-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test creates a 1k block file system with the quota feature
enabled.   As such, it is incompatible with DAX.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Zorro Lang <zlang@redhat.com>
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

