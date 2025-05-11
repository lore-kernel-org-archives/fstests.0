Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2EE825B68B
	for <fstests@vger.kernel.org>; Sun, 11 May 2025 14:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746973804; cv=none; b=DxggEgC8YTzgJqsSnTyRsLz0to1evLSEY7do+EZzfBR/+4QNv3w9pVD7U333PtLFh7EOYs0FnbfHqPQkGLbWlrmDrU2pbSKWVRwXNlj6HHgTBBNU9sTj/OxjMw7HO0oZgaP/5LyB5cOy6NxoWHe+rN7hSnd+2MPNhY39FXXvA8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746973804; c=relaxed/simple;
	bh=KNPQTb2q/xr0HfpG6S26Y/kudU68u8HlRM3F+Ol92ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1m/LosXLPFx+hjRrzYqiHgVisfSH7+ON5G009btTZDUVpMLDb3PW2wqMQ+A5ThSYe4nhZ5NAYIofDHHvjR1NmwVJ9ncC/Ndc+u3+CZ9T1+gwp8lmOs6ONm6Tnroa40J57S0HaZYte6pSPRGupv+X2JAgEd4eFdkLBxuhllbib0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FSrkLn60; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FSrkLn60"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746973801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ntZh0f3sEOmeBfZYkNqKiPOYiD2vJ7WGd8Qtcatk4Wg=;
	b=FSrkLn60q6vH17RWyNppSkQfvb17vAUgxxBM6trsykMANHynGODqRJmyu787ItxM699D19
	yNljyyvfCL6cGpMWc0NMMv+Jn1zVNv6Be2iVLoqz0QCyMaIjya05O9amso7NsuqEKG5TjL
	s+kLBWIoUGENIM6voOhJ6wejD+x5YGg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523--WvRIJafORqg7qtjOAi-1Q-1; Sun, 11 May 2025 10:29:59 -0400
X-MC-Unique: -WvRIJafORqg7qtjOAi-1Q-1
X-Mimecast-MFC-AGG-ID: -WvRIJafORqg7qtjOAi-1Q_1746973799
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-30ab450d918so5308501a91.2
        for <fstests@vger.kernel.org>; Sun, 11 May 2025 07:29:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746973799; x=1747578599;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ntZh0f3sEOmeBfZYkNqKiPOYiD2vJ7WGd8Qtcatk4Wg=;
        b=ceA9RQmlNUHesrlPbspjxtTUh95FcPRK41VCBPQ50l7KwXsimfRxa052fZ0dJGJDWp
         ZH+jxY9Ud90tx9le8jN05ZMZ6CxYJccyQcF5xVLOFPOJWEP0WbCtXpGOUzFblxFuAiMF
         McPx7wXGrPZ0oSKZrVrbaSSfejf7hahiLUUAk6W0zqAfL1vAQXF5luo1G7Kfzda5WgHh
         qDJyu0nBW03xMeLGAMNXtDuU6RFn8WpoUAKBP3QTrVEtAr0e3zNrcKD9ijAWQGr/Dk+s
         9ysYFL0Uwb99AAvOBsg11BXE16+hB1jNTjEIJzentcQbGzPQAfKhaIXmo1PcygIJ0KZ4
         zHHw==
X-Gm-Message-State: AOJu0Yy8JUFZwYNQ/xaz7dWedxmOyh424X9eq0udS120MtH167CHlGy4
	pW5XmT10Bm7tNWqhG0m/z5Kryf2bSQUI8AWiMxxZ9A42p5wkimEnTolHBgCVG793qwB1C9mpswc
	6wfeTMzm8Uavzp4sQdFNRx0mZRFzNxDwRsQiilEnFuYSsc250sbXWwc8=
X-Gm-Gg: ASbGncvjemEYBikBMaMbnyFrLKtru/MgcWa3xUqttiJSBxXE+H4RzO0Mv6A3Qee02AK
	wpO6Y/7TNftajxihje46vTgNP0tlTDB5kMK6WX3xOGRSM8NAON2Tu3Q70jKwkgMyuI0DvmXWxfa
	dWa6Fp1kUTD38K2DyHMtqxZTMUDY+bDZiliR+/RYa7qUYp4xgz3Yuk+SBzTnjNDPivzoUNPTcI8
	GFUJjhEVHnunHWBJ4cHA8/cs6Ab1J0c+Bv/OYS7mctOJIfjeHMa9IVVhZsvXyubCvxb9n9BFwhi
	So2zBI/gk353ZrrABI6Y6LOfv9ClZVYaNvw2DzaRpk4vEYxvuu6L
X-Received: by 2002:a17:90b:1b4a:b0:2fe:b8ba:62de with SMTP id 98e67ed59e1d1-30c3d646f35mr15673060a91.25.1746973798936;
        Sun, 11 May 2025 07:29:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEu6slgrPYixxPlUuqQ66e81lA8pABARSUw7C9Y7wov+vtFuWhEeO8bo13OGgoosXycF6H0kg==
X-Received: by 2002:a17:90b:1b4a:b0:2fe:b8ba:62de with SMTP id 98e67ed59e1d1-30c3d646f35mr15673040a91.25.1746973798626;
        Sun, 11 May 2025 07:29:58 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30c39dc8a95sm4973720a91.6.2025.05.11.07.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 07:29:58 -0700 (PDT)
Date: Sun, 11 May 2025 22:29:54 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/008: fix golden output for 512 fsblock size
Message-ID: <20250511142954.swhxnifhxvvkg3ty@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250508074102.125013-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508074102.125013-1-ailiop@suse.com>

On Thu, May 08, 2025 at 09:41:02AM +0200, Anthony Iliopoulos wrote:
> commit 97989c9839dd ("xfs/008: use block size instead of the pagesize")
> changed the test filter, which causes nocrc/512b fsblock configurations
> to fail due to mismatch of the golden output. Update it to match the
> expected output.
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>  tests/xfs/008.out | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/xfs/008.out b/tests/xfs/008.out
> index 0941e218c7d0..dc999156dab5 100644
> --- a/tests/xfs/008.out
> +++ b/tests/xfs/008.out
> @@ -8,7 +8,7 @@ randholes.2 : -l FSIZE -c 100 -b BLKSIZE
>  ------------------------------------------
>  holes is in range
>  
> -randholes.3 : -l FSIZE -c 100 -b 512
> +randholes.3 : -l FSIZE -c 100 -b BLKSIZE

This change fix the failure on nocrc/512b fsblock, but it causes xfs/008
fail on all other blocksize xfs.

  -randholes.3 : -l FSIZE -c 100 -b BLKSIZE
  +randholes.3 : -l FSIZE -c 100 -b 512

Thanks,
Zorro

>  ------------------------------------------
>  holes is in range
>  
> -- 
> 2.49.0
> 
> 

