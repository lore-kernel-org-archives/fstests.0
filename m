Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C368719E96D
	for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 19:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750274015; cv=none; b=ky9PZGlbO4m3heyhkVIUx8j5odPW+gNBRgVUY/Q6hgtQQJAyVt8j25mvPn4BHaRM+F3ZDbchQ+pi6eWUyBO1ssNr2ZVEQxwrDSIa1iiJnudFulpGIaTCiryrNTWNMKtQXs8hwVTx1osCwq6NPZCcddvf7KZHd4/GxjKj9PVxGAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750274015; c=relaxed/simple;
	bh=qRwep9XAM7Zn2ps+BVB4GITmsRJ61Ufct97ZvwpDBMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=seBwhyg3AZ15x31Mi6wjV0tgVZhiHjvCmyXLIj+lokJ9SLqP01jsKIMhUjedQUTzQHc4MmBvQZcRkdNOIufbn1+uN6iODEjtPdNTjDt9WUmdf096uGxmp/fHzKd2oRGiSloEvN2T37gD1CkyAXyNvdTGvt+Fs9D0vDvaq7Epv+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R6cE9MxW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6cE9MxW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750274012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B2vSDRxa894tXJCn4Fj5oVUc47J42gyRIxuocPUBGVc=;
	b=R6cE9MxWuEy9vz2R1rUqTEbola17E3IWqmJG+JskdGrmFQd7RE8hOrcJ/A1u6mFOFziHEJ
	KL0Hihpm0HDob5r+xHc6QLz+oa8wdZp+QhM6YWgQ/WTV4J2Aq1xg50cY6ZlEINTJLfK8MS
	wU8hZT7TAhY6gst+3k4Qo9Hps87MAlI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-251-IJ3sJFGJNz6VUBB_e2n0uw-1; Wed, 18 Jun 2025 15:13:31 -0400
X-MC-Unique: IJ3sJFGJNz6VUBB_e2n0uw-1
X-Mimecast-MFC-AGG-ID: IJ3sJFGJNz6VUBB_e2n0uw_1750274010
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-748d96b974cso2047855b3a.2
        for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 12:13:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750274010; x=1750878810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2vSDRxa894tXJCn4Fj5oVUc47J42gyRIxuocPUBGVc=;
        b=j2/0rAmaN0NVsXNss0YcLkOPcVSfub9fOIF2G8dVGg1Gsgfdxyp9u/ewsE1r/2qrNc
         RENEvFKprh7uN80v7MrtbA6UVeSsdVHkX49kRDsLdzBdcT1RyuC64OCmk3ox13HRS8qz
         dW7gjwjNltch29Xspj3d4EYcuDFr7dWFHEZmAaHAHx97gTttcqcQy6dZRqez2oiZDA3b
         rxtAZnptNp5GrkbGidzOZX0UFa8SK3yu5Q4QYyimrboJ1flEWSzUpXReBjHo9u+7/Q6Q
         V5+EtQxOOI1L8qFQK4heg8IskufVxWJ+ALztQpVO6FxHFLzCmFn0dUQHmNpdP1csrjh1
         LlwQ==
X-Gm-Message-State: AOJu0YwnY3AaTM7uB7ORZHT0iV+/dfcgPU2mQ9ZnBNarjia8m3KsNKJ+
	XT32gf9ADnasR+iFn1VG4uwvFuPDA3JstkK/8F3crF5oHF37dbJxv0p4r2b3mhcp0od2q3R4PPa
	M2cfyGijZ2stq/4FmN5Fdph8LOqhNfllbVA69Vakyklx7kjq5JECFNzAheJ8=
X-Gm-Gg: ASbGncvOuRElQXBJWhAamO0fAM5iwUDZYowTjbSWzLJ/jv59sXAraXzh0KYsgU/7WXH
	Ak0wQd4Sn/hoHApGK8Wwp/xi+QNDzDNzfv4yLrfPMSK6/XI7tBCLJcbr5RVZyQjjrj6NqDQL1Ro
	8LMXuiEE9d1uY08ad6iKy659Yx779BMNsVy5tmwMaI8ElOmtf5jSmhi6vHWReztCHiHbxPKZBKO
	Xf4wrMxBKoPkfPR2HfwOpIrOGVrImZY6e2jedSgNTrNDJ1qJ7/cxBP2V75wOvTiGMjqkAWfmWsS
	OpFzPqyJ2Cxm9a2HaFllBrRa+aWKFl0ixCUg6j3Zfe/1OCcm6ZoItGg3d8l4Uz4=
X-Received: by 2002:a05:6a00:148a:b0:736:b101:aed3 with SMTP id d2e1a72fcca58-7489cdeef7emr24370156b3a.1.1750274009965;
        Wed, 18 Jun 2025 12:13:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4PpK67//HdCQjKuOtU3n0Jm9SeUXLNOJyngMOtYmGVZufN8Mwd1OqczRq/KalUicz9vgeUw==
X-Received: by 2002:a05:6a00:148a:b0:736:b101:aed3 with SMTP id d2e1a72fcca58-7489cdeef7emr24370133b3a.1.1750274009647;
        Wed, 18 Jun 2025 12:13:29 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900b0599sm11489678b3a.111.2025.06.18.12.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 12:13:29 -0700 (PDT)
Date: Thu, 19 Jun 2025 03:13:24 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com
Subject: Re: [RFC 01/12] common/preamble: Fix fsx for ext4 with bigalloc
Message-ID: <20250618191324.fpwyi6acobodmyit@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <2568ed1e9d1c47d0fdb357f0e10c5ed341a72379.1749629233.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2568ed1e9d1c47d0fdb357f0e10c5ed341a72379.1749629233.git.ojaswin@linux.ibm.com>

On Wed, Jun 11, 2025 at 03:04:44PM +0530, Ojaswin Mujoo wrote:
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> 
> Insert range and collapse range only works with bigalloc in case
> the range is cluster size aligned, which fsx doesnt take care. To
> work past this, disable insert range and collapse range on ext4, if
> bigalloc is enabled.
> 
> This is achieved by defining a new function _setup_fs_options
> which can serve as a mechanism to apply FS-wide options to
> the tests.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  common/preamble | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/common/preamble b/common/preamble
> index ba029a34..2bccff74 100644
> --- a/common/preamble
> +++ b/common/preamble
> @@ -24,6 +24,20 @@ _register_cleanup()
>  	trap "${cleanup}exit \$status" EXIT HUP INT QUIT TERM $*
>  }
>  
> +# setup FS options only to be available for each test run
> +_setup_fs_options() {

If this's a function for fsx only, better to name it with "fsx", e.g.
_setup_default_fsx_avoid (or some other names).

> +	case "$FSTYP" in
> +	"ext4")
> +		if [[ "$MKFS_OPTIONS" =~ bigalloc ]]; then
> +			export FSX_AVOID="-I -C"

Hmm... I'm also wondering if this's an issue should be fixed in fstests. How about
let the testers who tests ext4 with MKFS_OPTIONS="-O bigalloc" write local.config
as below?

[ext4-bigalloc]
...
MKFS_OPTIONS="-O bigalloc"
FSX_AVOID="-I -C"

Thanks,
Zorro


> +		fi
> +		;;
> +	# Add other filesystem types here as needed
> +	*)
> +		;;
> +	esac
> +}
> +
>  # Prepare to run a fstest by initializing the required global variables to
>  # their defaults, sourcing common functions, registering a cleanup function,
>  # and removing the $seqres.full file.
> @@ -55,4 +69,6 @@ _begin_fstest()
>  	# remove previous $seqres.full before test
>  	rm -f $seqres.full $seqres.hints
>  
> +	# setup filesystem options for a given test execution
> +	_setup_fs_options
>  }
> -- 
> 2.49.0
> 
> 

