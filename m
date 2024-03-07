Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9254A12EBF6
	for <fstests@vger.kernel.org>; Thu,  7 Mar 2024 15:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709825174; cv=none; b=gropnEW4xkIJK47/ZPgzRi1zyxWfLtxRTXPIRd/A9VGtTTJ0lPyAwh8gS+CSX0u8wf0iEyA8H4W4402QO+lHI5iDtjUoIhCI7EjLUa6VY3js/HDciGboeKIocYFl4MOUr4OSGzyNpVXK4wWq8ihJGHgoOXGEAljMmJwDMIAoST0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709825174; c=relaxed/simple;
	bh=EU3XylEJitVrbCrOCmqX9RnYwePjWmiJLehkxf0rIpg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRsUxbA31FuPNytI8UyMCZEfBlsRhtiXQaJhhss6ZtunjPEVsbSwUEIhyycVRo4WinLiH1pEHFgci42wploda4tf0OVNT/yl2167dy4VpSEhzDzelq7nK2t58IO5zn4Y1F6ghdJbP8VIHWiTtVDYEasHXX7Jcd6x8uiGszUcveY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Egs3PMbT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Egs3PMbT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709825171;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jeioKZMX4TixT/w6JyLkmYdoiWIJWk4jwuG27h1QRMU=;
	b=Egs3PMbTrExiiGpitnP2Tgb4g7lfWgt6q9/oLSwsUwJrQmC1a0wjlFd9r/a8LAhRMLCnoJ
	MemP0qRNBrk+Xxlo9Fqu7Px/MjkjB1WVRjO0Oo212MWwLK8NTxue3Wn1Kxlqp7rCeWPXo9
	KJcU6yBPQ7QKSqLzwIS47apnbcnucyM=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-1ux7ROiyMy-tkRwGi84jSQ-1; Thu, 07 Mar 2024 10:26:09 -0500
X-MC-Unique: 1ux7ROiyMy-tkRwGi84jSQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1dcb989a738so9548195ad.1
        for <fstests@vger.kernel.org>; Thu, 07 Mar 2024 07:26:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709825168; x=1710429968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jeioKZMX4TixT/w6JyLkmYdoiWIJWk4jwuG27h1QRMU=;
        b=do4pmq10knnqWtiN6n/oqhZcOSxMSpyI9juQggaJtaN8+gedH6kGr4ZyO3DWtSXXfB
         Q4w2UeuBYAvuYk3Q4QokNpP1Sb2Dg30fuATW45Y9WYzFtRRofInBakas4WZy+FJAObDt
         YJ07EjSHYTdqVRVY2Q+65sKFJxH49PUTRi+bWoZBTp14D5MJ0+2ANqc5GBZ6xOGY655f
         i7rDvhx93Xs/dYvRcVTzWKE0AcpFBUDslBLfoayHKbOwwWZt3VSQZIFLQjStwBtBTWKY
         KYEaujMkvQ4wllOYX6oxNiBW8FBqEpf4E37WtixLlSRTv80/E9tIH76eu7tdvpGTk/cm
         mbdw==
X-Gm-Message-State: AOJu0Yw7RD28rGNtof1zaSdxB8S9QK1vGdc9rSf45IJWaP0lX2QiFON6
	SbbxlSMqlhsdO2UFLH81Nb6oxyd2bpIjSJ2zssHtmO/UfKF8Ph+rRj6JKcza6uy7hrR8FxvWfUX
	01GVDPr5pUBJY8qI0JvX1TbaSdqMMQB5vKrnMrg4o08d7Lb3nzoPh1vAYD7L3H2dj1g==
X-Received: by 2002:a17:902:d2c8:b0:1dc:fefe:8050 with SMTP id n8-20020a170902d2c800b001dcfefe8050mr2153708plc.29.1709825167621;
        Thu, 07 Mar 2024 07:26:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPTXpUz69hW1V/pb3qoEh1hQD9k5bkrW+3pVjGmcSg7DCVL18CiPM+Ve9O+H6lFCDSMocb4w==
X-Received: by 2002:a17:902:d2c8:b0:1dc:fefe:8050 with SMTP id n8-20020a170902d2c800b001dcfefe8050mr2153676plc.29.1709825167074;
        Thu, 07 Mar 2024 07:26:07 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id bg1-20020a056a02010100b005dc9ab425c2sm11297574pgb.35.2024.03.07.07.26.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Mar 2024 07:26:06 -0800 (PST)
Date: Thu, 7 Mar 2024 23:26:03 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 1/3] .gitignore: add src/fcntl_lock_corner_tests
Message-ID: <20240307152603.7wclj65j6lfejicj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1709806478.git.anand.jain@oracle.com>
 <d81464d8af573126efcc0551f80bd9968a38ab40.1709806478.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d81464d8af573126efcc0551f80bd9968a38ab40.1709806478.git.anand.jain@oracle.com>

On Thu, Mar 07, 2024 at 06:20:22PM +0530, Anand Jain wrote:
> git status reports a stray src/fcntl_lock_corner_tests; bring it under the
> ignore.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  .gitignore | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/.gitignore b/.gitignore
> index 3b160209ac03..574aa9e8c1d1 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -93,6 +93,7 @@ tags
>  /src/fsync-err
>  /src/fsync-tester
>  /src/ftrunc
> +/src/fcntl_lock_corner_tests

I haven't merged this test[1], the author is still looking into it,
due to some issues on cifs side. So this's an invalid patch.

But you remind me that patch forgot to do this change :) You can
reply to it as a review point :)

Thanks,
Zorro

[1]
https://lore.kernel.org/fstests/20240303050853.f7wslqfkkgdfv37i@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/

>  /src/genhashnames
>  /src/getdevicesize
>  /src/getpagesize
> -- 
> 2.39.3
> 
> 

