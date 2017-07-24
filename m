Received: from mx1.redhat.com ([209.132.183.28]:36678 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752482AbdGXIaM (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 24 Jul 2017 04:30:12 -0400
Date: Mon, 24 Jul 2017 10:30:09 +0200
From: Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH] generic/421: stop test from hanging on buggy kernels
Message-ID: <20170724083009.jgaxrbbou6ikjvpo@eorzea.usersys.redhat.com>
References: <20170719203551.126851-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170719203551.126851-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Wed, Jul 19, 2017 at 01:35:51PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> On some buggy kernels, the 'find' command in generic/421 encounters a
> "Permission denied" error when trying to search $dir, so it doesn't find
> the file it's supposed to.  This causes 'cat' to read from stdin,
> hanging the test.  Quote the argument to cat to make the test fail right
> away rather than hanging.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Look fine

Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

> ---
>  tests/generic/421 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/421 b/tests/generic/421
> index 1b2f66f9..9ab48d47 100755
> --- a/tests/generic/421
> +++ b/tests/generic/421
> @@ -98,7 +98,7 @@ keyid=$(_revoke_encryption_key $keydesc)
>  # ciphertext on key revocation.  Therefore, the name of the file we're opening
>  # here may be in either plaintext or ciphertext depending on the kernel version,
>  # and ciphertext names are unpredictable anyway, so just use 'find' to find it.
> -cat $(find $dir -type f) > /dev/null
> +cat "$(find $dir -type f)" > /dev/null
>  
>  # Wait for readers to exit
>  touch $tmp.done
> -- 
> 2.14.0.rc0.284.gd933b75aa4-goog
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Carlos
