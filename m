Received: from mail-pf1-f195.google.com ([209.85.210.195]:40750 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfBJJZp (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 10 Feb 2019 04:25:45 -0500
Received: by mail-pf1-f195.google.com with SMTP id h1so993203pfo.7
        for <fstests@vger.kernel.org>; Sun, 10 Feb 2019 01:25:44 -0800 (PST)
Date: Sun, 10 Feb 2019 17:25:37 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] fsstress: avoid infinite zero byte reading
Message-ID: <20190210092537.GR2713@desktop>
References: <20190129080916.11529-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129080916.11529-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Jan 29, 2019 at 04:09:16PM +0800, Zorro Lang wrote:
> copyrange_f and splice_f functions use a while loop to read a file,
> it's fine if there's only one fsstress process(and its children),
> but if some third part testing processes remove the file in the
> middle phase of copyrange_f running, copyrange_f maybe always return
> 0, and the while loop can't be end. As below:
> 
> root     47184  xxxxxx S+ ./fsstress -R -d /mnt/scratch -n 10000 -p 20 -v
> root     47187  xxxxxx R+ ./fsstress -d /mnt/scratch -n 10000 -p 20 -v
> root     47199  xxxxxx R+ ./fsstress -d /mnt/scratch -n 10000 -p 20 -v
> root     47314  xxxxxx S+ grep --color=auto fsstress
> ...
> ...
> copy_file_range(3, [372258], 4, [2658770], 71179, 0) = 0
> copy_file_range(3, [372258], 4, [2658770], 71179, 0) = 0
> copy_file_range(3, [372258], 4, [2658770], 71179, 0) = 0
> copy_file_range(3, [372258], 4, [2658770], 71179, 0) = 0
> ...
> ...
> lr-x------. 1 root root 64 Jan 28 11:34 /proc/47187/fd/3 -> '/mnt/scratch/p2/f2 (deleted)'
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  ltp/fsstress.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index c04feb78..68e40ee6 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -2363,8 +2363,9 @@ copyrange_f(
>  	int			v2;
>  	int			fd1;
>  	int			fd2;
> -	size_t			ret;
> +	size_t			ret = 0;
>  	int			e;
> +	int			limit;
>  
>  	/* Load paths */
>  	init_pathname(&fpath1);
> @@ -2446,6 +2447,7 @@ copyrange_f(
>  		off2 %= maxfsize;
>  	} while (stat1.st_ino == stat2.st_ino && llabs(off2 - off1) < len);
>  
> +	limit = 300;
>  	while (len > 0) {
>  		ret = syscall(__NR_copy_file_range, fd1, &off1, fd2, &off2,
>  			      len, 0);
> @@ -2456,6 +2458,15 @@ copyrange_f(
>  			break;
>  		else if (ret > 0)
>  			len -= ret;
> +		else {
> +			/*
> +			 * if copy_file_range always get 0 byte, break from the
> +			 * infinite loop running
> +			 */
> +			limit--;
> +			if (limit <= 0)
> +				break;
> +		}

I think we could just break the while loop if ret == 0, no need to retry
300 times.

>  	}
>  	e = ret < 0 ? errno : 0;
>  	if (v1 || v2) {
> @@ -2790,6 +2801,7 @@ splice_f(int opno, long r)
>  	size_t			bytes;
>  	int			e;
>  	int			filedes[2];
> +	int			limit;
>  
>  	/* Load paths */
>  	init_pathname(&fpath1);
> @@ -2886,6 +2898,7 @@ splice_f(int opno, long r)
>  
>  	bytes = 0;
>  	total = 0;
> +	limit = 300;
>  	while (len > 0) {
>  		/* move to pipe buffer */
>  		ret1 = splice(fd1, &off1, filedes[1], NULL, len, 0);
> @@ -2907,6 +2920,11 @@ splice_f(int opno, long r)
>  
>  		len -= ret1;
>  		total += ret1;
> +		if (ret1 == 0) {
> +			limit--;
> +			if (limit <= 0)
> +				break;
> +		}

Same here, just check ret1 after the 'read' splice and break the loop if
ret1 == 0.

Thanks,
Eryu

>  	}
>  
>  	if (ret1 < 0 || ret2 < 0)
> -- 
> 2.17.2
> 
