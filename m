Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4A2C433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiBIW0u (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235498AbiBIW0Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D6AE01116F
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=ZTgnqvtdkvlTfSC9yQnBs/hw5PlvXbpJWCFkbdyEgE8=; b=c6WKwhhZSU2l3m+V50xm8IyG+b
        cmwb/AMZHQteAug4nECQW96nN+BcHW+8PdV9GcWnAHrWyJcjBxnvvhEp21BJx+qWWA3Vo4eS70yvG
        gZACBAzUKlh93wEZLciPBxL4iNXAbB6LhCdWaDJhW0FmhYc3yLpaBOSY6EIY1n8DS++4+1tJ0mW7S
        GWGx92PjNeHgP/97Xx1SISHggtdwYO6yhqxYiafamOQWbh1yVqe0mSrY5BdLyEZ0qarmEHqDwSDFh
        6FF/szEhxXskyJMMJylxAemEkAopzvLho7hs4x+gsW9OGfsyGbJOs1xuQyEb0LCRXlDuM6M8iIetJ
        QhSMKNow==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPj-001q7U-IL; Wed, 09 Feb 2022 22:26:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 25/25] smb: fix compilation and disable warning on deprecated-declarations
Date:   Wed,  9 Feb 2022 14:26:10 -0800
Message-Id: <20220209222610.438470-26-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

smb.c hasn't been updated in a while, so disable
warning on deprecated-declarations for now. An smb
eager beaver can go fix this.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Makefile.in | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Makefile.in b/Makefile.in
index 43890d2..a1b6645 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -21,6 +21,8 @@ CFLAGS+=`pkg-config --cflags libtirpc`
 CFLAGS+=-Wimplicit-fallthrough=2
 CFLAGS_RPCGEN=-Wno-unused-variable
 CFLAGS_RPCGEN+=-Wno-cast-function-type
+SMBCFLAGS=-Wno-deprecated-declarations
+SMBCFLAGS+=`pkg-config --cflags smbclient`
 LIBS+=`pkg-config --libs libtirpc`
 EXEEXT=@EXEEXT@
 
@@ -68,6 +70,10 @@ libnfs.o: libnfs.c libnfs.h mount.h nfs.h
 	$(NQ) '   CC    ' $@
 	$(Q)gcc -g $(CFLAGS) -c libnfs.c -o $@
 
+smb.o: smb.c dbench.h
+	$(NQ) '   CC    ' $@
+	$(Q)$(CC) -c $(CPPFLAGS) $(CFLAGS) $(SMBCFLAGS) -o $@ $<
+
 mount.h: mount.x
 	$(NQ) ' RPCGEN  ' $@
 	$(Q)rpcgen -h mount.x > mount.h
-- 
2.34.1

