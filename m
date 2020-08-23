Return-Path: <SRS0=nV//=CB=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B14DC433DF
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Aug 2020 11:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 264C0206B5
	for <linux-fstests@archiver.kernel.org>; Sun, 23 Aug 2020 11:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="akQBHaPP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgHWLax (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Sun, 23 Aug 2020 07:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726730AbgHWLaw (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 23 Aug 2020 07:30:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB112C061573
        for <fstests@vger.kernel.org>; Sun, 23 Aug 2020 04:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=J0MsDR8fJC7bq4xqvD7F0C6DtfSZAR5tfoHzao8pEwU=; b=akQBHaPP4gIDjf5LpS+OMzeQme
        sOXweI/frsd00sQ0LjYfJwwy3z21NuMP5MxmiXLtZEKzsMN35KbO9fzZvaTlYwjiOF+As2CVzZ8YG
        dnmys7U0DkQ8x6gasB2nv2aeeN2Zpk6jAa6huR2JqnA40kGCziCJ7ghOjvBTYPC/OHxuJtClPcvgJ
        VsdFrdE1WnWM1gEc1dnQFGWknbUEly47sQTqURGsLsuSQrZd6juxBmB2uYQ2zArHdCOX9vPhCShtw
        nKPbJwCrBjPq5sAmpEKzhAvqvSb/U+6nn7cIObLy1EFVg+fHn8cNBYwitLcIGZWjtdCTozWhacHQQ
        cp9Wb4wg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9oD3-0002Rh-U6
        for fstests@vger.kernel.org; Sun, 23 Aug 2020 11:30:50 +0000
Date:   Sun, 23 Aug 2020 12:30:49 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     fstests@vger.kernel.org
Subject: irreproducibility
Message-ID: <20200823113049.GZ17456@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

I have a particular dislike of random tests.  They make it harder to
figure out when a bug has been fixed.  What's worse is when the test
gives you enough information to make it reproducible, and we throw that
away.

I made the following change to find out the random seed that fsx was
using for this test:

+++ b/tests/generic/112
@@ -57,7 +57,7 @@ _do_test()
 
     # This cd and use of -P gets full debug on "$RESULT_DIR" (not TEST_DEV)
     cd $out
-    if ! $here/ltp/fsx $_param -P "$RESULT_DIR" $FSX_AVOID $seq.$_n &>/dev/null
+    if ! $here/ltp/fsx $_param -P "$RESULT_DIR" $FSX_AVOID $seq.$_n &>"$RESULT_DIR"/fsx.stdouterr
     then
        echo "    fsx ($_param) returned $? - see $seq.$_n.full"
        mv "$RESULT_DIR"/$seq.$_n.fsxlog $seqres.$_n.full

I'm sure somebody can do something better than that which would actually
result in it being automatically preserved-on-failure/deleted-on-success.

