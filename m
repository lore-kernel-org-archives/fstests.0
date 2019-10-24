Return-Path: <SRS0=fGqU=YR=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D293CA9EAF
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Oct 2019 20:46:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62E002084C
	for <linux-fstests@archiver.kernel.org>; Thu, 24 Oct 2019 20:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571950019;
	bh=qG//jemOf0oV7yOFCo4p6dDb+1bp2vMf1ErKHQyQct0=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=BIa8mnGaZKjtwVBgrAHSevCN+zFoFdXxeirEHydVooktVh79WOWKg4ij4n+0HCEEt
	 BbbuK3aQXe6ASrBCBCeD458At7Sq+ZrMcUBpDaEZRhe/DopfI4JHp1OrQYVIdBnPVM
	 4MfDjmJlDqiRqIpx9GRKbl/aPMtsuGtQrXyQunf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbfJXUq7 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 24 Oct 2019 16:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:42134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726973AbfJXUq7 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 24 Oct 2019 16:46:59 -0400
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B5CC20578;
        Thu, 24 Oct 2019 20:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571950018;
        bh=qG//jemOf0oV7yOFCo4p6dDb+1bp2vMf1ErKHQyQct0=;
        h=From:To:Cc:Subject:Date:From;
        b=BFsIDGH6/024dJ2xIIQ7ihyt6NIegUJ5bXhyScRWsj0UNXJZKfMNrB7tsv8pnQTWu
         uDl89+oVJLG33wo3AbKwcDK2LuGFuZb2LEPjjEQSQXPyhiEgJmKvedkODYJIsKglqx
         UiViBdydGTvrFYA50tJkpzYjndSIbYEOFwU98lzA=
From:   Eric Biggers <ebiggers@kernel.org>
To:     fstests@vger.kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH] common/rc: skip encrypted direct I/O tests on f2fs
Date:   Thu, 24 Oct 2019 13:45:29 -0700
Message-Id: <20191024204529.90714-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0.rc0.303.g954a862665-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Skip the O_DIRECT tests on f2fs when the test_dummy_encryption mount
option is given, for the same reason as given for ext4 in
commit 9b154b26e4a1 ("common/rc: ext4 doesn't support O_DIRECT with
encryption").

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 common/rc | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/common/rc b/common/rc
index cfaabf10..7c94307a 100644
--- a/common/rc
+++ b/common/rc
@@ -2216,10 +2216,13 @@ _require_xfs_io_command()
 # check that kernel and filesystem support direct I/O
 _require_odirect()
 {
-	if [ $FSTYP = "ext4" ] ; then
+	if [ $FSTYP = "ext4" ] || [ $FSTYP = "f2fs" ] ; then
 		if echo "$MOUNT_OPTIONS" | grep -q "test_dummy_encryption"; then
-			_notrun "ext4 encryption doesn't support O_DIRECT"
-		elif echo "$MOUNT_OPTIONS" | grep -q "data=journal"; then
+			_notrun "$FSTYP encryption doesn't support O_DIRECT"
+		fi
+	fi
+	if [ $FSTYP = "ext4" ] ; then
+		if echo "$MOUNT_OPTIONS" | grep -q "data=journal"; then
 			_notrun "ext4 data journaling doesn't support O_DIRECT"
 		fi
 	fi
-- 
2.24.0.rc0.303.g954a862665-goog

