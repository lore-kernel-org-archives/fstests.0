Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4AA770F3
	for <fstests@vger.kernel.org>; Tue, 21 May 2024 14:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716300106; cv=none; b=WsApy9q+nBlEGHw3daHmw35Tf4+aPA7GrLXDkCN25BSiN2y0e1l/uKv4EyVrgVdHhg861n0jX5iCG5o94+hzGAZypm4IW1517poVhfO5eg2XgMG3cwsmwa8u46C2ERY8CkkpmeSiKLjk2KzDP9Sz6WfE9dL7x6OiRhHpqAXNHzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716300106; c=relaxed/simple;
	bh=EYqKcCI3tv2tT6clHDjGD3Z92vug3Et1dPHP3EkvB1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTdQF9dGDEEtdVFhpNOKW+5hCgiyu29FN1eFtOLS7Ptfu+eeyMVYYH+6KGUFPh3Tu/aHy+dqMaw0ti04qh3hqxNcWEe3ZmAbmQ5qcBIYuSRfhp/FYHlgIBYu591oVkVPJI9woX5aEIC82nUnCeasO0V+Y0vHXsQvDRK41hoOJ/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UV1QgDqX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UV1QgDqX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716300104;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L9UZBaBm0Gs/lAN/t3Z/bR3D6w1BaSGi3sD1JXjc9P0=;
	b=UV1QgDqXds38NQqT+RFHjuZXIuPD1LSTCeugMMMVSg+ImAHRJ/dIyc6ydCTqMMr1K7eGYo
	iYJ/DTJukKha7WEIKbou2JM3dT3FUPVxyOB8EmrEyqLoA2zf0Dz7ovyOOx1zqPbRX0fAYJ
	tf2d7hKiK43BDD4d6rGjTgrZ248AvT8=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-gxtMyTwbN9SHd5_IA8kFrA-1; Tue, 21 May 2024 10:01:41 -0400
X-MC-Unique: gxtMyTwbN9SHd5_IA8kFrA-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-1f2dba0679aso48890725ad.3
        for <fstests@vger.kernel.org>; Tue, 21 May 2024 07:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716300100; x=1716904900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9UZBaBm0Gs/lAN/t3Z/bR3D6w1BaSGi3sD1JXjc9P0=;
        b=TrfB5F4BBYwVGapdVICISfAf5AtxLP7ZCcFKcfcUExcmBP6Az5WClvbnSakow7KVqY
         AofZeX1Fo6ACwJmq3mHNgARET1v78kdKLIkrdck3cXrO7IBsTHsXxvrR/9vBX3aov+XB
         EC1CQsgBvzDEMe+kC0IXf68LRZl7zsyqHH7Px0xKlxaZo315g33Vs9BtKGPO+PX3xyVV
         kmE3ptB2sFPHkS2s6PEYH0eE0mq5Id4K8Bm5jT9BRYyU8AvWTNqPvZcn3D9YMwnRSwPu
         xUPKmofcAlEDpqVKBuNrX6t8p0WyaQIqCnOViVPhPJ1b+fH9iMRhXSCZLzqR1oic0bQQ
         i1ow==
X-Gm-Message-State: AOJu0YwMluMgDa7dzs2ZsUA/iSlAYevGOyv43z8UHHis5D1/70sOe6sT
	dRTsvM3RPA4fiszokEGBQod71h+198DC7r9SCYewzVyd1DnzCc56Ab/SktrUn+FY0duxLLyBpMN
	lHNRRa/BfkmPJEOhoriNisCjlpUJodZsR4ZCMS9Y7e2K6ryoiS75ns94=
X-Received: by 2002:a17:902:e546:b0:1f2:f107:5a71 with SMTP id d9443c01a7336-1f2f107618fmr102622485ad.44.1716300099081;
        Tue, 21 May 2024 07:01:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECtVoYVSuGzI2BlB2iJoT8bqImwLA9462R5K2Fv1nNwba64aKryGPgjWXLKArNybXPfq7WiQ==
X-Received: by 2002:a17:902:e546:b0:1f2:f107:5a71 with SMTP id d9443c01a7336-1f2f107618fmr102621755ad.44.1716300098211;
        Tue, 21 May 2024 07:01:38 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0badadacsm222621585ad.111.2024.05.21.07.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 07:01:37 -0700 (PDT)
Date: Tue, 21 May 2024 22:01:34 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] generic/733: add commit ID for btrfs
Message-ID: <20240521140134.gicbq65cksob5yno@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <dd6b7b2fad05501bead1b786babcb825548b9566.1716292871.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd6b7b2fad05501bead1b786babcb825548b9566.1716292871.git.fdmanana@suse.com>

On Tue, May 21, 2024 at 01:01:29PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> As of commit 5d6f0e9890ed ("btrfs: stop locking the source extent range
> during reflink"), btrfs now does reflink operations without locking the
> source file's range, allowing concurrent reads in the whole source file.
> So update the test to annotate that commit.
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---

Make sense to me, Thanks!

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/733 | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/generic/733 b/tests/generic/733
> index d88d92a4..f6ee7f71 100755
> --- a/tests/generic/733
> +++ b/tests/generic/733
> @@ -7,7 +7,8 @@
>  # Race file reads with a very slow reflink operation to see if the reads
>  # actually complete while the reflink is ongoing.  This is a functionality
>  # test for XFS commit 14a537983b22 "xfs: allow read IO and FICLONE to run
> -# concurrently".
> +# concurrently" and for BTRFS commit 5d6f0e9890ed "btrfs: stop locking the
> +# source extent range during reflink".
>  #
>  . ./common/preamble
>  _begin_fstest auto clone punch
> @@ -26,8 +27,16 @@ _require_test_program "punch-alternating"
>  _require_test_program "t_reflink_read_race"
>  _require_command "$TIMEOUT_PROG" timeout
>  
> -[ "$FSTYP" = "xfs" ] && _fixed_by_kernel_commit 14a537983b22 \
> -        "xfs: allow read IO and FICLONE to run concurrently"
> +case "$FSTYP" in
> +"btrfs")
> +	_fixed_by_kernel_commit 5d6f0e9890ed \
> +		"btrfs: stop locking the source extent range during reflink"
> +	;;
> +"xfs")
> +	_fixed_by_kernel_commit 14a537983b22 \
> +		"xfs: allow read IO and FICLONE to run concurrently"
> +	;;
> +esac
>  
>  rm -f "$seqres.full"
>  
> -- 
> 2.43.0
> 
> 

