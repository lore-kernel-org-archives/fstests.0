Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6221FAE
	for <fstests@vger.kernel.org>; Fri,  2 Feb 2024 13:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706878864; cv=none; b=trbAoNolIrFPG37KCR7dkTs0T356DJisewUaOmZTjh7vS25cnsiOZdstjbj603Gs9iUaGvnZHH8FjQbUrAw0q22Uor8Evqq1aXprJM+anunO3IuRAyPUqQFJijgItRCWgtqMc2sNZB7VWvmOg2Rn88rJpp5RRsOQD/OIuinBVAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706878864; c=relaxed/simple;
	bh=4FxNWHrwC9GPOspVNpAwC7TMnZW5/QXPjkxSr/Hx5vo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3nhE1ygNSnjees79SmtQB62smJWDcreTCdsmOSS1WUKuNj0RBw9Q79NtANJOXP6VHkj/gWk0EdIc4ur3qCI1SVd7kfkHT5H7vCr+wenmmrUA9iwI6WHoQQ63AVv6qKcoRGGubklpzlNih8T9YZXr6L7IeEQZ26VXFvPtZqO0Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TzHCwM3y; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzHCwM3y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706878861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oBPHz4Lv+rsJQJtk2BLpb+gXeEQSKAsPTl92j1HGsQo=;
	b=TzHCwM3yhZ3Z21unlJdRmQCLrtuqjlrGKxCeEIJTDBwQygU9DrLZGtLfvhU25eWdn9bDWf
	6It1WVrS+YtTLCIiCPqbVdcg7o16CUudm3tBGQoZFD5OR74QYIjfUXVwCblZld2Z9kkBlH
	FpxS/twECjJ3l/SGBEESY9qzee7gNsU=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-P5-kKQRKNhG8pbOLoFl2xA-1; Fri, 02 Feb 2024 08:01:00 -0500
X-MC-Unique: P5-kKQRKNhG8pbOLoFl2xA-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5d8dd488e09so2371700a12.2
        for <fstests@vger.kernel.org>; Fri, 02 Feb 2024 05:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706878859; x=1707483659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBPHz4Lv+rsJQJtk2BLpb+gXeEQSKAsPTl92j1HGsQo=;
        b=s3659yQRCqt7EICdDaeVE2yvowSeD710rEw4DgUQa8i9LyuyEw68EHrBTMODGdgjiC
         /xnOAhcu5oPWyYDcYnQoNbJ4XH1JQGC+fAx2a4JbaIEI2zT73ck6xOrsQ+nBFTh0dAZV
         tLAkqRA7EA8C7rH4B75lJqGdbI5j1/nUb6/pIVJeV3KX4y53Dvdtwvt6BzNbRIyKokDM
         h8nDNzE7sHyq+jV4R9CNOpFYbCcvFXFiGP0v97bkSt7Kv5m+2p+fSKXvuNbEiYBiDpJ/
         0LlpdqZc1ZRkK0hp9YmNIBnx113mgHHbBb6pGwOsMxG6gBmKXJB8lrIX4wjYPGKYzyOO
         2W4A==
X-Gm-Message-State: AOJu0YzoDX5lqX/hCK2z+KYR1toLaWYLEF0yRKWgLdp9ePJUyDrTST91
	W3T3+p3les/z93P4Ol3BjZbMo7nMvD7VOm/cFreIJ1Ao00CBL6+UpK2hoqCQ+NVHgEtZ/nc1Ngn
	mVsdi2IH2LGJuGEyGXoSEwR6R1N+rXhZa250s2XEF2GlZw480D2d0TqkQMPU9MgjTgg==
X-Received: by 2002:a05:6a20:1eaf:b0:19c:a6c8:10cc with SMTP id dl47-20020a056a201eaf00b0019ca6c810ccmr1568177pzb.5.1706878858615;
        Fri, 02 Feb 2024 05:00:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGYXZWUbYPnGUCN2ew0lbgA03mk0GcQTwOw+aGYD5laLv1XDlwAm4alEKxXLNGxokZuJ6d4yQ==
X-Received: by 2002:a05:6a20:1eaf:b0:19c:a6c8:10cc with SMTP id dl47-20020a056a201eaf00b0019ca6c810ccmr1568149pzb.5.1706878858281;
        Fri, 02 Feb 2024 05:00:58 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id u27-20020a62d45b000000b006ddd31aae37sm1593712pfl.33.2024.02.02.05.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 05:00:57 -0800 (PST)
Date: Fri, 2 Feb 2024 21:00:54 +0800
From: Zorro Lang <zlang@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH fstests] generic/089: increase the lock timeout to 120s
Message-ID: <20240202130054.nrqp3kn4djqtrbmy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240126201550.109929-1-jlayton@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126201550.109929-1-jlayton@kernel.org>

On Fri, Jan 26, 2024 at 03:15:50PM -0500, Jeff Layton wrote:
> On NFS, this test can take a long time. There is enough contention for
> the lock that it can take more than 10s (or even 60s) to acquire it.
> 
> Bump this value up to 120s, which seems to be long enough for testing
> with kdevops.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---

Good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  src/t_mtab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/src/t_mtab.c b/src/t_mtab.c
> index c0640a1951a4..4b3b26c86d02 100644
> --- a/src/t_mtab.c
> +++ b/src/t_mtab.c
> @@ -16,7 +16,7 @@
>  #include <mntent.h>
>  #include <limits.h>
>  
> -#define LOCK_TIMEOUT	10
> +#define LOCK_TIMEOUT	120
>  #define _(x)		(x)
>  
>  static char *mounted = "t_mtab";
> -- 
> 2.43.0
> 
> 

