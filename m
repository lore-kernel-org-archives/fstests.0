Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150AD2561D1
	for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760725277; cv=none; b=fhjuL1iUyQ2ST9X9ZOCt8WGYJ+3ygtP4Im/ijzLkuPyinvbX0fjhg6CerHrA66hcf340MKxvTkIrhIxQN7JOwA6zJf1a05LkGmN+yq5EBXB+X//u9Y+Ri5pVryQAPiwadp0Y22OsKhCwB39sed1nh0gnSgVLwQ2wuXleSsOCVoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760725277; c=relaxed/simple;
	bh=7V1vGZUMugbyY3uXC6TbIVNvUYRpBHUPf3OG4A8s66k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1lDGd+1np4ZUqlH4hZW5JlgSP1GcKypiOz3V4AQGNr5E24p2T7J84xnK64sk9pGck32gwx7w3Dr07tteCPGYtJtfVf8W/s/E71YhcioRly7B9+OLfhc3UnFl2Mg3lgCTO6gmle4RyBVa82aIGnKnjsgpGnG5qwnGClBe3xNUyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3vUR6Af; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3vUR6Af"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760725274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2b5Eht+PGQqCXGcdNOYyGJBasTFeEXQyNAzPsfbNKj4=;
	b=f3vUR6Af76YkRlC0RLhz3jdHr6VlS5gwP4vKLKVQSa3xBTR19myCVXGRu/0Le80NGevIAY
	AvGy/CPKEaNG/0Kz4f/WP4m6hGs0RvcnxU4cIz+B1yMOjWO6oU1K783pbQdScFKokrD1a0
	pU7rkdxy7Yhcy2LUC4cm2WhoG/OXJaE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-ZWujSqt2PzK3c4uPkK4rkQ-1; Fri, 17 Oct 2025 14:21:13 -0400
X-MC-Unique: ZWujSqt2PzK3c4uPkK4rkQ-1
X-Mimecast-MFC-AGG-ID: ZWujSqt2PzK3c4uPkK4rkQ_1760725272
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-7900f597d08so2161274b3a.1
        for <fstests@vger.kernel.org>; Fri, 17 Oct 2025 11:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760725272; x=1761330072;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2b5Eht+PGQqCXGcdNOYyGJBasTFeEXQyNAzPsfbNKj4=;
        b=eZvswCiH/F3WBcw03vP5xiyFd7DWikbPkJMgdMMHhqiKickw2rHzGfO7FPrEpBnfqd
         THatZiUxDvx5LkOZzRJHwAxCVgcg1HvgcS9CtQ8npV86SMHcIplonW+yF4a9P7TvS3i/
         N1K0GiC1JgoMoal5Yjpk1IbVzeKDyqhRjPZHluh1wGuy/rpmzp1wFHOdNASq2GdJ/WrB
         NA6X3GPwB8DWABAwLv7UspOKZVAnK0HSasCAuq6tP7MjcHa74qAtYKYti0wuT8LyIwbt
         NQTRxvzjC2drumnd8u6sKdcdBdedshHpFzbQU7UG3rmiFgfce7XNDqeSpAPud++P1Bu+
         O+ag==
X-Forwarded-Encrypted: i=1; AJvYcCWqW/JDEWO6+rwuaRpFTEg9I9Li2vw8RPPrjbgZNMR8pPyhYTQF1h85QsKEsdAo25cWrq30j4qe@vger.kernel.org
X-Gm-Message-State: AOJu0YwwoU1wWJC/+56gd84RgD0WcqEci9C+XN1FgvLjKNWjYSIBIijx
	wFUo5+HvMTXuAWzPI5Ne1xVn3vr71/UMADdtDYqu8LWiDxQMQWseOf7B1hRjvDKjkHRtaAfRTqH
	dsOdoXKR/YR2Lzy3mHt685e15CgqrWWPRAvu1bJXUxkMiGqAzEhIvZOx6rJ4=
X-Gm-Gg: ASbGncuNELFyrl2glXqwWk8vWRRwqN5OKXbSxejy4DUEa3jmrjFE72cxpHYHcpnx8qV
	G8ZmnsnoITfJbYWVaMHVQQMcBK4kQyF52xkrxLc+oYrAOJVJi+S2DrrMnVw/33nR6JXW1Vt3fQk
	ITtYezz1q9WjdJGogfxBF98mbNpVgE25FnGIxyHwxidhRBiNVnXO6S3XNLCdWHBBWH+6i1tGAq3
	DGMoOw7vr/bEQEpAkAYQulZjXnB5ktfKcAHJPBKcUmShjgZAn9wfKqkbOS2OYdlB3FHYffHCxxP
	sqlJuWrSj5VUhbNlXVt5skOr10UMmokNkyXOmC00EQqBxZs0yBjKhOtGeDOzsYeEklKtAESXHVo
	jNalIixFxG3DewNQi/OCSdzFZSSBkg0Gpkq+gKOg=
X-Received: by 2002:a05:6a20:e212:b0:334:a2ed:5fa0 with SMTP id adf61e73a8af0-334a8610906mr6437822637.28.1760725272234;
        Fri, 17 Oct 2025 11:21:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IETRSHCSGN92yC7zInJ3ldq9DBraMV4qDWpiqi2ZbNnHTstihrlPnjlLoY1XjVFIMXYjRV9IQ==
X-Received: by 2002:a05:6a20:e212:b0:334:a2ed:5fa0 with SMTP id adf61e73a8af0-334a8610906mr6437781637.28.1760725271534;
        Fri, 17 Oct 2025 11:21:11 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a230121f96sm212076b3a.76.2025.10.17.11.21.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 11:21:10 -0700 (PDT)
Date: Sat, 18 Oct 2025 02:21:05 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, Naohiro Aota <naohiro.aota@wdc.com>,
	linux-btrfs@vger.kernel.org, Hans Holmberg <hans.holmberg@wdc.com>,
	fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] generic: basic smoke for filesystems on zoned block
 devices
Message-ID: <20251017182105.lrmx2f6ylt2jnsak@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20251006132455.140149-1-johannes.thumshirn@wdc.com>
 <20251006132455.140149-3-johannes.thumshirn@wdc.com>
 <20251017145742.thvvkyk7qafi4aju@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017145742.thvvkyk7qafi4aju@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>

On Fri, Oct 17, 2025 at 10:57:42PM +0800, Zorro Lang wrote:
> On Mon, Oct 06, 2025 at 03:24:55PM +0200, Johannes Thumshirn wrote:
> > Add a basic smoke test for filesystems that support running on zoned
> > block devices.
> > 
> > It creates a zloop device with 2 sequential and 62 sequential zones,
> > mounts it and then runs fsx on it.
> > 
> > Currently this tests supports BTRFS, F2FS and XFS.
> > 
> > Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> > ---

Please ignore this, I checked the old version.

> >  tests/generic/772     | 52 +++++++++++++++++++++++++++++++++++++++++++
> >  tests/generic/772.out |  2 ++
> >  2 files changed, 54 insertions(+)
> >  create mode 100755 tests/generic/772
> >  create mode 100644 tests/generic/772.out
> > 
> > diff --git a/tests/generic/772 b/tests/generic/772
> > new file mode 100755
> > index 00000000..412fd024
> > --- /dev/null
> > +++ b/tests/generic/772
> > @@ -0,0 +1,52 @@
> > +#! /bin/bash
> > +# SPDX-License-Identifier: GPL-2.0
> > +# Copyright (c) 2025 Wesgtern Digital Corporation.  All Rights Reserved.
> > +#
> > +# FS QA Test 772
> > +#
> > +# Smoke test for FSes with ZBD support on zloop
> > +#
> > +. ./common/preamble
> > +_begin_fstest auto zone quick
> > +
> > +_cleanup()
> > +{
> > +	if test -b /dev/zloop$ID; then
> > +		echo "remove id=$ID" > /dev/zloop-control
> > +	fi
> > +}
> > +
> > +. ./common/zoned
> > +
> > +# Modify as appropriate.
> > +_require_scratch
> > +_require_scratch_size $((16 * 1024 * 1024)) #kB
> 
> _require_scratch_size contains _require_scratch, so you can remove _require_scratch.
> 
> Can you explain why we need 16GiB free space for these parameters?
> 
> > +_require_zloop
> > +
> > +_scratch_mkfs > /dev/null 2>&1
> > +_scratch_mount
> > +
> 
> 
> > +last_id=$(ls /dev/zloop* 2> /dev/null | grep -E "zloop[0-9]+" | wc -l)
> > +ID=$((last_id + 1))
> > +
> > +mnt="$SCRATCH_MNT/mnt"
> > +zloopdir="$SCRATCH_MNT/zloop"
> > +
> > +zloop_args="add id=$ID,zone_size_mb=256,conv_zones=2,base_dir=$zloopdir"
> > +
> > +mkdir -p "$zloopdir/$ID"
> > +mkdir -p $mnt
> > +echo "$zloop_args" > /dev/zloop-control
> > +zloop="/dev/zloop$ID"
> 
> About this part, can we have a common helper (e.g. _create_zloop_device) which
> can get a free zloop number and create a zloop dev, then output the device name
> if it's created successfully ?
> 
> > +
> > +_try_mkfs_dev $zloop 2>&1 >> $seqres.full ||\
> > +	_notrun "cannot mkfs zoned filesystem"
> 
> As this's a generic test case, I'm wondering if the zloop device can be created
> on any FSTYP? For example if FSTYP is nfs or cifs or overlay or tmpfs or exfat
> and so on.
> 
> > +_mount $zloop $mnt
> > +
> > +$FSX_PROG -q -N 20000 $FSX_AVOID "$mnt/fsx" >> $seqres.full
> 
> Do you care about the return status of fsx? If so, you can use _run_fsx or run_fsx.
> 
> > +
> > +umount $mnt
> 
> Please make sure "the $mnt is unmounted" and "all zloop devices are removed"
> in _cleanup.
> 
> Thanks,
> Zorro
> 
> > +
> > +echo Silence is golden
> > +# success, all done
> > +_exit 0
> > diff --git a/tests/generic/772.out b/tests/generic/772.out
> > new file mode 100644
> > index 00000000..98c13968
> > --- /dev/null
> > +++ b/tests/generic/772.out
> > @@ -0,0 +1,2 @@
> > +QA output created by 772
> > +Silence is golden
> > -- 
> > 2.51.0
> > 

