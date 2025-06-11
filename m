Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621461A8404
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2025 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656184; cv=none; b=ePTwsiy2od5pEkB7g23jNUBl3no4q7IpNyFJxJaCrkgjSkw2B8rb1opeiIEvOMg/21vW+VMq+Ql3grBcnwY25q+bhfbT+x6R3clmg5T/8VOL2Ban9PLG00kBl7hNacQNqp58OJDUHMTczlpwKUY/0Zx1CxBed4putUd2HV5VndA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656184; c=relaxed/simple;
	bh=RZQhaUrLXsvOdDqDKGVrXX4ijnmnOc+ad59Kmcvgm2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZkbwVBLqWRVP5JLb9/4q2o3+v23ORItqAkjA2zBlzZ1lnpRsB5i42O3MvmkJbSjPGWhN9rEudoN9TJvv7CqsSGOslbIhnUJ0X9yADsz7rUveBgZ6Eh7KBF/g0Ci8tOuGZtrA0JoMHX4KCuaeAeHs7gkQ5/xhDSWR9ArxWAhEAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM1mLTS2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM1mLTS2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9664C4CEE3;
	Wed, 11 Jun 2025 15:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749656183;
	bh=RZQhaUrLXsvOdDqDKGVrXX4ijnmnOc+ad59Kmcvgm2U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fM1mLTS28ZoaZrNMbeHs2RBjo+WgwY7uaug+3UpdlLfYNI6TwHnqr6IgkShQr/P27
	 9UrY8SHCl0ep0JWa1CaBwEKVg2qXBsvDhqtO+dMvpMI3cafw5t4dRbWetf8U4mhrxZ
	 P71kFvFHeANzfFXlvuRx9s5apdfoQaOIilDAukp9e2Mpy29g9luILZOq9rEXMZTCki
	 eIH6lVNdZ+jy/NUia3OuNmvRgiOwPgPgBb/umKfK1DPaJp7Q/DP8Xo/abgzk/YoilB
	 SUrZCTyWcng8cJ6A/GO57eS3RDWwGrCsJw2xkYNaWlA0KEYfS9tR0LjQK832o8/PTP
	 MgQrfdhl0YFJQ==
Date: Wed, 11 Jun 2025 08:36:23 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	john.g.garry@oracle.com
Subject: Re: [RFC 06/12] generic/770: Add atomic write multi-fsblock
 O_[D]SYNC tests
Message-ID: <20250611153623.GM6143@frogsfrogsfrogs>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <5503061a800eaff9fc182e68c3030c1ef07410f3.1749629233.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5503061a800eaff9fc182e68c3030c1ef07410f3.1749629233.git.ojaswin@linux.ibm.com>

On Wed, Jun 11, 2025 at 03:04:49PM +0530, Ojaswin Mujoo wrote:
> This adds various atomic write multi-fsblock stresst tests
> with mixed mappings and O_SYNC, to ensure the data and metadata
> is atomically persisted even if there is a shutdown.
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/generic/770     | 161 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/770.out |   2 +
>  2 files changed, 163 insertions(+)
>  create mode 100755 tests/generic/770
>  create mode 100644 tests/generic/770.out
> 
> diff --git a/tests/generic/770 b/tests/generic/770
> new file mode 100755
> index 00000000..2b98b3b3
> --- /dev/null
> +++ b/tests/generic/770
> @@ -0,0 +1,161 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 770
> +#
> +# Atomic write multi-fsblock data integrity tests with mixed mappings
> +# and O_SYNC
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +_begin_fstest auto quick rw atomicwrites
> +
> +_require_scratch_write_atomic_multi_fsblock
> +_require_atomic_write_test_commands

_require_shutdown?

--D

> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount >> $seqres.full
> +
> +check_data_integrity() {
> +	actual=$(_hexdump $testfile)
> +	if [[ "$expected" != "$actual" ]]
> +	then
> +		echo "Integrity check failed"
> +		echo "Integrity check failed" >> $seqres.full
> +		echo "# Expected file contents:" >> $seqres.full
> +		echo "$expected" >> $seqres.full
> +		echo "# Actual file contents:" >> $seqres.full
> +		echo "$actual" >> $seqres.full
> +	fi
> +}
> +
> +testfile=$SCRATCH_MNT/testfile
> +touch $testfile
> +
> +awu_max=$(_get_atomic_write_unit_max $testfile)
> +blksz=$(_get_block_size $SCRATCH_MNT)
> +
> +# Create an expected pattern to compare with
> +$XFS_IO_PROG -tc "pwrite -b $awu_max 0 $awu_max" $testfile >> $seqres.full
> +expected=$(_hexdump $testfile)
> +echo "# Expected file contents:" >> $seqres.full
> +echo "$expected" >> $seqres.full
> +
> +echo "# Test 1: Do O_DSYNC atomic write on random mixed mapping (10 iterations):" >> $seqres.full
> +# Calculate how many blocks (e.g. 4K) fit in awu_max (e.g. 64K)
> +num_blocks=$((awu_max / blksz))
> +echo "Testing $num_blocks blocks of $blksz size within $awu_max region" >> $seqres.full
> +
> +operations=("W" "H" "U")
> +
> +# Run 10 iterations of the test
> +for ((iteration=1; iteration<=10; iteration++)); do
> +	echo "=== Mixed Mapping Test Iteration $iteration ===" >> $seqres.full
> +
> +	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
> +	off=0
> +	mapping=""
> +
> +	for ((i=0; i<num_blocks; i++)); do
> +		index=$((RANDOM % ${#operations[@]}))
> +		map="${operations[$index]}"
> +		mapping="${mapping}${map}"
> +
> +		case "$map" in
> +			"W")
> +				$XFS_IO_PROG -dc "pwrite -S 0x61 -b $blksz $off $blksz" $testfile > /dev/null
> +				;;
> +			"H")
> +				# No operation needed for hole
> +				;;
> +			"U")
> +				$XFS_IO_PROG -c "falloc $off $blksz" $testfile >> /dev/null
> +				;;
> +		esac
> +		off=$((off + blksz))
> +	done
> +
> +	echo "Mixed mapping preparation complete. Full mapping pattern: $mapping" >> $seqres.full
> +
> +	sync $testfile
> +
> +	echo "Performing O_DSYNC atomic write over the entire $awu_max region" >> $seqres.full
> +	bytes_written=$($XFS_IO_PROG -dc "pwrite -DA -V1 -b $awu_max 0 $awu_max" $testfile | \
> +				  grep wrote | awk -F'[/ ]' '{print $2}')
> +
> +	test $bytes_written -eq $awu_max || echo "atomic write len=$awu_max failed"
> +	check_data_integrity
> +	echo "Iteration $iteration completed: OK" >> $seqres.full
> +	echo >> $seqres.full
> +done
> +echo "# Test 1: Do O_SYNC atomic write on random mixed mapping (10 iterations): OK" >> $seqres.full
> +
> +echo >> $seqres.full
> +echo "# Test 2: Do extending O_SYNC atomic writes: " >> $seqres.full
> +bytes_written=$($XFS_IO_PROG -dstc "pwrite -A -V1 -b $awu_max 0 $awu_max" $testfile | \
> +                grep wrote | awk -F'[/ ]' '{print $2}')
> +test $bytes_written -eq $awu_max || echo "atomic write len=$awu_max failed"
> +_scratch_shutdown -v >> $seqres.full
> +_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed for Test-2"
> +check_data_integrity
> +echo "# Test 2: Do extending O_SYNC atomic writes: OK" >> $seqres.full
> +
> +echo >> $seqres.full
> +echo "# Test 3: Do O_DSYNC atomic write on random mixed mapping with sudden fs shutdown (10 iterations):" >> $seqres.full
> +num_blocks=$((awu_max / blksz))
> +echo "Testing $num_blocks blocks of $blksz size within $awu_max region" >> $seqres.full
> +
> +operations=("W" "H" "U")
> +
> +for ((iteration=1; iteration<=10; iteration++)); do
> +	echo "=== Mixed Mapping Shutdown Test Iteration $iteration ===" >> $seqres.full
> +
> +	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
> +
> +	off=0
> +	mapping=""
> +
> +	for ((i=0; i<num_blocks; i++)); do
> +		index=$((RANDOM % ${#operations[@]}))
> +		map="${operations[$index]}"
> +		mapping="${mapping}${map}"
> +
> +		case "$map" in
> +			"W")
> +				$XFS_IO_PROG -dc "pwrite -S 0x61 -b $blksz $off $blksz" $testfile > /dev/null
> +				;;
> +			"H")
> +				# No operation needed for hole
> +				;;
> +			"U")
> +				$XFS_IO_PROG -c "falloc $off $blksz" $testfile > /dev/null
> +				;;
> +		esac
> +		off=$((off + blksz))
> +	done
> +
> +	echo "Mixed mapping preparation complete. Full mapping pattern: $mapping" >> $seqres.full
> +
> +	sync $testfile
> +
> +	echo "Performing O_DSYNC atomic write over the entire $awu_max region" >> $seqres.full
> +	bytes_written=$($XFS_IO_PROG -dc "pwrite -DA -V1 -b $awu_max 0 $awu_max" $testfile | \
> +				  grep wrote | awk -F'[/ ]' '{print $2}')
> +
> +	test $bytes_written -eq $awu_max || echo "atomic write len=$awu_max failed"
> +
> +	echo "Shutting down filesystem" >> $seqres.full
> +	_scratch_shutdown -v >> $seqres.full
> +	_scratch_cycle_mount >>$seqres.full 2>&1 || _fail "remount failed for Test-3"
> +	check_data_integrity
> +	echo "Iteration $iteration completed: OK" >> $seqres.full
> +	echo >> $seqres.full
> +done
> +echo "# Test 3: Do O_SYNC atomic write on random mixed mapping with sudden fs shutdown (10 iterations): OK" >> $seqres.full
> +
> +# success, all done
> +echo "Silence is golden"
> +status=0
> +exit
> +
> diff --git a/tests/generic/770.out b/tests/generic/770.out
> new file mode 100644
> index 00000000..17994ed5
> --- /dev/null
> +++ b/tests/generic/770.out
> @@ -0,0 +1,2 @@
> +QA output created by 770
> +Silence is golden
> -- 
> 2.49.0
> 
> 
