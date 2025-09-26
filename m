Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD121D86DC
	for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 16:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758905675; cv=none; b=OQBSD/Kgb67NaVfRsx6mdjDDmjmIFf8fB52HKrEsWkLG0HcXkaboXKmBRuLYSmtBd+xoN0qyeFFfKrYfOECvVOPFT0W7cfSuuzns/QvRmjG5ZFCwZVxmPPpFHTav9C7HH6CvJxKZZDSZ6VwvE+6RsuJ9dJvgtYYgwvcozgm3Y5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758905675; c=relaxed/simple;
	bh=htaagRVEBCvxjaOfpsfJDztMw7oWa6mMUdKkFrAiJ+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BC/sbG5l2fzQVVKpNLXR6J9CONNYf/+BGLuxSq4k8W0VHAa9W2WvkQQcaWMsqEnGZRmebaDfvN/3ufDwmxZAg3B4T7vyghvWPR79xJ6AlVoU65o7rQaqIKX30YxaaSb3LMreJA2mOHIlDsP325SL7Gyx19KSNFa1V7UW7T8XG2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RJxZKGo7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RJxZKGo7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758905670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N6RcA949crO5wvbETkeUIxvADcoBcmYfmZrIO/EL3go=;
	b=RJxZKGo7fXZoykjTQvfTj1o3zFd7T2gtKthAMfjOlPxRXLreyPvk+n0uKXSRV5JPAsekow
	c/qdjpbIksl85KN+FyNR+QD+Kul4D2YLxtitnPAG/QsXfZ6qOsqQX9Jo/ZWdDy9wf41N33
	FOVj+B/X8vGy5PnFDLTj+aXo8pQ7C7s=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-ZMVWnnRtPxOUaT4D7bmGAQ-1; Fri, 26 Sep 2025 12:54:28 -0400
X-MC-Unique: ZMVWnnRtPxOUaT4D7bmGAQ-1
X-Mimecast-MFC-AGG-ID: ZMVWnnRtPxOUaT4D7bmGAQ_1758905667
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24458274406so51398515ad.3
        for <fstests@vger.kernel.org>; Fri, 26 Sep 2025 09:54:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758905667; x=1759510467;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N6RcA949crO5wvbETkeUIxvADcoBcmYfmZrIO/EL3go=;
        b=JL4gZMnJz7kY/vNXc+zBj/XEVk+8UQ/zA+smSfSLKbKO7oY4JZ6M24P0gBjA4raFUU
         x2+RMUfpzuiPOSzNxeiIOZBu8ea2xqNrCR5885jdp1QAWZFGCG1j4Sc4BETdoSCm4JtB
         9/xfFNkXGBPfpBUPb/rIM9NvQp670WnRHxzqNAww99zY0iN/UsNSkcPz6u8RyGs9KwLY
         H5VzTOgAOg7KJeiK0BcHXn3yOEMqKVbA/+QnktlPhpKOxCC7YOUgigwjT9LnVekhqYGj
         NCOThu4PBVCkQzS5KdmmEQxyIvCKkGam/VLguBjDOga93UxfDPxQoBgbpiXUwnaaBH3Z
         U7eA==
X-Gm-Message-State: AOJu0Yy1MvfwKytfZ3wPMFIRsnN+nDCTOcFpIRS+E5vTeuH2JsSCFSeD
	+6gctL10YROAngCezLKCgR0LKl+oyZ8CnHL2Iap6jITu8MGU4giv/Z/1u1YuUXS9DrUY09/rY/X
	CKTGAW8/KJ4eNo30pIfAWKluHftqR0uJErWqjo3HQN2f7bzT6wbdR3tkPfB4=
X-Gm-Gg: ASbGncsZWYLnt8xScmKowDTo3XTPMBQNMnJ+zjsc8/pXPw9uSWmkexP29KYlhRDd8wh
	FHdoaBPIex51jp5f7VPJoYLS5NTTdNDZQDO7cjIUEVridIqy87ACbJ9CHjn0A2h3c4sEnfTPBkr
	/w6nVUY713eVP8lWl3KwKAGS/q1EpP//g6UVMk1o8Lb5zZ92iaTdmp1CEOC+samwdJQIeoaGQL7
	vRtP3sq2WTt3fyGTjfTZm6mv5N6bbEG+5FEXpGLTI9uz6TjHRKTODjcR35ja0lQWHjYRM5B5cRE
	bmqsmrMg9RxjDfddqEZJT1yRNXf0tRcaR8GaDa74P8VtQryeujw3WpoUHBKk4ZOmI+hP1xCxF7s
	v4Vsc
X-Received: by 2002:a17:903:19f0:b0:276:9863:44da with SMTP id d9443c01a7336-27ed49c778amr83485905ad.8.1758905667370;
        Fri, 26 Sep 2025 09:54:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEeumWsfsbSP2Omp5PXWJwViQxU3jOoLHv31qHxptWbjHQe7qpDzuRn1NmIwXHYdgBDk981Kw==
X-Received: by 2002:a17:903:19f0:b0:276:9863:44da with SMTP id d9443c01a7336-27ed49c778amr83485655ad.8.1758905667016;
        Fri, 26 Sep 2025 09:54:27 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-27ed6adca51sm58884145ad.147.2025.09.26.09.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 09:54:26 -0700 (PDT)
Date: Sat, 27 Sep 2025 00:54:21 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fdmanana@kernel.org
Cc: fstests@vger.kernel.org, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
	djwong@kernel.org, quwenruo.btrfs@gmx.com, zlang@kernel.org
Subject: Re: [PATCH 2/4] generic/562: Make test compatible with block sizes
 till 64k
Message-ID: <20250926165421.k7n3m6o2nuscarkq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1758036285.git.nirjhar.roy.lists@gmail.com>
 <b3ce6c555b0a04f6c8cca08ab36e3b0068abbbb2.1758036285.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3ce6c555b0a04f6c8cca08ab36e3b0068abbbb2.1758036285.git.nirjhar.roy.lists@gmail.com>

On Tue, Sep 16, 2025 at 03:30:10PM +0000, Nirjhar Roy (IBM) wrote:
> This test fails with 64k sector size in btrfs. The reason for
> this is the need for additional space because of COW. When
> the reflink/clone of file bar into file foo is done, there
> is no additional space left for COW - the reason is that the
> metadata space usage is much higher with 64k node size.
> In order to verify this, I instrumented the test script and
> disabled COW for file foo and bar and the test passes in 64k
> (and runs faster too).
> 
> With 64k sector and node size (COW enabled)
> After pwriting foo and bar and before filling up the fs
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop1      512M  324M  3.0M 100% /mnt1/scratch
> After filling up the fs
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop1      512M  441M  3.0M 100% /mnt1/scratch
> 
> With 64k sector and node size (COW disabled)
> After pwriting foo and bar and before filling up the fs
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop1      512M  224M  231M  50% /mnt1/scratch
> After filling up the fs
> Filesystem      Size  Used Avail Use% Mounted on
> /dev/loop1      512M  424M   31M  94% /mnt1/scratch
> 
> As we can see, with COW, the fs is completely full after
> filling up the fs but with COW disabled, we have some
> space left.
> 
> Fix this by increasing the fs size to 590M so that even with
> 64k node size and COW enabled, reflink has enough space to
> continue.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
> ---
>  tests/generic/562 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/562 b/tests/generic/562
> index 03a66ff2..b9562730 100755
> --- a/tests/generic/562
> +++ b/tests/generic/562
> @@ -22,7 +22,7 @@ _require_scratch_reflink
>  _require_test_program "punch-alternating"
>  _require_xfs_io_command "fpunch"
>  
> -_scratch_mkfs_sized $((512 * 1024 * 1024)) >>$seqres.full 2>&1
> +_scratch_mkfs_sized $((590 * 1024 * 1024)) >>$seqres.full 2>&1

Filipe is the author of this test case, if he can help to make sure
the 512MiB fs size isn't the necessary condition to reproduce the
original bug he tried to uncover, I'm good to have this change, even
change to bigger size :)

Thanks,
Zorro

>  _scratch_mount
>  
>  file_size=$(( 200 * 1024 * 1024 )) # 200Mb
> -- 
> 2.34.1
> 
> 

