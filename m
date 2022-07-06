Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BFDCCA480
	for <linux-fstests@archiver.kernel.org>; Wed,  6 Jul 2022 11:23:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiGFLXj (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 6 Jul 2022 07:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiGFLXc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 6 Jul 2022 07:23:32 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F74B15710
        for <fstests@vger.kernel.org>; Wed,  6 Jul 2022 04:23:30 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F30E22258D;
        Wed,  6 Jul 2022 11:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657106609; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JaYOpiHBsI2/xr9CV4WPU1qjh7pwMJa9O1tNo72CBts=;
        b=DOgd+HVOH1jbhZkKRHNr6YuYlMKj9pELfBRukY9sVX/rb7/PsNuRdKKoLj8W1U8pFpYgMn
        Qf7E5JaiBiLl0vj5Kr/4EztyF4vvIJb+V23T+d+uUYCIkMY8ZRWpzdvICpZOYj/Vhm4lUi
        RfyWteQaXr9+gvg2R6gxxfMaKHD7ACc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657106609;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JaYOpiHBsI2/xr9CV4WPU1qjh7pwMJa9O1tNo72CBts=;
        b=/Z5PhsWMMkFjXWinfpgWkHRvcjJ0ap7LLUjk5L/GpaPAm8pMFxcYSS46KKvoR18JG1ncd8
        Rql1+ZxpboW0M6CA==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id CDA942C143;
        Wed,  6 Jul 2022 11:23:28 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org, tytso@mit.edu
Cc:     David Disseldorp <ddiss@suse.de>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v3 3/5] check: make a few variables local
Date:   Wed,  6 Jul 2022 13:23:10 +0200
Message-Id: <20220706112312.4349-4-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220706112312.4349-1-ddiss@suse.de>
References: <20220706112312.4349-1-ddiss@suse.de>
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

