Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5060B3D903C
	for <fstests@vger.kernel.org>; Mon,  9 Mar 2026 15:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773070306; cv=none; b=cUJ/XUv+h3dwT5zqCwwri4UAR3tRfxX+tJVCYLL9tI1Sk0RikE3V7Zzro7xPbIK9NXcFur7y8IY5vRcbxJ+FHf0WnYlWSkMtWOaYFoGL9ZH5tDZQ9GCYCM3cU2snE6Rh0+XILRxwRS2BlvOEbJ6Av2SqBuVduEbxJ7r9WOOB7zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773070306; c=relaxed/simple;
	bh=styTRJidEb329/TYcyG6xwk1XD538n4BzhBnsVUAb0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQGBHdD0yMZ2/y0N1vx0JoZmnnJ0WXLCof90m/fTxBIqOI4/VT8RwCMnRR9fBJobBNtfusjollYDwwSQGmrHwxCzAA5sqos3O9HnL0AVTkv5rd4MFA03FgK6SJv8tfwZZyJEpbeYQ8IlTI14CRC/864jfZqm2hB6y6QfhBlv9jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H+klaNV0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yr00SgG6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+klaNV0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yr00SgG6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773070304;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HCA6EuPYCbjISG8NkXGqwgNV/qegVIJI7skqyHztj+g=;
	b=H+klaNV0RX81TWY4UofVt52Tvx5+za5BIXwnGHDIFmlMDGl6DmaVueHl5s/mWLF/hKjWBt
	hWyVpY48RJQHJjSDAM3cW1LXZbVrLJsUUrlAr1+tualRzk753MV4upxX0r6iwPQ3GvEVLP
	VKpgbZovyQxie4ZQPDcIMz3UbtH4VWI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-IhJccbauOaaFAGCZoN0FuQ-1; Mon, 09 Mar 2026 11:31:43 -0400
X-MC-Unique: IhJccbauOaaFAGCZoN0FuQ-1
X-Mimecast-MFC-AGG-ID: IhJccbauOaaFAGCZoN0FuQ_1773070302
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-829b8bb5173so576716b3a.3
        for <fstests@vger.kernel.org>; Mon, 09 Mar 2026 08:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773070302; x=1773675102; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HCA6EuPYCbjISG8NkXGqwgNV/qegVIJI7skqyHztj+g=;
        b=Yr00SgG6h2Xxb4ejJT9o0ydOuXyNsMXMo2QixXXTwetRi5jM26M0FAscioGvt071Bc
         axWnjcQF4gdiSpnMczAdrf+H8x0IIhPQDubub+zastYuDOKAbg4bFLhqZ4LMa1JOLUtP
         fkXaEf/EQHpxTOrDl5TUU9J53X0+DP16EC527YkBJMx2gbzMYuXq3ZBJZo7DtrVapaGR
         vmZLucgkumy5KQRJ20stWGsSl2W+QT/nByLjUJ3FbF5uAtwcdM3FUKETzlOj6wG6kGfZ
         VfoDx98lKJfBImKmBAO3Z+yfarNvPjGN9N5JVZssBfM2wkP2jdvCmc0WpNxuzTXK2kie
         4HTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773070302; x=1773675102;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCA6EuPYCbjISG8NkXGqwgNV/qegVIJI7skqyHztj+g=;
        b=B5VhdmeSKtx26Hl5Uu5QFVaNThjfPuiePH57A9oOB66V4mhKjpRZTb0+SCsJeQfElS
         t5S9QlB2a0trWVQ2t15xLw6JUC2Y+IoYM51C2Ny/2KPMvCdyhBqvJ8UjEHvydSu3PeZs
         C02M9Hj4ZcE4fympbDyjFOIE45WjYc7GFUMaE/OfFY9NVqv3ZSE9GL0XVrAbESoeZSxg
         Vri/LgKL/eXXypWAZRo4M7gsKZ1kQ7968VdogCdupi33ujTXbDJvTF3eJrjRauFnu20t
         /83CSHunH2z0Gx6LBoPaHcm/S2xrb4CLaOA6o8CQ/HAnSFi9avKFhgB27+k/Ie7/L48w
         +nWQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx2aQU3OZhHqx+TA2UyLqPXO5uTYebzKA8mwsQIPwfzWN5ef1DFH6Q/2WfWGap256ZzoTFC3L4@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9DPOaBc8pkbuEYJUBZmQCQwt7XEcIUWhDcTE6Zxvk226mo6Zk
	2sK6EiH7P4rARPlghfCuO2YdBtplVlQ9T5eAuiRmKdCS+7GitiLD9GKjfRMORD2TXwsX0SYkjkr
	lzZy2veM2PxgWFk44U+Vuj5QIWZn1mu55nw23yrO4H9GKMo+M5yQAdrrww1Q=
X-Gm-Gg: ATEYQzys0ms3KU7c4KCN2CftqnDCLQsniXM+UcFo09WAZNmafjkvqLehQvOge3K866H
	aqx66oFivoAOmYYlcPN/qxkSLgZ6P0Pt4Czjq0fX+fJ3ByOe86oVXz5J/apG5WEsJ6PoGcXlZZh
	/r4est5ws9Ujn7AAK027L/86WUcP4e0jwsFVeGO9AqTQmejw1Z+T+FNlB7PF4JHNJk2Kdg9H733
	eTZ2H64m6nKNTsyWAPgteWKtL5C7wsD8KV/DfXIRpbUUtBT7MknAaDkOlQTt85c3qYc+U0ufeqW
	Cju0QVS860/+fQicJtRKVIWVRazX74aD19uPv+2Lqt8v9OG5Y9dGbTS7fZFra9OpZzhIqEqLOZH
	Y8P6B8K3TB43o+3FyKypmxDNaDFmPnY9WHjb0zuCROXZQnW1uW7u73wHSx2PNnA==
X-Received: by 2002:a05:6a00:2483:b0:827:2dea:8840 with SMTP id d2e1a72fcca58-829a30b9c6fmr8489551b3a.56.1773070301548;
        Mon, 09 Mar 2026 08:31:41 -0700 (PDT)
X-Received: by 2002:a05:6a00:2483:b0:827:2dea:8840 with SMTP id d2e1a72fcca58-829a30b9c6fmr8489528b3a.56.1773070300963;
        Mon, 09 Mar 2026 08:31:40 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4637bb1sm9901003b3a.10.2026.03.09.08.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 08:31:40 -0700 (PDT)
Date: Mon, 9 Mar 2026 23:31:36 +0800
From: Zorro Lang <zlang@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org,
	fstests@vger.kernel.org, Hans Holmberg <Hans.Holmberg@wdc.com>,
	Naohiro Aota <naohiro.aota@wdc.com>
Subject: Re: [PATCH] fstests: test premature ENOSPC in zoned garbage
 collection
Message-ID: <20260309153136.taooohkzuc4ov56p@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20260210111103.265664-1-johannes.thumshirn@wdc.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260210111103.265664-1-johannes.thumshirn@wdc.com>

On Tue, Feb 10, 2026 at 12:11:03PM +0100, Johannes Thumshirn wrote:
> This test stresses garbage collection in zoned file systems by
> constantly overwriting the same file. It is inspired by a reproducer for
> a btrfs bugifx.
> 
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  tests/generic/783     | 48 +++++++++++++++++++++++++++++++++++++++++++
>  tests/generic/783.out |  2 ++
>  2 files changed, 50 insertions(+)
>  create mode 100755 tests/generic/783
>  create mode 100644 tests/generic/783.out
> 
> diff --git a/tests/generic/783 b/tests/generic/783
> new file mode 100755
> index 000000000000..f996d78803a1
> --- /dev/null
> +++ b/tests/generic/783
> @@ -0,0 +1,48 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Western Digital Corporation.  All Rights Reserved.
> +#
> +# FS QA Test 783
> +#
> +# This test stresses garbage collection in zoned file systems by constantly
> +# overwriting the same file. It is inspired by a reproducer for a btrfs bugifx.
> +
> +. ./common/preamble
> +_begin_fstest auto quick zone
> +
> +. ./common/filter
> +
> +_require_scratch_size $((16 * 1024 * 1024))
> +_require_zoned_device "$SCRATCH_DEV"
> +
> +# This test requires specific data space usage, skip if we have compression
> +# enabled.
> +_require_no_compress
> +
> +if [ "$FSTYP" = btrfs ]; then
> +	_fixed_by_kernel_commit XXXXXXXXXXXX \
> +		"btrfs: zoned: cap delayed refs metadata reservation to avoid overcommit"
> +	_fixed_by_kernel_commit XXXXXXXXXXXX \
> +		"btrfs: zoned: move partially zone_unusable block groups to reclaim list"
> +	_fixed_by_kernel_commit XXXXXXXXXXXX \
> +		"btrfs: zoned: add zone reclaim flush state for DATA space_info"

Please rebase to latest for-next branch, then change above "_fixed_by_kernel_commit"
to "_fixed_by_fs_commit btrfs ...."

> +fi
> +
> +_scratch_mkfs_sized $((16 * 1024 * 1024 * 1024)) &>>$seqres.full
> +_scratch_mount
> +
> +blocks="$(df -TB 1G $SCRATCH_DEV |\
> +	$AWK_PROG -v fstyp="$FSTYP" 'match($2, fstyp) {print $3}')"

Wouldn’t it make more sense to get the available size here? And there's a helper
_get_available_space in common/rc.

> +
> +loops=$(echo "$blocks * 4 - 2" | bc)
Is $blocks a huge number? How about using $((blocks * 4 - 2)) simply?

Can you add a comment to explain what's this "blocks * 4 - 2" for?

> +
> +for (( i = 0; i < $loops; i++)); do
> +	dd if=/dev/zero of=$SCRATCH_MNT/test bs=1M count=1024 status=none 2>&1

Not sure what's the "2>&1" for.

This isn't an append write, right? So we keep writting from 0 to 1G? Can you use a
comment to explain why we require 16G sized SCRATCH_DEV ?

Thanks,
Zorro

> +	if [ $? -ne 0 ]; then
> +		_fail "Failed writing on iteration $i"
> +	fi
> +done
> +
> +echo "Silence is golden"
> +# success, all done
> +_exit 0
> diff --git a/tests/generic/783.out b/tests/generic/783.out
> new file mode 100644
> index 000000000000..2522395956d4
> --- /dev/null
> +++ b/tests/generic/783.out
> @@ -0,0 +1,2 @@
> +QA output created by 783
> +Silence is golden
> -- 
> 2.53.0
> 

