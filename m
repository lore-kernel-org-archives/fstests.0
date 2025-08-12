Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5AC52C21FB
	for <fstests@vger.kernel.org>; Tue, 12 Aug 2025 08:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754989026; cv=none; b=SaJHdwaduMNZd1aDHStj1CXV9dPIwRhtKFXNxaKqpXIGdKC3R11ruaIVBw1CWLNF5BUQ5oqkeHF28BicCsNrPfHW+dALvKvXmleyJ6d5yK1WYQkF2grLop7mYP+neKuZpSukDuYbI6AS5AIgcYDVoODNQiN16IkRDP6HerXgRl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754989026; c=relaxed/simple;
	bh=k7q1jN4RbHkmIHMB9sfO7qk1hr18nvQA7F0TEnEi+pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6mOIsy5bs5GDsfPcRsv04GrvBLZe4C7K9FMnH3OsCOLs4WrFSkPdorJZcQpDk3Ea/3oVaGwMuR132G0Ft9q9/gYIbgXT6t1aFlDiGGCO89XeXySqFsmFADbKra1h3STonPaCEtay8qNWvFbfQMBwqPN0Wy/SDE8Tg0yMSSYWuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RdWp0Byo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RdWp0Byo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754989023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7oo1F55S48yAs2edvlqUHYOCLtEajNqjKqf6sVKiM+M=;
	b=RdWp0ByoFfBYXv4PlfopgNmPFmlhPRT59mxC6nYBnu7IWzD6zFj6uhANzBx1Edp0A+JRJT
	q8g0mONh64UbZ6IOaJv/F9GjTQqXMk1YYJ/tkKU0Tu/Xp5ISpbgj/5y6e/V81+sxKnTyyk
	BpaMTc+/qG0uDO4zZh6+yevcepGI1L8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-208-gs5cAgyMN2aTX-_Kx1kipw-1; Tue, 12 Aug 2025 04:57:02 -0400
X-MC-Unique: gs5cAgyMN2aTX-_Kx1kipw-1
X-Mimecast-MFC-AGG-ID: gs5cAgyMN2aTX-_Kx1kipw_1754989021
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76bf7375f8dso4790022b3a.3
        for <fstests@vger.kernel.org>; Tue, 12 Aug 2025 01:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754989021; x=1755593821;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7oo1F55S48yAs2edvlqUHYOCLtEajNqjKqf6sVKiM+M=;
        b=qTXT6yo1Ki1FhxvirYfFEYZgGHAu9jysbOHAT+p4p2US3LckLJ2gMYjMeqChYN1uIc
         4l6LqZdwUV4trFrpuMjbC5cUvFbJZc6YoPYpHVlTxtDQ9mFyVyJw+TUgsiiM6xwcOiih
         LAM2Wj6Qd7Yil2Au+VfAmWe132FWjTN1UWj4FZM4i7F5eeSUvxoIXXMRUR/EkPEQbU2V
         a0G3p86woA7CvQldauinzm1cFzLAjLiTbMTeetpyvkf6KoJKYnCznPOIWk79Tn4gNpeN
         GnllucYNW4dp//62K58F/Fh4ShqwNIUGHqyVcy0IxkkOD+LP6F1q+KQlkSyzHrbfZ31r
         nBhw==
X-Forwarded-Encrypted: i=1; AJvYcCWI0j9TG+1ReDxSKxAWbbLJXsGm6svoExWcCxrOf3G6rS3rDJnYDgkBTdoA5OoFKdlT1i7n0rHE@vger.kernel.org
X-Gm-Message-State: AOJu0YyC8z11bvH/hbzeF63uLSNYN4ZqTIpAsxVUWpk8YV8od4MYv3V8
	hMrKfXK783LFj2s/8LXhVGSi/D+rQv2DgJITJqn/ceU3d71DnDlK+4NcAQpdZxXOw2ro1rGeb7g
	fmXYa3DOWPhbB4f6cMKuHLcnNrfIq/8TEAKsjIvXySFmSpbEqEUdp15cIrNw=
X-Gm-Gg: ASbGncthXw3NSeffxDeFcnNmyQtjpsw2ZUEoYV5SrqkMq+p7JAEofmDWZLeygLmKPin
	KcA96Vf33W8Eh2ZHTH9jfdpiBthFnojjyUNeEO27KR9z6LUb7x1k6OhZZCYKku3LXbfVgrpQa/i
	+CCLyA+lsf+O75cyVxiyYIG/lDuPIZlhNehB5fE1kr7BQyHKyZt0QZoLdsZv08BOSYCghF46o5B
	S6toGYJAS7OwFywD2/iDZobWg0QgDc/szlsc9RcFf4t2AHwbXJpHoBYTYpUwAyCSzKtuSEO9cn+
	Yfo2GkSfKQNmLmCD6FKnh70Tkfk9De4vq3i/0Lo82uxoF9ewqFMsv7oZ56IOyc8vFe78MJVISAX
	a5a/n
X-Received: by 2002:a05:6a00:b86:b0:76b:c5bd:aec7 with SMTP id d2e1a72fcca58-76e0de417fcmr4045872b3a.8.1754989021054;
        Tue, 12 Aug 2025 01:57:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3/vvmzMpuLvzP7q8WpnOk7CDyAVs70g+WXZMfMWZJkU0r/I3TXYt7Gp4daqZtntSuTNjAog==
X-Received: by 2002:a05:6a00:b86:b0:76b:c5bd:aec7 with SMTP id d2e1a72fcca58-76e0de417fcmr4045844b3a.8.1754989020644;
        Tue, 12 Aug 2025 01:57:00 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bcdd40f63sm28930159b3a.87.2025.08.12.01.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 01:57:00 -0700 (PDT)
Date: Tue, 12 Aug 2025 16:56:56 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/3] f2fs/018: check data eof after partial truncation on
 compressed cluster
Message-ID: <20250812085656.kg3dsukgbde6skrd@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250811094415.1053545-1-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811094415.1053545-1-chao@kernel.org>

On Mon, Aug 11, 2025 at 05:44:13PM +0800, Chao Yu wrote:
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
>  tests/f2fs/018     | 58 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/018.out |  2 ++
>  2 files changed, 60 insertions(+)
>  create mode 100755 tests/f2fs/018
>  create mode 100644 tests/f2fs/018.out
> 
> diff --git a/tests/f2fs/018 b/tests/f2fs/018
> new file mode 100755
> index 00000000..ca727d24
> --- /dev/null
> +++ b/tests/f2fs/018
> @@ -0,0 +1,58 @@
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
> +_require_scratch
> +_require_fio
> +
> +testfile=$SCRATCH_MNT/testfile
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
> +	_scratch_mkfs "-O extra_attr,compression" >> $seqres.full || _fail "mkfs failed"
> +	_scratch_mount "-o compress_extension=*" >> $seqres.full
> +
> +	xfs_io -f -c "pwrite 0 $filesize" -c "fsync" $testfile >> $seqres.full
> +	xfs_io -c "truncate $offset1" $testfile
> +	xfs_io -c "truncate $offset2" $testfile

replace "xfs_io" with "$XFS_IO_PROG"

> +
> +	if [ "$offset3" ]; then
> +		xfs_io -c "truncate $offset3" $testfile

Same as above.

And generally we need: _require_xfs_io_command "truncate"

> +	fi
> +
> +	$FIO_PROG --name=verify-data --filename=$testfile --rw=read --verify=pattern \
> +		--verify_pattern=0x00 --do_verify=1 --verify_only --offset=$eof_start \
> +		--size=$eof_size >> $seqres.full 2>&1 || _fail "eof data is not zero"

Generally we do `_require_fio $fio_config` to make sure all arguments are supported
by current fio version and FSTYP, refer to generic/366. But as this is a f2fs only
test, and if you make sure you don't use any new/special fio arguments, I can accept
this. Or you can refer to generic/366.

> +	_scratch_unmount

I'm not familar with f2fs much, may I ask why we need to mkfs&mount ... umount
in each test loop?

Thanks,
Zorro

> +}
> +
> +check_data_eof 12k 4k 16k 12k 20k
> +check_data_eof 10k 6k 16k 10k 20k
> +check_data_eof 12k 4k 16k 8k 12k 20k
> +check_data_eof 10k 6k 16k 8k 10k 20k
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

