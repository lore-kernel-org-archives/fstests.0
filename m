Received: from sandeen.net ([63.231.237.45]:51322 "EHLO sandeen.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753547AbcAUE2L (ORCPT <rfc822;fstests@vger.kernel.org>);
	Wed, 20 Jan 2016 23:28:11 -0500
Subject: Re: [PATCH] fsync-tester: reopen files with correct flags
References: <1453340625-10406-1-git-send-email-david@fromorbit.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <56A05E59.1080404@sandeen.net>
Date: Wed, 20 Jan 2016 22:28:09 -0600
MIME-Version: 1.0
In-Reply-To: <1453340625-10406-1-git-send-email-david@fromorbit.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 1/20/16 7:43 PM, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> When "drop caches" tests are run, the test_fd is closed and
> re-opened. It is reopened O_RDWR, so dropping O_DIRECT and any other
> open flag that was set for test_fd. This fixes a random generic/311
> failure due to file data corruption I've been seeing on subtests 11
> and 13 when direct IO was specified.
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>

Cool.

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

> ---
>  src/fsync-tester.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/src/fsync-tester.c b/src/fsync-tester.c
> index 657e00f..4171874 100644
> --- a/src/fsync-tester.c
> +++ b/src/fsync-tester.c
> @@ -12,6 +12,7 @@
>  static int test_fd;
>  static char *buf;
>  static char *fname;
> +static int openflags = O_RDWR;
>  
>  /*
>   * Just creates a random file, overwriting the file in a random number of loops
> @@ -139,7 +140,7 @@ static int test_three(int *max_blocks, int prealloc, int rand_fsync,
>  			if (drop_caches) {
>  				close(test_fd);
>  				drop_all_caches();
> -				test_fd = open(fname, O_RDWR);
> +				test_fd = open(fname, openflags);
>  				if (test_fd < 0) {
>  					test_fd = 0;
>  					fprintf(stderr, "Error re-opening file: %d\n",
> @@ -381,7 +382,6 @@ int main(int argc, char **argv)
>  	long int test = 1;
>  	long int tmp;
>  	int ret = 0;
> -	int flags = O_RDWR|O_CREAT|O_TRUNC;
>  
>  	if (argc < 2)
>  		usage();
> @@ -435,7 +435,7 @@ int main(int argc, char **argv)
>  	srandom(seed);
>  
>  	if (direct_io) {
> -		flags |= O_DIRECT;
> +		openflags |= O_DIRECT;
>  		ret = posix_memalign((void **)&buf, getpagesize(), 4096);
>  		if (ret) {
>  			fprintf(stderr, "Error allocating buf: %d\n", ret);
> @@ -449,7 +449,7 @@ int main(int argc, char **argv)
>  		}
>  	}
>  
> -	test_fd = open(fname, flags, 0644);
> +	test_fd = open(fname, openflags | O_CREAT | O_TRUNC, 0644);
>  	if (test_fd < 0) {
>  		fprintf(stderr, "Error opening file %d (%s)\n", errno,
>  			strerror(errno));
> 
