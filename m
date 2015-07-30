Received: from bombadil.infradead.org ([198.137.202.9]:44268 "EHLO
	bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbbG3RN7 (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 30 Jul 2015 13:13:59 -0400
Date: Thu, 30 Jul 2015 10:13:58 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/4] xfstests: if DEV_BSIZE is not defined, assume it to
 be 512
Message-ID: <20150730171358.GA18185@infradead.org>
References: <1438006967-18815-1-git-send-email-tytso@mit.edu>
 <1438006967-18815-2-git-send-email-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438006967-18815-2-git-send-email-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Jul 27, 2015 at 10:22:44AM -0400, Theodore Ts'o wrote:
> On Linux systems with glibc, DEV_BSIZE defines the sector size for the
> Linux kernel, which is 512 since the beginning of time --- and which
> we can't really change without breaking a huge amount of kernel code.
> Some non-glibc C libraries, may not define DEV_BSIZE; if it does not
> exist, assume that it will be 512.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  lib/str_to_bytes.c | 4 ++++
>  lib/write_log.c    | 4 ++++
>  2 files changed, 8 insertions(+)
> 
> diff --git a/lib/str_to_bytes.c b/lib/str_to_bytes.c
> index c0d7d97..d63e93b 100644
> --- a/lib/str_to_bytes.c
> +++ b/lib/str_to_bytes.c
> @@ -44,7 +44,11 @@
>   ****************************************************************************/
>  
>  #if linux
> +#ifdef DEV_BSIZE
>  #define B_MULT	DEV_BSIZE	/* block size */
> +#else
> +#define B_MULT	512		/* block size */
> +#endif
>  #endif

That ifdef Linux looks bogus too.  I's say just define it to 512
bytes here unconditionally.

>  #ifndef BSIZE
>  #ifdef linux
> +#ifdef DEV_BSIZE
>  #define BSIZE DEV_BSIZE
> +#else  /* !DEV_BSIZE */
> +#define BSIZE 512
> +#endif	/* DEV_BSIZE */
>  #else
>  #define BSIZE BBSIZE
>  #endif

Same here, drop all the ifdefs and just define it to 512.
