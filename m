Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7880A1CF7B5
	for <fstests@vger.kernel.org>; Fri, 11 Oct 2024 05:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728623646; cv=none; b=DMYSqrY7FsKvJi+ox/zVrurQ8VKQpKRuzWluCl0uE17cSS304rSerAcviRgEXQZij4eFyYdB1wnBVIMUpMtwAz/fmFCaWR8TaewTqacIQVdrXn4TkKhFS7SGNKithKRWgM+tmEmJR7DbHqyjcy5yM+sji3rv9em8Fw5olF81JrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728623646; c=relaxed/simple;
	bh=JqpA2v+hs87ICGXIUn706nr4sJOJBkq+VFCXhddJBKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8miWOqvXLY2I9QII4tnDaxTxqBU3nxUzqHQEbxyLjr0lxdfTUHjI09LFs3CTkOTSQ+tFJLri57iCKmDnyxygopPuLrXFEnX1bRf9hUtE7++V0kLD4dx08fiz3y6MHe9wVff8CIsVSG5CCNhn34y0hO8k6fwxnzlT4L129j2ufk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELaUZoUc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELaUZoUc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728623644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=w8CNWf5jo9Ul/2dW2dvhhQFF2tcZI8t8jV67qvSSfqY=;
	b=ELaUZoUcp9cL4tWIz/GPDMOQhAVjNl+c2dZzTwPwK815zqt9li/IAafLyB8QXC+jMzSu85
	z/wJktEgsQEoFOzHW6oskTZ3uIQzS5NR9vb5S+YBuEB0tFuadnaoHawTFyiYw3/j4pDHRn
	881Beu/XkY0EDpLcP5Y/mPn4xAEqEbw=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-V5Gb-UALMyuzLFDSQYNdQA-1; Fri, 11 Oct 2024 01:14:02 -0400
X-MC-Unique: V5Gb-UALMyuzLFDSQYNdQA-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-71e01bfe040so1914801b3a.1
        for <fstests@vger.kernel.org>; Thu, 10 Oct 2024 22:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728623642; x=1729228442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8CNWf5jo9Ul/2dW2dvhhQFF2tcZI8t8jV67qvSSfqY=;
        b=PSZaK+uhN9uP6+HG0OzAaBdCqh/Ae8m+c/zuRsAOq9SOZHQMzXU43g98jr5obmadK5
         acT2v/zaG/1b5xx/CQT72/9n8Eoddr0Bsgl/kL5s/YkoU+ZkllILgAErx96fq9Okfux4
         U3dFm9N57BNgFHueZkH0rLvKI9MSXtsILzE5Z2rRKxkBvofkyL7A9G4kp0dBSe+P/qqn
         oAJNK+DigwiaGkW9DqnSg6hxmUS9s+Y3+W8zSwfxsYegF+nY41FaDCScN6dLG/ER44KX
         +rLig3ROhau2/8pjjhZbj7iVhHDMGTUbAX5mE2yGtKYyS3Lp0ok8O0b1HyW+4AcTthYk
         Ylfg==
X-Gm-Message-State: AOJu0Ywyko/nrvOibpHs9bVWEgC1CGRn78H6LXfbMetsRHUO9eHWYeFc
	FCiZo188pLW8OzN1X2yYhNuL/3V6I/rV9SCBTofJjI4Vf4OMDRGVeKpdYhM5mQheseFBD5vIZga
	suXI5piLS6iE6KWkiJ8EBf9IqN78QMDZPbQxaz13Yd8i4/tyQjy2oDtw=
X-Received: by 2002:a05:6a00:a05:b0:714:15ff:a2a4 with SMTP id d2e1a72fcca58-71e37ed2ec8mr2371992b3a.13.1728623641647;
        Thu, 10 Oct 2024 22:14:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOb3prsZgS5Xx0/c/yGPe3I0e5YYezLoWUiBqHjB3htzd1Ga72Yw01vkr4fl02Hoh5tyFusQ==
X-Received: by 2002:a05:6a00:a05:b0:714:15ff:a2a4 with SMTP id d2e1a72fcca58-71e37ed2ec8mr2371977b3a.13.1728623641259;
        Thu, 10 Oct 2024 22:14:01 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e2a9e96eesm1904479b3a.35.2024.10.10.22.13.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 22:14:00 -0700 (PDT)
Date: Fri, 11 Oct 2024 13:13:56 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
	Brian Foster <bfoster@redhat.com>
Subject: Re: [PATCH] fsstress: add support for FALLOC_FL_UNSHARE_RANGE
Message-ID: <20241011051356.mjaoarskwedmjs75@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <172780126017.3586479.18209378224774919872.stgit@frogsfrogsfrogs>
 <20241003213714.GH21840@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003213714.GH21840@frogsfrogsfrogs>

On Thu, Oct 03, 2024 at 02:37:14PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> Teach fsstress to try to unshare file blocks on filesystems, seeing how
> the recent addition to fsx has uncovered a lot of bugs.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---

Thanks for this new test coverage on fsstress. Although it's conflict with
current for-next branch, I've merged it manually, don't need one more
version :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  ltp/fsstress.c |   14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/ltp/fsstress.c b/ltp/fsstress.c
> index b8d025d3a0..8cd45c7a85 100644
> --- a/ltp/fsstress.c
> +++ b/ltp/fsstress.c
> @@ -139,6 +139,7 @@ typedef enum {
>  	OP_TRUNCATE,
>  	OP_UNLINK,
>  	OP_UNRESVSP,
> +	OP_UNSHARE,
>  	OP_URING_READ,
>  	OP_URING_WRITE,
>  	OP_WRITE,
> @@ -246,6 +247,7 @@ void	punch_f(opnum_t, long);
>  void	zero_f(opnum_t, long);
>  void	collapse_f(opnum_t, long);
>  void	insert_f(opnum_t, long);
> +void	unshare_f(opnum_t, long);
>  void	read_f(opnum_t, long);
>  void	readlink_f(opnum_t, long);
>  void	readv_f(opnum_t, long);
> @@ -339,6 +341,7 @@ struct opdesc	ops[OP_LAST]	= {
>  	[OP_TRUNCATE]	   = {"truncate",      truncate_f,	2, 1 },
>  	[OP_UNLINK]	   = {"unlink",	       unlink_f,	1, 1 },
>  	[OP_UNRESVSP]	   = {"unresvsp",      unresvsp_f,	1, 1 },
> +	[OP_UNSHARE]	   = {"unshare",       unshare_f,	1, 1 },
>  	[OP_URING_READ]	   = {"uring_read",    uring_read_f,	-1, 0 },
>  	[OP_URING_WRITE]   = {"uring_write",   uring_write_f,	-1, 1 },
>  	[OP_WRITE]	   = {"write",	       write_f,		4, 1 },
> @@ -3767,6 +3770,7 @@ struct print_flags falloc_flags [] = {
>  	{ FALLOC_FL_COLLAPSE_RANGE, "COLLAPSE_RANGE"},
>  	{ FALLOC_FL_ZERO_RANGE, "ZERO_RANGE"},
>  	{ FALLOC_FL_INSERT_RANGE, "INSERT_RANGE"},
> +	{ FALLOC_FL_UNSHARE_RANGE, "UNSHARE_RANGE"},
>  	{ -1, NULL}
>  };
>  
> @@ -4469,6 +4473,16 @@ insert_f(opnum_t opno, long r)
>  #endif
>  }
>  
> +void
> +unshare_f(opnum_t opno, long r)
> +{
> +#ifdef HAVE_LINUX_FALLOC_H
> +# ifdef FALLOC_FL_UNSHARE_RANGE
> +	do_fallocate(opno, r, FALLOC_FL_UNSHARE_RANGE);
> +# endif
> +#endif
> +}
> +
>  void
>  read_f(opnum_t opno, long r)
>  {
> 

