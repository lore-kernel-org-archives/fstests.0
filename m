Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C799CC433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 16:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A57C86112E
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 16:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbhKEQHC (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Nov 2021 12:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbhKEQHB (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 5 Nov 2021 12:07:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56579C061714
        for <fstests@vger.kernel.org>; Fri,  5 Nov 2021 09:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=msMIpr2b0ZApiPrNKJGyfnSHuSCVwQg7NS3RErEu/U0=; b=UCCE2ZBjf/F/if7L9dGeAqyRSB
        CKUCu70ySTA1x/s9/ZP0+wegn9WlUeMOkKWl8B7gkOrC3hIKEYTsNFNUv5zPTYzKN/HxeHvo8+6am
        4WfDO0W7Bk/8XVDU6MUUgx27z+JyznwUqW3Qq4gWiBK+EmyO6DpY5S8FrVhsAUyDvGZ8Hve+UiW1E
        kvDjDs1WlC4DWNLfb0fKE0qnW5IC/lOJaSwln1vYLLXZrQ9DmaWo7V6rg5m0VpHaojHNWmO/w7FRz
        QvZFwt8FOy2HauuLk1y8cwB8D0k9aja0JwzE5+KpvfKkh0+QxKzt5DuGMFI2AxlL8irbdTS/e0qMZ
        hW1HIrbw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mj1hV-00BtaF-Cq; Fri, 05 Nov 2021 16:04:21 +0000
Date:   Fri, 5 Nov 2021 09:04:21 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>, fdmanana@gmail.com
Cc:     fstests@vger.kernel.org, Anthony Iliopoulos <ailiopoulos@suse.de>
Subject: Re: [PATCH] fsstress: improve error message on check_cwd() error
Message-ID: <YYVWBdHBuj4hQnMy@bombadil.infradead.org>
References: <20211101155559.3988492-1-mcgrof@kernel.org>
 <20211103162434.GX24282@magnolia>
 <YYLSbnyxTTzLlGM/@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYLSbnyxTTzLlGM/@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Nov 03, 2021 at 11:18:22AM -0700, Luis Chamberlain wrote:
> On Wed, Nov 03, 2021 at 09:24:34AM -0700, Darrick J. Wong wrote:
> > > -	if (stat64(".", &statbuf) == 0 && statbuf.st_ino == top_ino)
> > > +	if (statbuf.st_ino == top_ino)
> > >  		return;
> > > +
> > > +	fprintf(stderr, "fsstress: check_cwd statbuf.st_ino (%lu) != top_ino (%lu)\n",
> > > +		statbuf.st_ino, top_ino);
> > 
> > This might want some explicit casting, since this can be defined as
> > anything between unsigned long to uint64_t, at least according to the
> > glibc headers on my system.
> 
> Um, Filipe had suggested something a bit different before. Can you guys
> decide and let me know your final preference ? :)

Any final preference / recommendation?

  Luis
