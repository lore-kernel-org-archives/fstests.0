Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228E022338
	for <fstests@vger.kernel.org>; Wed, 11 Jun 2025 15:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749656303; cv=none; b=USbyh9xm1QEgyAXyehM0ZPwB8TTQnnSYOZ80fxbubOgZXdFrKaKMfQ5UfHE7Q3WQLUzCMktHR++MyOyqPhN1spEB5xB65vYXod9Q2BsIR6fH9JWWZWkbYPX0NPaXt4QNs7ICpifVl7Xk41ofoV6FZsAOGgfXoKVbbbQfcR2fZ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749656303; c=relaxed/simple;
	bh=mi/qtKpNBdqQVhbLaLeW3jEpAJN7pXtZksu99ZR/Fzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LthxTlmY/CQYk5YI9kITmRN6QKonRC0LiJ9LSTxz1aUnuPuD5HnCfCUJmQjTNmHstIFhpWr8x8iQcMBdmca9IkZrE84U3o9u4p2ClklXlHsFfpnRj5YLSyoT8VK44YAihw7Ks/dulh2Gn/+E+yuiLefN4RL9dS98kYf1wHjbtSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rqh6xgYU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rqh6xgYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E467EC4CEE3;
	Wed, 11 Jun 2025 15:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749656303;
	bh=mi/qtKpNBdqQVhbLaLeW3jEpAJN7pXtZksu99ZR/Fzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rqh6xgYUW2RRPJT6kg+JmloZhJTttFjYe7AZAVnqN3zySBKUT9xSP716oMW1bVrO+
	 LCmQKcVwEEQgGYD7zzX9UJaXjIhzyPri3o/9VsxmHatKF+ERk7nErIujV+dZPPdldz
	 iEHFaiMIKPhtww/BuhHxVzGwNP/IHN1ecfxNSVSiGyTEHZDh7fwwSqu4zmAX5HVtwy
	 /wnAvbS9tHBBwGP9AHOrDa3gqhe6UAoZd707ZCVgpflbL8lT8Q9MzKj3F8sw+gG3Zj
	 ssMLnMX6QKDEo/ClrqJlgWDP+nnG2rIApXau/U+kr9oc05aY4CVk1mQ/gcAcQDf6ZW
	 l9xc4pxtezr8g==
Date: Wed, 11 Jun 2025 08:38:22 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	john.g.garry@oracle.com
Subject: Re: [RFC 08/12] generic/772: Add sudden shutdown tests for multi
 block atomic writes
Message-ID: <20250611153822.GN6143@frogsfrogsfrogs>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <fe30e64171982a664579d11c1277b2a033b952ab.1749629233.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe30e64171982a664579d11c1277b2a033b952ab.1749629233.git.ojaswin@linux.ibm.com>

On Wed, Jun 11, 2025 at 03:04:51PM +0530, Ojaswin Mujoo wrote:
> This test is intended to ensure that multi blocks atomic writes
> maintain atomic guarantees across sudden FS shutdowns.
> 
> Suggested-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/generic/772     | 360 ++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/772.out |   2 +
>  2 files changed, 362 insertions(+)
>  create mode 100755 tests/generic/772
>  create mode 100644 tests/generic/772.out
> 
> diff --git a/tests/generic/772 b/tests/generic/772
> new file mode 100755
> index 00000000..6af7e74c
> --- /dev/null
> +++ b/tests/generic/772
> @@ -0,0 +1,360 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 0772
> +#
> +# Test multi block atomic writes with sudden FS shutdowns to ensure
> +# the FS is not tearing the write operation
> +. ./common/preamble
> +. ./common/atomicwrites
> +_begin_fstest auto atomicwrites
> +
> +_require_scratch_write_atomic_multi_fsblock
> +_require_atomic_write_test_commands

_require_shutdown?

Otherwise seems fine to me...

--D

> +
> +_scratch_mkfs >> $seqres.full 2>&1
> +_scratch_mount >> $seqres.full
> +
> +testfile=$SCRATCH_MNT/testfile
> +touch $testfile
> +
> +awu_max=$(_get_atomic_write_unit_max $testfile)
> +blksz=$(_get_block_size $SCRATCH_MNT)
> +echo "Awu max: $awu_max" >> $seqres.full
> +
> +num_blocks=$((awu_max / blksz))
> +filesize=$(($blksz * 12 * 1024 ))
> +
> +atomic_write_loop() {
> +	local off=0
> +	local size=$awu_max
> +	for ((i=0; i<$((filesize / $size )); i++)); do
> +		# Due to sudden shutdown this can produce errors so just redirect them
> +		# to seqres.full
> +		$XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $size $off $size" >> /dev/null 2>>$seqres.full
> +		echo "Written to offset: $off" >> $tmp.aw
> +		off=$((off + $size))
> +	done
> +}
> +
> +create_mixed_mappings() {
> +	local file=$1
> +	local size_bytes=$2
> +
> +	echo "# Filling file $file with alternate mappings till size $size_bytes" >> $seqres.full
> +	#Fill the file with alternate written and unwritten blocks
> +	local off=0
> +	local operations=("W" "U")
> +
> +	for ((i=0; i<$((size_bytes / blksz )); i++)); do
> +		index=$(($i % ${#operations[@]}))
> +		map="${operations[$index]}"
> +
> +		case "$map" in
> +		    "W")
> +			$XFS_IO_PROG -fc "pwrite -b $blksz $off $blksz" $file  >> /dev/null
> +			;;
> +		    "U")
> +			$XFS_IO_PROG -fc "falloc $off $blksz" $file >> /dev/null
> +			;;
> +		esac
> +		off=$((off + blksz))
> +	done
> +
> +	sync $file
> +}
> +
> +populate_expected_data() {
> +	# create a dummy file with expected old data for different cases
> +	create_mixed_mappings $testfile.exp_old_mixed $awu_max
> +	expected_data_old_mixed=$(xxd -s 0 -l $awu_max -p $testfile.exp_old_mixed)
> +
> +	$XFS_IO_PROG -fc "falloc 0 $awu_max" $testfile.exp_old_zeroes >> $seqres.full
> +	expected_data_old_zeroes=$(xxd -s 0 -l $awu_max -p $testfile.exp_old_zeroes)
> +
> +	$XFS_IO_PROG -fc "pwrite -b $awu_max 0 $awu_max" $testfile.exp_old_mapped >> $seqres.full
> +	expected_data_old_mapped=$(xxd -s 0 -l $awu_max -p $testfile.exp_old_mapped)
> +
> +	# create a dummy file with expected new data
> +	$XFS_IO_PROG -fc "pwrite -S 0x61 -b $awu_max 0 $awu_max" $testfile.exp_new >> $seqres.full
> +	expected_data_new=$(xxd -s 0 -l $awu_max -p $testfile.exp_new)
> +}
> +
> +verify_data_blocks() {
> +	local verify_start=$1
> +	local verify_end=$2
> +	local expected_data_old="$3"
> +	local expected_data_new="$4"
> +
> +	echo >> $seqres.full
> +	echo "# Checking data integrity from $verify_start to $verify_end" >> $seqres.full
> +
> +	# After an atomic write, for every chunk we ensure that the underlying
> +	# data is either the old data or new data as writes shouldn't get torn.
> +	local off=$verify_start
> +	while [[ "$off" -lt "$verify_end" ]]
> +	do
> +		actual_data=$(xxd -s $off -l $awu_max -p $testfile)
> +		if [[ "$actual_data" != "$expected_data_new" ]] && [[ "$actual_data" != "$expected_data_old" ]]
> +		then
> +			echo "Checksum match failed at off: $off size: $awu_max"
> +			echo "Expected contents: (Either of the 2 below):"
> +			echo
> +			echo "Expected old: "
> +			echo "$expected_data_old"
> +			echo
> +			echo "Expected new: "
> +			echo "$expected_data_new"
> +			echo
> +			echo "Actual contents: "
> +			echo "$actual_data"
> +
> +			return 1
> +		fi
> +		echo -n "Check at offset $off suceeded! " >> $seqres.full
> +		if [[ "$actual_data" == "$expected_data_new" ]]
> +		then
> +			echo "matched new" >> $seqres.full
> +		elif [[ "$actual_data" == "$expected_data_old" ]]
> +		then
> +			echo "matched old" >> $seqres.full
> +		fi
> +		off=$(( off + awu_max ))
> +	done
> +
> +	return 0
> +}
> +
> +# test data integrity for file by shutting down in between atomic writes
> +test_data_integrity() {
> +	echo >> $seqres.full
> +	echo "# Writing atomically to file in background" >> $seqres.full
> +	atomic_write_loop &
> +	awloop_pid=$!
> +
> +	# Wait for atleast first write to be recorded
> +	while [ ! -f "$tmp.aw" ]; do sleep 0.2; done
> +
> +	echo >> $seqres.full
> +	echo "# Shutting down filesystem while write is running" >> $seqres.full
> +	_scratch_shutdown
> +
> +	kill $awloop_pid
> +	wait $awloop_pid
> +
> +	last_offset=$(tail -n 1 $tmp.aw | cut -d" " -f4)
> +	cat $tmp.aw >> $seqres.full
> +	echo >> $seqres.full
> +	echo "# Last offset of atomic write: $last_offset" >> $seqres.full
> +
> +	rm $tmp.aw
> +	sleep 0.5
> +
> +	_scratch_cycle_mount
> +
> +	# we want to verify all blocks around which the shutdown happended
> +	verify_start=$(( last_offset - (awu_max * 5)))
> +	if [[ $verify_start < 0 ]]
> +	then
> +		verify_start=0
> +	fi
> +
> +	verify_end=$(( last_offset + (awu_max * 5)))
> +	if [[ "$verify_end" -gt "$filesize" ]]
> +	then
> +		verify_end=$filesize
> +	fi
> +}
> +
> +# test data integrity for file wiht written and unwritten mappings
> +test_data_integrity_mixed() {
> +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> +
> +	echo >> $seqres.full
> +	echo "# Creating testfile with mixed mappings" >> $seqres.full
> +	create_mixed_mappings $testfile $filesize
> +
> +	test_data_integrity
> +
> +	verify_data_blocks $verify_start $verify_end "$expected_data_old_mixed" "$expected_data_new"
> +
> +	if [[ "$?" == "1" ]]
> +	then
> +		return 1
> +	fi
> +}
> +
> +# test data integrity for file with completely written mappings
> +test_data_integrity_writ() {
> +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> +
> +	echo >> $seqres.full
> +	echo "# Creating testfile with fully written mapping" >> $seqres.full
> +	$XFS_IO_PROG -c "pwrite -b $filesize 0 $filesize" $testfile >> $seqres.full
> +	sync $testfile
> +
> +	test_data_integrity
> +
> +	verify_data_blocks $verify_start $verify_end "$expected_data_old_mapped" "$expected_data_new"
> +
> +	if [[ "$?" == "1" ]]
> +	then
> +		return 1
> +	fi
> +}
> +
> +# test data integrity for file with completely unwritten mappings
> +test_data_integrity_unwrit() {
> +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> +
> +	echo >> $seqres.full
> +	echo "# Creating testfile with fully unwritten mappings" >> $seqres.full
> +	$XFS_IO_PROG -c "falloc 0 $filesize" $testfile >> $seqres.full
> +	sync $testfile
> +
> +	test_data_integrity
> +
> +	verify_data_blocks $verify_start $verify_end "$expected_data_old_zeroes" "$expected_data_new"
> +
> +	if [[ "$?" == "1" ]]
> +	then
> +		return 1
> +	fi
> +}
> +
> +# test data integrity for file with no mappings
> +test_data_integrity_hole() {
> +	$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> +
> +	echo >> $seqres.full
> +	echo "# Creating testfile with no mappings" >> $seqres.full
> +	$XFS_IO_PROG -c "truncate $filesize" $testfile >> $seqres.full
> +	sync $testfile
> +
> +	test_data_integrity
> +
> +	verify_data_blocks $verify_start $verify_end "$expected_data_old_zeroes" "$expected_data_new"
> +
> +	if [[ "$?" == "1" ]]
> +	then
> +		return 1
> +	fi
> +}
> +
> +test_filesize_integrity() {
> +	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
> +
> +	echo >> $seqres.full
> +	echo "# Performing extending atomic writes over file in background" >> $seqres.full
> +	atomic_write_loop &
> +	awloop_pid=$!
> +
> +	# Wait for atleast first write to be recorded
> +	while [ ! -f "$tmp.aw" ]; do sleep 0.2; done
> +
> +	echo >> $seqres.full
> +	echo "# Shutting down filesystem while write is running" >> $seqres.full
> +	_scratch_shutdown
> +
> +	kill $awloop_pid
> +	wait $awloop_pid
> +
> +	local last_offset=$(tail -n 1 $tmp.aw | cut -d" " -f4)
> +	cat $tmp.aw >> $seqres.full
> +	echo >> $seqres.full
> +	echo "# Last offset of atomic write: $last_offset" >> $seqres.full
> +	rm $tmp.aw
> +	sleep 0.5
> +
> +	_scratch_cycle_mount
> +	local filesize=$(_get_filesize $testfile)
> +	echo >> $seqres.full
> +	echo "# Filesize after shutdown: $filesize" >> $seqres.full
> +
> +	# To confirm that the write went atomically, we check:
> +	# 1. The last block should be a multiple of awu_max
> +	# 2. The last block should be the completely new data
> +
> +	if (( $filesize % $awu_max ))
> +	then
> +		echo "Filesize after shutdown ($filesize) not a multiple of atomic write unit ($awu_max)"
> +	fi
> +
> +	verify_start=$(( filesize - (awu_max * 5)))
> +	if [[ $verify_start < 0 ]]
> +	then
> +		verify_start=0
> +	fi
> +
> +	local verify_end=$filesize
> +
> +	# Here the blocks should always match new data hence, for simplicity of
> +	# code, just corrupt the $expected_data_old buffer so it never matches
> +	local expected_data_old="POISON"
> +	verify_data_blocks $verify_start $verify_end "$expected_data_old" "$expected_data_new"
> +
> +	return $?
> +}
> +
> +$XFS_IO_PROG -fc "truncate 0" $testfile >> $seqres.full
> +
> +echo >> $seqres.full
> +echo "# Populating expected data buffers" >> $seqres.full
> +populate_expected_data
> +
> +# Loop 20 times to shake out any races due to shutdown
> +for ((iter=0; iter<20; iter++))
> +do
> +	echo >> $seqres.full
> +	echo "------ Iteration $iter ------" >> $seqres.full
> +
> +	echo >> $seqres.full
> +	echo "# Starting data integrity test for atomic writes over mixed mapping" >> $seqres.full
> +	test_data_integrity_mixed
> +	if [[ "$?" == "1" ]]
> +	then
> +		status=1
> +		break
> +	fi
> +
> +	echo >> $seqres.full
> +	echo "# Starting data integrity test for atomic writes over fully written mapping" >> $seqres.full
> +	test_data_integrity_writ
> +	if [[ "$?" == "1" ]]
> +	then
> +		status=1
> +		break
> +	fi
> +
> +	echo >> $seqres.full
> +	echo "# Starting data integrity test for atomic writes over fully unwritten mapping" >> $seqres.full
> +	test_data_integrity_unwrit
> +	if [[ "$?" == "1" ]]
> +	then
> +		status=1
> +		break
> +	fi
> +
> +	echo >> $seqres.full
> +	echo "# Starting data integrity test for atomic writes over holes" >> $seqres.full
> +	test_data_integrity_hole
> +	if [[ "$?" == "1" ]]
> +	then
> +		status=1
> +		break
> +	fi
> +
> +	echo >> $seqres.full
> +	echo "# Starting filesize integrity test for atomic writes" >> $seqres.full
> +	test_filesize_integrity
> +	if [[ "$?" == "1" ]]
> +	then
> +		status=1
> +		break
> +	fi
> +done
> +
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/generic/772.out b/tests/generic/772.out
> new file mode 100644
> index 00000000..98c13968
> --- /dev/null
> +++ b/tests/generic/772.out
> @@ -0,0 +1,2 @@
> +QA output created by 772
> +Silence is golden
> -- 
> 2.49.0
> 
> 
