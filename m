Received: from mail-pf1-f195.google.com ([209.85.210.195]:33741 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727319AbeIITql (ORCPT
        <rfc822;fstests@vger.kernel.org>); Sun, 9 Sep 2018 15:46:41 -0400
Received: by mail-pf1-f195.google.com with SMTP id d4-v6so9207551pfn.0
        for <fstests@vger.kernel.org>; Sun, 09 Sep 2018 07:56:45 -0700 (PDT)
Date: Sun, 9 Sep 2018 22:56:34 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH] tmpfs: don't require TEST_DEV
Message-ID: <20180909145611.GJ3651@desktop>
References: <20180903122728.22882-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180903122728.22882-1-mszeredi@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: Miklos Szeredi <mszeredi@redhat.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Mon, Sep 03, 2018 at 02:27:28PM +0200, Miklos Szeredi wrote:
> tmpfs doesn't require a device and the source argument of the mount is ignored.
> If TEST_DEV is not given then set it to "none".
> 
> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> ---
>  common/config | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/common/config b/common/config
> index 2f1f27206776..40c2b399a3c7 100644
> --- a/common/config
> +++ b/common/config
> @@ -456,8 +456,9 @@ _check_device()
>  	fi
>  
>  	case "$FSTYP" in
> -	9p)
> +	9p|tmpfs)
>  		# 9p mount tags are just plain strings, so anything is allowed
> +		# tmpfs doesn't use mount source, ignore
>  		;;
>  	overlay)
>  		if [ ! -d "$dev" ]; then
> @@ -657,6 +658,10 @@ get_next_config() {
>  		export RESULT_BASE="$here/results/"
>  	fi
>  
> +	if [ "$FSTYP" == tmpfs -a -z "$TEST_DEV" ]; then
> +		export TEST_DEV=none
> +	fi
> +

Looks like we could ignore SCRATCH_DEV as well, just set it to a
different name. I'll just update it on commit.

Thanks,
Eryu

>  	#  Mandatory Config values.
>  	MC=""
>  	[ -z "$EMAIL" ]          && MC="$MC EMAIL"
> -- 
> 2.14.3
> 
