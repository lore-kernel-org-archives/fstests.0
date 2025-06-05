Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DE618C06
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749145216; cv=none; b=OzDTg4XbInffVvNLkx+S7dUxg22LnRAK9tSGQsE5mjKVrW5FHtKpOijy9Atpyni5q4MkdVheJse21F9Xi1TqwVruv8P8mPcBYIiNLkU9jJsHDTM7nZFN+8C566gn9wAlNNtqwgmwY7tNinukAG0ULrS6Grfs2r4EdQljfqaRJKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749145216; c=relaxed/simple;
	bh=RgKv1r9IMVTt3VDeHdXbu+22e54VLGyQXnhS0LiTUJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbBspGGr5UH85l7CqV+W+089Q9VD7ZV6gySQgdld3LQg/A3tr5AYF9jI9gHDelBrbQzVVsSLkNmcnOjtxRIGdK57Nlxoi/QB+x9sdcccu4Udzws2X/ZR+iT8jRxziWU9p/OwC9p7/yNG8VSCGXktuN9POnVaYdSIBaLSqufuXwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P8H1JImg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P8H1JImg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749145213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vwlg6lBxqGffvf2DWVfbPKyt1snNbKUQBjmobD4isok=;
	b=P8H1JImg/KJRKi4VcCTRik7bUEGpLjsHQ4/W3WqyXG4hgjs727jtIyXcHnec/TXl/6oMZz
	LdAX557DPCVH7h+5t4tGjgTd9dhT3TtracyJ8/JPtdiGGC4w465gRmavz7IcMdXuKSi5xL
	g4hjG9x8o+d5FhYEHdPpdUWI1HD1YFE=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-L13RRrvUM4erJBHVJ1Oaew-1; Thu, 05 Jun 2025 13:40:12 -0400
X-MC-Unique: L13RRrvUM4erJBHVJ1Oaew-1
X-Mimecast-MFC-AGG-ID: L13RRrvUM4erJBHVJ1Oaew_1749145211
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2358ddcb1e3so17033165ad.3
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 10:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749145211; x=1749750011;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vwlg6lBxqGffvf2DWVfbPKyt1snNbKUQBjmobD4isok=;
        b=mObyO7UlMukkVxq63GdUkQij1JyKyzZbOb0A7bOkez5k247fgFKwUfMrAeQm3hBQ1o
         8vixpvhzQL+P2K/OXZwZoxInoHMpVahq1UnAhAe4LG1sl7caueJhnoBZN25VklREWcPI
         Xcwb+oUE8q2JsuoxVHSXXDQ6Dl/V/7d5kuURVUKcxQ0C8/hUOhmWVN2Z75v137sEOYPs
         bP4Eps+QQV+wfnR7snK1LCzZQ4ixRbhF06jH5dKMYQal1MAtMSgki6kAkYSiHbFAg4zG
         mxnRpb2WsxS53QGBA1uVfZXKDYqUT/SfgO+y9oZ0zbvB1/c2xw38tBaHLybDcHwDNkT5
         0/3g==
X-Forwarded-Encrypted: i=1; AJvYcCUjJcuHdWlbPVvalyA3qBNFzHuSFfLjk786UBhz6iVZuIx4NRwq9lWbSn8n3MwUacxSvJwJLvFe@vger.kernel.org
X-Gm-Message-State: AOJu0YzujWJOZugmQimrdHpC/Csm7L/nS4HSd3bKWnYvl/jICDLWsAWS
	mm5JTtA+FC9DYzsVzh4OQ8rHAMRfdjD2wCTlap93a4rchcjiIXBnF6TwaGU2HYLBDosZ1+jySMw
	yZZLE0yqqotGG7MyXZ4lw35CK0mDHYPDRxo5FGNX4Q6ok0oQ6Wc9B5o6Aj0Q=
X-Gm-Gg: ASbGncsUlbbxYQUx8d7fCjYnN84KwJ4KV3soX5Oc20/aof42wjJXYuOEnevzZP/NIkZ
	D1dtdUUvRP/u4Qx9M6MIalaKh+uxmWSFXtQAmdQtTD1z+WdpOLUeajJQc13WqmsxqJcl61zBrYJ
	p/rdTOd9tJsenYSB3igXzXdJ/XLySRUdE6Gq7pDtswfkqawZ9p345vRhZuxG0dQIAzNgfBM9Q4n
	8/RCEsMmvKY4xWOg2sN/lZPWd9LXCW4fdQg2MPUNCmyElgyxO6ZYm41FBYSp6azgoaG79nfab+T
	pfxyjYYBe9fXjvNGXLi0vUKtxM8wZKZxjqFXhZQviNyiv1oYDS1R
X-Received: by 2002:a17:903:2c9:b0:234:d778:13fa with SMTP id d9443c01a7336-23601d13585mr3047985ad.26.1749145211089;
        Thu, 05 Jun 2025 10:40:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpVCJ3fno+BTFvqglRT+vOva1GLEiRKThNEttAa7fgb6sGBQnKHmEA7g9ycLT/9vb9cdIqkg==
X-Received: by 2002:a17:903:2c9:b0:234:d778:13fa with SMTP id d9443c01a7336-23601d13585mr3047735ad.26.1749145210790;
        Thu, 05 Jun 2025 10:40:10 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd34f9sm122066655ad.157.2025.06.05.10.40.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:40:10 -0700 (PDT)
Date: Fri, 6 Jun 2025 01:40:06 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2 3/6] generic/604: do not run with overlayfs
Message-ID: <20250605174006.6wu7axncn2ytdf55@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250603100745.2022891-1-amir73il@gmail.com>
 <20250603100745.2022891-4-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250603100745.2022891-4-amir73il@gmail.com>

On Tue, Jun 03, 2025 at 12:07:42PM +0200, Amir Goldstein wrote:
> Overlayfs does not allow mounting over again with the same layers
> until umount is fully completed, so is not appropriate for this test
> which tries to mount in parallel to umount.
> 
> This is manifested as the test failure below when overlayfs strict mount
> checks are enabled by enabling the index feature:
> 
> $ echo Y > /sys/module/overlay/parameters/index
> ...
>     +mount: /vdf/ovl-mnt: /vdf already mounted or mount point busy.
>     +       dmesg(1) may have more information after failed mount system call.
>     +mount /vdf /vdf/ovl-mnt failed
> 
> Opt-out of this test with overlayfs and remove the hacks that were placed
> by commit 06cee932 ("generic/604: Fix for overlayfs") to make the test pass
> with overlayfs in the first place.
> 
> Tested-by: André Almeida <andrealmeid@igalia.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/604 | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/tests/generic/604 b/tests/generic/604
> index 744d3456..481250fd 100755
> --- a/tests/generic/604
> +++ b/tests/generic/604
> @@ -13,6 +13,9 @@ _begin_fstest auto quick mount
>  # Import common functions.
>  . ./common/filter
>  
> +# Overlayfs does not allow mounting over again with the same layers
> +# until umount is fully completed, so is not appropriate for this test.
> +_exclude_fs overlay
>  
>  # Modify as appropriate.
>  _require_scratch
> @@ -22,11 +25,9 @@ _scratch_mount
>  for i in $(seq 0 500); do
>  	$XFS_IO_PROG -f -c "pwrite 0 4K" $SCRATCH_MNT/$i >/dev/null
>  done
> -# For overlayfs, avoid unmounting the base fs after _scratch_mount tries to
> -# mount the base fs.  Delay the mount attempt by a small amount in the hope
> -# that the mount() call will try to lock s_umount /after/ umount has already
> -# taken it.
> -_unmount $SCRATCH_MNT &
> +# Delay the mount attempt by a small amount in the hope that the mount() call
> +# will try to lock s_umount /after/ umount has already taken it.
> +_scratch_unmount &
>  sleep 0.01s ; _scratch_mount
>  wait
>  
> -- 
> 2.34.1
> 

