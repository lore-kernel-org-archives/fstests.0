Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3E5AC6FA82
	for <linux-fstests@archiver.kernel.org>; Tue, 13 Sep 2022 09:33:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiIMJdw (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 13 Sep 2022 05:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiIMJdv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 13 Sep 2022 05:33:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0C895B05E
        for <fstests@vger.kernel.org>; Tue, 13 Sep 2022 02:33:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 80389B80DFE
        for <fstests@vger.kernel.org>; Tue, 13 Sep 2022 09:33:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DB8C433C1
        for <fstests@vger.kernel.org>; Tue, 13 Sep 2022 09:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663061628;
        bh=QFvWDzShcmNAiIJbJ+F3aXFSWDnEDYU4GmWnnXqq+M8=;
        h=From:To:Subject:Date:From;
        b=QF10Sai3SDJFvusprRg787/+wk/D+yzyzWpcO9QjTrvI8wpkmbLJr6UNmH6UDOc77
         jJOBeoD5luxUROdZmb3nFJXk/LQcACeavL8BKfYEOep5TO5pfFTk04VVMW6BpHC2tt
         AZPN65b8zdn2yMQjruS9Yd4tlwoGxVB/uTHwvfaqTWG8nbsoRf7AfgbX2zfNi7rMxY
         KVGDFLH3C7JXBwHOFtfj7Bu/1F/bMpH56qdgv+EoIdoIIZKguE2YZxXQJGttztg4OK
         MJ6X57zuaYnUsQn6mBvHXtO65Ql9EULBOUdG09ZkqcOsUWC6Pp0IetQkXoSU8OAmqY
         bRWpk2oId7igw==
From:   Zorro Lang <zlang@kernel.org>
To:     fstests@vger.kernel.org
Subject: [PATCH] common/rc: replace obsolescent egrep and fgrep
Date:   Tue, 13 Sep 2022 17:33:45 +0800
Message-Id: <20220913093345.84370-1-zlang@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Due to the change in grep project:
  a95156247098 ("egrep, fgrep: now obsolete")

some tests start to fail on latest Fedora system with grep-3.8-1.fc38
or newer version, as:

  generic/447 70s ... egrep: warning: egrep is obsolescent; using grep -E
  ...
      @@ -1,4 +1,5 @@
       QA output created by 447
      +egrep: warning: egrep is obsolescent; using grep -E
      ...

So use grep -E and -F to instead of egrep and fgrep commands.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---
 common/rc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/common/rc b/common/rc
index a25cbcd0..dee3965e 100644
--- a/common/rc
+++ b/common/rc
@@ -30,6 +30,17 @@ dd()
 	fi
 }
 
+# The egrep and fgrep are obsolescent
+egrep()
+{
+	grep -E "$@"
+}
+
+fgrep()
+{
+	grep -F "$@"
+}
+
 # Prints the md5 checksum of a given file
 _md5_checksum()
 {
-- 
2.31.1

