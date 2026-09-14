Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2864C48BD3C
	for <fstests@vger.kernel.org>; Mon, 14 Sep 2026 17:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789407805; cv=none; b=eyux3HeThgBkN09DmenttVznipTQ8RWwUDkZrvLEI963WBlcUqJZotza9POJyuHKZp5rdv34O6qr0czpOBda9De3cWGcvToRyl+04pOC2QPeSldV6j3X5BSdTNq7wm+4AONZ06MzMX7ZnBtlUkP3d964/fNqUlRS279Sn6gS7cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789407805; c=relaxed/simple;
	bh=jdd/yDwW2D2R4nwIjFnoXEe0TJF7l6w6uaIhaSMbfYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ai+7ElC8Zs9QFDamp7S9ZZGW+dHbkA7xwIpJWmh7dUdUEiHWptNSRzmWcfzq+PAb3/bimvWiIu6xzMprhRxRKB91HuM5vm8UnpApEiH2gjtfAmhIzByz1y4SVQ3ji2kI1Nx9xa75HWxjFTQJEIbmoWA1gSx75d1PzNYlDL8cv8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lumg3ciU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lumg3ciU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DF11F000FF;
	Mon, 14 Sep 2026 17:43:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789407795;
	bh=Eaa+ufQVkLSxYcvRi11y6T4R6jY6iFIwM2uNZr0MweA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lumg3ciUeOXIBbjbk/irPuAyyuOXA1N35wjebwi+zGn9z949CXCYiZ9ExTDnzSdBT
	 Qp2GxeLhqkMsrLN08wDKgbp8Owrf34dqdQ5vVL4j+3UruHYnPDajATsRa3Hxvn0/HH
	 1fIwcQjrFatSNAEkDZr62oZXUt++rQG6sMz4a8SC20002+vZ7KJjuZjJI3abJzPYXf
	 Cf8mXpaBZrLB9y7ceI9tTflwjNETz3pcaM6Eb0ePQB5ZVkD2RIERVTN9+4jOrmZ7Sb
	 v9CLdsteCrbFL5oxj+M86H0ldg9vhs/SxM0P8da14lS8lF6msZvT3SOuqb1BFLpPxF
	 sJ38TL52LIYCg==
Date: Tue, 15 Sep 2026 01:43:10 +0800
From: Zorro Lang <zlang@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>
Subject: Re: [PATCH 2/5] min_dio_alignment: add a -r option to query read
 alignment
Message-ID: <aqgx_usAw1NOtjm1@zlang-mailbox>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, fstests@vger.kernel.org, 
	"Darrick J. Wong" <djwong@kernel.org>
References: <20260914114550.2451308-1-hch@lst.de>
 <20260914114550.2451308-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914114550.2451308-3-hch@lst.de>

On Mon, Sep 14, 2026 at 01:45:44PM +0200, Christoph Hellwig wrote:
> Add an option to query the STATX_DIO_READ_ALIGN if provided.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

Thanks Christoph, this version is good to me:)

Reviewed-by: Zorro Lang <zlang@kernel.org>

>  src/min_dio_alignment.c | 45 +++++++++++++++++++++++++++++++----------
>  1 file changed, 34 insertions(+), 11 deletions(-)
> 
> diff --git a/src/min_dio_alignment.c b/src/min_dio_alignment.c
> index 866fba1546c4..a557ce93a5d6 100644
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
> @@ -27,9 +29,17 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
>  	 */
>  	fd = open(mntpnt, O_TMPFILE | O_RDWR | O_EXCL, 0600);
>  	if (fd >= 0 &&
> -	    xfstests_statx(fd, "", AT_EMPTY_PATH, STATX_DIOALIGN, &stx) == 0 &&
> -	    (stx.stx_mask & STATX_DIOALIGN) && stx.stx_dio_offset_align != 0)
> -		return stx.stx_dio_offset_align;
> +	    xfstests_statx(fd, "", AT_EMPTY_PATH,
> +			STATX_DIOALIGN | STATX_DIO_READ_ALIGN, &stx) == 0) {
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
> @@ -42,9 +52,8 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
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
> @@ -56,11 +65,25 @@ static int min_dio_alignment(const char *mntpnt, const char *devname)
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
