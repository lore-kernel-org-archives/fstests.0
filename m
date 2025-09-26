Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788A822424C
	for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758902284; cv=none; b=OPr1hOJsO2SYzvGAx4hzUdz48nOVJgLf5J4AWb6ypkaqnoatn/RRguysWfCXAnXkss0GCzRNEtJmQq9hV/1RsXx3tNQPW83kdzZbPKHVxgXFU6t0mbHyWh/AiBQLofQj0rPmWdWtB0WTgPh8gotQdyoJOSLByhCIbhyQ3nzZUvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758902284; c=relaxed/simple;
	bh=QEBb8CvmzifXijQilZ6wiqu1lNq4+xZewyvZT2bnvfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wmhu/5+suK5ywPha1kbRHIxbgsKj/K+sqwqaLctbwVwzHfVBnOvBZdugywLk+DNNbz/i1blkg4RgDYmKvzEDyZk3p4KYu7+aEUgvGEGuqKlfYVamCq4gf3JvXtCI2YVKAm9M/diicjQVAvOi3zXTaRWaNhU2TUwXs4XeevYIrNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IAqMJp6C; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IAqMJp6C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758902281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lbAmfikudN6BqTKToQsuN7u+mvQbsqyab96HtsMyKbc=;
	b=IAqMJp6CgUarx6QwKedHtd3LmAX3YtI35AxGHLQhFeDI+LYAUl9/QjegBcYdiGsFaPNpIH
	dQ5PgdcE2/ygCE18oYfHODME0ovThcrklFKYm8ZyGAVa40Z0RWdI8KkGAKHEMRlBUSMrGB
	X840frDO6Gvo+rUg1DzZv3E2eOvMJEM=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-9swOMMnLPlyNn2o2hI7MRw-1; Fri, 26 Sep 2025 11:57:59 -0400
X-MC-Unique: 9swOMMnLPlyNn2o2hI7MRw-1
X-Mimecast-MFC-AGG-ID: 9swOMMnLPlyNn2o2hI7MRw_1758902279
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2e60221fso3297635b3a.0
        for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 08:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758902279; x=1759507079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbAmfikudN6BqTKToQsuN7u+mvQbsqyab96HtsMyKbc=;
        b=h21OmunNDuGGFMizJ9xgrLFYMnlYiURYa/wxlbbIYhnAyXRkTmyaAi7obdRjhyfQNf
         x+tz7a24mMnR6OfyvIg1Mo2n9h247WuE9ZexZJRK9h71rADlCwjZv5tU/+OPk17xS0hd
         wRjBTvDv4AmZM9XEGWcqtNrRV6MyIBWcUGoiL+0kpvGaG1R17/BdErfcBCqtQFwmGvSg
         Zjv6s2KbXnm0Fz2e+lKxUs6qZxmCiozSIGPkQsdK7w7HIeIYZh/hf80R27GqCpeSl+KE
         8D/wSdxBg2Gp2YQADF05iXNIfhRz5Dme8xSqXr61tsBJ36eVaHG/kDOeayc3Ag7xEFMM
         eUTA==
X-Gm-Message-State: AOJu0YzXv4yoS1qV505nmY+OB1zmQlfMJn6A0STg2wlKl0XoBbNLndKM
	YoJGOLRlqRqSQhXGY5RW8jO5dzwqROrLrO5dzWtN87qFlwscainEY+GLZZMVpBU1LD1Ydgw7XSe
	tew2xKEIZQnqwA7MvSflME9qaGpcBE3CCDNOFCXaCadF+PqkNOHiGq/8d1FM=
X-Gm-Gg: ASbGnctnjrCNrRTTLDjFpeRNchTNJMzoyHRYHMDX3Wws0yK3UzTeEashpmUYAEL28XI
	FqtqiRyRHQTsu14+c8SP6CLDekREZF5YakUloHXCMvwi+XJggAsA9U8AUdRkIk90DYYnIZKsqne
	44Z8L1ohsEl8GXgxBICF3G9iHFEguqcd97F/fepbCd/99z+cVL9c4Fw5q/O/3JXbpbErH/D6LNb
	zicDBSSIpBF7gu/uroHAXExeUOfbEtvKzgfui5uKdU8yL8JLft3n/oLRXzz+9Uo+rsjCM7Hhlyv
	2mwxZ00mgUyxPTSQUcKgc1XTTtPUAvNWgjUXGEoVnf6l0KZVC6QGE8fiFIdGif133y9sMzznwVn
	ogZxG
X-Received: by 2002:a05:6a21:3381:b0:2cb:5f15:ebf8 with SMTP id adf61e73a8af0-2e7ca7d6b46mr9027586637.27.1758902278648;
        Fri, 26 Sep 2025 08:57:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH96BUNIs4nlT/UUuxp8unsBbBn2QPoH6tmB3oSq3Mg9aUq5muVxP6EvMvA3dINyNKcCRGAGw==
X-Received: by 2002:a05:6a21:3381:b0:2cb:5f15:ebf8 with SMTP id adf61e73a8af0-2e7ca7d6b46mr9027548637.27.1758902277980;
        Fri, 26 Sep 2025 08:57:57 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7810cfdb99fsm3350338b3a.31.2025.09.26.08.57.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 08:57:57 -0700 (PDT)
Date: Fri, 26 Sep 2025 23:57:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anajain.sg@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/2] common/rc: helper functions to handle block devices
 via sysfs
Message-ID: <20250926155753.yhhrbfnilvmk2t47@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1758148804.git.anand.jain@oracle.com>
 <512a6148be0d8da51278f94a29b959f3950bcc0b.1758148804.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <512a6148be0d8da51278f94a29b959f3950bcc0b.1758148804.git.anand.jain@oracle.com>

On Thu, Sep 18, 2025 at 08:32:46AM +0800, Anand Jain wrote:
> From: Anand Jain <anand.jain@oracle.com>
> 
> _bdev_handle(dev)
> 	get sysfs handle for a given block device.
> 
> _has_bdev_sysfs_delete(dev_path)
> 	Checks if the block device supports sysfs-based delete.
> 
> _require_scratch_bdev_delete()
> 	Test if the scratch device does not support sysfs delete.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  common/rc | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 81587dad500c..627ddcc02fb8 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4388,6 +4388,32 @@ _get_file_extent_sector()
>  	echo "$result"
>  }
>  
> +_bdev_handle()
> +{
> +	local device=$(echo $1 | rev | cut -d"/" -f1 | rev)
                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

basename $1 ?

if you hope to make sure it's not link, you can

basename $(_real_dev $1)

> +
> +	test -e /sys/class/block/${device}/device/scsi_disk/ || \
> +			_notrun "Failed to obtain sys block handle"
> +
> +	ls /sys/class/block/${device}/device/scsi_disk/
> +}
> +
> +_has_bdev_sysfs_delete()
> +{
> +	local dev_path=$1
> +	local device=$(echo $dev_path | rev | cut -d"/" -f1 | rev)
> +	local delete_path=/sys/class/block/${device}/device/delete
> +
> +	test -e $delete_path
> +}
> +
> +_require_scratch_bdev_delete()
> +{

I'm wondering if it's better to call "_require_block_device" at first, before
checking the /sys ?

> +	if ! _has_bdev_sysfs_delete $SCRATCH_DEV; then
> +		_notrun "require scratch device sys delete support"
> +	fi
> +}
> +
>  # arg 1 is dev to remove and is output of the below eg.
>  # ls -l /sys/class/block/sdd | rev | cut -d "/" -f 3 | rev
>  _devmgt_remove()
> -- 
> 2.51.0
> 
> 

