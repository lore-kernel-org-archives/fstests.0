Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49DFC433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 29 Jun 2022 12:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiF2Mpt (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 29 Jun 2022 08:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbiF2Mpr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 29 Jun 2022 08:45:47 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A87134B90
        for <fstests@vger.kernel.org>; Wed, 29 Jun 2022 05:45:46 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 25TCjga5023645
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Jun 2022 08:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1656506743; bh=NDZVyZ5gvfyrcqKY2Brg3MnGgp5+uwqYZsM4M2WU+xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JezrHWZuQuFQKKQNcyZ2ZhSdO6ku8eLlm6z2s/9EBJN1WFrv9QmlOkIi14fVw5GVL
         TMlm29vKPTybzy579F7q6xozwFyy0ZsOc8SOP3Jo5t2AJ3hcOFDNTieejxdw4r0PkH
         fIoN13nbmZpwC05qOWvBztDwjnxwd0WrNNRdimwZlr2SIsQ0A03qk+xI2pvqHdJGH7
         FRDZYa1b8Upm1KT+MPfptRsGns/zw0W0DLRFdAuMr48qZek11aTj/Rn09c7J2DiQWE
         xWq1sju16JziL9vrgumC3cZ5cm+rpTzlTR36WD9IbxNGfdRp6qp2jUAfa9mk+iPA7M
         uICGLGDZ+KVjw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 36FEF15C4330; Wed, 29 Jun 2022 08:45:41 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     fstests@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH -v3 5/7] ext4/055: skip test if dax mount option is used
Date:   Wed, 29 Jun 2022 08:45:38 -0400
Message-Id: <20220629124540.175775-6-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220629124540.175775-1-tytso@mit.edu>
References: <20220629124540.175775-1-tytso@mit.edu>
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

