Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF6436D50C
	for <fstests@vger.kernel.org>; Sat, 22 Nov 2025 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763800620; cv=none; b=W0pUjdPXsMzFIkpcBnpHbhw6CvYu1pB3QxbQfDAFw0vuQov7QxDOi/N4wiWS+/R9aSJ43Hdn0s3lb0dcyi7BGIre1l39DXywZiM6iVyGDBSTulilj8iLEt70fB2yykNHKdNV1GbfFNUvbNqmcfVSOOo/gRe0a/IUzmJhw5Ifcdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763800620; c=relaxed/simple;
	bh=ztgXdhjxtjkovT48jBmQmJ1bQCaLWwKJ31UmH8BuFs4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNkm+EhkmjcSU6jl8RsOocB6ymNr/055U/LhJ+1GvzjYIhqrODri2BuPnE/dN8pnK9T3txFYJHLJtjgOGVnb7oUZPtYfgEdzsSme/PrqjcsaK/+joXAeezKQjpjynXTtjTbXIAzQ4elt7Nk8YOzJF1jp4DMcOqCmZzMPIWmWEHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g2mG70mm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WdQD7aD8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g2mG70mm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WdQD7aD8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763800617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N2zqQPxfD8wBoqVPNB/Ddc7v1WO9JhWHYtXYtFICkgs=;
	b=g2mG70mmV3YjK+3BqtgI7CFJlABvKvTerGbGTSUyczbZM5OIFO/A6jvj92rRnc+q59Wfo/
	BRBod+fGiaH5h6BYBUvfPItKOD/dhq4zCWMBuJr8Htiw4MvxlfOUE+qtSJsYsupsWdHN1q
	l4+Zwshc622J8d5p9fBIGOsTZ8rLTy4=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-qroQawqLM4-vTaiAuwnJTw-1; Sat, 22 Nov 2025 03:36:53 -0500
X-MC-Unique: qroQawqLM4-vTaiAuwnJTw-1
X-Mimecast-MFC-AGG-ID: qroQawqLM4-vTaiAuwnJTw_1763800612
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-297df52c960so77846755ad.1
        for <fstests@vger.kernel.org>; Sat, 22 Nov 2025 00:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763800612; x=1764405412; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N2zqQPxfD8wBoqVPNB/Ddc7v1WO9JhWHYtXYtFICkgs=;
        b=WdQD7aD8W++Pu6sTimx8FKNR78HkD4FB/HqeksLAeuv4LN10VR+MQYxy/1bO3CFkaB
         v2Z1jge4jQ44cZDS0EF/YZH0RrJeAA9jbGNruk7qCBhxziE3LteRJCTVmQrOoDRS/xWs
         xdsuIALmxxrxj8pjAsNKV6m+qteh+U2wn4l1YR3/6rTTrh1PAbGDmp5pgCm37QvTB5MB
         obd0nAGtnY2LAqhLxVWgz/PrWIsPbXdCy3A70Fdlt4kz8EJmyafcXXdq4moMcjKWHTpZ
         p6jb6n95nyPbAbqiwSmyOzYN23xY2TCmuMfLYqXb9X1v03GLw9GvGTDVFFaLy8B6EXF/
         vbjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763800612; x=1764405412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N2zqQPxfD8wBoqVPNB/Ddc7v1WO9JhWHYtXYtFICkgs=;
        b=tvsneXJm3uKGrqBQGzfJRTaFHr/FKJAUPh40JY4UBfWxm3dFIpKnWn/O9A1XgXsjnb
         GvbBgzb004Bcmm0r5SqgXci4wjoSwfXNwmxYWaUqN/a3+7LmgH1EqYGqajL6i40s/UjS
         ix5FwaiWwtInCNIDj8SOJpCQmcul+w+ORqc9JWa9YPNntQ31fV8ZycSq5TZRFeH4rixz
         d+TaK+ciBCMbhskTac7BCnz6AtsM06VWS31Spi0e0HFw1LMt6CAmlzbQQ2XDBtFoPj4w
         hD2dLnCy4hSBZIIFeluBzJmUquQGdyUFMh7YzqfPO32e7cR74kBbuMrcn5msR9r2muOD
         iyNw==
X-Forwarded-Encrypted: i=1; AJvYcCU8q2yNgVBzuhpRlRCTVqn62lXnahFG269Ha/gr8mKamzgJ8dF2tQMRswKMZuJODKGCybhefqip@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0oNO6Fix2o9k+KwKm2ri/RMzdZaPhlvRF+qFYK5vKiG4kPv4q
	UuaAbKHueRbiDw2qqxKnGNb8eCYQC3f3YFcUDTPdttZJ+liBD4EcGoQlzyzM/o5MBhuLBTGmXI+
	/VISqvU2Eaj9v5v4DWkL2nRbWsGdX3LKTlgQiUCibFOFqFIewgRKSxrJUGYQ=
X-Gm-Gg: ASbGncvhcxv/AVaNdA54UUm3fLjDdLoDa3kkFRcgUR66+QcuzQo/vym6Gzm8uhf3Xgl
	F0uOK/lt3bZoCxpmEpQT9gq8v6apLpOYyu1IOIdlZ9z1O4txGa6EzkdSbEzgn7e52A4zXk4FnNM
	XS4VrMXf2DPVazztj6R4dkkIENr6EvVhVhzIUJTrpuQWH4vyzJGXlFCc91C67613Hp7wqRN7mOL
	8b6Z6uUJm3IuBiCOH9D/KwkIruEKLIIdNDmsKBYvGKoK3rQJcV4hVvCuXA4/qo2MXyk3R5awJaB
	Z01stgNjssEMqHDvhJO55H7eFwsE2t4dLo4OTyxNZchpS2AVeCewnxPkQ3tuXBLZMieYqakaGUo
	iq4OjT0CcvhqxmoaC5g1C7yyWEIpHdxzLvz/OLNQfVFdHiZCBRw==
X-Received: by 2002:a17:902:cf10:b0:295:4d50:aab6 with SMTP id d9443c01a7336-29b6bec46afmr71868935ad.18.1763800612475;
        Sat, 22 Nov 2025 00:36:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZKVywsAu0qzobqnzraeicR/A1ubiNv8l1v7u8EFYDdKAkfyP7Xd1nvEfkitfjqRENmetaDg==
X-Received: by 2002:a17:902:cf10:b0:295:4d50:aab6 with SMTP id d9443c01a7336-29b6bec46afmr71868815ad.18.1763800612057;
        Sat, 22 Nov 2025 00:36:52 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b13e279sm77727945ad.41.2025.11.22.00.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Nov 2025 00:36:51 -0800 (PST)
Date: Sat, 22 Nov 2025 16:36:46 +0800
From: Zorro Lang <zlang@redhat.com>
To: cem@kernel.org
Cc: zlang@kernel.org, hch@lst.de, hans.holmberg@wdc.com,
	johannes.thumshirn@wdc.com, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/2] xfs: Add test for mkfs with smaller zone capacity
Message-ID: <20251122083646.ihtwb3k4eocnb7fe@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251120160901.63810-1-cem@kernel.org>
 <20251120160901.63810-3-cem@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120160901.63810-3-cem@kernel.org>

On Thu, Nov 20, 2025 at 05:08:30PM +0100, cem@kernel.org wrote:
> From: Carlos Maiolino <cem@kernel.org>
> 
> Add a regression test for initializing zoned block devices with
> sequential zones with a capacity smaller than the conventional
> zones capacity.
> 
> Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
> ---
>  tests/xfs/333     | 37 +++++++++++++++++++++++++++++++++++++
>  tests/xfs/333.out |  2 ++
>  2 files changed, 39 insertions(+)
>  create mode 100755 tests/xfs/333
>  create mode 100644 tests/xfs/333.out
> 
> diff --git a/tests/xfs/333 b/tests/xfs/333
> new file mode 100755
> index 000000000000..f045b13c73ee
> --- /dev/null
> +++ b/tests/xfs/333
> @@ -0,0 +1,37 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Red Hat, Inc.  All Rights Reserved.
> +#
> +# FS QA Test 333
> +#
> +# Test that mkfs can properly initialize zoned devices
> +# with a sequential zone capacity smaller than the conventional zone.
> +#
> +. ./common/preamble
> +. ./common/zoned
> +
> +_begin_fstest auto zone mkfs quick
> +_cleanup()
> +{
> +	_destroy_zloop $zloop

        cd /
        rm -r -f $tmp.*

> +}
> +
> +_require_scratch

_require_block_device $SCRATCH_DEV

> +_require_zloop

g/781 checks if current $FSTYP supports zoned filesystem, and _notrun if it's
not supported:

        _try_mkfs_dev $zloop >> $seqres.full 2>&1 ||\
                _notrun "cannot mkfs zoned filesystem"

I'm wondering if we could have a common helper for that, then this case can be
a generic test case too.

For example:

_require_zloop_filesystem()
{
        _require_zloop

        local zloopdir="$TEST_DIR/zloop_test"
        local zloop=$(_create_zloop $zloopdir 64 2)

	_try_mkfs_dev $zloop >/dev/null 2>&1 || \
		_notrun "cannot make $FSTYP on zloop"
	_destroy_zloop $zloop
}

But this method takes too much time to run, does anyone have a better idea to help it
to be finished in several seconds?


> +
> +_scratch_mkfs > /dev/null 2>&1
> +_scratch_mount >> $seqres.full
> +
> +zloopdir="$SCRATCH_MNT/zloop"
> +zone_size=64
> +conv_zones=2
> +zone_capacity=63

Better to add a comment to explain what are these numbers for.

> +
> +zloop=$(_create_zloop $zloopdir $zone_size $conv_zones $zone_capacity)
> +
> +_try_mkfs_dev $zloop >> $seqres.full 2>&1 || \
> +	_fail "Cannot mkfs zoned filesystem"
> +
> +echo Silence is golden

Is this done? If such zloop device can be created, should we expect it works as usual?

Thanks,
Zorro

> +# success, all done
> +_exit 0
> diff --git a/tests/xfs/333.out b/tests/xfs/333.out
> new file mode 100644
> index 000000000000..60a158987a22
> --- /dev/null
> +++ b/tests/xfs/333.out
> @@ -0,0 +1,2 @@
> +QA output created by 333
> +Silence is golden
> -- 
> 2.51.1
> 

