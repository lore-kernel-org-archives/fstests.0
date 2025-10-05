Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594C234BA22
	for <fstests@vger.kernel.org>; Sun,  5 Oct 2025 10:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759660627; cv=none; b=NOiO3mniNtvY9pmkkx4Tqmygpr3p0W+f1txOMpU/ZO52mf8dSTpcrlcrp9SHUnkNT/T7Fc9S9Jg7rM2NfK4K9ZWZypgJfRmrpY2nilQruodcqF+zN4NFNuvjwEXeSwKN80WP/Q0aoTxr8xJRhEz7JbTacvwIQAn+CWiX1sf8nUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759660627; c=relaxed/simple;
	bh=6LIHPOQPLDWrr6EbSN7wwdKPe2nDjZ08h3rW+KOWZrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RgOC05PVvbX1kjccRwV96tAL9/ICCnXpit56KEpZlge5/DnfVmscu8iN5kZO7zoO8IMjc3SgMGKcwVBmM/xpCnwKMenTxUt4yIH/QF+xyUvS8NvCrGoJLrGKFsADEA3pS7fD1XbCRTS8oLqRoyrisMqNRNZYswmiO33B7hffWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gUN9Anrr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gUN9Anrr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759660624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cXE+Do4eiYEQpRMZRWtP81SSjx9Cj+R+tBIOazUtRqs=;
	b=gUN9Anrr0iQVvomA4xAn4cpGcv3Kh/0Y/0KXb5L2D47t9JroSbVzWxpC6u+gxd1rOdJaUQ
	0UH7c50Paxe9zSmPYyv3vxX6lQFGeXS8si1wI8uUtaE+z0mu4dB60EafILqPLtptc07goc
	wWfT60ILpIXaTiokwSL3p4PYC/hjV90=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-Eepdmp3yO6S5nhCiO9Dt3g-1; Sun, 05 Oct 2025 06:37:03 -0400
X-MC-Unique: Eepdmp3yO6S5nhCiO9Dt3g-1
X-Mimecast-MFC-AGG-ID: Eepdmp3yO6S5nhCiO9Dt3g_1759660622
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-33428befc5bso3865820a91.0
        for <fstests@vger.kernel.org>; Sun, 05 Oct 2025 03:37:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759660622; x=1760265422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cXE+Do4eiYEQpRMZRWtP81SSjx9Cj+R+tBIOazUtRqs=;
        b=cFLO7mlNHyG0Qd2hN1ZVFmlcDofZf6rhq8KH7jUQnVEL1aZb24y8l4vBVt117zn70I
         7N9IRICDQO8KgF2iP1oI9dBsZydtWWUo+aQMkFnT7VuCxnKKRe4gxbqrw5TfflSAWBXD
         BY/8IFLl7WU6IZ8Dv0Vl9YUCdHOAzcitaOgrs9j9x4IxJsSGKWFcd827lQmfJAuATEc1
         jnsuw508Y4gsn4ivSqCSgpncy4V5GpDm67N/W7irNHNoBWOhExlePadZy0Rq8hF/GXkv
         lHdW9KFwzg5NKWNdElHakYnEBgYmch8aBMx3LsPD8YzUrEFh03kmS7qe1juAMsyl2x+K
         AfdQ==
X-Gm-Message-State: AOJu0Yy/gn/Lb5o4oJ/DWlgEdCxSJTFCiK9YLC5B9lkhbW6jZwa3onEK
	0ETYBuG0PpGZqHyvEDoPrJgdMRFUl3f3fEGxS8NauAYaqa1vAWH64dXKit2xxH3UYYX6mHK9IZI
	tHGGWXyCgLVV4l88DJJ9s57nkzKhLuVjtfMq1WaaL9ZMb/MbSQz0TWkcqzVU=
X-Gm-Gg: ASbGnct4DwnGXL/B4j8LOuxpp4o0Crg1D90sqKmdLySQzzG3ulmtUiZYIWa0H/f08MH
	YTb074ffZmCWnRwfYHk5o6qQNCL+gk+3ZY5fSvZ9VnGaYWyhBkU5QZR0ZJPC0360dZdzsHXRN3E
	hATk97PA+xqqfiHBLCz90oueSygft4XaLBQ1WkbOGTN4f20xRAV9OhxnUTcNNqD9Ve1QdlrxZeS
	Z4tFPb2zBp9Hqlx0w+LAHq2TDUde0Od5vPQ74ZsdbzoX3kiGj0yZOoX3E1EjgWiS+JBp8xiNKE7
	1MwGh2g+bK3wMgFNLs/xjhXyoQkaqPxZbM+2mVyXwucvBVPoYlKnE1Wqs9DbPAL7zy7aNERGbaz
	X1MW0/930Jg==
X-Received: by 2002:a17:90b:1b48:b0:327:ba77:a47 with SMTP id 98e67ed59e1d1-339c2782afbmr12219254a91.15.1759660621778;
        Sun, 05 Oct 2025 03:37:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFm83AyjS7X4hJtAl1cFaaDJwlNM/NB1MMUPpV8cEk9b8Sb3eLjy4T+3C65MTyp4EHmOdh1hA==
X-Received: by 2002:a17:90b:1b48:b0:327:ba77:a47 with SMTP id 98e67ed59e1d1-339c2782afbmr12219225a91.15.1759660621290;
        Sun, 05 Oct 2025 03:37:01 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099d4d324sm9665636a12.27.2025.10.05.03.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Oct 2025 03:37:00 -0700 (PDT)
Date: Sun, 5 Oct 2025 18:36:56 +0800
From: Zorro Lang <zlang@redhat.com>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, Andrey Albershteyn <aalbersh@kernel.org>
Subject: Re: [PATCH v4 1/3] file_attr: introduce program to set/get fsxattr
Message-ID: <20251005103656.5qu3lmjvlcjkwjx4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251003-xattrat-syscall-v4-0-1cfe6411c05f@kernel.org>
 <20251003-xattrat-syscall-v4-1-1cfe6411c05f@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003-xattrat-syscall-v4-1-1cfe6411c05f@kernel.org>

On Fri, Oct 03, 2025 at 11:32:44AM +0200, Andrey Albershteyn wrote:
> This programs uses newly introduced file_getattr and file_setattr
> syscalls. This program is partially a test of invalid options. This will
> be used further in the test.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> ---

[snap]

> +	if (!path1 && optind < argc)
> +		path1 = argv[optind++];
> +	if (!path2 && optind < argc)
> +		path2 = argv[optind++];
> +
> +	if (at_fdcwd) {
> +		fd = AT_FDCWD;
> +		path = path1;
> +	} else if (!path2) {
> +		error = stat(path1, &status);
> +		if (error) {
> +			fprintf(stderr,
> +"Can not get file status of %s: %s\n", path1, strerror(errno));
> +			return error;
> +		}
> +
> +		if (SPECIAL_FILE(status.st_mode)) {
> +			fprintf(stderr,
> +"Can not open special file %s without parent dir: %s\n", path1, strerror(errno));
> +			return errno;
> +		}
> +
> +		fd = open(path1, O_RDONLY);
> +		if (fd == -1) {
> +			fprintf(stderr, "Can not open %s: %s\n", path1,
> +					strerror(errno));
> +			return errno;
> +		}
> +	} else {
> +		fd = open(path1, O_RDONLY);
> +		if (fd == -1) {
> +			fprintf(stderr, "Can not open %s: %s\n", path1,
> +					strerror(errno));
> +			return errno;
> +		}
> +		path = path2;
> +	}
> +
> +	if (!path)
> +		at_flags |= AT_EMPTY_PATH;
> +
> +	error = file_getattr(fd, path, &fsx, fa_size,
> +			at_flags);
> +	if (error) {
> +		fprintf(stderr, "Can not get fsxattr on %s: %s\n", path,
> +				strerror(errno));
> +		return error;
> +	}

We should have a _require_* helper to _notrun your generic and xfs test cases,
when system doesn't support the file_getattr/setattr feature. Or we always hit
something test errors like below on old system:

  +Can not get fsxattr on ./fifo: Operation not supported

Maybe check if the errno is "Operation not supported", or any better idea?


Thanks,
Zorro

> +	if (action) {
> +		fsx.fa_xflags |= (fa_xflags | unknwon_fa_flag);
> +
> +		error = file_setattr(fd, path, &fsx, fa_size,
> +				at_flags);
> +		if (error) {
> +			fprintf(stderr, "Can not set fsxattr on %s: %s\n", path,
> +					strerror(errno));
> +			return error;
> +		}
> +	} else {
> +		if (path2)
> +			print_xflags(fsx.fa_xflags, 0, 1, path, 0, 1);
> +		else
> +			print_xflags(fsx.fa_xflags, 0, 1, path1, 0, 1);
> +	}
> +
> +	return error;
> +
> +usage:
> +	printf("Usage: %s [options]\n", argv[0]);
> +	printf("Options:\n");
> +	printf("\t--get, -g\t\tget filesystem inode attributes\n");
> +	printf("\t--set, -s\t\tset filesystem inode attributes\n");
> +	printf("\t--at-cwd, -a\t\topen file at current working directory\n");
> +	printf("\t--no-follow, -n\t\tdon't follow symlinks\n");
> +	printf("\t--set-nodump, -d\t\tset FS_XFLAG_NODUMP on an inode\n");
> +	printf("\t--invalid-at, -i\t\tUse invalid AT_* flag\n");
> +	printf("\t--too-big-arg, -b\t\tSet fsxattr size bigger than PAGE_SIZE\n");
> +	printf("\t--too-small-arg, -m\t\tSet fsxattr size to 19 bytes\n");
> +	printf("\t--new-fsx-flag, -x\t\tUse unknown fa_flags flag\n");
> +
> +	return 1;
> +}
> 
> -- 
> 2.50.1
> 

