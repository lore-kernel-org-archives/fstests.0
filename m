Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BF217B506
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2025 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749653159; cv=none; b=ODTRRmskXtiePd4DjKZI0Z36wk5Vj2G4at7AtSAvxB1fJP/HLM90+/xiDLckdVbi9pZul+hlUAlYXZe6m767WwwsMLMCbaVwCBCqh830c8hObanpPHeCsjr5fRIpNbeYHDQDRV8gUSWWaGl6KkZD8qmb3yx18jCr8/NUBZSPGDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749653159; c=relaxed/simple;
	bh=2g05PRCE6Ms+A11CaEd8U/BAGWAp9mo/5BfocHAA7kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SjwNJzF6BolpABKQjKjcWC+uFQgxRoIXwTKxjOI3vqHxzND/UkndUvQIYD+sQ3iyGapY3gDpIJvGD+pAoKVV9PIerSOqHbbSI6pCOzyjp+8sJrhd2kO/xQHGT42VeCRbp+l1TkNq5eVXj3AqLgd4KLkyMVp+zGzb7INjWmh3UtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rnpi/RpH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rnpi/RpH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB93C4CEE3;
	Wed, 11 Jun 2025 14:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749653158;
	bh=2g05PRCE6Ms+A11CaEd8U/BAGWAp9mo/5BfocHAA7kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rnpi/RpHs9VGBfYejZIr/6dTLhY/kxOA2udwxctGbLzCWP7GWb7IQxj6UBze/6L4+
	 PLFnmSzHpQjlC4f896EHcBYBiTgDjWhnjGKLzLRUu08dZJ9eyn7aSo6liL4ZNloRn0
	 ftChTWyaIMcd0oSfC/lAwCs0VC2482jMM23u6wKUSgHHr46t0amA/6LCbg2edZAQQ0
	 ltGZpBOdOtRKen30YHjQB24eWTR4oB0UVkuv3D24oqEUwGM0ArhWhirIrF//aGOnQV
	 fZM5jkKH1W3N+4k7TMbXrsCVlhQ6cxeNxBKNSZcUK9JztAXaH4aenHJ64hNaYvRlBz
	 DNIMgK8Mcgw0w==
Date: Wed, 11 Jun 2025 07:45:58 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	john.g.garry@oracle.com
Subject: Re: [RFC 07/12] generic/771: Stress fsx with atomic writes enabled
Message-ID: <20250611144558.GJ6143@frogsfrogsfrogs>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <136feebfb52701ecd7c85e4f4bd805ce97763e50.1749629233.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <136feebfb52701ecd7c85e4f4bd805ce97763e50.1749629233.git.ojaswin@linux.ibm.com>

On Wed, Jun 11, 2025 at 03:04:50PM +0530, Ojaswin Mujoo wrote:
> Stress file with atomic writes to ensure we excercise codepaths
> where we are mixing different FS operations with atomic writes
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/generic/771     | 49 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/771.out |  2 ++
>  2 files changed, 51 insertions(+)
>  create mode 100755 tests/generic/771
>  create mode 100644 tests/generic/771.out
> 
> diff --git a/tests/generic/771 b/tests/generic/771
> new file mode 100755
> index 00000000..690dfa0a
> --- /dev/null
> +++ b/tests/generic/771
> @@ -0,0 +1,49 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 771
> +#
> +# fuzz fsx with atomic writes
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +_begin_fstest rw auto quick atomicwrites
> +
> +# Import common functions.
> +. ./common/filter
> +
> +_require_test
> +_require_odirect
> +_require_scratch_write_atomic
> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount  >> $seqres.full 2>&1
> +
> +testfile=$SCRATCH_MNT/testfile
> +touch $testfile
> +
> +awu_max=$(_get_atomic_write_unit_max $testfile)
> +blksz=$(_get_block_size $SCRATCH_MNT)
> +bsize=`$here/src/min_dio_alignment $SCRATCH_MNT $SCRATCH_DEV`
> +
> +# fsx usage:
> +#
> +# -N numops: total # operations to do
> +# -l flen: the upper bound on file size
> +# -o oplen: the upper bound on operation size (64k default)
> +# -w writebdy: $psize would make writes page aligned (on i386)
> +# -Z: O_DIRECT (use -R, -W, -r and -w too)
> +# -W: mapped write operations DISabled
> +
> +_run_fsx_on_file $testfile -N 10000 -a -o $awu_max  -l 500000 -r $bsize -w $bsize -Z -W $FSX_AVOID >> $seqres.full

Don't we already get fsx stress testing RWF_ATOMIC through generic/521
and generic/522?

Also why is mmap write disabled?

--D

> +status=$?
> +
> +if [[ "$status" != "0" ]]
> +then
> +	echo "Somthing went wrong, check $seqres.full"
> +fi
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/771.out b/tests/generic/771.out
> new file mode 100644
> index 00000000..c2345c7b
> --- /dev/null
> +++ b/tests/generic/771.out
> @@ -0,0 +1,2 @@
> +QA output created by 771
> +Silence is golden
> -- 
> 2.49.0
> 
> 
