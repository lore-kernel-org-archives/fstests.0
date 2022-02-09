Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E6EC4167B
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 02:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241119AbiBICjY (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 8 Feb 2022 21:39:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244156AbiBICCb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 8 Feb 2022 21:02:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5185CC061348
        for <fstests@vger.kernel.org>; Tue,  8 Feb 2022 18:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=kJJu4cddWOeVRKP4W6qa3slSsXKVbv6Lgxw+HCtJntw=; b=4imxJY/hNcgq6whpBahUEMSzrP
        4B3rrkh3ltLqzZwCEaHsl/Fz3TW2KmBZiMjfjfKwUATJTkckNnirVNvFIcMhYOU9OrKoJwps2ddBN
        B2cjo/gw80/Ymkej9gFr097l0oRzZ+d8RUuMW7rKEwbr+STLb6O2PqJwebFQPHx0SE+qRJw7F1+NG
        Br2Iq47HlGN6C07XUEqP1X9A0oYHdtdnT2ZO8rA3Q6JHPd2JVB6G4iCZsTr/RIJ5pbemKHQw/rDwM
        fbPQJJjX/9oeLez1mfp1QM6bQxZPN0JlHdWiAY+NEpZK26eNp2/QM7wG1b1faP54A5MBqNoLYZttf
        q82y99DQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHcJO-00Fxxf-5P; Wed, 09 Feb 2022 02:02:26 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 3/4] Makefile: address deprecation of /usr/include/rpc
Date:   Tue,  8 Feb 2022 18:02:22 -0800
Message-Id: <20220209020223.3805346-4-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209020223.3805346-1-mcgrof@kernel.org>
References: <20220209020223.3805346-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

/usr/include/rpc is now removed from glibc. Software
which uses that should use libtirpc-devel, and to make
it work we should use pkg-config against that library.

Fix making dbench compile again for rpc stuff.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Makefile.in | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index 00af80e..a12affb 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -15,6 +15,8 @@ LIBS=@LIBS@ -lpopt -lz @LIBSMBCLIENT@ @LIBISCSI@
 DESTDIR=/
 CC=@CC@
 CFLAGS=@CFLAGS@ -I. -DVERSION=\"$(VERSION)\" -DDATADIR=\"$(datadir)\"
+CFLAGS+=`pkg-config --cflags libtirpc`
+LIBS+=`pkg-config --libs libtirpc`
 EXEEXT=@EXEEXT@
 
 LIBNFS_OBJ = libnfs.o mount_client.o nfs_client.o mount_xdr.o nfs_xdr.o
@@ -40,11 +42,11 @@ libnfs.a: $(LIBNFS_OBJ)
 
 nfsio.o: nfsio.c mount.h nfs.h
 	@echo Compiling $@
-	gcc -g -c nfsio.c -o $@
+	gcc -g $(CFLAGS) -c nfsio.c -o $@
 
 libnfs.o: libnfs.c libnfs.h mount.h nfs.h
 	@echo Compiling $@
-	gcc -g -c libnfs.c -o $@
+	gcc -g $(CFLAGS) -c libnfs.c -o $@
 
 mount.h: mount.x
 	@echo Generating $@
@@ -56,7 +58,7 @@ nfs.h: nfs.x
 
 mount_xdr.o: mount_xdr.c mount.h
 	@echo Compiling $@
-	gcc -g -c mount_xdr.c -o $@
+	gcc -g $(CFLAGS) -c mount_xdr.c -o $@
 
 mount_xdr.c: mount.x
 	@echo Generating $@
@@ -64,7 +66,7 @@ mount_xdr.c: mount.x
 
 mount_client.o: mount_client.c mount.h
 	@echo Compiling $@
-	gcc -g -c mount_client.c -o $@
+	gcc -g $(CFLAGS) -c mount_client.c -o $@
 
 mount_client.c: mount.x
 	@echo Generating $@
@@ -72,7 +74,7 @@ mount_client.c: mount.x
 
 nfs_xdr.o: nfs_xdr.c nfs.h
 	@echo Compiling $@
-	gcc -g -c nfs_xdr.c -o $@
+	gcc $(CFLAGS) -g -c nfs_xdr.c -o $@
 
 nfs_xdr.c: nfs.x
 	@echo Generating $@
@@ -80,7 +82,7 @@ nfs_xdr.c: nfs.x
 
 nfs_client.o: nfs_client.c nfs.h
 	@echo Compiling $@
-	gcc -g -c nfs_client.c -o $@
+	gcc -g $(CFLAGS) -c nfs_client.c -o $@
 
 nfs_client.c: nfs.x
 	@echo Generating $@
-- 
2.34.1

