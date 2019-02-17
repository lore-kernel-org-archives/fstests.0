Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:8254 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726124AbfBQWOe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 17 Feb 2019 17:14:34 -0500
Date: Mon, 18 Feb 2019 09:14:30 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] fsstress: avoid infinite zero byte reading
Message-ID: <20190217221430.GB9805@dastard>
References: <20190216072540.26272-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190216072540.26272-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Feb 16, 2019 at 03:25:40PM +0800, Zorro Lang wrote:
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
> 
> V2 remove 300 times loop, just return if get ret == 0
> 
> Thanks,
> Zorro
> 
>  ltp/fsstress.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 25e0c3e2..138f7ecf 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -2363,7 +2363,7 @@ copyrange_f(
>  	int			v2;
>  	int			fd1;
>  	int			fd2;
> -	size_t			ret;
> +	size_t			ret = 0;
>  	int			e;

What's this fix?

>  
>  	/* Load paths */
> @@ -2452,7 +2452,7 @@ copyrange_f(
>  		if (ret < 0) {
>  			if (errno != EAGAIN || tries++ >= 300)
>  				break;
> -		} else if (ret > len)
> +		} else if (ret > len || ret == 0)

Shoul dbe changing the first line, not this one.

-		if (ret < 0) {
+		if (ret <= 0) {

>  			break;
>  		else if (ret > 0)
>  			len -= ret;
> @@ -2908,6 +2908,9 @@ splice_f(int opno, long r)
>  
>  		len -= ret1;
>  		total += ret1;
> +		if (ret1 == 0) {
> +			break;
> +		}

Same thing as above. The checks after the splice() calls should
be changed from "if (ret < 0)" to "if (ret <= 0)". And there's two
splice calls with different error return values that need to be
checked, not one. And there's two checks for ret2, not one. :P

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
