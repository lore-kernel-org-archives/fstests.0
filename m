Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FE513AA51
	for <fstests@vger.kernel.org>; Tue, 27 Feb 2024 13:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709039858; cv=none; b=GlfVODIxebHm+VpjyQkcjwV/9QaHillJQzLI8VZ3lysrSC/nSHFYzU92OMpDKp2oaP8XfBkDfSqm5r17e+n+725Rw1Ksfii8EvDEP5KDypkAyLnvUVj0KKt06esdDjCXIzw69qzTrnX0Cz9pbH2wfA8rX1iD9cp5y2KW8kOyPpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709039858; c=relaxed/simple;
	bh=bIPdvg+UuXBoha7GoXLPqyt49LgbAAd8mx33ApAJuUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TloVpFpkAvt30XNV0w41kl5cQnXiexU1l4bNN3fRpCoO2e1IPtdzqXDAqCiKwxNKcA89zUdlp5m30avfiuc/39qpA3yRfW206X4HJBL6kegYCuebYsSw5KEImp1BOBGqYozIjDmff6Kj/chIj8OThJ8VC1zt6ABN2g9whKNRJ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f3isIB+N; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f3isIB+N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709039855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3OKqmPSh/37mZU0ZdzSlxg5+yizg6CX4lNnCMMmD3N4=;
	b=f3isIB+NRcuZSL1CrlHYIpzGnVD4SU3xMV23/f806s44Hn7/wW/2QM5XIo4rxSS3kyP/++
	/gmuZ0cJ4CfRw9EtAUV3VMk3zzVjWQ5Vlf8S20BrlZZln6pPQ0qNsQdoM5sv/viwWD16Ev
	Ar5nm0uxfRVkILfFCpln93JyV8GbnNg=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-_PLgkYjLNkWZ_qOsBCsfgA-1; Tue, 27 Feb 2024 08:17:34 -0500
X-MC-Unique: _PLgkYjLNkWZ_qOsBCsfgA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5d1bffa322eso4374473a12.1
        for <fstests@vger.kernel.org>; Tue, 27 Feb 2024 05:17:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709039548; x=1709644348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OKqmPSh/37mZU0ZdzSlxg5+yizg6CX4lNnCMMmD3N4=;
        b=XsgVCdpZT9wVj9soIsC6oSYLkyUeNw9BQtC5qWchFbBJMhHOhXh2CdAQByHK68LyFd
         +9qYq2FFMBPZdWIK2I+tYcyHkJtJNOXe9UuIj9XYq9IjRKFVRDacTLSKiNXZD12hBORu
         Dy1uXQvxwfQvm7IdOLN8zFvDJL1eZl9L4/8OorzjTZTs9a5BGxyuhhFFG/EaYfrHHXrl
         GKamPwOLP7GhherO12ONVyhEU5sfw344EeqdFEp/cYgLSxJB4EvCMzMCWm/B15Yknaaf
         pDGw8dH9YVLLARTurn8GBOKgfvbpkDmzjOFQoSw4UuUsC0iOPqN7f/4+YZRo7t/PHCCk
         rGQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeladvHEqGE2o4ZP3eh54NdhlV1aGZwHxmPKgwXJUcnLDbpxc/FLx2pMfRn0zLFagR/JcchvwThbJhYmO8G/IZL+kURSCpUw==
X-Gm-Message-State: AOJu0YxNi435D35wxoR1Qg+Z3uZJ6ghunL7/uOV8p04bqYfYpUudUUdw
	0WR9oDaxL6W75QTef9ljix1k1zktaVEgbhixsDDMVd/rAZ6Rbg85eUz1dHy+HmuJutr/oHn4aw7
	B5Qz09Bo0gskrZAw4F//o8g9hh5Ct/+qdJBRGzAzDl5vtpa08DfDF/zo=
X-Received: by 2002:a05:6a21:2d8c:b0:1a0:d240:c77d with SMTP id ty12-20020a056a212d8c00b001a0d240c77dmr2113113pzb.17.1709039548195;
        Tue, 27 Feb 2024 05:12:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtU2Ij5dNEbdxnNpv6yoTwy62ox0er1qhHOXSZkYUJRQQZOWaknwnJiS9l/fjz4r7TV9+5Aw==
X-Received: by 2002:a05:6a21:2d8c:b0:1a0:d240:c77d with SMTP id ty12-20020a056a212d8c00b001a0d240c77dmr2113103pzb.17.1709039547922;
        Tue, 27 Feb 2024 05:12:27 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id k62-20020a632441000000b005dc3fc53f19sm5793896pgk.7.2024.02.27.05.12.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 05:12:27 -0800 (PST)
Date: Tue, 27 Feb 2024 21:12:23 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org, fdmanana@suse.com
Subject: Re: [PATCH v3 3/3] fstests: btrfs: check conversion of zoned
 fileystems
Message-ID: <20240227131223.ghlqtl5oyylhs6ll@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240215-balance-fix-v3-0-79df5d5a940f@wdc.com>
 <20240215-balance-fix-v3-3-79df5d5a940f@wdc.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215-balance-fix-v3-3-79df5d5a940f@wdc.com>

On Thu, Feb 15, 2024 at 03:47:06AM -0800, Johannes Thumshirn wrote:
> Recently we had a bug where a zoned filesystem could be converted to a
> higher data redundancy profile than supported.
> 
> Add a test-case to check the conversion on zoned filesystems.
> 
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  tests/btrfs/310     | 67 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/310.out | 12 ++++++++++
>  2 files changed, 79 insertions(+)
> 
> diff --git a/tests/btrfs/310 b/tests/btrfs/310
> new file mode 100755
> index 000000000000..c39f60168f8a
> --- /dev/null
> +++ b/tests/btrfs/310
> @@ -0,0 +1,67 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2024 Western Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 310
> +#
> +# Test that btrfs convert can ony be run to convert to supported profiles on a
> +# zoned filesystem
> +#
> +. ./common/preamble
> +_begin_fstest volume raid convert

Don't you want to add it in "auto" group, to be a default test?

> +
> +_fixed_by_kernel_commit XXXXXXXXXX \
> +	"btrfs: zoned: don't skip block group profile checks on conv zones"
> +
> +. common/filter.btrfs
> +
> +_supported_fs btrfs
> +_require_scratch_dev_pool 4
> +_require_zoned_device "$SCRATCH_DEV"

OK, looks like don't need to check each devices of SCRATCH_DEV_POOL at here :)

> +
> +devs=( $SCRATCH_DEV_POOL )
> +
> +# Create and mount single device FS
> +_scratch_mkfs -msingle -dsingle 2>&1 > /dev/null

Mkfs with specific options might fail, so better to _fail if mkfs return non-zero,
and better to output the message into .full file, to know what's wrong.

Thanks,
Zorro

> +_scratch_mount
> +
> +# Convert FS to metadata/system DUP
> +_run_btrfs_balance_start -f -mconvert=dup -sconvert=dup $SCRATCH_MNT 2>&1 |\
> +	_filter_balance_convert
> +
> +# Convert FS to data DUP, must fail
> +_run_btrfs_balance_start -dconvert=dup $SCRATCH_MNT 2>&1 |\
> +	_filter_balance_convert
> +
> +# Add device
> +$BTRFS_UTIL_PROG device add ${devs[1]} $SCRATCH_MNT | _filter_device_add
> +
> +# Convert FS to data RAID1, must fail
> +_run_btrfs_balance_start -dconvert=raid1 $SCRATCH_MNT 2>&1 |\
> +	_filter_balance_convert | head -1
> +
> +# Convert FS to data RAID0, must fail
> +_run_btrfs_balance_start -dconvert=raid0 $SCRATCH_MNT 2>&1 |\
> +	_filter_balance_convert | head -1
> +
> +# Add device
> +$BTRFS_UTIL_PROG device add ${devs[2]} $SCRATCH_MNT | _filter_device_add
> +
> +# Convert FS to data RAID5, must fail
> +_run_btrfs_balance_start -f -dconvert=raid5 $SCRATCH_MNT 2>&1 |\
> +	_filter_balance_convert | head -1
> +
> +# Add device
> +$BTRFS_UTIL_PROG device add ${devs[3]} $SCRATCH_MNT | _filter_device_add
> +
> +# Convert FS to data RAID10, must fail
> +_run_btrfs_balance_start -dconvert=raid10 $SCRATCH_MNT 2>&1 |\
> +	_filter_balance_convert | head -1
> +
> +# Convert FS to data RAID6, must fail
> +_run_btrfs_balance_start -f -dconvert=raid6 $SCRATCH_MNT 2>&1 |\
> +	_filter_balance_convert | head -1
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/btrfs/310.out b/tests/btrfs/310.out
> new file mode 100644
> index 000000000000..bc06b29ecf10
> --- /dev/null
> +++ b/tests/btrfs/310.out
> @@ -0,0 +1,12 @@
> +QA output created by 310
> +Done, had to relocate X out of X chunks
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +There may be more info in syslog - try dmesg | tail
> +Resetting device zones SCRATCH_DEV (XXX zones) ...
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +Resetting device zones SCRATCH_DEV (XXX zones) ...
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +Resetting device zones SCRATCH_DEV (XXX zones) ...
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> +ERROR: error during balancing 'SCRATCH_MNT': Invalid argument
> 
> -- 
> 2.43.0
> 

