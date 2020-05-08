Return-Path: <SRS0=UVRB=6W=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8886C38A2A
	for <linux-fstests@archiver.kernel.org>; Fri,  8 May 2020 15:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A11C921655
	for <linux-fstests@archiver.kernel.org>; Fri,  8 May 2020 15:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QkXjlA7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEHPDR (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 May 2020 11:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbgEHPDR (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 May 2020 11:03:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2870AC061A0C
        for <fstests@vger.kernel.org>; Fri,  8 May 2020 08:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FS18PO3CAwX/wgx+WOzz2Mj0xX7TGhO0DkdRAB5/puY=; b=QkXjlA7uWW6LqAGKRnYoP8Cqwe
        HWdafGSV45mj2lT0lZxXLncQ928oqxaTX7sASvp7rv2mtX5PGaciv8NajO8CUmZwfk5QU5qDU8MO4
        Fywiu4H1WKUUWNtjisFLH3cmvtAIDsOjWCDQWI+gdbpz5Y7qp1GwFFXMwquk/tVz0+TUsujHm6lyk
        ytN3in8lTD88iRTpicdKFeCEa/weztM4khywK8PlTFdCvcMcapNuTelajFMFBbaewhMUM9tQR+p7m
        AeWDTeoZoxk9pTTAiYlOMPBRe33BLe4+1sgBJOWeP/JeCn2V3Fe4MswDYdV1NY8i4bSeGiZ7FsV7J
        ZPCAU2OQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX4Wy-0005mH-Ra; Fri, 08 May 2020 15:03:16 +0000
Date:   Fri, 8 May 2020 08:03:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     fstests <fstests@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2 V2] fstests: add _require_mknod
Message-ID: <20200508150316.GA22122@infradead.org>
References: <07e0ecad-11fd-9bc2-7e49-9470f7511b27@sandeen.net>
 <f7caf338-26ec-8a6c-4a91-4a037c12440e@sandeen.net>
 <42fcddeb-7274-bf41-3475-16eae0f78e92@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42fcddeb-7274-bf41-3475-16eae0f78e92@sandeen.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, May 08, 2020 at 09:23:42AM -0500, Eric Sandeen wrote:
> Add a _require_mknod test so that filesystems with no ->mknod
> operation will _notrun instead of fail.
> 
> Signed-off-by: Eric Sandeen <sandeen@sandeen.net>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
