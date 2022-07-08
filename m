Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E81CCA481
	for <linux-fstests@archiver.kernel.org>; Fri,  8 Jul 2022 08:51:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237650AbiGHIvy (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 Jul 2022 04:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237646AbiGHIvu (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Jul 2022 04:51:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69803823BC
        for <fstests@vger.kernel.org>; Fri,  8 Jul 2022 01:51:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 102F921DFA;
        Fri,  8 Jul 2022 08:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657270308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JaYOpiHBsI2/xr9CV4WPU1qjh7pwMJa9O1tNo72CBts=;
        b=cqx63RPT+5giLsA6HK/LmHd9/3uiS5kfCeDBf5FArqD45V9oyRa2m+e8PWsEVC1v0e+m+j
        xfEtucGIoOPTGnj01nUIjtuDi3RrG7jLljBtpx8JGj66CrW5oKH37BwzGTEHiM57sNBmwt
        lyyKZHWeDxLph/TrMisqzJhdzMDuKLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657270308;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JaYOpiHBsI2/xr9CV4WPU1qjh7pwMJa9O1tNo72CBts=;
        b=Q6YEOKfQTmtusqALUvi57zJ6Rh35tdpjKgkPucecLvJ0L0eQdgk3zECcEM3wxBhr+p3pEr
        mcTXwFCOy8CPeFBQ==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D77A92C143;
        Fri,  8 Jul 2022 08:51:47 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org, tytso@mit.edu
Cc:     djwong@kernel.org, zlang@redhat.com,
        David Disseldorp <ddiss@suse.de>
Subject: [PATCH v4 3/5] check: make a few variables local
Date:   Fri,  8 Jul 2022 10:51:40 +0200
Message-Id: <20220708085142.20991-4-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220708085142.20991-1-ddiss@suse.de>
References: <20220708085142.20991-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The variables aren't used outside of function scope. Also convert one
timestamp output to use the helper.

Signed-off-by: David Disseldorp <ddiss@suse.de>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
---
 check | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/check b/check
index dbad6dde..08857f7e 100755
--- a/check
+++ b/check
@@ -179,10 +179,10 @@ get_all_tests()
 # the function from that list.
 trim_test_list()
 {
-	test_list="$*"
+	local test_list="$*"
 
 	rm -f $tmp.grep
-	numsed=0
+	local numsed=0
 	for t in $test_list
 	do
 	    if [ $numsed -gt 100 ]; then
@@ -207,7 +207,7 @@ _wallclock()
 
 _timestamp()
 {
-    now=`date "+%T"`
+    local now=`date "+%T"`
     echo -n " [$now]"
 }
 
@@ -603,7 +603,7 @@ fi
 
 function run_section()
 {
-	local section=$1
+	local section=$1 skip
 
 	OLD_FSTYP=$FSTYP
 	OLD_TEST_FS_MOUNT_OPTS=$TEST_FS_MOUNT_OPTS
@@ -820,7 +820,7 @@ function run_section()
 		rm -f core $seqres.notrun
 
 		start=`_wallclock`
-		$timestamp && echo -n "	["`date "+%T"`"]"
+		$timestamp && _timestamp
 		[ ! -x $seq ] && chmod u+x $seq # ensure we can run it
 		$LOGGER_PROG "run xfstest $seqnum"
 		if [ -w /dev/kmsg ]; then
-- 
2.35.3

