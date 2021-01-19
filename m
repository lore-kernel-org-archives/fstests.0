Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B81BC433E6
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Jan 2021 06:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDF1A230FF
	for <linux-fstests@archiver.kernel.org>; Tue, 19 Jan 2021 06:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbhASGXm (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 19 Jan 2021 01:23:42 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:52176 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728626AbhASGNg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Jan 2021 01:13:36 -0500
X-IronPort-AV: E=Sophos;i="5.79,357,1602518400"; 
   d="scan'208";a="103608811"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 19 Jan 2021 14:13:10 +0800
Received: from G08CNEXMBPEKD04.g08.fujitsu.local (unknown [10.167.33.201])
        by cn.fujitsu.com (Postfix) with ESMTP id 97C454CE603A;
        Tue, 19 Jan 2021 14:13:05 +0800 (CST)
Received: from localhost.localdomain (10.167.220.84) by
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 19 Jan 2021 14:13:04 +0800
From:   Yang Xu <xuyang2018.jy@cn.fujitsu.com>
To:     <guaneryu@gmail.com>, <tytso@mit.edu>
CC:     <fstests@vger.kernel.org>, Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Subject: [PATCH v2] ext4/046: skip test when ext4 doesn't support bs < ps with dioread_nolock
Date:   Tue, 19 Jan 2021 14:13:39 +0800
Message-ID: <1611036819-5633-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20210117150624.GA2347@desktop>
References: <20210117150624.GA2347@desktop>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD06.g08.fujitsu.local (10.167.33.205) To
 G08CNEXMBPEKD04.g08.fujitsu.local (10.167.33.201)
X-yoursite-MailScanner-ID: 97C454CE603A.AC24E
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: xuyang2018.jy@cn.fujitsu.com
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

When testing arm machine, this case fails because ps > bs and kernel doesn't
introduced commit c8cc88163f40 ("ext4: Add support for blocksize < pagesize in dioread_nolock").
Only skip this case when kernel complains about bs!=ps error, so we can find
dioread_nolock mount regression in the future.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 tests/ext4/046 | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/tests/ext4/046 b/tests/ext4/046
index 5524024e..c6f7a051 100755
--- a/tests/ext4/046
+++ b/tests/ext4/046
@@ -31,13 +31,22 @@ _cleanup()
 # remove previous $seqres.full before test
 rm -f $seqres.full
 
+_require_check_dmesg
 _supported_fs ext4
 _require_scratch
 _require_xfs_io_command "falloc"
 _require_scratch_size $((6 * 1024 * 1024)) #kB
 
 _scratch_mkfs >> $seqres.full 2>&1
-_scratch_mount "-o dioread_nolock" >> $seqres.full 2>&1
+if ! _try_scratch_mount "-o dioread_nolock" >> $seqres.full 2>&1; then
+	err_str="can't mount with dioread_nolock if block size != PAGE_SIZE"
+	_check_dmesg_for ${err_str}
+	if [ $? -eq 0 ]; then
+		_notrun "mount failed, ext4 doesn't support bs < ps with dioread_nolock"
+	else
+		_fail "mount failed with dioread_nolock"
+	fi
+fi
 
 # Get blksz
 blksz=$(_get_file_block_size $SCRATCH_MNT)
-- 
2.23.0



