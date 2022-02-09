Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89A1C433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbiBIW0M (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:12 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbiBIW0M (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2BB6DF28A66
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=qgeQ8OV6cpFyXS4amF4UaDDJE7fJnHAdSUmm34ZpM+s=; b=3EOHDS19VZ1tf+Sigs2J1JIF9Z
        ov0i8VG9rbmHcP2yT/n9XAKoeCcuLzmwsEWD3/DhFOhBONlgu+Aak3fyw3zC1ID0GoVVIWm1Ul0yz
        uOF+xN/ss6FYMnHHX6mXmpI1ZHPiaSdBazC0E88NUG6FB2XjaXhCFoc/QirO9XJHB8As6RWECaazr
        rWhcSKX+MmWqdTT/pUrprq49VYlkJoCsBrr5GC7DeX8Uo3cJmyWjziXjJOFEMbC8PKXAmWj+ZRYAa
        ADHxC3JITnE/Q0JSd0mciQ70LAavlYj35lWuWTn75cChE1I7c+uiOwUGRiIlq/VQ26jbLm6h/zUNe
        mFGl653w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPi-001q5f-JO; Wed, 09 Feb 2022 22:26:14 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 03/25] dbench: remove unused double t value
Date:   Wed,  9 Feb 2022 14:25:48 -0800
Message-Id: <20220209222610.438470-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

The value is not used. Nuke it.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 dbench.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/dbench.c b/dbench.c
index c8f2fee..ca29373 100644
--- a/dbench.c
+++ b/dbench.c
@@ -496,7 +496,7 @@ static void process_opts(int argc, const char **argv)
  int main(int argc, const char *argv[])
 {
 	double total_bytes = 0;
-	double t, latency=0;
+	double latency=0;
 	int i;
 
 	setlinebuf(stdout);
@@ -568,8 +568,6 @@ static void process_opts(int argc, const char **argv)
 		latency = MAX(latency, children[i].worst_latency);
 	}
 
-	t = timeval_elapsed2(&tv_start, &tv_end);
-
 	if (options.machine_readable) {
 		printf(";%g;%d;%d;%.03f;\n", 
 			       throughput,
-- 
2.34.1

