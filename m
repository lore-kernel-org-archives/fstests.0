Received: from mx1.redhat.com ([209.132.183.28]:35034 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753538AbdBDESu (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 3 Feb 2017 23:18:50 -0500
Date: Sat, 4 Feb 2017 12:18:48 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/074: _cleanup potentially removes local FS files
Message-ID: <20170204041848.GG1859@eguan.usersys.redhat.com>
References: <20170129135620.25464-1-omzg@plexistor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170129135620.25464-1-omzg@plexistor.com>
Sender: fstests-owner@vger.kernel.org
To: Omer Zilberberg <omzg@plexistor.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Jan 29, 2017 at 03:56:20PM +0200, Omer Zilberberg wrote:
> fstest_dir is set after _cleanup() is defined and _require_test is
> called. If _require_test fails (due to some unrelated bug in tested FS),
> _cleanup will attempt to remove $fstest_dir.*, which expands to .*
> This has the unfortunate effect of removing xfstests' .git and
> .gitignore.
> 
> Here is the 074.out.bad file for this case:
> QA output created by 074
> mount: permission denied
> common/rc: retrying test device mount with external set
> mount: permission denied
> common/rc: could not mount /dev/pmem0 on /mnt
> rm: refusing to remove '.' or '..' directory: skipping '.'
> rm: refusing to remove '.' or '..' directory: skipping '..'
> ----
> 
> The only other test which could face the same problem is generic/285.
> However, that test defines _cleanup after the _require* calls, and so on
> _require_test failure, 285.out.bad contains the harmless:
> ./common/rc: line 1: _cleanup: command not found

How about defining fstest_dir before _cleanup function? Along with
"here" and "tmp", which looks clearer and makes more sense to me.

Thanks,
Eryu

> 
> Signed-off-by: Omer Zilberberg <omzg@plexistor.com>
> ---
>  tests/generic/074 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/074 b/tests/generic/074
> index 55264bd..ef84263 100755
> --- a/tests/generic/074
> +++ b/tests/generic/074
> @@ -33,7 +33,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
>  
>  _cleanup()
>  {
> -    rm -rf $fstest_dir.* $tmp.*
> +    [ -n "$fstest_dir" ] && rm -rf $fstest_dir.*
> +    rm -rf $tmp.*
>  }
>  
>  # get standard environment, filters and checks
> -- 
> 2.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
