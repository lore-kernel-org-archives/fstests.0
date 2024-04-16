Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D1C2907
	for <fstests@vger.kernel.org>; Tue, 16 Apr 2024 08:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713257408; cv=none; b=YtjlQWuQ6XG1KDOAKWBRPZjok3GoK/UMRHPySskgT2JF/y4+PmxKKWqt75TglRbHfKXD/2EUMt0eblnNeJqYoXlV+sTbd5Z9/UiN0IhUdE0LmojWpqzWMe/SMIyM3QltAl1mho3u3u5MNjBPzS6OyF9w4UIVm3mYsRs7If1XPUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713257408; c=relaxed/simple;
	bh=QtVMzZVYiBAZoVGdF9uXTKQ9diOfKuliUkEkMfVc1gk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IkwAMgdcWL2LfG+Gs7FoA+yAwEKv3AZXVnwoGsId68pf32S2TjNaLGJ65ARHjysK+Szj/bRwlzexZ/Gg09E/2BomQK84sgJsHO/YrQly6AnDHIxxorOuba2M+MibH7FLzjNRiqEWg0aVg7ZN10JasH7Emljol4j7YnLVgXf9Z+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UI5zWEel; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UI5zWEel"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713257405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8RD2gvEXUGgZfQHIzAcpv1uGMzDLpBLeVk35oktMnw=;
	b=UI5zWEelQfqWbuKtsjvwU5xxQ7fMWEQvEOziutVLP7eVMzi+fFE+5shtx5N2yyd7gF/lsz
	0hz3k4BnCxEYUh6c1maZK9ROg/XAsR3V+NpDZ8nldqpWKlrXxjeeWxivU602GnJG7LGBzR
	wGKuI13H+sOyqoOtWajj5RskHrD4sjg=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-94-v57DgVlAOgiRMp6wZmcbBw-1; Tue, 16 Apr 2024 04:50:03 -0400
X-MC-Unique: v57DgVlAOgiRMp6wZmcbBw-1
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3c6f9759b63so3133830b6e.1
        for <fstests@vger.kernel.org>; Tue, 16 Apr 2024 01:50:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713257402; x=1713862202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q8RD2gvEXUGgZfQHIzAcpv1uGMzDLpBLeVk35oktMnw=;
        b=rcqhtv43qsUQb1OQYQImiSwOVO8AxurhyvMSRY+nUdBsbC4S5KFZhmUZnrb62EazQc
         pzw5thxBSnQR7VV6cryL4jJcfh6HuY/M/WiWvuFhf+7yam4UYvkgvpj1TN/BdXO5R3dL
         ghr/x68te6nL98humkIydObaKFxuh4/F8f+4x8py3t45uHSRhlOk/T8vWbkPcPS6jMLG
         5E3XoS4rWMsWyPeBivaLqGWdtwC/Zn/FhwoOdxcceQRY8HbDpo7poHvHdmOFqhczUFpK
         c9k9ZWJO6DeGEIe9zsnWtL1LNv4xlPZRU9o4FgDtoxd36mfkP/vKd49z85RdfwgQMCL5
         tEUw==
X-Gm-Message-State: AOJu0YwmVaJeGIFNAqlYNMfCxjJxiI2/CshkNclForp0r5uby41AwVRr
	otPBYzDHekcrdEdKoRDhbD5tFDokEp1p/U+oufr5odqrfgwTZtTbNU/KH4PJH9pPSpE1Wwu92pZ
	fAs4NkqYKRm7ee6jmO5N6LF5uUTxnsR6EjYBfd6NELhFM6NIn8pLHWWsmFk6ReUWccg==
X-Received: by 2002:a05:6808:60c:b0:3c7:539:6d8b with SMTP id y12-20020a056808060c00b003c705396d8bmr8292310oih.30.1713257402608;
        Tue, 16 Apr 2024 01:50:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGD+NZXeFBRK/CkYLLjU5Een2fNjTAeT8LZ83PkekgAxytpKPK6wuNEn2YWXmxcL8r1pAVueg==
X-Received: by 2002:a05:6808:60c:b0:3c7:539:6d8b with SMTP id y12-20020a056808060c00b003c705396d8bmr8292290oih.30.1713257402100;
        Tue, 16 Apr 2024 01:50:02 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bn19-20020a056a00325300b006ed0b798f1fsm8537485pfb.119.2024.04.16.01.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Apr 2024 01:50:01 -0700 (PDT)
Date: Tue, 16 Apr 2024 16:49:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] common/quota: fix keywords of quota feature in
 _require_prjquota() for f2fs
Message-ID: <20240416084957.gyavejnhja6mofvo@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240416071819.5004-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240416071819.5004-1-chao@kernel.org>

On Tue, Apr 16, 2024 at 03:18:19PM +0800, Chao Yu wrote:
> Previously, in f2fs, sysfile quota feature has different name:
> - "quota" in mkfs.f2fs
> - and "quota_ino" in dump.f2fs
> 
> Now, it has unified the name to "quota" since commit 92cc5edeb7
> ("f2fs-tools: reuse feature_table to clean up print_sb_state()").
> 
> It needs to fix keywords in _require_prjquota() for f2fs, Otherwise,
> quota testcase will fail.
> 
> generic/383 1s ... [not run] quota sysfile not enabled in this device /dev/vdc
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  common/quota | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/common/quota b/common/quota
> index 6b529bf4..cfe3276f 100644
> --- a/common/quota
> +++ b/common/quota
> @@ -145,7 +145,7 @@ _require_prjquota()
>      if [ "$FSTYP" == "f2fs" ]; then
>  	dump.f2fs $_dev 2>&1 | grep -qw project_quota
>  	[ $? -ne 0 ] && _notrun "Project quota not enabled in this device $_dev"
> -	dump.f2fs $_dev 2>&1 | grep -qw quota_ino
> +	dump.f2fs $_dev 2>&1 | grep -qw quota

This will _notrun on old f2fs-tools, due to `grep -w quota` doesn't match
old "quota_ino". So how about grep -Eqw "quota|quota_ino", or any better idea
you have.

Thanks,
Zorro

>  	[ $? -ne 0 ] && _notrun "quota sysfile not enabled in this device $_dev"
>  	cat /sys/fs/f2fs/features/project_quota | grep -qw supported
>  	[ $? -ne 0 ] && _notrun "Installed kernel does not support project quotas"
> -- 
> 2.40.1
> 
> 

