Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF5E20C313
	for <fstests@vger.kernel.org>; Fri, 25 Oct 2024 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729878602; cv=none; b=doeCRT95psbsEJKUwGIfSpJE1gOFLO7XUU+CLvttUFD3bVRiyve3vrilvh6VJP+nHTNo5Sg9w61PbVLx2W4SYKkr3sf2AVUReEYgXjRn8FmvMlJQs6dGRxX8UE5MpqRHlRh7XiP2Hs/p/lipBkiSxw7ixzp9GDiDEOeY4MwaV/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729878602; c=relaxed/simple;
	bh=RMV97y8AE8pLpriChFbZ/iwuUtYd95nPNz+pLMh+76k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5Dd+RcGuiHUFImM0AzV3breIiQzRLh+90fMqgWmMSurNG3FPSg3ojxtCiPUqGbMssNjA7X7VAtYziASK3lT+Fz1JG4c1QBUEB+x218ACDt2LzcZkTLhz3lybUQ60wVnSRcPFNjykCUC28xxtTslYtJHiyfBOkAjKbCQgRkHzUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EMR8E2+E; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EMR8E2+E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729878598;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SnpXbnZh9dEsGr4idpu/9voSf8Qpjmhn9CzlBKJ1dgo=;
	b=EMR8E2+Ew5ZlXWNTOkEUsgqMvoVVqdo64vbJ38ubvf/k5Izy6NrQfSOYbF9dEFnST7Mv0Q
	3a0vJ04o5Yk8v+Dg/QeRot3ffecJ6nBWPMNX8L+c1mOgSCflZJXSY9pwIeCBNExtrbcX1h
	hZIUWzfFwlrodY8a4cxUGAmwuHizVJg=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-Fvbmx4KGM0eKz8a3IrjOiw-1; Fri, 25 Oct 2024 13:49:57 -0400
X-MC-Unique: Fvbmx4KGM0eKz8a3IrjOiw-1
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71e4fa3eaafso2376931b3a.1
        for <fstests@vger.kernel.org>; Fri, 25 Oct 2024 10:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729878596; x=1730483396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SnpXbnZh9dEsGr4idpu/9voSf8Qpjmhn9CzlBKJ1dgo=;
        b=FwzJiG86UxG88bKV4brahdHGLQ1AKjJiJPWiEjo50dLnZNGocruMxIs+e5MAxrldjg
         8i5Tyk+FooWFK8ckFZ/TIVTz4cL3eGi3PYZR3xzQbUeDHV1/9AA4bnNHDEAGdTG5tzJv
         CIckVpwGKeWi5ZFbv8N6ftB75JDxCXNs/cv/TCYQAv09pUXgNOtHSKwlJBZ7FdbI0m2A
         +l/Az1LyQ4tnGGKfXkJif0Vh04mPvdLl1XO72GKnBhrAcklnwx4VA09LwgFaZioT9NWs
         jv4ByNEkFMd6taUM+0W7+E1gHZNCv3eubtnVOfqqX+tomXMvSgcDFUV3pwxM5tb5UxdH
         fV3Q==
X-Gm-Message-State: AOJu0YwNJBGSmF7Bqyxc6hYiv8nCXWku03SPrlBmkWln/ROWaA9n0qSY
	bSEB+3jSFPeya8JH4YTEK121BO0RCb+PSr16iWoN7iHfvdflIb3MMYRltc1qLfruhrYw1cod0As
	rqXF0YBmRVSsvlD3uYbuR0f+8B9J154SWtz/On0bIyCDF720g+8A4Ein9yS9d+uLsqQ==
X-Received: by 2002:a05:6a00:188e:b0:71d:eb7d:20e4 with SMTP id d2e1a72fcca58-72062f860f6mr464607b3a.8.1729878595815;
        Fri, 25 Oct 2024 10:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQDXbYMv1YHKSRianzhXroudQGM27gBzh/KZgWLzNzAZvAP7bhrTEfa449tbvBBL2MzObGrw==
X-Received: by 2002:a05:6a00:188e:b0:71d:eb7d:20e4 with SMTP id d2e1a72fcca58-72062f860f6mr464590b3a.8.1729878595408;
        Fri, 25 Oct 2024 10:49:55 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72057a0b926sm1330097b3a.129.2024.10.25.10.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 10:49:55 -0700 (PDT)
Date: Sat, 26 Oct 2024 01:49:52 +0800
From: Zorro Lang <zlang@redhat.com>
To: fdmanana@kernel.org
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Filipe Manana <fdmanana@suse.com>
Subject: Re: [PATCH v2] btrfs: test remount with "compress" clears
 "compress-force"
Message-ID: <20241025174952.wmpuqmigei2za3ss@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <c0bbe053db28eb35daf4061bf832278305f9656c.1729855555.git.fdmanana@suse.com>
 <965c0f0b02fbf9d314c2a7192a65e5fd5c0afe53.1729876932.git.fdmanana@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <965c0f0b02fbf9d314c2a7192a65e5fd5c0afe53.1729876932.git.fdmanana@suse.com>

On Fri, Oct 25, 2024 at 06:24:21PM +0100, fdmanana@kernel.org wrote:
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
> 
> V2: Use findmnt instead of "mount | grep $SCRATCH_DEV".

If there's not more review points from btrfs list, I'll merge this patch
to catch up the release of this week.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

> 
>  tests/btrfs/323     | 39 +++++++++++++++++++++++++++++++++++++++
>  tests/btrfs/323.out |  2 ++
>  2 files changed, 41 insertions(+)
>  create mode 100755 tests/btrfs/323
>  create mode 100644 tests/btrfs/323.out
> 
> diff --git a/tests/btrfs/323 b/tests/btrfs/323
> new file mode 100755
> index 00000000..5cafa4b2
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
> +grep -wq 'compress-force=zlib:9' <(findmnt -rncv -S $SCRATCH_DEV -o OPTIONS)
> +if [ $? -ne 0 ]; then
> +	echo "compress-force not set to zlib:9 after initial mount:"
> +	findmnt -rncv -S $SCRATCH_DEV -o OPTIONS
> +fi
> +
> +# Remount with compress=zlib:4, which should clear compress-force and set the
> +# algorithm to zlib:4.
> +_scratch_remount compress=zlib:4
> +
> +grep -wq 'compress=zlib:4' <(findmnt -rncv -S $SCRATCH_DEV -o OPTIONS)
> +if [ $? -ne 0 ]; then
> +	echo "compress not set to zlib:4 after remount:"
> +	findmnt -rncv -S $SCRATCH_DEV -o OPTIONS
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

