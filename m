Return-Path: <SRS0=UVRB=6W=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D57BEC38A2A
	for <linux-fstests@archiver.kernel.org>; Fri,  8 May 2020 12:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5FF7208DB
	for <linux-fstests@archiver.kernel.org>; Fri,  8 May 2020 12:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lEfg1u7c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgEHMF4 (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 May 2020 08:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726815AbgEHMF4 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 May 2020 08:05:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA30C05BD43
        for <fstests@vger.kernel.org>; Fri,  8 May 2020 05:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9tW0yMLxVUAPKYP0bNtwz6/c1gR+b4tV81kqtP3uDlY=; b=lEfg1u7celp0YvJBGz0sB0k6hv
        YFoWGuGIaHd4eMTz4yTLIYY27zzNA+lP4g6pP43MJjkFrMrXCkYtOfmtWH090+UdIaqFRS7CoOc25
        aOQIVT2vdmFWy0C6xCkanyZgRQVWH8uABQ9IJbQnJvXRLqymXFZ/mV1x+0xlo62ioQNgcRw++2oz/
        RwXCw79Uck3yBTBb5YxP3qRgySZOFriZzBxysdDdkV8BfHaRwdPfVXmw8xTy9YkSIIRZ8Dl8vTSZ+
        dIWc7SF/VjXZYBfBXIide02MDwo5ufxVUweHcyBTW9rZgYotIm3g9BWlZJRL5H8YVU3MdoM+Zgs/H
        R5eVY+sw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX1lL-0000Xj-R9; Fri, 08 May 2020 12:05:55 +0000
Date:   Fri, 8 May 2020 05:05:55 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     fstests <fstests@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: Re: [PATCH 2/2] fstests: add _require_mknod
Message-ID: <20200508120555.GC23649@infradead.org>
References: <07e0ecad-11fd-9bc2-7e49-9470f7511b27@sandeen.net>
 <f7caf338-26ec-8a6c-4a91-4a037c12440e@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7caf338-26ec-8a6c-4a91-4a037c12440e@sandeen.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

> +_require_mknod()
> +{
> +	mknod $TEST_DIR/$tmp.null c 1 3 || _notrun "$FSTYP does not support mknod/mkfifo"

Can you fix this overly long line?  Otherwise this looks good.
