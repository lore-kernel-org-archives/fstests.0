Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C917B272E42
	for <fstests@vger.kernel.org>; Thu, 14 Aug 2025 20:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755204825; cv=none; b=p5Ib+xohkOg/OEiFO9nKRPSr6A/ljF0W+Z7m0wW9kEfd15R9NdHjr2xPqe8uSQCbbjgXSCE5ooAc90zIFWO8E099KAAJxhnYNv0tYzo8cfi7NQevp6+9ulTEjtBnpaZZZLHJS+sXlhR/w+xmj21nNl3mcOzoeRGMEReQ460ikk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755204825; c=relaxed/simple;
	bh=LR2TiTRaDYkSKgdFxDplh+goz5oHCRNzHWqZFA1KPf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSSLT3RrNmwGY8jo2P38uV3xZZQ6fe0lI9/Ca8JslDFG6aROH81MIsKishbgs/l3Q60wzk4p3J16ah35BfaxwxhXBJXDh3U0pKdOeb2qwER7A2TGsJudamaL64XssFBZCXPpyYflSj90IXFCimPWvFELVzEMnlyYxP5/y0AeuuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ey/+cv3c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ey/+cv3c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755204822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SVBmjRRbsDiYgdks9UuUao/r/n534PcdVoBrMDuOOFM=;
	b=Ey/+cv3cpSA5MWezTHkdRj52QboiFSarUfYbwwK4IQjqWJ/Ty9FfLzJM9PDIWZW86v+utk
	uKZZeqCR2OiCw0iDYp1Ds1T5s9k+omqQkr1ZimXP8I5sN4wSRrBvl/t0f+EPSZhF0oBJp5
	TxXpFjPy6PDBCcOcaCw5cemXDANL1Ys=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-hb3GIhsFNWeH4HcMis21jg-1; Thu, 14 Aug 2025 16:53:41 -0400
X-MC-Unique: hb3GIhsFNWeH4HcMis21jg-1
X-Mimecast-MFC-AGG-ID: hb3GIhsFNWeH4HcMis21jg_1755204820
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2ebafe0aso1187808b3a.3
        for <fstests@vger.kernel.org>; Thu, 14 Aug 2025 13:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755204820; x=1755809620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SVBmjRRbsDiYgdks9UuUao/r/n534PcdVoBrMDuOOFM=;
        b=IrHOzTA32+7modABPbW+G6+EDdjSksn3NW4lDYyh6uGN+MGrDamAAsGWZSgiZMBwTD
         3N7T/9I+kwqaL+fYuYXYCSxC0/R6nJqTQnzU3C+8oVcFPE5CIKiBiSDXD1hURJOC99Dk
         wNzRVkuDKr1iTfQcSDreSPIiToyxYCpfokE29qtC7jV7g1UMpJK5mXDK0XL+hhth/JSN
         0BeAolt8kFYVvmSSD2bcRHHz/i4eq8ejEGYOZkxDeZ2c38Rh6x1ZNh9S8LmAZaNpA/c3
         qpHIMQAyAFpzSEffIUexZeMKJFwZrp3aqPKhiStcAbzQ3Q+w1rDgMto7IE09ATx5VdZy
         pAFg==
X-Forwarded-Encrypted: i=1; AJvYcCU+PRXqSEHUbSdAiouVBSuPHYczVC79uCyYJQxAiWMHPeTMoapcNhTvRoK1TqPphxCUur/ngEzk@vger.kernel.org
X-Gm-Message-State: AOJu0YzQE7z72ce5ihEAEy/ckYncAa8tmQbEs20PwfMbCpb7GH0sJFeU
	vl4N74dcnPYZBc/5TYn2iiikNMETp39Hh28xbdp+BPiTIiIO8pP/ORirv1MIhXJAnbFHcG/bqdd
	6L1F9A9NoSWdfeigNJq7fBT7iTOF6a/mToDDb0KOHNkgZA/PtKAcbDcWhAqb8wSSt/IM=
X-Gm-Gg: ASbGncvKbMiX7GXLiyDeRRJ/twVyc0vPQ8ltnvjw6ZmBB241nUPJpAtu/2edl4YGz3o
	VggAHU6ZrlTfbiftOiGkYfRRGbcTe620ujWx7O0nMyi2vjZAG2W3g1VrKJjdFQWVz9MAFkZQnMG
	tjynQPL7KGr6T28SQTt1LLaFHjUO5bRee0mw77b5EYu4IM5AtXBUW7vnWSfPXki1UjVKJ8DKsJ2
	oQSK2A7/LXVngq0yedBA/O9mYZczf8mpLQ/5Y4+R00SEFJ8fx83e/lYuYLW5A24kPY67hCHLPJb
	SjYumduQckO5APq9Ptn9BQJ+rylflSlrs9INEoIHgBpdRSuOFI516gCfLcJ6A6/eAHUoD+oBpGC
	RVwhC
X-Received: by 2002:a05:6a20:3c8f:b0:240:252a:158e with SMTP id adf61e73a8af0-240bcf5e721mr6902330637.3.1755204819979;
        Thu, 14 Aug 2025 13:53:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoGvypaL9JtBGvDGIWVjrTXCp8kSwohwcmyEzcdb8xXtBTwhMvoKZoi9NOdVkw7TC+xRs8Pg==
X-Received: by 2002:a05:6a20:3c8f:b0:240:252a:158e with SMTP id adf61e73a8af0-240bcf5e721mr6902297637.3.1755204819502;
        Thu, 14 Aug 2025 13:53:39 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e13eb0db0sm7485776b3a.3.2025.08.14.13.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 13:53:39 -0700 (PDT)
Date: Fri, 15 Aug 2025 04:53:34 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2 1/3] f2fs/018: check data eof after partial truncation
 on compressed cluster
Message-ID: <20250814205334.obe6tmyhphngntdv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250814090712.2119455-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250814090712.2119455-1-chao@kernel.org>

On Thu, Aug 14, 2025 at 05:07:10PM +0800, Chao Yu wrote:
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
> v2:
> - add missing _require_xfs_io_command "truncate"
> - add missing _require_fio $fio_config
> - use $XFS_IO_PROG instead of xfs_io
> - avoid mkfs&mount .. umount for each round test
>  tests/f2fs/018     | 77 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/018.out |  2 ++
>  2 files changed, 79 insertions(+)
>  create mode 100755 tests/f2fs/018
>  create mode 100644 tests/f2fs/018.out
> 
> diff --git a/tests/f2fs/018 b/tests/f2fs/018
> new file mode 100755
> index 00000000..e1047f78
> --- /dev/null
> +++ b/tests/f2fs/018
> @@ -0,0 +1,77 @@
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
> +cat >$fio_config <<EOF
> +[global]
> +filename=$testfile
> +rw=read
> +verify=pattern
> +verify_pattern=0x00
> +do_verify=1
> +verify_only
> +offset=0
> +size=4k
> +numjobs=1
> +EOF
> +_require_fio $fio_config

Hmm... that looks strange if you create fio config file but don't use it later :-D

How about:

build_fio_config()
{
	local offset=$1
	local size=$2

	cat >$fio_config <<EOF
[global]
filename=$testfile
rw=read
verify=pattern
verify_pattern=0x00
do_verify=1
verify_only
offset=$offset
size=$size
numjobs=1
EOF
}

build_fio_config 0 4k
_require_fio $fio_config

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
> +

rm -f $testfile

> +	$XFS_IO_PROG -f -c "pwrite 0 $filesize" -c "fsync" $testfile >> $seqres.full
> +	$XFS_IO_PROG -c "truncate $offset1" $testfile
> +	$XFS_IO_PROG -c "truncate $offset2" $testfile
> +
> +	if [ "$offset3" ]; then
> +		xfs_io -c "truncate $offset3" $testfile
                ^^^^^^
       $XFS_IO_PROG

> +	fi
> +
> +	$FIO_PROG --name=verify-data --filename=$testfile --rw=read --verify=pattern \
> +		--verify_pattern=0x00 --do_verify=1 --verify_only --offset=$eof_start \
> +		--size=$eof_size >> $seqres.full 2>&1 || _fail "eof data is not zero"

build_fio_config $eof_start $eof_size
$FIO_PROG $fio_config >> $seqres.full 2>&1

> +
> +	rm -f $testfile

Move this line to above, then

return $?

> +}
> +
> +check_data_eof 12k 4k 16k 12k 20k
> +check_data_eof 10k 6k 16k 10k 20k
> +check_data_eof 12k 4k 16k 8k 12k 20k
> +check_data_eof 10k 6k 16k 8k 10k 20k

run_check check_data_eof 12k 4k 16k 12k 20k
run_check check_data_eof 10k 6k 16k 10k 20k
run_check check_data_eof 12k 4k 16k 8k 12k 20k
run_check check_data_eof 10k 6k 16k 8k 10k 20k

This can help you to know which line fails if one of them is failed. Or you
always get "eof data is not zero", no matter which line fails :)

> +
> +_scratch_unmount

This unmount looks useless, due to SCRATCH_DEV is always unmounted after a test done.

Thanks,
Zorro

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

