Received: from mx1.redhat.com ([209.132.183.28]:34602 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752713AbdFMGym (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 13 Jun 2017 02:54:42 -0400
Date: Tue, 13 Jun 2017 14:54:38 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/397: be compatible with ignored SIGPIPE
Message-ID: <20170613065438.GA4788@eguan.usersys.redhat.com>
References: <20170612211528.45666-1-ebiggers3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170612211528.45666-1-ebiggers3@gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Eric Biggers <ebiggers3@gmail.com>
Cc: fstests@vger.kernel.org, Eric Biggers <ebiggers@google.com>
List-ID: <fstests@vger.kernel.org>

On Mon, Jun 12, 2017 at 02:15:28PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> If generic/397 is executed in an environment with SIGPIPE ignored, it
> fails because the 'yes' program prints an error message:
> 
>     yes: standard output: Broken pipe
>     yes: write error
> 
> This can be reproduced with:
> 
>     trap '' SIGPIPE; ./check generic/397
> 
> Fix it by generating the string of 255 y's using just 'head' and 'tr'
> instead of 'yes', 'head', and 'tr'.
> 
> Although it's not really a good idea to execute xfstests with SIGPIPE
> ignored, this is the only test I've noticed where it causes a problem,
> so it might as well be fixed in the test.

I'm just curious, why do you need to run fstests with SIGPIPE ignored?

> 
> It would be much nicer to prevent this problem for all tests by making
> the 'check' script restore the default SIGPIPE handler.  But that isn't
> straightforward because bash's 'trap' builtin doesn't allow un-ignoring
> signals that were ignored on entry to the shell.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  tests/generic/397 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/397 b/tests/generic/397
> index 7077d048..ba920891 100755
> --- a/tests/generic/397
> +++ b/tests/generic/397
> @@ -69,7 +69,7 @@ for dir in $SCRATCH_MNT/edir $SCRATCH_MNT/ref_dir; do
>  	touch $dir/empty > /dev/null
>  	$XFS_IO_PROG -t -f -c "pwrite 0 4k" $dir/a > /dev/null
>  	$XFS_IO_PROG -t -f -c "pwrite 0 33k" $dir/abcdefghijklmnopqrstuvwxyz > /dev/null
> -	maxname=$(yes | head -255 | tr -d '\n') # 255 character filename
> +	maxname=$(head -c 255 /dev/zero | tr '\0' y) # 255 character filename

Using perl seems simpler, we have some other tests do similar tasks
using perl too.

	maxname=$($PERL_PROG -e 'print "y" x 255;')

Thanks,
Eryu

>  	$XFS_IO_PROG -t -f -c "pwrite 0 1k" $dir/$maxname > /dev/null
>  	ln -s a $dir/symlink
>  	ln -s abcdefghijklmnopqrstuvwxyz $dir/symlink2
> -- 
> 2.13.1.508.gb3defc5cc-goog
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
