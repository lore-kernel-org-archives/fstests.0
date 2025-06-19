Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CFB207DEF
	for <fstests@vger.kernel.org>; Thu, 19 Jun 2025 07:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750319045; cv=none; b=bxQS5l3vxvR/dTRi402Bsu4rfVhG0b4uYY1pEzSDgltfSG5NZw13cstf8DeEdSEB3WUwy7iL+nP889648ZpusqpsfJX7+LrluwYccdNqQTKXGQiqkET1YXvXlh75mYppHZ8593x89yoCpBliNKdxumwq6SLorJz/wyQBu3eAgH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750319045; c=relaxed/simple;
	bh=CkLqNkEot2sgpSWXWL3KxzkmcvAPsDo29vgGwNW32mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCU3AnbJWAbd2GA9kc0IUDgSjNiE/+Oauk3zsEzGlGxJ1ldnHk4oakfr2jKTqPOqsUO84m7e51zB62ohj+rkUAC/peCshrPXMZiUeFW/Vz1xTOqTWWQlgSVZlNm0FS56lBbTwtwrYPBV9o8BcMcB8fPyuaYumgNNfzKdoGLdnm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YELT7gV/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YELT7gV/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750319039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=h+QFso5PhMwETFmMtJnIYy2JU5HaKWYXVmUWtxN5BMY=;
	b=YELT7gV/KdGut6G5cTnK0iez5CrE6wbBcIHKOigRijpPbla4opltHGgvUMeAgzCzMFu+f3
	RdDz7Vu74E3T/kk76F+fqw2jLr0GMyy8pLa3pMDgpHrM2alqaPhWVBVVtIxxwCU96TNvw4
	YYeFMLGpi467ojT4mMFMmQLZYz7csEE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-HNXDgdQAOJ-ejhjUIifVtw-1; Thu, 19 Jun 2025 03:43:57 -0400
X-MC-Unique: HNXDgdQAOJ-ejhjUIifVtw-1
X-Mimecast-MFC-AGG-ID: HNXDgdQAOJ-ejhjUIifVtw_1750319037
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-748d9802b0eso451937b3a.3
        for <fstests@vger.kernel.org>; Thu, 19 Jun 2025 00:43:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750319036; x=1750923836;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+QFso5PhMwETFmMtJnIYy2JU5HaKWYXVmUWtxN5BMY=;
        b=rmbLk/UUentuH0JNeJAEFNfv1mdyl1KZeRuUqJ5JbcV+HB29pfbnU4pfKAg8JytknX
         UoTe+rjQgPRDmE2Ey2tmVXuwIyaCRUQh770aIbiezE7bdcqhsj6nXonu64pI6UPz5eml
         u+lqDpLISReV2iSSI/gS8IT0I7TeczKD5dhCh0lh2zkVGBux15FXAuS66oV6Pyo3P5Pf
         lCZ8134vFEfHO+m0+Uf5ooyjPviVfsyWWNizovnWmK8wTn38ehg57p56nFSjHFkwgaDj
         shKhQxqyQX7DHY2JsXYprc+uxm1DM851H+e1PzT5cmUqvpPyTowq+hfZzyMczEqwnfqi
         /dAw==
X-Gm-Message-State: AOJu0Yxpreb8WoB9gS/LlAdVZPVtgyKpKOnGxgHxx6dDVd4zdhHpNb93
	1+MHi50kl5lCux5hsa5JCDLXMGduuH7nV6XLwvro/dlaFOGbx51+DRKKr/6o8ifM6BTgcss7XLa
	AofU1lN9oXA+HgGcW7zdPDwSSEhv8axmXb5I6TZX3JmA+J0NFlPlRiSy47sTHWahNkHk=
X-Gm-Gg: ASbGncsTCucfbWCUBXDWXeinUa8PVCa5c+sH6gmqETBKUZzMm1Qx4C7XZosccHxZMYP
	Dk0H3V82QeYA3fM/pL6TlbwlqhUbHYHZKpE2NshsdF3DuGajNYK63fMIERQ6o+VJaTaGuN6GmL5
	fSUIXgSSm640DNgQ+xf7pxqc9X9jSPKNZQEeehd1aNwouroc+VQWCGaOkWSFNPNmxIGamjgoFhz
	0Lzi0qNCwnbZjAe46HrOCvRiF9Sgfg4P6UcjS4XHAJb9mpd+bSqkRKTEoRm3iIwbX/JIat8M/PP
	x6FY593akhTvPb93WpAwgH6DPkMxAtk3b0l5H0h7NdpVa2J0jPkIRKqa3rDbQQs=
X-Received: by 2002:a05:6a00:806:b0:740:9d7c:aeb9 with SMTP id d2e1a72fcca58-7489cfdce76mr30703575b3a.21.1750319036426;
        Thu, 19 Jun 2025 00:43:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQxEf7oLjhH2s636JxlykuRCJnoZtFuVVPcsEQywmhveYK3jVFpv8oPqgdMCxxpiybxGWfRA==
X-Received: by 2002:a05:6a00:806:b0:740:9d7c:aeb9 with SMTP id d2e1a72fcca58-7489cfdce76mr30703554b3a.21.1750319036055;
        Thu, 19 Jun 2025 00:43:56 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74890083fa0sm12512045b3a.82.2025.06.19.00.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 00:43:55 -0700 (PDT)
Date: Thu, 19 Jun 2025 15:43:51 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>,
	djwong@kernel.org, john.g.garry@oracle.com
Subject: Re: [RFC 09/12] ext4/061: Atomic writes stress test for bigalloc
 using fio crc verifier
Message-ID: <20250619074351.6tyynxkbzkzjmjub@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1749629233.git.ojaswin@linux.ibm.com>
 <1fb9171017c601c3a1e1da1581d5da41746ca813.1749629233.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fb9171017c601c3a1e1da1581d5da41746ca813.1749629233.git.ojaswin@linux.ibm.com>

On Wed, Jun 11, 2025 at 03:04:52PM +0530, Ojaswin Mujoo wrote:
> From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
> 
> We brute force all possible blocksize & clustersize combinations on
> a bigalloc filesystem for stressing atomic write using fio data crc
> verifier. We run nproc * $LOAD_FACTOR threads in parallel writing to
> a single $SCRATCH_MNT/test-file. With atomic writes this test ensures
> that we never see the mix of data contents from different threads on
> a given bsrange.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  tests/ext4/061     | 107 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/ext4/061.out |   2 +
>  2 files changed, 109 insertions(+)
>  create mode 100755 tests/ext4/061
>  create mode 100644 tests/ext4/061.out
> 
> diff --git a/tests/ext4/061 b/tests/ext4/061
> new file mode 100755
> index 00000000..9d656613
> --- /dev/null
> +++ b/tests/ext4/061
> @@ -0,0 +1,107 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 IBM Corporation. All Rights Reserved.
> +#
> +# FS QA Test 061
> +#
> +# Brute force all possible blocksize clustersize combination on a bigalloc
> +# filesystem for stressing atomic write using fio data crc verifier. We run
> +# nproc * 2 * $LOAD_FACTOR threads in parallel writing to a single
> +# $SCRATCH_MNT/test-file. With fio aio-dio atomic write this test ensures that
> +# we should never see the mix of data contents from different threads for any
> +# given fio blocksize.
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

I've seen these two functions many times, please make them to be common helpers.

> +
> +FS_MAX_CLUSTER_SIZE=$((128*1024))
> +FIO_LOAD=$(($(nproc) * 2 * LOAD_FACTOR))
> +SIZE=$((100*1024*1024))
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
> +	[aio-dio-aw-verify]
> +	direct=1
> +	ioengine=libaio

_require_aiodio

> +	rw=randwrite
> +	bs=$fiobsize
> +	fallocate=native
> +	filename=$SCRATCH_MNT/test-file
> +	size=$SIZE
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

Wow, 3 for loops...

> +			MKFS_OPTIONS="-O bigalloc -b $fsblocksize -C $fsclustersize"
> +			_scratch_mkfs_ext4 "$MKFS_OPTIONS" >> $seqres.full 2>&1 || continue

MKFS_OPTIONS is used in _scratch_mkfs_ext4 by default, you don't need to use it as
an argument.

Or do you want to do:

_scratch_mkfs_ext4 "-O bigalloc -b $fsblocksize -C $fsclustersize" ?

> +			if _try_scratch_mount >> $seqres.full 2>&1; then
> +				touch $SCRATCH_MNT/f1
> +				echo "== FIO test for fsblocksize=$fsblocksize fsclustersize=$fsclustersize fiobsize=$fiobsize ==" >> $seqres.full
> +				fio_config=$tmp.fio

Do you change the "$tmp"? If not, you don't need to set fio_config=$tmp.fio
everytime, you've set fio_config above this for loop.

> +				fio_out=$tmp.fio.out

If you don't change "$tmp", you can set fio_out once, before the
for loop running.

> +				create_fio_config
> +				_require_fio $fio_config

I think only $fiobsize will be changed in $fio_config at here, so you're trying
to check "bs=$fiobsize"? If so, that doesn't make sense, due to _require_fio accepts
any "bs" number, except bs <= 0. So you don't need to call _require_fio
at here everytime, especially you've called it before the loop running.

Thanks,
Zorro

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
> diff --git a/tests/ext4/061.out b/tests/ext4/061.out
> new file mode 100644
> index 00000000..273be9e0
> --- /dev/null
> +++ b/tests/ext4/061.out
> @@ -0,0 +1,2 @@
> +QA output created by 061
> +Silence is golden
> -- 
> 2.49.0
> 
> 

