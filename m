Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59E8C43217
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbiBIW0O (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235407AbiBIW0M (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00590E00F7E9
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hOINuISp/2GzAwx8dNA3uBj2ENwG6uE189tQS/ddZfg=; b=Ewts+KIpCEQIefm1R3P0rl+WNN
        yg1jSbLR7V5KFMyIONRCfFqGItiUs1wD7x4NObKOt1qglS0CA2LHZr7BpIwj5N8B2M/vjQJntRojk
        nYhgxU8iIJ5Zhde6hdxVwmXEoRPh1+FlnYAlIzeAWtdoohjDAPSo9myLYcZa8WmGq+F7MeXF/fP2f
        gYyPfbiv1myBYrSjneNS/sxQp7zr6adUzd8pn6DRS6jSErjbgec+eFBK+U0uflCpBwO+Uxncuychq
        w+j8hjxXppQIoGVOU9sE1dZtY70rrG+jw+NZwMePB43rldcZFEwH/SqJlYrAfHav3EdzbsDXg6URv
        WtzxE8CA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPi-001q5j-LK; Wed, 09 Feb 2022 22:26:14 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 05/25] Makefile.in: disable unused warning for rpc generated code
Date:   Wed,  9 Feb 2022 14:25:50 -0800
Message-Id: <20220209222610.438470-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

rpcgen cretes C code with unused variables, so just disable
gcc unused variable warning for rpc generated code.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Makefile.in | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index a12affb..da2fc96 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -16,6 +16,7 @@ DESTDIR=/
 CC=@CC@
 CFLAGS=@CFLAGS@ -I. -DVERSION=\"$(VERSION)\" -DDATADIR=\"$(datadir)\"
 CFLAGS+=`pkg-config --cflags libtirpc`
+CFLAGS_RPCGEN=-Wno-unused-variable
 LIBS+=`pkg-config --libs libtirpc`
 EXEEXT=@EXEEXT@
 
@@ -58,7 +59,7 @@ nfs.h: nfs.x
 
 mount_xdr.o: mount_xdr.c mount.h
 	@echo Compiling $@
-	gcc -g $(CFLAGS) -c mount_xdr.c -o $@
+	gcc -g $(CFLAGS) $(CFLAGS_RPCGEN) -c mount_xdr.c -o $@
 
 mount_xdr.c: mount.x
 	@echo Generating $@
@@ -66,7 +67,7 @@ mount_xdr.c: mount.x
 
 mount_client.o: mount_client.c mount.h
 	@echo Compiling $@
-	gcc -g $(CFLAGS) -c mount_client.c -o $@
+	gcc -g $(CFLAGS) $(CFLAGS_RPCGEN) -c mount_client.c -o $@
 
 mount_client.c: mount.x
 	@echo Generating $@
@@ -74,7 +75,7 @@ mount_client.c: mount.x
 
 nfs_xdr.o: nfs_xdr.c nfs.h
 	@echo Compiling $@
-	gcc $(CFLAGS) -g -c nfs_xdr.c -o $@
+	gcc $(CFLAGS) $(CFLAGS_RPCGEN) -g -c nfs_xdr.c -o $@
 
 nfs_xdr.c: nfs.x
 	@echo Generating $@
@@ -82,7 +83,7 @@ nfs_xdr.c: nfs.x
 
 nfs_client.o: nfs_client.c nfs.h
 	@echo Compiling $@
-	gcc -g $(CFLAGS) -c nfs_client.c -o $@
+	gcc -g $(CFLAGS) $(CFLAGS_RPCGEN) -c nfs_client.c -o $@
 
 nfs_client.c: nfs.x
 	@echo Generating $@
-- 
2.34.1

