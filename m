Received: from mail-pl1-f196.google.com ([209.85.214.196]:44619 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405791AbfIYNIQ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 Sep 2019 09:08:16 -0400
Received: by mail-pl1-f196.google.com with SMTP id q15so2388388pll.11
        for <fstests@vger.kernel.org>; Wed, 25 Sep 2019 06:08:16 -0700 (PDT)
Date: Wed, 25 Sep 2019 21:08:09 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] fsx: add more check for copy_file_range
Message-ID: <20190925130809.GT2622@desktop>
References: <1569395815-4657-1-git-send-email-suyj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1569395815-4657-1-git-send-email-suyj.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 25, 2019 at 03:16:55PM +0800, Su Yanjun wrote:
> On some linux distros(RHEL7, centos 7) copy_file_range uses
> general implementation (splice interface). splice interace
> uses pipe_to_file. pipe_to_file only work for different page.
> The userspace cant's be  aware of such error because copy_file_range
> returns ok too.

This looks like a kernel bug to me.

> So for such case when copy_file_range return we read back data
> then check it.

Yeah, I think we should make sure the data copied is correct.

> 
> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>
> ---
>  ltp/fsx.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 06d08e4..0439430 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -1602,6 +1602,7 @@ do_copy_range(unsigned offset, unsigned length, unsigned dest)
>  	size_t olen;
>  	ssize_t nr;
>  	int tries = 0;
> +	int ret = 0;
>  
>  	if (length == 0) {
>  		if (!quiet && testcalls > simulatedopcount)
> @@ -1665,6 +1666,37 @@ do_copy_range(unsigned offset, unsigned length, unsigned dest)
>  		memset(good_buf + file_size, '\0', dest - file_size);
>  	if (dest + length > file_size)
>  		file_size = dest + length;
> +	/*
> +	 * Although copy_file_range returns ok 
> +	 * for some linux distros that use general implementation 
> +	 * (splice interface) such as RHEL 7, centos 7 that use 
> +	 * pipe_to_file will cause test fail.
> +	 *
> +	 * Here we add a little more check here for copy_file_range
> +	 * We read copied data then check it. If check fail here 
> +	 * then report it.
> +	 */

Above comments seem like not necessary, the content check is inspired by
Rthis HEL7 issue, but not the main purpose.

> +	ret = lseek(fd, (off_t)dest, SEEK_SET);
> +	if (ret == (off_t)-1) {
> +		prterr("doread: lseek");
                        ^^^^^^^ not doread

> +		report_failure(140);

Use a different failure number than that in doread, i.e. don't copy the
code from doread.

> +	}
> +	ret = fsxread(fd, temp_buf, length, dest);
> +	if (ret != length) {
> +		if (ret == -1)
> +				prterr("doread: read");
> +		else
> +				prt("short read: 0x%x bytes instead of 0x%x\n",
> +					ret, length);

Same here, not doread, and weired indention above.

> +		report_failure(141);
> +	}
> +	if (memcmp(good_buf+dest, temp_buf, length) != 0) {
> +		prt("copy range: 0x%x to 0x%x at 0x%x\n", offset,
> +				offset + length, dest);
> +		prterr("do_copy_range:");
> +		report_failure(161);

I think we could take use of check_buffers().

And similar check could be added to do_clone_range as well, I think.

Thanks,
Eryu

> +
> +	}
>  }
>  
>  #else
> -- 
> 2.7.4
> 
> 
> 
