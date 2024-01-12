Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147926BB51
	for <fstests@vger.kernel.org>; Fri, 12 Jan 2024 13:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HJm29UlD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705065663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mhi/+JgNV+S+4kaUsq/RAwFdZECY3i+QjvGNP8Cshdw=;
	b=HJm29UlDb6pcBCnQlVKuO7dIRqrQ6ogi3gbuCSwq3U2eMdCrIYp4gCLnIhbFlT2mNIjLb2
	JlUZg4dadx8BL/kTBVnPfE96CV0hhwqf/fvy8WAHgAVAvv5jWxV6QT5y/P+FvODkkc17uB
	/1CdtvkloQ7vw77v/IIQLhh1z/5Xyp8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-ygR_RYrvPUuWTj4WBysi9g-1; Fri, 12 Jan 2024 08:21:02 -0500
X-MC-Unique: ygR_RYrvPUuWTj4WBysi9g-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6d9b8fef16aso4797553b3a.0
        for <fstests@vger.kernel.org>; Fri, 12 Jan 2024 05:21:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705065661; x=1705670461;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mhi/+JgNV+S+4kaUsq/RAwFdZECY3i+QjvGNP8Cshdw=;
        b=U+R5AEICNBYa3exwNWLb/tR4nmVqwh1wKVIqEYu2G3YC4uy8slX+ozBiTg00ZnlB++
         PzlZCXEygdAVwqpfHGnYBDw+wrulHfoO3YrjzNKe6ceTfS8/7alyAjOxJpHhRF7jQXnt
         W2r8fMJMIWWT8XO8bI8RvUR03TW/bDVrRyHjt0tMmnYS6IlQ1Z7QUfFjNJ0EBZVlZwOU
         C/YAtcnorf0mmzJwP5GiKLwv9W8J3F+i22bnttNDDm7RODwoojHhaKiymA/zwrzX+a9M
         s/ufRKfdTG7CJ1IUnJM55UXcTzyybteF9xTonbd7VXxQK1966yC4cz06ZWcqSimn1TAv
         WJuw==
X-Gm-Message-State: AOJu0YwFjLUVpy0lCXcFnPhJF8IGnCvlrxddX99x5eMW1MN2nx9Z1H4W
	j8E5kOE3vbQQNOO9dA/9gug6XmxXPMw8gOnbFiCbgq/PGLXvHZakoQXvtJFwICriZBtZ/5NrXd9
	/x23ZsQRMV/MVAnXdnOP0yStZ55rg7MON6wOz
X-Received: by 2002:a05:6a00:464f:b0:6d9:acb2:29ac with SMTP id kp15-20020a056a00464f00b006d9acb229acmr1398178pfb.23.1705065661159;
        Fri, 12 Jan 2024 05:21:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHOkbGz4wknQxKd35c5FYm98su9D3XNN32OBsrmlsx3jNtp1Jq9SZFAEwfBLL3+HhBmbphcBQ==
X-Received: by 2002:a05:6a00:464f:b0:6d9:acb2:29ac with SMTP id kp15-20020a056a00464f00b006d9acb229acmr1398164pfb.23.1705065660850;
        Fri, 12 Jan 2024 05:21:00 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id j6-20020aa783c6000000b006dab36287bfsm3134732pfn.207.2024.01.12.05.20.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 05:21:00 -0800 (PST)
Date: Fri, 12 Jan 2024 21:20:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: djwong@kernel.org, fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/4] xfs: check that the mountpoint is actually mounted
 in _supports_xfs_scrub
Message-ID: <20240112132057.2uunfrh4ar6xurk5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240112050833.2255899-1-hch@lst.de>
 <20240112050833.2255899-2-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112050833.2255899-2-hch@lst.de>

On Fri, Jan 12, 2024 at 06:08:30AM +0100, Christoph Hellwig wrote:
> Add a sanity check that the passed in mount point is actually mounted
> to guard against actually calling _supports_xfs_scrub before
> $SCRATCH_MNT is mounted.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

This version is good to me, thanks!

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/xfs | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/common/xfs b/common/xfs
> index f53b33fc5..4e54d75cc 100644
> --- a/common/xfs
> +++ b/common/xfs
> @@ -649,6 +649,9 @@ _supports_xfs_scrub()
>  	test "$FSTYP" = "xfs" || return 1
>  	test -x "$XFS_SCRUB_PROG" || return 1
>  
> +	mountpoint $mountpoint >/dev/null || \
> +		_fail "$mountpoint is not mounted"
> +
>  	# Probe for kernel support...
>  	$XFS_IO_PROG -c 'help scrub' 2>&1 | grep -q 'types are:.*probe' || return 1
>  	$XFS_IO_PROG -c "scrub probe" "$mountpoint" 2>&1 | grep -q "Inappropriate ioctl" && return 1
> -- 
> 2.39.2
> 
> 

