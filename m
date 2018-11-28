Received: from mail-pg1-f196.google.com ([209.85.215.196]:40947 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbeK1Ph1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Wed, 28 Nov 2018 10:37:27 -0500
Received: by mail-pg1-f196.google.com with SMTP id z10so8901960pgp.7
        for <fstests@vger.kernel.org>; Tue, 27 Nov 2018 20:37:12 -0800 (PST)
Date: Wed, 28 Nov 2018 12:37:05 +0800
From: Eryu Guan <guaneryu@gmail.com>
Subject: Re: [PATCH 3/3] generic: exclude selinux xattr form being considered
Message-ID: <20181128043705.GS3889@desktop>
References: <20181127214308.137410-1-gwendal@chromium.org>
 <20181127214308.137410-4-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127214308.137410-4-gwendal@chromium.org>
Sender: fstests-owner@vger.kernel.org
To: Gwendal Grignou <gwendal@chromium.org>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On Tue, Nov 27, 2018 at 01:43:08PM -0800, Gwendal Grignou wrote:
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>

I didn't see such failures before, could you please provide more info in
the commit log about the problem? So I can try to reproduce the failure.

> ---
>  common/filter     | 1 +
>  tests/generic/062 | 2 +-
>  tests/generic/377 | 2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/common/filter b/common/filter
> index ed082d24..3ca40431 100644
> --- a/common/filter
> +++ b/common/filter
> @@ -290,6 +290,7 @@ _filter_scratch()
>  	# so substitute SCRATCH_MNT first
>  	sed -e "s,\B$SCRATCH_MNT,SCRATCH_MNT,g" \
>  	    -e "s,\B$SCRATCH_DEV,SCRATCH_DEV,g" \
> +	    -e "/security\.selinux/d" \
>  	    -e "/.use_space/d"

This doesn't belong to _filter_scratch but to filters that filter xattr.
I want to understand & reproduce the problem so I know where the failure
comes from and think about what the best fix would be.

Thanks,
Eryu

>  }
>  
> diff --git a/tests/generic/062 b/tests/generic/062
> index 9024af2e..7e79a2dd 100755
> --- a/tests/generic/062
> +++ b/tests/generic/062
> @@ -120,7 +120,7 @@ for nsp in $ATTR_MODES; do
>  		getfattr -m $nsp -e hex -n $nsp.name2 $SCRATCH_MNT/$inode 2>&1 | invalid_attribute_filter
>  
>  		echo "*** final list (strings, type=$inode, nsp=$nsp)"
> -		getfattr -m '.' -e hex $SCRATCH_MNT/$inode
> +		getfattr -m '.' -e hex $SCRATCH_MNT/$inode | grep -ve "security\.selinux"
>  	
>  	done
>  done
> diff --git a/tests/generic/377 b/tests/generic/377
> index f7835ee8..0ce2cb4b 100755
> --- a/tests/generic/377
> +++ b/tests/generic/377
> @@ -66,7 +66,7 @@ $listxattr $testfile 9
>  $listxattr $testfile 11
>  
>  # 6. Calling listxattr with buffersize bigger than needed should succeed.
> -$listxattr $testfile 500 | sort
> +$listxattr $testfile 500 | grep -ve "security\.selinux" | sort
>  
>  status=0
>  exit
> -- 
> 2.18.1
> 
