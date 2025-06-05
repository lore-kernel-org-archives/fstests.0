Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4067D28EB
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749141275; cv=none; b=aEsmeTUc3T72R6kkhUYTdP1B8/kMLT2c05m7zxTl3hNRmkxF/FngqrKVJiBgsFbtkoeByDPNsy29BSAv74ICocOEWJhKCFjukPLIkyvq6Qqdntjjy8vuH8h4/xGNh+fYsEzBifcJECPdq0uW/g3M0qhB/02Ui9fg9H50kHJvr/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749141275; c=relaxed/simple;
	bh=RxRvD7SO6O9sfTp9NDr35QM2t6M2isl7yB7T2MjUNbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLyPh0xWMzEUolmv8pgO/1s8ZQsvLgoI0gK3IU4DEAiHNEDmHWUqjlzmPZwJ2cy/+isxrElLIic63ljtPtegfqoJNEisnnEnh6VudMQ1y/pq3j/1A7Ukk4tafC9pDeSiJHzQbUWuP4xmL1Q2hNnEZiJo3W6eKIMWExneyKXKN0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-1icHrciMNr-ryVYdFaLA5A-1; Thu, 05 Jun 2025 12:34:30 -0400
X-MC-Unique: 1icHrciMNr-ryVYdFaLA5A-1
X-Mimecast-MFC-AGG-ID: 1icHrciMNr-ryVYdFaLA5A_1749141270
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b26e0fee53eso774590a12.1
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 09:34:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749141270; x=1749746070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L9EFsPlovD9AmV+m06lmGE+qCZah4l0zduNGNlSZ4S8=;
        b=uJoRcfgMDSlnMWMAntYj64TwhyKKvkyC/H8mR4KwWirrJOnXO5eKN6cTBq1VHjxUY3
         IDzAzdmavqOoAoSFX0YtoXRLjSB1LuqugA2dc4a8XvTKX1gDvn1s+gl11JSrcMMFtDAG
         CVtSKKjiLnaGPpMMeZFubdrjf3NpBlfV8JVTDlx1o77Q8TbLImITgi1PD6DQtHSYT1ur
         k4bQXCzd3goOrJtaZP/+bNxBFIkiVhVLtoi+ECErRf/ZuDY3gJRbwtOaRNbUKWCw2XmH
         KJSBI7CVJ+bWmrIwWZLebgnrwoLTPBcDYQjhvIAdOynfoZhopw5/87heeNlUBdWyqjwN
         4YcA==
X-Forwarded-Encrypted: i=1; AJvYcCWJqCU/gGoTdWiu3XR3Kkds8LuIJzqoAGQB85ZtW8G7tVKA1gRu1GCBbhR+3hQqkyaqOWUP52Ps@vger.kernel.org
X-Gm-Message-State: AOJu0YxdKUNJRzN9rb7icR6mjTEhuyyO/KHMjGLOHvuMfPcxTg914Vx2
	jvOrXNswQfIPXTjcgfM3/N2nW+V4SiXDXYcaK4u8eyMINHUuC5E4vq36aJUrTiK1L175VReStxW
	Ujle0xrRAiqbvA1p3UDQlJTftJ1YvxcYWgsOUHbeMoHevxTCmeQ+Ymv3pk+E=
X-Gm-Gg: ASbGnctMQv5qrlyVQr965OLsUIPYQW5syhsxnpYXNtLH4T9WFDFG43xviqLjgOYvSTa
	QdFfhAfLyPbAxOgHX0EGo8cAuxurP6NQB5zLBb7MN4/cjJC9qxCnQQeHImGsomq5YXwvZJEJfzM
	EMoACquXVh9rOY+iIZk8XnUI9ZvmJGEyBjE3Yb9L9MnTEdE2ogQ8oS2vYJFhDr4e9cwzTCjcuNC
	urgsy+omnirTap0APYVuh54qpw1Yc0szEiEpJRa2QdGyY7Pc9A6xhBNWQUG3Bb4gKfIS30y1+b8
	ZzWpuGVRwOr+FZnmjmW4xrq0rxrYkmSv4KdlansS6JpY9NR6hJkD
X-Received: by 2002:a05:6a20:3d84:b0:1f3:418d:91b5 with SMTP id adf61e73a8af0-21d22b4522dmr11234652637.24.1749141269861;
        Thu, 05 Jun 2025 09:34:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF2oatv8Ge1bIXlSbD3ToytK8AFuY1r6ZR44zKX2LufIG7eqcpy57Qs02NR5tsfkB7qXGKA2Q==
X-Received: by 2002:a05:6a20:3d84:b0:1f3:418d:91b5 with SMTP id adf61e73a8af0-21d22b4522dmr11234616637.24.1749141269458;
        Thu, 05 Jun 2025 09:34:29 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afff72bcsm13060485b3a.166.2025.06.05.09.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 09:34:29 -0700 (PDT)
Date: Fri, 6 Jun 2025 00:34:24 +0800
From: Zorro Lang <zlang@redhat.com>
To: Chunhai Guo <guochunhai@vivo.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, chao@kernel.org,
	jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v3] f2fs/014: test for missing 'trimmed' flag issue
Message-ID: <20250605163424.j3uh5knzsblo4cud@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250526080323.1851300-1-guochunhai@vivo.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526080323.1851300-1-guochunhai@vivo.com>

On Mon, May 26, 2025 at 02:03:23AM -0600, Chunhai Guo wrote:
> This is a regression test case to verify whether the CP_TRIMMED_FLAG is
> properly set after performing the following steps:
> 1. mount the f2fs filesystem
> 2. create a file, write data to it, then delete the file
> 3. unmount the filesystem
> 4. verify that the 'trimmed' flag is set in the checkpoint state
> 
> We should apply the commit ("f2fs: fix missing discard for active
> segments") to resolve the issue where the 'trimmed' flag is missing.
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>
> ---
> v3:
>   - change the Copyright to VIVO
>   - add this case to the "trim" test group
>   - no need to check pwrite, as it is always present

Thanks, this version is good to me,

Reviewed-by: Zorro Lang <zlang@redhat.com>

> v2:
>   - Skip this test case if discard is not supported.
>   - Renumber this test case from 012 to 014.
> v1:
>   https://lore.kernel.org/linux-f2fs-devel/20250521064952.1373690-1-guochunhai@vivo.com/
> ---
>  tests/f2fs/014     | 40 ++++++++++++++++++++++++++++++++++++++++
>  tests/f2fs/014.out |  2 ++
>  2 files changed, 42 insertions(+)
>  create mode 100755 tests/f2fs/014
>  create mode 100644 tests/f2fs/014.out
> 
> diff --git a/tests/f2fs/014 b/tests/f2fs/014
> new file mode 100755
> index 000000000000..2f2e4dc360d9
> --- /dev/null
> +++ b/tests/f2fs/014
> @@ -0,0 +1,40 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 VIVO.  All Rights Reserved.
> +#
> +# FS QA Test No. f2fs/014
> +#
> +# This is a regression test case to verify whether the CP_TRIMMED_FLAG is
> +# properly set after performing the following steps:
> +# 1. mount the f2fs filesystem
> +# 2. create a file, write data to it, then delete the file
> +# 3. unmount the filesystem
> +# 4. verify that the 'trimmed' flag is set in the checkpoint state
> +# We should apply the commit ("f2fs: fix missing discard for active
> +# segments") to resolve the issue where the 'trimmed' flag is missing.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick trim
> +
> +_fixed_by_kernel_commit 21263d035ff2 \
> +	"f2fs: fix missing discard for active segments"
> +
> +_require_scratch
> +_require_command "$DUMP_F2FS_PROG" dump.f2fs
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount >> $seqres.full
> +
> +_require_batched_discard $SCRATCH_MNT
> +
> +foo=$SCRATCH_MNT/foo
> +$XFS_IO_PROG -c "pwrite 0 1m" -c "fsync" -f $foo >> $seqres.full
> +sync
> +
> +rm $foo
> +_scratch_unmount >> $seqres.full 2>&1
> +
> +$DUMP_F2FS_PROG $SCRATCH_DEV | grep "checkpoint state" | grep -o trimmed
> +
> +status=0
> +exit
> diff --git a/tests/f2fs/014.out b/tests/f2fs/014.out
> new file mode 100644
> index 000000000000..cb0c9447d675
> --- /dev/null
> +++ b/tests/f2fs/014.out
> @@ -0,0 +1,2 @@
> +QA output created by 014
> +trimmed
> -- 
> 2.34.1
> 
> 

