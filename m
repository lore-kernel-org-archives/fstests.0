Received: from mail-wm0-f51.google.com ([74.125.82.51]:50091 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751800AbdI0KBO (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 27 Sep 2017 06:01:14 -0400
Received: by mail-wm0-f51.google.com with SMTP id r74so16212889wme.4
        for <fstests@vger.kernel.org>; Wed, 27 Sep 2017 03:01:13 -0700 (PDT)
Date: Wed, 27 Sep 2017 12:01:10 +0200
From: Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH] src/nsexec: fix stack pointer alignment exception
Message-ID: <20170927100110.rfhl3hjqek4z2q6z@hades.localdomain>
References: <20170927055252.12225-1-zlang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170927055252.12225-1-zlang@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>
Cc: fstests@vger.kernel.org, sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>

On Wed, Sep 27, 2017 at 05:52:52AM +0000, Zorro Lang wrote:
> When test g/317 or g/318 on ARM server, we got a kernel exception:
> 
>   kernel: nsexec[8203]: SP Alignment exception: pc=00000000004010a0 sp=00000000005200e8
> 
> nsexec gives an unaligned child stack address to clone() system
> call sometimes. For making sure it's always aligned, use
> "__attribute__((aligned))" extension of GCC (Thanks this suggestion
> from Eric sandeen).
> 
> Signed-off-by: Zorro Lang <zlang@redhat.com>
> ---
>  src/nsexec.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/src/nsexec.c b/src/nsexec.c
> index f033b1a4..205dd081 100644
> --- a/src/nsexec.c
> +++ b/src/nsexec.c
> @@ -138,7 +138,8 @@ childFunc(void *arg)
>  
>  #define STACK_SIZE (1024 * 1024)
>  
> -static char child_stack[STACK_SIZE];    /* Space for child's stack */
> +/* Space for child's stack */
> +static char __attribute__((aligned)) child_stack[STACK_SIZE];

I don't really think the comment is necessary, other than that:

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

>  
>  int
>  main(int argc, char *argv[])
> -- 
> 2.13.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Carlos
