Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA1DC433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235400AbiBIW0W (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:22 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235447AbiBIW0O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 596A1E015253
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Reply-To:Content-ID:Content-Description;
        bh=4oE+QHox4pUwVU7xwXwkYDcvIdCGgs+HWwG08MQbq4o=; b=rDQkhtHfX5Om3hKvUZMN0DosTN
        wkRzKgR5CCMjLbMZ4FH6FpWDT70eWfTW9G8nvARqjnKWWRwC96O8A5NLdbYQMVzjUUHCOPYFKKITX
        o8khOz+327hrS1MEHdIOilgeW5YCma6QxI+FkMd/zuKX/V3glhgrZdzDfPW9cY/mXjn2M3oH2TFAO
        Ah6bb/xXhP2C7v5OdKkQDWd5AFhO4yZKcLz7kgaFm1IyB2Jailnv/Kf2P/w5vP9isjxDEwc8nWYye
        5+6oAuqKE4gb/7AfK35DnwThgVAANPV8bwV/FaPfz54FufowbpMn4Chk2+9SOCDYCussLd46qx13E
        tghfUYiw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPi-001q6T-Vs; Wed, 09 Feb 2022 22:26:14 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 14/25] dbench.h: use bits/types.h instead of defining uint32
Date:   Wed,  9 Feb 2022 14:25:59 -0800
Message-Id: <20220209222610.438470-15-mcgrof@kernel.org>
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

This fixes this compilation warning:

Compiling nfsio.o
gcc -g -g -O2 -Wall -W -I. -DVERSION=\"4.00\"
-DDATADIR=\"/usr/local/share\" `pkg-config --cflags libtirpc`
-Wimplicit-fallthrough=2 -c nfsio.c -o nfsio.o
In file included from nfsio.c:20:
dbench.h:105:16: error: two or more data types in declaration specifiers
  105 | #define uint32 unsigned int
      |                ^~~~~~~~
nfs.h:54:16: note: in expansion of macro ‘uint32’
   54 | typedef u_long uint32;
      |                ^~~~~~
dbench.h:105:25: error: two or more data types in declaration specifiers
  105 | #define uint32 unsigned int
      |                         ^~~
nfs.h:54:16: note: in expansion of macro ‘uint32’
   54 | typedef u_long uint32;
      |                ^~~~~~
In file included from nfsio.c:21:
nfs.h:54:1: warning: useless type name in empty declaration
   54 | typedef u_long uint32;
      | ^~~~~~~

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 dbench.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/dbench.h b/dbench.h
index 1fecd1a..7e628b2 100644
--- a/dbench.h
+++ b/dbench.h
@@ -102,7 +102,8 @@
 #define BOOL int
 #define True 1
 #define False 0
-#define uint32 unsigned
+
+#include <bits/types.h>
 
 struct op {
 	unsigned count;
-- 
2.34.1

