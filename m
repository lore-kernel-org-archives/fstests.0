Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB145132103
	for <fstests@vger.kernel.org>; Wed, 23 Oct 2024 03:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729652887; cv=none; b=LVlQiF06Kw/aiZ2gjFJ22h6HZKbgiBSRupwm946mKe2Em8Y9+UPc334gUj8dHbqQnIPz+FY6Lmy2F1ZCboK/LyZEwuep4/GIb3R4gI+dKflOsF2zFBKaFWtfFBVAkLq39zdChMcuFkhCWLbj69bomI8il/gDvK6esSDeJLt5tko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729652887; c=relaxed/simple;
	bh=vDKUhpSQEBvnv6xJrYNrJHG1E0MKc/x8FCiyFlM5I5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t040YF+XpCcgzb+zAY79KlQBPiUjM3KLFN12NdQb4xEUwbj8X76skcdBonYyCiyIgQgv0wtKZ9yqI+SLLhizOCO2sZCEY7g8zJDK7ajwbA9+GJRQ9VzjtoCCAY2dM3CMdUVTR9MTDff1btGve/ROCTpGIRqrxQ2+5AzTXK8xpvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bBHWq5ze; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBHWq5ze"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729652884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jdOL8buhJPizFqiZXTZfTTszBi6CktTqX5xrIm422Jk=;
	b=bBHWq5zejbHs/4cg+nFja/50hpmrTJskrx8hRxmbBHLOAJjOBhKYM+5nr58oC0WINvjdhB
	UETcDMvVeiQg3tWxQej2+t+3/GkHNpmx5ueHkGu5ZeEK+xzk53eH0+xeOxphlNnl4Jz8uI
	X2KBaxUWWgV5uQvC2ztf/0xCXDHd1/g=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-HbPMQ3-MP4GSAmeKxtQ8Bw-1; Tue, 22 Oct 2024 23:08:03 -0400
X-MC-Unique: HbPMQ3-MP4GSAmeKxtQ8Bw-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-71e6a7f3b67so7335838b3a.3
        for <fstests@vger.kernel.org>; Tue, 22 Oct 2024 20:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729652871; x=1730257671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdOL8buhJPizFqiZXTZfTTszBi6CktTqX5xrIm422Jk=;
        b=PwR8HCS74YqtqdXrxZpTQQyyAX8GH29H6U75a5LxNkVJ0+2TZgYddchfL9mePrbgWK
         zVonMQQPB0Zx08BAfagH0dopwSZj868E4BzQCYGo90+tUJ5YUJxXy09eJzGlEjd78mrq
         UBP+rOHTPzgP2dDcfWeEYNCTq6U3cczPzVWyUmMUDBVqYcNqLSXhopf+C+XAC7APZJq/
         4CClMw8nBTffBoHWFNPVd0VsAgAmhh9ucoHTgtsMO4v4ZKx1vPRA6CqxML0qivIELGRg
         Uz1NDPO+b8A4Q8zrX66saoH4XLTQysjos43gD953jw1gVJRh46YyuBqOy6B9xJ+6+R9B
         ncQg==
X-Gm-Message-State: AOJu0Yy0Qa9rrWS++eFG0tJr3/JP3AgESeMUGr+/N0Pe7eBcJMZzy+/3
	q7edo2hGWWPTNzm9OkNUxXsOd0gCmeC3NuYIrqyCIys+qjfV0ZXBzty5W5KYWt5cyY6XTaPCTtM
	f8Dggt5XZUG+82lP1A+uZJNlh61u8LvZncsETir9sGMNqZ8NM7ly2dbw=
X-Received: by 2002:a05:6a00:8d2:b0:71e:7a19:7d64 with SMTP id d2e1a72fcca58-72030a6e0f2mr1827910b3a.5.1729652871293;
        Tue, 22 Oct 2024 20:07:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGtr4wKcMT/1LrZvRiyghgTPdAnu41VjU0Ftb2YW3uKVfEElFpQ0/7Z+PtiPT+Np7wXG5UVBQ==
X-Received: by 2002:a05:6a00:8d2:b0:71e:7a19:7d64 with SMTP id d2e1a72fcca58-72030a6e0f2mr1827883b3a.5.1729652870842;
        Tue, 22 Oct 2024 20:07:50 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71ec13d765csm5407573b3a.115.2024.10.22.20.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 20:07:50 -0700 (PDT)
Date: Wed, 23 Oct 2024 11:07:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chao Yu <chao@kernel.org>
Cc: fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Jaegeuk Kim <jaegeuk@kernel.org>, Qi Han <hanqi@vivo.com>
Subject: Re: [PATCH 2/2] f2fs/007: add testcase to check consistency of
 compressed inode metadata
Message-ID: <20241023030746.5e53w26p5qtfbpod@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20241015025106.3203676-1-chao@kernel.org>
 <20241015025106.3203676-2-chao@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015025106.3203676-2-chao@kernel.org>

On Tue, Oct 15, 2024 at 10:51:06AM +0800, Chao Yu wrote:
> metadata of compressed inode should always be consistent after file
> compression, reservation, releasement and decompression, let's add
> a testcase to check it.
> 
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Cc: Qi Han <hanqi@vivo.com>
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  tests/f2fs/007     | 116 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/007.out |   4 ++
>  2 files changed, 120 insertions(+)
>  create mode 100755 tests/f2fs/007
>  create mode 100644 tests/f2fs/007.out
> 
> diff --git a/tests/f2fs/007 b/tests/f2fs/007
> new file mode 100755
> index 00000000..274be806
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

Hi Chao,

Thanks for the new f2fs test cases.

If there's a known fix for this regression, please mark it by:

_fixed_by_kernel_commit .....

> +# can become inconsistent after file compression, reservation
> +# releasement, and decompression.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
                            ^^^^
                            rw compress ?

> +
> +_cleanup()
> +{
> +	cd /
> +	rm -r -f tmp.*
> +}

This's same with default _cleanup, so it can be removed.

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
> +filename=/mnt/scratch_f2fs/testfile30
            ^^^^^^^^^^

$SCRATCH_MNT or ${testfile_prefix}30 ?

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
> +filename=/mnt/scratch_f2fs/testfile60

Same as above.

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
> +filename=/mnt/scratch_f2fs/testfile90

Same as above

> +buffer_compress_percentage=90
> +EOF
> +
> +_require_fio $fio_config
> +_require_scratch

I'd like to call _require_scratch at the beginning, especially you use
SCRATCH_* things in $fio_config. You can refer to generic/095.

> +_scratch_mkfs "-f -O extra_attr,compression" >> $seqres.full

Can you make sure this mkfs never fail? Maybe:
    || _fail "...."

> +_scratch_mount "-o compress_mode=user,compress_extension=*" >> $seqres.full
> +
> +echo -e "Run fio to initialize file w/ specified compress ratio" >> $seqres.full
> +cat $fio_config >> $seqres.full
> +$FIO_PROG $fio_config >> $seqres.full
> +_scratch_unmount
> +
> +for i in 30 60 90; do
> +	testfile=$testfile_prefix$i
> +
> +	_scratch_mount "-o compress_mode=user" >> $seqres.full
> +	f2fs_io compress $testfile >> $seqres.full
        ^^^^^^^
$F2FS_IO_PROG

> +	cblocks=`f2fs_io get_cblocks $testfile`
                 ^^^^^^^
$F2FS_IO_PROG

> +	echo "compression ratio is: "$cblocks" / 256"
> +
> +	_scratch_unmount
> +
> +	# 1. check after compression
> +	fsck -t $FSTYP -f $SCRATCH_DEV >> $seqres.full

_check_scratch_fs ?

If f2fs needs some custom operations, please change the _check_scratch_fs
or _check_generic_filesystem.

> +	if [ $? -ne 0 ]; then
> +		_fail "filesystem becomes corrupted after compress"
> +	fi
> +
> +	_scratch_mount >> $seqres.full
> +	f2fs_io release_cblocks $testfile >> $seqres.full

$F2FS_IO_PROG

> +	_scratch_unmount
> +
> +	# 2. check after releasement
> +	fsck -t $FSTYP -f $SCRATCH_DEV >> $seqres.full

_check_scratch_fs

> +	if [ $? -ne 0 ]; then
> +		_fail "filesystem becomes corrupted after release_cblocks"
> +	fi
> +
> +	_scratch_mount >> $seqres.full
> +	f2fs_io reserve_cblocks $testfile >> $seqres.full

$F2FS_IO_PROG

> +	_scratch_unmount
> +
> +	# 3. check after rservation
> +	fsck -t $FSTYP -f $SCRATCH_DEV >> $seqres.full

_check_scratch_fs

> +	if [ $? -ne 0 ]; then
> +		_fail "filesystem becomes corrupted after reserve_cblocks"
> +	fi
> +
> +	_scratch_mount "-o compress_mode=user" >> $seqres.full
> +	f2fs_io decompress $testfile >> $seqres.full

$F2FS_IO_PROG

> +	_scratch_unmount
> +
> +	# 4. check after decompression
> +	fsck -t $FSTYP -f $SCRATCH_DEV >> $seqres.full

_check_scratch_fs

Thanks,
Zorro

> +	if [ $? -ne 0 ]; then
> +		_fail "filesystem becomes corrupted after decompress"
> +	fi
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

