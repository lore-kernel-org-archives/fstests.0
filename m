Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55586C07E96
	for <linux-fstests@archiver.kernel.org>; Tue,  6 Jul 2021 20:15:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 317F261C48
	for <linux-fstests@archiver.kernel.org>; Tue,  6 Jul 2021 20:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhGFURp (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Tue, 6 Jul 2021 16:17:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbhGFURp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 6 Jul 2021 16:17:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA84C061574
        for <fstests@vger.kernel.org>; Tue,  6 Jul 2021 13:15:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=bzYVYeKQrfIVoz7OvHn4erUHaOPiFZdXJvaCSBch5C0=; b=Agx8ZepjtFsnHojzt6fwkT4cN2
        DC45tXeWDa46nagfTgLkT2nU9m6zOPUqVn2+sZmjKt/PXu7+qK9fHPp/i8d5SVcY9BGQoiRYsspqz
        QTwvxSJoZFrmMSmwaszxY0CGJDt3iwKC76fgApT9MHERHvaw4tbhXBY8ppgF8gHIT8qUSgOxyUiqp
        OfNX5yUu4zynmt8m3Abdv3/pE2qz+nT3AjX11eDk64FsI01uzWIjM99lb3UpZsdIUljptMmtOkTaI
        7AxZemvnCp+wLAmYefUyL5ziBKRHSRARh13tv/OCEwaoJFNDyemAq57XItvfrWCIf9oKo3uAFdjoy
        C55fTy2Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1m0rSw-00BjnU-Em; Tue, 06 Jul 2021 20:14:50 +0000
Date:   Tue, 6 Jul 2021 21:14:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Eryu Guan <guaneryu@gmail.com>, fstests@vger.kernel.org,
        "Darrick J. Wong" <djwong@kernel.org>
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH] Test seeks from LLONG_MIN
Message-ID: <YOS5trAuJN+ho+Is@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

We don't currently test seeking from LLONG_MIN, which apparently can
produce an UBSAN warning, although I've been unable to reproduce that.
In any case, it's a good corner case to test and straightforward to add.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index cb036f7b..76587b7f 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -395,8 +395,12 @@ static int test18(int fd, int testnum)
 	int ret = 0;
 
 	/* file size doesn't matter in this test, set to 0 */
+	ftruncate(fd, 0);
+
 	ret += do_lseek(testnum, 1, fd, 0, SEEK_HOLE, -1, -1);
 	ret += do_lseek(testnum, 2, fd, 0, SEEK_DATA, -1, -1);
+	ret += do_lseek(testnum, 3, fd, 0, SEEK_HOLE, LLONG_MIN, -1);
+	ret += do_lseek(testnum, 4, fd, 0, SEEK_DATA, LLONG_MIN, -1);
 
 	return ret;
 }

