Received: from mail.kernel.org ([198.145.29.99]:49202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbfBTDMK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 19 Feb 2019 22:12:10 -0500
Date: Tue, 19 Feb 2019 19:12:07 -0800
From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 1/5] commom/rc: define function _get_max_file_size
Message-ID: <20190220031206.GA672@sol.localdomain>
References: <20190220015955.26342-1-yuyufen@huawei.com>
 <20190220015955.26342-2-yuyufen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220015955.26342-2-yuyufen@huawei.com>
Sender: fstests-owner@vger.kernel.org
To: Yufen Yu <yuyufen@huawei.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hi Yufen,

On Wed, Feb 20, 2019 at 09:59:51AM +0800, Yufen Yu wrote:
> Define a new function _get_max_file_size to return
> the max file size supported by the special filesystem.
> 
> Signed-off-by: Yufen Yu <yuyufen@huawei.com>
> ---
>  common/rc | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index e5da6484..10ab497d 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -3785,6 +3785,29 @@ _require_scratch_feature()
>  	esac
>  }
>  
> +# get filesystem max file size
> +_get_max_file_size()
> +{
> +	case $FSTYP in
> +	vfat|jffs2|romfs)
> +		echo $((2**32-1)) # 0xFFFFFFFF
> +		;;
> +	*) # MAX_LFS_FILESIZE
> +		case "$(getconf LONG_BIT)" in
> +		"32")
> +			echo $(( ($(getconf PAGE_SIZE) << ($(getconf LONG_BIT) - 1) ) - 1))
> +			;;
> +		"64")
> +			echo "9223372036854775807"
> +			;;
> +		*)
> +			_fail "sizeof(long) == $(getconf LONG_BIT)?"
> +			;;
> +		esac
> +		;;
> +	esac
> +}

Why not move get_max_file_size() from tests/generic/485 to here instead?

- Eric
