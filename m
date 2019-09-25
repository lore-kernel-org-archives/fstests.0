Received: from mail-pg1-f193.google.com ([209.85.215.193]:39290 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbfIYJrb (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 25 Sep 2019 05:47:31 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so2899763pgi.6
        for <fstests@vger.kernel.org>; Wed, 25 Sep 2019 02:47:30 -0700 (PDT)
Date: Wed, 25 Sep 2019 17:47:24 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] generic/465: fix a read bug when encounter EOF
Message-ID: <20190925094720.GS2622@desktop>
References: <1568611466-100970-1-git-send-email-suyj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568611466-100970-1-git-send-email-suyj.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Su Yanjun <suyj.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 16, 2019 at 01:24:26PM +0800, Su Yanjun wrote:
> In nfs test, if the writer has not written enough data for reader reading,
> then reader only get partial data and test fails.
> 
> We can continue reading until read enough data.
> 
> Signed-off-by: Su Yanjun <suyj.fnst@cn.fujitsu.com>

Would you please provide more info on the actual failure you've seen? I
think the partial read issue should have been addressed by commit
2428c08a6025 ("generic/465: just check the actual read data under dio
read/write")

Thanks,
Eryu

> ---
>  src/aio-dio-regress/aio-dio-append-write-read-race.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/src/aio-dio-regress/aio-dio-append-write-read-race.c b/src/aio-dio-regress/aio-dio-append-write-read-race.c
> index 911f272..f28ef3c 100644
> --- a/src/aio-dio-regress/aio-dio-append-write-read-race.c
> +++ b/src/aio-dio-regress/aio-dio-append-write-read-race.c
> @@ -44,14 +44,27 @@ static void usage(const char *prog)
>  static void *reader(void *arg)
>  {
>  	struct io_data *data = (struct io_data *)arg;
> +	size_t blksize = data->blksize;
> +	size_t offset = data->offset;
> +	char   *buf = data->buf;
>  
>  	memset(data->buf, 'b', data->blksize);
>  	reader_ready = 1;
>  	do {
> -		data->read_sz = pread(data->fd, data->buf, data->blksize,
> -				      data->offset);
> +		data->read_sz = pread(data->fd, buf, blksize,
> +				      offset);
>  		if (data->read_sz < 0)
>  			perror("read file");
> +
> +		if (data->read_sz > 0) {
> +			blksize -= data->read_sz;
> +			offset  += data->read_sz;
> +			buf	+= data->read_sz;
> +			data->read_sz = 0;
> +		}
> +
> +		if (blksize <= 0)
> +			break;
>  	} while (data->read_sz <= 0);
>  
>  	return NULL;
> -- 
> 2.7.4
> 
> 
> 
