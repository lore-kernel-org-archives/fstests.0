Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4237A26A0A8
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2025 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749652946; cv=none; b=SkPYbljZWwqoMFKpWwUNwIzG373c8r/ZdR2a5ypljmRIMzVq2t7B74ncZyERaxvGJcb+NLdib+O9oZC10RPSZNDV/BpXOF1fV7/+MfYxtDGvSbqpogSVhnfbqULf79iytVx21exP01ZaWgInYlXnbxxHDLENnTabESx+o00/2zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749652946; c=relaxed/simple;
	bh=i0Tr5U0IAxQcA8NWf5zNWoiuAnZ4MmJDXKtQhCsWqzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLcVoy580UdTFqgIl81Bnyjo6gE/jXw1gYgluiLt/au4SEcx1JtcF20Ne8hdZdANJzl+OWYhH8nVBuay/Oh+Ic+HO6i4A+wPgzy8gjdETEQ1qKzyHENJa7z+ZrakwODISliUSHotlA1uL1SDIAO0BtinHWKeDE7sgwi7wGj+nWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R03Njb47; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R03Njb47"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFD10C4CEE3;
	Wed, 11 Jun 2025 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749652945;
	bh=i0Tr5U0IAxQcA8NWf5zNWoiuAnZ4MmJDXKtQhCsWqzk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R03Njb47vKnetLeQua3+kELkJBWajbEg34Qkjc7QEMJpFCor7oS5DdDy6j+Eme3mh
	 FPg2VqYtEnTiEuCLCkjuKGLtUHZWj6Tr+s/98UWmiX217usyT392f3YxabyGCSCxqY
	 u1fPRshXVXOx4YV90YtzXME+rgoo3lW7LGO55xr420JbNfjpUQpxzIem6cZ8PC7F9R
	 3ktQNpi5bTeFV45xYDS7JbtZSa4r1Xwpci9JCX+3WJiszs/0SIZWKCIno8u7zNfIhP
	 3sonaYKBMuUel1xE9a3GMXWzZotQuRtfNI/iCqr1JkdvA8vWT4DMr8IN4Xc/yf75qv
	 0Uuxuw2HM+nGg==
Date: Wed, 11 Jun 2025 07:42:25 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	john.g.garry@oracle.com
Subject: Re: [RFC 04/12] generic/767: Add atomic write test using fio crc
 check verifier
Message-ID: <20250611144225.GI6143@frogsfrogsfrogs>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <9cb914eacd9d7825f2903410948d2a1d4a1a8800.1749629233.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cb914eacd9d7825f2903410948d2a1d4a1a8800.1749629233.git.ojaswin@linux.ibm.com>

On Wed, Jun 11, 2025 at 03:04:47PM +0530, Ojaswin Mujoo wrote:
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> 
> This adds atomic write test using fio based on it's crc check verifier.
> fio adds a crc for each data block. If the underlying device supports atomic
> write then it is guaranteed that we will never have a mix data from two
> threads writing on the same physical block.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/generic/767     | 84 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/767.out |  2 ++
>  2 files changed, 86 insertions(+)
>  create mode 100755 tests/generic/767
>  create mode 100644 tests/generic/767.out
> 
> diff --git a/tests/generic/767 b/tests/generic/767
> new file mode 100755
> index 00000000..4f80e7b6
> --- /dev/null
> +++ b/tests/generic/767
> @@ -0,0 +1,84 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 767
> +#
> +# Validate FS atomic write using fio crc check verifier.
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +
> +_begin_fstest auto aio rw atomicwrites
> +
> +_require_scratch_write_atomic
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
> +
> +function min()
> +{
> +	if (( $1 > $2 )); then
> +		echo "$2"
> +	else
> +		echo "$1"
> +	fi
> +}

Should these be common/rc helpers?

Or, since bash is ... uh fun with arguments...

_min() {
	local ret

	for arg in "$@"; do
		if [ -z "$ret" ] || (( $arg < $ret )); then
			ret="$arg"
		fi
	done
	echo $ret
}

and then you can pass as many arguments as you like.  The only downside
is that you can pass stringly typed crap "_min cow frog" and it still
returns "cow".  As if.

> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount
> +
> +touch "$SCRATCH_MNT/f1"
> +awu_min_write=$(_get_atomic_write_unit_min "$SCRATCH_MNT/f1")
> +awu_max_write=$(_get_atomic_write_unit_max "$SCRATCH_MNT/f1")
> +blocksize=$(max "$awu_min_write" "$((awu_max_write/2))")
> +
> +# XFS can have high awu_max_write due to software fallback. Cap it at 64k
> +blocksize=$(min "$blocksize" "65536")
> +
> +fio_config=$tmp.fio
> +fio_out=$tmp.fio.out
> +
> +FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))

What program is nproc?

--D

> +SIZE=$((100 * 1024 * 1024))
> +
> +cat >$fio_config <<EOF
> +[aio-dio-aw-verify]
> +direct=1
> +ioengine=libaio
> +rw=randwrite
> +bs=$blocksize
> +fallocate=native
> +filename=$SCRATCH_MNT/test-file
> +size=$SIZE
> +iodepth=$FIO_LOAD
> +numjobs=$FIO_LOAD
> +group_reporting=1
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
> diff --git a/tests/generic/767.out b/tests/generic/767.out
> new file mode 100644
> index 00000000..2bf7f989
> --- /dev/null
> +++ b/tests/generic/767.out
> @@ -0,0 +1,2 @@
> +QA output created by 767
> +Silence is golden
> -- 
> 2.49.0
> 
> 
