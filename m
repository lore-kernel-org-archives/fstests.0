Return-Path: <fstests-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3437DCDB482
	for <linux-fstests@archiver.kernel.org>; Thu, 19 Oct 2023 01:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbjJSByK (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 18 Oct 2023 21:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjJSByJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 18 Oct 2023 21:54:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87AAAEA
        for <fstests@vger.kernel.org>; Wed, 18 Oct 2023 18:54:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1EE061F890;
        Thu, 19 Oct 2023 01:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1697680445; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=fYEhNPDJSJuMa0Irvw5Tz5Ff8Tji+nH6mi1Eq4Y3USA=;
        b=XY4mciedsRPQqLOw2FOuGeDyFH0EfWbzPrcvkcYOLasjUIwdtNRPd6xo3u339JSsK9mTl1
        /IQ4YGw2WSUXiLXXn4oVyVwV4edtMAXeZ8hn4DcD+s8F0oXPeAmXRNfAKG3ltXWbI7iYom
        gJzmvvxGTbKJbIC6PdRUKqnsbTnOmcA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 540861391B;
        Thu, 19 Oct 2023 01:54:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id r5QhADuMMGUBCAAAMHmgww
        (envelope-from <glass.su@suse.com>); Thu, 19 Oct 2023 01:54:02 +0000
From:   Su Yue <glass.su@suse.com>
To:     fstests@vger.kernel.org
Cc:     l@damenly.org, zlang@redhat.com, Su Yue <glass.su@suse.com>
Subject: [PATCH v2] generic/245: Filter mv error message
Date:   Thu, 19 Oct 2023 09:53:56 +0800
Message-ID: <20231019015356.23648-1-glass.su@suse.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spamd-Result: default: False [-2.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[4];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
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

Filter out and replace mv error messages to fix the test.

Signed-off-by: Su Yue <glass.su@suse.com>
---
v2:
  change sed regrex expression as Zorro suggested.
---
 tests/generic/245     | 5 ++++-
 tests/generic/245.out | 2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/generic/245 b/tests/generic/245
index e2d5c926e906..8e0f22366db3 100755
--- a/tests/generic/245
+++ b/tests/generic/245
@@ -29,9 +29,12 @@ _cleanup()
 # According to the rename(2) manpage you can get either EEXIST or ENOTEMPTY as an
 # error for trying to rename a non-empty directory, so just catch the error for
 # ENOTMEMPTY and replace it with the EEXIST output so that either result passes
+# Also, mv v9.4+ modified error message when a nonempty destination directory fails
+# to be overwriteen
 _filter_directory_not_empty()
 {
-	sed -e "s,Directory not empty,File exists,g"
+	sed -e "s,Directory not empty,File exists,g" \
+		-e "s,cannot move .* to \(.*\):\(.*\),cannot overwrite \1:\2,g"
 }
  
 
diff --git a/tests/generic/245.out b/tests/generic/245.out
index f5b5f182619d..19b598e4a175 100644
--- a/tests/generic/245.out
+++ b/tests/generic/245.out
@@ -1,2 +1,2 @@
 QA output created by 245
-mv: cannot move 'TEST_DIR/test-mv/ab/aa/' to 'TEST_DIR/test-mv/aa': File exists
+mv: cannot overwrite 'TEST_DIR/test-mv/aa': File exists
-- 
2.41.0

