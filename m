Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DE4C43334
	for <linux-fstests@archiver.kernel.org>; Thu, 30 Jun 2022 14:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiF3Oqr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 30 Jun 2022 10:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232297AbiF3Oqp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 30 Jun 2022 10:46:45 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5D31C13C
        for <fstests@vger.kernel.org>; Thu, 30 Jun 2022 07:46:44 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25UEkdIL005648
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Jun 2022 10:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656600400; bh=OKUO3qmv5wlwfMCWmEO6JQFe+sIB9qrZ4gUMvU0UBBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=GFHtDZnjqqk08H+rOL8cdCSSkg2AzqqWxA5BwHc1CXWNEZbGjNteeCcyxhJvgYTvA
         8YOWS4OZUzsAisl6BlDqlfqKr5UdZJLvQMBDhIQN2ZeZFzdprKjqqY5nhuVas1YI4x
         cGXUUuwuF6PPZsGH+ECmJAWolpVQItqFPKR9XSswv8A2vooIUwXceXOQtKx6Hj+3yC
         JB/sDXOCVb1iIUdXb5lZXdyU8bHl9zWO5zHWk+DR0ygE6mkrDhbQCSbX8RbfGV9WhL
         YcDcanfB7Dv3QiYzoZ+Nmldu1rJqva0XzxCBAW1pUMb/g4jnSAcYav2dj2yoDZeUvo
         4LYg6W7zT2XsA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4681D15C432C; Thu, 30 Jun 2022 10:46:39 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Zorro Lang <zlang@redhat.com>
Subject: [PATCH -v4 2/7] ext4/044: skip test if the file system does not have a journal
Date:   Thu, 30 Jun 2022 10:46:32 -0400
Message-Id: <20220630144637.478568-3-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220630144637.478568-1-tytso@mit.edu>
References: <20220630144637.478568-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This test mounts the file system using "mount -t ext3"; if the file
system config creates the file system without the jbd2 journal, the
"mount -t ext3" will fail.  So skip this test in that case.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Reviewed-by: Zorro Lang <zlang@redhat.com>
---
 tests/ext4/044 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tests/ext4/044 b/tests/ext4/044
index 46e44053..158e2ac5 100755
--- a/tests/ext4/044
+++ b/tests/ext4/044
@@ -16,6 +16,7 @@ _begin_fstest auto quick
 _supported_fs ext4
 _require_scratch
 _require_test_program "t_get_file_time"
+_require_metadata_journaling
 
 echo "Silence is golden"
 
-- 
2.31.0

