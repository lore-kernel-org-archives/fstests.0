Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8F113B192
	for <fstests@vger.kernel.org>; Sat,  9 Nov 2024 12:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731153728; cv=none; b=dolVpkU3ojDx1Lu2Jn6zzEkV2nBzVau96r+USPw2x4xkI41cB+L33LDjgZz6viRPPzzmVFpOqgCHJcL+U59tAZWx+BjvPZfFr/SsCSfOPEGfd/DSnHeHaTjfwE4Lpb31ET0Xs3dZxdcHrR1pQsnBhUV1f2kLDJMEsSd9tAWmJ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731153728; c=relaxed/simple;
	bh=ziNuw8oAb9j3aYay2KvVYXL6bZ0mJK+D8wbtvuvmOUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pHp9tI+zNXrPRkvhSlK45O5wZs8HbMSJNgRyBk/GkJ1suDG46ZiaVEBiOMbY363nEcNIbC7gZ6DqMKY5PGDkxbyCk1uCEsv4rWLtZ4RgDtDLj4Tcrmo2sCWxfwg4ldgjD8A6627BRRTPQkumwMSiTPa7zDe+1Njq3X/6j9q/oag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NE4cevFn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NE4cevFn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731153724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UGIItzgOG2PUh6Im4P+MuteC0Nq5Zl5YmFGcZs7ep1E=;
	b=NE4cevFne/qzUxLZA9OmF6eVSwKBDwMLkA5w5TrNNZd2BkXarnWMVMpqyWYfYLe1T5U3kh
	8sRcbKORDa3JioVMHTQ9RlF93VkEcgaFlGBW7u8/mT3s+gWIexIFnjQsyzOXs0VUVZjlrk
	kEsPjN2dELOI8m+SAwiyPALLnZ41UtQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-2H_Es-1TPbGgS1ReZg1uEA-1; Sat, 09 Nov 2024 07:02:02 -0500
X-MC-Unique: 2H_Es-1TPbGgS1ReZg1uEA-1
X-Mimecast-MFC-AGG-ID: 2H_Es-1TPbGgS1ReZg1uEA
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7203cdc239dso3655525b3a.3
        for <fstests@vger.kernel.org>; Sat, 09 Nov 2024 04:02:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731153721; x=1731758521;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UGIItzgOG2PUh6Im4P+MuteC0Nq5Zl5YmFGcZs7ep1E=;
        b=rN2yfqjiD8NZD4MNolczD3En4MZX5qL2kikaDRZ32jUX/9d9MBvovkSixi14WTGrcx
         KIxe3YCYBg0FBwGMUlFY7EZ7+Wf3DcDx8uuQ4+jvgFUAFTb1VnRhyHBAUafgEmh+hOwC
         2BLh1ADRvQUdIdwn6oZR7RJ2RTARsXSsvVFawF8Ffd7kIw8282tqdwhD6zLdVYrdaSTA
         w/b1Tj4lyPc4HS3qBLiJo1C/HA75KZL22I4Le0OKXoqR7QBPy7evykz7Fic9QEQG8GkD
         t2pHuwUwLjXcghuxuooRvrFQkmVZ5FCR6M0ay+7A0HrIb8XCJNgh0ttTN0pBsP3alMQO
         rlLw==
X-Gm-Message-State: AOJu0Yzj7SUBectVU6m5enn1pp+IfYiA0Wli9d42uyf58heQ3PyyU0I9
	/GwkU5fDUSNrXFywH5jaQ2TriZNSnD2HgT84GTfxiuUnwsrNmj7mHg2TaKG376Y9zScKxOP5vAU
	oK0LJDg3g4iWQD9tSGIMyOHOHOYTt3O2KoVRi2rHlj8F0U3Djjv26iLQ=
X-Received: by 2002:a05:6a00:139a:b0:71e:6ec9:fcda with SMTP id d2e1a72fcca58-7241337ff37mr7589654b3a.19.1731153720892;
        Sat, 09 Nov 2024 04:02:00 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH7AJb62874aA4UNHMmCytz3FrlaNxlND2cBVChfOCgiQwtmP/Xl4iJ14ogHR/XVuCTisP/Kw==
X-Received: by 2002:a05:6a00:139a:b0:71e:6ec9:fcda with SMTP id d2e1a72fcca58-7241337ff37mr7589635b3a.19.1731153720534;
        Sat, 09 Nov 2024 04:02:00 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a571a8sm5384148b3a.195.2024.11.09.04.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 04:01:59 -0800 (PST)
Date: Sat, 9 Nov 2024 20:01:56 +0800
From: Zorro Lang <zlang@redhat.com>
To: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Cc: fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4/032: add a new testcase in online resize tests
Message-ID: <20241109120156.lipr33ykp73lzsxb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241108134817.128078-1-aleksandr.mikhalitsyn@canonical.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108134817.128078-1-aleksandr.mikhalitsyn@canonical.com>

On Fri, Nov 08, 2024 at 02:48:17PM +0100, Alexander Mikhalitsyn wrote:
> Add a new testcase for [1] commit in ext4 online resize testsuite.
> 
> Link: https://lore.kernel.org/linux-ext4/20240927133329.1015041-1-libaokun@huaweicloud.com [1]
> Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> ---
>  tests/ext4/032 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/ext4/032 b/tests/ext4/032
> index 6bc3b61b..77d592f4 100755
> --- a/tests/ext4/032
> +++ b/tests/ext4/032
> @@ -97,6 +97,10 @@ mkdir -p $IMG_MNT || _fail "cannot create loopback mount point"
>  # Check if online resizing with bigalloc is supported by the kernel
>  ext4_online_resize 4096 8192 1
>  
> +_fixed_by_kernel_commit 6121258c2b33 \
> +	"ext4: fix off by one issue in alloc_flex_gd()"

We generally mark this at the beginning of the test, not in the middle of test
running. Refer to ext4/058.

Thanks,
Zorro

> +ext4_online_resize $(c2b 6400) $(c2b 786432)
> +
>  ## We perform resizing to various multiples of block group sizes to
>  ## ensure that we cover maximum edge cases in the kernel code.
>  for CLUSTER_SIZ in 4096 16384 65536; do
> -- 
> 2.43.0
> 
> 

