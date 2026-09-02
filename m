Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3457E4AA571
	for <fstests@vger.kernel.org>; Wed,  2 Sep 2026 16:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788366697; cv=none; b=mnHncukRaN9uqgTh4F9kYLDpn2WpGGVE1zAzaj1htsCI7/cnfLmxctAWZU3k3/WCAfSD6XC2FyR8HEgkfXEGk+mAzSaHHa4gGphZA1epCE/sEY7DpCqSC03f9y4vU1mGVFs2v366Bi0vxieqHO6wzsPEXwq0T3OmC5aqhMPyIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788366697; c=relaxed/simple;
	bh=5klSK4X0S9PdoLyVB3nED9lhXDgsG73XHzvOMXu6d54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLElt4PTCp4Xg4Np4LaIJmDoSzTdymN/UnTbkQKeVrcahdgdLd+I715ai4rFbr1YoLgE2AQZ4aUcwxkMs9fGOmBQFBVSp0JkPrMR/9P1QLgrkS8D8rbaIk9EEvxQBPyNVhPrv5GtDeyNUMsh90tjBio0e3hnn2Zt8aDqcyh7hHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WIX0zmIr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WIX0zmIr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32EEF1F000E9;
	Wed,  2 Sep 2026 16:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788366695;
	bh=jjB3a1klBZ1bBTQiVm/om3y0tBoZq2SwQ5dUMwEKlEo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WIX0zmIrHGJ6edAXvJkIH82jrSX/UG16ZIg6H1e9OvY2cA6tmAmPDcrKXvn2AXXJd
	 vSb1P/61KjfhdOoRNyD1MbBLqayJBBW4T1EGO506PxEYBvob0B9v3kKsieZrUsAuRj
	 kVmHdCfE0UDwJHIwbIakEWpDWYcJSvrgmWUW8j9Yg29+eT93b4oDUueHtSje58msxI
	 1QJlQ7I+Yu6E0UKCQQ8d9si8TkhTxYzS9Su7Tdww/2gDpN/SzzUPateZLSkmWrEskR
	 gsw6iIXwU7vySbPSjCTXyjsI+M9NS9cDC2bge8bH4OrH1XGGQq24nTEsaBejy5gmxx
	 c1Osx/k95dYBQ==
Date: Thu, 3 Sep 2026 00:31:30 +0800
From: Zorro Lang <zlang@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 2/5] min_dio_alignment: add a -r option to query read
 alignment
Message-ID: <aphPQV7nLIr8rmzX@zlang-mailbox>
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

read = true;

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
