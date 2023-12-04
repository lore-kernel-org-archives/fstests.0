Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O5TZIygR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F90B83
	for <fstests@vger.kernel.org>; Mon,  4 Dec 2023 06:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701699164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fTf5rZezHvNZYSU/Eu+ZUQTopNmjEYTCchqvqrhJ12o=;
	b=O5TZIygRi2BKG5yioHv1L3YDtEPbfUgQUVoMLk/d+8CyeSHVITgE19Ztrnndc+YcHWTdlQ
	F32WN/lfLjMqMFzNiKv6NTKIw5/Vj2HIXc7C4CwkRxNQ96c9CGxQB1SOloV/pE9SjbRn1C
	BRSHGSkMxa1wB+8LxR72Rl+mYnqY/Wk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-478-sx4CmhaaO4-eqEE29z8rRQ-1; Mon, 04 Dec 2023 09:12:43 -0500
X-MC-Unique: sx4CmhaaO4-eqEE29z8rRQ-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cf74396cbeso17094215ad.2
        for <fstests@vger.kernel.org>; Mon, 04 Dec 2023 06:12:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701699162; x=1702303962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fTf5rZezHvNZYSU/Eu+ZUQTopNmjEYTCchqvqrhJ12o=;
        b=PcRUeQMxtdntF16IeSunL+u0JEz/uYOIoOFxt8KYO/mLKVn39YwC52h3wNWqfHp6JA
         v+B9yaV280rADbjrZx9nLn5IqUV+QlhU5Q2jckqwNYZINteGinY+t+0wlHm0YBouVfNO
         Lxg9JFopPoC33tbzDH5EiGd3hs4J0+cllZySLUf4q/cDw6tPg6yk5Uz5QjHKiA5/63Iw
         QscImqh/YnSzbTOMJdV1dyouLqJ+u8sbLhrLcl5jLEd5agmJrmRVHKW7fPe+YG1pau4f
         n5EYqlW/Fb2VJ6PZPqmQ7CTry21B9DiY5N57YSIpAe0eQLrh/B7eGTQdBUv40k5rzBWL
         2ejQ==
X-Gm-Message-State: AOJu0YycwcQuHmuaiyZWt/Y3hSttjygO9j5X7qGljpzVGP0011UF2tAA
	2gmqTta+ZefqmHKv2XOtgcSsB8jFCZ88rOIBHlir3vJ2a717wWpmae6YhtsoIxyxuvbMPOz4Een
	WsDUxWuPkGkFfzpDuBw==
X-Received: by 2002:a17:902:a505:b0:1d0:8122:9009 with SMTP id s5-20020a170902a50500b001d081229009mr1093600plq.29.1701699162144;
        Mon, 04 Dec 2023 06:12:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4vGbQAakRWF+ZUDss/Oh7uy/kwXv5oGn8t7RTaLByvrftYowX3xZyeKFOADWig37kIzKniw==
X-Received: by 2002:a17:902:a505:b0:1d0:8122:9009 with SMTP id s5-20020a170902a50500b001d081229009mr1093587plq.29.1701699161766;
        Mon, 04 Dec 2023 06:12:41 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jj7-20020a170903048700b001d0be32b0basm212986plb.217.2023.12.04.06.12.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 06:12:41 -0800 (PST)
Date: Mon, 4 Dec 2023 22:12:37 +0800
From: Zorro Lang <zlang@redhat.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: fstests@vger.kernel.org, guaneryu@gmail.com, amir73il@gmail.com,
	ritesh.list@gmail.com, djwong@kernel.org, yangerkun@huawei.com
Subject: Re: [PATCH v5] ext4: Regression test of ext4_lblk_t overflow
Message-ID: <20231204141237.a3mzuua77i7k2uts@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231124115356.2438805-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231124115356.2438805-1-libaokun1@huawei.com>

On Fri, Nov 24, 2023 at 07:53:56PM +0800, Baokun Li wrote:
> Append writes to a file with logical block numbers close to 0xffffffff and
> observe if a kernel crash is caused by ext4_lblk_t overflow triggering
> BUG_ON at ext4_mb_new_inode_pa(). This is a regression test for commit
> bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
> V1->V2:
> 	Changes to make the use case more generic, not just for testing
> 	ext4.(ext4 and xfs have been tested)
> V2->V3:
> 	Clean up the code and remove hardcoding.
> V3->V4:
> 	Correct the description and modify finsert related code to
> 	make the test case easier to understand.
> V4->V5:
> 	Modify the image size to 80M.
> 	Modify the space reserved in the file to 2M.
> 	Now the test case can trigger the original problem at ext4
> 	1k,4k,64k block size.

Thanks for making this case to be generic, this version looks good to me now,
Reviewed-by: Zorro Lang <zlang@redhat.com>

> 
>  tests/generic/737     | 54 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/737.out |  2 ++
>  2 files changed, 56 insertions(+)
>  create mode 100755 tests/generic/737
>  create mode 100644 tests/generic/737.out
> 
> diff --git a/tests/generic/737 b/tests/generic/737
> new file mode 100755
> index 00000000..b4bf33e4
> --- /dev/null
> +++ b/tests/generic/737
> @@ -0,0 +1,54 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 HUAWEI.  All Rights Reserved.
> +#
> +# FS QA Test No. 737
> +#
> +# Append writes to a file with logical block numbers close to 0xffffffff
> +# and observe if a kernel crash is caused by ext4_lblk_t overflow triggering
> +# BUG_ON at ext4_mb_new_inode_pa(). This is a regression test for commit
> +# bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
> +#
> +. ./common/preamble
> +. ./common/populate
> +_begin_fstest auto quick insert prealloc
> +
> +# real QA test starts here
> +[[ "$FSTYP" =~ ext* ]] && _fixed_by_kernel_commit bc056e7163ac \
> +	"ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow"
> +
> +_require_odirect
> +_require_xfs_io_command "falloc"
> +_require_xfs_io_command "finsert"
> +
> +dev_size=$((80 * 1024 * 1024))
> +_scratch_mkfs_sized $dev_size >>$seqres.full 2>&1 || _fail "mkfs failed"
> +
> +_scratch_mount
> +file_blksz="$(_get_file_block_size ${SCRATCH_MNT})"
> +
> +# Reserve 1M space
> +$XFS_IO_PROG -f -c "falloc 0 1M" "${SCRATCH_MNT}/tmp" >> $seqres.full
> +
> +# Create a file with logical block numbers close to 0xffffffff
> +$XFS_IO_PROG -f -c "falloc 0 10M" "${SCRATCH_MNT}/file" >> $seqres.full
> +max_pos=$(( 0xffffffff * file_blksz ))
> +finsert_len=$(( max_pos - ((10 + 2) << 20) ))
> +$XFS_IO_PROG -f -c "finsert 1M ${finsert_len}" "${SCRATCH_MNT}/file" >> $seqres.full
> +
> +# Filling up the free space ensures that the pre-allocated space is the reserved space.
> +nr_free=$(stat -f -c '%f' ${SCRATCH_MNT})
> +_fill_fs $((nr_free * file_blksz)) ${SCRATCH_MNT}/fill $file_blksz 0 >> $seqres.full 2>&1
> +sync
> +
> +# Remove reserved space to gain free space for allocation
> +rm -f ${SCRATCH_MNT}/tmp
> +
> +# Trying to allocate two blocks triggers BUG_ON.
> +$XFS_IO_PROG -c "open -ad ${SCRATCH_MNT}/file" -c "pwrite -S 0xff 0 $((2 * file_blksz))" >> $seqres.full
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

