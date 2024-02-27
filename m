Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B3552F87
	for <fstests@vger.kernel.org>; Tue, 27 Feb 2024 06:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709013632; cv=none; b=JfaWJLZks8Sii4JjsrdLVuDpfcFfCMMHnN57DXrB8t7dl8WrTxNrqHNGjN+SEIu9qtp8/UB1dqd4Zonp7PJZ79uigXcrncNfnV+7I6H2oQ1kiS1M8Qx2WStMCvLeoSBiPq8KiKXVgKDnV9w4GUnrTD8PMJfpsCtAjx05uJEmUxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709013632; c=relaxed/simple;
	bh=5kKxge7WqQPz3FG4qgp/EapY9NOsOSueUeU3UeetsCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NfWCUS8w8kTFTJ7m1H2qhoqekvs/90Ekw3lwW5EmcHQrZAEHk4WlZupqMMMpei5wT+UIUpfvjg4wFgeYs324rkne1Gmi2Kp5FvmDjwc1tSpdINGZyq5yfA6fxUi55lBUWoHl4HzuYNqMpiOqOs97a4eK078T3Hgc+uNbIz0B56M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZFAgD3Cq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZFAgD3Cq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709013628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sWGQCTwr0SlLr9SzcIRIzUuc5ksWr4ISnzZMS4BZZdo=;
	b=ZFAgD3CqMDkqgM4cX7iKeiWgJEA0mUnZmawodrPZJTOe7F8yO+TXeDPBogpU2QkPs+llkg
	90rFu9HCre7J5peeXYS5fvSpZjyEr5ozqWzUAYQMWABp3csJ43Eo6O16ZT/u4fbtZA6fVJ
	caAGN36j+nRcY/v5xI2ECGMmMsiib2I=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-IMGnYzRvNYiamFMV3k2hrg-1; Tue, 27 Feb 2024 01:00:26 -0500
X-MC-Unique: IMGnYzRvNYiamFMV3k2hrg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bbaf0ee0d9so5132547b6e.1
        for <fstests@vger.kernel.org>; Mon, 26 Feb 2024 22:00:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709013625; x=1709618425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sWGQCTwr0SlLr9SzcIRIzUuc5ksWr4ISnzZMS4BZZdo=;
        b=Qbikw3q8T9sz3Jc6MojSZXgrgT5aqhgyz/UI9uFDX04M72pxBbmcPmusNi/4oYEfYE
         hd5C9U+Od3T5jMN6WqPmE7MwcAPSg13oG+bgkHWt2c59OYXQ+HQ1N72DqVHuUB0y58mp
         9U6ny5fGtQtYPDq6elq5683jo412XXQMTqHpqeI+G1dG7uZu3OgqOR8lUHseotvqoPNJ
         aF2iRNugU6vr5ZUU+/vI6Z6kQfipIUWSydUgK/Y5Qhd8LiTaAsUdd3mW8seD+5Q0ZjvA
         mGCERAnDdhkidGp6jz9mY0Ayb7qa8Ut7l6NnrSUNidWvSsjXeO2X0HpDzpmojrq79hmA
         gnrA==
X-Forwarded-Encrypted: i=1; AJvYcCXCmqROl4txrVm/2QrBCJQYGHT9i8QzFgIr9wOwl8lkIrlwZPjplFTzbg6miaCR4lbgpTx4H47xFvZVBipM9c3B1UCIDTmECg==
X-Gm-Message-State: AOJu0YzJK3CZZEIec7WFL9Tmq8of89Ssnicq3ta9xPN6NUJzqz3ZLjYT
	w6OwujGL+nTAIfcnE4ct87DVMAQbaUC9BBhLj6tZvUTI9bymP8GciR2W2rmK5UtGRO3Ubg2QUdQ
	z2XXu2UkmSoSP0L7BpY/M8ViWQFk9NUwPK5G0kppCdCZGLiQ2C8Y9AMAtzPymm28QNA==
X-Received: by 2002:a05:6808:f89:b0:3bf:e478:6f41 with SMTP id o9-20020a0568080f8900b003bfe4786f41mr1409288oiw.14.1709013625141;
        Mon, 26 Feb 2024 22:00:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEt93/xJ794qXrwWUsaCfvWEc+xYpB538F4g7MuBstr8UXMgdxETV+vIolB+NSVZCZUNed/gA==
X-Received: by 2002:a05:6808:f89:b0:3bf:e478:6f41 with SMTP id o9-20020a0568080f8900b003bfe4786f41mr1409271oiw.14.1709013624836;
        Mon, 26 Feb 2024 22:00:24 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id f6-20020a63f746000000b005dcc8a3b26esm4959652pgk.16.2024.02.26.22.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 22:00:24 -0800 (PST)
Date: Tue, 27 Feb 2024 14:00:21 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-xfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH 8/8] xfs: test for premature ENOSPC with large cow
 delalloc extents
Message-ID: <20240227060021.5hcpvn2ar5xsup6d@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <170899915207.896550.7285890351450610430.stgit@frogsfrogsfrogs>
 <170899915333.896550.18395785595853879309.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170899915333.896550.18395785595853879309.stgit@frogsfrogsfrogs>

On Mon, Feb 26, 2024 at 06:02:37PM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> On a higly fragmented filesystem a Direct IO write can fail with -ENOSPC error
> even though the filesystem has sufficient number of free blocks.
> 
> This occurs if the file offset range on which the write operation is being
> performed has a delalloc extent in the cow fork and this delalloc extent
> begins much before the Direct IO range.
> 
> In such a scenario, xfs_reflink_allocate_cow() invokes xfs_bmapi_write() to
> allocate the blocks mapped by the delalloc extent. The extent thus allocated
> may not cover the beginning of file offset range on which the Direct IO write
> was issued. Hence xfs_reflink_allocate_cow() ends up returning -ENOSPC.
> 
> This test addresses this issue.
> 
> Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> ---
>  common/rc          |   14 +++++++++
>  tests/xfs/1923     |   85 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/1923.out |    8 +++++
>  3 files changed, 107 insertions(+)
>  create mode 100755 tests/xfs/1923
>  create mode 100644 tests/xfs/1923.out
> 
> 
> diff --git a/common/rc b/common/rc
> index 30c44dddd9..d3a2a0718b 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1873,6 +1873,20 @@ _require_scratch_delalloc()
>  	_scratch_unmount
>  }
>  
> +# Require test fs supports delay allocation.
> +_require_test_delalloc()
> +{
> +	_require_command "$FILEFRAG_PROG" filefrag
> +
> +	rm -f $TEST_DIR/testy
> +	$XFS_IO_PROG -f -c 'pwrite 0 64k' $TEST_DIR/testy &> /dev/null
> +	$FILEFRAG_PROG -v $TEST_DIR/testy 2>&1 | grep -q delalloc

I'm wondering if it's a 100% reliable way to get the "delalloc" flag when
the delalloc is supported? If not, is it worth testing with several files
or a loop, then return 0 if one of them get delalloc ?

> +	res=$?
> +	rm -f $TEST_DIR/testy
> +	test $res -eq 0 || \
> +		_notrun "test requires delayed allocation buffered writes"
> +}
> +
>  # this test needs a test partition - check we're ok & mount it
>  #
>  _require_test()
> diff --git a/tests/xfs/1923 b/tests/xfs/1923
> new file mode 100755
> index 0000000000..4e494ad8c2
> --- /dev/null
> +++ b/tests/xfs/1923
> @@ -0,0 +1,85 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2022-2024 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test No. 1923
> +#
> +# This is a regression test for "xfs: Fix false ENOSPC when performing direct
> +# write on a delalloc extent in cow fork".  If there is a lot of free space but
> +# it is very fragmented, it's possible that a very large delalloc reservation
> +# could be created in the CoW fork by a buffered write.  If a directio write
> +# tries to convert the delalloc reservation to a real extent, it's possible
> +# that the allocation will succeed but fail to convert even the first block of
> +# the directio write range.  In this case, XFS will return ENOSPC even though
> +# all it needed to do was to keep converting until the allocator returns ENOSPC
> +# or the first block of the direct write got some space.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick clone
> +
> +_cleanup()
> +{
> +	cd /
> +	rm -f $file1 $file2 $fragmentedfile
> +}
> +
> +# Import common functions.
> +. ./common/reflink
> +. ./common/inject
> +
> +# real QA test starts here
> +_fixed_by_kernel_commit XXXXX \
> +	"xfs: Fix false ENOSPC when performing direct write on a delalloc extent in cow fork"

Is it this commit below, or a new fix with same subject?

commit d62113303d691bcd8d0675ae4ac63e7769afc56c
Author: Chandan Babu R <chandan.babu@oracle.com>
Date:   Thu Aug 4 08:59:27 2022 -0700

    xfs: Fix false ENOSPC when performing direct write on a delalloc extent in cow fork

If it's an old commit, please replace the "XXXXX" to "d62113303d69".

> +
> +# Modify as appropriate.
> +_supported_fs generic

"xfs"? As it's in tests/xfs/ directory.

> +_require_test_program "punch-alternating"
> +_require_test_reflink
> +_require_xfs_io_error_injection "bmap_alloc_minlen_extent"
> +_require_test_delalloc
> +
> +file1=$TEST_DIR/file1.$seq
> +file2=$TEST_DIR/file2.$seq
> +fragmentedfile=$TEST_DIR/fragmentedfile.$seq

As you use the $TEST_DIR, it might be worth making sure these files
aren't existed. Due to the files (from other cases) in $TEST_DIR might
not be cleaned, especially if they don't take much free space.

So if these 3 files won't take much space, we can keep them, don't need
a specific _cleanup(). And move the "rm -f $file1 $file2 $fragmentedfile"
at here.

> +
> +# COW operates on pages, so we must not perform operations in units smaller
> +# than a page.
> +blksz=$(_get_file_block_size $TEST_DIR)
> +pagesz=$(_get_page_size)
> +if (( $blksz < $pagesz )); then
> +	blksz=$pagesz
> +fi

Just curious, this's a xfs specific test case, can xfs support blocksize >
pagesize? If not, can we just use pagesz directly at here ?

> +
> +echo "Create source file"
> +$XFS_IO_PROG -f -c "pwrite 0 $((blksz * 256))" $file1 >> $seqres.full
> +
> +sync
> +
> +echo "Create Reflinked file"
> +_cp_reflink $file1 $file2 >> $seqres.full
> +#$XFS_IO_PROG -f -c "reflink $file1" $file2 >> $seqres.full

There's a "#", do you hope to run it or not?

> +
> +echo "Set cowextsize"
> +$XFS_IO_PROG -c "cowextsize $((blksz * 128))" -c stat $file1 >> $seqres.full
> +
> +echo "Fragment FS"
> +$XFS_IO_PROG -f -c "pwrite 0 $((blksz * 512))" $fragmentedfile >> $seqres.full
> +sync
> +$here/src/punch-alternating $fragmentedfile
> +
> +echo "Allocate block sized extent from now onwards"
> +_test_inject_error bmap_alloc_minlen_extent 1
> +
> +echo "Create big delalloc extent in CoW fork"
> +$XFS_IO_PROG -c "pwrite 0 $blksz" $file1 >> $seqres.full
> +
> +sync
> +
> +$XFS_IO_PROG -c 'bmap -elpv' -c 'bmap -celpv' $file1 >> $seqres.full
> +
> +echo "Direct I/O write at offset 3FSB"
> +$XFS_IO_PROG -d -c "pwrite $((blksz * 3)) $((blksz * 2))" $file1 >> $seqres.full
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/xfs/1923.out b/tests/xfs/1923.out
> new file mode 100644
> index 0000000000..a0553cf3ee
> --- /dev/null
> +++ b/tests/xfs/1923.out
> @@ -0,0 +1,8 @@
> +QA output created by 1923
> +Create source file
> +Create Reflinked file
> +Set cowextsize
> +Fragment FS
> +Allocate block sized extent from now onwards
> +Create big delalloc extent in CoW fork
> +Direct I/O write at offset 3FSB
> 

