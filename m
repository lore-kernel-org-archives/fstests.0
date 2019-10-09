Return-Path: <SRS0=es+p=YC=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FA98C47404
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Oct 2019 07:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 031AA20B7C
	for <linux-fstests@archiver.kernel.org>; Wed,  9 Oct 2019 07:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V8r10ns2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbfJIHAv (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 9 Oct 2019 03:00:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48890 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbfJIHAv (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 9 Oct 2019 03:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TnmKsFBi6TIrY7rzucFuA2QaVRxqfWb2i8bulPsITmo=; b=V8r10ns2Y9bXycIpLsdViWQmb
        wPym93xVGoZc0Coo6YychsyMoOx/M/WqcGntKtcJdcMW4SzaHqVoZ7wafQVJzio3bMZhTPqV9sYu5
        W0naink/9XWbtcoKoMiiC/k8SZCPa3+hDJscr6pdYNFYMkBqqKYtVhmYfskmQRqySmGQuhXRkcC5m
        qJT4pIqgZInol5uqt8RhWK+aFuErU1OA4FKNCimVREB3g2Vrdn5YnkG6YsFCDf13lPdbhPKv8eXE5
        KcFD04+M/vIqulvSNh8mD7HOT46qfTJUFIDf2k62hXG4xSfQ2lJNVXf35B+Q/UzuccEoq5hruNZT2
        QidUWGwww==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iI5xr-0006RE-Ct; Wed, 09 Oct 2019 07:00:51 +0000
Date:   Wed, 9 Oct 2019 00:00:51 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH] generic/001: remove unnecessary backslash
Message-ID: <20191009070051.GA24658@infradead.org>
References: <20191009053434.19369-1-jencce.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009053434.19369-1-jencce.kernel@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Oct 09, 2019 at 01:34:34PM +0800, Murphy Zhou wrote:
> Awk 5.0.1 is complaining about this backslash and causing false alarm
> like this:
>     warning: regexp escape sequence '\#' is not a known regexp operator
> 
> This fix works fine with Awk 3.1.7 , 4.0.2 , 4.2.1 and 5.0.1. This
> backslash is not necessary.
> 
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
