Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B664CCA481
	for <linux-fstests@archiver.kernel.org>; Mon, 20 Jun 2022 19:30:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbiFTTaE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 20 Jun 2022 15:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237260AbiFTTaC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 20 Jun 2022 15:30:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C1F1C122
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 12:30:01 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 112531FA14
        for <fstests@vger.kernel.org>; Mon, 20 Jun 2022 19:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1655753400; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VqWOJwJZ7adxjpdQPzHGsky4QKFFGOh8tJDz1L61VaQ=;
        b=j1cBrIWVv6U+VQI7Bt3QK5IhJGD+i9KPXU/a8wIG0Ay/FAmFGfwVWsNEFNiXBB8fa4uz8+
        /Pc2LqoICUNVOWadUXo7xw9hXrP9UWoCUIJpQse0nbUv35jMpjr1BqiPIkPn769XZQXET7
        CY+s1TxSjGQbgyyRNKJ8ZtgVyD4v7mA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1655753400;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VqWOJwJZ7adxjpdQPzHGsky4QKFFGOh8tJDz1L61VaQ=;
        b=ovk+t89zeNjElv1RKjHXyfKA4YyH/4mbreqMSMUzrtSGn8EXkIjkdBoLsiebDUEC8i90Zv
        V5HqeqPEj9A/5WAw==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EAE4B2C143;
        Mon, 20 Jun 2022 19:29:59 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [PATCH 2/6] check: simplify check.time parsing
Date:   Mon, 20 Jun 2022 21:29:30 +0200
Message-Id: <20220620192934.21694-3-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220620192934.21694-1-ddiss@suse.de>
References: <20220620192934.21694-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

There's no need to use grep and awk when the latter can do all that's
needed, including the pretty printing.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 check | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/check b/check
index 42925e09..43c072d2 100755
--- a/check
+++ b/check
@@ -819,13 +819,9 @@ function run_section()
 		try="$try $seqnum"
 		n_try=`expr $n_try + 1`
 
-		# slashes now in names, sed barfs on them so use grep
-		lasttime=`grep -w ^$seqnum $check.time | awk '// {print $2}'`
-		if [ "X$lasttime" != X ]; then
-			echo -n " ${lasttime}s ... "
-		else
-			echo -n "	" # prettier output with timestamps.
-		fi
+		awk 'BEGIN {lasttime="       "} \
+		     $1 == "'$seqnum'" {lasttime=" " $2 "s ... "; exit} \
+		     END {printf "%s", lasttime}' "$check.time"
 		rm -f core $seqres.notrun
 
 		start=`_wallclock`
-- 
2.35.3

