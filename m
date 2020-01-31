Return-Path: <SRS0=v13d=3U=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEDF2C2D0DB
	for <linux-fstests@archiver.kernel.org>; Fri, 31 Jan 2020 16:46:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA5B20663
	for <linux-fstests@archiver.kernel.org>; Fri, 31 Jan 2020 16:46:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RO07ZfWj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726443AbgAaQqT (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 31 Jan 2020 11:46:19 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:35550 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgAaQqT (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 31 Jan 2020 11:46:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=tl9irItpo51U2mmVnL9+0hrQ3qNvsHJBP+jaaGgw5xo=; b=RO07ZfWjpYL2qJTORVQ8d6O/k
        HiIhnoMbl3h77zXAVjlaqZ3zP8Xzv0X2H8nwDJ8XB5jggAyUEOs37J5Bcazlwm8WanlTeBz9Ype/9
        6VMYnjgRmrWihN52npwfDHiunnJ8olqYG5HehhDZ8vgflJc0EChnw6PbRVymG2pZGFe37KZF60jFX
        gd47DrCKXEpuD7aXp3cSeHj0qqR3IRnBXP4zH8xRa5Ifo9dDe8G2//HXkpffMGOTso3njgi107VfG
        9SBCD0Gyl/Ti9SDaCS8pGBWZRMbL668+va4+ZHBalSYSxzAl/xFAKjRUVuIoOS7vV/V/ioH8QuPYR
        TD9OxNRHg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ixZQx-0004v7-3F; Fri, 31 Jan 2020 16:46:19 +0000
Date:   Fri, 31 Jan 2020 08:46:19 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     jlayton@kernel.org
Cc:     fstests@vger.kernel.org
Subject: Re: xfstests generic/484
Message-ID: <20200131164619.GA13005@infradead.org>
References: <20200115150059.GA21201@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115150059.GA21201@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

Jeff can you help out with generic/484?

On Wed, Jan 15, 2020 at 07:00:59AM -0800, Christoph Hellwig wrote:
> Hi Jeff,
> 
> do you remember the story behind xfstests generic/484?  That test has
> been failing for me ever since it was added and on every file system
> (which is not surprising given that the functionality isn't file system
> specific).  Are we expected to fix the issue in the lock ode?  Or did we
> give up on it?
---end quoted text---
