Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0656820BB31
	for <fstests@vger.kernel.org>; Fri, 25 Oct 2024 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729875241; cv=none; b=LFr16+gOSKwE85zcrc6TmaXwAHye7CMon1CVBdbkneaK33uvI9T3Kx22c15dMkk80QNyNU7P1qNKzeu9K0amXMsZ3Xr55Kwzt5xt41iBVZseboJjNHupGtCvbRir8cJ84tDzo1X6JGoUMb1hHvju3hMSbqiJmI1MbBD/EPl/9c4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729875241; c=relaxed/simple;
	bh=sSYBq/xF/blFhnlo5Vs+Onf4gnOIphSaPeNe7ovGKUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxLxre1WWsO+wpoeflX0fCA0aPm/LuxqmgLemwycwlPtoi1ZUdCyYGXPUmBeq+75OR6GW9+X7HPPiwi2mNz7z8zvFwycvc010ie9w3G0A1yDI44Zz7GewLwPTIQ7gMRiUbOTmyZKlJfW1I6a3QKLg6azC4yEC/Mj7F0irgmpAY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fT4dZ9aL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fT4dZ9aL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729875236;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bLkaSdhoS06au728fQoj3BRyrW97t5u+D9r7+bwp0Y0=;
	b=fT4dZ9aL9QE1Fgfzp1G/94ryMOnVzuaAZMNhdRu631csGPbDYCk8bqQtczitTSeR1F02Ew
	9j9NylE9KRzKTKzN0TDlSYSzkxmxT0kOzHUcA18RaJRB2fFPxg2PBMZ+IFoYQpNNlzYNm6
	6Wgpoe2e+Y064VeGDVnmCjIYXgExIrw=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-0QSxcJr0OP6GztdYiSkSCg-1; Fri, 25 Oct 2024 12:53:53 -0400
X-MC-Unique: 0QSxcJr0OP6GztdYiSkSCg-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71e4fa3eaafso2329871b3a.1
        for <fstests@vger.kernel.org>; Fri, 25 Oct 2024 09:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729875233; x=1730480033;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLkaSdhoS06au728fQoj3BRyrW97t5u+D9r7+bwp0Y0=;
        b=TImnYpHI3D3VcU4Jxd9rEbTikn7sLK5QIsR4F7eYmTL7+8Jxx/D5SlW3VtxJCw3Era
         P4pxiBc1fHR5M0MCVcaV8QtIzRnTatyQ0V786wd/iVlZtWXhFXn7pxgRCoiFGuJTDjog
         FMZGTxy8xorOo6TFLL6xDJjsInqEtEFuNmPzEhOhhxoDPkFnwgFJWt6CcsWl+OlJmI4h
         NOhLXeMBR5gMF6guuD0ZsRRa+MxXfRnljmesffu6IEMkT0VVPdGPC4A3k43XiAmB9qyj
         oOTqBp/6UZkuuymb5D3Ua2awU9zc3aMMGLQmh1iCY+ljRRoVCO6Xu6tTZRvNl803k8PW
         FNHw==
X-Gm-Message-State: AOJu0YwAnA/R1/edEoHeW3dGwrhOWBmk9sQWyc3w8rKQIe4ZS+nXQkxU
	LwgyKcnhiz+8KPrn2aVyvjwNeh5Sx7Xpv91+teMPmalnbEjMiJ1/SQzwPY/sucQNvMiWmGA60Oc
	7b6VkBplfHKJ4bvsBLUnRVJjAIu+uR+1gbsE4FHhG43wm4mTqs3DAGkg=
X-Received: by 2002:a05:6a20:c997:b0:1d9:1dcd:b22c with SMTP id adf61e73a8af0-1d978bd014amr12289504637.47.1729875232804;
        Fri, 25 Oct 2024 09:53:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3iQ8c47Xa00f7HCNeZ7ROeMpT/AsSNfyZt7nMop5zeAlAtdECQhOSzT5BQ/Y7HGoyr4VOEA==
X-Received: by 2002:a05:6a20:c997:b0:1d9:1dcd:b22c with SMTP id adf61e73a8af0-1d978bd014amr12289474637.47.1729875232381;
        Fri, 25 Oct 2024 09:53:52 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057931abesm1279778b3a.73.2024.10.25.09.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 09:53:52 -0700 (PDT)
Date: Sat, 26 Oct 2024 00:53:48 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH] btrfs: test remount with "compress" clears
 "compress-force"
Message-ID: <20241025165348.dgtgksykvpkfh3mb@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <c0bbe053db28eb35daf4061bf832278305f9656c.1729855555.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0bbe053db28eb35daf4061bf832278305f9656c.1729855555.git.fdmanana@suse.com>

On Fri, Oct 25, 2024 at 12:27:01PM +0100, fdmanana@kernel.org wrote:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Test that remounting with the "compress" mount option clears the
> "compress-force" mount option previously specified.
> 
> This tests a regression introduced with kernel 6.8 and recently fixed by
> the following kernel commit:
> 
>   3510e684b8f6 ("btrfs: clear force-compress on remount when compress mount option is given")
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>
> ---
>  tests/btrfs/323     | 39 +++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/323.out |  2 ++
>  2 files changed, 41 insertions(+)
>  create mode 100755 tests/btrfs/323
>  create mode 100644 tests/btrfs/323.out
> 
> diff --git a/tests/btrfs/323 b/tests/btrfs/323
> new file mode 100755
> index 00000000..fd2e2250
> --- /dev/null
> +++ b/tests/btrfs/323
> @@ -0,0 +1,39 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (C) 2024 SUSE Linux Products GmbH. All Rights Reserved.
> +#
> +# Test that remounting with the "compress" mount option clears the
> +# "compress-force" mount option previously specified.
> +#
> +. ./common/preamble
> +_begin_fstest auto quick mount remount compress
> +
> +_require_scratch
> +
> +_fixed_by_kernel_commit 3510e684b8f6 \
> +	"btrfs: clear force-compress on remount when compress mount option is given"
> +
> +_scratch_mkfs >>$seqres.full 2>&1 || _fail "mkfs failed"
> +_scratch_mount -o compress-force=zlib:9
> +
> +# Confirm we have compress-force with zlib:9
> +_mount | grep $SCRATCH_DEV | grep -q 'compress-force=zlib:9'

How about:

grep -wq 'compress-force=zlib:9' <(findmnt -rncv -S $SCRATCH_DEV -o OPTIONS)

> +if [ $? -ne 0 ]; then
> +	echo "compress-force not set to zlib:9 after initial mount:"
> +	_mount | grep $SCRATCH_DEV
> +fi
> +
> +# Remount with compress=zlib:4, which should clear compress-force and set the
> +# algorithm to zlib:4.
> +_scratch_remount compress=zlib:4
> +
> +_mount | grep $SCRATCH_DEV | grep -q 'compress=zlib:4'

Same as above.

Others looks good to me.

Thanks,
Zorro

> +if [ $? -ne 0 ]; then
> +	echo "compress not set to zlib:4 after remount:"
> +	_mount | grep $SCRATCH_DEV
> +fi
> +
> +echo "Silence is golden"
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/323.out b/tests/btrfs/323.out
> new file mode 100644
> index 00000000..5dba9b5f
> --- /dev/null
> +++ b/tests/btrfs/323.out
> @@ -0,0 +1,2 @@
> +QA output created by 323
> +Silence is golden
> -- 
> 2.43.0
> 
> 

