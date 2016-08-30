Received: from mx1.redhat.com ([209.132.183.28]:54092 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757255AbcH3D7n (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 29 Aug 2016 23:59:43 -0400
Date: Tue, 30 Aug 2016 11:59:40 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] generic/159: record error value correctly
Message-ID: <20160830035940.GJ27776@eguan.usersys.redhat.com>
References: <20160830035114.13876-1-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160830035114.13876-1-wangxg.fnst@cn.fujitsu.com>
Sender: fstests-owner@vger.kernel.org
To: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Aug 30, 2016 at 11:51:14AM +0800, Wang Xiaoguang wrote:
> This case failed in btrfs, it's because when trying to open an immutable
> file, vfs returns EPERM, not EACCESS, fix this.
> 
> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
> ---
>  tests/generic/159.out | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/159.out b/tests/generic/159.out
> index 92fe33a..3e5e47f 100755
> --- a/tests/generic/159.out
> +++ b/tests/generic/159.out
> @@ -2,4 +2,4 @@ QA output created by 159
>  Format and mount
>  Create the original files
>  Try reflink on immutable files
> -TEST_DIR/test-159/file2: Permission denied
> +TEST_DIR/test-159/file2: Operation not permitted

I think you need to do a filter in the test not change the golden image,
so older kernels won't fail because they still return EACCES on
immutable inodes.

Thanks,
Eryu
