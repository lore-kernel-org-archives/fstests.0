Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7E53085DB
	for <fstests@vger.kernel.org>; Thu, 19 Jun 2025 07:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750319557; cv=none; b=cbS69/OAcIy/BO+7Fbz4nYwnu4QbeOuMpjfVGWBHP1Y1C3c5oQdOhRaNnv8sfv/p3ml6UcWkn+Al0n5tq1XW0wlp96SzZTs7ixEJQubZMnor1JC+VSzHvohe3kQSWiotURtU+XEm7bY5we0Kxdx6Y1D2K/7pslZ+qn8lP4LFWPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750319557; c=relaxed/simple;
	bh=2ISg654CeHGt8eKjSuUXTbRWJNOFyAM9wGL+CBXG+yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwcUr67Y26JcaIBIW707gLFABoi1CLSWqygLYHX3Puu2YXOMTtjJYY/Q7dWy76uI3Qfof5pH60DQ1vlT6t56qms5k92S+pmUto4a74zaiJ77gMkeQIJs7RaVOlle01Avwz58+BJh6KuptbEJEkSqseam1favDoVRJ6LM4Z7Bmkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AJAyYVTo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AJAyYVTo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750319554;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fBMQNFX9tRoMCm9/DMBgKcogKH0RvSpLMkHtoQr2m1M=;
	b=AJAyYVToPJhZt3QqZS33t3u10GTURJqm4iNqknFkcWJ3hu5yR87hRoiewJDTwd3Ys03f2x
	rf9b6zuPGFURXXTJyS3Vk6TeCYhM6/KgB0pq6V4MxpfFwHxBgfiL3aFIzXqK8JM2DZj16J
	FpWXkGRK25YxkUJE0B0IkCDbVep1R7g=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-LOc0f1v0NzugQXs5k7qV-w-1; Thu, 19 Jun 2025 03:52:32 -0400
X-MC-Unique: LOc0f1v0NzugQXs5k7qV-w-1
X-Mimecast-MFC-AGG-ID: LOc0f1v0NzugQXs5k7qV-w_1750319551
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-748e1e474f8so808369b3a.2
        for <fstests@vger.kernel.org>; Thu, 19 Jun 2025 00:52:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750319551; x=1750924351;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fBMQNFX9tRoMCm9/DMBgKcogKH0RvSpLMkHtoQr2m1M=;
        b=Zwius7RRfyJ6sYDapDcyDyTgSHs2EXJ4RMxUwngVHRkPuQLaA6yvb0FwiRJLXUSw+H
         savT426ReF0hC9Sa5gn0ale/FH4eVMJ1lT8VfZxKGSOX1ulhWcEX8H2MVdJBDr7qvxTj
         gG5hS9doShQ16gBc5xjZozTEsgChe9cTGOmSZnpDMiQQVmkT/2jj5QHP4MmK2G1Oic5m
         pADXvplRsAIsfczPZLgYQrF8XEUgbSTGuXZwSqYI4ozWDhvPAks8Gt9sfVfR8Ay71lvY
         xfTozm6N+AV6MQ9OSQIXhOZC8NLxe3x9KrAVOS/OyM0oU8Ch1cShM3WWY1xnOYlb1k8A
         tUCw==
X-Gm-Message-State: AOJu0YyER3wg7Kp/QfgSE/cdB0Z9q2CUmFDtDSGyVmbbQ43dnATaDJ91
	6xUqBtmGcCgv2dxMltG4dpW53Qyn0OlG6gu714AKhXXmQdyKrReXzDeCRiPjCfBHNDtzes24CDr
	recCXERIssjMkgfnFufmpNvhPaFHc+PHrgxCxaVOTp+lh7uYBGm9A5HYLM4ZL7foX5A4=
X-Gm-Gg: ASbGncu56iVXQzh0Qbx3FoJ02sHfw+vlqiuNl8tc/S2sCvHhitXZSiWw0mGpZ6H0PUc
	dN9xAzGKglObePhcKnnZ9zCg5Fs5MhkoJd9+OEtIEw+T3ixoYRi4v04tEygiR8Z5NmHuRs5XSBK
	zBPcasFLetwuVjCnfIS6xMNdnS9m/LK1APuF8DkObC0de2Joi7ohSZZcbXWbEe7yRQPg0ALv18V
	a5WyQ2g9Ma8YezGp0BRO1x2axiVElVShlKYXMuhx6/k30UOmVzcwTqac5dSJ6GibMdtnhygF1Rj
	mlZkcUoPat99mF6xmMxcLVGJ76r4x4k/KH5DbOz242n1lshwo4zgFy4gD4sbq9Y=
X-Received: by 2002:a05:6a21:2d4b:b0:215:e60b:3bcf with SMTP id adf61e73a8af0-21fbd57acf8mr38204228637.30.1750319551062;
        Thu, 19 Jun 2025 00:52:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWtWU51syGDU+d230jrJ4V+jzn09kCTMph/cAyDYUpqpBOO62zppjmoLwF9Caxu61OfTR9/A==
X-Received: by 2002:a05:6a21:2d4b:b0:215:e60b:3bcf with SMTP id adf61e73a8af0-21fbd57acf8mr38204197637.30.1750319550632;
        Thu, 19 Jun 2025 00:52:30 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748900d24c6sm12519294b3a.168.2025.06.19.00.52.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 00:52:30 -0700 (PDT)
Date: Thu, 19 Jun 2025 15:52:25 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com
Subject: Re: [RFC 11/12] ext4/063: Atomic write test for extent split across
 leaf nodes
Message-ID: <20250619075225.wtkol3bxdhsqszdi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <8b7208ab292e7a2df7a2142d189448cfe11fcee6.1749629233.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b7208ab292e7a2df7a2142d189448cfe11fcee6.1749629233.git.ojaswin@linux.ibm.com>

On Wed, Jun 11, 2025 at 03:04:54PM +0530, Ojaswin Mujoo wrote:
> In ext4, even if an allocated range is physically and logically
> contiguous, it can still be split into 2 extents. This is because ext4
> does not merge extents across leaf nodes. This is an issue for atomic
> writes since even for a continuous extent the map block could (in rare
> cases) return a shorter map, hence tearning the write. This test creates
> such a file and ensures that the atomic write handles this case
> correctly
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/ext4/063     | 125 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/063.out |   2 +
>  2 files changed, 127 insertions(+)
>  create mode 100755 tests/ext4/063
>  create mode 100644 tests/ext4/063.out
> 
> diff --git a/tests/ext4/063 b/tests/ext4/063
> new file mode 100755
> index 00000000..b4759990
> --- /dev/null
> +++ b/tests/ext4/063
> @@ -0,0 +1,125 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# In ext4, even if an allocated range is physically and logically contiguous,
> +# it can still be split into 2 extents. This is because ext4 does not merge
> +# extents across leaf nodes. This is an issue for atomic writes since even for
> +# a continuous extent the map block could (in rare cases) return a shorter map,
> +# hence tearning the write. This test creates such a file and ensures that the
> +# atomic write handles this case correctly
> +#
> +. ./common/preamble
> +. ./common/atomicwrites
> +_begin_fstest auto atomicwrites
> +
> +_require_scratch_write_atomic_multi_fsblock
> +_require_atomic_write_test_commands
> +
> +prep() {
> +	local bs=`_get_block_size $SCRATCH_MNT`
> +	local ex_hdr_bytes=12
> +	local ex_entry_bytes=12
> +	local entries_per_blk=$(( (bs - ex_hdr_bytes) / ex_entry_bytes ))
> +
> +	# fill the extent tree leaf which bs len extents at alternate offsets. For example,
> +	# for 4k bs the tree should look as follows
> +	#
> +	#                  +---------+---------+
> +	#                  | index 1 | index 2 |
> +	#                  +-----+---+-----+---+
> +	#               +--------+         +-------+
> +	#               |                          |
> +	#    +----------+--------------+     +-----+-----+
> +	#    | ex 1 | ex 2 |... | ex n |     |  ex n + 1 |
> +	#    +-------------------------+     +-----------+
> +	#    0      2            680          682
> +	for i in $(seq 0 $entries_per_blk)
> +	do
> +		$XFS_IO_PROG -fc "pwrite -b $bs $((i * 2 * bs)) $bs" $testfile > /dev/null
> +	done
> +	sync $testfile
> +
> +	echo >> $seqres.full
> +	echo "Create file with extents spanning 2 leaves. Extents:">> $seqres.full
> +	echo "...">> $seqres.full
> +	$DEBUGFS_PROG -R "ex `basename $testfile`" $SCRATCH_DEV |& tail >> $seqres.full

_require_command "$DEBUGFS_PROG" debugfs

> +
> +	# Now try to insert a new extent ex(new) between ex(n) and ex(n+1). Since
> +	# this is a new FS the allocator would find continuous blocks such that
> +	# ex(n) ex(new) ex(n+1) are physically(and logically) contiguous. However,
> +	# since we dont merge extents across leaf we will end up with a tree as:
> +	#
> +	#                  +---------+---------+
> +	#                  | index 1 | index 2 |
> +	#                  +-----+---+-----+---+
> +	#               +--------+         +-------+
> +	#               |                          |
> +	#    +----------+--------------+     +-----+-----+
> +	#    | ex 1 | ex 2 |... | ex n |     | ex merged |
> +	#    +-------------------------+     +-----------+
> +	#    0      2            680          681  682  684
> +	#
> +	echo >> $seqres.full
> +	torn_ex_offset=$((((entries_per_blk * 2) - 1) * bs))
> +	$XFS_IO_PROG -c "pwrite $torn_ex_offset $bs" $testfile >> /dev/null
> +	sync $testfile
> +
> +	echo >> $seqres.full
> +	echo "Perform 1 block write at $torn_ex_offset to create torn extent. Extents:">> $seqres.full
> +	echo "...">> $seqres.full
> +	$DEBUGFS_PROG -R "ex `basename $testfile`" $SCRATCH_DEV |& tail >> $seqres.full
> +
> +	_scratch_cycle_mount
> +}
> +
> +_scratch_mkfs >> $seqres.full
> +_scratch_mount >> $seqres.full
> +
> +testfile=$SCRATCH_MNT/testfile
> +touch $testfile
> +awu_max=$(_get_atomic_write_unit_max $testfile)
> +
> +echo >> $seqres.full
> +echo "# Prepping the file" >> $seqres.full
> +prep
> +
> +torn_aw_offset=$((torn_ex_offset - (torn_ex_offset % awu_max)))
> +
> +echo >> $seqres.full
> +echo "# Performing atomic IO on the torn extent range. Command: " >> $seqres.full
> +echo $XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $awu_max $torn_aw_offset $awu_max" >> $seqres.full

_require_xfs_io_command pwrite -A

> +$XFS_IO_PROG -c "open -fsd $testfile" -c "pwrite -S 0x61 -DA -V1 -b $awu_max $torn_aw_offset $awu_max" >> $seqres.full
> +
> +echo >> $seqres.full
> +echo "Extent state after atomic write:">> $seqres.full
> +echo "...">> $seqres.full
> +$DEBUGFS_PROG -R "ex `basename $testfile`" $SCRATCH_DEV |& tail >> $seqres.full
> +
> +echo >> $seqres.full
> +echo "# Checking data integrity" >> $seqres.full
> +
> +# create a dummy file with expected data
> +$XFS_IO_PROG -fc "pwrite -S 0x61 -b $awu_max 0 $awu_max" $testfile.exp >> /dev/null
> +expected_data=$(xxd -s 0 -l $awu_max -p $testfile.exp)

xxd isn't a necessary running dependence of xfstests, please use common/rc:_hexdump()
or other commands in coreutils.

> +
> +# We ensure that the data after atomic writes should match the expected data
> +actual_data=$(xxd -s $torn_aw_offset -l $awu_max -p $testfile)
> +if [[ "$actual_data" != "$expected_data" ]]
> +then
> +	echo "Checksum match failed at off: $torn_aw_offset size: $awu_max"
> +	echo
> +	echo "Expected: "
> +	echo "$expected_data"
> +	echo
> +	echo "Actual contents: "
> +	echo "$actual_data"
> +


> +	status=1
> +	exit

_exit 1

> +fi
> +
> +echo -n "Data verification at offset $torn_aw_offset suceeded!" >> $seqres.full
> +echo "Silence is golden"
> +status=0
> +exit
> diff --git a/tests/ext4/063.out b/tests/ext4/063.out
> new file mode 100644
> index 00000000..de35fc52
> --- /dev/null
> +++ b/tests/ext4/063.out
> @@ -0,0 +1,2 @@
> +QA output created by 063
> +Silence is golden
> -- 
> 2.49.0
> 
> 

