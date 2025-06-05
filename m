Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5915A16A395
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749142832; cv=none; b=M9Nk2UfSIE1XwMyS4KNnANObXYWCjwgc5opFHxpvCAVqz4shvyvaij9BpfeB1k0tUxiAxFZBEzgVYe9tjeYfnbQgsP6Oa1Vnzm+yy3BYJ7U9ltAJ+8hAatYPwBPiciw0lvMGevXpRFK7fgQVa49NG+DEtb+ad1Djk3vMArtxm3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749142832; c=relaxed/simple;
	bh=5y6uBvs1oK4NksnaOktuog0uazlXD9RW3grSW2SllOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxlOmWwVgG5xg0Skf/4iKemTCdY2/UTZxp2szQKy4pTNVUVj74smPhi2wVjxGDJIJZDE+fsLQG+3RaHj3ui81lR1RJv6VMDgY0QaPzD0VMcv4XlcapLnWalwwPbosrI6w1X7pxE/3RZmECg9diI4SqvlcQvuq4rbUt7P2eFMKL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-Wvgh_6v3MpmYmlrgI5jIeQ-1; Thu, 05 Jun 2025 13:00:28 -0400
X-MC-Unique: Wvgh_6v3MpmYmlrgI5jIeQ-1
X-Mimecast-MFC-AGG-ID: Wvgh_6v3MpmYmlrgI5jIeQ_1749142827
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-23592f5fcb0so18884015ad.3
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 10:00:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749142827; x=1749747627;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fuOZmFIKLobNWHk8eQoGLaBU2g01hQo7WjeN5047APk=;
        b=fgA8Y8JqiVzDBIjFXg/l7/nzSldYV0LHMwH0HiSegc2XsZRtCCTKpnfqyYDkxrCHQS
         Bi40iT/SidS/Btl2G8h7dztYqI66jrSB3+WW2jScvAFK130XohuWq2aDwJM8BHQj5mCH
         cEs1tBq8iRU5KxiGe9IZM03XKxJG66hi7C0YogatoSk+Nt0dBsBGN0/TcjordmOWLhF3
         Of6jdtxc1g5Mbsj+SnpCbGKt5nRNI26Q0B6TtagySBnkqcrovJxyn3FcI0ozYPuvN8t1
         wCfqbgoV/p/bUEqPs15ReVs/RU3acTxV7l77FOfzWIHavBK+jg1l2u7h1Mj7msvzziM/
         ZeeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCa6J44uWUdN9Ru0TRjZQTzp1cz6axtE700e7tny+eWkFgt8ThUAQfHbUdTNVDEaGIHZFLwoBD@vger.kernel.org
X-Gm-Message-State: AOJu0YwIXAyRGC6WovxfCbZM7h9BD/Jw/Mbc/MjpmEGs0ZwAwGddvNTG
	w8msFlXyDXndBBmIVnUBhXDmdlN3SUyeC0UHhuQVigOJ1LgIZyVn5ADDzT22IUAzeD2pFF5lbz2
	TnIrO2xZz1kyfENP4CLdtWA9VNTCVoupz6iZUiaJTCDO7d7xUgjVD81+L9D8=
X-Gm-Gg: ASbGnctFEWAgnUNJCJYVvLM3Ik957BA5LOpvRj3cSydUkDKIT7X+1hovTWEwcmBtcPX
	uCrYdlFZfB7mz4dWmfi7aH8JiORWWDjTCx1uuONvStPq+4Hj169hCjCBc4G9ap08vJLln/rWvaZ
	hZbDm1qzseotBWQR3LyqffD02pAsXgkaAwEkFipCvmb2crwRN5y8UcmHWZUKifYkoEsvTCbAuTD
	kW/NTVBRQguykHa/zTHwes2BMfsAazSLgmJtY/usI8TCtWh9OvX0gkXtvN4qlhJjJGtPR1P1f/D
	KwmpawysB2UtRibAsoOagerWwOCfWFa+1DxezxGjKT8FSmJKFg2y
X-Received: by 2002:a17:903:192:b0:234:ed31:fc99 with SMTP id d9443c01a7336-23601d00625mr1674015ad.21.1749142825334;
        Thu, 05 Jun 2025 10:00:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHzgrE2kpRLCdNS2a/K793lVwAuMqCjPuGdo+NdhBTrA0iVs8OGFtkAaAadDo0Ht0bwuLN2Fw==
X-Received: by 2002:a17:903:192:b0:234:ed31:fc99 with SMTP id d9443c01a7336-23601d00625mr1672755ad.21.1749142824444;
        Thu, 05 Jun 2025 10:00:24 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506d14ddasm122012245ad.251.2025.06.05.10.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:00:23 -0700 (PDT)
Date: Fri, 6 Jun 2025 01:00:18 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>,
	Miklos Szeredi <miklos@szeredi.hu>, linux-unionfs@vger.kernel.org,
	fstests@vger.kernel.org,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	Karel Zak <kzak@redhat.com>
Subject: Re: [PATCH] overlay: workaround libmount failure to remount,ro
Message-ID: <20250605170018.j5ocx6n3rujob2h5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250526081852.1505232-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250526081852.1505232-1-amir73il@gmail.com>

On Mon, May 26, 2025 at 10:18:52AM +0200, Amir Goldstein wrote:
> libmount v1.41 calls several unneeded fsconfig() calls to reconfigure
> lowerdir/upperdir when user requests only -o remount,ro.
> 
> Those calls fail because overlayfs does not allow making any config
> changes with new mount api, besides MS_RDONLY.
> 
> force mount(8) to use mount(2) to remount ro/rw to workaround
> this issue, by setting LIBMOUNT_FORCE_MOUNT2=always.
> 
> Reported-by: André Almeida <andrealmeid@igalia.com>
> Cc: Karel Zak <kzak@redhat.com>
> Link: https://lore.kernel.org/linux-fsdevel/20250521-ovl_ro-v1-1-2350b1493d94@igalia.com/

Is my bug report (a year ago) gotten fixed?
https://lore.kernel.org/linux-fsdevel/20241026180741.cfqm6oqp3frvasfm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/

If this kernel fix works, do we still need this workaround?

Thanks,
Zorro

> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  common/overlay    | 4 +++-
>  tests/overlay/035 | 2 +-
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/common/overlay b/common/overlay
> index a6d37a93..5ee9f561 100644
> --- a/common/overlay
> +++ b/common/overlay
> @@ -127,7 +127,9 @@ _overlay_base_scratch_mount()
>  _overlay_scratch_mount()
>  {
>  	if echo "$*" | grep -q remount; then
> -		$MOUNT_PROG $SCRATCH_MNT $*
> +		# force mount(8) to use mount(2), to workaround libmount v1.41
> +		# failed fsconfig() calls to reconfigure lowerdir/upperdir
> +		LIBMOUNT_FORCE_MOUNT2=always $MOUNT_PROG $SCRATCH_MNT $*
>  		return
>  	fi
>  
> diff --git a/tests/overlay/035 b/tests/overlay/035
> index 0b3257c4..2a4df99a 100755
> --- a/tests/overlay/035
> +++ b/tests/overlay/035
> @@ -42,7 +42,7 @@ mkdir -p $lowerdir1 $lowerdir2 $upperdir $workdir
>  # Verify that overlay is mounted read-only and that it cannot be remounted rw.
>  _overlay_scratch_mount_opts -o"lowerdir=$lowerdir2:$lowerdir1"
>  touch $SCRATCH_MNT/foo 2>&1 | _filter_scratch
> -$MOUNT_PROG -o remount,rw $SCRATCH_MNT 2>&1 | _filter_ro_mount
> +_scratch_remount rw 2>&1 | _filter_ro_mount
>  $UMOUNT_PROG $SCRATCH_MNT
>  
>  # Make workdir immutable to prevent workdir re-create on mount
> -- 
> 2.34.1
> 

