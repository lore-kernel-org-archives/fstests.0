Received: from mx1.redhat.com ([209.132.183.28]:35672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753643AbdLFHfS (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 6 Dec 2017 02:35:18 -0500
Date: Wed, 6 Dec 2017 15:35:16 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH] btrfs/057: Fix test case to work on 64K page size
Message-ID: <20171206073516.GQ2749@eguan.usersys.redhat.com>
References: <1512542745-26243-1-git-send-email-harish@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1512542745-26243-1-git-send-email-harish@linux.vnet.ibm.com>
Sender: fstests-owner@vger.kernel.org
To: Harish <harish@linux.vnet.ibm.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Wed, Dec 06, 2017 at 12:15:45PM +0530, Harish wrote:
> On platforms with a page size greater than 4Kb, at the moment btrfs
> doesn't support a node/leaf size smaller than the page size, but it
> supports a larger one. So use the max supported node size (64Kb) so
> that the test runs on any platform currently supported by Linux.
> 
> Signed-off-by: Harish <harish@linux.vnet.ibm.com>

Looks fine to me. Also cc btrfs list for review.

Thanks,
Eryu

> ---
>  tests/btrfs/057     | 7 +++++--
>  tests/btrfs/057.out | 4 ++--
>  2 files changed, 7 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/btrfs/057 b/tests/btrfs/057
> index 8d35579..06b2be9 100755
> --- a/tests/btrfs/057
> +++ b/tests/btrfs/057
> @@ -48,8 +48,11 @@ _require_scratch
>  
>  rm -f $seqres.full
>  
> -# use small leaf size to get higher btree height.
> -run_check _scratch_mkfs "-b 1g --nodesize 4096"
> +# Currently in btrfs the node/leaf size can not be smaller than the page
> +# size (but it can be greater than the page size). So use the largest
> +# supported node/leaf size (64Kb) so that the test can run on any platform
> +# that Linux supports.
> +run_check _scratch_mkfs "-b 1g --nodesize 65536"
>  
>  # inode cache is saved in the FS tree itself for every
>  # individual FS tree,that affects the sizes reported by qgroup show
> diff --git a/tests/btrfs/057.out b/tests/btrfs/057.out
> index 60cb92d..f2d9e9c 100644
> --- a/tests/btrfs/057.out
> +++ b/tests/btrfs/057.out
> @@ -1,3 +1,3 @@
>  QA output created by 057
> -4096 4096
> -4096 4096
> +65536 65536
> +65536 65536
> -- 
> 2.7.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe fstests" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
