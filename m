Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECC32877C2
	for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760727405; cv=none; b=DkP8dhc1QSAv4nUS2+2J9fQyo6ZWeJdDJHhPdHvsg1uq+K2TWwEg5P7mZIvuDMrqCUXvo7QGSmH2GryZnUQaiVEGgYVE59a8ybeeK8u3LTsxSTX6F69Rq151RqcuV1ve0lB5o2KouPyPNklLKNmyb0QDXP1lpjpTzaomtaWPezw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760727405; c=relaxed/simple;
	bh=d5EYSvZWE21MAW/5ducNnSAuwHg4mPYcU9kcJd5FPu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKVxqed4oak+dQGGqEA0fxN9x3h0TMZoTnA4H5c+frUhU+/DGeL5cc9aoEkLe/kvXhQM1mZwzPGdJD7iI+6QXSCoBbtUKzPgeThxZdHhQwXPrlndyZrQgjPvTYWofY3h0o1WhAWL5UoUqMk4SywUqyt58wJ4MlzP5vzPlvCY1YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N30GSl5U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N30GSl5U"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760727403;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uYprDHVp8YGKTFNY5McgCFcGhbJLnpr1suYb15I8Fy4=;
	b=N30GSl5U8LtLSeTIKYJIftIMyGYQU5u/hER4mLHUXJATGD5pB6kd7AsOrUs4Lw7q0p6XOb
	WLNHhwGLDx6tC4Pv2NHsu1E+clnQeQmDs8PPSj//WZNndyp2geV0OB4JGwdRZDLQx6tq8w
	XgymwXzOuKYyoHHHekXssXX88hW4Etw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-495-JHv_LdsnMVmFWisENRsIfw-1; Fri, 17 Oct 2025 14:56:41 -0400
X-MC-Unique: JHv_LdsnMVmFWisENRsIfw-1
X-Mimecast-MFC-AGG-ID: JHv_LdsnMVmFWisENRsIfw_1760727401
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-26983c4d708so19387415ad.3
        for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 11:56:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760727400; x=1761332200;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uYprDHVp8YGKTFNY5McgCFcGhbJLnpr1suYb15I8Fy4=;
        b=OkjDTXiSKl9WAxudWlj1hIslwxqslXnqaGbdNbeDNTd5yrpNfI3T8bygTExOtog4zF
         tN+oAUJcsYnovRu4QyTAduJtfqTWjgQxx/KTfEPuag4GjI8mL/NClxBa7467sr/Nq+JU
         6PDUkrI1SyfxpZ+ipeBXcgttwuK05rhg01hlYmEYGadhMAy6gGIt7MfAdX167g6uz4AY
         MxfIoOBMQ47E8/fWawMjT5MiDze+FpqvhqG8vZIJg310cCkM2p3EuKA4EYg+sJL+zE8c
         ANgwgT86R2JHZ2DkfmNlj/50FvXLC6mo9o08wQfIEHJ7Jsza7xL19gCemFveri06Gl0l
         YdVg==
X-Forwarded-Encrypted: i=1; AJvYcCXAR/6wNL7v6HICjkVPRVeT+JSIM43I8MbqV3XNHpMoLLypjjEcDUkvcCJAusSNyWEV7b3uc7W7@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhg0HLTA8YbptzQOmcbt+Cp/VCbMIeXcbXTyPl3dsIwWxDEcjz
	Iz5wpMy7vjb6TdDHHa2QyRxaEMY+o9VeUr1giXEXyRjX7SNKNtUL8IVcRjJ7VQG4ggRxulYUTJ1
	X/CWYsKa3XDSC2yg1cE2/5C2ynFLtMyksYqLyTK3RbU734fc/yodxSut6u4E=
X-Gm-Gg: ASbGncveAbw7adS0+deWJkxirloCuq52O+xC4RNpf0gLuXOextPzh78//3/8aL0A7QB
	NZBDJeogWL9QEQEucanIFqsNhN9g20uVuXHEEFiVqlAmdOKNI0jfhG1RUNN5Ol1a5mM3YaSYEt8
	L24ygumXXXXlVjqWy5zraOT59RJvcPLZOwJPgmPgzcCLKBtF4zxK/ceL1rwAKVBkeTGAQo2aLBR
	rXcD0vHxN0niXT9V3GTrijqZw3JFTQyTFmoI2o0wdJ1yjMeGq8F1QmRBUGTwBLHbILvqtS2Q/MU
	pwbnMQTc87Q7z0sDG29Txd6ec+oBRRbuUqMSKXXsLA8T6Q+CSGbmOX28uzz2/aqFN6s/XxX+Sya
	Lx0k3yN0oQPVpXALOmufrkgOirNMUlKoQKdmwGUE=
X-Received: by 2002:a17:903:8c6:b0:28d:18fb:bb93 with SMTP id d9443c01a7336-290c9c8968cmr56491715ad.7.1760727400544;
        Fri, 17 Oct 2025 11:56:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFKCO/8OEf5q9MtiPSZhBTjjXT9lJOMBbtv23Dt9GU9oMRJ+VlU3uAZY3eoFQ0b7rxF/ekGBw==
X-Received: by 2002:a17:903:8c6:b0:28d:18fb:bb93 with SMTP id d9443c01a7336-290c9c8968cmr56491375ad.7.1760727400090;
        Fri, 17 Oct 2025 11:56:40 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29246ffeec3sm2531175ad.52.2025.10.17.11.56.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 11:56:39 -0700 (PDT)
Date: Sat, 18 Oct 2025 02:56:33 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v5 3/3] generic: basic smoke for filesystems on zoned
 block devices
Message-ID: <20251017185633.pvpapg5gq47s2vmm@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251016152032.654284-1-johannes.thumshirn@wdc.com>
 <20251016152032.654284-4-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016152032.654284-4-johannes.thumshirn@wdc.com>

On Thu, Oct 16, 2025 at 05:20:32PM +0200, Johannes Thumshirn wrote:
> Add a basic smoke test for filesystems that support running on zoned
> block devices.
> 
> It creates a zloop device with 2 conventional and 62 sequential zones,
> mounts it and then runs fsx on it.
> 
> Currently this tests supports BTRFS, F2FS and XFS.
> 
> Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  tests/generic/772     | 43 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/772.out |  2 ++
>  2 files changed, 45 insertions(+)
>  create mode 100755 tests/generic/772
>  create mode 100644 tests/generic/772.out
> 
> diff --git a/tests/generic/772 b/tests/generic/772
> new file mode 100755
> index 00000000..10d2556b
> --- /dev/null
> +++ b/tests/generic/772
> @@ -0,0 +1,43 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Wesgtern Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 772
> +#
> +# Smoke test for FSes with ZBD support on zloop
> +#
> +. ./common/preamble
> +. ./common/zoned
> +
> +_begin_fstest auto zone quick
> +
> +_cleanup()
> +{
> +	_destroy_zloop $zloop

        cd /
        rm -r -f $tmp.*

> +}
> +
> +# Modify as appropriate.
> +_require_scratch
> +_require_scratch_size $((16 * 1024 * 1024)) #kB

_require_scratch_size contains _require_scratch.

> +_require_zloop
> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount
> +
> +mnt="$SCRATCH_MNT/mnt"
> +zloopdir="$SCRATCH_MNT/zloop"
> +
> +mkdir -p $mnt
> +zloop=$(_create_zloop $zloopdir 256 2)
> +
> +_try_mkfs_dev $zloop >> $seqres.full 2>&1 ||\
> +	_notrun "cannot mkfs zoned filesystem"

Does this mean the current FSTYP doesn't support zoned?

As this's a generic test case, the FSTYP can be any other filesystems, likes
nfs, cifs, overlay, exfat, tmpfs and so on, can we create zloop on any of them?
If not, how about _notrun if current FSTYP doesn't support.

> +_mount $zloop $mnt
> +
> +$FSX_PROG -q -N 20000 $FSX_AVOID "$mnt/fsx" >> $seqres.full
> +
> +umount $mnt

Please make sure the zloop device is unmounted and destroied in _cleanup, due
to someone might kill the test process suddenly.

Thanks
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

