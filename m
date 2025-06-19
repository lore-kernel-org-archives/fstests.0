Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86E8254AF4
	for <fstests@vger.kernel.org>; Thu, 19 Jun 2025 07:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750317319; cv=none; b=R8Gw0OmFB9EKFJUQLNoJSWbEFovNz+LMBgBashy1Y8GUEESMOBEodbiWFwH05qIAB8ObCMrk3O3/5rVeHrigsxTGEQJax2Ps2O0sJbacqv66+bwPY/CbaVz3r5q2NTi341G3fr8kGuahVzj6yZGhbn0+l5hEKoyCx0BSOf1nkQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750317319; c=relaxed/simple;
	bh=vZUQ0R6YKY4V3gMOay26RCsrkoLacMhVRbZRFVmqfvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E2jSojBUAeZh03YjfBFyh7/pz8y9nmB09eB3KpNiFM1W6L5D25LHULlhWd8WqaPVbQDm3FUdfAMpN7MjMDcvdmhNEOFUKWiLFEf4sWtfXc1w07Nn6gQc3f8XU1gLrivigMz5hafXfzA2KtcSVh2xWh4AOaaDOSRg+akiQBPN/nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E8ClYviO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E8ClYviO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750317314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dVI5KC06AuO7lE9hVT8X2jps2TXebb/kjys2xZyOw7M=;
	b=E8ClYviOLL6ZMaDaB25tNkt3bkY5N9dRd7Iqq2h6Yq4/65PDzmm9ca4ktAGjFqYpuWyAtY
	rltzUEu3cssOUuxDG1tyQe7f3YcxAQDwb4vaj572yCpIsyGSh5DjpaoN4aSQnfhjMspeH0
	j6DNuEcbYam9sr8wgnDTUCEe1/eLLVk=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-YznrsdXHPVylzDOa_9o7ew-1; Thu, 19 Jun 2025 03:15:13 -0400
X-MC-Unique: YznrsdXHPVylzDOa_9o7ew-1
X-Mimecast-MFC-AGG-ID: YznrsdXHPVylzDOa_9o7ew_1750317312
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-235dd77d11fso5675915ad.0
        for <fstests@vger.kernel.org>; Thu, 19 Jun 2025 00:15:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750317312; x=1750922112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVI5KC06AuO7lE9hVT8X2jps2TXebb/kjys2xZyOw7M=;
        b=mcK+7qsIO10xZOICXBzZaxypVJ2U0ABPcrJ/i/BU9zLt/e0g7RT2nMIv8ZZzTHVd/q
         8bqy5uLiJjF2Ou3mqtsWzkffN5cE6y6sijYOBHD3n9KX/wIgnhMdwbbC81ErRBcB5MEs
         sCOJOnIwhBnbXU+mXdZFIcF9AwKPPfe4ToMFSe8UXPMXKT7UtSxT7uwhAANKhBXfz2Zu
         7NUpJr+C+9p/hRJywgQwlzv3ANrk57TI47y2Rp4WQmnhlQd+htEOIyO2BP8MeYSy1Q8Z
         yJqHVXLW899xe7zPSW3ykxRdTLXgdxHWmMpGZIlPkyqasf6mkUyVa278WKPngmnLqidj
         KxHQ==
X-Gm-Message-State: AOJu0YwSsfLmywA7wloBSIxskSvZ5C9L6tyy0j+e5WTNhpODOBJ4tNWw
	lfihDobPJ19gQR9jIlAKePCVyM+dPkfP7KPJJ2vuZ9sCPaBuOaWLwS3QW+UbtES1KgWyOav14/6
	PtRW+DwN0qOpmkSLVZZh5LVGcVQJq8EU9Ddw11xfhaz4O8V1wKoHbMFYPQTbnK5yO26I=
X-Gm-Gg: ASbGncuOkE/SRellnYofwRgV2QKNYe69bqOgxu5FBeBOwJRKGuegwua9eftLgmN+pfY
	B70t+AZRWgVQ4PkGJ2m2aD76J45l3eK/f81vYanp0ptWMklyOy5OpO/RRneQs4cJTXqzU6V4a0u
	E6C6X39z/RmyR2vNrYvfQfiRm0YG8K0KP3fAHOfx2/TWYNvwuWS3MxoJv8FPSgtEVuKzUEY2vyb
	HMWV/rFHFhHxMThiGDZ1jziVnGqvNenPxmksfSq1ui7tI6imQHziGWr8QISe0Kgibc11dWCEIT+
	R3mCnpVGssRRhms0YE3khq3+IFuKFxAFXNQ+lbjzZGvlIth4rowdj2TnarqaB4s=
X-Received: by 2002:a17:902:e811:b0:235:c9a7:d5fb with SMTP id d9443c01a7336-2366b3442b2mr304646985ad.16.1750317311545;
        Thu, 19 Jun 2025 00:15:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHdlvVvjjiZvRucyLQZMUduEcJya022pbwtjgjjwVDFUrli6Gx3h54uFgQyZAhR5vwIiZ6hiA==
X-Received: by 2002:a17:902:e811:b0:235:c9a7:d5fb with SMTP id d9443c01a7336-2366b3442b2mr304646465ad.16.1750317311046;
        Thu, 19 Jun 2025 00:15:11 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365deb6a0csm113293255ad.191.2025.06.19.00.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 00:15:10 -0700 (PDT)
Date: Thu, 19 Jun 2025 15:15:06 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com
Subject: Re: [RFC 08/12] generic/772: Add sudden shutdown tests for multi
 block atomic writes
Message-ID: <20250619071506.4y7z2milesbo6vsl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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

_require_xfs_io_command pwrite -A

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

_require_xfs_io_command falloc

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

"xxd" it's not a necessary running dependence of xfstests, please replace it with
common/rc:_hexdump() function or other similar commands in coreutils. Or you have
to _notrun if there's not xxd installed.

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

If there's background processes in test case, please make sure it's killed in
_cleanup(), e.g.

_cleanup()
{
...
	[ -n "$awloop_pid" ] && kill $awloop_pid
	wait
...
}

> +
> +	# Wait for atleast first write to be recorded
> +	while [ ! -f "$tmp.aw" ]; do sleep 0.2; done
> +
> +	echo >> $seqres.full
> +	echo "# Shutting down filesystem while write is running" >> $seqres.full
> +	_scratch_shutdown

_require_scratch_shutdown

> +
> +	kill $awloop_pid
> +	wait $awloop_pid

	unset awloop_pid

tell _cleanup "it's killed".

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

_require_xfs_io_command truncate

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

If the return value is useful, you'd better to "return 0" clearly. Or the
return value of this function will be unclear.

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

Same as above

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

Same

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

Same

> +}
> +
> +test_filesize_integrity() {
> +	$XFS_IO_PROG -c "truncate 0" $testfile >> $seqres.full
> +
> +	echo >> $seqres.full
> +	echo "# Performing extending atomic writes over file in background" >> $seqres.full
> +	atomic_write_loop &
> +	awloop_pid=$!

Please use another name, then deal with it in _cleanup, refer to
above awloop_pid.

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

What are these "status=1" for? You "break" the loop run directly after setting
status=1, then the status will be set to 0 at the end of the test.

You can output something to break the golden image (.out file). Or call _exit
or _fail to end the test with an error output.

Thanks,
Zorro

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

