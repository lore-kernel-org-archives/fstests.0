Received: from mx1.redhat.com ([209.132.183.28]:50160 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750868AbcIUJhj (ORCPT <rfc822;fstests@vger.kernel.org>);
        Wed, 21 Sep 2016 05:37:39 -0400
Date: Wed, 21 Sep 2016 17:37:21 +0800
From: Eryu Guan <eguan@redhat.com>
Subject: Re: [PATCH 2/3] modify xfs/ quota tests to work on generic
 filesystems
Message-ID: <20160921093721.GK27776@eguan.usersys.redhat.com>
References: <65c03ebd-ee9c-7439-2642-0362a177ec6d@redhat.com>
 <ef6b5c28-9579-c13e-0547-17d05f150714@sandeen.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef6b5c28-9579-c13e-0547-17d05f150714@sandeen.net>
Sender: fstests-owner@vger.kernel.org
To: Eric Sandeen <sandeen@sandeen.net>
Cc: Eric Sandeen <sandeen@redhat.com>, fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

On Tue, Sep 20, 2016 at 05:21:46PM -0500, Eric Sandeen wrote:
> Fix several xfs quota tests to work on non-xfs filesystems.
> 
> New _require function to be sure that the xfs_quota tool can operate
> on foreign filesystems; if it can, and if it needs to, it adds "-f"
> to the XFS_QUOTA_PROG variable.
> 
> Modify _qmount to do quotacheck/quotaon to mount and /enable/
> quota.  On xfs this isn't needed and/or fails; it's ignored.
> 
> All quota-related options used as arguments to _qmount are changed
> from i.e. uquota to i.e. usrquota; the latter is standard across
> almost all linux filesytems, including xfs.
> 
> xfs/260 filters out the root/default quota line, because ext4
> consumes a different amount of space than xfs, and it's not what
> we're testing for, so just ignore it.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>
> ---
> 
> diff --git a/common/quota b/common/quota
> index d91062a..2ec56a5 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -78,6 +78,19 @@ _require_xfs_quota()
>  }
>  
>  #
> +# checks that xfs_quota can operate on foreign (non-xfs) filesystems
> +# Skips check on xfs filesystems, old xfs_quota is fine there.
> +# Appends "-f" to enable foreign behavior on non-xfs filesystems if available.
> +#
> +_require_xfs_quota_foreign()
> +{
> +    if [ "$FSTYP" != "xfs" ]; then
> +	$XFS_QUOTA_PROG -f -V &>/dev/null || \
> +		_notrun "xfs_quota binary does not support foreign filesystems"
> +	XFS_QUOTA_PROG="$XFS_QUOTA_PROG -f"
> +    fi

Mixing space and tab in this function.

> +}

Better to have an empty line here :)

> +#
>  # checks that the XFS project quota support in the kernel is enabled.
>  #
>  _require_prjquota()

[snip]

> diff --git a/tests/xfs/118 b/tests/xfs/118
> index 8414594..da18a32 100755
> --- a/tests/xfs/118
> +++ b/tests/xfs/118
> @@ -47,11 +47,12 @@ _cleanup()
>  # real QA test starts here
>  
>  # Modify as appropriate.
> -_supported_fs xfs
> +_supported_fs generic
>  _supported_os IRIX Linux
>  
>  _require_scratch
> -_require_xfs_quota
> +_require_quota
> +_require_xfs_quota_foreign
>  
>  _chowning_file()
>  {
> @@ -72,10 +73,10 @@ _chowning_file()
>  }
>  
>  echo "mkfs on scratch"
> -_scratch_mkfs_xfs >$seqres.full
> +_scratch_mkfs >$seqres.full

I found that stderr should be redirected to $seqres.full too, otherwise
it fails with ext2/3 as

+mke2fs 1.42.9 (28-Dec-2013)

I can fix them at commit time if there's no other review comments.

Thanks,
Eryu
