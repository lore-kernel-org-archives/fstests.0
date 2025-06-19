Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5E7258A
	for <fstests@vger.kernel.org>; Thu, 19 Jun 2025 07:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750319168; cv=none; b=fwaZLLpdY/cHW+aioTvwRMtxt6atyiiOgI/luz7HcAnCJDNSW/Mv74qzEoqVir2a5nmiQhx3KQIcanO5xwFYVeBH6b465L3LkOa9r4trEhOAdTWGgzSlkggZoxc4fChpXne5iWwZsf20OFz5dprQsxNCroNX0wlYXE5z22F/Pxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750319168; c=relaxed/simple;
	bh=ydAFl1lq6DgWbycioNQLxVu/SIA1vHuF28zz9+gicO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQCNkE802y8QWW4shCKSptOE8Q2y1CYTmV8lOuLy9cdnlYjs2Shr7QgisCliTcxG+nvS0zH/JsT5V1vaROkdT3tYeKp4qU1IE+EoPLxDSD3Cz2gwkR8fpUStEnbN58AB6w4584I8VDicNE87dkq1y/b9ALbT+zmWgU21fAYU/3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wk2jyD5R; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wk2jyD5R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750319164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+H3RrN/SmlpPvXqyYHsB0ciVYqRMq1lZUOPkr5bmOLY=;
	b=Wk2jyD5RC8lkpN7/kfyB/Zcrvn2F5KJxQmJkF2qMa2YEC48vGipWztFqBbCZU8zob6O3H8
	f8GHUohVBR2o2UCqZkPPws2eW9nGJyhcUD71W0/QMjmPvIra9BUmU1TtyT91LjPtUwqqEl
	lMCX2sJybcjKABuL5NqB/Nm7p9SODt4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290--B1Wwt4eMCqb8lON-DmDag-1; Thu, 19 Jun 2025 03:46:03 -0400
X-MC-Unique: -B1Wwt4eMCqb8lON-DmDag-1
X-Mimecast-MFC-AGG-ID: -B1Wwt4eMCqb8lON-DmDag_1750319162
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-3138e65efe2so462771a91.1
        for <fstests@vger.kernel.org>; Thu, 19 Jun 2025 00:46:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750319162; x=1750923962;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+H3RrN/SmlpPvXqyYHsB0ciVYqRMq1lZUOPkr5bmOLY=;
        b=G87RR8uZw4L8slaT4CDNZ63OjIYXn8oORuLaifgOVNQdQ5lCkjPWSkffMpOb9OU3qO
         7q5LfF4lXhuL71FEYuUSgxAHBWhdN87wHblOV+ojA0jpPYsx2gGA9Twtld4jjH3xvD6B
         zFaSuVAjkzY/qSld+UOVP2umsnqLUd+74sv6HD1/k/0KrwcpBBHpPtohKPoESW9j40NQ
         QjuOgbHFY8BfZPBHJWX7ZzgQkZ1c93Pxc0hy1SOXZ1P67rotL9RNMpLlj25bUFXl1vuP
         eF8WJnGXkIgyJLHb87iLQt+1SbIDxwq41UJLsUWKE7ZeCe617Yt+3mm6cAhOTpua1Kfq
         BHCQ==
X-Gm-Message-State: AOJu0YyOoQufmn3ORKH26EekBpKj+QobwlaCM6rSKjBtxivBKT9C4Ao/
	/Ykb4wyEc4IGsoJL8Je8vgUaD6+2x7waaUD+W63YObOJI/gf6D08C2/Q9z6CIHucBPBHj5Jetx7
	n0THPS23TBttnY5ypc+4k4KlRg7v5hoWS5/SqSJ2B05LqZjvwOnXUVHEJmW8=
X-Gm-Gg: ASbGncvoqLjsHX2Z5xEyVuNdriXIQJvykwYItFjqCcFKaQKB3ZS932KuUdgA6lLSg7J
	UNZjtF4Pfh7oLzI31zO0Zuuvq2GAHmoYPpX9YSibHMUVnkPkjDX+oFR/mVWgyRiIhfUSL9xsxOL
	aQG8arxZ1lD+Oo+x5a0pPJJy/irgWSCvIbQZaysq4m8uCtLsGvz4Y/jf/FZ/9EVC2mbcPCevMbA
	C6QndKG9nJmtRpNBNTEsjd1RrW3uICsHsmj2UZXZKAdphYoTh4JSlz02D5MldFSBtjccU0976Ch
	my7uvykyFlLueA/njOUXORZ9pL3X8VZY9oldWS0DjIBa6FgrOfGWsQpAPnO4Tx8=
X-Received: by 2002:a17:90b:4e86:b0:312:e744:5b76 with SMTP id 98e67ed59e1d1-313f1e16fc7mr35645775a91.33.1750319162155;
        Thu, 19 Jun 2025 00:46:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3BKzQCKNSo+0bdqMAFvkkIdd+JBbGaTLs8Q/fVauZqDrt6mvJoEiA9HGQ4rVRoFbOj/kI6w==
X-Received: by 2002:a17:90b:4e86:b0:312:e744:5b76 with SMTP id 98e67ed59e1d1-313f1e16fc7mr35645746a91.33.1750319161730;
        Thu, 19 Jun 2025 00:46:01 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3158a224446sm1620829a91.1.2025.06.19.00.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 00:46:01 -0700 (PDT)
Date: Thu, 19 Jun 2025 15:45:57 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com
Subject: Re: [RFC 10/12] ext4/062: Atomic writes test for bigalloc using fio
 crc verifier on multiple files
Message-ID: <20250619074557.x4qdj6c6hs7pqelj@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <9b0512d4063c2dc421e3e72e8c899460dd0c2644.1749629233.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b0512d4063c2dc421e3e72e8c899460dd0c2644.1749629233.git.ojaswin@linux.ibm.com>

On Wed, Jun 11, 2025 at 03:04:53PM +0530, Ojaswin Mujoo wrote:
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> 
> Brute force all possible blocksize clustersize combination on a bigalloc
> filesystem for stressing atomic write using fio data crc verifier. We run
> multiple threads in parallel with each job writing to its own file. The
> parallel jobs running on a constrained filesystem size ensure that we stress
> the ext4 allocator to allocate contiguous extents.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---

Similar review points as patch 9/12.

>  tests/ext4/062     | 131 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/062.out |   2 +
>  2 files changed, 133 insertions(+)
>  create mode 100755 tests/ext4/062
>  create mode 100644 tests/ext4/062.out
> 
> diff --git a/tests/ext4/062 b/tests/ext4/062
> new file mode 100755
> index 00000000..50803b97
> --- /dev/null
> +++ b/tests/ext4/062
> @@ -0,0 +1,131 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 061
> +#
> +# Brute force all possible blocksize clustersize combination on a bigalloc
> +# filesystem for stressing atomic write using fio data crc verifier. We run
> +# nproc * $LOAD_FACTOR threads in parallel writing to a single
> +# $SCRATCH_MNT/test-file. We also create 8 such parallel jobs to run on
> +# a constrained filesystem size to stress the ext4 allocator to allocate
> +# contiguous extents.
> +#
> +
> +. ./common/preamble
> +. ./common/atomicwrites
> +
> +_begin_fstest auto rw stress atomicwrites
> +
> +_require_scratch_write_atomic
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
> +	if (( $1 < $2 )); then
> +		echo "$1"
> +	else
> +		echo "$2"
> +	fi
> +}
> +
> +FSSIZE=$((360*1024*1024))
> +FS_MAX_CLUSTER_SIZE=$((128*1024))
> +FIO_LOAD=$(($(nproc) * LOAD_FACTOR))
> +fiobsize=4096
> +
> +# Calculate fsblocksize and FS_MAX_CLUSTER_SIZE as per bdev atomic write units.
> +bdev_awu_min=$(_get_atomic_write_unit_min $SCRATCH_DEV)
> +bdev_awu_max=$(_get_atomic_write_unit_max $SCRATCH_DEV)
> +fsblocksize=$(max 4096 "$bdev_awu_min")
> +FS_MAX_CLUSTER_SIZE=$(min "$FS_MAX_CLUSTER_SIZE" "$bdev_awu_max")
> +
> +function create_fio_config()
> +{
> +cat >$fio_config <<EOF
> +	[global]
> +	direct=1
> +	ioengine=libaio
> +	rw=randwrite
> +	bs=$fiobsize
> +	fallocate=truncate
> +	size=$((FSSIZE / 12))
> +	iodepth=$FIO_LOAD
> +	numjobs=$FIO_LOAD
> +	group_reporting=1
> +	verify_state_save=0
> +	verify=crc32c
> +	verify_fatal=1
> +	verify_dump=0
> +	verify_backlog=1024
> +	verify_async=4
> +	verify_write_sequence=0
> +	atomic=1
> +
> +	[job1]
> +	filename=$SCRATCH_MNT/testfile-job1
> +
> +	[job2]
> +	filename=$SCRATCH_MNT/testfile-job2
> +
> +	[job3]
> +	filename=$SCRATCH_MNT/testfile-job3
> +
> +	[job4]
> +	filename=$SCRATCH_MNT/testfile-job4
> +
> +	[job5]
> +	filename=$SCRATCH_MNT/testfile-job5
> +
> +	[job6]
> +	filename=$SCRATCH_MNT/testfile-job6
> +
> +	[job7]
> +	filename=$SCRATCH_MNT/testfile-job7
> +
> +	[job8]
> +	filename=$SCRATCH_MNT/testfile-job8
> +
> +EOF
> +}
> +
> +# Let's create a sample fio config to check whether fio supports all options.
> +fio_config=$tmp.fio
> +create_fio_config
> +_require_fio $fio_config
> +
> +for ((fsblocksize=$fsblocksize; fsblocksize <= $(_get_page_size); fsblocksize = $fsblocksize << 1)); do
> +	for ((fsclustersize=$fsblocksize; fsclustersize <= $FS_MAX_CLUSTER_SIZE; fsclustersize = $fsclustersize << 1)); do
> +		for ((fiobsize = $fsblocksize; fiobsize <= $fsclustersize; fiobsize = $fiobsize << 1)); do
> +			MKFS_OPTIONS="-O bigalloc -b $fsblocksize -C $fsclustersize"
> +			_scratch_mkfs_sized "$FSSIZE" >> $seqres.full 2>&1 || continue
> +			if _try_scratch_mount >> $seqres.full 2>&1; then
> +				touch $SCRATCH_MNT/f1
> +				echo "== FIO test for fsblocksize=$fsblocksize fsclustersize=$fsclustersize fiobsize=$fiobsize ==" >> $seqres.full
> +				fio_config=$tmp.fio
> +				fio_out=$tmp.fio.out
> +				create_fio_config
> +				_require_fio $fio_config
> +				cat $fio_config >> $seqres.full
> +				$FIO_PROG $fio_config --output=$fio_out
> +				ret=$?
> +				cat $fio_out >> $seqres.full
> +				_scratch_unmount
> +				[[ $ret -eq 0 ]] || break;
> +			fi
> +		done
> +	done
> +done
> +
> +# success, all done
> +echo Silence is golden
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
> 2.49.0
> 
> 

