Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2005F18C34C
	for <fstests@vger.kernel.org>; Mon, 17 Jun 2024 07:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718609170; cv=none; b=Ucm9e62UOjLAOh7bmxBftq/xvrLY+O8FlIN4GGId9AAyAKjG1gJkpcEEG+M5xZgqChMkNtiiv+syjlZDxO9hxFWtBGFbUymxKjUOezsGt99vCEc5lqQHsDWkJAc5Nyjy28szzo1uUqSc59an1Nq8HGqFj7M9c8BbDwbwytqkuHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718609170; c=relaxed/simple;
	bh=swgMdo9JJuiiehrBE1ReAFKdLDyAHIWHqyUMKuEdJe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZBd7mnTA5xKm4icoSp2lN62+TQfIAx9lV+rCQRnlDZC6I3hohSS05ve+yq1DuIsNYHuZEv9Fzd14d2fOgz2RAH2lI7wxPY0gcJXcmVyCbH+F7T7I+hI8sdc3w+iERUmNXUlbtkbaqzOBckzpRdUWSaIkikcp0Tf492ZSgmAUmPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VUp+zcWm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUp+zcWm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718609166;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nfLGduVhMEpMPrUwdp4yXLY4JWbd+UJGjfINWgqv0z0=;
	b=VUp+zcWm6JuhKq155U/J2j8qPFLhOlBXM/GuoXPoOi5SmmE669+tHm7PZRpdon6GQZM6Ju
	g2CWGDcRvC39x+tFUMEUupxmr6/hrBeSBf1ZCyM7/ahx5FoUk/KZBA8+nGWI86WGbMY5RN
	GPqpvO9ibHvo0hGHpw3nxAXjA5yZsLM=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-VySqg2XQOLqMWtjpCIO7pg-1; Mon, 17 Jun 2024 03:26:05 -0400
X-MC-Unique: VySqg2XQOLqMWtjpCIO7pg-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-6ea5a4fd129so4119578a12.3
        for <fstests@vger.kernel.org>; Mon, 17 Jun 2024 00:26:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718609164; x=1719213964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nfLGduVhMEpMPrUwdp4yXLY4JWbd+UJGjfINWgqv0z0=;
        b=RNPv+euo21d7gAbcPXu0HW4bzOsVNEEEaxvafBLlPPl8X5I7/heTVxOzB67KjDF0qq
         sF3ZgspcB1eAc8JhJB64Pzbq8WMPUG0HGUR8FIYHuPPHok5LupQ1um9YPtnas1CKC26u
         KnUXdUvMj+DCP26r9MHqC9GNQXLQ5utBBblZ4l5Nm/Llr2y9TJJXzvyxsEuD3OcpUcVi
         St1aWZpPHA0qvo9UavLOHFdH3Evpk9PxRleEq9WPrWMp4ojJOgoc9WtwYloHIwmzCKTo
         Bez3Q9if9YixNS6NhXgfj5aJL8D+vDVsoiGmUsmGtJOKf9zPklKd1aFYK1KoKNUcYxC7
         D5wQ==
X-Gm-Message-State: AOJu0Yxr5FfnbUPswmSs32CaE1yq4Dz0Vcnw8/cwENJrGnMDQT9C4Jyt
	K0cLEmtEFykkuLc1vH8u2uqB8cWTcJJ+P9tkaFO0yRBIOO3J/M/ymD/vV17P0z+wBLvtYL83UnI
	jJR09crCJbSACZjE0NwLmh9uOthoj8Nkn4LaS6tkYOh0wEZVpDYmMaPk=
X-Received: by 2002:a05:6a20:da92:b0:1b5:b214:efcc with SMTP id adf61e73a8af0-1bae82fd317mr10375008637.53.1718609163964;
        Mon, 17 Jun 2024 00:26:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGBeLokwQj83qkQs4+N+qe5Ofv/UM5cL1wv4G5uGFBAk0Ao8JzipNieZ8vCYLx4f4hCPpRoQ==
X-Received: by 2002:a05:6a20:da92:b0:1b5:b214:efcc with SMTP id adf61e73a8af0-1bae82fd317mr10374996637.53.1718609163444;
        Mon, 17 Jun 2024 00:26:03 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855f525desm73690525ad.293.2024.06.17.00.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 00:26:03 -0700 (PDT)
Date: Mon, 17 Jun 2024 15:26:00 +0800
From: Zorro Lang <zlang@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH -v2 1/2] ext4/045: use the large_dir feature to fix test
 failures with a 1k block size
Message-ID: <20240617072600.wvezfce2qivtrzxe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240611222659.256476-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611222659.256476-1-tytso@mit.edu>

On Tue, Jun 11, 2024 at 06:26:58PM -0400, Theodore Ts'o wrote:
> If the file system has a 1k blocksize, this test will fail without the
> large_dir file system, because the depth of the dir_index tree needs
> to be greater than 2.  So enable the large_dir unconditionally, which
> also gives us better test coverage of the large_dir code paths.
> 
> As a result of requiring large_dir, this test will get skipped if the
> kernel is older than 4.13 --- which was released in 2017; and that
> seems to be reasonable at this point.

Makes sense to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  tests/ext4/045 | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/ext4/045 b/tests/ext4/045
> index 4f0ad4aa7..a90ae1ba3 100755
> --- a/tests/ext4/045
> +++ b/tests/ext4/045
> @@ -20,6 +20,7 @@ LONG_DIR=2
>  _supported_fs ext4
>  
>  _require_scratch
> +_require_scratch_ext4_feature large_dir
>  _require_test_program "t_create_short_dirs"
>  _require_test_program "t_create_long_dirs"
>  _require_dumpe2fs
> @@ -42,7 +43,7 @@ workout()
>         echo "Num of dirs to create: $1, Dir name len: $dir_name_len, " \
>                 "Parent dir: $3" >> $seqres.full
>  
> -       _scratch_mkfs "-O extent,dir_nlink,dir_index -I 256" >> $seqres.full 2>&1
> +       _scratch_mkfs "-O extent,dir_nlink,dir_index,large_dir -I 256" >> $seqres.full 2>&1




>         _scratch_mount
>  
>         # create directories
> -- 
> 2.43.0
> 
> 

