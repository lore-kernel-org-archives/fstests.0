Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC431EA0B2
	for <fstests@vger.kernel.org>; Tue,  6 Aug 2024 13:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951955; cv=none; b=FCDpx/2weg9WJZiErGAmfcXO8DeDHnttyis8pRZegivFnGmraaxW3ZheQNZU2HiFzrFNX6YsGjnzlMW6dEgZOlzfm66OUdqG8pP1F5CCDtzbzt+bd69HjgXZe7RQO8bySroFygwpLbCBuipr9b48HLw7vmw1e1RF1vPDSrTDaO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951955; c=relaxed/simple;
	bh=JntuWFDuBdyUVzja1Lml9181G6EzygSOut5mWGJZMro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSVvwETCfKkYJ03sRnj1qF+WKZI0NhwlcrR0GhVW1Xmig0P30b8uxaoYM1zToLJb00wFOe9AMFUQX3+gQ9xNcWejkait3SBi4QfIVjbKApaQKPEBEJaRZYXs8gsLXnxYJWIvMuUYJzx8kOJzmaiCJ/1n6KPhk8YbWEAugPa5K0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eoxm7sit; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eoxm7sit"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722951953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=14kaEXJ/fYktRDtIF6Cwxo38R5BK66laylWRL8R7wds=;
	b=eoxm7sitX+rML2C1G6GhoXw9AvywDPlSAK3eFIZgIa8uC+SKRxuW8jhNnU7UlMHauh/JtS
	N9iU9bG2LYzYe9A3ErgL0cOekH6Y3/CEY/ybEIemAy5cMdkEYY81aKfJg5MMaesw1X3XSD
	YNxeg0sE5Z6fpzqv1OdL1jTgJKmg8s8=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-386-silG7TGxPz29w6ytbrfhsA-1; Tue, 06 Aug 2024 09:45:49 -0400
X-MC-Unique: silG7TGxPz29w6ytbrfhsA-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-71050384c9aso964490b3a.1
        for <fstests@vger.kernel.org>; Tue, 06 Aug 2024 06:45:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722951949; x=1723556749;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=14kaEXJ/fYktRDtIF6Cwxo38R5BK66laylWRL8R7wds=;
        b=BzqEQDWLNU2UggxCnERkXk4wptkhH7JosIljuMtxkajWQJwTjoH0jOBRZ/ldppr+Hz
         txB09xymhCuXVGlY0RxP7alwjJ1jMMi75Lg+lDz4WVYpuEI1tIxa4Pxlf5VSA99jwqUt
         HaawfPyLU76USstCqBmbRDVByeFe572l0eEzPJnnrcgkxCs5sht0HVCjOUu0+Xq/mtMd
         Lz+v/CorqQO6/NRqqLPWjj/O7nOR00tXHY2jMq8iL0SEWDaVUDdn8yqy9OyPlUioonMV
         BBbwcXM6ni0eR283hJdfAh7RFFOiT8HMzUdhwkTd77xeRNq3d3VUc1dEzCTfWieb9xfJ
         nKCQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQFna/oHm65WMEK7SjpJfksuHuB5fCmmF1c9hDd4JCU3hr1hbr5pJ4l/yakxXAyGGafM8SCiYyL9znTZoRaEidSNxSLHdQDw==
X-Gm-Message-State: AOJu0YzX/Vi49D//jh11MAa9MnodV9GA5skIPw0Ny745k2TmfxHZ73b/
	NnOv1wmk1y47qaiJEI7diA7ETRK40YaMXUQMOoLqA5jgoKetEaB4I8LSOdvdPdyAM3s4XP+s0Bn
	nS5MwAFCj279EGsmSqhNXez4ipFgGHTSIb3EVYbfwFvOQMpOPyL8sFpQ=
X-Received: by 2002:a05:6a00:85a3:b0:70d:2a1b:422c with SMTP id d2e1a72fcca58-7106da29926mr22346874b3a.7.1722951948523;
        Tue, 06 Aug 2024 06:45:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXjTyXs51jnjR9/RjTLvCCIFrptmDXVJRuIrd9w21T7YgzeIHDoifLFEORcsrnF11QNrW1jg==
X-Received: by 2002:a05:6a00:85a3:b0:70d:2a1b:422c with SMTP id d2e1a72fcca58-7106da29926mr22346837b3a.7.1722951948018;
        Tue, 06 Aug 2024 06:45:48 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b763562989sm7063427a12.34.2024.08.06.06.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 06:45:47 -0700 (PDT)
Date: Tue, 6 Aug 2024 21:45:43 +0800
From: Zorro Lang <zlang@redhat.com>
To: Boris Burkov <boris@bur.io>
Cc: linux-btrfs@vger.kernel.org, kernel-team@fb.com,
	fstests@vger.kernel.org
Subject: Re: [PATCH v4] btrfs: add test for btrfstune squota enable/disable
Message-ID: <20240806134543.hbnyllmwokss5z4u@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <797a1ffab1bb76e65d278d9996abc72f423042ed.1720810205.git.boris@bur.io>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <797a1ffab1bb76e65d278d9996abc72f423042ed.1720810205.git.boris@bur.io>

On Fri, Jul 12, 2024 at 11:52:36AM -0700, Boris Burkov wrote:
> btrfstune supports enabling simple quotas on a fleshed out filesystem
> (without adding owner refs) and clearing squotas entirely from a
> filesystem that ran under squotas (clearing the incompat bit)
> 
> Test that these operations work on a relatively complicated filesystem
> populated by fsstress while preserving fssum.
> 
> Signed-off-by: Boris Burkov <boris@bur.io>
> ---

By checking the fstests@ mailing list, I found this patch was missed. As
Filipe has reviewed it, I'll add this patch to "patches-in-queue" branch
at first, then push it if no other review points. Sorry for this missing.

Thanks,
Zorro

> Changelog:
> v4:
> - redirected stdout of both btrfstune commands to .full file. Re-tested
>   on 1. correct progs (passes) and 2a. buggy progs with a leaked eb and
>   2b. buggy progs that hits a uptodatebuffer error while committing the
>   txn. Everything behaved as expected.
> v3:
> - switched btrfstune commands from '|| _fail' to filtered golden output.
>   Got rid of redirecting stderr to .full because some aberrant output
>   (like eb leaks) shows up in stderr and I think it is helpful to treat
>   those as errors.
> v2:
> - added needed requires invocations
> - made fsck and btrfstune command failures matter 
> 
> 
>  tests/btrfs/332     | 67 +++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/332.out |  2 ++
>  2 files changed, 69 insertions(+)
>  create mode 100755 tests/btrfs/332
>  create mode 100644 tests/btrfs/332.out
> 
> diff --git a/tests/btrfs/332 b/tests/btrfs/332
> new file mode 100755
> index 000000000..7f2c2ff9c
> --- /dev/null
> +++ b/tests/btrfs/332
> @@ -0,0 +1,67 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Meta Platforms, Inc.  All Rights Reserved.
> +#
> +# FS QA Test No. btrfs/332
> +#
> +# Test tune enabling and removing squotas on a live filesystem
> +#
> +. ./common/preamble
> +_begin_fstest auto quick qgroup
> +
> +# Import common functions.
> +. ./common/filter.btrfs
> +
> +# real QA test starts here
> +_supported_fs btrfs
> +_require_scratch_enable_simple_quota
> +_require_no_compress
> +_require_command "$BTRFS_TUNE_PROG" btrfstune
> +_require_fssum
> +_require_btrfs_dump_super
> +_require_btrfs_command inspect-internal dump-tree
> +$BTRFS_TUNE_PROG --help 2>&1 | grep -wq -- '--enable-simple-quota' || \
> +	_notrun "$BTRFS_TUNE_PROG too old (must support --enable-simple-quota)"
> +$BTRFS_TUNE_PROG --help 2>&1 | grep -wq -- '--remove-simple-quota' || \
> +	_notrun "$BTRFS_TUNE_PROG too old (must support --remove-simple-quota)"
> +
> +_scratch_mkfs >> $seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount
> +
> +# do some stuff
> +d1=$SCRATCH_MNT/d1
> +d2=$SCRATCH_MNT/d2
> +mkdir $d1
> +mkdir $d2
> +run_check $FSSTRESS_PROG -d $d1 -w -n 2000 $FSSTRESS_AVOID
> +fssum_pre=$($FSSUM_PROG -A $SCRATCH_MNT)
> +
> +# enable squotas
> +_scratch_unmount
> +$BTRFS_TUNE_PROG --enable-simple-quota $SCRATCH_DEV >> $seqres.full
> +_check_btrfs_filesystem $SCRATCH_DEV
> +_scratch_mount
> +fssum_post=$($FSSUM_PROG -A $SCRATCH_MNT)
> +[ "$fssum_pre" == "$fssum_post" ] \
> +	|| echo "fssum $fssum_pre does not match $fssum_post after enabling squota"
> +
> +# do some more stuff
> +run_check $FSSTRESS_PROG -d $d2 -w -n 2000 $FSSTRESS_AVOID
> +fssum_pre=$($FSSUM_PROG -A $SCRATCH_MNT)
> +_scratch_unmount
> +_check_btrfs_filesystem $SCRATCH_DEV
> +
> +$BTRFS_TUNE_PROG --remove-simple-quota $SCRATCH_DEV >> $seqres.full
> +_check_btrfs_filesystem $SCRATCH_DEV
> +$BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | grep 'SIMPLE_QUOTA'
> +$BTRFS_UTIL_PROG inspect-internal dump-tree $SCRATCH_DEV  | grep -e 'QUOTA' -e 'QGROUP'
> +
> +_scratch_mount
> +fssum_post=$($FSSUM_PROG -A $SCRATCH_MNT)
> +_scratch_unmount
> +[ "$fssum_pre" == "$fssum_post" ] \
> +	|| echo "fssum $fssum_pre does not match $fssum_post after disabling squota"
> +
> +echo Silence is golden
> +status=0
> +exit
> diff --git a/tests/btrfs/332.out b/tests/btrfs/332.out
> new file mode 100644
> index 000000000..adb316136
> --- /dev/null
> +++ b/tests/btrfs/332.out
> @@ -0,0 +1,2 @@
> +QA output created by 332
> +Silence is golden
> -- 
> 2.45.2
> 
> 

