Return-Path: <SRS0=Jsw6=3G=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7083C33CB1
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jan 2020 08:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8872220748
	for <linux-fstests@archiver.kernel.org>; Fri, 17 Jan 2020 08:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aoEJG+Xz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729011AbgAQIpS (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 17 Jan 2020 03:45:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53884 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgAQIpS (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 17 Jan 2020 03:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=mzNzZY3+jK7ztV4XFXvgjTnKIY79B8kmU2QPwV4/RLE=; b=aoEJG+Xztsycz9RMZAMrgJqIh
        cFcuov1oD9u0olE0rJur2V29zIKHu+D6oQNTxqgnWGdcLNtNV70fiTNRzJwY7oGrmLkFEOGLhkPF7
        GTeZw1V2gfYdOyQyNOmOgo5FMgSEzu0zs4jIGWC2+GCdKccb5OIJy4iw6ztfx42G2TfaJ/8wICLa+
        yQj2t4B3qPdY1OJWtIxKtoGNTd0dUOTBxkj3Xz4spuqXMQle89N3bA/i9XsJrRDb7x2h6j57qnxGs
        Ps7yZq5QcVKjOKFSex2CoIOWmG7Vw97Zwv7kAs804fjL4MD584uxsCPem1JREOkfZ9QDkOpHHh+nZ
        mU7mS6ZCA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1isNFl-0001NT-CY; Fri, 17 Jan 2020 08:45:17 +0000
Date:   Fri, 17 Jan 2020 00:45:17 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic: require fibmap for testcases using filefrag
Message-ID: <20200117084517.GA24082@infradead.org>
References: <20200117083824.32450-1-jencce.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117083824.32450-1-jencce.kernel@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Jan 17, 2020 at 04:38:24PM +0800, Murphy Zhou wrote:
> To mute false alarm on NFS, which is reporting FIBMAP unsupported.

How do these tests end up using FIBMAP?  We really should not use FIBMAP
in any tests except those exercising FIBMAP itself.

