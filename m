Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7243085BA
	for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 20:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750277841; cv=none; b=Toxl1LuXFnS9fo2veJPTb5t1slH+T7//XpfRq/cLzOZJ3nPdGplqyIhER8mUpnFPNPACuPLy0qdpK1/Q9bRQlVqCLhY1xtoe/TYG6wg5K3dyLzJajGK9lGPXeXvoGhO0n1y9SYsghspaaR8kWMKKBDB3hDINX57y38VLk8Q7MaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750277841; c=relaxed/simple;
	bh=Q/MaXLBtzzln43lghbD8oT8gug4K7wobKAwpmPtg+hQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RQpPuEz8M0/+Fg1rlkClBPnFeUlYvfGAYE1P/rgaWN0GAFz/TL2xPFzatpYB/Just7dxd6HsPR9TBYa7VitnXy5XdHAM4nFEwZt6s9pVnm5LooO9D+k8Xn7FYcMFfAcjenJxxEHrkHqkKunD5zd173ZLvsDj3dGzVuWO1IT/tAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WP96Kkdt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WP96Kkdt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750277838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rTpSukZ6jU8ypmFpV1ZqIFWHUmoI19CzJbFvtJKyT5g=;
	b=WP96Kkdt3bqX57Y26/tmgM+iOOzqJ7/P9xcggn6qwvT0eXvkRShESYQ5MIQnCLYRLSP2zP
	cYQuQKcJCaXTywCmMRPptzZUTvbu4MwgcPB0jy3XmqW8J8shhL/G/fBLMFtkG3IJPFotp4
	of7DjgYufm/TSairJZaA2yc0ZKFib/0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-K2LzhCatNzmR8F2GvxAKAQ-1; Wed, 18 Jun 2025 16:17:17 -0400
X-MC-Unique: K2LzhCatNzmR8F2GvxAKAQ-1
X-Mimecast-MFC-AGG-ID: K2LzhCatNzmR8F2GvxAKAQ_1750277837
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b2f4c436301so30603a12.0
        for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 13:17:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750277836; x=1750882636;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rTpSukZ6jU8ypmFpV1ZqIFWHUmoI19CzJbFvtJKyT5g=;
        b=fQ3TMBNDVGfirgH4jTYB+gEyRwvK4LORSjt5PnkuBl32LpBMPoOC8pHsY6oGi1rC3W
         RjLWDXkQUR8v2vIn4Xx7qJzZstZyblkjR0ddYBCoh9zf/xzCjuwU2zvupzeUZAa9PiTm
         r446iCoTI+z7XVlqnkus6ci6ilZZGaajsAXaF+Ti6tFPt5u0qu+Ztax0GMNVZp+7erF3
         mzk7f/GkrpLPeoguUYhEx8fRtnlpIyfchkSxprr7BH/vOdbspvQ6rm35eoOOcqP2FBqJ
         CeSdGAapLaI/n12tu/y/kwtr4mJY02w5RSsC1xqBsmGXHsZA4Z4iQ2K1f+jX2gDPkJZv
         U4lg==
X-Gm-Message-State: AOJu0YwkqOmvclF+BV2tdXjTV7mhEJaWTZEZnK2ncrzmmZsQaGw1o9Y4
	wJ4VtzrQ8nESvv7L1LIrC20oUc2mTPk2wyzEZKu53cd/UhuSDEb76pZDPM3ykHKx48XTNSSkZQW
	3VHFSIx31SQ15cwr5p1b4FgDSM7wLYEJ0wz8b2Lc6RSGTPuo18rU9me/1R4d1s5RlBVs=
X-Gm-Gg: ASbGncvGGfnIPRLd3B2/tzmcB718l50IUZebNQ126/HDYghEZ56EsiSoevE2EStIEAU
	DxbEvdgwmWggJAiDv9q/TJ1PsYorMj3SMsZWKiBi/S14PVxBmMe24IhRMv7CldIQEHHN38oeWPL
	oh6aEtPENGZ81EkJ6EzgcpJ9LiX05ljqIIOh1heTdPapS7Ctxdb+hnYRowb+IBryGGXNMNU75wH
	We/vTQRkY8Vj77rVFmo6CaQfGTPLvb6hH4wXGuHVBBkQC14hWwmGyCxaAE2aAJkd/qPGKWz1jCa
	YK72AICrLx6rTb+1KFmB77CRXD50LQ4pkcR4jES1HMSUFDaAkfNgFuklI/R/72k=
X-Received: by 2002:a05:6a21:6d97:b0:218:17a2:4421 with SMTP id adf61e73a8af0-2201125ffa2mr1495246637.10.1750277836357;
        Wed, 18 Jun 2025 13:17:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXQ8eWcLL70c3YB9ysHRyR1qW938aHl+TtC/Sa88xuwBw16NnzNuV58q9unjiECWRXDbuVxA==
X-Received: by 2002:a05:6a21:6d97:b0:218:17a2:4421 with SMTP id adf61e73a8af0-2201125ffa2mr1495207637.10.1750277835893;
        Wed, 18 Jun 2025 13:17:15 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b31d731ab20sm676546a12.77.2025.06.18.13.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 13:17:15 -0700 (PDT)
Date: Thu, 19 Jun 2025 04:17:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com
Subject: Re: [RFC 06/12] generic/770: Add atomic write multi-fsblock
 O_[D]SYNC tests
Message-ID: <20250618201711.2d6xuv6pztoj4pbn@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
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

_require_xfs_io_command falloc

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

_require_xfs_io_command pwrite -A


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

_require_scratch_shutdown

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

Looks like there're two iterations (loop running codes), the code looks much similar, can we
move them to one function then call it twice?

Thanks,
Zorro

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

