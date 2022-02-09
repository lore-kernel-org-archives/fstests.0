Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9054CC433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235465AbiBIW0m (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:42 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235466AbiBIW0P (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4684E00E26B
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=STaFeoEGn3B0DfEkUnqi8MP96mUb5G8OJkeNgh9O9Js=; b=DsQ9xspHoNkptkZbN6e2eNu1mN
        lpOzyjc922HqffnudsEPHdvHmZnJe641/kIHm0BHNhEiKa5WoF6Bu4CuQ49/JCin1kdg2Hugr3fth
        RtVgwfiepEJo/oPD0o6IlzytuMQ8fPH1pO6ty0oLua6MN95zwEyeECVIWvwh57D2w+7sFM8JHYdwR
        rVky9NaxW0NDdF6SidQwc/UooaeRvl/157VMmhF2zKFdl6NXevHhM1sSOU1ppZFEW8QSwx2gXtwZR
        wvVNuJ0gvmx42pmSg5jMSNFPGLRrQOfwy5y7iW/dYZiBK1UtOHBo2IakljHb/aWHbfyBrEUxHmjWx
        1nYXtxyA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPj-001q71-Cm; Wed, 09 Feb 2022 22:26:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 22/25] Makefile.in: declare datarootdir
Date:   Wed,  9 Feb 2022 14:26:07 -0800
Message-Id: <20220209222610.438470-23-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

This shuts up a complaint from ./configure

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Makefile.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.in b/Makefile.in
index eb84399..43890d2 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -4,6 +4,7 @@ srcdir=@srcdir@
 VPATH=@srcdir@
 
 prefix=@prefix@
+datarootdir = @datarootdir@
 exec_prefix=@exec_prefix@
 bindir=@bindir@
 mandir=@mandir@
-- 
2.34.1

