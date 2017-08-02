Received: from mx1.redhat.com ([209.132.183.28]:38446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751662AbdHBCbd (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 1 Aug 2017 22:31:33 -0400
Date: Wed, 2 Aug 2017 10:31:28 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] xfs/073: don't follow symbolic link when comparing the
 directories
Message-ID: <20170802023128.GQ9167@eguan.usersys.redhat.com>
References: <1501590018-19013-1-git-send-email-houtao1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501590018-19013-1-git-send-email-houtao1@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: Hou Tao <houtao1@huawei.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 01, 2017 at 08:20:18PM +0800, Hou Tao wrote:
> When there is a broken symbolic link file under $here directory,
> the diff between the source directory and the target directory will
> output something like: "diff: /path/xxx/yyy: No such file or directory",
> and the test case will fail.
> 
> To fix it, we should use "--no-dereference" option of diff command to
> only compare the values of the symbolic links.
> 
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  tests/xfs/073 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/073 b/tests/xfs/073
> index 7228dd9..ddd462b 100755
> --- a/tests/xfs/073
> +++ b/tests/xfs/073
> @@ -98,7 +98,7 @@ _verify_copy()
>  	fi
>  
>  	echo comparing new image files to old
> -	diff -Naur $source_dir $target_dir
> +	diff -Naur --no-dereference $source_dir $target_dir

Hmm, diff shipped by RHEL6 doesn't know this option. I think another
option would be removing any broken symlinks in $source_dir after
copying files to it, e.g.

find $imgs.source_dir -type l -exec test ! {} \; -exec rm -f {} \;

Thanks,
Eryu

>  
>  	echo comparing new image directories to old
>  	find $source_dir | _filter_path $source_dir > $tmp.manifest1
> -- 
> 2.5.0
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
