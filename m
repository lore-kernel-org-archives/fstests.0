Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD85AC4332F
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbiBIW0P (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:15 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbiBIW0N (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:13 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DF8E015252
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bLKfzp5m9dJE4zTm24eebH5oSOMkSHFVXdxE564CNK0=; b=aP5ADrOG4/MR1PiW7TTZkv9a5d
        Ab6UyYGNayDRlrAR5w6DnLA7/YURQBHeB0Ns6KEDkd9EFUqDnfzKqK6DNxMfPD20NjlQqEnp5Tx9V
        wX/glmpOsIyd35zgwGja3RuWTzel9rtYhpxU8nK0hG7fEVKrhdI/M5vGT+ecU+LQfpUmtbv9gNlXz
        z0qVReOwAswYUaPbE0HUxosjDFwK+nlsVRdhNV2hh1YLe487EEq8po3Los427CLZFyzBl2hP5n93k
        /JibKiLcSoibhc+OhZvKbFfhT8VwHyF13I3KKTJb0QGFmfHnyuFYUB167hlmLAWQ+8eoMmjhhNEIQ
        bVclAyYw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPi-001q67-QN; Wed, 09 Feb 2022 22:26:14 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 09/25] snprintf: specify safe fallthrough on switches
Date:   Wed,  9 Feb 2022 14:25:54 -0800
Message-Id: <20220209222610.438470-10-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

gcc -Wall will complain when we fallthrough on a switch
but don't mean it. Fortunately we can follow the Linux kernel
strategy to use -Wimplicit-fallthrough=2 and allow comments
to supress this to clarify this was intended.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Makefile.in | 4 +++-
 snprintf.c  | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/Makefile.in b/Makefile.in
index da2fc96..ef414a5 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -16,6 +16,8 @@ DESTDIR=/
 CC=@CC@
 CFLAGS=@CFLAGS@ -I. -DVERSION=\"$(VERSION)\" -DDATADIR=\"$(datadir)\"
 CFLAGS+=`pkg-config --cflags libtirpc`
+# Allows comments to be used for fallthrough
+CFLAGS+=-Wimplicit-fallthrough=2
 CFLAGS_RPCGEN=-Wno-unused-variable
 LIBS+=`pkg-config --libs libtirpc`
 EXEEXT=@EXEEXT@
@@ -28,7 +30,7 @@ SRV_OBJS = util.o tbench_srv.o socklib.o
 all: dbench doc
 
 dbench: $(DB_OBJS)
-	$(CC) -o $@ $(DB_OBJS) $(LIBS)
+	$(CC) $(CFLAGS) -o $@ $(DB_OBJS) $(LIBS)
 
 tbench_srv: $(SRV_OBJS)
 	$(CC) -o $@ $(SRV_OBJS) $(LIBS)
diff --git a/snprintf.c b/snprintf.c
index adfd3c4..9cfc20e 100644
--- a/snprintf.c
+++ b/snprintf.c
@@ -317,6 +317,7 @@ static size_t dopr(char *buffer, size_t maxlen, const char *format, va_list args
 				break;
 			case 'X':
 				flags |= DP_F_UP;
+				/* fallthrough */
 			case 'x':
 				flags |= DP_F_UNSIGNED;
 				if (cflags == DP_C_SHORT)
@@ -339,6 +340,7 @@ static size_t dopr(char *buffer, size_t maxlen, const char *format, va_list args
 				break;
 			case 'E':
 				flags |= DP_F_UP;
+				/* fallthrough */
 			case 'e':
 				if (cflags == DP_C_LDOUBLE)
 					fvalue = va_arg (args, LDOUBLE);
@@ -348,6 +350,7 @@ static size_t dopr(char *buffer, size_t maxlen, const char *format, va_list args
 				break;
 			case 'G':
 				flags |= DP_F_UP;
+				/* fallthrough */
 			case 'g':
 				if (cflags == DP_C_LDOUBLE)
 					fvalue = va_arg (args, LDOUBLE);
-- 
2.34.1

