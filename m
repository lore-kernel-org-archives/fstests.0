Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50B50C433FE
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiBIW00 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:26 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235463AbiBIW0O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91162E01567E
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description;
        bh=h+B3rpYzk+n6bh9FCtTdLrJgfMLxdOLFar2iy99NtGw=; b=K82QV16t2JidQEdOdwDDG08qKX
        gaAf/JUCjjPTNuNgpwAUhGJ7/Op4sFZ2d+GnrF0vyRBl/vTKHn96MxRTKeFAgqhl5tBHGgiepDg4t
        dMuPjgIVvZ5zt2WxJ66pnXjwo9gllnUgUA2/Yxe9CGSt/0SBfqM01W6+GzBS3dZi0xlk7igl30a6Y
        FNdxc3lw2k5gpU1+Jx5ZXuyBcpPmfnGhDtVWGntExwDSrrSQEPKA0WvQygREQ+q4H8aPdKV68zBTE
        g9NDBrax6lkgbXbmq35kpsFPbqg1Ig4RQayH+TsJjVgtoLFtvzIUDFaZ8iD4S57DhVC+yguDfHoXT
        583uaTVg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPj-001q6n-6y; Wed, 09 Feb 2022 22:26:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 19/25] Makefile.in:
Date:   Wed,  9 Feb 2022 14:26:04 -0800
Message-Id: <20220209222610.438470-20-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209222610.438470-1-mcgrof@kernel.org>
References: <20220209222610.438470-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

mount_client.c:19:17: warning: cast between incompatible function types
from ‘bool_t (*)(void)’ {aka ‘int (*)(void)’} to ‘bool_t (*)(XDR *,
...)’ {aka ‘int (*)(struct __rpc_xdr *, ...)’} [-Wcast-function-type]
   19 |                 (xdrproc_t) xdr_void, (caddr_t) argp,
      |                 ^

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Makefile.in | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile.in b/Makefile.in
index ef414a5..f8e1f58 100644
--- a/Makefile.in
+++ b/Makefile.in
@@ -19,6 +19,7 @@ CFLAGS+=`pkg-config --cflags libtirpc`
 # Allows comments to be used for fallthrough
 CFLAGS+=-Wimplicit-fallthrough=2
 CFLAGS_RPCGEN=-Wno-unused-variable
+CFLAGS_RPCGEN+=-Wno-cast-function-type
 LIBS+=`pkg-config --libs libtirpc`
 EXEEXT=@EXEEXT@
 
-- 
2.34.1

