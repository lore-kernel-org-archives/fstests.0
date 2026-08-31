Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9061D46AA7B
	for <fstests@vger.kernel.org>; Mon, 31 Aug 2026 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788196605; cv=none; b=Y3KBxjusFYs8jI+Caq0SMDuQTJp0GRVZ6Fi7WrTk1mfOJyfjkN7IVyIuPf4i0qZ+tN6twDutlWe+3eBuA2hzEzeZchbVEBAFB0BaZcxNVY+t4+Tmt2/8iPCoQX5oeQ6WhK+UgzqIXR0sUaPpx0yeMP6JVBCGRzM/71zLmAg3s9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788196605; c=relaxed/simple;
	bh=3VAKYF879VI23OgPCw3lES+nwCy4UoeaTNzoelmn2kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u8+wxYUqx6RuBjOuVve8h9Ntxkl6IkVbFCQl6sXEo+zq1Zc+pi3O8U+QaHgiMcxKGwDsjRk3d6tgn6/Kr+7w9ftbqKMXWB1TBZD2XehSYshNGAtgHKh681/vv3KjsglpA6FnuSrfQ/57fctDm8+EvRrurhS/5+HQaFP0fEKQUmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tsk0tEGn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tsk0tEGn"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 1A9211F000E9;
	Mon, 31 Aug 2026 17:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788196604;
	bh=kRSGtQPepigVnGDzrKqvZqbQZhGWTK/I6YCMYkHPHyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Tsk0tEGn+Y+SCTQCcRRJn0Ov/3ih7ZcUjhe/akUSBgksPTLugZtPJXKVTKsb0u+Gf
	 4e+3EHdc+xq+YYarzkv8fH6YHMZmEQKqBAK0D8ih9gigP+e9blvA7jjAY+ZN/AaA7A
	 ty5egvf6lkxSe9VqcXvwNh4HYNfQWlKsBa2MDdb3kXX4KtOUMcpjIz3x41In8aRXKm
	 8e6dS2WoCn8bQHKyUr0aG5YdhHtipO/tRjwYcxi3Wn0Anizxglx/7bJgWp6rZ0wSX0
	 /lw9Y/6gLQH7hH39gmGChPKIxUfnP1NH2h1jOGysftbhGCAJ5l7+Ct+LD+qfsRq/nn
	 MhLqJEh1BwoDw==
Date: Mon, 31 Aug 2026 10:16:43 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Subject: Re: [PATCH 2/5] min_dio_alignment: add a -r option to query read
 alignment
Message-ID: <20260831171643.GC839663@frogsfrogsfrogs>
References: <20260831065120.2578146-1-hch@lst.de>
 <20260831065120.2578146-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260831065120.2578146-3-hch@lst.de>

On Mon, Aug 31, 2026 at 09:51:05AM +0300, Christoph Hellwig wrote:
> Add an option to query the STATX_DIO_READ_ALIGN if provided.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This makes sense to me.  It's sorta nice to have a canonical example of
how you're supposed to access the directio geometry fields :)

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  src/min_dio_alignment.c | 44 ++++++++++++++++++++++++++++++-----------
>  1 file changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/src/min_dio_alignment.c b/src/min_dio_alignment.c
> index 866fba1546c4..143cee684ab4 100644
> --- a/src/min_dio_alignment.c
> +++ b/src/min_dio_alignment.c
> @@ -1,17 +1,19 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * Copyright (c) 2024 Christoph Hellwig
> + * Copyright (c) 2024,2026 Christoph Hellwig
>   */
>  #include <fcntl.h>
> +#include <stdbool.h>
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <unistd.h>
> +#include <getopt.h>
>  #include <sys/mount.h>
>  #include <sys/ioctl.h>
>  #include <sys/stat.h>
>  #include "statx.h"
>  
> -static int min_dio_alignment(const char *mntpnt, const char *devname)
> +static int min_dio_alignment(const char *mntpnt, const char *devname, bool read)
>  {
>  	struct statx stx = { };
>  	struct stat st;
> @@ -27,9 +29,16 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
>  	 */
>  	fd = open(mntpnt, O_TMPFILE | O_RDWR | O_EXCL, 0600);
>  	if (fd >= 0 &&
> -	    xfstests_statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) == 0 &&
> -	    (stx.stx_mask & STATX_DIOALIGN) && stx.stx_dio_offset_align != 0)
> -		return stx.stx_dio_offset_align;
> +	    xfstests_statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) == 0) {
> +		if (read &&
> +		    (stx.stx_mask & STATX_DIO_READ_ALIGN) &&
> +		    stx.stx_dio_read_offset_align != 0)
> +			return stx.stx_dio_read_offset_align;
> +
> +		if ((stx.stx_mask & STATX_DIOALIGN) &&
> +		    stx.stx_dio_offset_align != 0)
> +			return stx.stx_dio_offset_align;
> +	}
>  
>  	/*
>  	 * If we are on a block device and no explicit aligned is reported, use
> @@ -42,9 +51,8 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
>  		if (dev_fd > 0 &&
>  		    fstat(dev_fd, &st) == 0 &&
>  		    S_ISBLK(st.st_mode) &&
> -		    ioctl(dev_fd, BLKSSZGET, &logical_block_size) == 0) {
> +		    ioctl(dev_fd, BLKSSZGET, &logical_block_size) == 0)
>  			return logical_block_size;
> -		}
>  	}
>  
>  	/*
> @@ -56,11 +64,25 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
>  
>  int main(int argc, char **argv)
>  {
> -	if (argc != 3) {
> -		fprintf(stderr, "usage: %s mountpoint devicename\n", argv[0]);
> -		exit(1);
> +	bool read = false;
> +	int c;
> +
> +	while ((c = getopt(argc, argv, "r")) != -1) {
> +		switch(c) {
> +		case 'r':
> +			read = 1;
> +			break;
> +		default:
> +			goto usage;
> +		}
>  	}
>  
> -	printf("%d\n", min_dio_alignment(argv[1], argv[2]));
> +	if (argc - optind != 2)
> +		goto usage;
> +
> +	printf("%d\n", min_dio_alignment(argv[optind], argv[optind + 1], read));
>  	exit(0);
> +usage:
> +	fprintf(stderr, "usage: %s [-r] mountpoint devicename\n", argv[0]);
> +	exit(1);
>  }
> -- 
> 2.53.0
> 
> 
