Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EB21D54EE
	for <fstests@vger.kernel.org>; Wed, 14 May 2025 05:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747200055; cv=none; b=mO3kLZGq2ucYKNOtqALSyBS2EPJxNcPFGGKUDqzMk9vfYz6/3Dl6w8/z8yU5ZvebaYz1is9r4OsBUGrpXHC+OUOjx3ac+m7/qGCu9uMy6CrUTB+Am7xRXf8+mS93/aabjD84n42Cw5nTbyDfg5dKH0M/JzkJ3kWzP2OCB2o5+4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747200055; c=relaxed/simple;
	bh=iaSoaw7bB3NhqQPx7C2KU/lCarj17ymW18hvtWU4L/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TzToKm0LXHPCu4L4TO1/JleadK5b3iTGLE6dgC6es9vG7MXTiKnVzOS36pfqUs/zXVRqPFAijt5qVUUh8kOYOFarNeiPNcOlTVVX/P1FxqD1nWki/PFEKVJfgtp4yH9XO4PYc++CHfbe0mPcfboqPGEIJ8dp980CoYYTpn5ZVZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YAVHhVrr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YAVHhVrr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747200052;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TXtBDIE77Q4RcA96cyQfjtM+WgYsnihPBjFJnUlXQZY=;
	b=YAVHhVrr5Z1Fb1VZ+mQzvSNUhG0Zfdu1v5kfG2yUp51A0oxF3aqH5BBJqmgc3zAE5MtMcc
	aGLgBAWaE1z52vXzy1O9tGkZW3ebFiEALCEkfHwCEK1P8+M302UZ8jO/f9Ag0yd/j2fenl
	/mf80J/Kwia+bNb7ppsaQQ15COtPjq0=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-SVIQ1d0eMtKDxpYNNgsOQA-1; Wed, 14 May 2025 01:20:50 -0400
X-MC-Unique: SVIQ1d0eMtKDxpYNNgsOQA-1
X-Mimecast-MFC-AGG-ID: SVIQ1d0eMtKDxpYNNgsOQA_1747200049
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22e3abea7e8so67227945ad.2
        for <fstests@vger.kernel.org>; Tue, 13 May 2025 22:20:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747200049; x=1747804849;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXtBDIE77Q4RcA96cyQfjtM+WgYsnihPBjFJnUlXQZY=;
        b=bejS+Ph/Kyfn8fnEkapMqA83GuL4VIKAovBo1Z3AiUFtThW/13tCBGMaQI+Ha3SoT0
         H9DOuqI2e9YBGAdoldqxYjMd4DZm1y+B+OboOX3qyYGdeS4E4if1jU5ZpBA/n632TG9p
         6NJlxtOFkHqznDReRVDv0cfMRSOE+A5vQaDCPY97hmesyQHwRoct/ZumxC+pnVbxj8Fh
         kpt120PfqCwZDEmo6brLj026xJj606Xq1eC450Q05AQ33Dgb1vut43M9+bLMVFNYAbSk
         HhF4+rNF94Jk+0jvRe1+znRL7ayPbxBjduVNaw+b/Z/AN64Wd40DzUxadTZqU8lrp2u4
         KWuA==
X-Gm-Message-State: AOJu0Yx0P95jRzqU5L9jVtzcjiyR/5SkwrGpGTd/QIp+CqEe8d5kB2Fj
	4Ais/l9MlO0X+7ud21WP+pPqD0o5GqJEf4PnA2oPy2YQxGN/jbc1vnjLxCQbgAsqWJrh9IJtOxk
	5J/e+szHLuXsd3XHZRbmhFVpyWsC8g5LJuWe5cW8rYcwF9sb776GlqRg=
X-Gm-Gg: ASbGncsxEPKZ4AxImwW3gQ4mP+BFT5uSxKPfE93dV1FmPTkWx2sIvQJeLIrTGsDB8D5
	lCaM0qYYXn6SoD4KcgFxzY2NciVgE7fZRldKmIfv9kOoRcVp/CesD4dO9xDl14vzAm6DXWONSXS
	CGld0YWkhhjltTPKEEwpzr9g0HaIqFNbWU7oKJJ/GzBpbSWA3tHTtQo7u4hFylDI3qTPwdJkBjw
	Pp2hdCfe8s2YkaOMPLkOFAHkBObZ4cssFwBMmDDSi+d4aZsEc1Nc5Bv02WLXlg5RHxa+N2+MKMv
	Xr9m2TXmpzN2Si/9I2YFS2wdnSWG5aqJDkxzOvshvtr+u2K8y7sv
X-Received: by 2002:a17:902:d4d0:b0:22e:68c4:2602 with SMTP id d9443c01a7336-231981a85c1mr28934385ad.33.1747200049499;
        Tue, 13 May 2025 22:20:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlx6APVjppTpKolovlnJP7aetqZfQVG8S4gkZTYEsgBJ0KT5TH/IvUnaGF4AlKDpj3hN7dsw==
X-Received: by 2002:a17:902:d4d0:b0:22e:68c4:2602 with SMTP id d9443c01a7336-231981a85c1mr28934185ad.33.1747200049163;
        Tue, 13 May 2025 22:20:49 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc8271d98sm89427225ad.154.2025.05.13.22.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 22:20:48 -0700 (PDT)
Date: Wed, 14 May 2025 13:20:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org, ritesh.list@gmail.com,
	ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v1 2/3] new: Replace "status=0; exit 0" with _exit 0
Message-ID: <20250514052043.o7as5lxhkzklungz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1747123422.git.nirjhar.roy.lists@gmail.com>
 <96ea8b7bb8dcaa397ade82611d56482d79f28598.1747123422.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96ea8b7bb8dcaa397ade82611d56482d79f28598.1747123422.git.nirjhar.roy.lists@gmail.com>

On Tue, May 13, 2025 at 08:10:11AM +0000, Nirjhar Roy (IBM) wrote:
> We should now start using _exit 0 for every new test
> that we add.
> 
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  new | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/new b/new
> index 139715bf..e55830ce 100755
> --- a/new
> +++ b/new
> @@ -176,8 +176,7 @@ exit
>  #echo "If failure, check \$seqres.full (this) and \$seqres.full.ok (reference)"
>  
>  # success, all done
> -status=0
> -exit
> +_exit 0

Hmm, this makes sense after we have:

  744623644 common: Move exit related functions to a common/exit

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  End-of-File
>  
>  sleep 2		# latency to read messages to this point
> -- 
> 2.34.1
> 
> 

