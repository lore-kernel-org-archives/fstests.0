Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0A45D91A
	for <fstests@vger.kernel.org>; Fri, 12 Jan 2024 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eO94XEKu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705066337;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7iaekVqJK9nhSOhPLHVUDDvK2n3hHVPlmo+CJ8u5AZg=;
	b=eO94XEKu7WWRx1SSZN8jzilQk8Q3waMXcQQSeQZiqT2NTZ3dszDkEiH3u2pazUSLNfbiLe
	epCzrnJUV/zFoKP6sJvbd9abryV6Le+IfBlLVRwVlg9qcFoF5jOhnxmnWsVlWWHMkn6U6w
	XwK/Pcj+mXO5aaKd9wkCtqaK0vwIGXg=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-282-Zm8uP_UHNUeq3SvBLdSJqw-1; Fri, 12 Jan 2024 08:32:10 -0500
X-MC-Unique: Zm8uP_UHNUeq3SvBLdSJqw-1
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bee15fb2b4so256344139f.1
        for <fstests@vger.kernel.org>; Fri, 12 Jan 2024 05:32:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705066329; x=1705671129;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7iaekVqJK9nhSOhPLHVUDDvK2n3hHVPlmo+CJ8u5AZg=;
        b=wy1AmIKMZbwAR88vayCMJOA93KlWXr2IW59Kvg7+IJkbvKwsDwNmlIaZl1x9bB5KYd
         D6bAZngwJzZT9X6KFLbg8vICZBHiBa2Nu0mlJGuI9GHQqoRovbwXRmt2BnZKLYuo3vQ2
         D5DuUnCNHjAG2tV+Y403g8RlFmVi7XGmS+V27LF1oFTGQzmpHl9nhqS1tQiCQBfVL4XX
         CIWop0inWSua7NTefsNc1mavGryBFd2QDHzpL4SHDBeZBAZgPmHf7qFBz2iMFRQI+ReZ
         QD62K+cXBSsUeKXiqBC8RKAN2m3IVdPEhF5NfXOYUTgNQVPU4bJCRObSfMCtX99Xm7fG
         wm2g==
X-Gm-Message-State: AOJu0YzXhaZJDE11V4PqcY/2uJxRKWqlWAAaL4DOd4+K2ICoS5eufOg8
	BFL5BGVLvRnY8fKtQ8XK59ZSwDqVfQcm9MZ2Dt42D1waG2LtJ+3VTt9F4QmWSH3T0RffAEQ9Rp3
	TWddUJW2W2w6LRCFe6TxGSvzjzoJbUQEGeB0s
X-Received: by 2002:a5e:c008:0:b0:7be:37f6:b998 with SMTP id u8-20020a5ec008000000b007be37f6b998mr1439913iol.21.1705066329469;
        Fri, 12 Jan 2024 05:32:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGei0sml5KQOOeE2JfPQSxzZ5dH/BhexoU6M7HuaZQoZG0x3OIX+3aD12uDrLEgBGGZVkev5A==
X-Received: by 2002:a5e:c008:0:b0:7be:37f6:b998 with SMTP id u8-20020a5ec008000000b007be37f6b998mr1439899iol.21.1705066329165;
        Fri, 12 Jan 2024 05:32:09 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i7-20020a639d07000000b005b7dd356f75sm3131010pgd.32.2024.01.12.05.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 05:32:08 -0800 (PST)
Date: Fri, 12 Jan 2024 21:32:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: djwong@kernel.org, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/4] xfs: add a _scratch_require_xfs_scrub helper
Message-ID: <20240112133205.yvdeh27in7l4qzu2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240112050833.2255899-1-hch@lst.de>
 <20240112050833.2255899-3-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112050833.2255899-3-hch@lst.de>

On Fri, Jan 12, 2024 at 06:08:31AM +0100, Christoph Hellwig wrote:
> Add a helper to call _supports_xfs_scrub with $SCRATCH_MNT and
> $SCRATCH_DEV.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  common/xfs    | 7 +++++++
>  tests/xfs/556 | 2 +-
>  tests/xfs/716 | 2 +-
>  3 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/common/xfs b/common/xfs
> index 4e54d75cc..b71ba8d1e 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -662,6 +662,13 @@ _supports_xfs_scrub()
>  	return 0
>  }
>  
> +# Does the scratch file system support scrub?
> +_scratch_require_xfs_scrub()

Usually we name a require helper as _require_xxxxxxxx, you can find that
by running `grep -rsn scratch_require common/` and `grep -rsn require_scratch common/`.

So better to change this name to _require_scratch_xfs_scrub. That's a simple
change, I can help to change that when I merge this patchset.

Thanks,
Zorro

> +{
> +	_supports_xfs_scrub $SCRATCH_MNT $SCRATCH_DEV || \
> +		_notrun "Scrub not supported"
> +}
> +
>  # Save a snapshot of a corrupt xfs filesystem for later debugging.
>  _xfs_metadump() {
>  	local metadump="$1"
> diff --git a/tests/xfs/556 b/tests/xfs/556
> index 061d8d572..6be993273 100755
> --- a/tests/xfs/556
> +++ b/tests/xfs/556
> @@ -40,7 +40,7 @@ _scratch_mkfs >> $seqres.full
>  _dmerror_init
>  _dmerror_mount >> $seqres.full 2>&1
>  
> -_supports_xfs_scrub $SCRATCH_MNT $SCRATCH_DEV || _notrun "Scrub not supported"
> +_scratch_require_xfs_scrub
>  
>  # Write a file with 4 file blocks worth of data
>  victim=$SCRATCH_MNT/a
> diff --git a/tests/xfs/716 b/tests/xfs/716
> index 930a0ecbb..4cfb27f18 100755
> --- a/tests/xfs/716
> +++ b/tests/xfs/716
> @@ -31,7 +31,7 @@ _require_test_program "punch-alternating"
>  _scratch_mkfs > $tmp.mkfs
>  _scratch_mount
>  
> -_supports_xfs_scrub $SCRATCH_MNT $SCRATCH_DEV || _notrun "Scrub not supported"
> +_scratch_require_xfs_scrub
>  
>  # Force data device extents so that we can create a file with the exact bmbt
>  # that we need regardless of rt configuration.
> -- 
> 2.39.2
> 
> 

