Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A39125B2
	for <fstests@vger.kernel.org>; Tue,  1 Jul 2025 14:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751380094; cv=none; b=AUTcZBiIZIS+GEwMd3tsIDIrMbKHldCtJuT6G9bvCzISnBUBdMX9PvRQOL1sliD0Cxh+DYo2AVc1u9tMxxjehbRieJnyriAI6SarDw+hnGDhhdOJPQPlkR5kBLSHWeQffvc72rJWm9jmQdXlmcUG8hnWKcTCaB1FZXEvvONKTho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751380094; c=relaxed/simple;
	bh=FfWNlt0sTvazmmf8FeKea/5UbR8UES/3TauQo/EeSf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQdqNSH/FQt6Qt9z8e1Uj0Wt+zaRHES6IzMPRVjCmJcxRZ4j8ubzRAy0CIx76qhRTYAImZDIj1abTOAHKPvkvwOF9tu79iiQdtt8ssqoXB5kPVYyhRelUVHfRkgs9cZ3NtlU9dpMZIkOhl8KXzXB0wM5vNyq3f+YPN6iS0EMBBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hVumTctL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVumTctL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751380091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aqHNejLTu5OmdI4y6XzLz4N8WLe44NOczvGEBwpMpFg=;
	b=hVumTctL94jINcX5Y3R4y7DuIdT+UcatF6ASoimGlVzhn9vY0QZeDbhvDInSPw/ssD2DLi
	v2S3Dbq52HBolSvNSf43ZzeypX0oU3jL6V30jm2PMtLW+LGi1S+lXWH2wsWzM9AKstQJdY
	Q3qLc4lBUfyf6b3AQc4U5Irw2MK1zl8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113--DdoLFF0MB6u4SnA4ahk5Q-1; Tue, 01 Jul 2025 10:28:10 -0400
X-MC-Unique: -DdoLFF0MB6u4SnA4ahk5Q-1
X-Mimecast-MFC-AGG-ID: -DdoLFF0MB6u4SnA4ahk5Q_1751380090
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-313ff01d2a6so5480804a91.3
        for <fstests@vger.kernel.org>; Tue, 01 Jul 2025 07:28:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751380089; x=1751984889;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aqHNejLTu5OmdI4y6XzLz4N8WLe44NOczvGEBwpMpFg=;
        b=w9lHx+HutEosaNcO26rR12FgBjeDxEPZjlN87f5fdZ36et6vNApRFnSIR1J72HNyvk
         8iLf8YuRzPnfah1He3YwJGLqCAVf2zC7bvX8VtqBGLDahyFyEW+fATmNkE3XMSVJmUhO
         xexqzPCP93AAXZGEjbwbTF/kT52ccW4le4ngvGE0FmT8sxzEa9tTsbEDhXeWZjPavqQn
         8GozG6M9AHwcgh6lBeQLqkkto01b24QqB+nzkj53WrYjIIdyPAQTzWmqQqCJWtfBYN8s
         1sjRFy7boMWKN20dtGMgscDs4R9+vz7FSp0Us+3Aaf0JVeV15D2FwQn/Kls6Ss4okfjT
         jzWA==
X-Gm-Message-State: AOJu0Yzlq5qjWerHuV7Z5r447cjbQHdy8Z5dgsw6MsLsSY9AW6ATCrm2
	OIEaZG4Urs7LcZAJNEykzuwYK70Ej/qIED/X/FzEBYHH9gWVKP4tjCB1xjVauuQBnBZy33zohfS
	wQhSCMDaKpuQMnY0kH+wjWvG36FKaTS7nvSAvuY71bJwe6/sW3ou8MD27/LaWAokp0+k=
X-Gm-Gg: ASbGnct8lGXPEyaRGfsyLjpyfRjIsWy66muNfdB3xrqNI+2Avh73mUhs3EbdLxM6Yu7
	bs8Wjp2r3Bq8hKQxussPYDuLoYF4midxeHsv7dJ1X1kdh3v5ufYlRz/zwt3m5HE4lAHGPzp5sAI
	Nt6Q0X7XjXWucXlO0i5Sd0NBcmzv/BOihMd2RIVTmjEnP3RQkYTr9P8oujdJH1AojZojIc6V2ec
	kNv9GISEeULG1bnIZwL2O65ReZ7U0Iw0Cu9C6Vs1mBQL5c/2f2lSkp7S5tqlhfFpjVrndpjIRRP
	3Dk4U4Il2GQA4aec5DMywJDidnEnWm3ZlHAU12B+GK1jl/PQbvVm5t+7dfiesDQ=
X-Received: by 2002:a17:90b:2e07:b0:313:28e7:af14 with SMTP id 98e67ed59e1d1-318c92a33f1mr21670717a91.19.1751380089246;
        Tue, 01 Jul 2025 07:28:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJG7AxAZVuPp084miQi4ypOjwn2m18XooM4pwIZ4HD3FB/NDkjhWdSDdcwuAmtqWE8T7BjKw==
X-Received: by 2002:a17:90b:2e07:b0:313:28e7:af14 with SMTP id 98e67ed59e1d1-318c92a33f1mr21670678a91.19.1751380088787;
        Tue, 01 Jul 2025 07:28:08 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-315f5382e7csm16969392a91.2.2025.07.01.07.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:28:08 -0700 (PDT)
Date: Tue, 1 Jul 2025 22:28:04 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH 2/2] fstests: check: fix unset seqres in run_section()
Message-ID: <20250701142804.pdc4ibftng4qoizc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1748058175.git.anand.jain@oracle.com>
 <8d691171e1bb1b0be98a0ca79e50f9839073d2ac.1748058175.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d691171e1bb1b0be98a0ca79e50f9839073d2ac.1748058175.git.anand.jain@oracle.com>

On Sat, May 24, 2025 at 11:57:14AM +0800, Anand Jain wrote:
> While testing, I saw that ".full" is created by _scratch_unmount(), called here:
> 
>  725 function run_section()
>  ::
>  815         if [ ! -z "$SCRATCH_DEV" ]; then
>  816           _scratch_unmount 2> /dev/null
>  817           # call the overridden mkfs - make sure the FS is built
> 
> Ensure seqres is set early in run_section() as a fix.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

Reviewed-by: Zorro Lang <zlang@redhat.com>

> This patch was sent earlier; it now addresses review comments and includes
> an updated git commit log, no code changes.
>   https://patchwork.kernel.org/project/linux-btrfs/patch/12a741fc7606f1b1e13524b9ee745456feade656.1744183008.git.anand.jain@oracle.com/
> 
>  check | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/check b/check
> index ede54f6987bc..93d8a6cd3237 100755
> --- a/check
> +++ b/check
> @@ -794,6 +794,7 @@ function run_section()
>  
>  	seq="check.$$"
>  	check="$RESULT_BASE/check"
> +	seqres="$check"
>  
>  	# don't leave old full output behind on a clean run
>  	rm -f $check.full
> @@ -835,7 +836,6 @@ function run_section()
>  	  fi
>  	fi
>  
> -	seqres="$check"
>  	_check_test_fs
>  
>  	loop_status=()	# track rerun-on-failure state
> -- 
> 2.49.0
> 

