Received: from mx1.redhat.com ([209.132.183.28]:55034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbeHJCnj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 9 Aug 2018 22:43:39 -0400
Subject: Re: [PATCH] generic/228: fix restoration of kernel.core_pattern
 sysctl
References: <83cc171697f79477991c501939dcda146aa7ba3b.1533850682.git.osandov@fb.com>
From: Eric Sandeen <sandeen@redhat.com>
Message-ID: <c2927c55-432d-414d-9b66-f00448447fa6@redhat.com>
Date: Thu, 9 Aug 2018 19:16:20 -0500
MIME-Version: 1.0
In-Reply-To: <83cc171697f79477991c501939dcda146aa7ba3b.1533850682.git.osandov@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Omar Sandoval <osandov@osandov.com>, fstests@vger.kernel.org
Cc: kernel-team@fb.com
List-ID: <fstests@vger.kernel.org>

On 8/9/18 4:40 PM, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> generic/228 changes kernel.core_pattern, so it saves it beforehand in
> order to restore it. However, it adds an extra space in the process:
> 
> $ echo \"$(sysctl kernel.core_pattern | awk -F = '{print $NF}')\"
> " |/usr/lib/systemd/systemd-coredump %P %u %g %s %t %c %h %e"
> 
> Instead of using awk, just use sysctl -n to only print the value.

Oh, was that my fault?  Seems like something that would be my fault.
It'd have worked w/o "-F =" too but yours is better as long as sysctl -n
isn't new?  Works on my old RHEL6 box.  :)

Reviewed-by: Eric Sandeen <sandeen@redhat.com>

> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  tests/generic/228 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/228 b/tests/generic/228
> index fd022313..16178c33 100755
> --- a/tests/generic/228
> +++ b/tests/generic/228
> @@ -45,7 +45,7 @@ avail=`df -P $TEST_DIR | awk 'END {print $4}'`
>  [ "$avail" -ge 104000 ] || _notrun "Test device is too small ($avail KiB)"
>  
>  # Suppress core dumped messages
> -core_pattern=`sysctl kernel.core_pattern | awk -F = '{print $NF}'`
> +core_pattern=`sysctl -n kernel.core_pattern`
>  ulimit_c=`ulimit -c`
>  sysctl -w kernel.core_pattern=core &>/dev/null
>  ulimit -c 0
> 
