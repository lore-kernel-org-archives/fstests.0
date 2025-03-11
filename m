Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A16F1D63E2
	for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702260; cv=none; b=ufnvngrg5mVvFDqPFO7oFWucSKxG5jFVeqIhUesgh99bZpFQihPk/S4gD9uenZlWZOiKc+86cBZn24wshuYVJd++i5sMtXlY+Cx3jQI9gB9a7ccTSiMWvCj26jhJPiqTfP2Yl6oLAqFH/4VXAfxZQrcCEbAsp5/wtOTa4VuQAdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702260; c=relaxed/simple;
	bh=IFdzE8aWAG0/ZbYQeMGJj4OJEDclSTteZZS2tMWfxiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tExLcieakGHLCggjxG/A07ZhJzxDwT2A3EOtVQcKvDoz7HkCktX4vMvWYi36PvokkG0kByh1fjPWlDW0TYbVz44XfLlgln6yVfVps+yrj8vToybA+FLUx9xzVUelRS1g+LGQ3N9CCrYnSMRqNbpkG0y2UZFYG4L6/ZMUkTR9WqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JE4LpVlx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JE4LpVlx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741702257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SkvND+eYHH9qsacQ7rfWb/ck3Os9E/r1JZIjq4LYTVM=;
	b=JE4LpVlx9PiD7dDjPMTD2uI/BMLuO2l91vwbsaOESmpZ+/U8aD2KYJ04i22MIE32Od5IR3
	FXYQRb0SsPy+s3XPFWcslddfqtZ05G+mX3oCjCxm2OwWWkyETfA9y1WheyTrs3wEOb1js4
	MbiT21dQeeo5+m5An0w11jt2qPwhSPM=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-rnSVPEPcMMaUUqp52HJEuQ-1; Tue, 11 Mar 2025 10:10:55 -0400
X-MC-Unique: rnSVPEPcMMaUUqp52HJEuQ-1
X-Mimecast-MFC-AGG-ID: rnSVPEPcMMaUUqp52HJEuQ_1741702253
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2241e7e3addso77796135ad.1
        for <fstests@vger.kernel.org>; Tue, 11 Mar 2025 07:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741702253; x=1742307053;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkvND+eYHH9qsacQ7rfWb/ck3Os9E/r1JZIjq4LYTVM=;
        b=dbTBsHKRSuMZhkepALrLnYH/aSkh+Zmah0PyBZkfRp3O4fQ0Va4jNKOWgGBuTCyArd
         dWVm7rp7ziDy81eia2xwIf4kCK0fZf/REVf9a51Fmkm8KNn7kHf3sneoVaYAs5B7lh5v
         sKuvFhB/9bXlSqSUkmMX6HAZMqBUKs7ks0iNB0jUfulDQ5Rt6NQk6M43+RI9OvAYad+A
         gjq3bukBcTKnNBveVGeQ4t03FXNOpbIMv3f7L7XO9piyA55n2a4wrb/e7faJBr8h40yW
         Qz84N3jycdW1nszEikUxwVeGMTeyerj16nLqO7RgQWG7DE0By/ycepcSEAjl7wtEi8q8
         LF1w==
X-Forwarded-Encrypted: i=1; AJvYcCXROKAQhICFhqHdf/jYpDGHrjMzfMtEuMFx42ySpYLQlXdai7JijU90CqVcjUBHIsNIFn4jqaXI@vger.kernel.org
X-Gm-Message-State: AOJu0YwNqADJASFNTZmuGVpvk5wcuIEYgWS7ALamuepae8ciy1gz46e/
	DRXpvH4FksohYr3ZGtxIqkg4vfEuASvQwnBDjTgRQ1HjHdClaqw8ZWXdDvx4VF/G8gsdyX5cG6x
	v3YTETBoRrkv2Bo0q8ww6RZPIZz5uDzGVgUx4heimdDRezWH0lql2lMc=
X-Gm-Gg: ASbGncuaQFLlZQD1gUOJ990/4ZR5v8IrF1+vqC6H2yyqr1t6qfkNafFBLuaYndhHob/
	cXDZSjv/r6uhaQvViwX8R7E4K9xugsGpp9lpS4N/55Yp8jsxEKyZDVjtohHOkoyTyHnR/QlbSdu
	aYtMyRFa2dEnmTMKr0RG9/L6enOfB+2X6A586njyz46oFPark6ZUdue4lywHwQ9yHQ9isLTBAmo
	MgbsUby6TNgT3CNAWr142/ftqgl1Bu2Fy4Crv30Xx5kxg60OiVTXCHGtfw7/YzDxvPD0EgOUSUR
	vP30vIomRmbsKYyiMRuGmHCpnwmwPt7bPf1iki8KXjsn6d9OYz5fVESO
X-Received: by 2002:a05:6a00:a09:b0:736:ab1d:83c4 with SMTP id d2e1a72fcca58-736eb65d07amr5709722b3a.0.1741702253333;
        Tue, 11 Mar 2025 07:10:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGBAe6qYUv/1LSdx10iDSl+9jxSxX1nvqdNSscZ0FP3Zlo9UqY1wsdnnJeIUzm79j1aANS0w==
X-Received: by 2002:a05:6a00:a09:b0:736:ab1d:83c4 with SMTP id d2e1a72fcca58-736eb65d07amr5709685b3a.0.1741702253020;
        Tue, 11 Mar 2025 07:10:53 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736d8f0ea83sm4312868b3a.143.2025.03.11.07.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 07:10:51 -0700 (PDT)
Date: Tue, 11 Mar 2025 22:10:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 4/6] common/rc: use -f for mkfs.f2fs by default
Message-ID: <20250311141046.hpwurbjqc6dbwoml@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250311080430.3696582-1-chao@kernel.org>
 <20250311080430.3696582-4-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311080430.3696582-4-chao@kernel.org>

On Tue, Mar 11, 2025 at 04:04:28PM +0800, Chao Yu wrote:
> Otherwise, mkfs will fail due to there is an existing filesystem
> in the image.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v3:
> - split change from f2fs/009, and cover both _scratch_mkfs() and
> _try_scratch_mkfs_sized()

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/common/rc b/common/rc
> index ca755055..23b642f4 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -993,7 +993,7 @@ _scratch_mkfs()
>  		mkfs_filter="grep -v -e ^Warning: -e \"^mke2fs \""
>  		;;
>  	f2fs)
> -		mkfs_cmd="$MKFS_F2FS_PROG"
> +		mkfs_cmd="$MKFS_F2FS_PROG -f"
>  		mkfs_filter="cat"
>  		;;
>  	ocfs2)
> @@ -1336,7 +1336,7 @@ _try_scratch_mkfs_sized()
>  	f2fs)
>  		# mkfs.f2fs requires # of sectors as an input for the size
>  		local sector_size=`blockdev --getss $SCRATCH_DEV`
> -		$MKFS_F2FS_PROG $MKFS_OPTIONS "$@" $SCRATCH_DEV `expr $fssize / $sector_size`
> +		$MKFS_F2FS_PROG -f $MKFS_OPTIONS "$@" $SCRATCH_DEV `expr $fssize / $sector_size`
>  		;;
>  	tmpfs)
>  		local free_mem=`_free_memory_bytes`
> -- 
> 2.48.1
> 
> 

