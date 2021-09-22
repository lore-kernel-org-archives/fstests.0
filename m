Return-Path: <fstests-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0C5C433EF
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Sep 2021 20:10:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF44E611C4
	for <linux-fstests@archiver.kernel.org>; Wed, 22 Sep 2021 20:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237575AbhIVULb (ORCPT
        <rfc822;linux-fstests@archiver.kernel.org>);
        Wed, 22 Sep 2021 16:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237784AbhIVULQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 22 Sep 2021 16:11:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2005EC0611FA
        for <fstests@vger.kernel.org>; Wed, 22 Sep 2021 13:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wjg0c008hIEYp3kuW728GJ5k4Yl8aMM/8+o1xtmwmus=; b=qt+A6/K58NV/uUOGGqVTjNvPOO
        n5NRXjwOeCbQjpYYl7BXs2AUq3kt9kCF0K4BrjEzrRf/dsvUW262+SqhzOR53ilUx4cqnvGb0/9Wk
        F5BozukCMlRsUcbz48GwAe5+4AWbAwDi/rS4ChIZWJhH0lOVor0rOljWUcNUz2+OV+/JpV7sOSMjL
        etgC1Kj+jIckB/qYFIS5sOAwx88vbxaXCqcRtrAdM88YISjIY5FsAUU7GNHgOLSB9Np5ozvcsG/Nr
        N15SBqq36pe/p9nhIaJXDntbHWZut8E8uta89ng1evpWVhCIniQirqr/tF4TRaqP4w1By2lq00z/M
        P7ygF/ng==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mT8Wc-009ZEJ-It; Wed, 22 Sep 2021 20:07:26 +0000
Date:   Wed, 22 Sep 2021 13:07:26 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Filipe Manana <fdmanana@gmail.com>
Cc:     fstests <fstests@vger.kernel.org>,
        Anthony Iliopoulos <ailiopoulos@suse.de>
Subject: Re: [PATCH] fsstress: improve error message on check_cwd() error
Message-ID: <YUuM/h7zGaAsPggl@bombadil.infradead.org>
References: <20210921175035.1286786-1-mcgrof@kernel.org>
 <CAL3q7H4hvwDcio3qqTbQj0BK9GbEeGhfbx2F32WBpB3D5nKL8Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H4hvwDcio3qqTbQj0BK9GbEeGhfbx2F32WBpB3D5nKL8Q@mail.gmail.com>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <fstests.vger.kernel.org>
X-Mailing-List: fstests@vger.kernel.org

On Wed, Sep 22, 2021 at 11:15:08AM +0100, Filipe Manana wrote:
> On Tue, Sep 21, 2021 at 6:51 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
> >
> > I ran into an error with generic/083 with xfs due to check_cwd() but
> > why it failed is not clear because there are two types of
> > failures:
> >
> >   o stat64() failed (likely -ENOMEM is my guess)
> >   o the inode actually changed
> >
> > Thow a bone out to developers so that in case en error does happen
> > they know which rabbit hole to go down on.
> >
> > Cc: Anthony Iliopoulos <ailiopoulos@suse.de>
> > Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> > ---
> >  ltp/fsstress.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> > index b4ddf5e2..d2f09901 100644
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
> >         struct stat64   statbuf;
> > +       int ret;
> > +
> > +       ret = stat64(".", &statbuf);
> > +       if (ret !=0) {
> > +               fprintf(stderr, "fsstress: check_cwd stat64 failed with: %d (%s)\n",
> > +                       ret, strerror(ret));
> 
> The error is not in 'ret' but instead in 'errno', so it should print
> errno and strerror(errno).

Good call will fix.

> > +               goto out;
> > +       }
> >
> > -       if (stat64(".", &statbuf) == 0 && statbuf.st_ino == top_ino)
> > +       if (statbuf.st_ino == top_ino)
> >                 return;
> > +
> > +       fprintf(stderr, "fsstress: check_cwd statbuf.st_ino (%ld) != top_ino (%ld)\n",
> > +               (long)statbuf.st_ino, (long)top_ino);
> 
> ino_t is guaranteed to be an unsigned integer, and can be either 64 or
> 32 bits wide [1].
> Casting to unsigned 64 bits would be better imo.

There are other similar mi-uses in the code, should I fix those to
then?

  Luis
 
