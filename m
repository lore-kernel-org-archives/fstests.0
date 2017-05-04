Received: from userp1040.oracle.com ([156.151.31.81]:26504 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752203AbdEDPtV (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 4 May 2017 11:49:21 -0400
Date: Thu, 4 May 2017 08:49:16 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] punch-alternating: add some options
Message-ID: <20170504154916.GB5970@birch.djwong.org>
References: <ad311156-c99a-4269-051e-082b259bb0de@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad311156-c99a-4269-051e-082b259bb0de@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Thu, May 04, 2017 at 10:16:54AM -0500, Eric Sandeen wrote:
> I didn't end up using this, but somebody else might find
> it useful, so sending it.
> 
> This change lets us specify punch patterns other than
> literally every other block.
> 
> i.e. punch-alternating with no options will do:
> 
> ...HDHDHDHDHDHD...
> 
> -i 4 -s 2 will do:
> 
> ...DDHHDDHHDDHH...
> 
> or -i 3 -s 1 will do:
> 
> ...DDHDDHDDHDDH...
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/src/punch-alternating.c b/src/punch-alternating.c
> index 4148622..0c7a7ff 100644
> --- a/src/punch-alternating.c
> +++ b/src/punch-alternating.c
> @@ -11,6 +11,14 @@
>  #include <string.h>
>  #include "global.h"
>  
> +void usage(char *cmd)
> +{
> +	printf("Usage: %s [-i interval] [-s size] file\n", cmd);
> +	printf("Punches every other block in the file by default,\n");
> +	printf("or 'size' blocks every 'interval' blocks with options.\n");
> +	exit(1);
> +}
> +
>  int main(int argc, char *argv[])
>  {
>  	struct stat	s;
> @@ -21,14 +29,27 @@ int main(int argc, char *argv[])
>  	off_t		sz;
>  	int		mode;
>  	int		error;
> +	int		c;
> +	int		size = 1;	/* punch $SIZE blocks ... */
> +	int		interval = 2;	/* every $INTERVAL blocks */
> +
> +	if (argc < 2)
> +		usage(argv[0]);

I think you want a (optind == argc - 1) check after the getopt to
preserve the "only one file at a time" semantics... or an optind loop to
process a bunch of files.

> -	if (argc != 2) {
> -		printf("Usage: %s file\n", argv[0]);
> -		printf("Punches every other block in the file.\n");
> -		return 1;
> +	while ((c = getopt(argc, argv, "i:s:")) != EOF) {
> +		switch (c) {
> +		case 'i':
> +			interval = atoi(optarg);
> +			break;
> +		case 's':
> +			size = atoi(optarg);
> +			break;
> +		default:
> +			usage(argv[0]);
> +		}
>  	}

Is it valid to -i 0 -s -5 here? :)

--D

> -	fd = open(argv[1], O_WRONLY);
> +	fd = open(argv[optind], O_WRONLY);
>  	if (fd < 0)
>  		goto err;
>  
> @@ -44,8 +65,8 @@ int main(int argc, char *argv[])
>  	blksz = sf.f_bsize;
>  
>  	mode = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
> -	for (offset = 0; offset < sz; offset += blksz * 2) {
> -		error = fallocate(fd, mode, offset, blksz);
> +	for (offset = 0; offset < sz; offset += blksz * interval) {
> +		error = fallocate(fd, mode, offset, blksz * size);
>  		if (error)
>  			goto err;
>  	}
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
