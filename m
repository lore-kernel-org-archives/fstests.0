Received: from sandeen.net ([63.231.237.45]:51620 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752154AbdI2OoG (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 29 Sep 2017 10:44:06 -0400
Subject: Re: [PATCH] src/nsexec: fix stack pointer alignment exception
References: <20170927055252.12225-1-zlang@redhat.com>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <3480df1f-d1d0-630d-985f-3dfd33e3ab9d@sandeen.net>
Date: Fri, 29 Sep 2017 09:44:05 -0500
MIME-Version: 1.0
In-Reply-To: <20170927055252.12225-1-zlang@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: fstests-owner@vger.kernel.org
To: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
Cc: sandeen@redhat.com
List-ID: <fstests@vger.kernel.org>

On 9/27/17 12:52 AM, Zorro Lang wrote:
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

Does it matter if the __attribute__ goes before or after
the array name (child_stack[])?  I can't quite tell from reading i.e.
https://gcc.gnu.org/onlinedocs/gcc-3.1/gcc/Variable-Attributes.html#Variable%20Attributes
if it does, though most examples I see have the __attribute__ after the variable
name, i.e.

> short array[3] __attribute__ ((aligned));

in the URL above.

-Eric

>  
>  int
>  main(int argc, char *argv[])
> 
