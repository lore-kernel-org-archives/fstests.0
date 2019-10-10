Return-Path: <SRS0=mik5=YD=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F2E0C4360C
	for <linux-fstests@archiver.kernel.org>; Thu, 10 Oct 2019 06:49:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2617221920
	for <linux-fstests@archiver.kernel.org>; Thu, 10 Oct 2019 06:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JiG/Li5b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfJJGtg (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 10 Oct 2019 02:49:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46234 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727207AbfJJGtg (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 10 Oct 2019 02:49:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=xKWuIym4JxqmokYQU5+3M41thCo8iJpJuuKy/e5KtI8=; b=JiG/Li5bQE1C7qwZbS2uxb5W4
        adT4DJQ4WtEv8nRM/KHCpnDfM1WsA//UoQjxD8w72pwmtFQLqYbULHt4Pqp1T5QI69gqard2EzVHg
        u8oE+m2iHBtlztMenfF9oqBuVN/ofsNhGZCdGIz3QwSKz75WHYfJbePv5YfvHOm3gCIwqnLdJqgFc
        tYHQ04P3hiRInMThSoFDyLKVE2lXanloZ0ZKlxH/AWcd8NBIz49E9pBEqCD5w4i9G+VcxOmkcMsyZ
        6uQ2GPA0TtubdTro8edr5Xe8Hzf7MX2p5G/xJgTu8LMO3FeZyQ5DL0mnZokr9IfMByRYQkCzXINHy
        MQtsZosxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iISGV-0007xq-Tt; Thu, 10 Oct 2019 06:49:35 +0000
Date:   Wed, 9 Oct 2019 23:49:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Eryu Guan <guaneryu@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic: check reflink multiple mmap write
Message-ID: <20191010064935.GA28292@infradead.org>
References: <20191010041440.GH13097@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191010041440.GH13097@magnolia>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 09, 2019 at 09:14:40PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Add a test to make sure that we can handle multiple memory mappings to a
> physical storage extent shared by multiple files, and that we can handle
> the copy on write operation without error.
> 
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>

Thanks, this looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

To further try fund DAX corner cases we should also try different
offsets for the different files, or different offsets in the same
file referring to the same blocks.  I can take a stab at that once
I find some time.
