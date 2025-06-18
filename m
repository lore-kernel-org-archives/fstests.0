Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAD32EAB64
	for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 15:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750260065; cv=none; b=Bc7nKkIkIW2yKIU7d991QFHyxxOsMFexMeldXZX5nH9EfzMbsgasCe95byf7CKbGby7Eq3/rfGbUc9a17w//DaZpzlP7q2zMR4mumuab5ElLUjdaM5BQAA1NAaMZTfa2vvMdKDmb+ZIh466+W+UmIxcNKdQM8l4GSYWOaOyYdL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750260065; c=relaxed/simple;
	bh=r9uwIAjtrUP6ra8fDOE36xskqVLoUnIt69nrrMEiQa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L+L+Vq7suEBPiJ0BgB08o6G2e2yfkEhTuFSecHwI4Sr//tK0os+iTjwhtutvS6eteydf0+eQu9xYfnbIgwLPVLb518gq/JyvI+wNhqgkppQRVJMPVj1BR9Gabnq/hQEAc11DP4gVqVd/nUnUiP1HZkAZpkShVc33/JOpSSKYYM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBAf80/C; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBAf80/C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750260062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lWIkQUCenG3F3PX3x5M5o/OP8KKGomc1hDFaeyfKPMA=;
	b=PBAf80/C2PsinHVq/xgwG4hXYTZy5v9thoFP77E7DIDslf+uLcp1o4myQ17/0HbP/6v+ry
	adVuNqBXks7QW7aiQjqobmOqcU0UvWiD+OSscHYkyMjYLQx1XllkiXM1hn1XAQ9EbDtp75
	/ysXEXnjB4+B0Vg0HeI6V9PSKHgSSf4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-M46rMNaZM6OuyrTaaJwRdQ-1; Wed, 18 Jun 2025 11:21:01 -0400
X-MC-Unique: M46rMNaZM6OuyrTaaJwRdQ-1
X-Mimecast-MFC-AGG-ID: M46rMNaZM6OuyrTaaJwRdQ_1750260060
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74834bc5d37so10494561b3a.0
        for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 08:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750260060; x=1750864860;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWIkQUCenG3F3PX3x5M5o/OP8KKGomc1hDFaeyfKPMA=;
        b=J/zeHIaYoi1w203AqJuYBvdZddJMxsVXX2vgHXfczT9FC1kdvnYX4wdmrWqtjmmM5j
         RwdyLjPoZ5NZC50DoYOnVTjxQX1GNNKUoUcJwBJJ4V3Dt6wtZE7RYbXT72+RcsXspfgV
         0fm7in/XPs69eEKlkUy5BRHkJjXdcAZHdZHYhO9thx+oS/Hj3BPPj1ZVDIMaRaWfBNXn
         Vn4Rsv+1KddlpM3UGYYax9s4RioDNp63FPS/C34RULbm2nvS4NnVqiKd0Xc/3K06QjoG
         D7vVuLoFUFBBr9W6qC3KiPZIYv72XZMw6KK37AKgN7kdkl9sXXehrtwLAYSEQDrxsvCo
         4fPA==
X-Forwarded-Encrypted: i=1; AJvYcCWYInlaxKRY2cRjgDcI3h52ONTLpzbpBwXWoFB8uGklc+Tz+awzevhZL9SMxE8eqE24tZaPfLAK@vger.kernel.org
X-Gm-Message-State: AOJu0YwT5MXnlsjjbG7P+pyVtQJDQkErv1XUxwneaB4J1w71+Qa6v5mq
	P57LY8Ie5g6wVO4b8AsLbc8KJ6EdjiqM5liRBY2By4wEnAnr7DDpxTl498afH91Mwn+/JpREqCC
	dOWpkGolodsDBCJIxm3Bdkz76oYoEEN1Z6hLA2W735y7ZdqgylNimUN3Wxfs=
X-Gm-Gg: ASbGncu1sYNkvzac291k0ydXJhd9rKeXfOtVOdtqQPnNFLjtKBJ+FBwRs0G0VDHArEp
	bp5JZPATyMopJxCYBow27Wob9CitPeZim2mdXQyAEZnI9BYxl5gWR2dtMRvYD83H+wp5bLJG3w/
	ltH2oVl2GMjNLOxHiw8OtFaJ4j9aN6k2iu7vTN/f5sWf+1qLziRoYS5VSVpD0as1/RAEDoWB1dN
	F5y5I4gn6jtonRi+jpCGm/wqfmvMp62qGBTIut8/mwo9s4cNrG+OJxUGHvFzk7Lme8PxaN+9/Vu
	xoUBjTtxhQgUWluEw/1hopCsdDlRPXkOO6GrBkZn/IJr1sqbHeAVmtlpLneh5l4=
X-Received: by 2002:a05:6a00:a1b:b0:748:f365:bedd with SMTP id d2e1a72fcca58-748f365c29bmr1070971b3a.17.1750260059864;
        Wed, 18 Jun 2025 08:20:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZabfvJdt2Ho6EE9eagvnI32TQwTXd0Y//d206eDGoC+fgtQAbQUIGrXRTmpS/L6JqYSJpTA==
X-Received: by 2002:a05:6a00:a1b:b0:748:f365:bedd with SMTP id d2e1a72fcca58-748f365c29bmr1070931b3a.17.1750260059415;
        Wed, 18 Jun 2025 08:20:59 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d29adsm11139648b3a.164.2025.06.18.08.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 08:20:58 -0700 (PDT)
Date: Wed, 18 Jun 2025 23:20:54 +0800
From: Zorro Lang <zlang@redhat.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	=?utf-8?B?QW5kcsOp?= Almeida <andrealmeid@igalia.com>,
	linux-unionfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 2/3] fstests: add helper _require_xfs_io_shutdown
Message-ID: <20250618152054.iyxxizt5hazzduw3@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250609151915.2638057-1-amir73il@gmail.com>
 <20250609151915.2638057-3-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609151915.2638057-3-amir73il@gmail.com>

On Mon, Jun 09, 2025 at 05:19:14PM +0200, Amir Goldstein wrote:
> Requirements for tests that shutdown fs using "xfs_io -c shutdown".
> The requirements are stricter than the requirement for tests that
> shutdown fs using _scratch_shutdown helper.
> 
> Generally, with overlay fs, tests can do _scratch_shutdown, but not
> xfs_io -c shutdown.
> 
> Encode this stricter requirement in helper _require_xfs_io_shutdown
> and use it in test generic/623, to express that it cannot run on
> overalyfs.
> 
> Reported-by: André Almeida <andrealmeid@igalia.com>
> Link: https://lore.kernel.org/linux-fsdevel/20250521-ovl_ro-v1-1-2350b1493d94@igalia.com/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  common/rc         | 21 +++++++++++++++++++++
>  tests/generic/623 |  2 +-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/common/rc b/common/rc
> index d9a8b52e..21899a4a 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -616,6 +616,27 @@ _scratch_shutdown_and_syncfs()
>  	fi
>  }
>  
> +# Requirements for tests that shutdown fs using "xfs_io -c shutdown".
> +# The requirements are stricter than the requirement for tests that
> +# shutdown fs using _scratch_shutdown helper.
> +# Generally, with overlay fs, test can do _scratch_shutdown, but not
> +# xfs_io -c shutdown.
> +# It is possible, but not trivial, to execute "xfs_io -c shutdown" as part
> +# of a command sequence when shutdown ioctl is to be performed on the base fs
> +# (i.e. on an alternative _scratch_shutdown_handle path) as the example code
> +# in _scratch_shutdown_and_syncfs() does.
> +# A test that open codes this pattern can relax the _require_xfs_io_shutdown
> +# requirement down to _require_scratch_shutdown.
> +_require_xfs_io_shutdown()
> +{
> +	if [ _scratch_shutdown_handle != $SCRATCH_MNT ]; then
> +		# Most likely overlayfs
> +		_notrun "xfs_io -c shutdown not supported on $FSTYP"
> +	fi
> +	_require_xfs_io_command "shutdown"
> +	_require_scratch_shutdown

Thanks, I think this's good to me now,

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +}
> +
>  _move_mount()
>  {
>  	local mnt=$1
> diff --git a/tests/generic/623 b/tests/generic/623
> index b97e2adb..f546d529 100755
> --- a/tests/generic/623
> +++ b/tests/generic/623
> @@ -15,7 +15,7 @@ _begin_fstest auto quick shutdown mmap
>  	"xfs: restore shutdown check in mapped write fault path"
>  
>  _require_scratch_nocheck
> -_require_scratch_shutdown
> +_require_xfs_io_shutdown
>  
>  _scratch_mkfs &>> $seqres.full
>  _scratch_mount
> -- 
> 2.34.1
> 

