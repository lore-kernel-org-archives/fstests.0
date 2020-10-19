Return-Path: <SRS0=fS5H=D2=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1048C433E7
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Oct 2020 12:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 751DC222E7
	for <linux-fstests@archiver.kernel.org>; Mon, 19 Oct 2020 12:58:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="InpBlbi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbgJSM6m (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Mon, 19 Oct 2020 08:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727202AbgJSM6m (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 19 Oct 2020 08:58:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D80C0613CE
        for <fstests@vger.kernel.org>; Mon, 19 Oct 2020 05:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=2eF3RgDPXfIKE58x+r/G6CftrKxYi6fPrtju7kM3TQg=; b=InpBlbi1Vzt8gt7YVQNumgQXz5
        jW/haHK6v/NOIg3zI9Zu1MRfKddkDjjOGoxSfvuJOnmy/cW00r8EzGTQNzdAhnQ9YBl4k0QmN62nP
        ElQ5YryB6xD1sEUkE9vk/l7agMBnfP5EkVtmzYyK3tymX5BB1DlZq+BmXHxeaMVP6FTjTugjnXnhQ
        +PtJ7YWUSm0j8mTRHfyzTvzFKX1jfMRpkzoggSrfghmqnDqBO/CZGXEl5RHWeLtK+8NgkUJJx6sxO
        YPk84u2Dwaou2trK8Txf0gYITGo614slv3l5Y618p2plmj8Wp1IBwcNiWMJzgr8pm8ZxXJ/rxmhWm
        RgayfWnw==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUUkK-000064-5F
        for fstests@vger.kernel.org; Mon, 19 Oct 2020 12:58:40 +0000
Date:   Mon, 19 Oct 2020 13:58:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     fstests@vger.kernel.org
Subject: [PATCH] Fix generic/127 to exit if any subtest fails
Message-ID: <20201019125839.GQ20115@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org


If one of the subtests of generic/127 fails, we proceed with the rest of
the tests, potentially overwriting useful data.  This makes it stop as
soon as any of the subtests fails.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

diff --git a/tests/generic/127 b/tests/generic/127
index dedd8bbf..d4b2cc38 100755
--- a/tests/generic/127
+++ b/tests/generic/127
@@ -90,16 +90,16 @@ _supported_fs generic
 _supported_os Linux
 _require_test
 
-_fsx_lite_nommap
-_fsx_lite_mmap
+_fsx_lite_nommap || exit
+_fsx_lite_mmap || exit
 
-_fsx_std_nommap
-_fsx_std_mmap
+_fsx_std_nommap || exit
+_fsx_std_mmap || exit
 
 #flush cache after write
 FSX_ARGS="-f $FSX_ARGS"
-_fsx_std_nommap
-_fsx_std_mmap
+_fsx_std_nommap || exit
+_fsx_std_mmap || exit
 
 status=0
 _cleanup

