Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C551C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbiBIW0R (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:17 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235435AbiBIW0N (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F355E01526E
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=05KVKhCTONq+QzuABBghIGqngXTCXNNeYyKogBeXvOE=; b=tH5TBEakRVPmNePR/FQo0P10my
        5LbwunEIqPDquReSHKY4e3n5Kvu4TYqAaISGBh7X68sV1f3OeUfsB/WVQhs4lUDQrFn40sRj+fnEi
        XsGGGI0SEeu2si1IbBfitTWGnuvjiE15FUEhJgV1mjOzIIZmQdaJOEYk2GewCx5kZXJkpt2QvxVaA
        PnkPLDgqc4Nz6Jo/VyqwTpwQyfUoooMisq5WUifUg/UspxCsAJTYwa1U7aZNuX3SxCJrRXWU/+KEv
        8K0+kywxNOpTkXfygPlsrdLsl7lKt3eZ8EWtYQ+ciXVFruDbvHA0l2uQxjeygBpfLkxtMcM28ILyp
        EqFzKm5w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPi-001q6J-ST; Wed, 09 Feb 2022 22:26:14 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 11/25] nfsio: remove unused status variable
Date:   Wed,  9 Feb 2022 14:25:56 -0800
Message-Id: <20220209222610.438470-12-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 nfsio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/nfsio.c b/nfsio.c
index 1b49bd3..7332066 100644
--- a/nfsio.c
+++ b/nfsio.c
@@ -51,7 +51,6 @@ static void nfs3_cleanup(struct child_struct *child)
 
 static void nfs3_setup(struct child_struct *child)
 {
-	const char *status = "0x00000000";
 	nfsstat3 res;
 
 	child->rate.last_time = timeval_current();
-- 
2.34.1

