Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1A5C433FE
	for <linux-fstests@archiver.kernel.org>; Tue, 12 Apr 2022 11:57:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345518AbiDLL7m (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 12 Apr 2022 07:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353083AbiDLL6i (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 12 Apr 2022 07:58:38 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3729066601
        for <fstests@vger.kernel.org>; Tue, 12 Apr 2022 03:50:08 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E69651F858;
        Tue, 12 Apr 2022 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1649760606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v5NrLNv+PO8jeQMvNcXueE3aQseWF20SQby3JfeN71w=;
        b=QXLdMyPF514bYEjnOjLO/8I3vuG8lVkbn9r0L3zZoP2JMAAxvdAfPkNNsIcKjbR1Nvg2aA
        5Y3WHK53wpkRRLvq+AbfaCGVfp8IphcL/HG04cy4JIz1shETux7OyjBkihtvZ52fviZFQ0
        x7x9++pTWHzrVdC5FjWRmbNqr6rraBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1649760606;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v5NrLNv+PO8jeQMvNcXueE3aQseWF20SQby3JfeN71w=;
        b=GEGTISX8+L4j+IqZxO4Carui09URQtrda47ZRJ5AsFy8dJujf+3JUhGxfM2uSGlV13VFMp
        KQgjY9YftSF440AA==
Received: from echidna.suse.de (unknown [10.163.47.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C8EB8A3BA3;
        Tue, 12 Apr 2022 10:50:06 +0000 (UTC)
From:   David Disseldorp <ddiss@suse.de>
To:     fstests@vger.kernel.org
Cc:     dchinner@redhat.com, David Disseldorp <ddiss@suse.de>
Subject: [PATCH v2 3/3] generic/020: fix unaligned MAX_ATTRVAL_SIZE output filter
Date:   Tue, 12 Apr 2022 12:50:01 +0200
Message-Id: <20220412105001.14325-4-ddiss@suse.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220412105001.14325-1-ddiss@suse.de>
References: <20220412105001.14325-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The current attr -g "$max_attrval_name" output filter is broken if
MAX_ATTRVAL_SIZE isn't 16-byte aligned, due to od's duplicate
suppression behaviour.
Fix it by having od only dump one byte per line.

Signed-off-by: David Disseldorp <ddiss@suse.de>
---
 tests/generic/020     | 2 +-
 tests/generic/020.out | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/generic/020 b/tests/generic/020
index 34861401..d1913953 100755
--- a/tests/generic/020
+++ b/tests/generic/020
@@ -134,7 +134,7 @@ dd if=/dev/zero bs=1 count=$MAX_ATTRVAL_SIZE 2>/dev/null \
     | _attr -s "$max_attrval_name" $testfile >/dev/null
 
 OCTAL_SIZE=`echo "obase=8; $MAX_ATTRVAL_SIZE" | bc`
-_attr -q -g "$max_attrval_name" $testfile | od -t x1 \
+_attr -q -g "$max_attrval_name" $testfile | od -w1 -t x1 \
     | sed -e "s/^0*$OCTAL_SIZE$/ATTRSIZE/"
 _attr -r "$max_attrval_name" $testfile >/dev/null
 
diff --git a/tests/generic/020.out b/tests/generic/020.out
index 7e3e65bd..0dc5e09f 100644
--- a/tests/generic/020.out
+++ b/tests/generic/020.out
@@ -47,7 +47,7 @@ user.snrub="fish2\012"
 user.snrub="fish2\012"
 
 *** really long value
-0000000 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+0000000 00
 *
 ATTRSIZE
 *** set/get/remove really long names (expect failure)
-- 
2.34.1

