Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C37CCA47B
	for <linux-fstests@archiver.kernel.org>; Mon, 27 Jun 2022 22:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbiF0WX3 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 27 Jun 2022 18:23:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242570AbiF0WX1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 27 Jun 2022 18:23:27 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6621111C1B
        for <fstests@vger.kernel.org>; Mon, 27 Jun 2022 15:23:20 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 1BBF621D83;
        Mon, 27 Jun 2022 22:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1656368599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B85EDi2aXL1RHfDW1dQjU2CVx4999GUkiMWlbHNImC8=;
        b=aFIvtfcw0dbRNBO7YQDDRoNWwXCFWchOS8R0Y/kYfdrvFcRgDYOw25e10bXSuSy5Czs1xs
        fuvhBtk1Lnfw7gAGxuodVmubNqrfmIFN5sg1c/1OtCJyOKj3ds3X0ixMVVl4dSITtMtPY0
        jA4tdNxH5n7awJO/Xi632aQsMKzOSsk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1656368599;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B85EDi2aXL1RHfDW1dQjU2CVx4999GUkiMWlbHNImC8=;
        b=bSiZA5rl1nnZvB9S5rxQevdQsmAgmH+o5D/tRhFtBpOkmqJ2mak0WpKJeMa+NoESDVTMrD
        rUxMfKuH533EINCw==
Received: from echidna.suse.de (ddiss.udp.ovpn2.nue.suse.de [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EFE062C146;
        Mon, 27 Jun 2022 22:23:18 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org, tytso@mit.edu
Cc:     David Disseldorp <ddiss@suse.de>
Subject: [RFC PATCH v2 6/6] check: stash full/dmesg/out.bad files on rerun
Date:   Tue, 28 Jun 2022 00:22:56 +0200
Message-Id: <20220627222256.14175-7-ddiss@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220627222256.14175-1-ddiss@suse.de>
References: <20220627222256.14175-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

These files would otherwise be overwritten.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 check | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/check b/check
index 726c83d9..baf336da 100755
--- a/check
+++ b/check
@@ -570,8 +570,17 @@ _stash_test_status() {
 				      "$report_msg"
 	fi
 
-	# only stash result for first failure (triggering loop)
-	((loop_num > 1)) && return
+	if ((loop_num > 0)); then
+		# retain files which would be overwritten in subsequent reruns
+		for i in "${REPORT_DIR}/${test_seq}.full" \
+			 "${REPORT_DIR}/${test_seq}.dmesg" \
+			 "${REPORT_DIR}/${test_seq}.out.bad"; do
+			[ -f "$i" ] || continue
+			cp "$i" "${i}.rerun$((loop_num - 1))"
+		done
+		# only stash result for first failure (triggering loop)
+		((loop_num != 1)) && return
+	fi
 
 	case "$test_status" in
 	fail)
-- 
2.35.3

