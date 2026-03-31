Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30D543C071
	for <fstests@vger.kernel.org>; Tue, 31 Mar 2026 21:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774991899; cv=none; b=tuNNwSdMljoBl+1RuJtPdYaMRzGoeY0dCxain6J/BfWnXB4ewkfaP14jGm5vI1NYx519DK9KZnDwB//nwzw2o1wY/6xnV21epFfFgUx0YwZEyff9KcqKaGPKcjABPYW90+nUoB7/9Ke1rGjzDic9qOrE46xnlVWUHL+xbcldieA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774991899; c=relaxed/simple;
	bh=WneSfPwlaQ1re2mwvmDd5q3dH84wCFzAzS6Ge2fHSms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLXqZhCKrKcknAoynaJ4BOMEE9J+U2s2oVGoqR43pYOCmDVC91KTeOkCLqWE8K/KySgGlZY9/snpqTQLAB1x/6JQbQQ95/RkAQqkcL17llqHTVn+knnD3A49gpdwaUJAWpSm7tMZZuM03I5MU1YCLzsf7VCbH29GrV8W/aabRzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E1OhWVWq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ROkQqf4f; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E1OhWVWq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ROkQqf4f"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774991896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OKCpa5pplmPPb0BYoR3bxkOcgIRcj2RD5yOLVHcxUOA=;
	b=E1OhWVWqCGZIBcJo8UDbiuiUDe7952eMpvfXAQJNgR0cUQsvINgvzir1EIp24xlJtE+BoS
	Elqyi6YZDvY0j0BUelzbg4CEgqwkF6PdZ5cfkWTVSob2lurK7HNrCl8bVdSqmhrGvNe727
	gc+G+vQuVNhOVb7FLpRTmQ8P5xrqmyk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-15-0QNYIc5WMxiyXSKpOFAy-Q-1; Tue, 31 Mar 2026 17:18:15 -0400
X-MC-Unique: 0QNYIc5WMxiyXSKpOFAy-Q-1
X-Mimecast-MFC-AGG-ID: 0QNYIc5WMxiyXSKpOFAy-Q_1774991894
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2b250d3699aso80824635ad.2
        for <fstests@vger.kernel.org>; Tue, 31 Mar 2026 14:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774991894; x=1775596694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OKCpa5pplmPPb0BYoR3bxkOcgIRcj2RD5yOLVHcxUOA=;
        b=ROkQqf4fLu5kE5KOX2hoNgQ9+AEaHGjt2VDHT+6deBZFeanL9iZcJhbKoQSomlw2jY
         90+1uYqWngkT4MMR/PaJ0t/5N7+1MU9E0oXqOs9e58n9PkCd1lxy75U20KL6NtrVRe0z
         ke6FNFP6gCbIBlWH3ImHqZ6kfeU3z7P/J/ihp0wVBFQRQA7SzSfIwL8phEr3N+H/8+OJ
         RyyokGAhq8B4NWyZK7jllFguL38rqWJgeSmzHwLeAEnpv/0o/tbEDQHz5i+g7SSTFxtW
         Pza8OWBl1i+uXZcOGtWTiYzVXplnN8ee2I8lQnJCWoR2CPTm0VRV5hh4KIeE97bxy7wt
         Pyzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774991894; x=1775596694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKCpa5pplmPPb0BYoR3bxkOcgIRcj2RD5yOLVHcxUOA=;
        b=kKsuh3dvggvWjfDay4R4mg3okj9IY2x4VHSUBdJ8iAcL1iGyYs5of3e1rTZsY8RBgZ
         bfn9pRUfca340uin8zt6CDrUC+6qHM7YRg0ZtKBkeQhsGBWGStkm2dCdg+0jMkbjgYIy
         njAzVax4/Ly+F6oCKp3R7+YKzPziIG5/E4y6DEVXAPtvWnja6EfRcvjBHZjMLpPGop52
         Y+bSFY96MypTD8Yl+djG5TjDtLAWCH1Ujg40U57AilN6FBbN7s8vpzhJ9vRD3f94okqY
         4ZLjwSlST82XsBQudQfFW9xg4YNir6n/1/2XHBtEU5DTST04gZ9Jp5bkwEb04x+gHE3B
         URow==
X-Forwarded-Encrypted: i=1; AJvYcCWtmTGHhfRmanEGLlpjA8Uak5HZkUjxqYnVuCYqn2yEwtcrNtNkGRJGUBa41Qck+t0bDz0Z77HA@vger.kernel.org
X-Gm-Message-State: AOJu0YyMQ1sR5hNmlf1CXdJQCxiEW652MHOeB/A8r3nHOSNNhnjGnFXd
	BueU5SEWjK/CHmcC+hz0x9Trv4XgT3Ztr0y7AVh5NkC8Gxdyaw1knSgK4wFMjTm5rsw77Mt/BIx
	JRjHx7AiNEB5G0LwZlbfRkaO7NLXnQ40txaOQeNQ44/SpDw7V6l+0k5b/NMo=
X-Gm-Gg: ATEYQzwhbeb3DIueM+Fp5Z6SPnx8YJh1xb/1G43Znv1Qxj2L/9+1C8XsW8URWHv4jYN
	pZaWm7jo7VDOBi9axUptvtP5csNX+qRe4ohv425T+PLllKd2MDoQa4pItPfxFrOjzIgy/ukQ1xa
	224CHqbVIeaeNuhd2yRS32xn9UwpCfJdS4qRHjtgVAFlB5ZFxpOgAMUFmEf8lk5LqVreEmZGE8O
	BNjTq1Ty6QbM1IMQMokfdQ232q/QJ0orARTf+BTacqpdsT/crvQWMx9c8M6kJ03cPveJDROb9FV
	AymbNBWH9pbelXMvKMnD26p2/H9Jz1VESSqA+/pNBf0d7wMwO3E18528h9a6fVBQvkzhXE9MUo7
	wCVMwg+qnb16XD6D18g==
X-Received: by 2002:a17:903:2ec3:b0:2ae:66c9:494f with SMTP id d9443c01a7336-2b269a8c805mr6677145ad.2.1774991893930;
        Tue, 31 Mar 2026 14:18:13 -0700 (PDT)
X-Received: by 2002:a17:903:2ec3:b0:2ae:66c9:494f with SMTP id d9443c01a7336-2b269a8c805mr6676975ad.2.1774991893421;
        Tue, 31 Mar 2026 14:18:13 -0700 (PDT)
Received: from doltdoltdolt ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242676e13sm126291445ad.28.2026.03.31.14.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:18:13 -0700 (PDT)
Date: Wed, 1 Apr 2026 05:18:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, djwong@kernel.org, dlemoal@kernel.org,
	hans.holmberg@wdc.com, fstests@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2] xfs: add a test for number of open zones on
 conventional devices
Message-ID: <20260331211807.gofhlabxlr3mdxnr@doltdoltdolt>
References: <20260331152341.4047725-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331152341.4047725-1-hch@lst.de>

On Tue, Mar 31, 2026 at 05:23:20PM +0200, Christoph Hellwig wrote:
> Test that mounts of zoned file systems on conventional devices don't
> create more open zones than allowed when the last blocks in one or more
> zones have been invalidated.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
> 
>  - delete odd files
>  - fix the sysfs attr check to be on the scratch and not the test fs
> 
>  tests/xfs/4201     | 66 ++++++++++++++++++++++++++++++++++++++++++++++
>  tests/xfs/4201.out |  1 +
>  2 files changed, 67 insertions(+)
>  create mode 100755 tests/xfs/4201
>  create mode 100644 tests/xfs/4201.out
> 
> diff --git a/tests/xfs/4201 b/tests/xfs/4201
> new file mode 100755
> index 000000000000..150978a9deda
> --- /dev/null
> +++ b/tests/xfs/4201
> @@ -0,0 +1,66 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2026 Christoph Hellwig.
> +#
> +# FS QA Test No. 4201
> +#
> +# Test that mounts of zoned file systems on conventional devices don't create
> +# more open zones than allowed when the last blocks in one or more zones have
> +# been invalidated.
> +#
> +
> +. ./common/preamble
> +_begin_fstest auto quick zone
> +
> +_require_scratch
> +_require_odirect
> +_require_non_zoned_device $SCRATCH_DEV
> +_require_non_zoned_device $SCRATCH_RTDEV
> +
> +open_zones=5
> +blocks=65536
> +bsize=4096
> +
> +zone_size_mib=$((blocks * bsize / 1024 / 1024))
> +file_size_mib=$((zone_size_mib / 2))
> +nr_files=$((open_zones * 3 - 1))
> +
> +echo "zone size: $zone_size_mib" >>$seqres.full
> +echo "file size: $file_size_mib" >>$seqres.full
> +echo "nr files: $nr_files" >>$seqres.full
> +
> +_scratch_mkfs -b size=${bsize} -r zoned=1,rgsize=${blocks}b \
> +	> "$seqres.full" 2>&1

I usually tack on "|| _fail 'mkfs failed'" after _scratch_mount if it's
using extra options. That way, we'll know for sure if the mkfs actually
failed.

> +_scratch_mount -o max_open_zones=${open_zones}
> +
> +_has_fs_sysfs_attr $SCRATCH_DEV zoned/nr_open_zones || \
> +	_notrun "This test requires /sys/fs/${FSTYP}/$SCRATCH_DEV/zoned/nr_open_zones"

Can this be replaced with "_require_fs_sysfs_attr" ? _require_fs_sysfs_attr also can
help to get the real path to the sysfs directory for the fs on a device.

Thanks,
Zorro

> +
> +for i in $(seq 1 $nr_files); do
> +	dd if=/dev/zero of=$SCRATCH_MNT/$i bs=1M count=$file_size_mib \
> +		 oflag=direct > /dev/null 2>&1
> +done
> +
> +# delete odd numbered files as they should be at the end of the zones
> +for ((i = 0; i < $nr_files; i = $((i + 2)))); do
> +	rm $SCRATCH_MNT/$((i + 1))
> +done
> +
> +_scratch_unmount
> +_scratch_mount -o max_open_zones=${open_zones}
> +
> +max_open=$(_get_fs_sysfs_attr $SCRATCH_DEV zoned/max_open_zones)
> +nr_open=$(_get_fs_sysfs_attr $SCRATCH_DEV zoned/nr_open_zones)
> +
> +if [ ${max_open} -ne $((open_zones - 1)) ]; then
> +	_fail "Test needs adjustments for multiple open GC zones"
> +fi
> +
> +if [ ${nr_open} -gt ${max_open} ]; then
> +	_fail "Too many open zones: $nr_open/$max_open"
> +fi
> +
> +_scratch_unmount

Is this line part of the test?

Thanks,
Zorro

> +
> +status=0
> +exit
> diff --git a/tests/xfs/4201.out b/tests/xfs/4201.out
> new file mode 100644
> index 000000000000..32e395dd4d6d
> --- /dev/null
> +++ b/tests/xfs/4201.out
> @@ -0,0 +1 @@
> +QA output created by 4201
> -- 
> 2.47.3
> 
> 

