Return-Path: <SRS0=G3mi=5R=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4062CC43331
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Apr 2020 07:31:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F7C220772
	for <linux-fstests@archiver.kernel.org>; Wed,  1 Apr 2020 07:31:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NJcEISTH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbgDAHbG (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 1 Apr 2020 03:31:06 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54622 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731725AbgDAHbG (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 1 Apr 2020 03:31:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BGfWwiq7THcwFsWaRbyYIWjvOFvArJNn4+mcxlixU9M=; b=NJcEISTHqTB1xlU1DbWfhN63lO
        3GO55J3PmzD/wFR8MrQ/PkprBkFtyOwWhgp9GJg1IhnHVZDzdZq43ihsZ8p/OgipDw6ppSC5RjiPV
        9c19j7vGVrkMv/ShJ0+RUKfflTTl1Vh4BF+3G1GCtNNG+2R9USAVbETk9JMqqJA3fuMFHq0TCs+bt
        62OrrOpKU62m7Y4/0DEsdyHWG2rDaN7Cf36gGmdMuCiBy3hWmsWq5kxdp4rwSJ6kSkoFRhrQBYDkX
        Mq7Je8sZlb+ijauLAB1SQVjWmm6MOwC2MxAaEa84UNjsQeSH2aaE7TyvBpnGZI0oNGjj7JbHA2Bt3
        p02lzr6A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJXq6-0002ji-BR; Wed, 01 Apr 2020 07:31:06 +0000
Date:   Wed, 1 Apr 2020 00:31:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/571: skip test on filesystems that don't support
 F_SETLEASE fcntl
Message-ID: <20200401073106.GA32736@infradead.org>
References: <20200331145135.136672-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331145135.136672-1-smayhew@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Tue, Mar 31, 2020 at 10:51:35AM -0400, Scott Mayhew wrote:
> nfs and gfs2 (without localflocks) both use simple_nosetlease() for
> their setlease f_op, so skip this test on those filesystem types.
> 
> Signed-off-by: Scott Mayhew <smayhew@redhat.com>

I think we need to check for an EINVAL return instead of hard coding
file system names.
