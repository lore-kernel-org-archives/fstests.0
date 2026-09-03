Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174DC4A8412
	for <fstests@vger.kernel.org>; Thu,  3 Sep 2026 13:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442778; cv=none; b=srMvy4aJU3QAJfBuH23UvU9T1NYqkvscZ1+L55GoKvK/AREYwYD6z3Yb4o0GvG47ei1XJQ5ipUFE+0QqnlJgrz+1lyYrgvACePQKd7My4O7H8Q4QqyRppFU3Yo2/jfbxpYxoPCk+K13O+tnpfldYiEr+c2J/rG8KZZFrGi3F2Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442778; c=relaxed/simple;
	bh=EwAtfIw8yCwsmp0ZWd7UMh6dnzUP6S13fg7zbZbQ4CM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uA7VWfwd7YMWrbhxaUcfaQseY+JTSsWeG08qC4WvKpN00EdzXZ1CIoQcc+GAzjpfy3FIwyGwhY6EZ2jdwM5DofQtIjdDFSdXcpEOFPenKiAowib03/5tSNWj+svv9G9fLjypdwEGOym6abaNOB1LMi38zeSJUoyGu1yeOz3b32A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSBVC4Ie; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSBVC4Ie"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB581F00A3A;
	Thu,  3 Sep 2026 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788442765;
	bh=DL5wfCWEHuJXr66JqeuVPqyZD7djEh0RNicbPhKIjMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jSBVC4IeI/O6aUyeIyIVMt4QnQNlLtmVvgBa1osuwMzYQkQ+OIXcTOWRMLA54ahzQ
	 Tq2UunRzMdZbfEGMBEZsSaVNW0Qx8y7pDWc3+y1EfSxk+wj9hBdJDC26n8cbRdkEeO
	 7WfxHKBLE5fneLswnF4Z3qKoWXARQTlb4gCAtYcZv/9RFXhKVpTFPpQ/l03F9eTpvM
	 ztxoi4NTKiE+aiewzLStE1fhACkZMsIq7C5PfGc9gmhnmThNMiu4wPX+zfPWJwfMtL
	 yr3rNCA7wVTtJzwfMW/hJRvHF2ig/x0ctOi8CjD2UT8Zjwh4xVkKLpOXyJM7/u1GUM
	 ivDfeMKaTIXSA==
Date: Thu, 3 Sep 2026 21:39:18 +0800
From: Zorro Lang <zlang@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/5] min_dio_alignment: add a -r option to query read
 alignment
Message-ID: <apl3SkiDvs7hPD5O@zlang-mailbox>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
References: <20260831065120.2578146-1-hch@lst.de>
 <20260831065120.2578146-3-hch@lst.de>
 <aphNSwwkbZTSkBRz@zlang-mailbox>
 <20260903053409.GA16469@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903053409.GA16469@lst.de>

On Thu, Sep 03, 2026 at 07:34:09AM +0200, Christoph Hellwig wrote:
> On Thu, Sep 03, 2026 at 12:26:26AM +0800, Zorro Lang wrote:
> > On Mon, Aug 31, 2026 at 09:51:05AM +0300, Christoph Hellwig wrote:
> > > Add an option to query the STATX_DIO_READ_ALIGN if provided.
> > > 
> > > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  src/min_dio_alignment.c | 44 ++++++++++++++++++++++++++++++-----------
> > >  1 file changed, 33 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/src/min_dio_alignment.c b/src/min_dio_alignment.c
> > > index 866fba1546c4..143cee684ab4 100644
> > > --- a/src/min_dio_alignment.c
> > > +++ b/src/min_dio_alignment.c
> > > @@ -1,17 +1,19 @@
> > >  // SPDX-License-Identifier: GPL-2.0
> > >  /*
> > > - * Copyright (c) 2024 Christoph Hellwig
> > > + * Copyright (c) 2024,2026 Christoph Hellwig
> > >   */
> > >  #include <fcntl.h>
> > > +#include <stdbool.h>
> > >  #include <stdio.h>
> > >  #include <stdlib.h>
> > >  #include <unistd.h>
> > > +#include <getopt.h>
> > >  #include <sys/mount.h>
> > >  #include <sys/ioctl.h>
> > >  #include <sys/stat.h>
> > >  #include "statx.h"
> > >  
> > > -static int min_dio_alignment(const char *mntpnt, const char *devname)
> > > +static int min_dio_alignment(const char *mntpnt, const char *devname, bool read)
> > >  {
> > >  	struct statx stx = { };
> > >  	struct stat st;
> > > @@ -27,9 +29,16 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
> > >  	 */
> > >  	fd = open(mntpnt, O_TMPFILE | O_RDWR | O_EXCL, 0600);
> > >  	if (fd >= 0 &&
> > > -	    xfstests_statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) == 0 &&
> > > -	    (stx.stx_mask & STATX_DIOALIGN) && stx.stx_dio_offset_align != 0)
> > > -		return stx.stx_dio_offset_align;
> > > +	    xfstests_statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) == 0) {
> > 
> > 
> > Hmm... shouldn't STATX_DIO_READ_ALIGN be passed in the request mask as well?
> > 
> >   xfstests_statx(fd, "", AT_EMPTY_PATH,
> >                  STATX_DIOALIGN|STATX_DIO_READ_ALIGN, &stx)
> 
> Yeah, strictly speaking we should.  Currently this is only supported
> for XFS, and XFS automatically adds STATX_DIO_READ_ALIGN when
> STATX_DIOALIGN is requested, so it works.  But more by chance than
> design.

I couldn't find any mention in the statx doc that STATX_DIO_READ_ALIGN is
added by default, explicitly specifying it seems more aligned with how
the mask parameter is intended to work. Would you like me to fold this in
when merging? or did you omit it due to other concerns?

This is the only open point left for the patchset, once we reach consensus,
I'm good to merge it :)

Thanks,
Zorro

> 
> 
