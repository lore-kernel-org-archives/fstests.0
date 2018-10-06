Received: from mail-pf1-f194.google.com ([209.85.210.194]:39261 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726409AbeJFQet (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sat, 6 Oct 2018 12:34:49 -0400
Received: by mail-pf1-f194.google.com with SMTP id c25-v6so5865625pfe.6
        for <fstests@vger.kernel.org>; Sat, 06 Oct 2018 02:32:15 -0700 (PDT)
Date: Sat, 6 Oct 2018 17:32:07 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 1/2] check: recognize f2fs through parameter
Message-ID: <20181006093207.GI17817@desktop>
References: <20180930092653.122684-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180930092653.122684-1-yuchao0@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org
List-ID: <fstests@vger.kernel.org>

On Sun, Sep 30, 2018 at 05:26:52PM +0800, Chao Yu wrote:
> Add a paramenter in check to configure $FSTYP for f2fs.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  check | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/check b/check
> index f3c8021d94b9..a9024094721a 100755
> --- a/check
> +++ b/check
> @@ -59,6 +59,7 @@ check options
>      -pvfs2          test PVFS2
>      -tmpfs              test TMPFS
>      -ubifs              test ubifs
> +    -f2fs		test f2fs
>      -l			line mode diff
>      -udiff		show unified diff (default)
>      -n			show me, do not run tests
> @@ -263,6 +264,7 @@ while [ $# -gt 0 ]; do
>  	-pvfs2)		FSTYP=pvfs2 ;;
>  	-tmpfs)		FSTYP=tmpfs ;;
>  	-ubifs)		FSTYP=ubifs ;;
> +	-f2fs)		FSTYP=f2fs ;;

The test harness should be able to detect the f2fs type from $TEST_DEV.
We add param to set FSTYP only when there's no way to tell the
filesystem type from the device.

Thanks,
Eryu

>  
>  	-g)	group=$2 ; shift ;
>  		GROUP_LIST="$GROUP_LIST ${group//,/ }"
> -- 
> 2.18.0.rc1
> 
