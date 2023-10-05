Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70431E92700
	for <linux-fstests@archiver.kernel.org>; Thu,  5 Oct 2023 13:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232089AbjJEN7h (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 5 Oct 2023 09:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjJEN5g (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 5 Oct 2023 09:57:36 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B151991
        for <fstests@vger.kernel.org>; Wed,  4 Oct 2023 20:43:07 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 76DC12184B;
        Thu,  5 Oct 2023 03:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1696477380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=sQ5kNyJKpOGisvBNGoSlD0DNdlmyK9MFPpT3Nc06aDM=;
        b=n6YiBNsS5TIaD3iOMFUWHf0pdIBuqkW4Q3Swi4g5IRFyIoVajL1n+FHOZWL9gmlt/5VlIs
        kGtgU2h46zxk9RMb5g849MOB/zDwLh8e6FZOa4xIOlDzn2b4vcllf5EzSJ2yTELUbPm0mr
        zLoXoYkyL9tNoX2A+yKw7maUSBdq694=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4C46E13597;
        Thu,  5 Oct 2023 03:42:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nCESBcMwHmXGXwAAMHmgww
        (envelope-from <glass.su@suse.com>); Thu, 05 Oct 2023 03:42:59 +0000
From:   Su Yue <glass.su@suse.com>
To:     fstests@vger.kernel.org
Cc:     l@damenly.org, Su Yue <glass.su@suse.com>
Subject: [PATCH] generic/245: Filter mv error message
Date:   Thu,  5 Oct 2023 11:42:55 +0800
Message-ID: <20231005034255.2031-1-glass.su@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Coreutils commit 3cb862ce5f10 ( mv: better diagnostic for 'mv dir x' failure)
was released in v9.4, changed the error message from
'mv: cannot move 'b/t' to 'a/t': Directory not empty' to
'mv: cannot overwrite 'a/t': Directory not empty' in case of
EDQUOT/EEXIST/EISDIR/EMLINK/ENOSPC/ENOTEMPTY/ETXTBSY.

The change breaks generic/245 due to the mismatched output:

generic/245 1s ... - output mismatch (see /root/xfstests-dev/results//generic/245.out.bad)
    --- tests/generic/245.out   2023-10-05 11:15:21.124295738 +0800
    +++ /root/xfstests-dev/results//generic/245.out.bad 2023-10-05 11:15:23.456315468 +0800
    @@ -1,2 +1,2 @@
    QA output created by 245
    -mv: cannot move 'TEST_DIR/test-mv/ab/aa/' to 'TEST_DIR/test-mv/aa': File exists
    +mv: cannot overwrite 'TEST_DIR/test-mv/aa': File exists
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/245.out /root/xfstests-dev/results//generic/245.out.bad'  to see the entire diff)

Filter out the common part of mv error messages to fix the test.

Signed-off-by: Su Yue <glass.su@suse.com>
---
 tests/generic/245     | 4 +++-
 tests/generic/245.out | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/tests/generic/245 b/tests/generic/245
index e2d5c926e906..31f9dd1873b6 100755
--- a/tests/generic/245
+++ b/tests/generic/245
@@ -29,9 +29,11 @@ _cleanup()
 # According to the rename(2) manpage you can get either EEXIST or ENOTEMPTY as an
 # error for trying to rename a non-empty directory, so just catch the error for
 # ENOTMEMPTY and replace it with the EEXIST output so that either result passes
+# Also, mv v9.4+ modified error message when a nonempty destination directory fails
+# to be overwriteen
 _filter_directory_not_empty()
 {
-	sed -e "s,Directory not empty,File exists,g"
+	sed -e "s,Directory not empty,File exists,g" -e "s/.* '\(.*\)':\(.*\)/mv: '\1':\2/"
 }
  
 
diff --git a/tests/generic/245.out b/tests/generic/245.out
index f5b5f182619d..fb7f0f7908e7 100644
--- a/tests/generic/245.out
+++ b/tests/generic/245.out
@@ -1,2 +1,2 @@
 QA output created by 245
-mv: cannot move 'TEST_DIR/test-mv/ab/aa/' to 'TEST_DIR/test-mv/aa': File exists
+mv: 'TEST_DIR/test-mv/aa': File exists
-- 
2.42.0

