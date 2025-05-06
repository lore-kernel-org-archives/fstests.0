Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B084B1E4B
	for <fstests@vger.kernel.org>; Tue,  6 May 2025 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746561625; cv=none; b=oLd2hnzHR+c4QYh/EbfvhX3Bz4nx2dYd5OJBKmMmjiUVFS8RudapodWtHw61Ett/+Rw0kiT+H74RfIaXlV0+MtLt33q4yL8YKLVsXAU2jRG0vtbwqswUfkSIgatye7kZCbCAm0B4F7aCghQof1/lj6ZBcd+ufHVbByQ7UsBwm5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746561625; c=relaxed/simple;
	bh=2uHDelOTpuwUHnZyb+wEuLKcdCHh024glNfQMm6Wmcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WD1VzDJY8qdRo/F5WhlIOZ4dBguM7XLPCGKv8YTs9LDYpLzoeDLvWcf6kOGBXXTxpxBtUqpBBDim/RQEcXcaiyMaefUbUxI8VKpJoa1XvMyWj8f9FkqloxNTqwZ6uvVxScmZ53LYBA4zLKHECAe6AtOOo3gNwsdA2MzWey0Bars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cLIfZOGJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cLIfZOGJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746561622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JRKNb+znFoP9oDTbjuujsO0CNvdczG6HBT8uBWpcL1c=;
	b=cLIfZOGJ71OX6MEoB60JDhcqazCwiNQos76F/NdeT08ycMCkW+dLV8rA/pyiyhoVvDtwYH
	b8Qn6g6w6qo75rHduXrQYJGQzY8od8EhSrS+z72fCClbRLeWsMVHtUgg3U3vppF+hkX32I
	uvnICdh0jRqRS1aqp9LjSCWv8ad40L8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-yW7LqYt9Mcmx_EcZIw_vQA-1; Tue, 06 May 2025 16:00:21 -0400
X-MC-Unique: yW7LqYt9Mcmx_EcZIw_vQA-1
X-Mimecast-MFC-AGG-ID: yW7LqYt9Mcmx_EcZIw_vQA_1746561619
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-736c1ea954fso3199456b3a.3
        for <fstests@vger.kernel.org>; Tue, 06 May 2025 13:00:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746561619; x=1747166419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JRKNb+znFoP9oDTbjuujsO0CNvdczG6HBT8uBWpcL1c=;
        b=QZ2J0mv4RxwXCnQcvaygo6V7q7PPpT3xRTyAxsKhXCWzB9WpdCfzAg5WQM9oelyom8
         VK/Le9W6gHsHEM6FiiRMWe+vd9+PVosc76pinJkYWZzkAjl5hazhjKXZI385kY4yNxia
         Atv6aXh/h0/M0Vjyvr9KH/KJFQ8NRQfU4BWRuzp6020Y0BxBv4Ol54XhZZNmBxmXRVmY
         L6xiii1xyzVT2ARgLLiwP9pgcROhfZbuAR9vNSNxAUsvLqecc3pYNmJzOjTrdpYw69Yz
         IpJ6MOk92m++NSn4L07OOZh/NmRT4Uyqj0YFvjY2W7atmnW19WWhrK85dwefzSY+tWOq
         +Flw==
X-Forwarded-Encrypted: i=1; AJvYcCVRFfo9lb44DcpQkNSSoH3tqVt7hqXeAT7pNg5qp0ES4UsOMBzFR0mcyxRGYaiGfYG5G8IN7KY7@vger.kernel.org
X-Gm-Message-State: AOJu0YwG2btO+KoyZUUqwZP+lqdTPFbc9J4odNjTidx6Zd8fheHBmZbj
	XI1SZ1ETHZLyZfY4jeM0500VogS9bfFNXT6AtBZx/fl93hEW+MgtVzeMJuV30Xxc9k1jptbfath
	vMnu7N7KM0Rdshuop4DusJprJDSgOET9NZJdiDc39qeZMyan8Rcs0gIw=
X-Gm-Gg: ASbGncsaC6v0yLU0yk6opA23wiTfcmVqYCF7C0Xdi370jds/FG+8LR9l4kS0u1ITkkU
	bj7u8tQtrQ5MegbgEJJZWXvvztztzhHXPfcuADMwvkdBBGARCEVQUX4fnpYdiDvLFnOjeImw1YR
	gTraMYeFSFLfXl552/NGcSTp/AvnTj5lxBYIFvMk4frF9Z+lAteuHw6/Ol88VmAmskabdxHPl5f
	j0JqnbABI0UdaoI8PqWKqVHrBlZ5ZJ6zNQpHTIrlTbxRyUJwMJbNWtHpsc2wjf3542GkQ5SgVR6
	2ekeEA/OrQg8+jGvMKZR06oS4uK/oCCA4pNpFUeBz3kByxMlH0mY
X-Received: by 2002:a05:6a21:920a:b0:1f5:6abb:7cbb with SMTP id adf61e73a8af0-2148be0fa4fmr704928637.23.1746561618627;
        Tue, 06 May 2025 13:00:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK+Ho05Fa3ap5WeM3Co4cLbk4TZQOt1Dz3Lg6V9Vq9wqwbC5JnVP2ZrMDUWGMxVEWIOgCwWg==
X-Received: by 2002:a05:6a21:920a:b0:1f5:6abb:7cbb with SMTP id adf61e73a8af0-2148be0fa4fmr704897637.23.1746561618315;
        Tue, 06 May 2025 13:00:18 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058ded103sm9356625b3a.77.2025.05.06.13.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 13:00:17 -0700 (PDT)
Date: Wed, 7 May 2025 04:00:13 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 11/15] xfs: test zoned GC file defragmentation for
 sequential writers
Message-ID: <20250506200013.jmktymxccn4ezcea@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250501134302.2881773-1-hch@lst.de>
 <20250501134302.2881773-12-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501134302.2881773-12-hch@lst.de>

On Thu, May 01, 2025 at 08:42:48AM -0500, Christoph Hellwig wrote:
> Test that zoned GC defragments sequential writers forced into the same
> zone.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Same review points with patch 10/15

>  tests/xfs/4210     | 124 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/4210.out |   5 ++
>  2 files changed, 129 insertions(+)
>  create mode 100755 tests/xfs/4210
>  create mode 100644 tests/xfs/4210.out
> 
> diff --git a/tests/xfs/4210 b/tests/xfs/4210
> new file mode 100755
> index 000000000000..2984339fd86e
> --- /dev/null
> +++ b/tests/xfs/4210
> @@ -0,0 +1,124 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Christoph Hellwig.
> +#
> +# FS QA Test No. 4210
> +#
> +# Test that GC defragments sequentially written files.
> +#
> +. ./common/preamble
> +_begin_fstest auto rw zone
> +
> +_cleanup()
> +{
> +	cd /
> +	_scratch_unmount >/dev/null 2>&1
> +}
> +
> +# Import common functions.
> +. ./common/filter
> +. ./common/zoned
> +
> +_require_scratch
> +
> +_scratch_mkfs_sized $((256 * 1024 * 1024))  >>$seqres.full 2>&1
> +
> +# limit to two max open zones so that all writes get thrown into the blender
> +export MOUNT_OPTIONS="$MOUNT_OPTIONS -o max_open_zones=2"
> +_try_scratch_mount || _notrun "mount option not supported"
> +_require_xfs_scratch_zoned
> +
> +fio_config=$tmp.fio
> +fio_out=$tmp.fio.out
> +fio_err=$tmp.fio.err
> +
> +cat >$fio_config <<EOF
> +[global]
> +bs=64k
> +iodepth=16
> +iodepth_batch=8
> +directory=$SCRATCH_MNT
> +ioengine=libaio
> +rw=write
> +direct=1
> +size=30m
> +
> +[file1]
> +filename=file1
> +
> +[file2]
> +filename=file2
> +
> +[file3]
> +filename=file3
> +
> +[file4]
> +filename=file4
> +
> +[file5]
> +filename=file5
> +
> +[file6]
> +filename=file6
> +
> +[file7]
> +filename=file7
> +
> +[file8]
> +filename=file8
> +EOF
> +
> +_require_fio $fio_config
> +
> +# create fragmented files
> +$FIO_PROG $fio_config --output=$fio_out
> +cat $fio_out >> $seqres.full
> +
> +# fill up all remaining user capacity
> +dd if=/dev/zero of=$SCRATCH_MNT/fill bs=4k >> $seqres.full 2>&1
> +
> +sync
> +
> +# all files should be badly fragmented now
> +extents2=$(_count_extents $SCRATCH_MNT/file2)
> +echo "number of file 2 extents: $extents2" >>$seqres.full
> +test $extents2 -gt 200 || _fail "fio did not fragment file"
> +
> +extents4=$(_count_extents $SCRATCH_MNT/file4)
> +echo "number of file 4 extents: $extents4" >>$seqres.full
> +test $extents4 -gt 200 || _fail "fio did not fragment file"
> +
> +extents6=$(_count_extents $SCRATCH_MNT/file6)
> +echo "number of file 6 extents: $extents6" >>$seqres.full
> +test $extents6 -gt 200 || _fail "fio did not fragment file"
> +
> +extents8=$(_count_extents $SCRATCH_MNT/file8)
> +echo "number of file 8 extents: $extents8" >>$seqres.full
> +test $extents8 -gt 200 || _fail "fio did not fragment file"
> +
> +# remove half of the files to create work for GC
> +rm $SCRATCH_MNT/file1
> +rm $SCRATCH_MNT/file3
> +rm $SCRATCH_MNT/file5
> +rm $SCRATCH_MNT/file7
> +
> +# fill up all remaining user capacity a few times to force GC
> +for i in `seq 1 10`; do
> +	dd if=/dev/zero of=$SCRATCH_MNT/fill bs=4k >> $seqres.full 2>&1
> +	$XFS_IO_PROG -c "fsync" $SCRATCH_MNT/fill >> $seqres.full 2>&1
> +done
> +
> +#
> +# All files should have a no more than a handful of extents now
> +#
> +extents2=$(_count_extents $SCRATCH_MNT/file2)
> +_within_tolerance "file 2 extents" $extents2 3 2 -v
> +extents4=$(_count_extents $SCRATCH_MNT/file4)
> +_within_tolerance "file 4 extents" $extents4 3 2 -v
> +extents6=$(_count_extents $SCRATCH_MNT/file6)
> +_within_tolerance "file 6 extents" $extents6 3 2 -v
> +extents8=$(_count_extents $SCRATCH_MNT/file8)
> +_within_tolerance "file 8 extents" $extents8 3 2 -v
> +
> +status=0
> +exit
> diff --git a/tests/xfs/4210.out b/tests/xfs/4210.out
> new file mode 100644
> index 000000000000..488dd9db790b
> --- /dev/null
> +++ b/tests/xfs/4210.out
> @@ -0,0 +1,5 @@
> +QA output created by 4210
> +file 2 extents is in range
> +file 4 extents is in range
> +file 6 extents is in range
> +file 8 extents is in range
> -- 
> 2.47.2
> 

