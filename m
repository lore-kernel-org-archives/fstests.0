Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D87618CC15
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749145658; cv=none; b=YkmlNeAfT+sMAC0D8siZXSmi9z3RWFHpF1bycrdjbN+aLyPB29JS3VzgO4jW1HfVVoQ1hDlFWMEKI2xnhZAHOa7FCvnuKXhzEKbCtHWe1M5SofnOO6dUbjO5SBSXVYRuXjwcK+Tf7ATmMueqtRIpaxxli61th/l4qtfJMMPZMJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749145658; c=relaxed/simple;
	bh=0+4mGifBSZ1EUI6m4L7viLeZiFAuPEG/1VNn01841fE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz6P9T/Rmkm9mNei/IRA1Wzmbg+koO22gFfMly6L+9vkb05RVVvhmgSIQTpRQFrBJ3rOl1p6YsLXwy4bReXcwlVj0UAjZMH/HOnh6Xvo9vPhPKXzLf62NRjtAc+v78QGkza1l2BvYZ+LR3q9KKoDNvFDIfDXxGLzBeNdWd/vRew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IC016rBo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IC016rBo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749145656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dBYDgkCaHV8aab0ys3GOL9Tm4EBDoblxVnSYokg/638=;
	b=IC016rBowHoCv9XChQZNjL4sKtHAhK/ybUrht8HPIkjMNA7G1uLFtzQ4cX8p7qd735Roc8
	WLz9AXM+JvhYvlttHPe8hnTbeYrO7vfW4Ykb1Xf4y7R2a/UdN5wpYwrMg6fpMx+X0tqU7A
	7vyX/MWbnscx73X8gqJQoFDUTOv86g8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-U14dZse2N5aDhn236pH7Dg-1; Thu, 05 Jun 2025 13:47:35 -0400
X-MC-Unique: U14dZse2N5aDhn236pH7Dg-1
X-Mimecast-MFC-AGG-ID: U14dZse2N5aDhn236pH7Dg_1749145654
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-235e3f93687so18358185ad.2
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 10:47:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749145654; x=1749750454;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBYDgkCaHV8aab0ys3GOL9Tm4EBDoblxVnSYokg/638=;
        b=Rn+jn5BGlPbSAJlIaQ1BGgASeg0mJaQTEHxtlezXNA9FK95JF1OtlbP7DCXemVYmsq
         7p4wXQeihHvhnH1EqggVU6s9Cl8sxcpwFXVfz7441DNWVU0CPPpxwOvcvk+lozAiEkqq
         nak8/YTwaEDpMhOXeHmC91KCwkuUvVbqDbTElZ6er/OoHjO9z0bUPImYGEVh9SI6HdAP
         E5UzoGYifnJUu/xWWO5jtkjXuwK033IErY7ht3ptwqy26qMvWtDS8wLuPW2aUR+cUP+K
         kF6Da1AWDAf13wXXdbB6+/lMQ1SeEjYzOa0l4s16aspontzvM/A2p01zgCURioLpO2BK
         D6ug==
X-Forwarded-Encrypted: i=1; AJvYcCWz6I56HXYN+M/T4kdrM8WxTWYDcQstoVG4MfGkuiUxCANE+2BMhv4HIKeQkBivHgvcOVNGbzNQ@vger.kernel.org
X-Gm-Message-State: AOJu0YyBULOSLimJjMxCIIPitN0eBbu+yBWiy8yne/obxz4w9AXJa8D3
	HM7i7P15sJBfAu608d7oBEEVNo3qIYH/l5bTPrnbYHOi737K/wnZQZJruCv+dGZxTTz9uh4edZX
	CaB0ys3dSIf9VQfnYd94gSWgyAeLGMA7Lbvpge/LfMySNybejN7vruxMHIkM=
X-Gm-Gg: ASbGncv9ZU4ixtWDh6b2B6F8RPhRHY8VS+YtKgydXKeKwfDMBx7MbbvTmwyNSefAb48
	a7kV6nYGU6+egGLeVN7QIstNFor2h9VS+H8Gp7JJcoDsucXg6IZtFg9a20ioLl9NYCrB0q1ydlF
	OLw+v1Okq0ZcKEDFwV4FZxweknP67I4NfK3rtPGcKXcpmjTD8lbizx7amkJJcmCnq08oUsNgj5n
	aFQj26FLdAdfDLRf4kFVEStxW+eWCQTZyCcDOYW0NGSRman9ncKw2qgtxr7unu3dFlXqjF7+pGp
	zQIzmyVDG1iMTBHGsK4TIhr17ixTgdyfCHECHaEe4zYZDkFmb2A5
X-Received: by 2002:a17:903:1c2:b0:22e:5d9b:2ec3 with SMTP id d9443c01a7336-23601d15070mr3398655ad.30.1749145654212;
        Thu, 05 Jun 2025 10:47:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHntklI8byJnLAxFpamewVIn9BIYz/sV/5rQcCOncdhNXAit1fPuWdjcLRw8hmQSV6bhC5qvQ==
X-Received: by 2002:a17:903:1c2:b0:22e:5d9b:2ec3 with SMTP id d9443c01a7336-23601d15070mr3398455ad.30.1749145653887;
        Thu, 05 Jun 2025 10:47:33 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2ecebb4e99sm9075455a12.65.2025.06.05.10.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 10:47:33 -0700 (PDT)
Date: Fri, 6 Jun 2025 01:47:29 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v2 2/6] overlay: fix regression in
 _repair_overlay_scratch_fs
Message-ID: <20250605174729.klfoqsct36v6e6lt@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250603100745.2022891-1-amir73il@gmail.com>
 <20250603100745.2022891-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250603100745.2022891-3-amir73il@gmail.com>

On Tue, Jun 03, 2025 at 12:07:41PM +0200, Amir Goldstein wrote:
> _repair_overlay_scratch_fs assumed that the base fs is mounted.
> This was a wrong assumption to make, and that was exposed by commit
> 4c6bc456 ("fstests: clean up mount and unmount operations") that
> converted open coded umount in generic/332 to _scratch_unmount.
> 
> After this change, there errors were observed when running generic/332
> if fsck.overlay is installed:
> 
>      Check for damage
>     +fsck.overlay:[Error]: Faile to resolve upperdir:/vdf/ovl-upper:
>                            No such file or directory
>     +fsck.overlay failed, err=8
>     +umount: /vdf: not mounted.
> 
> Fix this by making sure that base fs is mounted before running the
> layers check and fix test generic/330 to conform with the umount
> conversion patch.
> 
> Fixes: 4c6bc456 ("fstests: clean up mount and unmount operations")
> Tested-by: André Almeida <andrealmeid@igalia.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---

Thanks for this regression fix from overlay.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/overlay    | 2 ++
>  tests/generic/330 | 2 +-
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/common/overlay b/common/overlay
> index 0fad6e70..0be943b1 100644
> --- a/common/overlay
> +++ b/common/overlay
> @@ -434,6 +434,8 @@ _check_overlay_scratch_fs()
>  
>  _repair_overlay_scratch_fs()
>  {
> +	# Base fs needs to be mounted for overlayfs check
> +	_overlay_base_scratch_mount
>  	_overlay_fsck_dirs $OVL_BASE_SCRATCH_MNT/$OVL_LOWER \
>  		$OVL_BASE_SCRATCH_MNT/$OVL_UPPER \
>  		$OVL_BASE_SCRATCH_MNT/$OVL_WORK -y
> diff --git a/tests/generic/330 b/tests/generic/330
> index c67defc4..901b17b1 100755
> --- a/tests/generic/330
> +++ b/tests/generic/330
> @@ -61,7 +61,7 @@ md5sum $testdir/file1 | _filter_scratch
>  md5sum $testdir/file2 | _filter_scratch
>  
>  echo "Check for damage"
> -umount $SCRATCH_MNT
> +_scratch_unmount
>  _repair_scratch_fs >> $seqres.full
>  
>  # success, all done
> -- 
> 2.34.1
> 

