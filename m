Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD46B41DDE1
	for <fstests@vger.kernel.org>; Mon, 14 Sep 2026 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789379053; cv=none; b=ThcYE/arEIZCeSqkH2GCIqb/drxSRNEn9IYZbHXU6yDrq9kTDN0pbuVf56M9c291CwRPehHyaneJIU5X5kcM0UZ8k8bP0oic3O/MtIv2w9kQ19tyBmKo+ODxQF2tCxO047q+LXrBTLDy/I1+NcDymUZm5Ve/m5VxtNk97tNljRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789379053; c=relaxed/simple;
	bh=DpKT4ZgDypZTf812CCVRDrPRbDXmVNIYi8HXM2OGs1A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aMFxTMiv+hVDIElyC+iLgmBys/+IQZ3PLlaQi64+dG2FPBaXbXBXg7HlOhfCBisNJO8Ye2AbWm7qGJd62WSv30oDmfB9ee5VcEgNN30kQC+3L3hZiQdluUAtZdplsRRxt/H6oscmDOyH4UzGbAVEzNbrhZbo+qngGNkr40mc4P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0VKD6ps; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0VKD6ps"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DA6D1F000FF;
	Mon, 14 Sep 2026 09:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789379051;
	bh=T3HWGO73bRPuRcS7wNOsBUmNNXc+qzgADfU5jeABbaM=;
	h=Date:From:To:Subject:References:In-Reply-To;
	b=l0VKD6ps78tg8+rfBmfq8IBqmXO6FdAShOTFpPF7Oknoy/HW4JZ3715J/inRT3Whs
	 tlZUCj+1cifoRjMnOkdQ1WDm5p4mVZ4JTLt39G7zv+4HQb/OTG538AQURW7ayfwgpi
	 WDd2JwLDuqy+eGdnrpRZbqrUq8VD10PUjHXhXk6uIRXseN+iXuOgbOvzJxERJEN77k
	 7qkAs8mwZoCcmRfjphCMGf2uM9g5Q5h6GvjHe5uR61sDcC9gULZ28vTRVeU+yfAdsl
	 3VsfjWxH0/fOnY8tMYgjccTY6+25TaI98JLzJAR1Qtat/+ck8SYCQhORAoap749vt2
	 /uSQD37Az5i6w==
Date: Mon, 14 Sep 2026 17:44:07 +0800
From: Zorro Lang <zlang@kernel.org>
To: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/5] min_dio_alignment: add a -r option to query read
 alignment
Message-ID: <aqfAZC5O21fYmVNP@zlang-mailbox>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
References: <20260831065120.2578146-1-hch@lst.de>
 <20260831065120.2578146-3-hch@lst.de>
 <aphNSwwkbZTSkBRz@zlang-mailbox>
 <20260903053409.GA16469@lst.de>
 <apl3SkiDvs7hPD5O@zlang-mailbox>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apl3SkiDvs7hPD5O@zlang-mailbox>

On Thu, Sep 03, 2026 at 09:39:18PM +0800, Zorro Lang wrote:
> On Thu, Sep 03, 2026 at 07:34:09AM +0200, Christoph Hellwig wrote:
> > On Thu, Sep 03, 2026 at 12:26:26AM +0800, Zorro Lang wrote:
> > > On Mon, Aug 31, 2026 at 09:51:05AM +0300, Christoph Hellwig wrote:
> > > > Add an option to query the STATX_DIO_READ_ALIGN if provided.
> > > > 
> > > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > > ---
> > > >  src/min_dio_alignment.c | 44 ++++++++++++++++++++++++++++++-----------
> > > >  1 file changed, 33 insertions(+), 11 deletions(-)
> > > > 
> > > > diff --git a/src/min_dio_alignment.c b/src/min_dio_alignment.c
> > > > index 866fba1546c4..143cee684ab4 100644
> > > > --- a/src/min_dio_alignment.c
> > > > +++ b/src/min_dio_alignment.c
> > > > @@ -1,17 +1,19 @@
> > > >  // SPDX-License-Identifier: GPL-2.0
> > > >  /*
> > > > - * Copyright (c) 2024 Christoph Hellwig
> > > > + * Copyright (c) 2024,2026 Christoph Hellwig
> > > >   */
> > > >  #include <fcntl.h>
> > > > +#include <stdbool.h>
> > > >  #include <stdio.h>
> > > >  #include <stdlib.h>
> > > >  #include <unistd.h>
> > > > +#include <getopt.h>
> > > >  #include <sys/mount.h>
> > > >  #include <sys/ioctl.h>
> > > >  #include <sys/stat.h>
> > > >  #include "statx.h"
> > > >  
> > > > -static int min_dio_alignment(const char *mntpnt, const char *devname)
> > > > +static int min_dio_alignment(const char *mntpnt, const char *devname, bool read)
> > > >  {
> > > >  	struct statx stx = { };
> > > >  	struct stat st;
> > > > @@ -27,9 +29,16 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
> > > >  	 */
> > > >  	fd = open(mntpnt, O_TMPFILE | O_RDWR | O_EXCL, 0600);
> > > >  	if (fd >= 0 &&
> > > > -	    xfstests_statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) == 0 &&
> > > > -	    (stx.stx_mask & STATX_DIOALIGN) && stx.stx_dio_offset_align != 0)
> > > > -		return stx.stx_dio_offset_align;
> > > > +	    xfstests_statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) == 0) {
> > > 
> > > 
> > > Hmm... shouldn't STATX_DIO_READ_ALIGN be passed in the request mask as well?
> > > 
> > >   xfstests_statx(fd, "", AT_EMPTY_PATH,
> > >                  STATX_DIOALIGN|STATX_DIO_READ_ALIGN, &stx)
> > 
> > Yeah, strictly speaking we should.  Currently this is only supported
> > for XFS, and XFS automatically adds STATX_DIO_READ_ALIGN when
> > STATX_DIOALIGN is requested, so it works.  But more by chance than
> > design.
> 
> I couldn't find any mention in the statx doc that STATX_DIO_READ_ALIGN is
> added by default, explicitly specifying it seems more aligned with how
> the mask parameter is intended to work. Would you like me to fold this in
> when merging? or did you omit it due to other concerns?
> 
> This is the only open point left for the patchset, once we reach consensus,
> I'm good to merge it :)

Hi Christoph, friendly ping, I'm still waiting on your confirmation before
merging this patchset. Would you prefer I keep it as is, or should I add
STATX_DIO_READ_ALIGN?

Thanks,
Zorro

> 
> Thanks,
> Zorro
> 
> > 
> > 
> 
