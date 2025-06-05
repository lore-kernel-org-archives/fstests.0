Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F331D5160
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 15:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136328; cv=none; b=H6lDR6FS4eCfsAKdmd3i2j1rY9sJeEcMOBiARkBcARBbDPxrSLUpGEubqugEj+tpIXG+Ez9g+ufqo6+DA/YPKPfQeZ/LZhMAAdZl0n5brIFsmaiDrOzDH8rHuxIcevQzeacEHjlD3rtEyYkMpf2YKfaaXDc8tEvWndcyEbDSvk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136328; c=relaxed/simple;
	bh=BC71BgMShyokfrM2Uqrq5zwfzFoUWqhNu9aQQbhLVBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPE92Ds0nxXeRruT8XmReMJ1UJgky0rT6m0N8a5BLO5Kg3qc0a6Eg4Tq/7wqnvE+OVfA/3Dq/glr1Z9QTYhCBzUy3nxzqDIxcSq9VLFVkvnjsfEiXMxJHnB0lZwea6vEwW484mThjzuxJmY/kve8Erq60GAlg3ULt0ul0M0VgUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQdk1Noh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQdk1Noh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749136324;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+1ugE0Mb8API8brZ8R8c376wMPnsW739GcTth8L7GZ4=;
	b=UQdk1NohbfLau/V6k+C1veFavXx3MvM4Ih2uOFawXeIsojVoCGJRW1pAilr52MkaQTJpNA
	4yz3cnQuBJKtAj+OYmWcdctdkHJ+wHm/lPAQoqsBo9a68u9kF2pGy7nJ7Tm6x6Wt56vJA9
	DYGN0nDQvGQgHUtShznqxQ6pvkhZGkA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-106--bLzh1j0Ow-Yiid7OCgJBg-1; Thu, 05 Jun 2025 11:12:01 -0400
X-MC-Unique: -bLzh1j0Ow-Yiid7OCgJBg-1
X-Mimecast-MFC-AGG-ID: -bLzh1j0Ow-Yiid7OCgJBg_1749136319
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7429fc0bfc8so1903655b3a.1
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 08:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749136319; x=1749741119;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1ugE0Mb8API8brZ8R8c376wMPnsW739GcTth8L7GZ4=;
        b=sJcr+djzpMsMfgZaMKZTc7BcabhoKSwP70TGRACeeoi5skEiwGHf/M/Tk1a+DGCkpI
         ZOk3jNvObPqx42DxuHguCKx/fgQGjg7exZWPjTZTiUaTTQqK9bIPb+oIuMQBTiNw05h0
         4v+ruofbBgal1AYyXHUVMDmuBLCTqseR1h6UFPxv51jFu+ISCIxlETieMg5n1l2iZDOD
         jMEFtRoE9YI3e+XvU10V44oMM5Lk3xfbRJ/2+3PwO0yLAUx+SYxXcPA4E7B330zWF+85
         XbD79HagqxGiKSKA43erBCPzgs/fW/3pHBn8CAnbN5cZl6mY7mTEiN2EDDCbyvS/Yxrx
         xH4A==
X-Forwarded-Encrypted: i=1; AJvYcCWIO+/vvtUPBg6haC65tAYGCi7ZJjS5OwhvEANHqqv4YwkZoVbB2IWe9MnJZOa5Vv9bwJu0VXv+@vger.kernel.org
X-Gm-Message-State: AOJu0YzWM6RRilNrz100d7LaQ15Jf4xXrDqP8Y0YMpC2R2l8XbkE5TG9
	sI86Kx4Xzx5nXFL6rBNs0DcIhl7vYIJRznS3HUoAveB9wTo8e9aiO/JiEEwp9j9ZoTrOd6GUYtW
	21twBdC5bZGvtLd8RYs5LqJmuHJThV1tk4Nvi8Am0R70DrHhEczIZ7tgxpl5s56dmZlM=
X-Gm-Gg: ASbGncuYKMcmOTYqZSnGMxKHB7NU/FsVvnou08LII58q2HrU1rqNkJ0XZFAJjyhTliS
	ZVMEaJnpKPwb0k+tlvp9Q7O3aFwG/iPSbmYagq3KQuAHbx/FjHlmHMaOEg8YdIsxmbwy/ryOTVd
	wXB1iWkiOA51ZRESIvHg750AwRF2x09FPplGjfmHrMHzR1teB1lvRouVTzmOd4uCwdbc87eQlep
	QkAC7fq+x5ceMDBH8YNrPVwmlabn4nVX20MoDCWo63pj1wawvJYZKES0lr+LmNotWg6kINieNx+
	Vs8yQaZTqHhJhTpmCFkGE5IKVRewhKOhuPtHowuSo6wEpg9dgM0W
X-Received: by 2002:a05:6a21:9208:b0:218:f95:f84a with SMTP id adf61e73a8af0-21d36280d70mr5882076637.4.1749136319219;
        Thu, 05 Jun 2025 08:11:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2h+c7YhuFAm7TeG5GPosxZm/SiQdZhNvvuwYUSXURxfO9gdG3SBuUH8GU3oZUEkwOC6DXiA==
X-Received: by 2002:a05:6a21:9208:b0:218:f95:f84a with SMTP id adf61e73a8af0-21d36280d70mr5882045637.4.1749136318821;
        Thu, 05 Jun 2025 08:11:58 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2eceb0c5d9sm9105227a12.8.2025.06.05.08.11.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 08:11:58 -0700 (PDT)
Date: Thu, 5 Jun 2025 23:11:54 +0800
From: Zorro Lang <zlang@redhat.com>
To: Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, friendy.su@sony.com
Subject: Re: [PATCH v1 3/7] generic/754: add _require_symlinks
Message-ID: <20250605151154.awkqeunfosv2ziei@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
 <20250528091530.1218188-4-Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528091530.1218188-4-Yuezhang.Mo@sony.com>

On Wed, May 28, 2025 at 05:15:26PM +0800, Yuezhang Mo wrote:
> This test tests whether xattrs can be added to a symbolic link,
> which requires symlink support, so add _require_symlinks to check
> for symlink support.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Friendy Su <friendy.su@sony.com>
> ---
>  tests/generic/754 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/754 b/tests/generic/754
> index 7afda609..c1016641 100755
> --- a/tests/generic/754
> +++ b/tests/generic/754
> @@ -10,6 +10,7 @@
>  #
>  . ./common/preamble
>  _begin_fstest auto
> +_require_symlinks

Make sense to fix this error on FAT:

    +/mnt/scratch/symlink.32: target is corrupt
    +/mnt/scratch/symlink.64: target is corrupt
    +/mnt/scratch/symlink.96: target is corrupt
    +/mnt/scratch/symlink.128: target is corrupt
    +/mnt/scratch/symlink.160: target is corrupt
    +/mnt/scratch/symlink.192: target is corrupt
    ...

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  
>  _require_scratch
>  
> -- 
> 2.25.1
> 
> 

