Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822C91A4F22
	for <fstests@vger.kernel.org>; Fri, 28 Feb 2025 05:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740720057; cv=none; b=I2WrGeBKQLBWhofMoaCxT3aWHRb5qGxN9MRxI8cuCIGbqOoyVYhlBGlS2eH1XQSofmcXJRacKN1kF1HHiI1S0XqlhAo2f4lgRE04QFclwFjhQM3w5FJjwKFJ6DE/uHM+FHjJskSURoO5ByiZB1TgRrCS+WQpKAlnVFXUVZdO9lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740720057; c=relaxed/simple;
	bh=YnCr11+jofyTBBjvZ98dwiUUtYT5Blv0XwzpDzEIzl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdDb71JwYR+9ST8GzKTQquG0NhkI37k1J1LJxYKPsgtqOtlii6DNUePegtj1qrYu7BacaJU5FpfFxfrbfxD/HLeGk1ZbSrk8baZVs/u9YMr2FXx+DxhhNddtg9cfzMtOd1u0vIOrazXJwNcR2TxsHHD1pQMAP3qZhJhHm4Fn5S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cmQAMHR8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cmQAMHR8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740720054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RyVg1vM93p2mte050nuhN+tNCQv5kBGlJi1Ovg0GaHs=;
	b=cmQAMHR8aMa/LnsHGuuYbLPD3LJ2G1DZcz1A8YrvD3z3sHe7qbHTj9++OWBYUZz4n76+BH
	Ol6xjC2Rc2xQ1J3XS+HSlmWi/pFTRukcozDx6pTOTMtEIBSCp4+ShHXWxuiHEGQj20v+I1
	f4U5SaGpUCGgxvj+wOtM7LbFY2Q8d0M=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-q48eMWzSP5WUxOLmfFk_Gg-1; Fri, 28 Feb 2025 00:20:52 -0500
X-MC-Unique: q48eMWzSP5WUxOLmfFk_Gg-1
X-Mimecast-MFC-AGG-ID: q48eMWzSP5WUxOLmfFk_Gg_1740720051
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-223725a1e76so662165ad.0
        for <fstests@vger.kernel.org>; Thu, 27 Feb 2025 21:20:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740720051; x=1741324851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyVg1vM93p2mte050nuhN+tNCQv5kBGlJi1Ovg0GaHs=;
        b=CGfv3VxsgBIBzkP8jTVzqubLH7H2My0ZOKkJtf3rtZgx5wlZJY7spr3hbnfniPnLsU
         dNW1mbXDiXhXjpehluY+vsjMlVO+QFjx+YteqqcWtjjrzA+YEZw20G8dqVz4PgOnG0ou
         jEc8M7Xo2YV3i+TEYwS74xLDD5BPGSI6rsEHJCExxSwrbdUo5BkeP5uqgICUTLZMvlCt
         eSJzahJusKAHFOoyVaSP6nZA2n4f1eR/9b2aNci6Wj6MrKwtRzCgxZEHqzwNxPGZHLh2
         aiDS52tFOBGUtHeY2H6ZDuyVy11qEQy7jel6Io/zK8Y2b1KJ988Y6J65qVr1vyUgJ+JP
         XmVA==
X-Gm-Message-State: AOJu0YwR7snTOVLpl+jEBiK8799ZKgWcJK2Sn0osZj37M23iEh90BeCS
	M3kClkNL1my8KI/vVIvFIpq4sf1kZgUIaeoxq9Fuip2EjcRaHBNDmRFTdKPZB3U28e2G6zWG83K
	vXT82NPlcrP+g/IRGf7eTZnj1wfRCg/71gUIIJoEBqQerIIeXHbPBBGj5hBi7Ac/1Zg==
X-Gm-Gg: ASbGnculomCwhEgKEy3eX7N1WAIDFvd6gYopa1Oco32jsO6/7mhmwglIabi8bjR0H03
	SqS/mslFpKD7bm5ZV0grlTPqcMERQ1jo/cNHpKltYFgHDqyxua8zwgRYDGaipQLaAiLf/nvKeAS
	Fvd+qes6vM/S3dSH0JEqKQJTDWB2Vj/haSdgHNUXYgCXbFOk6O8ZGs745NMsMvsFafRxYKwrl2+
	690EI+FgfzV28xJOGSbGA1TWAzC5e/zMiJ0y4q1+uRHk43rHeNpC3Z5zqLhqaKqFgcb/VegtvLu
	3J+1zv6qkSa0osLBCjWJoUKL8bH9hIZg62R907Bd6pxbdfb4u4mhuxej
X-Received: by 2002:a17:903:198e:b0:21f:988d:5758 with SMTP id d9443c01a7336-2236924e748mr31732615ad.35.1740720051108;
        Thu, 27 Feb 2025 21:20:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzy49UASObmQ7/nUvx+TWKzEu6dRH9MJ0+SeFJeR4O2daveYepfu9fVUCfCPpIG4lr218RQg==
X-Received: by 2002:a17:903:198e:b0:21f:988d:5758 with SMTP id d9443c01a7336-2236924e748mr31731725ad.35.1740720049534;
        Thu, 27 Feb 2025 21:20:49 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504c5c20sm24914935ad.146.2025.02.27.21.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2025 21:20:49 -0800 (PST)
Date: Fri, 28 Feb 2025 13:20:45 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs/254: fix test failure due to already unmounted
 scratch device
Message-ID: <20250228052045.usxjsezp5jgadlxq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <b470cdee538aab91177f8295fb8886ae79f680db.1740662683.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b470cdee538aab91177f8295fb8886ae79f680db.1740662683.git.fdmanana@suse.com>

On Thu, Feb 27, 2025 at 01:25:18PM +0000, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> If there are no failures in the middle of test while the 3rd scratch
> device is mounted (at $seq_mnt), the unmount call in the _cleanup
> function will result in a test failure since the unmount already
> happened, making the test fail:
> 
>   $ ./check btrfs/254
>   FSTYP         -- btrfs
>   PLATFORM      -- Linux/x86_64 debian0 6.14.0-rc4-btrfs-next-188+ #1 SMP PREEMPT_DYNAMIC Wed Feb 26 17:38:41 WET 2025
>   MKFS_OPTIONS  -- /dev/sdc
>   MOUNT_OPTIONS -- /dev/sdc /home/fdmanana/btrfs-tests/scratch_1
> 
>   btrfs/254 2s ... - output mismatch (see /home/fdmanana/git/hub/xfstests/results//btrfs/254.out.bad)
>       --- tests/btrfs/254.out	2024-10-07 12:36:15.532225987 +0100
>       +++ /home/fdmanana/git/hub/xfstests/results//btrfs/254.out.bad	2025-02-27 12:53:30.848728429 +0000
>       @@ -3,3 +3,4 @@
>        	Total devices <NUM> FS bytes used <SIZE>
>        	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
>        	*** Some devices missing
>       +umount: /home/fdmanana/btrfs-tests/dev/254.mnt: not mounted.
>       ...
>       (Run 'diff -u /home/fdmanana/git/hub/xfstests/tests/btrfs/254.out /home/fdmanana/git/hub/xfstests/results//btrfs/254.out.bad'  to see the entire diff)
> 
>   HINT: You _MAY_ be missing kernel fix:
>         770c79fb6550 btrfs: harden identification of a stale device
> 
>   Ran: btrfs/254
>   Failures: btrfs/254
>   Failed 1 of 1 tests
> 
> This is a recent regression because the _unmount function used to redirect
> stdout and stderr to $seqres.full, but not anymore since the recent commit
> identified in the Fixes tag below. So redirect stdout and stderr of the
> call to _unmount in the _cleanup function to /dev/null.
> 
> Fixes: f43da58ef936 ("unmount: resume logging of stdout and stderr for filtering")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/254 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/254 b/tests/btrfs/254
> index 33fdf059..e1b4fb01 100755
> --- a/tests/btrfs/254
> +++ b/tests/btrfs/254
> @@ -21,7 +21,7 @@ _cleanup()
>  {
>  	cd /
>  	rm -f $tmp.*
> -	_unmount $seq_mnt

Oh this change was merged with the _unmount update together...

> +	_unmount $seq_mnt > /dev/null 2>&1

Sure, makes sense to me.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  	rm -rf $seq_mnt > /dev/null 2>&1
>  	cleanup_dmdev
>  }
> -- 
> 2.45.2
> 
> 

