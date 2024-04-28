Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9160B53A6
	for <fstests@vger.kernel.org>; Sun, 28 Apr 2024 05:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714282648; cv=none; b=DmOr7WKAOYZ1OtxOzf0RqwcA9P46gJNM7DInIF0vkvpBu9fcKpkVTWQBnmplD3no148lIJc8JpRfXxkjOy2n9uO5nizDReF7zbeg+7izUyDm6qpkLaZL4p+LYWT+QtVHeKMlBwUxs24JA4fHlmKih0YmFEKRNhECLJS3y029ZGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714282648; c=relaxed/simple;
	bh=j6dw5ncgFccmSMlrVV6KR097ves+xfaWP6BQmpbaxEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UsVdX0pWMXFwiYll+yNhDX9LCvfH4sZdKBw4SqE7kV4g1kPNZ9/RzNqtxU7+VhJO55yPS+jhPtTTPfbWh57gavx20kvLJgF8Lp7ARbgwynBlQa2DCMjpMVzH0MQcJ/YtUSS7pFL3UXZuwwtkCYeZlIdhRnvVNki8jabVveV8d7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y+H+IFQf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y+H+IFQf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714282645;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=U0cQ4D0mf6f1lnzvXNoE8+HHgtQjUG3zSIVb7bxQBdQ=;
	b=Y+H+IFQf/0RHzayvNx3skzn4kFmOhBexuisbSxUHwIzsJCG0WNG9Xtnh6KIz5PzIwPF6P9
	/Iy71s+TsbDPcgF+g33911MJaIvdqAdNsiSE1/OmWTJbdBGIzGh4jDwfICAhQUGnVVEPIz
	v7qZJjKmNBLfvbnzT69UHSSs/jWV5SQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-lzb8KzXONV-S1pSCG_n1RQ-1; Sun, 28 Apr 2024 01:37:23 -0400
X-MC-Unique: lzb8KzXONV-S1pSCG_n1RQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2ae83527c22so3726771a91.3
        for <fstests@vger.kernel.org>; Sat, 27 Apr 2024 22:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714282642; x=1714887442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0cQ4D0mf6f1lnzvXNoE8+HHgtQjUG3zSIVb7bxQBdQ=;
        b=NFAFOagmnAhV73Pt3EQCcbJUcYdUfBgkSwAo/DwCVyuZLDfHabG8a7rWXFdEsKdKZX
         t7iy/jAEB5n9v8xwESG/vy1+bmL3L2kxrFu4H39nksY78Hy6DFWVA+7uBQJfEpyUVO27
         P2pjaZokQBI7wBT9JgMRmP9NfIxW+Jsx7On77py4rz8fUdEyJJoxjZCXwCEwj1713hgJ
         8umwIx/yaWcEsci6qIeeLycSb5Cw2tFdW9+nkx/wOFOIPaMjNL5YzZT9WkCSXttNRU4S
         kahlPTUBYWnR7SfmN2WAdBZqWpVBV+pQCVXmGTRCOnQXoCHrt9/BKB04GmvA9/CbVkVp
         JySQ==
X-Gm-Message-State: AOJu0YyP91fW7NC4fThnLvqhUBv6Cj4ASwbTwo5cMmtiEAdhie/JExTf
	/6qrYw4+GyW82rANwAU7W7iceT9pyhtGnb8d+VRfXiSKCyTEucBOKJr2Z+85ZDcSEpm5NaU2xxb
	0WI0NLCM6SNfbpAoObivaZ12nXWK5FcPiS+9OXbN8aBWxS5CCWpnz8/2Iq+2PpfIoMA==
X-Received: by 2002:a17:90a:fd0e:b0:2b1:b6f:e297 with SMTP id cv14-20020a17090afd0e00b002b10b6fe297mr1912159pjb.36.1714282642320;
        Sat, 27 Apr 2024 22:37:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHAcoy0PFkw/0HmI/an1atpptKSWIlnSpdy2MzhYh5uqJFXcXEmYndDpRfTZ2iN6/iJOBFgcg==
X-Received: by 2002:a17:90a:fd0e:b0:2b1:b6f:e297 with SMTP id cv14-20020a17090afd0e00b002b10b6fe297mr1912143pjb.36.1714282641684;
        Sat, 27 Apr 2024 22:37:21 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id si4-20020a17090b528400b002ae62a84f29sm9737402pjb.38.2024.04.27.22.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 22:37:21 -0700 (PDT)
Date: Sun, 28 Apr 2024 13:37:17 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Disseldorp <ddiss@suse.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH 1/2] common/config: export TEST_DEV for mkfs.xfs
Message-ID: <20240428053717.qsvzt6jo7w32tfsh@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240411063234.30110-1-ddiss@suse.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411063234.30110-1-ddiss@suse.de>

On Thu, Apr 11, 2024 at 04:32:33PM +1000, David Disseldorp wrote:
> As of xfsprogs commit 6e0ed3d1 ("mkfs: stop allowing tiny filesystems")
> attempts to create XFS filesystems sized under 300M fail, unless
> TEST_DIR, TEST_DEV and QA_CHECK_FS environment variables are exported
> (or a --unsupported mkfs parameter is provided).
> 
> TEST_DIR and QA_CHECK_FS are already exported, while TEST_DEV may only
> be locally set if provided via e.g. configs/$HOSTNAME.config. Explicitly
> export TEST_DEV to ensure that tests which call _scratch_mkfs_sized()
> with an fssize under 300M run normally.
> 
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---

Actually, using "export" in xfstests/local.config for each parameter could
help too.

The 2nd patch still has some disagreement, I'll merge this patch at first,
as it's simple enough and got two RVBs.

Thanks,
Zorro

>  common/config | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/config b/common/config
> index 2a1434bb..4bd5650f 100644
> --- a/common/config
> +++ b/common/config
> @@ -932,6 +932,9 @@ else
>  fi
>  
>  _canonicalize_devices
> +# mkfs.xfs checks for TEST_DEV before permitting < 300M filesystems. TEST_DIR
> +# and QA_CHECK_FS are also checked by mkfs.xfs, but already exported elsewhere.
> +export TEST_DEV
>  
>  # make sure this script returns success
>  /bin/true
> -- 
> 2.35.3
> 
> 

