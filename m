Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BE01AF0DC
	for <fstests@vger.kernel.org>; Wed, 19 Feb 2025 05:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739944737; cv=none; b=LLdI7yB6kUhSX/G9Y5REZ+5cRNXUChl+iN676UVVb25horelp8zt1yJM/Xw8j0MOiHsB5onft+B1VfuAKPshhvr2M4MMnzfK9ZpaDM30VDjB8Rv5sY+f2IhJXXi7CSW0SOdYr2n/0OocDGQBI2ZEKjQztw11cmWRU3+M7VaDeCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739944737; c=relaxed/simple;
	bh=cmTtd+5HQcnkZ4IAP31qlBKVt321XEIeEr5PKO4u+a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uj6xRvD/2GzCIJ7C2WPD6ghcujxLdaYgWnS2/9vL+aYRnRXwUj4NhptPONKMpo5UphwnqnhDjxRUy5q1TvN/vs1kNmV/ZsESlkvUI6yVW6SIobMqdFXZdfW4L3st4m4xFt6cbgIdpxc+q6t/Dn/zeKCP3rZJ3FuoMojC6DgZpow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B8tK/9aT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B8tK/9aT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739944734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YokxX3qQWk1mv/VDdALhwh1PAR6A9BWJ//OPV4oLrsc=;
	b=B8tK/9aTA7epdLUTo/lup3YI39N/UElev19q+lUycjUuOsTvr2+Q/XByFALClnR6u0dN+f
	HezEQM20Wlx29JVyGhk7U4cbdBUzjfzrUk26I9RgnORvznHDJcX91S+sePo5RcWpgGQ/e7
	Ze1003+z1Y78cv3aobSFS0FYsEpJpZw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-Ko_4_hSgNmWZq7GYXzQ-Sg-1; Wed, 19 Feb 2025 00:58:52 -0500
X-MC-Unique: Ko_4_hSgNmWZq7GYXzQ-Sg-1
X-Mimecast-MFC-AGG-ID: Ko_4_hSgNmWZq7GYXzQ-Sg_1739944731
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2fc1a4c150bso12406258a91.2
        for <fstests@vger.kernel.org>; Tue, 18 Feb 2025 21:58:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739944731; x=1740549531;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YokxX3qQWk1mv/VDdALhwh1PAR6A9BWJ//OPV4oLrsc=;
        b=xQEKphEPE1DhHu1gi2IHzgjdTnEyUz9QJd1CZaY44bkhehji0AMZ0c32RmofrAJRz3
         vPlSCBaiE2gfhxuZ2JoGlZuCnx5FOtqRva/vstByD14Y8Vhml7RSbGYsUb7z4E5xKSRY
         adsViPe+ilbpqb7on6dMs+ka+CcNeXGQ32QZoPC06ecjx61qe+Uwad5eSMCTHVUBjAUY
         x6t+kAi8pdQ0sF3Px6ZxACSMlnDk7B07p5MaeanWLJuw15B+BdTmsiHPVEHm9MDVVJf2
         ZgJpyghMSQGWXgyc7BHrNEgU15bcDp6tABngTrwRSsm1+RyLuqzCgkGplcscJjIbYfEK
         Cn2A==
X-Forwarded-Encrypted: i=1; AJvYcCWrwG9dWon4jmQ7szf73dsTky2pejdzM3DpW9B35GWDnHKnzQUK2h3ohAevwO17QPJULbcr44zW@vger.kernel.org
X-Gm-Message-State: AOJu0YwvQKht/cd4IRNW7qEikt0vQG9dTLfo5oA+AbVrYv9qAZmg5Xv5
	QgHI0KaiOXGfmhvAwKhV5axyu2NbsRt+rw2s9umfzK4qVdQv34yEXpebP5WJZ1okfNYxfwYilNK
	vg1U2DElNOvrknalyg32bjtX0kw41GDAycN12mrZqS5RDx+bWO6vB9a4=
X-Gm-Gg: ASbGncvfAFg0AgrNb1tN7Mz8gToYqyLhX6jMqRdsszjoAZ6X3JnNcpJeOSqbJafyqw7
	FFBur7Tf+vnZCVPNIFRxRgOTw3dH/m5jv6dAs9iNQ351aMw/GSEI4HuT/dvJs1AGJ8aFCgPFHk6
	+/q5Ps4795ffHQGaj+CO1FwC2OrAZRkQ8mjyz5493dfD55IqRXbZvMtymBffx8ZjmhFOswQK2eO
	JzjNPm2/jmMA1Osl1m/zEHODN1Fl+ymFXd69Odg3YptJfLXobRyYNZ6BNCeEfx7x4PJSfxuciW9
	LWi+8JFasu2rJjx3RjmTCmy9LXpkPOT743kuRuq+lAbb1g==
X-Received: by 2002:a17:90b:224d:b0:2ee:accf:9685 with SMTP id 98e67ed59e1d1-2fc40d12d39mr25653846a91.4.1739944731250;
        Tue, 18 Feb 2025 21:58:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJPagFe3FnyteGo6t1av2DMGdt45X9cqSU9aHuSKb3hxn5htsk4qpMRj/P3IafC3sTkfQDnA==
X-Received: by 2002:a17:90b:224d:b0:2ee:accf:9685 with SMTP id 98e67ed59e1d1-2fc40d12d39mr25653826a91.4.1739944730916;
        Tue, 18 Feb 2025 21:58:50 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf9ab0233sm13387857a91.44.2025.02.18.21.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 21:58:50 -0800 (PST)
Date: Wed, 19 Feb 2025 13:58:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH] fstests: btrfs/226: fill in missing comments changes
Message-ID: <20250219055846.r6amxpdxubjbtyhd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <e73cfe5310a8cee5f6c709d54b8c18ff52e39a0a.1739918100.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e73cfe5310a8cee5f6c709d54b8c18ff52e39a0a.1739918100.git.anand.jain@oracle.com>

On Wed, Feb 19, 2025 at 06:35:44AM +0800, Anand Jain wrote:
> From: Qu Wenruo <wqu@suse.com>
> 
> Update comments that were previously missed.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/226 | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/btrfs/226 b/tests/btrfs/226
> index 359813c4f394..ce53b7d48c49 100755
> --- a/tests/btrfs/226
> +++ b/tests/btrfs/226
> @@ -22,10 +22,8 @@ _require_xfs_io_command fpunch
>  
>  _scratch_mkfs >>$seqres.full 2>&1
>  
> -# This test involves RWF_NOWAIT direct IOs, but for inodes with data checksum,
> -# btrfs will fall back to buffered IO unconditionally to prevent data checksum
> -# mimsatch, and that will break RWF_NOWAIT with -EAGAIN.
> -# So here we have to go with nodatasum mount option.
> +# RWF_NOWAIT works only with direct I/O and requires an inode with nodatasum
> +# to avoid checksum mismatches. Otherwise, it falls back to buffered I/O.

As a supplement patch, this is good to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  _scratch_mount -o nodatasum
>  
>  # Test a write against COW file/extent - should fail with -EAGAIN. Disable the
> -- 
> 2.47.0
> 
> 

