Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A5518A93F
	for <fstests@vger.kernel.org>; Fri, 25 Oct 2024 03:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729828719; cv=none; b=XKfZrURrh+8RB99gghBdqdRVAVJhWi+gv84YC7pAg6dMV+mKXzolYT8+K1f7lLi+npiKwTux2gYRBDjvqFHbrnNegD6kEg0cpk/GoZOg2dRxGCUCs1hZK702bLsSSrs1T0H8tqwXVPx9kAENRfwL7qDYFuiQTXp1jtDsjorXDXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729828719; c=relaxed/simple;
	bh=z6c+LnBo6I3Re91KL4NsYvkYU73YvxcL4roxPYnpCE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpGjr9G4cil08E3h4De1zZ/pIE3p4J0uVfUSScis+3EN524gV2Mux4px5VI8RHW9l7l4+jEj9EGgO2nQqvr/12WzuM/J4huCe7BshcdYUGwt4SErs2YQwVqSbGxAitI0FdBqyZ0mbsMJPXRRFVcZ4C4OZp33RI4SH40wP+zHUlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gA/dCvwl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gA/dCvwl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729828716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YiGDlovTmHt4YBMyrJNgxhu/7l9hwDiwqAtY4NqF5F0=;
	b=gA/dCvwlbU0qLS+B6/M9qfmoWGaRDxV5InjMdS46A+xnKZVgaB5Z99gXEKRoV85LF+ckRh
	LkZCHtFnbumUSGmW9J8xA7qm34K1f3YtlyQMeX+0Qd8ymuMRU1pTYo9R40wPj5iI8IG8M4
	q/f6bP4jC+IxcOQSD6HDCOdvZuY+b9w=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-LTDcOgKcP_u6WRd5tHjJfQ-1; Thu, 24 Oct 2024 23:58:33 -0400
X-MC-Unique: LTDcOgKcP_u6WRd5tHjJfQ-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2e2eb765285so1825786a91.1
        for <fstests@vger.kernel.org>; Thu, 24 Oct 2024 20:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729828710; x=1730433510;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiGDlovTmHt4YBMyrJNgxhu/7l9hwDiwqAtY4NqF5F0=;
        b=p+JqxNeGSyFpS4Vjt5qjN9jfe5PjKbGfnSXKhY4aGDodBo18cnLtHVImDZu80P6bpk
         liBLaPWITx/LNQYQVfxqgQV6+uFTpPGEbSZ97nZsdP2qNdH36YFbn3nw05L/Dk76e5lt
         bJCwIVwJBY6ejRSE42Luf+VrPR9j8VzZDRqiGuhSvXhSKT3UBTflK/wVlwOcOvv1nJVI
         U0r52k8gcDdqrX8aPtGTE+bunxf1jSQ5h2I3daacGY5rHlMl9dYuB7Y3l2G5WaGvQCPC
         H+xS86LDLVLpfdtXQNzfaZa3ax2DAvkTIsKEvxsc3Cun2WsVPFKBSQuAiVuYN+nQ8Gly
         V4XQ==
X-Gm-Message-State: AOJu0YyaBnplTQWtbMZhOCPHLrerDAclyVErXWc5iP1Q8p32ofiMBk3i
	q0d62Bke6qd1wnWQ97eL4GiSckF+heKhABFP4SpMg4CQJK4fhT7Qgr4oKkkaWRhR/Ztxvu5SYFi
	lZtYFMAG0voVxReRrMkOlhkrP6axrqXkRWVsPEwbyEfC37OJjgLhPrrg=
X-Received: by 2002:a17:90b:3890:b0:2e0:894f:198e with SMTP id 98e67ed59e1d1-2e76b6cdb36mr9367145a91.30.1729828710014;
        Thu, 24 Oct 2024 20:58:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8V4APi8wzjunyKjyiJGvnLf3sBZMADffzV1GNJpd5R8ubktTp14cXLhRw3/ZYjR5kKhMcSw==
X-Received: by 2002:a17:90b:3890:b0:2e0:894f:198e with SMTP id 98e67ed59e1d1-2e76b6cdb36mr9367133a91.30.1729828709630;
        Thu, 24 Oct 2024 20:58:29 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e8e3771a1fsm303278a91.57.2024.10.24.20.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:58:29 -0700 (PDT)
Date: Fri, 25 Oct 2024 11:58:24 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>, Qi Han <hanqi@vivo.com>
Subject: Re: [PATCH v2 2/2] f2fs/007: add testcase to check consistency of
 compressed inode metadata
Message-ID: <20241025035824.3i62khlg3juccxeb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241023081602.3806579-1-chao@kernel.org>
 <20241023081602.3806579-2-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241023081602.3806579-2-chao@kernel.org>

On Wed, Oct 23, 2024 at 04:16:02PM +0800, Chao Yu wrote:
> metadata of compressed inode should always be consistent after file
> compression, reservation, releasement and decompression, let's add
> a testcase to check it.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Qi Han <hanqi@vivo.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
> v2:
> - add _fixed_by_kernel_commit()
> - code cleanup
> - add error handling for _scratch_mkfs()
>  tests/f2fs/007     | 116 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/007.out |   4 ++
>  2 files changed, 120 insertions(+)
>  create mode 100755 tests/f2fs/007
>  create mode 100644 tests/f2fs/007.out
> 
> diff --git a/tests/f2fs/007 b/tests/f2fs/007
> new file mode 100755
> index 00000000..8979c21c
> --- /dev/null
> +++ b/tests/f2fs/007
> @@ -0,0 +1,116 @@
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
> +_require_scratch

Better to move _require_scratch before "testfile_prefix=$SCRATCH_MNT/testfile".
Due to we'd better to make sure there's $SCRATCH_MNT, before using it.

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
> +export FSCK_OPTIONS="-f $FSCK_OPTIONS"
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
> +	_check_scratch_fs
> +	if [ $? -ne 0 ]; then
> +		_fail "filesystem becomes corrupted after compress"
> +	fi
> +
> +	_scratch_mount >> $seqres.full
> +	$F2FS_IO_PROG release_cblocks $testfile >> $seqres.full
> +	_scratch_unmount
> +
> +	# 2. check after releasement
> +	_check_scratch_fs
> +	if [ $? -ne 0 ]; then
> +		_fail "filesystem becomes corrupted after release_cblocks"

The _fail is not necessary, due to _check_scratch_fs will do "exit 1"
if it find a corruption. If you need some message, maybe echo it before
calling _check_scratch_fs?

> +	fi
> +
> +	_scratch_mount >> $seqres.full
> +	$F2FS_IO_PROG reserve_cblocks $testfile >> $seqres.full
> +	_scratch_unmount
> +
> +	# 3. check after rservation
> +	_check_scratch_fs
> +	if [ $? -ne 0 ]; then
> +		_fail "filesystem becomes corrupted after reserve_cblocks"
> +	fi

Same as above

> +
> +	_scratch_mount "-o compress_mode=user" >> $seqres.full
> +	$F2FS_IO_PROG decompress $testfile >> $seqres.full
> +	_scratch_unmount
> +
> +	# 4. check after decompression
> +	_check_scratch_fs
> +	if [ $? -ne 0 ]; then
> +		_fail "filesystem becomes corrupted after decompress"
> +	fi

Same as above.

Thanks,
Zorro

> +done
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/007.out b/tests/f2fs/007.out
> new file mode 100644
> index 00000000..2ea71c18
> --- /dev/null
> +++ b/tests/f2fs/007.out
> @@ -0,0 +1,4 @@
> +QA output created by 007
> +compression ratio is: 64 / 256
> +compression ratio is: 128 / 256
> +compression ratio is: 192 / 256
> -- 
> 2.40.1
> 

