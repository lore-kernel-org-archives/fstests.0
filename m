Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88865C433F5
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Feb 2022 22:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbiBIW0b (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Feb 2022 17:26:31 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235451AbiBIW0O (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Feb 2022 17:26:14 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 861E1E015677
        for <fstests@vger.kernel.org>; Wed,  9 Feb 2022 14:26:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=auLxMu1bP0Nw8+3Xj2t+yJ45AoADWkRsADb4+RxnZGg=; b=qhJFbGqfZycFOo5s/wQhhUumtz
        iIBF+Cyn6gw1abZHLpHqBHNXIo6/M2ZwZd4pp61rZZ+bKXnp7k9HVaWG2p6nMFFc45eE5fUFUaypI
        jR2d8g4SQ2yO8PIhUxXvCBFLa+bFIU82zUB6TFW2t5o1rBJApJtersbbgKk5Ajc7/ZIu2e5+qUVyC
        ZX1+zKGquPWa208cUTexmZN2T636HGEaJ1Z3ts4k7ArDR128ZIK5BuuVs4a6ZFuuEbU9CfwT8v7XC
        XON5JnL/+BNZer6BPq8upUetaEup9bbEsDX/Xbumac1kHgKPbMpZDqegaSUdPS7OdHb62JWAZbkLB
        fKaBv7PQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHvPj-001q6j-5W; Wed, 09 Feb 2022 22:26:15 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     raymond.barbiero.dev@gmail.com
Cc:     fstests@vger.kernel.org, jack@suse.cz, mgorman@techsingularity.net,
        dave@stgolabs.net, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 18/25] libnfs.c: fix sign conflict compile warning
Date:   Wed,  9 Feb 2022 14:26:03 -0800
Message-Id: <20220209222610.438470-19-mcgrof@kernel.org>
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
 libnfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libnfs.c b/libnfs.c
index 50f914e..82e88f9 100644
--- a/libnfs.c
+++ b/libnfs.c
@@ -853,10 +853,10 @@ nfsstat3 nfsio_read(struct nfsio *nfsio, const char *name, char *buf, uint64_t o
 		goto finished;
 	}
 
-	if (offset >= size && size > 0) {
+	if (offset >= (uint64_t) size && (uint64_t) size > 0) {
 		offset = offset % size;
  	}
-	if (offset+len >= size) {
+	if (offset+len >= (uint64_t) size) {
 		offset = 0;
 	}
 
-- 
2.34.1

