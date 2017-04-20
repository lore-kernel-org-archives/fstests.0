Received: from sandeen.net ([63.231.237.45]:38724 "EHLO sandeen.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937876AbdDTA1i (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 19 Apr 2017 20:27:38 -0400
Subject: Re: [PATCH] generic: fix statx definition for non-x86 architecture
References: <20170419235453.8237-1-gwendal@chromium.org>
From: Eric Sandeen <sandeen@sandeen.net>
Message-ID: <2d3170ce-77ce-c33f-a7a8-b681d1da92db@sandeen.net>
Date: Wed, 19 Apr 2017 19:27:36 -0500
MIME-Version: 1.0
In-Reply-To: <20170419235453.8237-1-gwendal@chromium.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>, dhowells@redhat.com, eguan@redhat.com
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 4/19/17 6:54 PM, Gwendal Grignou wrote:
> Fix a compilation error for ARM:
> __ILP32__ is defined but not __X32_SYSCALL_BIT.
> 
> The check should only apply for x86_64 architecture, statx for other
> architectures is not implemented yet - see commit 7acc839c9e57
> "statx: Add a system call to make enhanced file info available".
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

probably needs fixing in xfs_io too, thanks.

-Eric

> ---
>  src/statx.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/src/statx.h b/src/statx.h
> index b491c018..5d58208a 100644
> --- a/src/statx.h
> +++ b/src/statx.h
> @@ -19,10 +19,12 @@
>  #ifndef __NR_statx
>  # ifdef __i386__
>  #  define __NR_statx 383
> -# elif defined (__ILP32__)
> -#  define __NR_statx (__X32_SYSCALL_BIT + 332)
>  # elif defined(__x86_64__)
> -#  define __NR_statx 332
> +#  if defined (__ILP32__)
> +#   define __NR_statx (__X32_SYSCALL_BIT + 332)
> +#  else
> +#   define __NR_statx 332
> +#  endif
>  # endif
>  #endif
>  
> 
