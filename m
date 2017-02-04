Received: from mx1.redhat.com ([209.132.183.28]:55680 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753413AbdBDDrz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 3 Feb 2017 22:47:55 -0500
Date: Sat, 4 Feb 2017 11:47:52 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic: add shutdown group
Message-ID: <20170204034752.GD1859@eguan.usersys.redhat.com>
References: <20170203230137.25941-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170203230137.25941-1-tytso@mit.edu>
Sender: fstests-owner@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Fri, Feb 03, 2017 at 06:01:37PM -0500, Theodore Ts'o wrote:
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/generic/group | 30 +++++++++++++++---------------
>  1 file changed, 15 insertions(+), 15 deletions(-)

I notice that there're also some xfs tests are doing shutdown, I think
they belong to shutdown group too, e.g.

xfs/051
xfs/079
xfs/121
xfs/181
xfs/212

I can update the patch at commit time if you think it's ok.

Thanks,
Eryu

> 
> diff --git a/tests/generic/group b/tests/generic/group
> index 159d691b..9b06ba72 100644
> --- a/tests/generic/group
> +++ b/tests/generic/group
> @@ -44,20 +44,20 @@
>  039 metadata auto quick
>  040 metadata auto quick
>  041 metadata auto quick
> -042 rw punch zero
> -043 metadata log auto
> -044 metadata log auto
> -045 metadata log auto
> -046 metadata log auto
> -047 metadata rw auto
> -048 metadata rw auto
> -049 metadata rw auto
> -050 mount auto quick
> -051 auto stress log metadata repair
> -052 log auto quick
> +042 shutdown rw punch zero
> +043 shutdown metadata log auto
> +044 shutdown metadata log auto
> +045 shutdown metadata log auto
> +046 shutdown metadata log auto
> +047 shutdown metadata rw auto
> +048 shutdown metadata rw auto
> +049 shutdown metadata rw auto
> +050 shutdown mount auto quick
> +051 shutdown auto stress log metadata repair
> +052 shutdown log auto quick
>  053 acl repair auto quick
> -054 log v2log auto
> -055 log v2log auto quota stress
> +054 shutdown log v2log auto
> +055 shutdown log v2log auto quota stress
>  056 metadata auto quick
>  057 metadata auto quick
>  058 auto quick prealloc punch insert
> @@ -390,11 +390,11 @@
>  385 quota auto quick
>  386 auto quick quota
>  387 auto clone
> -388 auto log metadata
> +388 shutdown auto log metadata
>  389 auto quick acl
>  390 auto freeze stress dangerous
>  391 auto quick rw
> -392 auto quick metadata
> +392 shutdown auto quick metadata
>  393 auto quick rw
>  394 auto quick
>  395 auto quick encrypt
> -- 
> 2.11.0.rc0.7.gbe5a750
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
