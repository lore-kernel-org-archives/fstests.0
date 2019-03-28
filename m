Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:17335 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726508AbfC1VzZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 28 Mar 2019 17:55:25 -0400
Date: Fri, 29 Mar 2019 08:55:21 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH 5/7] fsstress: allow afsync on directories too
Message-ID: <20190328215521.GN26298@dastard>
References: <20190328185458.29033-1-fdmanana@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190328185458.29033-1-fdmanana@kernel.org>
Sender: fstests-owner@vger.kernel.org
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
List-ID: <fstests@vger.kernel.org>

On Thu, Mar 28, 2019 at 06:54:58PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Currently the afsync function can only be performed against regular files.
> Allow it to operate on directories too, to increase test coverage and allow
> for chances of finding bugs in the filesystem implementation of fsync
> against directories.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  ltp/fsstress.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index ffe78ef7..0fb9e399 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -1767,15 +1767,21 @@ afsync_f(int opno, long r)
>  	struct iocb	iocb;
>  	struct iocb	*iocbs[] = { &iocb };
>  	struct io_event	event;
> +	DIR             *dir = NULL;
>  
>  	init_pathname(&f);
> -	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
> +	if (!get_fname(FT_REGFILE | FT_DIRm, r, &f, NULL, NULL, &v)) {
>  		if (v)
>  			printf("%d/%d: afsync - no filename\n", procid, opno);
>  		free_pathname(&f);
>  		return;
>  	}
>  	fd = open_path(&f, O_WRONLY | O_DIRECT);
> +	if (fd < 0 && errno == EISDIR) {
> +		dir = opendir_path(&f);
> +		if (dir)
> +			fd = dirfd(dir);
> +	}

You've added this pattern to about 5 functions now. Please factor
the whole getname/open thing into a helper that can be used
everywhere....

>  	e = fd < 0 ? errno : 0;
>  	check_cwd();
>  	if (fd < 0) {
> @@ -1783,6 +1789,8 @@ afsync_f(int opno, long r)
>  			printf("%d/%d: afsync - open %s failed %d\n",
>  			       procid, opno, f.path, e);
>  		free_pathname(&f);
> +		if (dir)
> +			closedir(dir);
>  		return;
>  	}
>  
> @@ -1791,24 +1799,24 @@ afsync_f(int opno, long r)
>  		if (v)
>  			printf("%d/%d: afsync - io_submit %s %d\n",
>  			       procid, opno, f.path, e);
> -		free_pathname(&f);
> -		close(fd);
> -		return;
> +		goto out;
>  	}
>  	if ((e = io_getevents(io_ctx, 1, 1, &event, NULL)) != 1) {
>  		if (v)
>  			printf("%d/%d: afsync - io_getevents failed %d\n",
>  			       procid, opno, e);
> -		free_pathname(&f);
> -		close(fd);
> -		return;
> +		goto out;
>  	}
>  
>  	e = event.res2;
>  	if (v)
>  		printf("%d/%d: afsync %s %d\n", procid, opno, f.path, e);
> +out:
>  	free_pathname(&f);
> -	close(fd);
> +	if (dir)
> +		closedir(dir);
> +	else
> +		close(fd);

Same here for close.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
