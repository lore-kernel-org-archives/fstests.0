Return-Path: <SRS0=UVRB=6W=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088A9C38A2A
	for <linux-fstests@archiver.kernel.org>; Fri,  8 May 2020 12:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8DCF2145D
	for <linux-fstests@archiver.kernel.org>; Fri,  8 May 2020 12:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="f2zwBSE5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEHMEq (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 8 May 2020 08:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726618AbgEHMEq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 May 2020 08:04:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44D38C05BD43
        for <fstests@vger.kernel.org>; Fri,  8 May 2020 05:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O7aD5rRu+fDwR/RlbVWJ45WyVlca+V4WdpR/vKsc6/M=; b=f2zwBSE5YqLd6Hw0KT9ZXKi15f
        bSShqW7OfYKXSr2hosxEr3/EqnQ/vx33PheQmRMQPaQNwbhYWRC9a8vfkhCfexhSOMsTea7ZDj8n3
        BDwZUi/kQmhiOZMFm6c0wj7G8kqXNbRPK/+HrvRIXSxqAqNzMmy2/drGJK4SYaJnm2nAi282SFT44
        tEm/SKW9b6ozwjpSagh1NaLI4853Px/RmdPk3dKFwUs7ha219v1575Vuu3ju5R2XorpdQBwww31HG
        5MCw7H5rTIpIevSNRyiVze7qp3+NMxXo6d6pfB10BASfQ+KJWgI9cgoSjsyWQKm2gO5dyTMvbRstC
        BC0O99tA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jX1kD-0006D1-J0; Fri, 08 May 2020 12:04:45 +0000
Date:   Fri, 8 May 2020 05:04:45 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Eric Sandeen <sandeen@redhat.com>
Cc:     fstests <fstests@vger.kernel.org>
Subject: Re: [PATCH] generic/506: fix _require test, use xfs_io vs chattr
Message-ID: <20200508120445.GA23649@infradead.org>
References: <e29cb8b1-5c4f-0cc4-017f-a2303d31a1f6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e29cb8b1-5c4f-0cc4-017f-a2303d31a1f6@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Thu, May 07, 2020 at 10:25:51PM -0500, Eric Sandeen wrote:
> _require_prjquota doesn't work on xfs unless the scratch device has
> been mounted with project quota, so do that prior to the test.
> 
> older chattr/lsattr don't understand project quotas, so use xfs_io
> instead for compatibility on older systems.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
