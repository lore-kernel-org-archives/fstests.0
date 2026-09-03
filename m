Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89D51B808
	for <fstests@vger.kernel.org>; Thu,  3 Sep 2026 05:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788413656; cv=none; b=bJC3ZTsVh1PTeYi0s3eZJguQKzkynHUfcYQyH3yhxR/uDrgOlFSUYB7deW3sqJJt/faV/OdH0i8iwbh6RJQR8WTsTK2H2qqIC9KJp4kSuZ+8O3c8NF4LoJc7YEq4NhOxVaSrB3V0UcAKi9nb1ILpqtEynRKt/iL1NQ0HXTw+44A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788413656; c=relaxed/simple;
	bh=AkhjkYDWAL2/cRbK6fAULNs8h+HYTnCe+m9OkwikIVA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1VY68SlZo6Ij0Y9kmLZErO2YSFM5Q1X36GWz8D1DgR1Qs1Lu2G1on+zfl7BfHAfRU+RdTp/i8nRIiKDS1l5zdm5LGrpNWZNIj57gOMGWapERaYI0ZirTnhfkipZebLcQcQ6jNhxx/Pwbuk/erQVgQIwbwtAGy7/XnoMpKOTWf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8BB196732A; Thu,  3 Sep 2026 07:34:09 +0200 (CEST)
Date: Thu, 3 Sep 2026 07:34:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/5] min_dio_alignment: add a -r option to query read
 alignment
Message-ID: <20260903053409.GA16469@lst.de>
References: <20260831065120.2578146-1-hch@lst.de> <20260831065120.2578146-3-hch@lst.de> <aphNSwwkbZTSkBRz@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aphNSwwkbZTSkBRz@zlang-mailbox>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Sep 03, 2026 at 12:26:26AM +0800, Zorro Lang wrote:
> On Mon, Aug 31, 2026 at 09:51:05AM +0300, Christoph Hellwig wrote:
> > Add an option to query the STATX_DIO_READ_ALIGN if provided.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  src/min_dio_alignment.c | 44 ++++++++++++++++++++++++++++++-----------
> >  1 file changed, 33 insertions(+), 11 deletions(-)
> > 
> > diff --git a/src/min_dio_alignment.c b/src/min_dio_alignment.c
> > index 866fba1546c4..143cee684ab4 100644
> > --- a/src/min_dio_alignment.c
> > +++ b/src/min_dio_alignment.c
> > @@ -1,17 +1,19 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  /*
> > - * Copyright (c) 2024 Christoph Hellwig
> > + * Copyright (c) 2024,2026 Christoph Hellwig
> >   */
> >  #include <fcntl.h>
> > +#include <stdbool.h>
> >  #include <stdio.h>
> >  #include <stdlib.h>
> >  #include <unistd.h>
> > +#include <getopt.h>
> >  #include <sys/mount.h>
> >  #include <sys/ioctl.h>
> >  #include <sys/stat.h>
> >  #include "statx.h"
> >  
> > -static int min_dio_alignment(const char *mntpnt, const char *devname)
> > +static int min_dio_alignment(const char *mntpnt, const char *devname, bool read)
> >  {
> >  	struct statx stx = { };
> >  	struct stat st;
> > @@ -27,9 +29,16 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
> >  	 */
> >  	fd = open(mntpnt, O_TMPFILE | O_RDWR | O_EXCL, 0600);
> >  	if (fd >= 0 &&
> > -	    xfstests_statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) == 0 &&
> > -	    (stx.stx_mask & STATX_DIOALIGN) && stx.stx_dio_offset_align != 0)
> > -		return stx.stx_dio_offset_align;
> > +	    xfstests_statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) == 0) {
> 
> 
> Hmm... shouldn't STATX_DIO_READ_ALIGN be passed in the request mask as well?
> 
>   xfstests_statx(fd, "", AT_EMPTY_PATH,
>                  STATX_DIOALIGN|STATX_DIO_READ_ALIGN, &stx)

Yeah, strictly speaking we should.  Currently this is only supported
for XFS, and XFS automatically adds STATX_DIO_READ_ALIGN when
STATX_DIOALIGN is requested, so it works.  But more by chance than
design.

