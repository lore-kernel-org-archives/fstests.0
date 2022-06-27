Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAA88C43334
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Jun 2022 22:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238348AbiF0WX1 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Jun 2022 18:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240245AbiF0WX0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Jun 2022 18:23:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC02211817
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 15:23:19 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 99A8D1F8D4;
        Mon, 27 Jun 2022 22:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1656368598; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VfqcS6LThFPa8HxrmKrMrPU9veeDsBi9O5Y9CEre11U=;
        b=Rjx+c/vEJutNo83tgv4ZnRzIAuVvzePl6MzHKOIIu2Ol6diJ7qn4653h7vqPkIxP444w2R
        VPsjC+rNlcwvd9djZYzr1WvyRKzPKlGk7lAlKaT5o7UA19LNasjkR5Xchu7MECJHYJjAdx
        2sBzcAkdP+E/adyyPbCu3U1ffvpXgnw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1656368598;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VfqcS6LThFPa8HxrmKrMrPU9veeDsBi9O5Y9CEre11U=;
        b=3wHYGAvk0LnXaMMqNeItRuDxxiGrBrKSemmwdGdFokjh9gFafoOCsbHlB6lpoImcxfKYxf
        wXIICd79244FAOAg==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 79D9E2C143;
        Mon, 27 Jun 2022 22:23:18 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org, tytso@mit.edu
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH v2 3/6] check: make a few variables local
Date:   Tue, 28 Jun 2022 00:22:53 +0200
Message-Id: <20220627222256.14175-4-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220627222256.14175-1-ddiss@suse.de>
References: <20220627222256.14175-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The variables aren't used outside of function scope. Also convert one
timestamp output to use the helper.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 check | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/check b/check
index 9d60df45..f973dd28 100755
--- a/check
+++ b/check
@@ -176,10 +176,10 @@ get_all_tests()
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
@@ -204,7 +204,7 @@ _wallclock()
 
 _timestamp()
 {
-    now=`date "+%T"`
+    local now=`date "+%T"`
     echo -n " [$now]"
 }
 
@@ -600,7 +600,7 @@ fi
 
 function run_section()
 {
-	local section=$1
+	local section=$1 skip
 
 	OLD_FSTYP=$FSTYP
 	OLD_TEST_FS_MOUNT_OPTS=$TEST_FS_MOUNT_OPTS
@@ -817,7 +817,7 @@ function run_section()
 		rm -f core $seqres.notrun
 
 		start=`_wallclock`
-		$timestamp && echo -n "	["`date "+%T"`"]"
+		$timestamp && _timestamp
 		[ ! -x $seq ] && chmod u+x $seq # ensure we can run it
 		$LOGGER_PROG "run xfstest $seqnum"
 		if [ -w /dev/kmsg ]; then
-- 
2.35.3

