Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:49920 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730918AbfHWH10 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 23 Aug 2019 03:27:26 -0400
Date: Fri, 23 Aug 2019 15:27:23 +0800
From: Eryu Guan <eguan@linux.alibaba.com>
Subject: Re: [PATCH] ltp/fsx: avoid infinite loop while finding offset2 in
 clone/dedupe/copy range ops
Message-ID: <20190823072723.GT52397@e18g06458.et15sqa>
References: <20190823072259.56671-1-eguan@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190823072259.56671-1-eguan@linux.alibaba.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: "Darrick J. Wong" <darrick.wong@oracle.com>
List-ID: <fstests@vger.kernel.org>

On Fri, Aug 23, 2019 at 03:22:59PM +0800, Eryu Guan wrote:
> In CLONE/DEDUPE/COPY RANGE operations, we pick a "offset" and "size"
> first, then find a suitable "offset2" by looping if there's overlap
> (|offset2-offset| < size) or final file size is greater than max file
> size (offset2 + size > maxfilelen).
> 
> But it's possible that there's no such suitable offset2 and we loop
> forever. e.g. block_size = 4096, offset = 0, size = 4096 and maxfilelen
> is a value smaller than 8212 (which could be set via '-l' option).
                          ^^^^ should be 8192

Thanks,
Eryu

> 
> Fix it by making sure maxfilelen/file_size is big enough to hold 'size'
> bytes from 'offset2', and just skip this operation if not.
> 
> Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
> ---
>  ltp/fsx.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 06d08e4e93f3..f6eb3308e8bc 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -1825,6 +1825,14 @@ do {						\
>  	TRIM_LEN(off, len, size);		\
>  } while (0)
>  
> +#define CHECK_RANGE(off, len, size)		\
> +do {						\
> +	if ((off + len * 2) > size) {		\
> +		log5(op, offset, size, -1, FL_SKIPPED); \
> +		goto out;			\
> +	}					\
> +} while (0)
> +
>  void
>  cleanup(int sig)
>  {
> @@ -1989,6 +1997,7 @@ test(void)
>  		TRIM_OFF_LEN(offset, size, file_size);
>  		offset = offset & ~(block_size - 1);
>  		size = size & ~(block_size - 1);
> +		CHECK_RANGE(offset, size, maxfilelen);
>  		do {
>  			offset2 = random();
>  			TRIM_OFF(offset2, maxfilelen);
> @@ -2003,6 +2012,7 @@ test(void)
>  			TRIM_OFF_LEN(offset, size, file_size);
>  			offset = offset & ~(block_size - 1);
>  			size = size & ~(block_size - 1);
> +			CHECK_RANGE(offset, size, file_size);
>  			do {
>  				if (tries++ >= 30) {
>  					size = 0;
> @@ -2020,6 +2030,7 @@ test(void)
>  		offset -= offset % readbdy;
>  		if (o_direct)
>  			size -= size % readbdy;
> +		CHECK_RANGE(offset, size, maxfilelen);
>  		do {
>  			offset2 = random();
>  			TRIM_OFF(offset2, maxfilelen);
> -- 
> 2.14.4.44.g2045bb6
