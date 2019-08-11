Received: from mail-pl1-f194.google.com ([209.85.214.194]:32770 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbfHKOeJ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 11 Aug 2019 10:34:09 -0400
Received: by mail-pl1-f194.google.com with SMTP id c14so46805494plo.0
        for <fstests@vger.kernel.org>; Sun, 11 Aug 2019 07:34:09 -0700 (PDT)
Date: Sun, 11 Aug 2019 22:33:57 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] seek_sanity_test: Repair check for unwritten extent
 support
Message-ID: <20190811143357.GD2665@desktop>
References: <20190807112514.1903-1-agruenba@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190807112514.1903-1-agruenba@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: fstests@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Aug 07, 2019 at 01:25:14PM +0200, Andreas Gruenbacher wrote:
> In test_basic_support, commit f3c1bca7fb25 ("generic: Test that
> SEEK_HOLE can find a punched hole") cleverly punched a hole in the test
> file in the middle of the check for unwritten extent support, making
> sure we would never detect when unwritten extent support is missing.
> Fix that.
> 
> While at it, explicitly check for SEEK_DATA support as well:  so far, we
> were assuming that SEEK_HOLE support implies SEEK_DATA support, but it
> won't hurt to actually check.
> 
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>

Thanks for the fix! I missed the bug when reviewing f3c1bca7fb25, I
think that's because it's not so obvious that the fallocate and the
subsequent SEEK_DATA as a whole are for check for unwritten extent
support. So I did minor updates based on this patch to add more
comments, to make it clear what we're checking for at each stage.

Thanks,
Eryu

> ---
>  src/seek_sanity_test.c | 27 +++++++++++++++++++--------
>  1 file changed, 19 insertions(+), 8 deletions(-)
> 
> diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
> index 30e996e2..080ca7eb 100644
> --- a/src/seek_sanity_test.c
> +++ b/src/seek_sanity_test.c
> @@ -1156,7 +1156,16 @@ static int test_basic_support(void)
>  	if (ret)
>  		goto out;
>  
> -	/* Is SEEK_DATA and SEEK_HOLE supported in the kernel? */
> +	/* Is SEEK_DATA supported in the kernel? */
> +	pos = lseek(fd, 0, SEEK_DATA);
> +	if (pos == -1) {
> +		fprintf(stderr, "Kernel does not support llseek(2) extension "
> +			"SEEK_DATA. Aborting.\n");
> +		ret = -1;
> +		goto out;
> +	}
> +
> +	/* Is SEEK_HOLE supported in the kernel? */
>  	pos = lseek(fd, 0, SEEK_HOLE);
>  	if (pos == -1) {
>  		fprintf(stderr, "Kernel does not support llseek(2) extension "
> @@ -1186,19 +1195,21 @@ static int test_basic_support(void)
>  			ret = -1;
>  		}
>  		goto out;
> -	} else if (fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> -			     0, alloc_size) == -1) {
> -		fprintf(stderr, "File system does not support punch hole.\n");
> -	} else {
> -		punch_hole = 1;
>  	}
>  
>  	pos = lseek(fd, 0, SEEK_DATA);
>  	if (pos == 0) {
>  		fprintf(stderr, "File system does not support unwritten extents.\n");
> -		goto out;
> +	} else {
> +		unwritten_extents = 1;
> +	}
> +
> +	if (fallocate(fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> +			     0, alloc_size) == -1) {
> +		fprintf(stderr, "File system does not support punch hole.\n");
> +	} else {
> +		punch_hole = 1;
>  	}
> -	unwritten_extents = 1;
>  
>  	printf("\n");
>  
> -- 
> 2.20.1
> 
