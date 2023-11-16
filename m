Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRshfmwS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB3BA4
	for <fstests@vger.kernel.org>; Wed, 15 Nov 2023 18:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700103096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BL4zxiN7u9NkwZgBjtZRADD+ybgJzZTVWcuKU9mDEZo=;
	b=WRshfmwSeadbGikuw409jsHZnFvmX5j5MwFdLM9T4dClaZevyIK3UFW6IZkcn8PZn3FR4N
	qlRDkyo53Qhh5AnSCZ9yrhy9tqgu0NluJll80XZ0vTtt0sxDK6O1rr/iKSlGsOdLuFk5ME
	jsLFYhQ/wyXgmdbFwS65m7vuXbsqDTo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-ATehX3WiPyuAyRR8NK_qLg-1; Wed, 15 Nov 2023 21:51:33 -0500
X-MC-Unique: ATehX3WiPyuAyRR8NK_qLg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-27ff8065e61so311960a91.1
        for <fstests@vger.kernel.org>; Wed, 15 Nov 2023 18:51:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700103092; x=1700707892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BL4zxiN7u9NkwZgBjtZRADD+ybgJzZTVWcuKU9mDEZo=;
        b=SjIDHbSw4bHSEWPA4x/6vP8E6ONSwtW8VG8n0V87G5Gqv5TOm11lTUB0coXT5Z60mz
         GlCnKqyn8+YL5O4VnZB+2I1DEN7u1c3iUMRgRf12ug0DS9+ZTBOfRTCnAN2iPFpiaOaF
         l0nh+1xqUhj+0zj9E9/sytcFLe7O1B4vscwUZzCdVlvrdHpMjaolAzS4ry6ao76bg7fV
         G8rBazgTGT9OPuUeb1lnZPtGU8QiVjThNsYcVBos6CCO7F8EbE4J6Cc6Mm+rcW+dlpPT
         vbZ5kghSXdnOhtbWQML7x1vh9LptelYslVB3LR9qFMWQuOeLUd3JRQLJ5Dtp/JuEwsXY
         AhRQ==
X-Gm-Message-State: AOJu0Yw63clcn/sZKScWnjzh053bIucYadWnGKICBMehSexHV8ieb2KI
	hiQWcBOqAKg2wKpaflHbnDyw6ovvZ2W5dH/iBWc2wqy6hoAGJj8XmU0STMDkRbS6f7/MJUSyul8
	y+B5eDyEBvT5AuS2oyQ==
X-Received: by 2002:a17:90b:3b47:b0:27c:f8f4:fedb with SMTP id ot7-20020a17090b3b4700b0027cf8f4fedbmr16957713pjb.21.1700103092412;
        Wed, 15 Nov 2023 18:51:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGms3NCGbnZe4BJTxXjIBHSBKzJhwlVFfrZGxEm9fAyWwc5ptdzCfEOOxGKl933OFzN4PAkZA==
X-Received: by 2002:a17:90b:3b47:b0:27c:f8f4:fedb with SMTP id ot7-20020a17090b3b4700b0027cf8f4fedbmr16957705pjb.21.1700103092123;
        Wed, 15 Nov 2023 18:51:32 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id o17-20020a17090ab89100b00280469602bcsm517179pjr.2.2023.11.15.18.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 18:51:31 -0800 (PST)
Date: Thu, 16 Nov 2023 10:51:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, dsterba@suse.cz
Subject: Re: [PATCH] common/btrfs: add _btrfs_get_fsid() helper
Message-ID: <20231116025125.cdrwnopq33srdcb4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <887706aa6c981aff219b0b2faca614e8ee2323b3.1699417639.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <887706aa6c981aff219b0b2faca614e8ee2323b3.1699417639.git.anand.jain@oracle.com>

On Wed, Nov 08, 2023 at 12:28:57PM +0800, Anand Jain wrote:
> We have two instances of reading the btrfs fsid by using the command
> 'btrfs filesystem show <mnt>' turn this into an easy-to-use helper
> function and also use it.
> 
> Suggested-by: David Sterba <dsterba@suse.cz>
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

It looks good to me, will merge it with:
  [PATCH v4 0/5] btrfs/219 cloned-device mount capability update

Reviewed-by: Zorro Lang <zlang@redhat.com>


>  common/btrfs | 14 ++++++++++++--
>  common/rc    |  5 +----
>  2 files changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index fbc26181f7bc..f91f8dd869a1 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -457,13 +457,23 @@ _scratch_btrfs_is_zoned()
>  	return 1
>  }
>  
> -_require_btrfs_sysfs_fsid()
> +_btrfs_get_fsid()
>  {
>  	local fsid
> +	local mnt=$1
>  
> -	fsid=$($BTRFS_UTIL_PROG filesystem show $TEST_DIR |grep uuid: |\
> +	fsid=$($BTRFS_UTIL_PROG filesystem show $mnt |grep uuid: |\
>  	       $AWK_PROG '{print $NF}')
>  
> +	echo $fsid
> +}
> +
> +_require_btrfs_sysfs_fsid()
> +{
> +	local fsid
> +
> +	fsid=$(_btrfs_get_fsid $TEST_DIR)
> +
>  	# Check if the kernel has sysfs fsid support.
>  	# Following kernel patch adds it:
>  	#   btrfs: sysfs add devinfo/fsid to retrieve fsid from the device
> diff --git a/common/rc b/common/rc
> index 7f14c19ca89e..b2e06b127321 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4721,7 +4721,6 @@ _require_statx()
>  _fs_sysfs_dname()
>  {
>  	local dev=$1
> -	local fsid
>  
>  	if [ ! -b "$dev" ]; then
>  		_fail "Usage: _fs_sysfs_dname <mounted_device>"
> @@ -4729,9 +4728,7 @@ _fs_sysfs_dname()
>  
>  	case "$FSTYP" in
>  	btrfs)
> -		fsid=$($BTRFS_UTIL_PROG filesystem show ${dev} | grep uuid: | \
> -							$AWK_PROG '{print $NF}')
> -		echo $fsid ;;
> +		_btrfs_get_fsid $dev ;;
>  	*)
>  		_short_dev $dev ;;
>  	esac
> -- 
> 2.39.3
> 
> 

