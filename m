Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BB54AA3FE
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366393; cv=none; b=A5Tv3o1YtJEGbvJSPiS3/7l9IQa7ysPZIMeIVhMvEYeLFXNiSla5+zceriGYVRDzca7l5chNkbKaF4ZGQFnpLuDW8aIQmDUrAVBYcFNuosrWSL4Xf/SqljB1qoL6MuZ3n+BH4W9v3hb7UV9dkBCtenvoLdIgs9NezfFK0X4et/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366393; c=relaxed/simple;
	bh=1gd1ovilkFquYuKLh+18QDhOVrVW1VhpXJUuYBP4w3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NG/ICb9kOM6HFveTuWJgUhD8E449Jrh1FxRZBrZzUqXplLLXxXkYJoEW0EOrg67s+GsNtOazqmSAYmJ+/Nl8hsH1U07jzliN1XXu3/yzEjaPPh1yEEmftEc+KUhNzvTi1Z8zz2UViM3r76cMOq6rtaOkZLVU9H1/RKVtg9Uk/4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAnqtw1h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAnqtw1h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B001F000E9;
	Wed,  2 Sep 2026 16:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788366391;
	bh=gJCYO7vO1VKZ4Q1bP0MyX4OrS8YLyq/z0pM2IABNPpA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JAnqtw1h343QvgoJsBiIJlaZ8iLOCozeZUywvRnoKPDxJ8f8bz39sWFmaE8n/NCpi
	 gU2rwRwx1S4wb7Ysxx0OYhE7nea2gJw6gGbIXZIxiWyQtHXgKfyZpJHPRCapiF7h1I
	 81inToZY6cyS1Z++zz6GxCCwvwKTHzCtDLlSIavTleI4e4E81JXd0BIR02RWFM/HvP
	 0ZJHpLAXjegLPOfpfMjs8YDO2Gj3+9tinstev640JYFQ9Znh+LIha54kKQa1e2zcGN
	 tqhYQFrlpcNcnjUWOMvPy2a8aSnRZE39AarAZdX/rOUdkk9HIUc5EVZ0tioiJJ8ea4
	 j5iReqwQPNAfg==
Date: Thu, 3 Sep 2026 00:26:26 +0800
From: Zorro Lang <zlang@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/5] min_dio_alignment: add a -r option to query read
 alignment
Message-ID: <aphNSwwkbZTSkBRz@zlang-mailbox>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org
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


Hmm... shouldn't STATX_DIO_READ_ALIGN be passed in the request mask as well?

  xfstests_statx(fd, "", AT_EMPTY_PATH,
                 STATX_DIOALIGN|STATX_DIO_READ_ALIGN, &stx)

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
