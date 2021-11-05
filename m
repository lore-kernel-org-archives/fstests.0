Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACC8FC433F5
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 16:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92D406137C
	for <linux-fstests@archiver.kernel.org>; Fri,  5 Nov 2021 16:09:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbhKEQMA (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Fri, 5 Nov 2021 12:12:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:49790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232646AbhKEQL5 (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 5 Nov 2021 12:11:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DDE0C6137A;
        Fri,  5 Nov 2021 16:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636128551;
        bh=9ZrY6cv74X/mUSuWsmsLBVOquagym/Wn/GMCZToxYLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tykYMJpjAX7rwYFKDI14wopG2/CqWY7D7X+FoCWEb5q4mCBwbnZv3wcmco/zc5U2u
         zV6h7ojh33WMLTkFMxeAOigelmOvL5Ssmx1WrNuhBgvnWxsORQtPrk7ZCLkkb/OKt/
         PqiGfU+giYVG3lcPJbp1JZQcjTL1xqerxi8Qlf+v6TSrq2wYfdozmsPNEKYdOd7GnB
         bzLyqHxT+2s6p8Jr8dXhDpF3nHsiCF84Pse206EFOj5c22736c7x2zct9yjDyHM6Vx
         guyMyOhdoZOpWN6wkO1kadLaars+98yb1ZnvAOYBhSIFEiWFwS/vffYZ+gFgv1FUhd
         5go56ve7HYo7w==
Date:   Fri, 5 Nov 2021 09:09:10 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     fdmanana@gmail.com, fstests@vger.kernel.org,
        Anthony Iliopoulos <ailiopoulos@suse.de>
Subject: Re: [PATCH] fsstress: improve error message on check_cwd() error
Message-ID: <20211105160910.GB24282@magnolia>
References: <20211101155559.3988492-1-mcgrof@kernel.org>
 <20211103162434.GX24282@magnolia>
 <YYLSbnyxTTzLlGM/@bombadil.infradead.org>
 <YYVWBdHBuj4hQnMy@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YYVWBdHBuj4hQnMy@bombadil.infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Fri, Nov 05, 2021 at 09:04:21AM -0700, Luis Chamberlain wrote:
> On Wed, Nov 03, 2021 at 11:18:22AM -0700, Luis Chamberlain wrote:
> > On Wed, Nov 03, 2021 at 09:24:34AM -0700, Darrick J. Wong wrote:
> > > > -	if (stat64(".", &statbuf) == 0 && statbuf.st_ino == top_ino)
> > > > +	if (statbuf.st_ino == top_ino)
> > > >  		return;
> > > > +
> > > > +	fprintf(stderr, "fsstress: check_cwd statbuf.st_ino (%lu) != top_ino (%lu)\n",
> > > > +		statbuf.st_ino, top_ino);
> > > 
> > > This might want some explicit casting, since this can be defined as
> > > anything between unsigned long to uint64_t, at least according to the
> > > glibc headers on my system.
> > 
> > Um, Filipe had suggested something a bit different before. Can you guys
> > decide and let me know your final preference ? :)
> 
> Any final preference / recommendation?

Use %llu with explicit casts to (unsigned long long) and it should work
fine everywhere.

--D

>   Luis
