Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 495E3C433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbiBIW0l (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:41 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235487AbiBIW0P (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:15 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF1CDF28A66
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=QyTx/VIaPV6czS2cPMhCe5m2MVAhKE2XPTH8dCt+vnM=; b=EAJepXTf7n5xdiu4EhTdxEw/iN
        EpVevsLlyjl0n46maBe7rSex9TMOoOt4YbqXqbSueTdWaKytReU2LCo/eS2zqO7ePYOP/fqWg0iZw
        DYzVgaZnAI6ZqZ5DzuJymyK1auENI2OhRv4xeJFGH6HtobK0tNfz4gj2vIpcpf12bV5d5c1IEXs39
        rNju8whJ6RBKb3oMfWBXGxhureyXF1t5qbUGvl0T6Kqo6KjQA8Awiv79wUv++tnKo0exUzY+pQVMw
        h+HUTURRHzq8p8vjKxsdLkeBbVWn9/FR9iGSiej7dnq76bpDvGwFAYHfomnzhNnuSlcZMp5dsYvNQ
        f1P1lNNw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPj-001q6x-Af; Wed, 09 Feb 2022 22:26:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 21/25] Makefile.in: modernize build output with V=1 or V=0
Date:   Wed,  9 Feb 2022 14:26:06 -0800
Message-Id: <20220209222610.438470-22-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Allow the build to be chatty or not. By default we're quiet.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Makefile.in | 120 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 70 insertions(+), 50 deletions(-)

diff --git a/Makefile.in b/Makefile.in
index f8e1f58..eb84399 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -28,99 +28,119 @@ LIBNFS_OBJ = libnfs.o mount_client.o nfs_client.o mount_xdr.o nfs_xdr.o
 DB_OBJS = fileio.o util.o dbench.o child.o system.o snprintf.o sockio.o nfsio.o libnfs.a socklib.o @LINUXSCSI@ iscsi.o libiscsi.o @SMBO@
 SRV_OBJS = util.o tbench_srv.o socklib.o
 
+ifeq ($(V),1)
+	export Q=
+	export NQ=true
+else
+	export Q=@
+	export NQ=@echo
+endif
+
 all: dbench doc
 
+%.o: %.c dbench.h
+	$(NQ) '   CC    ' $@
+	$(Q)$(CC) -c $(CPPFLAGS) $(CFLAGS) -o $@ $<
+
 dbench: $(DB_OBJS)
-	$(CC) $(CFLAGS) -o $@ $(DB_OBJS) $(LIBS)
+	$(NQ) '   LD    ' $@
+	$(Q)$(CC) $(CFLAGS) -o $@ $(DB_OBJS) $(LIBS)
 
 tbench_srv: $(SRV_OBJS)
-	$(CC) -o $@ $(SRV_OBJS) $(LIBS)
+	$(NQ) '   CC    ' $@
+	$(Q)$(CC) -o $@ $(SRV_OBJS) $(LIBS)
 
 tbench: dbench
-	ln -sf dbench tbench
+	$(NQ) '   LN    ' $@
+	$(Q)ln -sf dbench tbench
 
 libnfs.a: $(LIBNFS_OBJ) 
-	@echo Creating library $@
-	ar r libnfs.a $(LIBNFS_OBJ) 
-	ranlib libnfs.a
+	$(NQ) '   AR    ' $@
+	$(Q)ar r libnfs.a $(LIBNFS_OBJ)
+	$(Q)ranlib libnfs.a
 
 nfsio.o: nfsio.c mount.h nfs.h
-	@echo Compiling $@
-	gcc -g $(CFLAGS) -c nfsio.c -o $@
+	$(NQ) '   CC    ' $@
+	$(Q)gcc -g $(CFLAGS) -c nfsio.c -o $@
 
 libnfs.o: libnfs.c libnfs.h mount.h nfs.h
-	@echo Compiling $@
-	gcc -g $(CFLAGS) -c libnfs.c -o $@
+	$(NQ) '   CC    ' $@
+	$(Q)gcc -g $(CFLAGS) -c libnfs.c -o $@
 
 mount.h: mount.x
-	@echo Generating $@
-	rpcgen -h mount.x > mount.h
+	$(NQ) ' RPCGEN  ' $@
+	$(Q)rpcgen -h mount.x > mount.h
 
 nfs.h: nfs.x
-	@echo Generating $@
-	rpcgen -h nfs.x > nfs.h
+	$(NQ) '   CC    ' $@
+	$(Q)rpcgen -h nfs.x > nfs.h
 
 mount_xdr.o: mount_xdr.c mount.h
-	@echo Compiling $@
-	gcc -g $(CFLAGS) $(CFLAGS_RPCGEN) -c mount_xdr.c -o $@
+	$(NQ) '   CC    ' $@
+	$(Q)gcc -g $(CFLAGS) $(CFLAGS_RPCGEN) -c mount_xdr.c -o $@
 
 mount_xdr.c: mount.x
-	@echo Generating $@
-	rpcgen -c mount.x > mount_xdr.c
+	$(NQ) ' RPCGEN  ' $@
+	$(Q)rpcgen -c mount.x > mount_xdr.c
 
 mount_client.o: mount_client.c mount.h
-	@echo Compiling $@
-	gcc -g $(CFLAGS) $(CFLAGS_RPCGEN) -c mount_client.c -o $@
+	$(NQ) '   CC    ' $@
+	$(Q)gcc -g $(CFLAGS) $(CFLAGS_RPCGEN) -c mount_client.c -o $@
 
 mount_client.c: mount.x
-	@echo Generating $@
-	rpcgen -l mount.x > mount_client.c
+	$(NQ) ' RPCGEN  ' $@
+	$(Q)rpcgen -l mount.x > mount_client.c
 
 nfs_xdr.o: nfs_xdr.c nfs.h
-	@echo Compiling $@
-	gcc $(CFLAGS) $(CFLAGS_RPCGEN) -g -c nfs_xdr.c -o $@
+	$(NQ) '   CC    ' $@
+	$(Q)gcc $(CFLAGS) $(CFLAGS_RPCGEN) -g -c nfs_xdr.c -o $@
 
 nfs_xdr.c: nfs.x
-	@echo Generating $@
-	rpcgen -c nfs.x > nfs_xdr.c
+	$(NQ) ' RPCGEN  ' $@
+	$(Q)rpcgen -c nfs.x > nfs_xdr.c
 
 nfs_client.o: nfs_client.c nfs.h
-	@echo Compiling $@
-	gcc -g $(CFLAGS) $(CFLAGS_RPCGEN) -c nfs_client.c -o $@
+	$(NQ) '   CC    ' $@
+	$(Q)gcc -g $(CFLAGS) $(CFLAGS_RPCGEN) -c nfs_client.c -o $@
 
 nfs_client.c: nfs.x
-	@echo Generating $@
-	rpcgen -l nfs.x > nfs_client.c
+	$(NQ) ' RPCGEN  ' $@
+	$(Q)rpcgen -l nfs.x > nfs_client.c
 
 doc/dbench.1.html: doc/dbench.1.xml
-	-test -z "$(XSLTPROC)" || $(XSLTPROC) -o $@ http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl $<
+	$(NQ) 'GEN-HTML ' $@
+	$(Q)-test -z "$(XSLTPROC)" || $(XSLTPROC) -o $@ http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl $<
 
 doc/dbench.1: doc/dbench.1.xml
-	-test -z "$(XSLTPROC)" || $(XSLTPROC) -o $@ http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl $<
+	$(NQ) 'GEN-MAN  ' $@
+	$(Q)-test -z "$(XSLTPROC)" || $(XSLTPROC) -o $@ http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl $<
 
 doc: doc/dbench.1 doc/dbench.1.html
 
 # Careful here: don't install client.txt over itself.
 install: all
-	mkdir -p $(DESTDIR)$(bindir)
-	mkdir -p $(DESTDIR)$(docdir)/loadfiles
-	mkdir -p $(DESTDIR)$(mandir)/man1
-	${INSTALLCMD} dbench $(DESTDIR)$(bindir)
-	${INSTALLCMD} loadfiles/client.txt $(DESTDIR)$(docdir)/loadfiles
-	${INSTALLCMD} loadfiles/nfs.txt $(DESTDIR)$(docdir)/loadfiles
-	${INSTALLCMD} loadfiles/nfs_2.txt $(DESTDIR)$(docdir)/loadfiles
-	${INSTALLCMD} loadfiles/smb.txt $(DESTDIR)$(docdir)/loadfiles
-	${INSTALLCMD} loadfiles/smb_1.txt $(DESTDIR)$(docdir)/loadfiles
-	${INSTALLCMD} loadfiles/smb_2.txt $(DESTDIR)$(docdir)/loadfiles
-	${INSTALLCMD} loadfiles/smb_3.txt $(DESTDIR)$(docdir)/loadfiles
-	${INSTALLCMD} loadfiles/iscsi.txt $(DESTDIR)$(docdir)/loadfiles
-	${INSTALLCMD} loadfiles/scsi.txt $(DESTDIR)$(docdir)/loadfiles
-	${INSTALLCMD} -m644 dbench.1 $(DESTDIR)$(mandir)/man1
+	$(NQ) ' INSTALL ' $@
+	$(Q)mkdir -p $(DESTDIR)$(bindir)
+	$(Q)mkdir -p $(DESTDIR)$(docdir)/loadfiles
+	$(Q)(mkdir -p $(DESTDIR)$(mandir)/man1
+	$(Q)${INSTALLCMD} dbench $(DESTDIR)$(bindir)
+	$(Q)${INSTALLCMD} loadfiles/client.txt $(DESTDIR)$(docdir)/loadfiles
+	$(Q)${INSTALLCMD} loadfiles/nfs.txt $(DESTDIR)$(docdir)/loadfiles
+	$(Q)${INSTALLCMD} loadfiles/nfs_2.txt $(DESTDIR)$(docdir)/loadfiles
+	$(Q)${INSTALLCMD} loadfiles/smb.txt $(DESTDIR)$(docdir)/loadfiles
+	$(Q)${INSTALLCMD} loadfiles/smb_1.txt $(DESTDIR)$(docdir)/loadfiles
+	$(Q)${INSTALLCMD} loadfiles/smb_2.txt $(DESTDIR)$(docdir)/loadfiles
+	$(Q)${INSTALLCMD} loadfiles/smb_3.txt $(DESTDIR)$(docdir)/loadfiles
+	$(Q)${INSTALLCMD} loadfiles/iscsi.txt $(DESTDIR)$(docdir)/loadfiles
+	$(Q)${INSTALLCMD} loadfiles/scsi.txt $(DESTDIR)$(docdir)/loadfiles
+	$(Q)${INSTALLCMD} -m644 dbench.1 $(DESTDIR)$(mandir)/man1
 
 clean:
-	rm -f *.[ao] *~ dbench tbench_srv
-	rm -f mount.h mount_xdr.c mount_client.c
-	rm -f nfs.h nfs_xdr.c nfs_client.c 
+	$(NQ) '  CLEAN  ' $@
+	$(Q)rm -f *.[ao] *~ dbench tbench_srv
+	$(Q)rm -f mount.h mount_xdr.c mount_client.c
+	$(Q)rm -f nfs.h nfs_xdr.c nfs_client.c
 
 proto:
-	./mkproto.pl *.c > proto.h
+	$(NQ) ' MKPROTO ' $@
+	$(Q)./mkproto.pl *.c > proto.h
-- 
2.34.1

