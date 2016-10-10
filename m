Received: from userp1050.oracle.com ([156.151.31.82]:29967 "EHLO
        userp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750717AbcJJJDX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 10 Oct 2016 05:03:23 -0400
Subject: Re: [PATCH] generic/175: disable inline data feature for btrfs
References: <20161010050647.30262-1-wangxg.fnst@cn.fujitsu.com>
From: Anand Jain <anand.jain@oracle.com>
Message-ID: <b0db2215-ee06-0dc6-51de-2dc096943b03@oracle.com>
Date: Mon, 10 Oct 2016 17:03:49 +0800
MIME-Version: 1.0
In-Reply-To: <20161010050647.30262-1-wangxg.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 10/10/16 13:06, Wang Xiaoguang wrote:
> For btrfs, if compression is enabled, it may generate inline data for a
> blocksize data range, this inline data is stored in fs tree, will not have
> a individual extent, try to reflink this data range at a not-zero offset
> will return EOPNOTSUPP, so here we disable inline data feature for btrfs.

  Hm. I didn't get the point of why its not a btrfs bug ?

Thanks, Anand


> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
> ---
>  tests/generic/175 | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tests/generic/175 b/tests/generic/175
> index 964580c..b3f90dc 100755
> --- a/tests/generic/175
> +++ b/tests/generic/175
> @@ -50,6 +50,13 @@ rm -f "$seqres.full"
>
>  echo "Format and mount"
>  _scratch_mkfs > "$seqres.full" 2>&1
> +# For btrfs, if compression is enabled, it may generate inline data for a
> +# blocksize data range, this inline data is stored in fs tree, will not have
> +# a individual extent, try to reflink this data range at a not-zero offset
> +# will return EOPNOTSUPP, so here we disable inline data feature for btrfs.
> +if [ "$FSTYP" = "btrfs" ]; then
> +	export MOUNT_OPTIONS="-o max_inline=0 $MOUNT_OPTIONS"
> +fi
>  _scratch_mount >> "$seqres.full" 2>&1
>
>  testdir="$SCRATCH_MNT/test-$seq"
>
