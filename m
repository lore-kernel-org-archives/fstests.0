Return-Path: <SRS0=wiEE=5S=vger.kernel.org=fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D090C43331
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Apr 2020 10:39:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17AF2077D
	for <linux-fstests@archiver.kernel.org>; Thu,  2 Apr 2020 10:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tRlueeTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387610AbgDBKjr (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:39:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35262 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728612AbgDBKjr (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 2 Apr 2020 06:39:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SxkIQHzO2anAX3JErHqPN7lYE36Wh90qt/ippgZ9qm0=; b=tRlueeTmVFiZR3wkBWhlktpJSa
        abpZa4S1e81F4j+6IO282lkJxrzj+8618EcU2gY7yrbFTSWQNQFmQXz9ZUTiAKCKP2AcW7ZW/spCo
        1KdT2QSzU+b+Uz8Gh8/G6+Cwu/AgJSJ5PqZr8e1gt3aM35HoeyDYxb+SjQ7a2JuQHtOos5V+I3KxU
        8q+5GKRvha9dX8qTWFuJi9VsnS435Q6YP/E2OwI+lTqu0oxPvhPYgQEmDXehrQ1/blR8B24RejPGi
        elzgmJlfvBMbztAV737CquYBqJQybu7lee3UrAuXzLBbs67FRJpzB683WvPLavui1XzwDnM5xyE0j
        vYUp6iqQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJxGE-0002gE-Rj; Thu, 02 Apr 2020 10:39:46 +0000
Date:   Thu, 2 Apr 2020 03:39:46 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     fstests@vger.kernel.org
Subject: Re: [PATCH v2] generic/571: skip test on filesystems that don't
 support F_SETLEASE fcntl
Message-ID: <20200402103946.GA9028@infradead.org>
References: <20200401172659.299308-1-smayhew@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200401172659.299308-1-smayhew@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: fstests-owner@vger.kernel.org
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Apr 01, 2020 at 01:26:59PM -0400, Scott Mayhew wrote:
> Add an option to the locktest program to check for fcntl setlease
> support, and skip the generic/571 test on filesystems where the check
> returns EINVAL.

The changes to locktest.c seem to contain some whitespace damange.

Otherwie this looks sensible to me.
