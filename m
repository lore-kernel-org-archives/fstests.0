Received: from mx1.redhat.com ([209.132.183.28]:47508 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754228AbdCBJAK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 2 Mar 2017 04:00:10 -0500
Date: Thu, 2 Mar 2017 16:05:46 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 1/2] check: prepare test report generator infrastructure
Message-ID: <20170302080546.GK14226@eguan.usersys.redhat.com>
References: <1487681045-22884-1-git-send-email-dmonakhov@openvz.org>
 <1487681045-22884-3-git-send-email-dmonakhov@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487681045-22884-3-git-send-email-dmonakhov@openvz.org>
Sender: fstests-owner@vger.kernel.org
To: Dmitry Monakhov <dmonakhov@openvz.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Feb 21, 2017 at 04:44:04PM +0400, Dmitry Monakhov wrote:
> Save testcase data which later may be used by report generators
> - Save failure reason to $err_msg variable
> - Save number of notrun tests to $n_notrun counter, similar to $n_try,$n_bad
> 
> changes since v1:
>  - add _dump_err[,2] _log_err helper functions
> 
> Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>

Sorry for the late review, and thanks for the update! Some minor
comments inline.

> ---
>  check         | 31 +++++++++++++++++++++----------
>  common/btrfs  |  8 ++------
>  common/config | 19 +++++++++++++++++++
>  common/rc     | 14 +++++++-------
>  common/xfs    | 22 ++++++----------------
>  5 files changed, 55 insertions(+), 39 deletions(-)
> 
> diff --git a/check b/check
> index 5a93c94..8ee2f6f 100755
> --- a/check
> +++ b/check
[snip]
> diff --git a/common/config b/common/config
> index 03c2f9f..66b1972 100644
> --- a/common/config
> +++ b/common/config
> @@ -128,6 +128,25 @@ _fatal()
>      exit 1
>  }
>  
> +_dump_err()
> +{
> +    err_msg="$*"
> +    echo "$err_msg"
> +}
> +
> +_dump_err2()
> +{
> +    err_msg="$*"
> +    >2& echo "$err_msg"
> +}
> +
> +_log_err()
> +{
> +    err_msg="$*"
> +    echo "$err_msg" | tee -a $seqres.full
> +    echo "(see $seqres.full for details)"
> +}
> +

I think these functions belong to common/rc

>  export MKFS_PROG="`set_prog_path mkfs`"
>  [ "$MKFS_PROG" = "" ] && _fatal "mkfs not found"
>  
> diff --git a/common/rc b/common/rc
> index ec59b88..ec9b2a0 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1052,7 +1052,9 @@ _repair_scratch_fs()
>  		_scratch_xfs_repair "$@" 2>&1
>  		res=$?
>  	fi
> -	test $res -ne 0 && >&2 echo "xfs_repair failed, err=$res"
> +	if [ test $res -ne 0]; then

Use "[" or "test", not both :) , and need a space before "]".

Thanks,
Eryu
