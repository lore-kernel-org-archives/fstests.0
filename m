Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E7F67E79
	for <fstests@vger.kernel.org>; Fri,  1 Mar 2024 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709290826; cv=none; b=brdqDER0yTbvKCfcW0kALu5A/VQutWNeKcUonfWZh0GWaU1+KAvS8UaAXbf1wWLJxq58KnVsgLWk6PafCgIapNvBytqsh1Qn2smuahTWTG4pXB06oM4v/CjPBDL6ztFZ+M7ey39+i/p1OVcSXAlS7yIfjx8W9nCqknUuQA2fbJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709290826; c=relaxed/simple;
	bh=18vaJbDhToOFq21EuQHC+XD7+N8JzbZMHO6oTRpH/bA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rZ9dlU42VZ7adeB/G9t1Z+uCmrTu7iTLPxN4cHuoFoGlaUaCbCLsu/RiVGDltGEmomCxMF/D6kFGy6qH46Nh7vmZZlPOXGKEhkFD5frKGKbbYSC0QkqHBCrgr7oO/jhIi0lmL7QLGKgKs9BebQrVJBIKNAVPfLamZQWz69xpkCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V+KENv/M; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V+KENv/M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709290823;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rAszOXrcQ2W8OsdF2/4MNcDOJ2fSkKZ2hwZAaKVGNcQ=;
	b=V+KENv/MgSu6jcTrfAXrgodseTDRE73ltukER6MdFfxsKc/yLS+FcmNi9XNubeQpzX7WO9
	elGTSrIHLalWN3yRZPlS6PrZK5vaS2dbU8sitSlQBGoVWs3b87H9rjKvc1utR9Ql1jHQVx
	XyfckrW0Qc9hDhnBevDzcCUu5OuRR4Q=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-AEV6XJ_ZN864fa9nBJlajw-1; Fri, 01 Mar 2024 06:00:22 -0500
X-MC-Unique: AEV6XJ_ZN864fa9nBJlajw-1
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1dcabec8fddso21584485ad.2
        for <fstests@vger.kernel.org>; Fri, 01 Mar 2024 03:00:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709290821; x=1709895621;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rAszOXrcQ2W8OsdF2/4MNcDOJ2fSkKZ2hwZAaKVGNcQ=;
        b=hioG+rK/qnkTzTYWb9PCet3tebNJ9hSePjRaPdcLkTmMlWUKVWIjsOJ0MoGaFCMvne
         N/NF5I9Rda/zgjjtp9paEOKOZIR/HGM3erznEE4TpZNbDLqmQMEUSQLrZCSqF2g0mfiH
         ejFc+HlA7aQYspm9E43okf3RU2Go+fp2jdW6vKse+fn1r3YGiRUnpEv5JsJi67E20DCi
         0qU+O3n8L13kWqQm8T8sMQ/8CDPjIJkQfQWezcNo/Ja/soq8Y62KJ/1Z0FgeDZFanyBH
         hlYvLpPiNtn/SYeSbVewEgH/Syc0sHmfi943b+TTN/ImmJOkly7HmWNjFzgzqhOePSd6
         Pycg==
X-Forwarded-Encrypted: i=1; AJvYcCUX+KbtKXZRH9CM2nWcmjfUWd3REDZ7a1sAsDOlAIoBjdUdNOBB8QDTdtL98zmzwhm6b2G3YT52BZrTFLBD3bbEPPs2aIeSjQ==
X-Gm-Message-State: AOJu0Yyv95MHibXplA/zUVuGvwBMqdasndmkMr3heQlJKr31ItBoLGvG
	KAGizna3loACFrFoznEgg+wHYKmuMhp3o1cZ2XDzl2yNgFyL4ElLYooH2ZQldG+0wLFb3WitHGu
	V1VCpTucIL/pIMHQnUAvIn9aEjtt+AzOpWeo0fV1X/DYv6ZHJtxqDOBg=
X-Received: by 2002:a17:903:1248:b0:1dc:adad:f54b with SMTP id u8-20020a170903124800b001dcadadf54bmr1190386plh.44.1709290821025;
        Fri, 01 Mar 2024 03:00:21 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEx7bX4MpACJgJ3SiOQkG26r2Hzrom8jahSHc9EgKfUMnl/jl8InIV9fK8J/dX5A11aYdtjpQ==
X-Received: by 2002:a17:903:1248:b0:1dc:adad:f54b with SMTP id u8-20020a170903124800b001dcadadf54bmr1190350plh.44.1709290820220;
        Fri, 01 Mar 2024 03:00:20 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id kx4-20020a170902f94400b001d9aa663282sm3150185plb.266.2024.03.01.03.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 03:00:19 -0800 (PST)
Date: Fri, 1 Mar 2024 19:00:16 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] add src/t_reflink_read_race to .gitignore
Message-ID: <20240301110016.yog5bzex3z5yhd6i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240221121021.3591859-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221121021.3591859-1-hch@lst.de>

On Wed, Feb 21, 2024 at 01:10:21PM +0100, Christoph Hellwig wrote:
> Just like all the other test programs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 50ca94e98..d66190b13 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -165,6 +165,7 @@ tags
>  /src/t_readdir_1
>  /src/t_readdir_2
>  /src/t_readdir_3
> +/src/t_reflink_read_race

This line has been added by:

commit acff198213e3d874e76f6a133a816c8dee5e128d
Author: Li Zhijian <lizhijian@fujitsu.com>
Date:   Fri Jan 12 17:45:24 2024 +0800

    gitignore: Add missing /src/t_reflink_read_race

Thanks,
Zorro

>  /src/t_rename_overwrite
>  /src/t_snapshot_deleted_subvolume
>  /src/t_stripealign
> -- 
> 2.39.2
> 

