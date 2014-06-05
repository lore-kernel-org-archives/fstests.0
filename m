Return-Path: <fstests-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:64764 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751380AbaFET3p (ORCPT
	<rfc822;fstests@vger.kernel.org>); Thu, 5 Jun 2014 15:29:45 -0400
Received: by mail-ie0-f179.google.com with SMTP id rd18so1271697iec.24
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2014 12:29:45 -0700 (PDT)
Message-ID: <5390C532.2060706@ieee.org>
Date: Thu, 05 Jun 2014 14:29:54 -0500
From: Alex Elder <elder@ieee.org>
MIME-Version: 1.0
Subject: Re: [patch] resvtest.c: fix invalid use of sizeof()
References: <x49lhtbw42a.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49lhtbw42a.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: xfstests-owner@vger.kernel.org
To: Jeff Moyer <jmoyer@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 06/05/2014 02:26 PM, Jeff Moyer wrote:
> Hi,
> 
> sizeof(pointer) will give you the size of a pointer, not the space
> allocated to it.  I noticed this when gcc complained:
> 
> resvtest.c:76:33: warning: argument to 'sizeof' in 'memset' call is the same expression as the destination; did you mean to provide an explicit length? [-Wsizeof-pointer-memaccess]
>   memset(writebuffer, 'A', sizeof(writebuffer));

Nice catch, gcc!

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> 
> diff --git a/src/resvtest.c b/src/resvtest.c
> index 037d9ea..ecad031 100644
> --- a/src/resvtest.c
> +++ b/src/resvtest.c
> @@ -73,7 +73,7 @@ main(int argc, char **argv)
>  		perror("open");
>  		exit(1);
>  	}
> -	memset(writebuffer, 'A', sizeof(writebuffer));
> +	memset(writebuffer, 'A', bsize);
>  
>  	unlink(filename);
>  	writefd = open(filename, O_RDWR | O_CREAT | O_EXCL, S_IRUSR | S_IWUSR);
> @@ -111,7 +111,7 @@ main(int argc, char **argv)
>  		char *p;
>  		int numerrors;
>  
> -		if (write(writefd, writebuffer, sizeof(writebuffer)) < 0) {
> +		if (write(writefd, writebuffer, bsize) < 0) {
>  			perror("write");
>  			exit(1);
>  		}
> @@ -128,11 +128,11 @@ main(int argc, char **argv)
>  		lseek(readfd, SEEK_SET, 0);
>  		numerrors = 0;
>  		for (j = 0; j < n; j++) {
> -			if (read(readfd, readbuffer, sizeof(readbuffer)) < 0) {
> +			if (read(readfd, readbuffer, bsize) < 0) {
>  				perror("read");
>  				exit(1);
>  			}
> -			for (i = 0; i < sizeof(readbuffer); i++) {
> +			for (i = 0; i < bsize; i++) {
>  				if (readbuffer[i] != 'A') {
>  					fprintf(stderr,
>  "errors detected in file, pos: %d (%lld+%d), nwrites: %d [val=0x%x].\n",
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

