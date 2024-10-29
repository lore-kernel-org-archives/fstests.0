Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCAE1DF243
	for <fstests@vger.kernel.org>; Tue, 29 Oct 2024 06:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730182884; cv=none; b=iXP27bzv1FUmKpvwN4m4n7s3ZGXmEM7WtXv9LApt9PSF8PnHu7fvK3mMh74P7Yp7JP2EAOyjyboSnPiJ70FW+n8yuxANn0+ZgC8pIx9qr57fZkcaVB15hWZUY46lJBVuNxoMcSiNbUJaQSMh/jSQhUEIZUon5lG6CNB4kMbColM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730182884; c=relaxed/simple;
	bh=VbvjgEJbCalCTU8pd5Vy05H252j/lrSO1xEEIjqTdqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtKjG4vak6diomuAJjKC7wflXum9pW3sQA2HiKwT/8tThuJ5hKZILvf1S4EnOJJg29zZRZ8uHKrfu07YcpiMHnCWkHEWYujkTLWzs9xeOTCVOB/lra78YcbvHS8dTi7Yq6tJfOAe/ZxWmMvYNzDmEICpSNUknFPAQEIyjjTc1ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=W9S0yjpM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W9S0yjpM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730182879;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JC+/Hyis0NruJXfhxP3v+aJI15wvdh+lyb4kuIHhQHc=;
	b=W9S0yjpMImyZtsG9zRhzAy2TiympKtaITRSl+o6ByJ/szsfQXL8oFw1+nwGLQpsAZmP/Q9
	TovPNI9O/a7H3BMXcpwT0zwV/IyKFavBig0+i5AOWWrPB0DMVWfQ3w+CX3iceAtm6iuFKj
	CR5yTTDZTanGPveTxJYI4Bc+FI6s/t8=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-nlBpxDK6M2agxQdESQjw5Q-1; Tue, 29 Oct 2024 02:21:09 -0400
X-MC-Unique: nlBpxDK6M2agxQdESQjw5Q-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-7edb8c3e743so2741934a12.1
        for <fstests@vger.kernel.org>; Mon, 28 Oct 2024 23:21:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730182869; x=1730787669;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JC+/Hyis0NruJXfhxP3v+aJI15wvdh+lyb4kuIHhQHc=;
        b=KMnRI9Qc/VHnNPPGTP5cVD15RwWNNVVhx9KtakQHlfpW0VLdrl190I6WVeYBsaqC89
         PPb6sslxFI9RxIS9LVRNat+CccpOjOcJjaSCXspKhv2ZKoX41uWqwZ0fqSlLeeDLIwiF
         oWJ7wcZsLy6VueJmCNsinDWhfDWSoLg6+HH4FhMQpe+VJiWxvLLZCtPKlcjhpeI59CIT
         8UHhNWB7Mko0y5H+dSWWb+g+ejKaWOalvND8HWvYsQfbjD+DbADLz3c0lVUiFLKSjq7t
         FRlWoHS8Ec39HUzl39TMuI05pmnNhJSERNDQroFA9GfCrQA3R9kVeIgldRvz0/ftv9cC
         WFVg==
X-Gm-Message-State: AOJu0YzG90x2w3yTcqwdl7qB7BeM7eVBCLndSDOYW64dBKdqGO1DSh7l
	964tWSNQqdWX/tR4YHZWelp3x3ycqysASaWYx5drIXB8w7R7K6zKGLse87OhB1fp44nhW83HsXc
	VCoQdhB5z+c9lrOHvZ6kZ93tCHcZphWUJgp02XAWCTwNDm41FP89Rp40=
X-Received: by 2002:a17:903:234a:b0:20c:c88b:511b with SMTP id d9443c01a7336-210c6c1e203mr127142225ad.33.1730182868732;
        Mon, 28 Oct 2024 23:21:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDjTVDysZhBC3z/0cZTbwGxQluA+Z70HP5A1biA2A8SZNiGZDDCRKglVArmxNafj7LW3ZY0Q==
X-Received: by 2002:a17:903:234a:b0:20c:c88b:511b with SMTP id d9443c01a7336-210c6c1e203mr127142085ad.33.1730182868410;
        Mon, 28 Oct 2024 23:21:08 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf6d3ffsm59787725ad.73.2024.10.28.23.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 23:21:08 -0700 (PDT)
Date: Tue, 29 Oct 2024 14:21:04 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>, Qi Han <hanqi@vivo.com>
Subject: Re: [PATCH v3 2/2] f2fs/007: add testcase to check consistency of
 compressed inode metadata
Message-ID: <20241029062104.pepwqv4w4scvgiy4@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241028141800.1788356-1-chao@kernel.org>
 <20241028141800.1788356-2-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028141800.1788356-2-chao@kernel.org>

On Mon, Oct 28, 2024 at 10:18:00PM +0800, Chao Yu wrote:
> metadata of compressed inode should always be consistent after file
> compression, reservation, releasement and decompression, let's add
> a testcase to check it.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Qi Han <hanqi@vivo.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v3:
> - move _require_scratch before use of $SCRATCH_MNT
> - output message before _check_scratch_fs
>  tests/f2fs/007     | 108 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/007.out |  16 +++++++
>  2 files changed, 124 insertions(+)
>  create mode 100755 tests/f2fs/007
>  create mode 100644 tests/f2fs/007.out
> 
> diff --git a/tests/f2fs/007 b/tests/f2fs/007
> new file mode 100755
> index 00000000..805d88fa
> --- /dev/null
> +++ b/tests/f2fs/007
> @@ -0,0 +1,108 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Oppo.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/007
> +#
> +# This is a regression test to check whether compressed metadata
> +# can become inconsistent after file compression, reservation
> +# releasement, and decompression.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick rw compress
> +
> +_fixed_by_kernel_commit xxxxxxxxxxxx \
> +        "f2fs: compress: fix inconsistent update of i_blocks in release_compress_blocks and reserve_compress_blocks"
> +
> +_require_scratch
> +testfile_prefix=$SCRATCH_MNT/testfile
> +fio_config=$tmp.fio
> +
> +cat >$fio_config <<EOF
> +[write_compressed_data_30]
> +name=mytest
> +ioengine=psync
> +rw=write
> +direct=0
> +bs=1M
> +filesize=1M
> +numjobs=1
> +filename=${testfile_prefix}30
> +buffer_compress_percentage=30
> +
> +[write_compressed_data_60]
> +name=mytest
> +ioengine=psync
> +rw=write
> +direct=0
> +bs=1M
> +filesize=1M
> +numjobs=1
> +filename=${testfile_prefix}60
> +buffer_compress_percentage=60
> +
> +[write_compressed_data_90]
> +name=mytest
> +ioengine=psync
> +rw=write
> +direct=0
> +bs=1M
> +filesize=1M
> +numjobs=1
> +filename=${testfile_prefix}90
> +buffer_compress_percentage=90
> +EOF
> +
> +_require_fio $fio_config
> +_scratch_mkfs "-f -O extra_attr,compression" >> $seqres.full || _fail "mkfs failed"
> +_scratch_mount "-o compress_mode=user,compress_extension=*" >> $seqres.full
> +
> +echo -e "Run fio to initialize file w/ specified compress ratio" >> $seqres.full
> +cat $fio_config >> $seqres.full
> +$FIO_PROG $fio_config >> $seqres.full
> +_scratch_unmount
> +
> +# force to repaire if filesystem is corrupted

              repair

> +export FSCK_OPTIONS="-f $FSCK_OPTIONS"

JFYI, if f2f2 always hope to force to repair, you can think about changing the _fsck_opts()
in common/config.

Others look good to me, I'll help to fix above typo when I merge it. Thanks for you patch.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +
> +for i in 30 60 90; do
> +	testfile=$testfile_prefix$i
> +
> +	_scratch_mount "-o compress_mode=user" >> $seqres.full
> +	$F2FS_IO_PROG compress $testfile >> $seqres.full
> +	cblocks=`$F2FS_IO_PROG get_cblocks $testfile`
> +	echo "compression ratio is: "$cblocks" / 256"
> +
> +	_scratch_unmount
> +
> +	# 1. check after compression
> +	echo "check fs after compress"
> +	_check_scratch_fs
> +
> +	_scratch_mount >> $seqres.full
> +	$F2FS_IO_PROG release_cblocks $testfile >> $seqres.full
> +	_scratch_unmount
> +
> +	# 2. check after releasement
> +	echo "check fs after release_cblocks"
> +	_check_scratch_fs
> +
> +	_scratch_mount >> $seqres.full
> +	$F2FS_IO_PROG reserve_cblocks $testfile >> $seqres.full
> +	_scratch_unmount
> +
> +	# 3. check after rservation
> +	echo "check fs after reserve_cblocks"
> +	_check_scratch_fs
> +
> +	_scratch_mount "-o compress_mode=user" >> $seqres.full
> +	$F2FS_IO_PROG decompress $testfile >> $seqres.full
> +	_scratch_unmount
> +
> +	# 4. check after decompression
> +	echo "check fs after decompress"
> +	_check_scratch_fs
> +done
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/007.out b/tests/f2fs/007.out
> new file mode 100644
> index 00000000..a4b76300
> --- /dev/null
> +++ b/tests/f2fs/007.out
> @@ -0,0 +1,16 @@
> +QA output created by 007
> +compression ratio is: 64 / 256
> +check fs after compress
> +check fs after release_cblocks
> +check fs after reserve_cblocks
> +check fs after decompress
> +compression ratio is: 128 / 256
> +check fs after compress
> +check fs after release_cblocks
> +check fs after reserve_cblocks
> +check fs after decompress
> +compression ratio is: 192 / 256
> +check fs after compress
> +check fs after release_cblocks
> +check fs after reserve_cblocks
> +check fs after decompress
> -- 
> 2.40.1
> 

