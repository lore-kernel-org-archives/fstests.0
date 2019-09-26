Received: from mx1.redhat.com ([209.132.183.28]:45870 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727038AbfIZOhF (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 26 Sep 2019 10:37:05 -0400
Date: Thu, 26 Sep 2019 10:37:02 -0400
From: Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH v2] ltp/fsx: avoid infinite loop while finding offset2 in
 clone/dedupe/copy range ops
Message-ID: <20190926143702.GF26832@bfoster>
References: <20190824144107.27748-1-guaneryu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190824144107.27748-1-guaneryu@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, Eryu Guan <eguan@linux.alibaba.com>
List-ID: <fstests@vger.kernel.org>

On Sat, Aug 24, 2019 at 10:41:07PM +0800, Eryu Guan wrote:
> From: Eryu Guan <eguan@linux.alibaba.com>
> 
> In CLONE/DEDUPE/COPY RANGE operations, we pick a "offset" and "size"
> first, then find a suitable "offset2" by looping if there's overlap
> (|offset2-offset| < size) or final file size is greater than max
> file size (offset2 + size > maxfilelen).
> 
> But it's possible that there's no such suitable offset2 and we loop
> forever. e.g. block_size = 4096, offset = 0, size = 4096 and
> maxfilelen is a value smaller than 8212 (which could be set via '-l'
> option).
> 
> Fix it by making sure maxfilelen/file_size is big enough to hold
> 'size' bytes from 'offset2', and just skip this operation if not.
> 
> Signed-off-by: Eryu Guan <eguan@linux.alibaba.com>
> ---
> v2:
> - don't use macro with ugly hacks, use an inline function instead
> 
>  ltp/fsx.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/ltp/fsx.c b/ltp/fsx.c
> index 06d08e4e93f3..890666ab6140 100644
> --- a/ltp/fsx.c
> +++ b/ltp/fsx.c
> @@ -1911,6 +1911,15 @@ fail:
>  	return 0;
>  }
>  
> +/* Check if range operations are possible to find a suitable offset */
> +static inline bool check_range(unsigned long op, unsigned long off,
> +			       unsigned long len, unsigned long size)
> +{
> +	bool ret = ((off + len * 2) <= size);

A more self-documenting name than ret would be helpful, though I'd
probably just do something like:

	if ((off + len * 2) > size) {
		log5(op, off, len, -1, FL_SKIPPED);
		return false;
	}
	...
	return true;

> +	if (!ret)
> +		log5(op, off, len, -1, FL_SKIPPED);
> +	return ret;
> +}

Instead of offloading just this check, could we factor out the
associated offset2 loop into this function as well (and probably rename
it)? I.e., this function can return true if it assigned offset2 or false
and let the caller jump out. It could also take an optional max loop
count for the dedupe case.

Brian

>  
>  int
>  test(void)
> @@ -1989,6 +1998,8 @@ test(void)
>  		TRIM_OFF_LEN(offset, size, file_size);
>  		offset = offset & ~(block_size - 1);
>  		size = size & ~(block_size - 1);
> +		if (!check_range(op, offset, size, maxfilelen))
> +			goto out;
>  		do {
>  			offset2 = random();
>  			TRIM_OFF(offset2, maxfilelen);
> @@ -2003,6 +2014,8 @@ test(void)
>  			TRIM_OFF_LEN(offset, size, file_size);
>  			offset = offset & ~(block_size - 1);
>  			size = size & ~(block_size - 1);
> +			if (!check_range(op, offset, size, file_size))
> +				goto out;
>  			do {
>  				if (tries++ >= 30) {
>  					size = 0;
> @@ -2020,6 +2033,8 @@ test(void)
>  		offset -= offset % readbdy;
>  		if (o_direct)
>  			size -= size % readbdy;
> +		if (!check_range(op, offset, size, maxfilelen))
> +			goto out;
>  		do {
>  			offset2 = random();
>  			TRIM_OFF(offset2, maxfilelen);
> -- 
> 2.21.0
> 
