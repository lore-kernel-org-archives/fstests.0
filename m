Received: from imap.thunk.org ([74.207.234.97]:59965 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750935AbbG3Rrd (ORCPT <rfc822;fstests@vger.kernel.org>);
	Thu, 30 Jul 2015 13:47:33 -0400
Date: Thu, 30 Jul 2015 13:47:30 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/4] xfstests: if DEV_BSIZE is not defined, assume it to
 be 512
Message-ID: <20150730174730.GB3227@thunk.org>
References: <1438006967-18815-1-git-send-email-tytso@mit.edu>
 <1438006967-18815-2-git-send-email-tytso@mit.edu>
 <20150730171358.GA18185@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150730171358.GA18185@infradead.org>
Sender: fstests-owner@vger.kernel.org
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Jul 30, 2015 at 10:13:58AM -0700, Christoph Hellwig wrote:
> > diff --git a/lib/str_to_bytes.c b/lib/str_to_bytes.c
> > index c0d7d97..d63e93b 100644
> > --- a/lib/str_to_bytes.c
> > +++ b/lib/str_to_bytes.c
> > @@ -44,7 +44,11 @@
> >   ****************************************************************************/
> >  
> >  #if linux
> > +#ifdef DEV_BSIZE
> >  #define B_MULT	DEV_BSIZE	/* block size */
> > +#else
> > +#define B_MULT	512		/* block size */
> > +#endif
> >  #endif
> 
> That ifdef Linux looks bogus too.  I's say just define it to 512
> bytes here unconditionally.

Ack, will do.

> Same here, drop all the ifdefs and just define it to 512.

Ditto

					- Ted
					
