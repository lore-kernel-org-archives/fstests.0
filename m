Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WayF+8bi"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8773D6F
	for <fstests@vger.kernel.org>; Fri, 17 Nov 2023 06:24:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700231099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GrGmH37AukiqBUw4dCzrH6AyAH818DeWwDO5VMvtA3E=;
	b=WayF+8biuhXkFaN60NXLVYVneHs3nwAWb9bq4FObUhNVuspRELiOUmVqXO5rPO1aao44mX
	5AJBi7QnsyKhDAPGXmFxSmTDGbreuBh6u/+EvTyW5XhiRUcxhzRr5P9dzu+nacwXS//c+e
	xkc5z5pQGaH1HP4LrZ2ifKAwyvDTzcI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-Q-o_XD3cPjmG5IkyNMR7jA-1; Fri, 17 Nov 2023 09:24:57 -0500
X-MC-Unique: Q-o_XD3cPjmG5IkyNMR7jA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1cc2a0c7c6cso25887335ad.1
        for <fstests@vger.kernel.org>; Fri, 17 Nov 2023 06:24:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700231096; x=1700835896;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GrGmH37AukiqBUw4dCzrH6AyAH818DeWwDO5VMvtA3E=;
        b=aLPLHFVZ0PZHFB6mnYukDokH1D5HLyKBJN3uk28zduWh2f2MA7Yy+nKNtFIXvlcXF/
         Mp3XrsHbvX4emcNkKMj7CsSUfGjrDzPFp2bR/1fAVLnIu1Mabnx0k+XlWle9H7z1WT//
         6+Uvl9Mw6UAGp1THQjg/bktLn/DTq+fmeOknScsdYHZWSgie1463s8dXSWBOmcuKT+Sz
         /PGWuWl/Tr7A506UtLLxZeTS/UtR/kRt3f12nOfSg1sCvgfvyR8WwLKvbZXl5FW8fkX6
         g4C2DXP8FwgGaD+kWcoiafBqbRmi7RxVyHGMu++Znq/8jsri0ECWrL3mGto7jxbQ2WWO
         eNuA==
X-Gm-Message-State: AOJu0YwD7eK4PakRSQ4tKLCpw1ETV9yVVw5g+t42j4HCSrZaa2YBHWsS
	3ixP3w/SEe+PH6Sm+xbNGknZJJRekLd5RTTvuWOuA2ECJmGsF2dvOs1oUEZ5rsbE424yqNJVwVP
	wMrLnjnZAWHNW6z53WA==
X-Received: by 2002:a17:903:2301:b0:1cc:3de0:bcc4 with SMTP id d1-20020a170903230100b001cc3de0bcc4mr6188085plh.44.1700231096592;
        Fri, 17 Nov 2023 06:24:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGpUdOyDxRdB1t8GAACeXHdT8WXeEEiOJclSCb4Y0zobMhTwKL5rqi/5Xc10ZuiTSjlxlBjfA==
X-Received: by 2002:a17:903:2301:b0:1cc:3de0:bcc4 with SMTP id d1-20020a170903230100b001cc3de0bcc4mr6188059plh.44.1700231096188;
        Fri, 17 Nov 2023 06:24:56 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001c9d968563csm1446374pli.79.2023.11.17.06.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 06:24:55 -0800 (PST)
Date: Fri, 17 Nov 2023 22:24:51 +0800
From: Zorro Lang <zlang@redhat.com>
To: Baokun Li <libaokun1@huawei.com>
Cc: fstests@vger.kernel.org, guaneryu@gmail.com, amir73il@gmail.com,
	ritesh.list@gmail.com, yangerkun@huawei.com
Subject: Re: [PATCH] ext4: Regression test of ext4_lblk_t overflow
Message-ID: <20231117142451.mhjdsgbqljzkvzuv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231028070123.971548-1-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028070123.971548-1-libaokun1@huawei.com>

On Sat, Oct 28, 2023 at 03:01:23PM +0800, Baokun Li wrote:
> Append writes to a file approaching 16T and observe if a kernel crash is
> caused by ext4_lblk_t overflow triggering BUG_ON at ext4_mb_new_inode_pa().
> This is a regression test for commit bc056e7163ac ("ext4: fix BUG in
> ext4_mb_new_inode_pa() due to overflow")
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---

Hi Baokun,

Thanks for this new coverage, some review points as below ...


>  tests/ext4/062     | 53 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/062.out |  2 ++
>  2 files changed, 55 insertions(+)
>  create mode 100755 tests/ext4/062
>  create mode 100644 tests/ext4/062.out
> 
> diff --git a/tests/ext4/062 b/tests/ext4/062
> new file mode 100755
> index 00000000..0ae4ed80
> --- /dev/null
> +++ b/tests/ext4/062
> @@ -0,0 +1,53 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2023 HUAWEI.  All Rights Reserved.
> +#
> +# FS QA Test No. 062
> +#
> +# Append writes to a file approaching 16T and observe if a kernel crash is
> +# caused by ext4_lblk_t overflow triggering BUG_ON at ext4_mb_new_inode_pa().
> +# This is a regression test for commit
> +# bc056e7163ac ("ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow")
> +#
> +. ./common/preamble
> +_begin_fstest auto quick insert
                                   ^^^
                                   prealloc

> +
> +# real QA test starts here
> +_supported_fs ext4
> +_fixed_by_kernel_commit bc056e7163ac \
> +	"ext4: fix BUG in ext4_mb_new_inode_pa() due to overflow"
> +
> +_require_xfs_io_command "falloc"
> +_require_xfs_io_command "open"
> +_require_xfs_io_command "pwrite"

I think we don't need to check the "open" and "pwrite" operations,
if you don't need special option for them.

> +_require_scratch_size_nocheck $((100 * 1024))   # 100MB in KB

I think 100MB is small enough, don't need this check.

> +
> +# Initalize a 4k 100M ext4 fs
> +dev_size=$((100 * 1024 * 1024))
> +MKFS_OPTIONS="-b 4096 $MKFS_OPTIONS" _scratch_mkfs_sized $dev_size \
> +	>>$seqres.full 2>&1 || _fail "mkfs failed"

Can we use bsize=$(_get_file_block_size ....) to get the real block size,
to avoid use a specific mkfs option?
If so, my second question is if this case can be a generic case. The test
steps look common enough, I'm glad to see what will happen on other
filesystems through this test.

> +
> +_scratch_mount
> +
> +# Reserve 1M space
> +$XFS_IO_PROG -f -c "falloc 0 1M" "${SCRATCH_MNT}/tmp" >> $seqres.full 2>&1
> +
> +# Create a file with logical block numbers close to overflow
> +$XFS_IO_PROG -f -c "falloc 0 10M" "${SCRATCH_MNT}/file" >> $seqres.full 2>&1
> +$XFS_IO_PROG -f -c "finsert 1M 16777203M" "${SCRATCH_MNT}/file" >> $seqres.full 2>&1

_require_xfs_io_command "finsert"

> +
> +# Filling up the free space ensures that the pre-allocated space is the reserved space.
> +$XFS_IO_PROG -f -c "falloc 0 80388096" "${SCRATCH_MNT}/fill" >> $seqres.full 2>&1

Can we make sure this step fill the whole free space? There's a helper in
common/populate named _fill_fs, please check if it's what you want?

> +
> +# Remove reserved space to gain free space for allocation
> +rm -f ${SCRATCH_MNT}/tmp
> +
> +# Trying to allocate two blocks triggers BUG_ON.
> +$XFS_IO_PROG -c "open -ad ${SCRATCH_MNT}/file" -c "pwrite -S 0xff 0 8192" >> $seqres.full 2>&1

Oh, you need open -d option, that means you need direct IO, so you need:
_require_odirect

And all above xfs_io commands, include falloc, finsert, open and pwrite.
You can redirect the stdout to $seqres.full, but better *not* to change
the stderr, for we can find errors if they fail (except that expected ENOSPC).

> +
> +umount "${SCRATCH_MNT}"

The $SCRATCH_MNT will be unmounted at the end of the testing, don't need to do
it manually, except this's a necessary step of the reproducer.

> +echo "Silence is golden"
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/ext4/062.out b/tests/ext4/062.out
> new file mode 100644
> index 00000000..a1578f48
> --- /dev/null
> +++ b/tests/ext4/062.out
> @@ -0,0 +1,2 @@
> +QA output created by 062
> +Silence is golden
> -- 
> 2.31.1
> 
> 

