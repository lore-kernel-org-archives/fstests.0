Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FFA24B28
	for <fstests@vger.kernel.org>; Tue,  6 May 2025 19:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746561139; cv=none; b=DiBMzjHZkX+s0Q6w+KKdNZDQKp22HgIbcQaHaRvcI9XkcWIIn09RVxtec8iEwnE8yaqIGYayK55IG4fLBYZnfpuTgqDP/HIsI5vmdb99Sbubgzs8/bx/9/Dpzn5yby1LCz6uyTVWy2fvqn9khN5tqOD/OoXqIvM6KIRrhCbHUP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746561139; c=relaxed/simple;
	bh=PaPDZVQJdH6x3nG/gLHfslbfMF1fNOGEzzHak1XD6ak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7SB/B/GldbrcisbF1IQIpOkqVAiZFEtLMVy3Z7y2tkAQL48T9/JPbYbvENnzxNXKE8YfQc8EfeNFqFSpeUiCJ+SR4MxeeTukJPqUMqb2ghbfYdg+FM8p5YGKydRy1ZfbZjBUjDjcIOzOfskYylnxnOp2/3eT06UiuP4uA06s3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RoVZjtJZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoVZjtJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746561136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dl4uG7nduGgixZVnZZm5Y9BUK6yJE2KDwcHDY3c99MQ=;
	b=RoVZjtJZqCjbkysHnes0MBskFx/bvjYikJIQVPIelSii42diZR8+SiEQXI+YdKaRaTlTjU
	04sV4LQq+Lez/kIEd2kS0uk/AX8orELtLX0m64kQv4RwFSBpCx2DaIYDFD8GF1kIqdOoBX
	mbHEkDosX8uAGvwnbKKNeNuIKkgFgkA=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-Ou3lZCmnNfSo4nJVZDP6YQ-1; Tue, 06 May 2025 15:52:13 -0400
X-MC-Unique: Ou3lZCmnNfSo4nJVZDP6YQ-1
X-Mimecast-MFC-AGG-ID: Ou3lZCmnNfSo4nJVZDP6YQ_1746561131
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-22aa75e6653so44131865ad.0
        for <fstests@vger.kernel.org>; Tue, 06 May 2025 12:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746561131; x=1747165931;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dl4uG7nduGgixZVnZZm5Y9BUK6yJE2KDwcHDY3c99MQ=;
        b=IClLeXtrAoBa41fqz3FXc69SWGAw9k3y+Og6HQ/EdrDlw/mGO/asfrcLrxzGDlV2Yf
         SetmG5frMpqCKt+qhYiGPTnJK54Dzg7dJApIerOU41Nneg4FIcHUQQuJ/11/SkV6Rjcu
         NTPXTy4fxWUGZc3Og8/GURD8ipG/5YAsft5mPBZptilblZRCfDyju0Ra6XvLj1J6cWWI
         TfCFPKlobCifnBygXCDaQF09EOk++h/cG2tcRUNv4+MG7+jq5869FLHoezfZUrJCHNmT
         M249tDjC7i8xhswwzAC9PREq/BnCwgTzt7W3887dh1yVLzcgd74U8hbWIDfU5TobDy0y
         NyDw==
X-Forwarded-Encrypted: i=1; AJvYcCX4reQja29sjzPPaBBAUWRRF5O7aixZ7JZhWmZz5PvigoEzVm0bPT1fxJ0vreorGFxfMRcfl6zH@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf54/lQqe0mTDUZSCZtpv2I7dI2VfvCkn77iKjiHCV9PEE65C8
	MNjhMEi8gLTincksHt5I8zqAbMpHm75l8MsdEMpYUsyjLI6B+YeBswJs5vtNoOHkQjpd1NEq0x/
	oekUHO/AodK9heXCe7+PrFD6Zj8OaduioYPPAxCg6EbkB50EPv5iUJYo=
X-Gm-Gg: ASbGnctM4wZw5Bxpt5ha+1s2pX3MsEu0EXpSYGTKw7AKtAMxCK9sHnXY52KXnPzL4OY
	0BWppofQKy0xBgDg0IDZYgFfxF1tGV3lAbSAoyfE0VN9Cser5TdFniriOC9Rb5wDyDVd6kr9FpE
	h9p8SKexCvVogopaMolUVVSyb9VNQFzvpy4G/+NY2rkdbcZxJ0jbaP2o86hzlL9cuF3QBChkVhx
	tLUt4I0d69qIsSIZLLjy2MzZoiw9qafOI3cfwoed+nvBYq22P5T9jDigAS4Zn4jNP6/kBR9OTTV
	qCAs+aY2E82J1O2KLtU3yFPKtFpU1wtLGRkpa5KX72pWKbyhMbV5
X-Received: by 2002:a17:903:3ba4:b0:22e:4d50:4f58 with SMTP id d9443c01a7336-22e5ecae63emr6522475ad.31.1746561131045;
        Tue, 06 May 2025 12:52:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyj0q1yCppfcIDU5BuDEnlGOw3XxRdA3ec82mHrLuK3/maFkgYdbkwqOREHYBFOE31TELSGQ==
X-Received: by 2002:a17:903:3ba4:b0:22e:4d50:4f58 with SMTP id d9443c01a7336-22e5ecae63emr6522215ad.31.1746561130698;
        Tue, 06 May 2025 12:52:10 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e1521fbe2sm77660505ad.139.2025.05.06.12.52.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 12:52:10 -0700 (PDT)
Date: Wed, 7 May 2025 03:52:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Zorro Lang <zlang@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
	Hans Holmberg <hans.holmberg@wdc.com>, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 08/15] xfs: test zone stream separation for two direct
 writers
Message-ID: <20250506195205.hqrkl3wvwpgal2dq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250501134302.2881773-1-hch@lst.de>
 <20250501134302.2881773-9-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250501134302.2881773-9-hch@lst.de>

On Thu, May 01, 2025 at 08:42:45AM -0500, Christoph Hellwig wrote:
> Check that two parallel direct sequential writers are separated into
> different zones.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/xfs/4207     | 79 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/4207.out |  3 ++
>  2 files changed, 82 insertions(+)
>  create mode 100755 tests/xfs/4207
>  create mode 100644 tests/xfs/4207.out
> 
> diff --git a/tests/xfs/4207 b/tests/xfs/4207
> new file mode 100755
> index 000000000000..edc22da73bfb
> --- /dev/null
> +++ b/tests/xfs/4207
> @@ -0,0 +1,79 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Christoph Hellwig.
> +#
> +# FS QA Test No. 4207
> +#
> +# Test that multiple direct I/O write streams are directed to separate zones.
> +#
> +. ./common/preamble
> +_begin_fstest quick auto rw zone
> +
> +_cleanup()
> +{
> +	cd /
> +	_scratch_unmount >/dev/null 2>&1

Same... remove this _cleanup if the "unmount" isn't necessary.

> +}
> +
> +# Import common functions.
> +. ./common/filter

You don't use any filter helpers in common/filter ...

> +
> +_require_scratch
> +
> +_filter_rgno()

I've seen this function in many cases of this patchset, how about move it
to common/filter or common/xfs ?

> +{
> +	# the rg number is in column 4 of xfs_bmap output
> +	perl -ne '
> +		$rg = (split /\s+/)[4] ;
> +		if ($rg =~ /\d+/) {print "$rg "} ;
> +	'
> +}
> +
> +_scratch_mkfs_xfs >>$seqres.full 2>&1
> +_scratch_mount
> +_require_xfs_scratch_zoned 3
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
> +size=1m
> +directory=$SCRATCH_MNT
> +ioengine=libaio

_require_aio?

> +rw=write
> +direct=1

_require_odirect ? or _require_aiodio?

> +
> +[file1]
> +filename=file1
> +size=128m
> +
> +[file2]
> +filename=file2
> +size=128m
> +EOF
> +
> +_require_fio $fio_config
> +
> +$FIO_PROG $fio_config --output=$fio_out
> +cat $fio_out >> $seqres.full
> +
> +# Check the files only have a single extent each and are in separate zones
> +extents1=$(_count_extents $SCRATCH_MNT/file1)
> +extents2=$(_count_extents $SCRATCH_MNT/file2)
> +
> +echo "number of file 1 extents: $extents1"
> +echo "number of file 2 extents: $extents2"
> +
> +rg1=`xfs_bmap -v $SCRATCH_MNT/file1 | _filter_rgno`
> +rg2=`xfs_bmap -v $SCRATCH_MNT/file2 | _filter_rgno`
> +if [ "${rg1}" == "${rg2}" ]; then
> +	echo "same RG used for both files"
> +fi
> +
> +status=0
> +exit
> diff --git a/tests/xfs/4207.out b/tests/xfs/4207.out
> new file mode 100644
> index 000000000000..5d33658de474
> --- /dev/null
> +++ b/tests/xfs/4207.out
> @@ -0,0 +1,3 @@
> +QA output created by 4207
> +number of file 1 extents: 1
> +number of file 2 extents: 1
> -- 
> 2.47.2
> 
> 

