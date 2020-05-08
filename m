Return-Path: <SRS0=UVRB=6W=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10375C47254
	for <linux-fstests@archiver.kernel.org>; Fri,  8 May 2020 12:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4D8B2145D
	for <linux-fstests@archiver.kernel.org>; Fri,  8 May 2020 12:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hzERjF7b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgEHMFM (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 May 2020 08:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbgEHMFM (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 May 2020 08:05:12 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAF0C05BD43
        for <fstests@vger.kernel.org>; Fri,  8 May 2020 05:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bA7+9SoTXYD6aGPvj7riKJRB6ZlTqGcOOR4oVFwieWI=; b=hzERjF7b+DwJJ2CruhE0ZBDX2B
        Gh4ytB9BDHgq9hRAX9PqH5v9+xygkxfxWCKqkE2zXotLacHLj2L6nye3/noLBat4P0j1raCwWSzJW
        3Qomuj/I3Zu4TdoTQD6Y13eYcl+q+q2tC4w7mT85VLuMX+Ji7Wg7V8qveRP0PLVsaJuoGV/nts8D/
        gd91VbuALN45GIYN2C7/GL5YvgB4O2VoGgiDKCEz3jYZaFhfDwCI+GOmIc7djKt/FGyUyO6GMcwZH
        XldwNEYHbSWEUVQl7Xf7qSD8HcPRDnyJ5hNpPou8jGIpH4kn/kPtLXzfKAdZZYyDeAR6WhVs+NI0U
        tD5dNQYw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX1kd-0000EY-Ou; Fri, 08 May 2020 12:05:11 +0000
Date:   Fri, 8 May 2020 05:05:11 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Sandeen <sandeen@sandeen.net>
Cc:     fstests <fstests@vger.kernel.org>,
        Namjae Jeon <namjae.jeon@samsung.com>
Subject: Re: [PATCH 1/2] fstests: update sparse file & negative timestamp
 tests for exfat
Message-ID: <20200508120511.GB23649@infradead.org>
References: <07e0ecad-11fd-9bc2-7e49-9470f7511b27@sandeen.net>
 <931ccb70-0b72-6532-d859-e355264d299a@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <931ccb70-0b72-6532-d859-e355264d299a@sandeen.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, May 06, 2020 at 05:16:50PM -0500, Eric Sandeen wrote:
> exfat cannot do sparse files or negative timestamps, so exclude
> tests which require these.
> 
> Signed-off-by: Eric Sandeen <sandeen@sandeen.net>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
