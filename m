Received: from cn.fujitsu.com ([59.151.112.132]:8878 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751411AbdDLBfH (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 11 Apr 2017 21:35:07 -0400
Subject: Re: [PATCH] fstests: introduce btrfs-map-logical
References: <1491960463-28680-1-git-send-email-bo.li.liu@oracle.com>
From: Qu Wenruo <quwenruo@cn.fujitsu.com>
Message-ID: <5d7f7d05-b7af-5d8d-93f6-0db2db4ade85@cn.fujitsu.com>
Date: Wed, 12 Apr 2017 09:35:00 +0800
MIME-Version: 1.0
In-Reply-To: <1491960463-28680-1-git-send-email-bo.li.liu@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Liu Bo <bo.li.liu@oracle.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



At 04/12/2017 09:27 AM, Liu Bo wrote:
> A typical use case of 'btrfs-map-logical' is to translate btrfs logical
> address to physical address on each disk.

Could we avoid usage of btrfs-map-logical here?

I understand that we need to do corruption so that we can test if the 
repair works, but I'm not sure if the output format will change, or if 
the program will get replace by "btrfs inspect-internal" group.

Thanks,
Qu

> 
> Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
> ---
>   common/config | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/common/config b/common/config
> index 59041a3..b7c06bf 100644
> --- a/common/config
> +++ b/common/config
> @@ -249,6 +249,7 @@ case "$HOSTOS" in
>           export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
>           export BTRFS_SHOW_SUPER_PROG="`set_prog_path btrfs-show-super`"
>   	export BTRFS_CONVERT_PROG="`set_prog_path btrfs-convert`"
> +	export BTRFS_MAP_LOGICAL_PROG="`set_prog_path btrfs-map-logical`"
>           export XFS_FSR_PROG="`set_prog_path xfs_fsr`"
>           export MKFS_NFS_PROG="false"
>           export MKFS_CIFS_PROG="false"
> 


