Received: from mx1.redhat.com ([209.132.183.28]:38040 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752176AbdFSJwF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 19 Jun 2017 05:52:05 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 99D1880C09
        for <fstests@vger.kernel.org>; Mon, 19 Jun 2017 09:52:04 +0000 (UTC)
Received: from localhost (unknown [10.66.12.196])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1DEAE895AC
        for <fstests@vger.kernel.org>; Mon, 19 Jun 2017 09:52:03 +0000 (UTC)
Date: Mon, 19 Jun 2017 17:52:03 +0800
From: Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH 3/4] fsstress: do memset randomly before write operations
Message-ID: <20170619095202.GO20784@dhcp12-143.nay.redhat.com>
References: <1497629466-22647-1-git-send-email-zlang@redhat.com>
 <1497629466-22647-3-git-send-email-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1497629466-22647-3-git-send-email-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Jun 17, 2017 at 12:11:05AM +0800, Zorro Lang wrote:
> Recently we found a bug by trigger a page fault when io-vector of
> writev is in processing. If do memset between malloc() and write
> operations, memset will init the pages. So do memset randomly
> maybe help to cover above situation.
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  ltp/fsstress.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index 4ff90d5..e1b73e4 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -1924,7 +1924,8 @@ do_aio_rw(int opno, long r, int flags)
>  		off = (off64_t)(lr % MIN(stb.st_size + (1024 * 1024), MAXFSIZE));
>  		off -= (off % align);
>  		off %= maxfsize;
> -		memset(buf, nameseq & 0xff, len);
> +		/* randomly memset maybe trigger page fault at write time */
> +		if (random() / 2) memset(buf, nameseq & 0xff, len);

Sorry for my mistake, all "(random() / 2)" should be "random() % 2".

Thanks,
Zorro

>  		io_prep_pwrite(&iocb, fd, buf, len, off);
>  	} else {
>  		off = (off64_t)(lr % stb.st_size);
> @@ -2455,7 +2456,8 @@ dwrite_f(int opno, long r)
>  	buf = memalign(diob.d_mem, len);
>  	off %= maxfsize;
>  	lseek64(fd, off, SEEK_SET);
> -	memset(buf, nameseq & 0xff, len);
> +	/* randomly memset maybe trigger page fault at write time */
> +	if (random() / 2) memset(buf, nameseq & 0xff, len);
>  	e = write(fd, buf, len) < 0 ? errno : 0;
>  	free(buf);
>  	if (v)
> @@ -3672,7 +3674,8 @@ write_f(int opno, long r)
>  	lseek64(fd, off, SEEK_SET);
>  	len = (random() % FILELEN_MAX) + 1;
>  	buf = malloc(len);
> -	memset(buf, nameseq & 0xff, len);
> +	/* randomly memset maybe trigger page fault at write time */
> +	if (random() / 2) memset(buf, nameseq & 0xff, len);
>  	e = write(fd, buf, len) < 0 ? errno : 0;
>  	free(buf);
>  	if (v)
> @@ -3733,7 +3736,8 @@ writev_f(int opno, long r)
>  	lseek64(fd, off, SEEK_SET);
>  	len = (random() % FILELEN_MAX) + 1;
>  	buf = malloc(len);
> -	memset(buf, nameseq & 0xff, len);
> +	/* randomly memset maybe trigger page fault at write time */
> +	if (random() / 2) memset(buf, nameseq & 0xff, len);
>  
>  	iovcnt = (random() % MIN(len, IOV_MAX)) + 1;
>  	iov = malloc(sizeof(struct iovec) * iovcnt);
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
