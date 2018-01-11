Received: from szxga04-in.huawei.com ([45.249.212.190]:4158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753471AbeAKCQe (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 10 Jan 2018 21:16:34 -0500
Subject: Re: [PATCH] common: support defrag test on f2fs
References: <1515572690-11377-1-git-send-email-rongx.a.chen@intel.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <f20df6c3-380c-707d-f2b9-8751ad88d93b@huawei.com>
Date: Thu, 11 Jan 2018 10:16:19 +0800
MIME-Version: 1.0
In-Reply-To: <1515572690-11377-1-git-send-email-rongx.a.chen@intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Chen Rong <rongx.a.chen@intel.com>, fstests@vger.kernel.org
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
List-ID: <fstests@vger.kernel.org>

On 2018/1/10 16:24, Chen Rong wrote:
> f2fs-tools has a defragment tool, so we can test generic/324 on f2fs

+Cc f2fs mailing list

defrag.f2fs can only do filesystem-level defragment, but it looks like
generic/324 expects to execute file-level defragment, so we can not simply
use that existing tool in this testcase.

As I checked, actually, this modification does let this testcase passed, so
isn't there any problem in verification flow of this testcase?

Thanks,

> 
> Signed-off-by: Chen Rong <rongx.a.chen@intel.com>
> ---
>  common/config | 1 +
>  common/defrag | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/common/config b/common/config
> index d0fbfe5..71cb367 100644
> --- a/common/config
> +++ b/common/config
> @@ -226,6 +226,7 @@ case "$HOSTOS" in
>          export MKFS_BTRFS_PROG="`set_btrfs_mkfs_prog_path_with_opts`"
>          export MKFS_F2FS_PROG="`set_prog_path mkfs.f2fs`"
>          export DUMP_F2FS_PROG="`set_prog_path dump.f2fs`"
> +        export DEFRAG_F2FS_PROG="`set_prog_path defrag.f2fs`"
>          export BTRFS_UTIL_PROG="`set_prog_path btrfs`"
>          export BTRFS_SHOW_SUPER_PROG="`set_prog_path btrfs-show-super`"
>  	export BTRFS_CONVERT_PROG="`set_prog_path btrfs-convert`"
> diff --git a/common/defrag b/common/defrag
> index d279382..d54b89c 100644
> --- a/common/defrag
> +++ b/common/defrag
> @@ -44,6 +44,9 @@ _require_defrag()
>      btrfs)
>  	DEFRAG_PROG="$BTRFS_UTIL_PROG filesystem defragment"
>  	;;
> +    f2fs)
> +	DEFRAG_PROG="$DEFRAG_F2FS_PROG"
> +	;;
>      *)
>          _notrun "defragmentation not supported for fstype \"$FSTYP\""
>  	;;
> 

