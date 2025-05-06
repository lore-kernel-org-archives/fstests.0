Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF511862
	for <fstests@vger.kernel.org>; Tue,  6 May 2025 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746561671; cv=none; b=olj9Y6ZtdYD4/UBWrmA5zKHQoHyRqtz9rEUgAoc6bdBTYXws6iBh5ioLR8eBiHOX1J4RQApxuaZpULUJpqGTZ+sSJTetH3diedI37Hyz6ES0OX6Ot05PSb76b9N2OleLZInr4xyVS6cnwcsIzCUVqnZGCwkP3I4jWxp02BC28eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746561671; c=relaxed/simple;
	bh=e9Nx29McDIOaH1b3XML0MNUycb7rPwVRyUHkArzgfhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mn4Vl74z/GmShrBkkEuE+XaTegHYrw8PuWLNZ+QWO8ZngXPq3GqFxnv0cJUZLFCpJdoqdfg560zmJqfFYfjg7zYhPJNPJyC6DMHX9iT9FS93RCpCfx23JCgBhTmeUPdbuRcF8OvQBXGrwpY17EXoyiX/Z43/6wFB0P54sYgKKJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PGxnVQuA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PGxnVQuA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746561668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XyjqCp34h880u9gSBdSkyO+ZNrvrvM19O7+yIgz8NBA=;
	b=PGxnVQuARWhJ+vSz9OQsrECEnNuUCN6NItRKYomakSZh8hrS5vHOFqVZWj1npZWjC2jmwN
	tSTze3ZKzLqGbNAZlQyIhvw0f3oLFXqBHnnJ5g7H80gYTGZHw08MALCld3Rc99Fm5Xdvj7
	K1iOhkqACOpML6Ig4IvwPkrT3RtgFfU=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-hc7bkXqXPXiylLRgFIZUrA-1; Tue, 06 May 2025 16:01:07 -0400
X-MC-Unique: hc7bkXqXPXiylLRgFIZUrA-1
X-Mimecast-MFC-AGG-ID: hc7bkXqXPXiylLRgFIZUrA_1746561666
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-736b431ee0dso4472662b3a.0
        for <fstests@vger.kernel.org>; Tue, 06 May 2025 13:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746561666; x=1747166466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XyjqCp34h880u9gSBdSkyO+ZNrvrvM19O7+yIgz8NBA=;
        b=jqNwNit30zkhTuGzi8Y13r2Hedk0cdyZsyFpuYZXjr/tmAi7ftwm9Qpk8T5inec5PL
         An5PcSq9ixltNcZMWCE7wZGqkEesvySSOBV/ELmRzQFqh8tfq7GQfkFjUAhSFPWZXqPm
         rw4j52098sNmu5gAp0vu1ANNS/JJ+qtE8VRVQk1BrefYqwxTTa8CHZdLpg21kpK+vaPM
         5HFR8akelQNxGtwRorw1zoLiSqjX7SUMtl1fqF9H+P4E5RJlln7RCLotfdNEEx0y3XGP
         R8FYm7OpoHb3/QiNS9rvwAOq3KXtBH3HAQW04kyjkA5NOpXssrFKzxVbxXAnK4KIbgVE
         8gSw==
X-Forwarded-Encrypted: i=1; AJvYcCUBIkSsqF9mZgVQAPeR117cK8H1ZrKMjBt2ERQZnbi119VOmnv2QtV47BnpGEqSmYg5p1ANnfRo@vger.kernel.org
X-Gm-Message-State: AOJu0YzEC55SWycsM+dHYQxZI5ZzidYHZfI/wZn8jkYHYlmEyENOunZ6
	yaUh+MOihiWev7IaetieJ8UBoc/iwgrevuqMRYawT4fs6btqRg6vN8G5FvmaVuYxwM7Dpd/3XQh
	hH/wyCAgXPcFhfveopOA0WESEVjTMSeVjY5nQwsSfx1smUlnLjhFmYpc=
X-Gm-Gg: ASbGncs1szrKkyar12D9dQex8jVWe3f42/yl57sCOGlNYVChoayaIXKR6f9B7Q6YaL4
	1JqDGQx0VNAlo+nDqcbknAeBEUoinPs3ZSCtjGcdAbjiMgOiHDdBepELSUz/nIU3+k/6l4odCrp
	lMkji14/25GRaKobmdJedw7E8gK/3PRhVGdvCv2c6NfrcwUT7TNOMjTKV0OCace3VxgOuPCyVsO
	ZWBH5KeSGDtMm1KseadSzRq7k+bAZvbvVOVT0uz5EmhaUbmMZQhJSSOKGWvkKGEWfljrPlomOKG
	27emphxB/kq2M/PXOu0vv2O+Ia06x7DUNb6V7GwZAsiCDTQ2ZqHp
X-Received: by 2002:a05:6a00:3003:b0:73e:2d76:9eb1 with SMTP id d2e1a72fcca58-7409cf01a8cmr538077b3a.10.1746561666222;
        Tue, 06 May 2025 13:01:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK4bbsFQaHaG5GxZVx6Mk732R6xm4F5U9eFxuF7SWICRrPkslBKbVbTgCVSTkzNJ4uBtTWCA==
X-Received: by 2002:a05:6a00:3003:b0:73e:2d76:9eb1 with SMTP id d2e1a72fcca58-7409cf01a8cmr538035b3a.10.1746561665830;
        Tue, 06 May 2025 13:01:05 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74059020dedsm9704252b3a.91.2025.05.06.13.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 13:01:05 -0700 (PDT)
Date: Wed, 7 May 2025 04:01:01 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 12/15] xfs: test zoned GC file defragmentation for random
 writers
Message-ID: <20250506200101.6u4ww65kpu34eqlg@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250501134302.2881773-1-hch@lst.de>
 <20250501134302.2881773-13-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501134302.2881773-13-hch@lst.de>

On Thu, May 01, 2025 at 08:42:49AM -0500, Christoph Hellwig wrote:
> Test that zoned GC defragments sequential writers forced into the same
> zone.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

Same review points with patch 10/15

>  tests/xfs/4211     | 129 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/4211.out |   5 ++
>  2 files changed, 134 insertions(+)
>  create mode 100755 tests/xfs/4211
>  create mode 100644 tests/xfs/4211.out
> 
> diff --git a/tests/xfs/4211 b/tests/xfs/4211
> new file mode 100755
> index 000000000000..9679da72a4eb
> --- /dev/null
> +++ b/tests/xfs/4211
> @@ -0,0 +1,129 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Christoph Hellwig.
> +#
> +# FS QA Test No. 4211
> +#
> +# Test that GC defragments randomly written files.
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
> +rw=randwrite
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
> +#
> +# Fill up all remaining user capacity a few times to force GC.
> +#
> +# This needs to be a very large number of larger zones sizes that have a lot
> +# of OP for the small file system size
> +#
> +for i in `seq 1 200`; do
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
> diff --git a/tests/xfs/4211.out b/tests/xfs/4211.out
> new file mode 100644
> index 000000000000..348e59950a47
> --- /dev/null
> +++ b/tests/xfs/4211.out
> @@ -0,0 +1,5 @@
> +QA output created by 4211
> +file 2 extents is in range
> +file 4 extents is in range
> +file 6 extents is in range
> +file 8 extents is in range
> -- 
> 2.47.2
> 
> 

