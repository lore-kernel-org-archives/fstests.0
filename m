Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A416121C194
	for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 15:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755271901; cv=none; b=KcWW99pZ5V21z+l0jkYql6++j/SG0dCqxmS4zKxfgd3UvQM2DeGfckjX75Cc8hiQx3R232pEBTxROicm7R38aHaU2dE1CzxPw8s1mxRaIBFoemk5GlQVMyTX3Puqi1MLAIQ4O8B17OfSSQnGpzNRm+Wk6I/e4q3lagTY3WUoyvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755271901; c=relaxed/simple;
	bh=7Hd8hR7mfGoJXv3eHp2kvRtv+8aG8BWuYgrdC5cHPHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=en9+1dTaMS2guYN7FUuf3bVy9GEUYWMaS/4ftZUngGBhDLhpSr0NGHGE1WFqSKFlolarobRXNkG/ayTGCvhCfB4uQlPy+o4O3MOF/I2tbeDb5upfX1oFr014MZDBphAmpclb0+eqf8zHz3uhRwRCMmnqwU2hrwqQDXL4l8ZFe5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QIak8Siy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QIak8Siy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755271898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fuR/uQYDE2m+RSdGCCxyIopNOZi97r9mDnaed9upTYQ=;
	b=QIak8SiyF0cNr/ps8s42xca57BpTlRphK/J3KCtOfNVYRSa5vCHwaAZIrWIJ/f1R2C8UMw
	PGYcXDcGQY1OTEKBePXSYI0Iki0wT49BNL+XNpwpasoRRbLBj3M/YPE5DiT6UhnFDWjel9
	UmK+l0rwhw2ZIIgWeB2NTa8/Gon360o=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-2-Nw5cILn1OOafYNdaWjNwuQ-1; Fri, 15 Aug 2025 11:31:34 -0400
X-MC-Unique: Nw5cILn1OOafYNdaWjNwuQ-1
X-Mimecast-MFC-AGG-ID: Nw5cILn1OOafYNdaWjNwuQ_1755271893
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b472478725eso883083a12.1
        for <fstests@vger.kernel.org>; Fri, 15 Aug 2025 08:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755271892; x=1755876692;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fuR/uQYDE2m+RSdGCCxyIopNOZi97r9mDnaed9upTYQ=;
        b=LV3fZAyOb+gSAdlZUsxp1C8UoBnqM8n/XAPqIR3MHAXUyEj4WDyNcXeV2tMFSvgEQz
         kojftRPE5GToLlIWb21XEX4K1N+FFYjbDWHcUCiETafTnb1NhtXXh4dlZerADFYMFzal
         P2s8MrUjLognpQ0Qb47d9vN7JGkdFbBSPZ8gvwuDTFSnn+CgT8epocLAzLN6H8zWoffE
         79H0ixlUpFJRDsx1mlJouQs1uBtzXBm9QSSuG4mJuo4E8f4kZtkujUqstbvrO3AcGej9
         gW9PJxe1/+VREDkh7IDbix9XfnJzWkOegVnqo/07eLai1qCV3gcRWmzHn+Mr6yk4B9O+
         mEww==
X-Forwarded-Encrypted: i=1; AJvYcCWU1PexEuTPXFP/axaChyj/xaF/2Oenq7Cg3c6D2AklhM5EmUMCp4S1eOKpXxVyZTpdKt5pSI34@vger.kernel.org
X-Gm-Message-State: AOJu0YyJFRLsKoqgX6FiASFJyqk7jV0GWCbtjk24uFKKfQe9uXxX4v6g
	5VhbPIYSc1lgTWhcD1i+hA01azNm05WUUstyiGatfCLtdRQilH4c3bJI0DYNQ8hK+sT7H/IvZvs
	F4ps4iztCaxQFJsMJB8r4d/wpHBBGin15E2MxKJ2wPEDQJw4L9h2TUdabyukRb2o3J0o=
X-Gm-Gg: ASbGncupho/Re1UsbVenyvEC0xw/VIiaxNjTVGIUnPMfhfct37wPps/Q9xVpDtgzSlr
	aKp8vlbg2ndCs+va69dC7wWVS/1IvSWwJK0MRfQzrG1bzEERmDJ8EZmJbBYqOCFRfyJXBohY5kp
	MANkVJelxg3J+eLrFNCconf8X0hG8WXVejMaaF3G9Z5zGqRmmgd6r3/uMMtiYvgD8zv5gAvy4e0
	Vdo9MrKadFHUTNScOlTN9+GgyG1I6Sm2RC/l3S78p5CisRf10WC78lB42jW4MWXN4lXzCfbR8o/
	guDc9wjNOaCzjrz687xr/DzhQZ39k+4hgy6QQ8KUeQ04877m+Inxy6JmdsJshw5sNgoiLuOLX8x
	0Hsv9
X-Received: by 2002:a17:903:3c70:b0:234:a734:4ab1 with SMTP id d9443c01a7336-2446d6da5a8mr35820145ad.3.1755271892385;
        Fri, 15 Aug 2025 08:31:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHaXmbVZ9VgUsiC39cykU3ziTKFL0z957nyuEfKFMiyrOBOXKV5BfUKKhngCEEbSEVyG3GxQ==
X-Received: by 2002:a17:903:3c70:b0:234:a734:4ab1 with SMTP id d9443c01a7336-2446d6da5a8mr35819725ad.3.1755271891930;
        Fri, 15 Aug 2025 08:31:31 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2446d510f07sm16582675ad.96.2025.08.15.08.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 08:31:31 -0700 (PDT)
Date: Fri, 15 Aug 2025 23:31:27 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3 1/3] f2fs/018: check data eof after partial truncation
 on compressed cluster
Message-ID: <20250815153127.aqjzltcxsdktar23@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250815081405.2523015-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250815081405.2523015-1-chao@kernel.org>

On Fri, Aug 15, 2025 at 04:14:03PM +0800, Chao Yu wrote:
> This is a regression testcase, it is added to check below case
> and its variants:
> - write 16k data into compressed file (data will be compressed)
> - truncate file to 12k (truncate partial data in compressed cluster)
> - truncate file to 20k
> - verify data in range of [12k, 16k] to see whether data is all zero
> or not
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v3:
> - introduce build_fio_config() for cleanup
> - use run_check() to check return value of check_data_eof()
> - add _cleanup
> - use $XFS_IO_PROG instead of xfs_io
>  tests/f2fs/018     | 89 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/018.out |  2 ++
>  2 files changed, 91 insertions(+)
>  create mode 100755 tests/f2fs/018
>  create mode 100644 tests/f2fs/018.out
> 
> diff --git a/tests/f2fs/018 b/tests/f2fs/018
> new file mode 100755
> index 00000000..8013042d
> --- /dev/null
> +++ b/tests/f2fs/018
> @@ -0,0 +1,89 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Chao Yu.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/018
> +#
> +# This is a regression test to check whether page eof will be
> +# zero or not after we truncate partial data in compressed
> +# cluster.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw compress
> +
> +_fixed_by_kernel_commit ba8dac350faf \
> +	"f2fs: fix to zero post-eof page"
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +	"f2fs: fix to zero data after EOF for compressed file correctly"
> +
> +_require_xfs_io_command "truncate"
> +_require_scratch
> +
> +testfile=$SCRATCH_MNT/testfile
> +fio_config=$tmp.fio
> +
> +build_fio_config()
> +{
> +	local offset=$1
> +	local size=$2
> +
> +	cat >$fio_config <<EOF
> +[verify-data]
> +filename=$testfile
> +rw=read
> +verify=pattern
> +verify_pattern=0x00
> +do_verify=1
> +verify_only
> +offset=$offset
> +size=$size
> +numjobs=1
> +EOF
> +	cat $fio_config >> $seqres.full
> +}
> +
> +build_fio_config 0 4k
> +_require_fio $fio_config
> +
> +_cleanup()
> +{
> +       rm -f $testfile
> +}

This _cleanup isn't necessary, the $testfile is on SCRATCH_DEV, we don't
need to cleanup SCRATCH_DEV manually.

Others look good to me, I can help to remove above _cleanup function when
I merge this patchset, if other 2 patches are good to merge too :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> +
> +_scratch_mkfs "-O extra_attr,compression" >> $seqres.full || _fail "mkfs failed"
> +_scratch_mount "-o compress_extension=*" >> $seqres.full
> +
> +check_data_eof()
> +{
> +	local eof_start=$1
> +	local eof_size=$2
> +	local filesize=$3
> +	local offset1=$4
> +	local offset2=$5
> +	local offset3=$6
> +
> +	rm -f $testfile
> +
> +	$XFS_IO_PROG -f -c "pwrite 0 $filesize" -c "fsync" $testfile >> $seqres.full
> +	$XFS_IO_PROG -c "truncate $offset1" $testfile
> +	$XFS_IO_PROG -c "truncate $offset2" $testfile
> +
> +	if [ "$offset3" ]; then
> +		$XFS_IO_PROG -c "truncate $offset3" $testfile
> +	fi
> +
> +	build_fio_config $eof_start $eof_size
> +	$FIO_PROG $fio_config >> $seqres.full 2>&1
> +
> +	return $?
> +}
> +
> +run_check check_data_eof 12k 4k 16k 12k 20k
> +run_check check_data_eof 10k 6k 16k 10k 20k
> +run_check check_data_eof 12k 4k 16k 8k 12k 20k
> +run_check check_data_eof 10k 6k 16k 8k 10k 20k
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/018.out b/tests/f2fs/018.out
> new file mode 100644
> index 00000000..8849e303
> --- /dev/null
> +++ b/tests/f2fs/018.out
> @@ -0,0 +1,2 @@
> +QA output created by 018
> +Silence is golden
> -- 
> 2.49.0
> 

