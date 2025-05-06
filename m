Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B21A182
	for <fstests@vger.kernel.org>; Tue,  6 May 2025 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746562578; cv=none; b=hZpTaulx1kI4uiNJ8jgRtwF4HPVzfPoBLedtcMzszVKbXgV+KoqxBmdfM4hEZrOFUN4ukyfcfcoOM2eawXVeekxvboSAGtr32V+i/W8LY3+nI5Yt7LqLrcRKvgya88MFlmz+1Yzmep5rn/oLwvG0jVAYd7xyHjxtfNhnlq+2wRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746562578; c=relaxed/simple;
	bh=w91ERMvYNjD8AxkcDDuGxeAQsXuSundsTOd10md6120=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8ccH/a+vpptsMbWHFm+kfqiWNU1na32N+E07bp0WJUwQ+oqYLFt4SFLPZER2eNohtLxpf9RBx96K2by8EX7rBVbm8SKilHzQtkAbGNKtDDEzYUptkPiDBDPceKf8IfmO6vZZnQWtgXTPl2dPQa8ISg4E0lNAMVcOvigGclowdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkmThk/i; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkmThk/i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746562575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EiTwiC812fR8NWWsZHSKHCFWmLK0aJ0pgWsqi+Hiv2k=;
	b=MkmThk/iNsCy+6Zph4q55plb00iDtst8UCdyKKFAtP5leWKK2tNiJNQunxUofKHKPjE6vU
	H95I8exZVCXd++RYC0YE1bvBJuneNU6AZ6GXs7lsczDFb1KPHuf/chteBpieVNNNtMNCz5
	Gf2jwTF7NLNqgmUC7zBeSgBS9OVVUHM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-L2-N0N9bNr219xY-l3Owdg-1; Tue, 06 May 2025 16:16:14 -0400
X-MC-Unique: L2-N0N9bNr219xY-l3Owdg-1
X-Mimecast-MFC-AGG-ID: L2-N0N9bNr219xY-l3Owdg_1746562574
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-7395d07a3dcso3700867b3a.3
        for <fstests@vger.kernel.org>; Tue, 06 May 2025 13:16:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746562574; x=1747167374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EiTwiC812fR8NWWsZHSKHCFWmLK0aJ0pgWsqi+Hiv2k=;
        b=gplvLxD87eik397uAobVD2+P1CvaO76DVNfcACdyg9Kp1HAFR6fRg+FKkPyY31UlYe
         HwR3sNj3ig48p1q2SHRneXrJ3DMkeOBski2sTZwJyLpRRjlxPozVp5QvIDi7b/KLsv0/
         e6YuPON1bRPzFVlO3YmyNBpW1XdUxD646M48jPVSBrZ7I+A3d4h0cJztHDsm13qCc1Qo
         GxuLDQ1pnR3B7vCPNuNn2JzxSO8/RcYkgSxrsUwaFL2PGn+NCR9bRNNHQ4LhC9vldiLA
         vkWSYxbUi/Ut9dcFj7P4cMlROJy9wJxiLaP4cNx4mWLScpoPSDGRGWZMIoVnb3y8qFt2
         kLgA==
X-Forwarded-Encrypted: i=1; AJvYcCWaEiT8abr5J0URN51Wr22ec7eZMP+IkWfD1CMHfkNdz9a/tmnxp9ImoAzYtdQm1EIq392TLSOf@vger.kernel.org
X-Gm-Message-State: AOJu0YzhpTyUUSTwqlgMzdu3lE68XzoUSXSan1KftYH1bhfqtF/B71q9
	40Zrq0OIPCgAyGWzIbXwMissYGOOEWy7LVfxlxVxkg1njOwuu/ik2uhdBRCKF3mdTPr/dIOJJkF
	6U6i8yEKqTAb0pCrnXlFQGvtFPp58IToDtJusWO4dvB60FaKtqlJoXd8=
X-Gm-Gg: ASbGncuki4oWfyOipIL5aus9r8SaNBHp3/UZr23QJ2Gdd5RBU2VKeGkf1a1MnCar8y3
	FilaOmCnIjJEJ9eUjRYQB6wOBL03771xuuGQaiZ1CdPlMPxIVVSrR8nnvwDRP2iu3m4+g1Gyhhx
	qVpCLqFOXronzPTQezyPpwsHv++mgLtSG0HeqfxFzknRklpuOKbj+LHZehxl0/c5Uud76fhIQXj
	Y1I+KlRnOlJuHef3/+h5xR9xedOkt2AOcIba2A/2D6M1mHaEx9sBzOPxvFqziVkp6y/T4eCZDR6
	8PRqRDkycSdCOaQQzZauOVIMIDKW8un2dDLRDmkiENLoQXkm+1qT
X-Received: by 2002:aa7:930b:0:b0:736:532b:7c10 with SMTP id d2e1a72fcca58-7409cfda29cmr611080b3a.21.1746562573325;
        Tue, 06 May 2025 13:16:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyuyFKjjzC18sm6uQ4TbsIEzSyhk7yWBSipbUMLBuu7C3f6xKc7ISBa5A15kAWhM5TvGJtkQ==
X-Received: by 2002:aa7:930b:0:b0:736:532b:7c10 with SMTP id d2e1a72fcca58-7409cfda29cmr611035b3a.21.1746562572804;
        Tue, 06 May 2025 13:16:12 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058dbbe25sm9748091b3a.59.2025.05.06.13.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 May 2025 13:16:12 -0700 (PDT)
Date: Wed, 7 May 2025 04:16:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: Hans Holmberg <Hans.Holmberg@wdc.com>
Cc: Zorro Lang <zlang@kernel.org>, "djwong@kernel.org" <djwong@kernel.org>,
	"fstests@vger.kernel.org" <fstests@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	hch <hch@lst.de>
Subject: Re: [PATCH v2 15/15] xfs: test that we can handle spurious zone wp
 advancements
Message-ID: <20250506201607.erolq5xpceam65tv@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250501134302.2881773-16-hch@lst.de>
 <20250505095054.16030-1-hans.holmberg@wdc.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250505095054.16030-1-hans.holmberg@wdc.com>

On Mon, May 05, 2025 at 09:51:48AM +0000, Hans Holmberg wrote:
> From: Hans Holmberg <Hans.Holmberg@wdc.com>
> 
> Test that we can gracefully handle spurious zone write pointer
> advancements while unmounted.
> 
> Any space covered by the wp unexpectedly moving forward should just
> be treated as unused space, so check that we can still mount the file
> system and that the zone will be reset when all used blocks have been
> freed.
> 
> Signed-off-by: Hans Holmberg <hans.holmberg@wdc.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---

This's good to me, just below picky review points.

> 
> Canges since v1:
>  Added _require_realtime and fixed a white space error based
>  on Darrick's review comments.
> 
>  tests/xfs/4214     | 62 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/4214.out |  2 ++
>  2 files changed, 64 insertions(+)
>  create mode 100755 tests/xfs/4214
>  create mode 100644 tests/xfs/4214.out
> 
> diff --git a/tests/xfs/4214 b/tests/xfs/4214
> new file mode 100755
> index 000000000000..0637bbc7250e
> --- /dev/null
> +++ b/tests/xfs/4214
> @@ -0,0 +1,62 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Western Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 4214
> +#
> +# Test that we can gracefully handle spurious zone write pointer
> +# advancements while unmounted.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick zone
> +
> +# Import common functions.
> +. ./common/filter

Looks like this case doesn't use any filter helper.

> +. ./common/zoned
> +
> +_require_scratch
> +_require_realtime
> +_require_zoned_device $SCRATCH_RTDEV
> +_require_command "$BLKZONE_PROG" blkzone
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +blksz=$(_get_file_block_size $SCRATCH_MNT)
> +
> +test_file=$SCRATCH_MNT/test.dat
> +dd if=/dev/zero of=$test_file bs=1M count=16 >> $seqres.full 2>&1 \
> +	oflag=direct || _fail "file creation failed"

Why put the "oflag=direct" behind the ">> $seqres.full 2>&1" ? I'm saying
it's wrong, just a bit weird :)

Thanks,
Zorro

> +
> +_scratch_unmount
> +
> +#
> +# Figure out which zone was opened to store the test file and where
> +# the write pointer is in that zone
> +#
> +open_zone=$($BLKZONE_PROG report $SCRATCH_RTDEV | \
> +	$AWK_PROG '/oi/ { print $2 }' | sed 's/,//')
> +open_zone_wp=$($BLKZONE_PROG report $SCRATCH_RTDEV | \
> +	grep "start: $open_zone" | $AWK_PROG '{ print $8 }')
> +wp=$(( $open_zone + $open_zone_wp ))
> +
> +# Advance the write pointer manually by one block
> +dd if=/dev/zero of=$SCRATCH_RTDEV bs=$blksz count=1 seek=$(($wp * 512 / $blksz))\
> +	oflag=direct >> $seqres.full 2>&1 || _fail "wp advancement failed"
> +
> +_scratch_mount
> +_scratch_unmount
> +
> +# Finish the open zone
> +$BLKZONE_PROG finish -c 1 -o $open_zone $SCRATCH_RTDEV
> +
> +_scratch_mount
> +rm $test_file
> +_scratch_unmount
> +
> +# The previously open zone, now finished and unused, should have been reset
> +nr_open=$($BLKZONE_PROG report $SCRATCH_RTDEV | grep -wc "oi")
> +echo "Number of open zones: $nr_open"
> +
> +status=0
> +exit
> diff --git a/tests/xfs/4214.out b/tests/xfs/4214.out
> new file mode 100644
> index 000000000000..a746546bc8f6
> --- /dev/null
> +++ b/tests/xfs/4214.out
> @@ -0,0 +1,2 @@
> +QA output created by 4214
> +Number of open zones: 0
> -- 
> 2.34.1
> 

