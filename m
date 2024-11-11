Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB3E1482F2
	for <fstests@vger.kernel.org>; Mon, 11 Nov 2024 19:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731354330; cv=none; b=ZT42OmXH5/v7nuizMus644BQzOl0KJctvPD0NSUOyY8Av6+UFkpxYKvcmpgZLEKXaOmFt7RroFBwJ3AWGRY8qUV9vPCfP7qlavZqysfD+7HyuVC6mgg8Hp0BwVupi0xlVagSOeAA29J72cSfEZiQmuqqT+neSVFTCFEu1SB/ZzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731354330; c=relaxed/simple;
	bh=fVIwmPSEyggbFyf3YoqDBAG/ttDebsnDiuaZIkJVWks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jmJRccIOS1aAkDkI4BGCsJ93t8AqrC+NXm0cGnIOyIgI2MbnjbgEkqt5hZ7LMTmps7IE30UqzUz4b1L+pASxCIOIDDaqcndmkFX0G4+RfT3cLUV+SNLDQ2eH5EUKaJHzknx5hhCUizUHY+H+ScWQjf/DFbOEQ5T7/75w9as8TR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sm+75VVC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sm+75VVC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731354327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KqLw0TSAVME91KT/AGX/wbm5nqSWrShInFV5Vs47FMQ=;
	b=Sm+75VVCjsaGQae28aVBULUiOPQj5r4maCbgvadJfwThTqCX9ZcBy33IfJ/1pZ/yM2fHWc
	h3y3NRlSaodthhU1OgV7WPTbJ5NlqbP1jE8t/ktBb1iFCDnLb2cMYLnRSst6/uS6wrC+7L
	fb1CEJe1cydusQhHJbmvSumxu3pFOqE=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-Fq2z0RLiMZCVbZg6zjecFA-1; Mon, 11 Nov 2024 14:45:26 -0500
X-MC-Unique: Fq2z0RLiMZCVbZg6zjecFA-1
X-Mimecast-MFC-AGG-ID: Fq2z0RLiMZCVbZg6zjecFA
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-71e65e09f8bso5252577b3a.2
        for <fstests@vger.kernel.org>; Mon, 11 Nov 2024 11:45:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731354324; x=1731959124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqLw0TSAVME91KT/AGX/wbm5nqSWrShInFV5Vs47FMQ=;
        b=hRGD/0snmIGep7gtJ+Yjr3s0f+GMf/+4Mgj/S0j/UMHOr8laEsbVCvdM0N3HD6AtM/
         bHTo7TNN8F/L/aQi1D5CdglmgP7qWzX3sLWsI80JcsNcb3/TyGBRxfA0OPnoxsdrAQlw
         mpilPyfH/k0y1LOmLnhRS3r7c+TMXzlCVWz/WFRJ9OO4Z3+WwIZZ9Oa5k4RXPtAS8Ihr
         FYM1E9ffSRe6182KuI1d6Ce/nayeS8KTJqOl4HYrw7xCVQC0XbkDgD74ipNTNh+ZTf86
         zno/L2QgSgaQrsU32dQJzn6vuld8nEWGZ/+mE0yRXDml+FyQ9ZDGklG4KTqQkzlGAY4c
         oFjA==
X-Forwarded-Encrypted: i=1; AJvYcCUCvy8Uf/rPhObsqNde1OdBEAkV2zuCjDM5ADlQ5KKmTheTE23l9LiabwO/3hYfqTbwUkEs6FRU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9UJDWHCEXJEvTBrA/9mx808h159GLgq6p5CirVawkgYvUhP9J
	M+eTTnzd6UG2pDBibZY1OqgWHg5zgownRZrQjV/0hpNcsR1UyE3d0dt90EBPn69F2Ncbnk5/cz0
	4MgBUVOAv9DtlEduJX3DKa51DJDED9Qfm4PILDsPp3Lhb3Yp0qF0BLs4=
X-Received: by 2002:a05:6a00:3cca:b0:71e:7ab6:8ea6 with SMTP id d2e1a72fcca58-72413384ebbmr17526345b3a.25.1731354324220;
        Mon, 11 Nov 2024 11:45:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGCewOlB11baezzNOtqcqMmLjJAQuXf7s20SaqBym9VA1VaSckalXwtsvHt9UtOnDk0qPAdOw==
X-Received: by 2002:a05:6a00:3cca:b0:71e:7ab6:8ea6 with SMTP id d2e1a72fcca58-72413384ebbmr17526328b3a.25.1731354323886;
        Mon, 11 Nov 2024 11:45:23 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a7ec7sm9507541b3a.55.2024.11.11.11.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 11:45:23 -0800 (PST)
Date: Tue, 12 Nov 2024 03:45:20 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <jth@kernel.org>
Cc: Anand Jain <anand.jain@oracle.com>, fstests@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH] fstests: check for ext3 support in btrfs/136
Message-ID: <20241111194520.qxilxxu5nf5lenjy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <4c41adf81241f5d23b5a10251564b1630cabc500.1731327765.git.jth@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c41adf81241f5d23b5a10251564b1630cabc500.1731327765.git.jth@kernel.org>

On Mon, Nov 11, 2024 at 01:24:53PM +0100, Johannes Thumshirn wrote:
> Test-case btrfs/136 requires ext3 support, so check for ext3 using
> _require_extra_fs.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---

Makes sense to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/136 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/btrfs/136 b/tests/btrfs/136
> index 9b5b3331119f..2a5280fb9bd1 100755
> --- a/tests/btrfs/136
> +++ b/tests/btrfs/136
> @@ -20,6 +20,8 @@ _require_scratch_nocheck
>  # ext4 does not support zoned block device
>  _require_non_zoned_device "${SCRATCH_DEV}"
>  
> +_require_extra_fs ext3
> +
>  _require_command "$BTRFS_CONVERT_PROG" btrfs-convert
>  _require_command "$MKFS_EXT4_PROG" mkfs.ext4
>  _require_command "$E2FSCK_PROG" e2fsck
> -- 
> 2.43.0
> 

