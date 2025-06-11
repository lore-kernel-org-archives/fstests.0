Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716131C6FF6
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2025 15:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656139; cv=none; b=FW+tb6lrpauD+VpvVFWffeUlgz6xSEOABpYdz3RyqltWJWejr+q4m+TK8jXANl9sETmewD8oqqIG8Drsem+izzcMLdGsd0VBV42yZaS02OLdxilEvXbwyBtAHNfnlJhjWEUW6jK46v8GtzKSNxCBBwyioPPW+G+79zgKJwLkEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656139; c=relaxed/simple;
	bh=ya5ev4K9uEsmDRQg2pIjq7qUsou0aaMwbAYL1Yq4qtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3H474kMB6EcrZ939LAb555hUP62YMy1Ih2e8OzHVc+Vx4NZaHgB9KHHT5yss2MB+7yV10vyUILY7HgFA9ptVTPskZqjSOQ4jinbGW+dyyCJxEhO6igul6iWaELyjnyB6E8+xLg44Gu6fRYc8/u0XCjPg665CWakU2saJvZ5slA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r6sIZhYL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r6sIZhYL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7DDC4CEF1;
	Wed, 11 Jun 2025 15:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749656138;
	bh=ya5ev4K9uEsmDRQg2pIjq7qUsou0aaMwbAYL1Yq4qtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r6sIZhYLA/K9gH5YHUfi8xOFfpVekrgZgYQU1kZwVHju7BLGKOjJR6s7QAlua3lJ/
	 2HQ3telBCTDzt8rcxN/ksLdpltQcSfAWJ3npIrLRX6AKGQZIPpvYU4XBLUhvyQV7BI
	 fGvyMMb4lj64XI4CGjS5jlKdd12MSpt7K5pRjs04BO8NpYYVrYW/EpG5/A3NuayzRt
	 OtaLmZIT3eT079ZZdFr7ABPRI1Meu4KRYiY01+u2sdaf2e5KXmXzd8BkryW56OOJiF
	 L5xVv1cHgqtPU1/+cN1QVTYPMqeEGm+2zC+FQQ8rxQ63ImOWzOKAQZbUAcM8hZsQEw
	 wMe3WoPdoUv2Q==
Date: Wed, 11 Jun 2025 08:35:38 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	john.g.garry@oracle.com
Subject: Re: [RFC 05/12] generic/769: Add atomic write test using fio verify
 on file mixed mappings
Message-ID: <20250611153538.GL6143@frogsfrogsfrogs>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <15c49ab581996987e060ee44cda4c58c4ceac1f8.1749629233.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15c49ab581996987e060ee44cda4c58c4ceac1f8.1749629233.git.ojaswin@linux.ibm.com>

On Wed, Jun 11, 2025 at 03:04:48PM +0530, Ojaswin Mujoo wrote:
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> 
> This tests uses fio to first create a file with mixed mappings. Then it
> does atomic writes using aio dio with parallel jobs to the same file
> with mixed mappings. This forces the filesystem allocator to allocate
> extents over mixed mapping regions to stress FS block allocators.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/generic/769     | 101 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/769.out |   2 +
>  2 files changed, 103 insertions(+)
>  create mode 100755 tests/generic/769
>  create mode 100644 tests/generic/769.out
> 
> diff --git a/tests/generic/769 b/tests/generic/769
> new file mode 100755
> index 00000000..469d6344
> --- /dev/null
> +++ b/tests/generic/769
> @@ -0,0 +1,101 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 769
> +#
> +# Validate FS atomic write using fio crc check verifier on mixed mappings
> +# of a file.
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +
> +_begin_fstest auto aio rw atomicwrites
> +
> +_require_scratch_write_atomic_multi_fsblock
> +_require_odirect
> +_require_aio
> +
> +function max()
> +{
> +	if (( $1 > $2 )); then
> +		echo "$1"
> +	else
> +		echo "$2"
> +	fi
> +}

Yeah, there's that function again.

The rest of the test looks fine.

--D

> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +touch "$SCRATCH_MNT/f1"
> +awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
> +awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
> +aw_bsize=$(max "$awu_min_write" "$((awu_max_write/4))")
> +
> +fsbsize=$(_get_block_size $SCRATCH_MNT)
> +
> +fio_config=$tmp.fio
> +fio_out=$tmp.fio.out
> +
> +FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
> +SIZE=$((128 * 1024 * 1024))
> +
> +cat >$fio_config <<EOF
> +[global]
> +ioengine=libaio
> +fallocate=none
> +filename=$SCRATCH_MNT/test-file
> +filesize=$SIZE
> +bs=$fsbsize
> +direct=1
> +verify=0
> +group_reporting=1
> +
> +# Create written extents
> +[written_blocks]
> +stonewall
> +ioengine=libaio
> +rw=randwrite
> +io_size=$((SIZE/3))
> +random_generator=lfsr
> +
> +# Create unwritten extents
> +[unwritten_blocks]
> +stonewall
> +ioengine=falloc
> +rw=randwrite
> +io_size=$((SIZE/3))
> +random_generator=lfsr
> +
> +# atomic write to mixed mappings of written/unwritten/holes
> +[atomic_write_aio_dio_job]
> +stonewall
> +direct=1
> +ioengine=libaio
> +rw=randwrite
> +bs=$aw_bsize
> +iodepth=$FIO_LOAD
> +numjobs=$FIO_LOAD
> +size=$SIZE
> +random_generator=lfsr
> +verify_state_save=0
> +verify=crc32c
> +verify_fatal=1
> +verify_dump=0
> +verify_backlog=1024
> +verify_async=4
> +verify_write_sequence=0
> +atomic=1
> +EOF
> +
> +_require_fio $fio_config
> +
> +cat $fio_config >> $seqres.full
> +$FIO_PROG $fio_config --output=$fio_out
> +cat $fio_out >> $seqres.full
> +
> +# success, all done
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/generic/769.out b/tests/generic/769.out
> new file mode 100644
> index 00000000..1512b439
> --- /dev/null
> +++ b/tests/generic/769.out
> @@ -0,0 +1,2 @@
> +QA output created by 769
> +Silence is golden
> -- 
> 2.49.0
> 
> 
