Received: from userp2130.oracle.com ([156.151.31.86]:49100 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732951AbfDJPOC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 10 Apr 2019 11:14:02 -0400
Date: Wed, 10 Apr 2019 08:13:52 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] fsx: test copy_file_range() using non-zero length copy
Message-ID: <20190410151352.GH32415@magnolia>
References: <20190410111359.5243-1-bfoster@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190410111359.5243-1-bfoster@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Brian Foster <bfoster@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Apr 10, 2019 at 07:13:59AM -0400, Brian Foster wrote:
> The copy_file_range() test detection code performs a zero-length
> copy to determine whether to perform such calls during the test run.
> While this detects the common case of syscall availability,
> copy_file_range() has a somewhat variable implementation on the
> kernel side that can depend on certain per-filesystem features, etc.
> In some implementations, a zero length copy can shortcut and return
> success before ever invoking per-filesystem functionality and thus
> not thoroughly testing the copy mechanism on the current system.
> This can cause the test detection code to pass only to run into an
> immediate failure on the first copy_file_range() call during the
> test.
> 
> Tweak test_copy_range() to perform a small single byte copy to avoid
> this problem. Also fix a typo bug in the errno check of the clone
> range detection logic.
> 
> Signed-off-by: Brian Foster <bfoster@redhat.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  ltp/fsx.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 391824bf..06d08e4e 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -1364,7 +1364,7 @@ test_clone_range(void)
>  	};
>  
>  	if (ioctl(fd, FICLONERANGE, &fcr) &&
> -	    (errno = EOPNOTSUPP || errno == ENOTTY)) {
> +	    (errno == EOPNOTSUPP || errno == ENOTTY)) {
>  		if (!quiet)
>  			fprintf(stderr,
>  				"main: filesystem does not support "
> @@ -1581,9 +1581,9 @@ do_dedupe_range(unsigned offset, unsigned length, unsigned dest)
>  int
>  test_copy_range(void)
>  {
> -	loff_t o1 = 0, o2 = 0;
> +	loff_t o1 = 0, o2 = 1;
>  
> -	if (syscall(__NR_copy_file_range, fd, &o1, fd, &o2, 0, 0) == -1 &&
> +	if (syscall(__NR_copy_file_range, fd, &o1, fd, &o2, 1, 0) == -1 &&
>  	    (errno == ENOSYS || errno == EOPNOTSUPP || errno == ENOTTY)) {
>  		if (!quiet)
>  			fprintf(stderr,
> -- 
> 2.17.2
> 
