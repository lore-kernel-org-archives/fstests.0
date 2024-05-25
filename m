Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56EF863BF
	for <fstests@vger.kernel.org>; Sat, 25 May 2024 05:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716616134; cv=none; b=QumawKOnU/XN/8HUD6zIJKvsCf+zZTGrHh1KX1/Zyv+YC09c6EsSk8J4eEumkl5p0XxzWEsvn6U7zu1zr0gLJoTTnnPo4hlY2vsoGXCqcZCdiSVa0xpsv61j9H1NIkVRYMkSC9zEK0MYMhI+JMLXjercPgOFPo4F6hBPk0VV5io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716616134; c=relaxed/simple;
	bh=pdBb/0j5R7hlvaam/Yl3zWaN49Ts5cq/slwTFJFyZrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3oqQnj+ZBcQY1KOy4Ad+D5phBqS4HvWJYPImQ9uNYz3e9eQy0hHqYqbkG0UUQS+YGxbGBZvSEZQb2d9QLOAg6OmWuyLPNvdVWlXC56TvmwIVbyL7k/S0C7U1lIfS2TVYrEmqPPfQIQpY8O6TONl4Ip7oMW4TmOaxcU9vXVR/GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aApg1Bcj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aApg1Bcj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716616132;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PBX4lOH54XFAMj+rQ8FNv3GNU9PLV4YIpHFYn5Jmk5w=;
	b=aApg1BcjCSb55GPM67KtfSyh4XQywYov6P+4OHIK656BLdrt639vBFqh4ACvWF80b6q3/P
	mHR32G21zzMnMdeupcGCIrIPy8IhcNnNkZOaoXvUstOxLBFFOfPn4lkBoS4e32q2wuT93O
	w/wnssJAVFLXXJvGOywha7g/dNPVGM8=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-583-J6F8Mg17Mdmx1vnoRTqofw-1; Sat, 25 May 2024 01:48:50 -0400
X-MC-Unique: J6F8Mg17Mdmx1vnoRTqofw-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2bf9410c954so148442a91.3
        for <fstests@vger.kernel.org>; Fri, 24 May 2024 22:48:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716616129; x=1717220929;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PBX4lOH54XFAMj+rQ8FNv3GNU9PLV4YIpHFYn5Jmk5w=;
        b=LUhfhS5mA0WmrGiYi1R/nt4w/kqXzbeHSwNen5SgPYMBMKezrersDuE3ZxskRxdsoW
         b/WNxqgbR0cBzCvqm2HBpC3eEphUepkwkQsA7QZfnV5JJq/6vze4OLT31mebiivhOmsS
         f2NAzK5fvx2DT4XruGkysHtm55I0w/oboQR9kFQ2tlum9aFEqfnA2DoXZrbO1zyXh5a7
         FMJHlCcTouxPUAbo2bTMyyUhmka2jDVQjKMfRGgzXAaUkJMz0k+6CvD/7ojgSt+Xsf0/
         dNM0WXOcdP/HE+aJQcU6YqmvhM0Dlw+KedaXZy/+vGgr9nmTrIjT0hsBMW6Tvh+GNqNQ
         diiA==
X-Gm-Message-State: AOJu0Yybsp1R8f3O412ZaRbSRhFAQnq95Muo5j6m70dMQCDKUOuBz/Fl
	JGhYKUwSlYB7yQsBHudI9tppjFKLw1joGsbvz5Vq/Wr6f6XP6WW7d1cOQRSWcmvAkz6mqrvkjV/
	vuoIwE+iRnUx7SEu7QBUgNKHPIc4azu9p7MrDXKwyKKZ5EP+HhZMFCqo=
X-Received: by 2002:a17:902:ecd2:b0:1f3:38e2:3f51 with SMTP id d9443c01a7336-1f4499017a7mr62049475ad.68.1716616129349;
        Fri, 24 May 2024 22:48:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXwmZ49wto2r0o9q3YM9HIEgdHJdsuKcPyWKkk+DKUKJR/dijR8xbyo12lsL4N5Gsfgv87lQ==
X-Received: by 2002:a17:902:ecd2:b0:1f3:38e2:3f51 with SMTP id d9443c01a7336-1f4499017a7mr62049225ad.68.1716616128848;
        Fri, 24 May 2024 22:48:48 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c9e43c2sm23020805ad.308.2024.05.24.22.48.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 22:48:48 -0700 (PDT)
Date: Sat, 25 May 2024 13:48:44 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: fstests@vger.kernel.org, gost.dev@samsung.com, mcgrof@kernel.org,
	ritesh.list@gmail.com, djwong@kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 0/3] more lbs test fixes
Message-ID: <20240525054844.5qcuyhwwnmhlpev5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240513131254.92412-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513131254.92412-1-kernel@pankajraghav.com>

Looks like this patchset still has some review points to discuss. I'll
give it more time. The release of this weekend won't have it :)

Thanks,
Zorro

On Mon, May 13, 2024 at 07:12:51AM -0600, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
> 
> These are some of the tests that failed when we were working on LBS
> patches [1].
> 
> generic/436 and xfs/008 are adapted to work with bs > ps systems.
> 
> xfs/161 is an upstream failure, and it happens even on bs <= ps systems.
> 
> Changes since v1:
> - Corrected copy pasta error in generic/436
> - xfs/161 removed hardcoded and incorporated ritesh's comments
> 
> [1] https://lore.kernel.org/linux-xfs/20240503095353.3798063-1-mcgrof@kernel.org/
> 
> Pankaj Raghav (3):
>   xfs/161: adapt the test case for 64k FS blocksize
>   generic/436: round up bufsz to nearest filesystem blksz
>   xfs/008: use block size instead of the pagesize
> 
>  src/seek_sanity_test.c |  8 ++++----
>  tests/xfs/008          | 19 ++++++++++---------
>  tests/xfs/008.out      |  8 ++++----
>  tests/xfs/161          | 16 ++++++++++++----
>  4 files changed, 30 insertions(+), 21 deletions(-)
> 
> 
> base-commit: b26d68da08e47e6508a96bee72b25823040ab67e
> -- 
> 2.34.1
> 

