Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0C225A32F
	for <fstests@vger.kernel.org>; Wed,  9 Apr 2025 10:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194170; cv=none; b=nHjeg8DQogIHdMLCHo5L6OMWJl2vzC1dDP+ypHbnAb+xvM1ENUVIbaKtl4AGk13rYZSf1fVHknSP+YaJemMNGa/ybpGhaHXWjDs3DTyoLBfQ8rUdzLBA4U7lvkm3MmHH7szak7FvseyO6ZMDhN60z7O8YboAoMSs5TqEqxNpmOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194170; c=relaxed/simple;
	bh=dcg9diGmOETxHl3X0pFjL22l8wT63J1MgIIDDThjJoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnjxfN7C2Yuvp4keOgIoIjOcWRyzD5UTJhuFpuYcHkqFDAQtleVdJW0UBYAwfo6w+ktKbcf/3bEvP5seoE7Id66YPnnIzHUsJP8/hwRwvrjZQzeRXu/8n2J3qPqnmLpzz7FO2LTlOiutIlXMxNjMQQBgRjZ8JyLMaUeZ5PvoF7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VyJ5xF8s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VyJ5xF8s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744194167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mcrGQST1e8wmHt/n1CJ2fai9C3J4yAUkIfuo/b2aXHE=;
	b=VyJ5xF8sMNoJ6iicFYqLgZj7/QKa3jrDkBm7vAnZOKgyA8h1NRGdShkfD6ypLeGhQcSNsT
	bPP7i5EtAWcyb3bb7nY0adtYHolHYWo8rBB7QjtLR7y2v1MOWBgcf1zywwbqHGbYOXUOZS
	RoxgRflStn92r3HCrXWDY7Vv+x/ZW2k=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-B4Taj8trNvKTYyXJxmZQsQ-1; Wed, 09 Apr 2025 06:22:46 -0400
X-MC-Unique: B4Taj8trNvKTYyXJxmZQsQ-1
X-Mimecast-MFC-AGG-ID: B4Taj8trNvKTYyXJxmZQsQ_1744194166
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2254e0b4b85so5773045ad.0
        for <fstests@vger.kernel.org>; Wed, 09 Apr 2025 03:22:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744194165; x=1744798965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcrGQST1e8wmHt/n1CJ2fai9C3J4yAUkIfuo/b2aXHE=;
        b=g6+sKTrZ+rsiOXGBmj5y6n3KPeyWFC0a6VHu52f8V3bFNEfnmpEm0SSly+LNDClv0D
         02B2iQsBrid+FInpQlL164v0TCLB6/8rPj98LD8PD5tYFfhOmIQgKjES3rA52UmxQgnR
         7ittnalCfF3SlwFBdh8wDzq+3G/+akoqKHdJhdfgJBoX4l9sGKHxWKIIxnD/H6dohTwo
         FYt9YD1KKenNjDpUCDMDIFkzwjhXgWm/ZlbUMfzG83voQ6F1d93zB/nn8ta3EVoXJF86
         04PtVcgnlySCWvLmUU9wIn0Y1ge0GQTirb65Ksof8fYgTuhCsXcs5mfTENSTOg3PYFVm
         0qkA==
X-Gm-Message-State: AOJu0Yzdk43XgvgJRsjUn7FIc0wFj3479IGfJVFvxDEU1zfdhAZ8X+HK
	idQx2zXg/6TrCtWwTPNeRsrrERtmVJG2BOXjeNQXQ9l5IgVQACNWpQLSaAoqm8EhpqcMJqYLnnW
	icrsiEj15UHI3yuY32Ysj9vkbksi0sMJUI45WN6aCkCeOlH5zf27/vy4=
X-Gm-Gg: ASbGncubh2pIYar05FbPEMpptA5iTESw8flNyIGf09dvWfq+k+/XlCXh8WJXELRMerj
	BB94fAa6SsVhHadMaXTLwmZkO8OVHu98vVBYR+lMiVxe7FAgg1wxANLG71bA4oZINY25heFqC2B
	6F9pAdmrdNu82L+WlUpXPN2+IWAipHHazLyFoWBkzZjswGp3VyS7IYQawbCCn66hsBQc2mRBYxL
	kZCYDHEndJDhP7W3IvBipIA2tbidjiKg/FZkmjkiDzO60iJ/S+Vzl+3P/wXi27cdE762rdeHIRZ
	896aizB4XE4M2707c1nfAgDczt7/hafEOLiMtSFh+YBpt/DnRxIe
X-Received: by 2002:a17:902:d50e:b0:223:607c:1d99 with SMTP id d9443c01a7336-22ac3177406mr28365755ad.0.1744194165645;
        Wed, 09 Apr 2025 03:22:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFEZkdchgkOCqLThdgbAgpbOQbj3drE9E5QtEXp78hPTcXegSMcL6XPMa2v3LzeqTILr/DjOg==
X-Received: by 2002:a17:902:d50e:b0:223:607c:1d99 with SMTP id d9443c01a7336-22ac3177406mr28365565ad.0.1744194165311;
        Wed, 09 Apr 2025 03:22:45 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7b628edsm8232085ad.10.2025.04.09.03.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 03:22:44 -0700 (PDT)
Date: Wed, 9 Apr 2025 18:22:41 +0800
From: Zorro Lang <zlang@redhat.com>
To: Anand Jain <anand.jain@oracle.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, djwong@kernel.org
Subject: Re: [PATCH v6 5/6] fstests: btrfs: testcase for sysfs policy syntax
 verification
Message-ID: <20250409102241.vj52t3vqqhoitkdl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <cover.1744183008.git.anand.jain@oracle.com>
 <b4a2791c47d6d5b4ed32762044d0d3dfce24a11c.1744183008.git.anand.jain@oracle.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4a2791c47d6d5b4ed32762044d0d3dfce24a11c.1744183008.git.anand.jain@oracle.com>

On Wed, Apr 09, 2025 at 03:43:17PM +0800, Anand Jain wrote:
> Checks if the sysfs attribute sanitizes arguments and verifies
> input syntax.
> 
> Signed-off-by: Anand Jain <anand.jain@oracle.com>
> ---

This version is good to me,
Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/btrfs/329     | 21 +++++++++++++++++++++
>  tests/btrfs/329.out | 19 +++++++++++++++++++
>  2 files changed, 40 insertions(+)
>  create mode 100755 tests/btrfs/329
>  create mode 100644 tests/btrfs/329.out
> 
> diff --git a/tests/btrfs/329 b/tests/btrfs/329
> new file mode 100755
> index 000000000000..f4faddedf076
> --- /dev/null
> +++ b/tests/btrfs/329
> @@ -0,0 +1,21 @@
> +#! /bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2025 Oracle.  All Rights Reserved.
> +#
> +# FS QA Test 329
> +#
> +# Verify sysfs knob input syntax for read_policy round-robin
> +#
> +. ./common/preamble
> +_begin_fstest auto quick
> +
> +. ./common/sysfs
> +. ./common/filter
> +
> +_require_test
> +_require_fs_sysfs_attr_policy $TEST_DEV read_policy round-robin
> +
> +_verify_sysfs_syntax $TEST_DEV read_policy round-robin 4096
> +
> +status=0
> +exit
> diff --git a/tests/btrfs/329.out b/tests/btrfs/329.out
> new file mode 100644
> index 000000000000..eff7573adb6a
> --- /dev/null
> +++ b/tests/btrfs/329.out
> @@ -0,0 +1,19 @@
> +QA output created by 329
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
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> +Invalid argument
> -- 
> 2.47.0
> 

