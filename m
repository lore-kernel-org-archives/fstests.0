Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44272E5B2E
	for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 16:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719824; cv=none; b=GX5G2p4/1O26yGnTsC+0/8C1cw4v4OkN9kavvwsg3dgp+CQmunvCYE/4QVgivL5ljsjO01N3Z9BLppqbmLGgyONrO+cWXHqopa3a/T0Tsh8Uwb2876iN0ig1ToDt5gNjD+bvu8GiIkOW3URlbULeAsgE++nhcb4mJ6hKrM8n17c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719824; c=relaxed/simple;
	bh=G/8pP4iJPC7WPeNOKFqGlk9ZPzfsAiSip0FjNXiAL0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J03Umr2oKcjC+UjmYGdUfKQDyjsd+4eaOE3KN+Hd49c1suX9UX3OfW/F87XP50YH7VZPUp/0GoJY9VBhX+rivXjXA3ypuA7sgYg3akBrMb9IEW1pZRbEGrebpw9D2tM2q5tqc6pkRKQJjAL9dCaljVtzT1oIMubKHI7k61lmee8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FBUHWOIz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FBUHWOIz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760719821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9pOpDwR+gViips/mmHk0RvKenHB3drdamk0Sjv95aFE=;
	b=FBUHWOIzLopwjk8RFsXS5wOhorwjOkYtz3h4ZOBYikK04YdDweTNxeCh0st0DDWB6nB103
	g2HpQGCWBSRNIUvEfUhWCHM+VEYRWW2Fj0HV22pt7iJyzSclBPWjky9KTXahX82mGmJOnD
	WUEikpC1p+RVMOJp7w0cPhYkXPAkBVQ=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-_1Dw5AuqMYWzqYUKpX4Ncg-1; Fri, 17 Oct 2025 12:50:18 -0400
X-MC-Unique: _1Dw5AuqMYWzqYUKpX4Ncg-1
X-Mimecast-MFC-AGG-ID: _1Dw5AuqMYWzqYUKpX4Ncg_1760719817
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-290c2d13a01so14214135ad.0
        for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 09:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760719817; x=1761324617;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9pOpDwR+gViips/mmHk0RvKenHB3drdamk0Sjv95aFE=;
        b=jFiY2hafrkCQr/X/0dFqzZS3Y6197EiBOaRBxOMO4qgb4SP/Tq0GtHHrsmzs5ZCOOu
         qauQmzoYC5zx6jr8YH/xo+kcnFEgDTcfqQ+kuoRVFmORxdQ+W8M7A6S7tzQstdxbm7n6
         H/2+ZGUFWwSLynaL55WH5KhFgrf4JawPnnpOt9f/P3CFoXgxbmmxA/zWdkaA3MzQBugW
         hKssNYLKzVZ/VNbmOoV57d1v2aNP8BEhPdOy+z4sHcMANuB+MJTjOPlKS0mhvwYWSO8A
         nJt8mw1ZCBypikbLa3q5+0luIsi6tSBqSCnzT2C4Fse+1M29hxT7DJD0QCUJrY8rX278
         AdBw==
X-Forwarded-Encrypted: i=1; AJvYcCXnjgXVNG2d5B6OXp4tod72Fmgtmh1cg+tAWhudvdsy2zEjv+3ptwcd6kFk0XYSAgrnkeHHN0MZ@vger.kernel.org
X-Gm-Message-State: AOJu0YzpFFNzkF62G9b7F6o6kUywjEYuKqRvxq6ZZugDO5aUj8C8VTdn
	P0hCkPXGlNGtxbcJCrIq4aw2K2qQh5XKO1bLWnCVyThCqUCfvb7CgvCKRomJpUgdwjEGY9sMyii
	atJxMYIH68K7QHO+rsJMB0+Nqbjzo9JKP/1BJxlVvMzRFflS0cVYkZXj8tCo=
X-Gm-Gg: ASbGnctAe5j5k+qqYQajNy8Joe28DkLF62qNCCIuxUsuYE/WgMYRlPxYPBVFRPDQDaA
	TBF5X5SdlwI22l5/wVNo9307lAz8o71kr5UGkn8j4CG8aBdz60lcziM3Nyhfe9gaE83bPVcLFk6
	T407g+ln/NACQDYEXkRAz3xUZeCmm1/id5y32lo1nbkOKRhQoXIdprsKF3sYTC7HpHQXm9aGsvH
	2xBH0fCzTdFkzG2ydBBMkHBB9cqYYo7wGGhpkrGAarffHXssfm5Y5hferIodpvYCf1eYTib68Si
	SOcabkKHfzGfOVKGVkmK1L1FhQUzXnjPB868hVelBQu8eFtTWX5R4aHcj6Y/CLGw4/eSYEm60gT
	qnDia7xqqstU9Vvp5JCAHVeES9DHRtC/vNLp7r4M=
X-Received: by 2002:a17:903:3205:b0:267:8b4f:df36 with SMTP id d9443c01a7336-29091be7fb3mr106109785ad.29.1760719817237;
        Fri, 17 Oct 2025 09:50:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5QIga8v7Pg0TkjxYA3oXvINdMbOC55XbYEc/ZbkLjHxG2FwEQDQdwNjh5O2otKPBCKRJL+A==
X-Received: by 2002:a17:903:3205:b0:267:8b4f:df36 with SMTP id d9443c01a7336-29091be7fb3mr106109465ad.29.1760719816600;
        Fri, 17 Oct 2025 09:50:16 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a7664ab4dsm260719a12.1.2025.10.17.09.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 09:50:16 -0700 (PDT)
Date: Sat, 18 Oct 2025 00:50:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 3/3] common/f2fs: introduce _require_inject_f2fs_command()
Message-ID: <20251017165011.roxu42xkz7zrk6ou@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251009085043.16910-1-chao@kernel.org>
 <20251009085043.16910-3-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251009085043.16910-3-chao@kernel.org>

On Thu, Oct 09, 2025 at 04:50:43PM +0800, Chao Yu wrote:
> Introduce _require_inject_f2fs_command() to check whether inject.f2fs
> supports specific metaarea and member parameters.
> 
> Meanwhile, let's check inject.f2fs requirement inside
> _require_inject_f2fs_command() for cleanup.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---

Thanks, this version is good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/f2fs    | 27 +++++++++++++++++++++++++++
>  tests/f2fs/009 |  2 +-
>  tests/f2fs/012 |  2 +-
>  tests/f2fs/019 |  2 +-
>  tests/f2fs/020 |  2 +-
>  tests/f2fs/022 |  2 +-
>  6 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/common/f2fs b/common/f2fs
> index 4d0d688b..82d3102e 100644
> --- a/common/f2fs
> +++ b/common/f2fs
> @@ -69,3 +69,30 @@ _check_f2fs_filesystem()
>  
>      return 0
>  }
> +
> +# check that inject.f2fs supports to inject specific field in specific meta area
> +_require_inject_f2fs_command()
> +{
> +	_require_command "$F2FS_INJECT_PROG" inject.f2fs
> +
> +	if [ $# -ne 2 ]; then
> +		echo "Usage: _require_inject_f2fs_command metaarea member" 1>&2
> +		_exit 1
> +	fi
> +	metaarea=$1
> +	member=$2
> +
> +	case $metaarea in
> +	sb|cp|nat|sit)
> +		val=0
> +		;;
> +	ssa|node|dent)
> +		;;
> +	*)
> +		_notrun "unsupport metaarea: $metaarea"
> +		;;
> +	esac
> +
> +	$F2FS_INJECT_PROG "--$metaarea" "$val" "-h" | grep "$member:" > /dev/null || \
> +		_notrun "--$metaarea --mb $member support is missing"
> +}
> diff --git a/tests/f2fs/009 b/tests/f2fs/009
> index 7333d484..4c179f2d 100755
> --- a/tests/f2fs/009
> +++ b/tests/f2fs/009
> @@ -12,7 +12,7 @@
>  _begin_fstest auto quick
>  
>  _require_scratch
> -_require_command "$F2FS_INJECT_PROG" inject.f2fs
> +_require_inject_f2fs_command node i_links
>  _require_command "$(type -P socket)" socket
>  
>  _fixed_by_git_commit f2fs-tools 958cd6e \
> diff --git a/tests/f2fs/012 b/tests/f2fs/012
> index 7438d9ce..53d54bf6 100755
> --- a/tests/f2fs/012
> +++ b/tests/f2fs/012
> @@ -20,7 +20,7 @@ _fixed_by_kernel_commit 91b587ba79e1 \
>  export LC_ALL=C.UTF-8
>  _require_scratch_nocheck
>  _require_command "$F2FS_IO_PROG" f2fs_io
> -_require_command "$F2FS_INJECT_PROG" inject.f2fs
> +_require_inject_f2fs_command dent d_hash
>  
>  #check whether f2fs supports "lookup_mode=x" mount option
>  mntopt=""
> diff --git a/tests/f2fs/019 b/tests/f2fs/019
> index 2307bd96..a6e6e38c 100755
> --- a/tests/f2fs/019
> +++ b/tests/f2fs/019
> @@ -18,7 +18,7 @@ _fixed_by_kernel_commit 77de19b6867f \
>  	"f2fs: fix to avoid out-of-boundary access in dnode page"
>  
>  _require_scratch_nocheck
> -_require_command "$F2FS_INJECT_PROG" inject.f2fs
> +_require_inject_f2fs_command node addr
>  
>  # remove all mkfs options to avoid layout change of on-disk inode
>  export MKFS_OPTIONS=""
> diff --git a/tests/f2fs/020 b/tests/f2fs/020
> index 38bc6582..a6933134 100755
> --- a/tests/f2fs/020
> +++ b/tests/f2fs/020
> @@ -20,7 +20,7 @@ _fixed_by_kernel_commit 061cf3a84bde \
>  	"f2fs: fix to do sanity check on ino and xnid"
>  
>  _require_scratch_nocheck
> -_require_command "$F2FS_INJECT_PROG" inject.f2fs
> +_require_inject_f2fs_command node i_xattr_nid
>  _require_attrs user
>  
>  # remove all mkfs options to avoid layout change of on-disk inode
> diff --git a/tests/f2fs/022 b/tests/f2fs/022
> index ed3b4f2b..48a8386b 100755
> --- a/tests/f2fs/022
> +++ b/tests/f2fs/022
> @@ -19,7 +19,7 @@ _fixed_by_kernel_commit xxxxxxxxxxxx \
>  	"f2fs: fix to do sanity check on node footer for non inode dnode"
>  
>  _require_scratch_nocheck
> -_require_command "$F2FS_INJECT_PROG" inject.f2fs
> +_require_inject_f2fs_command node i_nid
>  
>  # remove all mkfs options to avoid layout change of on-disk inode
>  export MKFS_OPTIONS=""
> -- 
> 2.40.1
> 

