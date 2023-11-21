Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Puq3I2dS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0CCC1
	for <fstests@vger.kernel.org>; Tue, 21 Nov 2023 01:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700558942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/lEIaTMs56S6HSueWro3AGh0MiocGrRWSsNydfj1xp4=;
	b=Puq3I2dSp5pGGcTJvi4cuh/nFcKzYwytxpMUGmAgso/xVh0FPZTFtZEwkzQwMaGn16lUr3
	UoIoU0DaSpzaVALnWcv7Gc17fvN11iTRYJQEfCMvTbWUlHPYt+HVWOXqWcpWG7Yc2ng6zW
	pPPWOpfH1yblGHaSpfZ+Q5IR4JSoaoE=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-vWDoP6qzOkyQ6emiubfggA-1; Tue, 21 Nov 2023 04:28:58 -0500
X-MC-Unique: vWDoP6qzOkyQ6emiubfggA-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1f08758b52cso5871244fac.3
        for <fstests@vger.kernel.org>; Tue, 21 Nov 2023 01:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700558938; x=1701163738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/lEIaTMs56S6HSueWro3AGh0MiocGrRWSsNydfj1xp4=;
        b=UsJIrFO1+dSnLu7lGmzM9xWPNzZrtS7LgJwu09RdrVmVK8HsiuizAUAj1Rg/IzXegn
         kjUNxlsVcsTreFYEHakGcqtzreX+vRYqjNR1IUNn4CbjIYhoW9cGRt9A4K9rICPQJnh2
         1V6zcwBYWGhA7thvMKIXjKEYPMXDD5dMeo2xIevxBH7V6BH/lIc2nvfVvxjSLHMKgcXG
         H/aelPS51H17daH0yZjQMfhsM5m5rAgxhpLpTUpiQLewqhVEsayltVcfNA759VszNERQ
         NucTYQYhcOqfzLXaB3SDzGsBsHNKidzzRQw0SvivriyLzd2n4NRctPWzTLDNVK5nBvzn
         ht3Q==
X-Gm-Message-State: AOJu0YxRUSWMAE8KoCETyupFQycM9WvwBunCHvKlvzogKEGrmgQDRiMP
	EknnY8SwW6hCi0K+t42N5fl4TIKtBj5fkRvNYZpN0AI0ntkmXSZljKkyKjGCfxV4YECZc4DD83o
	xJ96DUi3zkhmc8YgaXQ==
X-Received: by 2002:a05:6870:e38a:b0:1ef:fa20:3812 with SMTP id x10-20020a056870e38a00b001effa203812mr13936688oad.13.1700558937794;
        Tue, 21 Nov 2023 01:28:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeBMR3B08GOA1ZRpmKIE/XtMmm6l1EMjTtY5tDMnMuqsOAsOp+evfgpV8tg0d/xBZhVFgaHQ==
X-Received: by 2002:a05:6870:e38a:b0:1ef:fa20:3812 with SMTP id x10-20020a056870e38a00b001effa203812mr13936675oad.13.1700558937530;
        Tue, 21 Nov 2023 01:28:57 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 2-20020aa79102000000b006be22fde07dsm7527299pfh.106.2023.11.21.01.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 01:28:57 -0800 (PST)
Date: Tue, 21 Nov 2023 17:28:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: fstests@vger.kernel.org, guaneryu@gmail.com, amir73il@gmail.com,
	ritesh.list@gmail.com, yangerkun@huawei.com
Subject: Re: [PATCH v2] ext4: Regression test of ext4_lblk_t overflow
Message-ID: <20231121092853.2fpd4sar77intbho@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231120070327.1922631-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120070327.1922631-1-libaokun1@huawei.com>

On Mon, Nov 20, 2023 at 03:03:27PM +0800, Baokun Li wrote:
> Append writes to a file approaching 16T and observe if a kernel crash is
> caused by ext4_lblk_t overflow triggering BUG_ON at ext4_mb_new_inode_pa().
> This is a regression test for commit bc056e7163ac ("ext4: fix BUG in
> ext4_mb_new_inode_pa() due to overflow")
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> V1->V2:
> 	Changes to make the use case more generic, not just for testing
> 	ext4.(ext4 and xfs have been tested)

Thanks for this change,

> 
>  tests/generic/737     | 55 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/737.out |  2 ++
>  2 files changed, 57 insertions(+)
>  create mode 100755 tests/generic/737
>  create mode 100644 tests/generic/737.out
> 
> diff --git a/tests/generic/737 b/tests/generic/737
> new file mode 100755
> index 00000000..a65c448b
> --- /dev/null
> +++ b/tests/generic/737
> @@ -0,0 +1,55 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 HUAWEI.  All Rights Reserved.
> +#
> +# FS QA Test No. 737
> +#
> +# Append writes to a file approaching 16T and observe if a kernel crash is
> +# caused by ext4_lblk_t overflow triggering BUG_ON at ext4_mb_new_inode_pa().
> +# This is a regression test for commit
> +# bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
> +#
> +#set -x

Useless comment "set -x"

> +. ./common/preamble
> +. ./common/populate
> +_begin_fstest auto quick insert prealloc
> +
> +# real QA test starts here
> +_fixed_by_kernel_commit bc056e7163ac \
> +	"ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow"

[[ "$FSTYP" =~ ext* ]] && ....

> +
> +_require_xfs_io_command "falloc"
> +_require_xfs_io_command "finsert"
> +
> +# Initalize a 4k 100M fs

It might not be 4k block size, so this comment is useless. Or you can say
better to use "4k" block size to tigger the bug:)

> +dev_size=$((100 * 1024 * 1024))
> +_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1 || _fail "mkfs failed"
> +
> +_scratch_mount
> +blksz="$(_get_block_size ${SCRATCH_MNT})"
> +_require_odirect $blksz

I think the _require_odirect can be move up, before the mkfs calling.

> +
> +# Reserve 1M space
> +$XFS_IO_PROG -f -c "falloc 0 1M" "${SCRATCH_MNT}/tmp" >> $seqres.full
> +
> +# Create a file (~16T) with logical block numbers close to overflow
> +$XFS_IO_PROG -f -c "falloc 0 10M" "${SCRATCH_MNT}/file" >> $seqres.full
> +insert_size=$((blksz * 4096 - 10 - 3))
> +$XFS_IO_PROG -f -c "finsert 1M ${insert_size}M" "${SCRATCH_MNT}/file" >> $seqres.full
> +
> +# Filling up the free space ensures that the pre-allocated space is the reserved space.
> +nr_free=$(stat -f -c '%f' ${SCRATCH_MNT})
> +_fill_fs $((nr_free * blksz)) ${SCRATCH_MNT}/fill $blksz 0 >> $seqres.full 2>&1
> +sync
> +
> +# Remove reserved space to gain free space for allocation
> +rm -f ${SCRATCH_MNT}/tmp
> +
> +# Trying to allocate two blocks triggers BUG_ON.
> +$XFS_IO_PROG -c "open -ad ${SCRATCH_MNT}/file" -c "pwrite -S 0xff 0 8192" >> $seqres.full

Shouldn't the 8192 be "$((2 * blksz))", if the comment says "two blocks" ?

I tried 1024 blocksize, really can't reproduce this bug, do you know why? Maybe
related with the falloc/finsert size?
Anyway, it covers this bug on default block size of ext4, and can be a generic
test on other conditions.

Thanks,
Zorro

> +
> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/737.out b/tests/generic/737.out
> new file mode 100644
> index 00000000..67b83d78
> --- /dev/null
> +++ b/tests/generic/737.out
> @@ -0,0 +1,2 @@
> +QA output created by 737
> +Silence is golden
> -- 
> 2.31.1
> 

