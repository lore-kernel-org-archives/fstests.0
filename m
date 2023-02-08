Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EE0C636D3
	for <linux-fstests@archiver.kernel.org>; Wed,  8 Feb 2023 07:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjBHHEQ (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 8 Feb 2023 02:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjBHHDs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 8 Feb 2023 02:03:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E92245203
        for <fstests@vger.kernel.org>; Tue,  7 Feb 2023 23:02:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58F51B81C3B
        for <fstests@vger.kernel.org>; Wed,  8 Feb 2023 07:02:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25BFC433EF;
        Wed,  8 Feb 2023 07:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675839721;
        bh=04/W/oVcx58Irmqh05c196PsJPbTs+gLrqies6ZiOy0=;
        h=From:To:Cc:Subject:Date:From;
        b=K0HeElE2tpa8JpmaZh1VOZ5OScXS/Qh7QG3kL0x6I+MhEsv8L8j2i/I385VucjNB1
         ca8jdxw6jy5wc0r0n/BTCGCu92enabmKdSC4krsIU8YIUpibCJcT1zXg736ymsYKp3
         InLsWFbEnmGJBKRxf7ptAurrpzn1flCi0x8L0F+ypYQ3cJGetkddUFbDgnsMY6eHLs
         82CdKxhjcncxw3ZrDr+5To8nHCPxYyMd40cFkazb6AXLesV/jz/V4uOy5we475S0E5
         ENroswpn/fiGef5qF8z1U9JeVSeLd9VV/OjRhUjUkKC4vjIjO0NKxBgxmAXh6bfAph
         kpgCtadzvSgvw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     fstests@vger.kernel.org
Subject: [xfstests-bld PATCH] test_appliance: add f2fs/compress config
Date:   Tue,  7 Feb 2023 23:01:56 -0800
Message-Id: <20230208070156.229272-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add a f2fs/compress configuration which causes all files to be
automatically compressed, similar to how f2fs/encrypt causes all files
to be automatically encrypted.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 test-appliance/files/root/fs/f2fs/cfg/all.list | 1 +
 test-appliance/files/root/fs/f2fs/cfg/compress | 5 +++++
 2 files changed, 6 insertions(+)
 create mode 100644 test-appliance/files/root/fs/f2fs/cfg/compress

diff --git a/test-appliance/files/root/fs/f2fs/cfg/all.list b/test-appliance/files/root/fs/f2fs/cfg/all.list
index bc796ff..90a7a36 100644
--- a/test-appliance/files/root/fs/f2fs/cfg/all.list
+++ b/test-appliance/files/root/fs/f2fs/cfg/all.list
@@ -1,2 +1,3 @@
 default
 encrypt
+compress
diff --git a/test-appliance/files/root/fs/f2fs/cfg/compress b/test-appliance/files/root/fs/f2fs/cfg/compress
new file mode 100644
index 0000000..6f2b954
--- /dev/null
+++ b/test-appliance/files/root/fs/f2fs/cfg/compress
@@ -0,0 +1,5 @@
+SIZE=small
+export MKFS_OPTIONS="-O compression,extra_attr"
+export F2FS_MOUNT_OPTIONS="compress_extension=*"
+REQUIRE_FEATURE=compression
+TESTNAME="F2FS compression"
-- 
2.39.1

