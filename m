Received: from aserp2130.oracle.com ([141.146.126.79]:59750 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752743AbeBESfN (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 5 Feb 2018 13:35:13 -0500
Date: Mon, 5 Feb 2018 10:35:07 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: Failing scratch mounts
Message-ID: <20180205183507.GC4844@magnolia>
References: <CAHc6FU7s_zjwCWMAWymk2oYa-JduuXObw68nD3F5nKz9X-LRGQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc6FU7s_zjwCWMAWymk2oYa-JduuXObw68nD3F5nKz9X-LRGQ@mail.gmail.com>
Sender: fstests-owner@vger.kernel.org
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Sat, Feb 03, 2018 at 07:58:46PM +0100, Andreas Gruenbacher wrote:
> Hi,
> 
> we have many fstests that call _scratch_mount without checking if the
> mount was successful. When the mount fails, the tests then write to
> the underlying filesystem. Here's a list of fstests that do this for
> gfs2:
> 
>   generic/029 generic/030 generic/032 generic/037 generic/053 generic/069
>   generic/071 generic/084 generic/094 generic/098 generic/103 generic/105
>   generic/109 generic/129 generic/130 generic/132 generic/162 generic/163
>   generic/169 generic/204 generic/225 generic/231 generic/232 generic/233
>   generic/235 generic/256 generic/294 generic/306 generic/319 generic/320
>   generic/337 generic/361 generic/374 generic/377 generic/380 generic/390
>   generic/401 generic/403 generic/412 generic/416 generic/422 generic/427
>   generic/439 generic/449 generic/452 generic/453 generic/454 generic/460
>   generic/464 generic/476
> 
> This is after fixing generic/270 which even fills up the scratch mount
> point completely.
> 
> Since _scratch_mount is mostly used without checking for success, can
> we change it to _fail by default, and introduce _try_check_mount or
> similar for those few cases where we don't want to fail implicitly?

I don't have a problem with that.

--D

> 
> Thanks,
> Andreas
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
