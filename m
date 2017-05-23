Received: from userp1040.oracle.com ([156.151.31.81]:20720 "EHLO
        userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932968AbdEWDSy (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 22 May 2017 23:18:54 -0400
Date: Mon, 22 May 2017 20:18:41 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: [PATCH] stat_test: Fix stx_attributes check
Message-ID: <20170523031841.GJ4521@birch.djwong.org>
References: <1495317973-24072-1-git-send-email-richard@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1495317973-24072-1-git-send-email-richard@nod.at>
Sender: fstests-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>
Cc: fstests@vger.kernel.org, dhowells@redhat.com, amir73il@gmail.com, eguan@redhat.com
List-ID: <fstests@vger.kernel.org>

On Sun, May 21, 2017 at 12:06:13AM +0200, Richard Weinberger wrote:
> I found that this test succeeds on UBIFS:
> stat_test /mnt/foo attr=+compressed attr=-compressed
> 
> Since stx_attributes can hold many flags, check the flags
> correctly with the & operator.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>

Looks ok to /me/...
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  src/stat_test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/stat_test.c b/src/stat_test.c
> index 3dc44bbdb71d..fc87ed5c6e8f 100644
> --- a/src/stat_test.c
> +++ b/src/stat_test.c
> @@ -621,10 +621,10 @@ static void check_attribute(const struct statx *stx, char *arg)
>  
>  	attr = p->attr_flag;
>  	if (set) {
> -		check(stx->stx_attributes && attr,
> +		check((stx->stx_attributes & attr) == attr,
>  		      "Attribute %s should be set\n", arg);
>  	} else {
> -		check(~stx->stx_attributes && attr,
> +		check((stx->stx_attributes & attr) == 0,
>  		      "Attribute %s should be unset\n", arg);
>  	}
>  }
> -- 
> 2.7.3
> 
