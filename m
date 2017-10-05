Received: from bombadil.infradead.org ([65.50.211.133]:46581 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbdJETs0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 5 Oct 2017 15:48:26 -0400
Date: Thu, 5 Oct 2017 12:48:26 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 3/4] holetest: Fix comparison of unsigned integer with 0
Message-ID: <20171005194826.GB21115@infradead.org>
References: <1507207800-5688-1-git-send-email-rostislav@tuxera.com>
 <1507207800-5688-3-git-send-email-rostislav@tuxera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1507207800-5688-3-git-send-email-rostislav@tuxera.com>
Sender: fstests-owner@vger.kernel.org
To: Rostislav Skudnov <rostislav@tuxera.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Thu, Oct 05, 2017 at 12:49:59PM +0000, Rostislav Skudnov wrote:
> ---
>  src/holetest.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/holetest.c b/src/holetest.c
> index 1939b35..e7ba123 100644
> --- a/src/holetest.c
> +++ b/src/holetest.c
> @@ -205,7 +205,7 @@ int test_this(int fd, loff_t sz)
>  			 */
>  			fflush(stdout);
>  			tid[i] = fork();
> -			if (tid[i] < 0) {
> +			if ((int64_t)tid[i] < 0) {

Just use the proper type for the return.  But I think this whole
file needs a redo - it tries to use tid both for storing a fork
return value and a pthread_t pointer.  If you only want a minimal
fix just introduce a int ret local variable.
