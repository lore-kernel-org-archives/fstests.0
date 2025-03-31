Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31654212FB7
	for <fstests@vger.kernel.org>; Mon, 31 Mar 2025 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743429929; cv=none; b=OatrhESwGQEzTPW9Gp4B50aA+4xbHgeyl0f3+t1QTvLMXkv9ZY/1foezYzOnFwIFyufJEmKfJmmFrmUFdq8n2u1JNWz5P1DTIbpJ6QrnQjyYyq+bX4t1FcbQafEa6AcMUOnmg1BX/ap4UyfS6p6YLZnhHNvWM2r1qFTNS9yOrf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743429929; c=relaxed/simple;
	bh=B+AwkAZOJEiT2q+B6HITmNEqaPPCcCX4MXwG5fdQAjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/ir3Xs8CZJBr+7bHOi8d/smmqG+Q/MSZKZv0rdcQ0unWVDOE9FnZVncL49sWBgOqBvq5Jbm6yHQS5hF5fxcZV4WGagkkc0gNPWNx64aBY0K2HfgQt+yG99xUZc16tAVl44jU4pOD3VGVCAWZR2pJ10jYsm8nr0Y9H0R4Yx4+bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WjPWFx8L; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WjPWFx8L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743429927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lbJE47OqdqR3/52t5jOg708wyYmsdkilsHpLK6arp/s=;
	b=WjPWFx8LdXI3nO81GJ5c4qzr4OSgLXgkmB5Xs/PHDHDGqxliENP9G+W8ZXYAtma1smjZ6b
	85Aa32S3oFOMzXmCcTnaNdelWbX1hiFYMFbO7qjFyr49aHWgKdMjTiJJTqT85wQxJ5zMPS
	dqYUovpCeQOF926DZuba9BrwhjmSjug=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-XOotyBV7OWGu6S_3I_D4DA-1; Mon, 31 Mar 2025 10:05:25 -0400
X-MC-Unique: XOotyBV7OWGu6S_3I_D4DA-1
X-Mimecast-MFC-AGG-ID: XOotyBV7OWGu6S_3I_D4DA_1743429924
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-22406ee0243so64318055ad.3
        for <fstests@vger.kernel.org>; Mon, 31 Mar 2025 07:05:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743429924; x=1744034724;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lbJE47OqdqR3/52t5jOg708wyYmsdkilsHpLK6arp/s=;
        b=A4e+m4Xv1nEwFBJN2TGoW7gXVgmPtN85Xc/zE3C+jD3Tw8HmGZJOWT3rpMAQNpzRsH
         KKoctm7hwi21TvUIsrf8zYGDEph/cygWCCZTFuP17m9a2iMkWfiO3eeCXa3eZPorR9Eu
         hXbpUHfeoGFiLaAtv6ByP+dH0DPTStSpkTDADeJq4uEL0Enh93+eXwkOkantXokXg1l+
         IE+I3KUoUOof0o8nIlWIKdWLVw2iMrph86pCf/Bd0siLM+0BWnqJyMRC7RIDgMuQof8u
         vfDtout3bV9VhZyuoYbpXi09tXu3gzE0pArWaaYYMJ2xRd13dA4CLz0pFO32eUs8jbNf
         syAA==
X-Gm-Message-State: AOJu0YzLSSVCH9RET+hF/8k3QM8VUPgMXnlbD5ISI9aesdyfif/UKJOc
	QZdfE3F5KWwyfdXHRa2BRkUA2XA+QwF+bh0PXuuKUqz6DdhF7MJRaEVahuElLK62E+8h0PGAeQZ
	5vyQOFzw/tVvLP1ASSt+UrbVmSStyUj9xKx7mT/q9LunWOc+0jaD3reY=
X-Gm-Gg: ASbGncsZ56u4eM9t1zAP/QZSuLzO+T0fFQhIWcl8pPM0CgcKP9FTFlHIKdozuil4F7v
	4Ia1DW34lzSIuS496BEY7U3NXWsYDD7tEN4nbostsH6NCYfpGZoZxIehNk6jhj6Ya72ILSsbHk6
	/nhW6OSY8e8CVdYnUiY/Q9og5TZYA6BIAKbfxaz80l/HNQDFGh5EJ2WvafqlO4MGtyLA1c9YmXr
	dmYsj+ID3ovaO4UdQyeLhJywGoIUNwWQicPjPAH9D8nVuGM9ObtoyjnTP8+qErjYSsCOlTNSIg+
	hwzQsCPqiOiHvZWQZrxeEnx1LFSgRB3BqsqmHbo1qgAf2KG0cEt6UhNk
X-Received: by 2002:a05:6a00:2e18:b0:736:2ff4:f255 with SMTP id d2e1a72fcca58-7398043955emr13493803b3a.15.1743429924374;
        Mon, 31 Mar 2025 07:05:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGOm+wZTjpuHBz9/z/NZkXD5KYjRzV24qYWQ5XAIB3MRLSHrrSWS1KF20c3rGNnimE6+Wshjw==
X-Received: by 2002:a05:6a00:2e18:b0:736:2ff4:f255 with SMTP id d2e1a72fcca58-7398043955emr13493763b3a.15.1743429923958;
        Mon, 31 Mar 2025 07:05:23 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7397109d361sm7142605b3a.138.2025.03.31.07.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 07:05:23 -0700 (PDT)
Date: Mon, 31 Mar 2025 22:05:20 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	david@fromorbit.com, djwong@kernel.org
Subject: Re: [PATCH v4 5/5] fstests: btrfs: testcase for sysfs chunk_size
 attribute validation
Message-ID: <20250331140520.r57xfhsijfiltfct@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1740721626.git.anand.jain@oracle.com>
 <8b6df6ccabf016310063e75117759c835931f70a.1740721626.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b6df6ccabf016310063e75117759c835931f70a.1740721626.git.anand.jain@oracle.com>

On Fri, Feb 28, 2025 at 01:55:23PM +0800, Anand Jain wrote:
> Checks if the sysfs attribute sanitizes arguments and verifies
> input syntax allocation/data/chunk_size.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---
>  tests/btrfs/334     | 19 +++++++++++++++++++
>  tests/btrfs/334.out | 14 ++++++++++++++
>  2 files changed, 33 insertions(+)
>  create mode 100755 tests/btrfs/334
>  create mode 100644 tests/btrfs/334.out
> 
> diff --git a/tests/btrfs/334 b/tests/btrfs/334
> new file mode 100755
> index 000000000000..532fe37a0489
> --- /dev/null
> +++ b/tests/btrfs/334
> @@ -0,0 +1,19 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 334
> +#
> +# Verify sysfs knob input syntax for allocation/data/chunk_size
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +. ./common/sysfs
> +. ./common/filter
> +
> +_require_fs_sysfs_attr $TEST_DEV allocation/data/chunk_size
> +verify_sysfs_syntax $TEST_DEV allocation/data/chunk_size 256m

Same review points with patch 4/5.

> +
> +status=0
> +exit
> diff --git a/tests/btrfs/334.out b/tests/btrfs/334.out
> new file mode 100644
> index 000000000000..f64f9ac09499
> --- /dev/null
> +++ b/tests/btrfs/334.out
> @@ -0,0 +1,14 @@
> +QA output created by 334
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> -- 
> 2.47.0
> 
> 

