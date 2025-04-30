Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AAB2DC771
	for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 09:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746003759; cv=none; b=WNXsFtBqGPZEuR4Z3jgTfAxuxk5LF+uSBx8eNrB56dnHh5JXoUF9bKaWBAr3q16xeKtgGy5Y631QdSjy1MOoqGKw3r4x84qQCM9H5ucaE3Bo7wkfERFJ/nyChKFvzZ9DJQjkkiudORyw1UEEDD9xx+0fkA2dyTJdVEd9m2XL1bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746003759; c=relaxed/simple;
	bh=/GQ63ZR3SFEHdmtk09lfW+F3O9bODpFnRkBO8Ok8jRE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=W70l//bSKBAyBcDZhQluOUqgzobTXmnrWK2sK7ybr2IiHaDiBsA9gpyA16G+Qyr620oxasw933mTED7cO/k2yfY/SFKT7Y5rxHZFRNyqVNYEnKapbGVkbWKsca2yCFPnkFApDdNuAVHzF2p6YcWxoj5o70ky5ADhp0AR+vTw2RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7MplapV; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7MplapV"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7398d65476eso619103b3a.1
        for <fstests@vger.kernel.org>; Wed, 30 Apr 2025 02:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746003757; x=1746608557; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56WHi38L13gnYGozxFX0hu9jqqPpzXl/GiAn8vDfkkc=;
        b=J7MplapVhJuJs1YBSdUda63yAA4F+3x8IF9uf9YRUkTnE/x64099/lO5idV9hsSxvR
         lfjLURY6A+mnyvox0cF36vpRS8ChNSoq5gAwtr5O4std72WSeeIRa3KCF/pU+yM/SrJW
         CyozJrlkvhu/n3hzXP0hqatR5qVjDG8VJyhUn5TL8d2kI7HbuxfMfYwriXLJm3kvM2V/
         jHFa+t+EoK1eyYsnrb99YaTHOPf35tgt+5rSYq9Ce2RVrkhAl4R0UcsDjGF0vIXSO6aL
         vnCJM3GgGLscD/a+lmh1Y9430PfZ2YoXSoTqwxRIvE9GFtquerFDAXcGZzKHi756uYYf
         44cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746003757; x=1746608557;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=56WHi38L13gnYGozxFX0hu9jqqPpzXl/GiAn8vDfkkc=;
        b=iltbrKp7L9CCpvmJSjqu/9Dcag+pHFOsMbcWMJahM8ihNLxwhYPol5VQ3okzDCoOGO
         dPhf6tTBxsuG0rDGIUy3JN0UfCDF1xAYBH/THzDJr/TWfs86p0f7k6o9U3WoEuuVYrZr
         ZDQpbHsfgmQhsHZ13VldxCz3RIkI7XT2GJiJNgU9Cpu1ydnZp/OdiynbXlE9AwxicvwG
         /m1F1ZONy3zy/VXyZd7DloSIFdyKtYLsdVNcgl2HpfMURNSl/WMfU7KU1JmxnK2e4LFs
         bLnkACiTDs+hTCj0jeI3HNi1XW4FK8PfJbiMVJU4sd/bOm52xfagta1PTKcQaegEeD4T
         aeYg==
X-Forwarded-Encrypted: i=1; AJvYcCUvribfeE/9MXIa53UPKn5VeM4/XZm++jIsyVltWPiyjRxVSu+FfgWB4BQOIz9X7bxacJJu+fX/@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb10iTcBd5Oi0CAKGpfYFsVv1avDKSqGHwUtHRF5fcsP9CRXmE
	LyGfiNFv57GGtoKy2G8xBQGRexw/mVPzqFmuwMWi3mg0aENHuEmvmCql0g==
X-Gm-Gg: ASbGncukEmVanq2ui4gEn7jPsUR2IhXVAv6BbSUIs8lJRKPJX2wRIH0uBU7hes5QULa
	7UnPcGimKNzuu9yFBVb4p+3f1Pi69Dd9MwYf5cqsaVnX0/4aRqjRUekMakU68t0X3H0rxECNV0r
	EEAAAJecr8RQn4Wy6W7nNCpooZA4HUFrJNkrkZZVYxH+DBuuj5DCJzaNvtQqpMfSHFitPgoZ1T5
	fqkvT/dpCWN4+keXDicRYEug71XRvbzQlHww4bvhsIVd9wYgx9huaqn2QB8RBhPTCgWeKTrR76V
	eNIlu0VvOeuwEzJOmCmfXzfyhXq79gpPEm2qFRNoWNsYHYuDM0hCJf5VS4kcWDwpIFGnBnEc8rq
	J/H8qf5APKAnlzuTEsw==
X-Google-Smtp-Source: AGHT+IHFySA8RCC1ztMBqnQx0CI0vZCgbes1tIVolxZC9lGiJKeQvrIy8ew1nM1ZiYanTWtfWSSQyA==
X-Received: by 2002:a05:6a00:888:b0:736:4e14:8ec5 with SMTP id d2e1a72fcca58-74039ba2194mr3063992b3a.11.1746003756807;
        Wed, 30 Apr 2025 02:02:36 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7404192f7e5sm79658b3a.135.2025.04.30.02.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 02:02:36 -0700 (PDT)
Message-ID: <15e09df3ecf75b4b7da58fd2e00d5f72aab2d493.camel@gmail.com>
Subject: Re: [PATCH 23/28] open-by-handle.c: use syncfs() rather than sync()
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: Dave Chinner <david@fromorbit.com>, fstests@vger.kernel.org
Cc: zlang@kernel.org
Date: Wed, 30 Apr 2025 14:32:33 +0530
In-Reply-To: <20250417031208.1852171-24-david@fromorbit.com>
References: <20250417031208.1852171-1-david@fromorbit.com>
	 <20250417031208.1852171-24-david@fromorbit.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit

On Thu, 2025-04-17 at 13:01 +1000, Dave Chinner wrote:
> From: Dave Chinner <dchinner@redhat.com>
> 
> generic/467 runs open_by_handle at least 15 times. Each
> execution runs sync() at least once, sometimes three times.
> 
> When running check-parallel, sync() can take a -long- time to
> run as there can be dozens of filesystems that need to be synced,
> not to mention sync getting hung up behind all the mount and
> unmounts that are also being run. This results in:
> 
> Ten slowest tests - runtime in seconds:
> generic/467 442
> .....
> 
> This test running for a really long time.
> 
> Convert the sync() calls to syncfs() so that they only try to sync
> the filesystem under test and not the entire system. This avoids
> interactions and delays with other tests and mount/unmount
> operations, hence allowing both the test and the overall
> check-parallel operation to run faster:
> 
> generic/467        6s
> 
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> ---
>  src/open_by_handle.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/src/open_by_handle.c b/src/open_by_handle.c
> index a99cce4b3..816bb5d12 100644
> --- a/src/open_by_handle.c
> +++ b/src/open_by_handle.c
> @@ -430,7 +430,7 @@ int main(int argc, char **argv)
>  	}
>  
>  	/* sync to get the new inodes to hit the disk */
> -	sync();
> +	syncfs(mount_fd);
>  
>  	/*
>  	 * encode the file handles or read them from file (-i) and
> maybe store
> @@ -563,10 +563,10 @@ int main(int argc, char **argv)
>  	}
>  
>  	/* sync to get log forced for unlink transactions to hit the
> disk */
> -	sync();
> +	syncfs(mount_fd);
>  
>  	/* sync once more FTW */
> -	sync();
> +	syncfs(mount_fd);
I don't see mount_fd being closed at the end. Maybe all the file
descriptors are closed after the program finishes execution?
Other than this:
Feel free to add 
Reviewed-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

>  
>  	/*
>  	 * now drop the caches so that unlinked inodes are reclaimed
> and

