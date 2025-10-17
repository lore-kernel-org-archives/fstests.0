Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5504221C9EA
	for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713074; cv=none; b=gvcw0gkpEXx1QhRXbxA/z4PAEd9BYg5dGUOb2gJztiDziNh/ZvNwlJWx69ndfR+AtUQ6tJuyrw/Wc1iKIyTcFFgUQkkbT+jJtfJC0UpO4UUFhDnp251uewLG7pR+iqtPAevBj6upq7cT9ppEjpqN5UOp3j3HmLVDMGJl5dgHtPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713074; c=relaxed/simple;
	bh=L0bFPxDcqgJpPxvTaEYcFqpIamt+96UvErK7XQwmfBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfRYPPc663fQHA+IPVfCwbZ6y7UJ6ZmiTQfA61r56rQCnGtuPRntgnmadZqywwr2GPU9VdsUeuShnMgl12fjeZjVmPQMiWpHgLrh0uwKcBezt/M8QIld64AdDtNaxfhq/wMwRS2qTgd7mA16ZXBe+me9YmxSEg4+X/vIL7x1wAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EQj8lZem; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EQj8lZem"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760713071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0CWIznKk8NO+pqJ/eP683zeyfH/gjzfyXn71NVQmDXo=;
	b=EQj8lZemU1Lc9Z+Rwy/YzL0MpXaUMH7BXQs1GUycRotw/nF3h+RkJzRNe7dbDLbMkoNOiB
	88D3dQaIUH5VYAIj1A6gZtSnKC2tuSF04dDsmyRV/V1FeSLYVma4OeA/EXHRgntbm8Gi5+
	b6x+l59XuEGBQ98/d871M/dwvvWmko4=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-TONOZEgbObqIaf8E3nOxMw-1; Fri, 17 Oct 2025 10:57:50 -0400
X-MC-Unique: TONOZEgbObqIaf8E3nOxMw-1
X-Mimecast-MFC-AGG-ID: TONOZEgbObqIaf8E3nOxMw_1760713069
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7a144677fd9so3626241b3a.3
        for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 07:57:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760713069; x=1761317869;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0CWIznKk8NO+pqJ/eP683zeyfH/gjzfyXn71NVQmDXo=;
        b=aRHo//9JHAIXQgT1NsGluopSDyrcotYuwB4YHeTw6A8uQnYKavAQG6ax/ICBjp0BT0
         8d7mP9awCj5FnXCNPjHgUNz5OsBSjVb8bkbYusmIeV2SLHNq6iA/QKUyo5lw87jBVp7J
         szf60RYwqpPeinm7CSxA93aYvfygy8Bh5rbdZphwH1kvzYPLudhbNkXlQHyTA2iFf4s1
         obcUCqyG7A/t+A9GaO0FeYWV4p3+9hjerdvuIJWhovW6r+mDRrCSAIkofoIp+OPD2o4l
         MJnDeNC2CewhvU+/QTjMzWWugP+mp3kqfHkG90yKn9jNFEQelxGRNPq4y963lW4cvQn9
         KZmQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgCr5+O0pudqGKfQgdHp7g5dT901NcKrkLVkL0GR9r1eAbOng21xuDLH9xQBFTMHVqdUS70l3a@vger.kernel.org
X-Gm-Message-State: AOJu0YyB8o3dbPiPXH6dtTkjOvjcRltNhVNwkhgt+SSjAPuYGhb8yoXV
	Djc8mgiO5qC4+OuvhIPols0Qi3yY6oHMrBk2zqqdiW1mHTnFf9w9x0LnfWNWGV2rR2/fLAWU9Rw
	NreucBF3ZUdR/966F0qgTxOGgWJA3vea7NrPMyBV34RHBqdq8Mg5imIXpAsg=
X-Gm-Gg: ASbGncvNIRpNrnznyC3XBiePwyt4XneKhYPk+qQ1Yk3yMf/EYeWvnfwStkGJIjYjrvO
	bTvk5uB78e2q9D4ubViP91b0iABUAzr5uemwlcG2/KROSVUge/MqfSxP7QEzTOnHyPMUn5NBeO0
	E+6bc/mWCRggJzccyvYfq0bkrqGNZplJoKGr5Obo9wfBgNcrQ3LUZXmUeqO7BpJb9b1k2SmRDAP
	GHFp0ejJxQT1kQiI1gcD9Ray+QImHApwtXuPICh9gncjE4YoeSKWffA5Em+YOLz5l9F4XoREirG
	FBOFu/AHJ9m8YcEcBh1qpCNDxcEyUnm7SLb6vjSoNoCMVgJVdC7MPlOgPHXBFsrlfisYgIeIQzH
	COis5jSX/K09/W/gkFFEAC/Wb3vXS5wyspSAHeJw=
X-Received: by 2002:a05:6a20:72a2:b0:334:8002:740f with SMTP id adf61e73a8af0-334a85bacd8mr5263222637.41.1760713068700;
        Fri, 17 Oct 2025 07:57:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEV8bycvyQSRyozXfQHV3RbBixEHjX0DtEj7uEL8WhTY3bj+WlE9auL1ONIzq/ZrxZgb2EPDQ==
X-Received: by 2002:a05:6a20:72a2:b0:334:8002:740f with SMTP id adf61e73a8af0-334a85bacd8mr5263181637.41.1760713068196;
        Fri, 17 Oct 2025 07:57:48 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76b67fa4sm2528a12.33.2025.10.17.07.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 07:57:47 -0700 (PDT)
Date: Fri, 17 Oct 2025 22:57:42 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] generic: basic smoke for filesystems on zoned block
 devices
Message-ID: <20251017145742.thvvkyk7qafi4aju@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251006132455.140149-1-johannes.thumshirn@wdc.com>
 <20251006132455.140149-3-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251006132455.140149-3-johannes.thumshirn@wdc.com>

On Mon, Oct 06, 2025 at 03:24:55PM +0200, Johannes Thumshirn wrote:
> Add a basic smoke test for filesystems that support running on zoned
> block devices.
> 
> It creates a zloop device with 2 sequential and 62 sequential zones,
> mounts it and then runs fsx on it.
> 
> Currently this tests supports BTRFS, F2FS and XFS.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  tests/generic/772     | 52 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/772.out |  2 ++
>  2 files changed, 54 insertions(+)
>  create mode 100755 tests/generic/772
>  create mode 100644 tests/generic/772.out
> 
> diff --git a/tests/generic/772 b/tests/generic/772
> new file mode 100755
> index 00000000..412fd024
> --- /dev/null
> +++ b/tests/generic/772
> @@ -0,0 +1,52 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Wesgtern Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 772
> +#
> +# Smoke test for FSes with ZBD support on zloop
> +#
> +. ./common/preamble
> +_begin_fstest auto zone quick
> +
> +_cleanup()
> +{
> +	if test -b /dev/zloop$ID; then
> +		echo "remove id=$ID" > /dev/zloop-control
> +	fi
> +}
> +
> +. ./common/zoned
> +
> +# Modify as appropriate.
> +_require_scratch
> +_require_scratch_size $((16 * 1024 * 1024)) #kB

_require_scratch_size contains _require_scratch, so you can remove _require_scratch.

Can you explain why we need 16GiB free space for these parameters?

> +_require_zloop
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +


> +last_id=$(ls /dev/zloop* 2> /dev/null | grep -E "zloop[0-9]+" | wc -l)
> +ID=$((last_id + 1))
> +
> +mnt="$SCRATCH_MNT/mnt"
> +zloopdir="$SCRATCH_MNT/zloop"
> +
> +zloop_args="add id=$ID,zone_size_mb=256,conv_zones=2,base_dir=$zloopdir"
> +
> +mkdir -p "$zloopdir/$ID"
> +mkdir -p $mnt
> +echo "$zloop_args" > /dev/zloop-control
> +zloop="/dev/zloop$ID"

About this part, can we have a common helper (e.g. _create_zloop_device) which
can get a free zloop number and create a zloop dev, then output the device name
if it's created successfully ?

> +
> +_try_mkfs_dev $zloop 2>&1 >> $seqres.full ||\
> +	_notrun "cannot mkfs zoned filesystem"

As this's a generic test case, I'm wondering if the zloop device can be created
on any FSTYP? For example if FSTYP is nfs or cifs or overlay or tmpfs or exfat
and so on.

> +_mount $zloop $mnt
> +
> +$FSX_PROG -q -N 20000 $FSX_AVOID "$mnt/fsx" >> $seqres.full

Do you care about the return status of fsx? If so, you can use _run_fsx or run_fsx.

> +
> +umount $mnt

Please make sure "the $mnt is unmounted" and "all zloop devices are removed"
in _cleanup.

Thanks,
Zorro

> +
> +echo Silence is golden
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/772.out b/tests/generic/772.out
> new file mode 100644
> index 00000000..98c13968
> --- /dev/null
> +++ b/tests/generic/772.out
> @@ -0,0 +1,2 @@
> +QA output created by 772
> +Silence is golden
> -- 
> 2.51.0
> 

