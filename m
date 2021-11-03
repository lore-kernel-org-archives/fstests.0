Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E2ADC433EF
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Nov 2021 18:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F55B61058
	for <linux-fstests@archiver.kernel.org>; Wed,  3 Nov 2021 18:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhKCSVE (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 3 Nov 2021 14:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhKCSVA (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 3 Nov 2021 14:21:00 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF83FC061714
        for <fstests@vger.kernel.org>; Wed,  3 Nov 2021 11:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ljBswrtlsQwLqbcnDLYaUg5x1AcGrsr/mVGsp4CHIzI=; b=k1T6QQogzm5wxCk4ZxJfpg9zU9
        qOevlMhc7VLapBIoQoCRYAqCL2hrLLYRdf2oI0FKeL1q50a59+PMY/57j2YOtVoKtssFZatZ1C55/
        Md9pDlzFkBiwMM+2O3wCIXNHQgusAddZJZ4qQRrlJkXZZBWhxfSaQtmhzlPgHSOzqQt7j/USeV9V1
        AaBsmSerm6SvEIFLgA6hDL3HkreoDJRVm8nEa+BIUCZSgGYiIJ2jbybZf1LHISwKFGOBYflc5XbKP
        Qke1+yDoKS0ZK7BUYpj3fWvSPO7PpI07+kYElsfWtCaZfXnv8J5fJKKVjV2VduxfisWfOc8SmpUza
        njfskz0Q==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1miKq6-006ALv-Rl; Wed, 03 Nov 2021 18:18:22 +0000
Date:   Wed, 3 Nov 2021 11:18:22 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>, fdmanana@gmail.com
Cc:     fstests@vger.kernel.org, Anthony Iliopoulos <ailiopoulos@suse.de>,
        mcgrof@kernel.org
Subject: Re: [PATCH] fsstress: improve error message on check_cwd() error
Message-ID: <YYLSbnyxTTzLlGM/@bombadil.infradead.org>
References: <20211101155559.3988492-1-mcgrof@kernel.org>
 <20211103162434.GX24282@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211103162434.GX24282@magnolia>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Nov 03, 2021 at 09:24:34AM -0700, Darrick J. Wong wrote:
> On Mon, Nov 01, 2021 at 08:55:59AM -0700, Luis Chamberlain wrote:
> > I ran into an error with generic/083 with xfs due to check_cwd() but
> > why it failed is not clear because there are two types of
> > failures:
> > 
> >   o stat64() failed (likely -ENOMEM is my guess)
> >   o the inode actually changed
> > 
> > Throw a bone out to developers so that in case en error does happen
> > they know which rabbit hole to go down on.
> 
> <cough> word choice on those last three words...

Will fix thanks.

> > 
> > Cc: Anthony Iliopoulos <ailiopoulos@suse.de>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  ltp/fsstress.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> > 
> > diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> > index 90ae432e..a576afea 100644
> > --- a/ltp/fsstress.c
> > +++ b/ltp/fsstress.c
> > @@ -9,6 +9,7 @@
> >  #include <sys/uio.h>
> >  #include <stddef.h>
> >  #include <stdbool.h>
> > +#include <string.h>
> >  #include "global.h"
> >  
> >  #ifdef HAVE_BTRFSUTIL_H
> > @@ -943,9 +944,21 @@ check_cwd(void)
> >  {
> >  #ifdef DEBUG
> >  	struct stat64	statbuf;
> > +	int ret;
> > +
> > +	ret = stat64(".", &statbuf);
> > +	if (ret !=0) {
> 
> Nit: space between '!=' and '0'.

OK.

> > +		fprintf(stderr, "fsstress: check_cwd stat64 failed with: %d (%s)\n",
> > +			ret, strerror(ret));
> 
> ret is set to -1 on error, according to the manpage; to get the real
> error you'd have to call strerror(errno) as the last arg, or be lazy
> and:

I don't want to be lazy here as this is a real issue.

> 		perror("fsstress check_cwd stat64");
> 
> > +		goto out;
> > +	}
> >  
> > -	if (stat64(".", &statbuf) == 0 && statbuf.st_ino == top_ino)
> > +	if (statbuf.st_ino == top_ino)
> >  		return;
> > +
> > +	fprintf(stderr, "fsstress: check_cwd statbuf.st_ino (%lu) != top_ino (%lu)\n",
> > +		statbuf.st_ino, top_ino);
> 
> This might want some explicit casting, since this can be defined as
> anything between unsigned long to uint64_t, at least according to the
> glibc headers on my system.

Um, Filipe had suggested something a bit different before. Can you guys
decide and let me know your final preference ? :)

  Luis
