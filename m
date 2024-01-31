Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3D47F488
	for <fstests@vger.kernel.org>; Wed, 31 Jan 2024 14:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710313; cv=none; b=h0h7CpU99284zgdd0fsxO7VxhInp3LK0ehGpi9aRHeLiDkMpalTOskdf5EYn87lVGnyUHCAoU6D5SGrTtXrMkXsWEh0A7mA9A87GhfWk3sEX20gvJRmKKbWKtLXHRKtyr6532KRlZArFLUkcKAWSDcUION5ykla3iIrJjytzpRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710313; c=relaxed/simple;
	bh=rVR7BNBZBtNMx2j/+oKZJxghwXHKX9iut7QXMbHxjN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snUCU1TCmttIOc5aK0MFCIphkCtL+r8zDSX8nlkoCSFHWPKEFq9HoX7pHNJSOf+HgOgX647tmcRA/tY6eo4F2LyA/ut9O6F4GjQN0SCSzWy1bVVEh9WlJgTQxIZfsxQEFG1sLYOnXXJ7t9FGZFpHL0wk2fKXEzDP81yvXQsCmYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OflN+Rev; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OflN+Rev"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706710310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AMjcP4lz0fQtJiuXGiD0XLKEQG2nHpsVAsiofujyr0U=;
	b=OflN+RevfLy/0GqoATEVoH2tPWfg3oQhxBfCgwZJe7fWuahiqM9TOjGe2p4uqKB9uye+GI
	Dlrli+No+POO/mGgpo9Asbd+oxzsPcccvivWt7/hNZyDq0umH0kI/LfX8Xn0K7PG3hIU7X
	9RKVyFagX7+5aGz4nruCgSCDvpTrUcI=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-vxwZQN9kOVqPQDAx4oofFg-1; Wed, 31 Jan 2024 09:11:48 -0500
X-MC-Unique: vxwZQN9kOVqPQDAx4oofFg-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5d8dc8f906aso1915510a12.2
        for <fstests@vger.kernel.org>; Wed, 31 Jan 2024 06:11:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706710307; x=1707315107;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AMjcP4lz0fQtJiuXGiD0XLKEQG2nHpsVAsiofujyr0U=;
        b=CkGEZTtraIGDjpFImWrHnKSa8SOKZjb1jQIvzyqvsLk8aZHByQ4/b7oFSSVjlj//h5
         iwm4JA9eU2a98QZNjWCKYfjbC/R1RHqw4mLX5heFnSXjyvsOZrZuoS0x2NeKVPWlkyrG
         hYyfuQ7OhxPJXKehRF2+ca64koXsk1QV3RcLBnaR4yip3BTSTT1WcV3kN7IqzqELKS8V
         an32R7c6Pvw55zzaWwlDGpqgqaglNh8EoMxsLFtkW+HCmBgFJtodb362BQ2F4vDaXACR
         uMKXBJ/Ulv8ccg17TrDL+At1RHNXnJKRnl+moZlis0lCzBlom7OtbvGT+Gi9HlBJFgGV
         9cJA==
X-Gm-Message-State: AOJu0YzO93+YaG6CaUZF0HHcamwE+qyqcb+Cv8YBZfDxVLRcEL55E7tI
	k1CAv90jBspp5bsN6XxiPcwy8i8zHz9CGhR02ULvmxOXMpmr4CDXih3RquzphX+u20nHopl/9FU
	U3YRGwjtkjPrkGNSFT3pank8Jcp4EZ0wXrhD6uCQ8qYWjLiHJ7tjiRF8=
X-Received: by 2002:a05:6a21:32a3:b0:19c:a988:24b9 with SMTP id yt35-20020a056a2132a300b0019ca98824b9mr1904610pzb.25.1706710307501;
        Wed, 31 Jan 2024 06:11:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzo2Qd33nCbPvMgXORy+rq2hkew1ZZjh96/HTu6onc924vg6puW7DvQgM4aOjCuH1JYiMreg==
X-Received: by 2002:a05:6a21:32a3:b0:19c:a988:24b9 with SMTP id yt35-20020a056a2132a300b0019ca98824b9mr1904588pzb.25.1706710307199;
        Wed, 31 Jan 2024 06:11:47 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCV6cTZZXe+vFjg1zlwg73JXpM1OTkI9xZKxCMJIMNOUsryu+JOD3rAVbd7/UF9mZ5DHMUM4bDaDKs7Xxp86myrMBIUKCarLVLZP2qg7RlJTNhAm6sDvPO1kZxQiWE4saEqf4wwaMtpjqpbNmbz7tOEPDw==
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id x7-20020a636307000000b005c259cef481sm10526630pgb.59.2024.01.31.06.11.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:11:46 -0800 (PST)
Date: Wed, 31 Jan 2024 22:11:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: Su Yue <glass.su@suse.com>
Cc: fstests@vger.kernel.org, linux-bcachefs@vger.kernel.org, l@damenly.org,
	bfoster@redhat.com
Subject: Re: [PATCH v4 2/2] common/rc: improve block_size support for bcachefs
Message-ID: <20240131141143.st3gpqn4iivdyfey@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240129235104.8976-1-l@damenly.org>
 <20240129235104.8976-2-l@damenly.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240129235104.8976-2-l@damenly.org>

On Tue, Jan 30, 2024 at 07:51:04AM +0800, Su Yue wrote:
> From: Su Yue <glass.su@suse.com>
> 
> mkfs.bcachefs now supports option '--block_size' to allow
> custom block_size.
> 
> Add the pattern to set def_blksz if MKFS_OPTIONS contains the
> option in _scratch_mkfs_sized.
> Also let mkfs.bcachefs decide blocksize if no option is given in
> MKFS_OPTIONS or _scratch_mkfs_sized parameter.
> 
> Signed-off-by: Su Yue <glass.su@suse.com>
> ---
> changelog:
> v4:
>     Respect block_size in MKFS_OPTIONS. 
> v3:
>     Add logic to Let mkfs.bcachefs decide blocksize if no option is given in
>     local.config or _scratch_mkfs_sized parameter.
> v2:
>     Born.
> ---

Thanks for helping fstests to support bcachefs better, feel
free to send more patches for bcachefs testing.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index 31c21d2a8360..315a2413f963 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -930,6 +930,7 @@ _scratch_mkfs_sized()
>  	local fssize=$1
>  	local blocksize=$2
>  	local def_blksz
> +	local blocksize_opt
>  
>  	case $FSTYP in
>  	xfs)
> @@ -950,6 +951,13 @@ _scratch_mkfs_sized()
>  	jfs)
>  		def_blksz=4096
>  		;;
> +	bcachefs)
> +		def_blksz=`echo $MKFS_OPTIONS | sed -rn 's/.*(--block_size)[ =]?+([0-9]+).*/\2/p'`
> +		[ -n "$blocksize" ] && blocksize_opt="--block_size=$blocksize"
> +		[ -n "$def_blksize" ] && blocksize_opt="--block_size=$def_blksize"
> +		# If no block size is given by local.confg or parameter, blocksize_opt is empty.
> +		# Let MKFS_BCACHEFS_PROG decide block size on its own.
> +		;;
>  	esac
>  
>  	[ -n "$def_blksz" ] && blocksize=$def_blksz
> @@ -1051,7 +1059,7 @@ _scratch_mkfs_sized()
>  		export MOUNT_OPTIONS="-o size=$fssize $TMPFS_MOUNT_OPTIONS"
>  		;;
>  	bcachefs)
> -		$MKFS_BCACHEFS_PROG $MKFS_OPTIONS --fs_size=$fssize --block_size=$blocksize $SCRATCH_DEV
> +		$MKFS_BCACHEFS_PROG $MKFS_OPTIONS --fs_size=$fssize $blocksize_opt $SCRATCH_DEV
>  		;;
>  	*)
>  		_notrun "Filesystem $FSTYP not supported in _scratch_mkfs_sized"
> -- 
> 2.43.0
> 
> 

