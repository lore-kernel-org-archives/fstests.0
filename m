Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE9413CA97
	for <fstests@vger.kernel.org>; Thu,  1 May 2025 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746088746; cv=none; b=cvYaQv2+RGL79V7STOEZH2G4JQthyxx3+fRaCZpCdcrZ/iUrpYNEB77cst9uLNpjLGUEUaJS+SlIOFp9TY6C1FHlpi6FYBfh6FEs7vVhvY8QxLJW7SCO+gNHj9qUMH1MKHdoAQmEHm4reMgorKxA77JWdRKyeFoMacbH+LdqTl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746088746; c=relaxed/simple;
	bh=UiDNqUQ4x+I6cDl+Wf9F3An8nAnKrPqL5RcCG6E1xy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tWEeXGkGTKL7EnOV1WUD9gWgDImZS2aLspyfc/CHGyr0a/MUmf0UP9IG9e+yGw5FVbzxT/fRsBgQUqEkQhRa6jSairwh4e8huQyRYT5WQlouERWj9cDIabvzHMutsCeQiFE9x9QSpQ8ZYeogG2f9mmws4fgRT68HbCPH8ZpD38w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i7STYH6w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7STYH6w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746088743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m1hJcso6iq9NYt8ZpukInEEBt1bRoH8yb/JXyxZ6WrU=;
	b=i7STYH6w1bBiY+YXTiD5TLHlrzFSc95YBelG9CSHYDlTys3xCFZDJJu7y+C0Mt5i6CUw7A
	WkY8K6jQKsVXej2l1M/7z8tx40ebkST+UWjyhsxzKv1tugbx2jPCXogqkON9jgV5Yvqm52
	UaJlBATP273eA579lGnIPM0Fc4PJoj0=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-aZ8pmjRwMN2BtAbQCHBDyA-1; Thu, 01 May 2025 04:39:02 -0400
X-MC-Unique: aZ8pmjRwMN2BtAbQCHBDyA-1
X-Mimecast-MFC-AGG-ID: aZ8pmjRwMN2BtAbQCHBDyA_1746088741
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-739764217ecso756109b3a.0
        for <fstests@vger.kernel.org>; Thu, 01 May 2025 01:39:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746088741; x=1746693541;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m1hJcso6iq9NYt8ZpukInEEBt1bRoH8yb/JXyxZ6WrU=;
        b=I6H87xLhD5X7l7Lk2TUMygDMM9sAvy1xlYVwzEf2fmKZ2iJyg87I6eYpRT5/vs0uym
         CPfqb9zNRubOWvZyheiHcjhrbW/biNVSRnd9CCEfT4HeBV6mgaR2X8gRpaeWzw3+5GWc
         hLBfDIIrBY0W2d9jMd+STlC5J89k6AeXdwhxvaDCzyU/tBZ2drtbOl3Nn7vXPY6gfSh8
         19oy7e3e7u6Sq9T+yAKU4HJP3V233PCtqOrmx2rFDtCBmEMpOSulkEINa9DpZkg6Kjpt
         Ha2v8pCP7bN9Sf28ROSNp3tnih1NLNIHZOyCWmWYY7FTILQ37uH0szThV23x/Bjkks92
         jnSQ==
X-Gm-Message-State: AOJu0YxC423VnWKLE4BTAF8+1dD0p2upOTHdoyXoxGydvieCk+XJoaw1
	ABtQYVjDLCk5HWekFSnIxjEfXJlfd1TIweEm1kkQC88kZu2k95dpTNJd31TC/cy+stv+mTZwxK3
	r86ZfHkhP113/ZszPpBGMc8Xm4EO7OFNBjGzk2aTp6NnNg7mYLgi8U5JEVQTLnLw=
X-Gm-Gg: ASbGnctZlQ1jWcUr9I+QtW5GEaqkIrCAJ9rOQP0sBLhCTRZd3CtvQ+5GWvNjlEhz5dS
	lPczMCZsreTlOo57Ha5o352m8pEHuTzmIjuI1+wI6HlD9GqHYyuFnb4Lvm9kmO/X5SYAGpSQdAl
	LweZhkzsPLQ/XI8JNIt6NVWYo02sG68bt73c1UtFLX4Rxu7JsO53R80cqmEPjQhlbuzgd/y02ga
	oost7q2OVrrwjLlag0Kw1MMS3q6BiqMo03lq7lXaah80p7TLX6Utn0R+N/TdKkVIjtiYCbgypS7
	6sGHp1qFbiuN5cs3v4GA02y0yUdmbIZrqZiMewmVS+Dxpkr/4+CJ
X-Received: by 2002:a05:6a00:2e9d:b0:734:26c6:26d3 with SMTP id d2e1a72fcca58-74049198213mr3148594b3a.5.1746088740999;
        Thu, 01 May 2025 01:39:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGGtA2KB/rtnzETiR9KtxF45gwvbjHq3/RtLqe39bcC1elbHyLcTpTdVoyATqp46w7CRq60BQ==
X-Received: by 2002:a05:6a00:2e9d:b0:734:26c6:26d3 with SMTP id d2e1a72fcca58-74049198213mr3148564b3a.5.1746088740630;
        Thu, 01 May 2025 01:39:00 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7404fa2246esm318319b3a.136.2025.05.01.01.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 01:39:00 -0700 (PDT)
Date: Thu, 1 May 2025 16:38:56 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anthony Iliopoulos <ailiop@suse.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] fstests/MAINTAINERS: update ocfs2 mailing list address
Message-ID: <20250501083856.fmf6cjgnccyhl43n@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250430122342.157170-1-ailiop@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430122342.157170-1-ailiop@suse.com>

On Wed, Apr 30, 2025 at 02:23:42PM +0200, Anthony Iliopoulos wrote:
> Bring the ocfs2 mailing list address up to date, following the upstream
> change in kernel commit a57b4b7f0557 ("MAINTAINERS: update ocfs2-devel
> mailing list address").
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bc31572902bf..a0f50f3d98b4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -157,7 +157,7 @@ F:	tests/nfs/
>  F:	common/nfs
>  
>  OCFS2
> -L:	ocfs2-devel@oss.oracle.com
> +L:	ocfs2-devel@lists.linux.dev

Sure, thanks!

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  S:	Supported
>  F:	tests/ocfs2/
>  
> -- 
> 2.49.0
> 
> 

