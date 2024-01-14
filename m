Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994D55225
	for <fstests@vger.kernel.org>; Sun, 14 Jan 2024 12:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cb2j79Nm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705237064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EV9qT0xi0f/EfAM2vWU4Of1/cD06Z7Hd39BHq/uthHs=;
	b=cb2j79Nm1ixy+ajFdndxj/c1a8sXi5t0RsbUr54sdXu9vM2sjmYVK6zVsOEQikZLinoaiH
	NI0LCzDKX4FlbH8ydr1vE3IzJHggPoDDmJGSJJ7jmjgLD5BnOQsLqrrMjjzzMQfM6wFZyL
	5B1ReR857USiDGkvHHiu/9OrR6rwiig=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-504-tyveUM0rNuu0_9bywm-wug-1; Sun, 14 Jan 2024 07:57:37 -0500
X-MC-Unique: tyveUM0rNuu0_9bywm-wug-1
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-598f047f034so570989eaf.3
        for <fstests@vger.kernel.org>; Sun, 14 Jan 2024 04:57:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705237057; x=1705841857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EV9qT0xi0f/EfAM2vWU4Of1/cD06Z7Hd39BHq/uthHs=;
        b=JKCCvsYQrS5I1+Fw7KUbhgOrHn9qWN9GuQDC1Nuaq8XK6iYn5uw7ERTJhQv9y5Uy6L
         b1OA1oQdpnTHg8jS19W/wHHs21/BZLjIGLVD8D0XIqPH11452Zvw9Vr7NGeKSPLrHJRH
         i7XYS95c48K0IPJ2JEqJGkWLWND8kpeS+JOOTMaxrDt3dIXI75zbktZgDTcx54VIPUrU
         DMe702T6mvNccGvQV7v+5UOqdnK7dnXbxSyb5ZAheUN+S1nI6MG1QEySNWgq9UYi7mEy
         dd9f6EKfhztnn8pneq2s516fg+4KygnznE65sym6jsB1WSdsTMvsHdpb/HRBdroYI5zj
         tYtg==
X-Gm-Message-State: AOJu0Yy0Z1ouDHB+G5h4xn5axTzWvTJ9GUfAXgPn00cS/8dkdJ04/s7T
	MZ4XPNv1FKq5jRIj8sZTZ6AMF4uNXpTYjd0bVek4QbdDze4g3UVWaDAe99iWt6lla9fMkwtfksg
	OVPHmF/pBok2PJ0oy3gbwACPK0Q==
X-Received: by 2002:a05:6820:505:b0:596:419f:502e with SMTP id m5-20020a056820050500b00596419f502emr2934059ooj.0.1705237057185;
        Sun, 14 Jan 2024 04:57:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8oOHaDdPTRniQcbYTAy+7Dj4vGLEtue7MrlKUooDRPzKm1Jr6QGHx9j19qpkoultOKB/JDw==
X-Received: by 2002:a05:6820:505:b0:596:419f:502e with SMTP id m5-20020a056820050500b00596419f502emr2934049ooj.0.1705237056928;
        Sun, 14 Jan 2024 04:57:36 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id pt12-20020a17090b3d0c00b0028e3feea296sm1450033pjb.1.2024.01.14.04.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 04:57:36 -0800 (PST)
Date: Sun, 14 Jan 2024 20:57:32 +0800
From: Zorro Lang <zlang@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fstests@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
	Daniel Rosenberg <drosen@google.com>
Subject: Re: [PATCH v2 4/4] generic: add test for custom crypto data unit size
Message-ID: <20240114125732.qpdltz52wrjursl2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231121223909.4617-1-ebiggers@kernel.org>
 <20231121223909.4617-5-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231121223909.4617-5-ebiggers@kernel.org>

On Tue, Nov 21, 2023 at 02:39:09PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add a test that verifies the on-disk format of encrypted files that use
> a crypto data unit size that differs from the filesystem block size.
> This tests the functionality that was introduced in Linux 6.7 by kernel
> commit 5b1188847180 ("fscrypt: support crypto data unit size less than
> filesystem block size").
> 
> This depends on the xfsprogs patch
> "xfs_io/encrypt: support specifying crypto data unit size"
> (https://lore.kernel.org/r/20231013062639.141468-1-ebiggers@kernel.org)
> which adds the '-s' option to the set_encpolicy command of xfs_io.
> 
> As usual, the test skips itself when any prerequisite isn't met.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  tests/generic/900     | 29 +++++++++++++++++++++++++++++
>  tests/generic/900.out | 11 +++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100755 tests/generic/900
>  create mode 100644 tests/generic/900.out
> 
> diff --git a/tests/generic/900 b/tests/generic/900
> new file mode 100755
> index 00000000..8d1b5766
> --- /dev/null
> +++ b/tests/generic/900
> @@ -0,0 +1,29 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright 2023 Google LLC
> +#
> +# FS QA Test No. generic/900
> +#
> +# Verify the on-disk format of encrypted files that use a crypto data unit size
> +# that differs from the filesystem block size.  This tests the functionality
> +# that was introduced in Linux 6.7 by kernel commit 5b1188847180
> +# ("fscrypt: support crypto data unit size less than filesystem block size").

I'll write this part as:

  _wants_kernel_commit 5b1188847180
	"fscrypt: support crypto data unit size less than filesystem block size"

when I merge it.

> +#
> +. ./common/preamble
> +_begin_fstest auto quick encrypt
> +
> +. ./common/filter
> +. ./common/encrypt
> +
> +_supported_fs generic
> +
> +# For now, just test 512-byte and 1024-byte data units.  Filesystems accept
> +# power-of-2 sizes between 512 and the filesystem block size, inclusively.
> +# Testing 512 and 1024 ensures this test will run for any FS block size >= 1024
> +# (provided that the filesystem supports sub-block data units at all).
> +_verify_ciphertext_for_encryption_policy AES-256-XTS AES-256-CTS-CBC v2 log2_dusize=9

Oh, all _require_scratch_... things are in this helper. I was wondering
why it doesn't need to _require_scratch :)

This patchset looks good to me, tested passed on latest upstream kernel.
Thanks for this upgrade. Feel free to ping me, if your patchset be blocked
long time.

Reviewed-by: Zorro Lang <zlang@redhat.com>

> +_verify_ciphertext_for_encryption_policy AES-256-XTS AES-256-CTS-CBC v2 log2_dusize=10
> +
> +# success, all done
> +status=0
> +exit
> diff --git a/tests/generic/900.out b/tests/generic/900.out
> new file mode 100644
> index 00000000..3259f08c
> --- /dev/null
> +++ b/tests/generic/900.out
> @@ -0,0 +1,11 @@
> +QA output created by 900
> +
> +Verifying ciphertext with parameters:
> +	contents_encryption_mode: AES-256-XTS
> +	filenames_encryption_mode: AES-256-CTS-CBC
> +	options: v2 log2_dusize=9
> +
> +Verifying ciphertext with parameters:
> +	contents_encryption_mode: AES-256-XTS
> +	filenames_encryption_mode: AES-256-CTS-CBC
> +	options: v2 log2_dusize=10
> -- 
> 2.42.1
> 
> 

