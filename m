Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD07317FAC2
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 14:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749135207; cv=none; b=dT/Hh3wWAoYMMALhSBT6ls7KxFym7a67w8KJk3FUGwUGIv5SWNqEU86l39x2zVd3CI3eSm+a+SBd244IWWOj+3QHZFx4Mka1FB0xpizgF8XHVPG/i8woSykj897UGTfs6a1VRooq9ZHgu4EjRWd9AfqhHAYH6rJTpGK3MB8hhbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749135207; c=relaxed/simple;
	bh=DnzmyU3JB821Y4iWKSzFv/n7X5Dp4GSFP6HQky1VZ0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n+bSe9vx/1hX4YUJH0+0p3I3qSw3u0B1ILba0yzNrxbpJT2l1zNAaXmZm7mB1fcbOrWJlNuJiOXZTir0EzDdIo2IEe30dxIu8LiW+TdAqDjlpGu+yNV0jbFweq/AMCV0Ma2qexQLOsdG0km7W4b0MuAdNTdo9ntZrcFyxSyu5lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bMpZ9LJw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bMpZ9LJw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749135204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XWV4KD+k9LM73/d+Ftvbhwvq5xMQqgwsW6O26577zAQ=;
	b=bMpZ9LJwgctOGnsH5LnvCR7MxPf/cC18+qUX40orXL4nJxgTEMe6m4qwMkREONREp2CbHj
	Y/OgJlEKSu/3b22iJZBZN5goZW5HzZ6Mr+dCxxKrJOIGZLMSMsDuzE78TKbz1/5jus7VWS
	8L9IZtPRKvfIOrmnnmBTSLSHxEzFIUo=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570--qeH-KA8OQCOShHAzclcsw-1; Thu, 05 Jun 2025 10:53:23 -0400
X-MC-Unique: -qeH-KA8OQCOShHAzclcsw-1
X-Mimecast-MFC-AGG-ID: -qeH-KA8OQCOShHAzclcsw_1749135202
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-742c03c0272so1614036b3a.1
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 07:53:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749135202; x=1749740002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XWV4KD+k9LM73/d+Ftvbhwvq5xMQqgwsW6O26577zAQ=;
        b=c6Fg7BTtXH3pF45iaG6EZd0HELq7G5k8Btwvh98n8/DmPGcmrCIGmGVfDTvYQ+EP3+
         YOOpVJn4MgOQrcWTPLRI/eE36wHcFJYIZXP2NI9g2566x+UtM5xeJugcxNEDlq2+zOX2
         79LXo6Zbs2/eYwBBZNs4Njgms83qJbJLge3dBmfBvZXebDn+EGJAibvXaP8qSWew3cdv
         8v1QSyDbqZAe2+F+VVSYrfAvO8gZJ2/21i2daPAadWPa+lbHWI5+ClKBnMWiOFqSmGGN
         aNLQKU3HExhr1iNtV60/zaAb0ojotUKKTerZKWkGe5JkeOK7LCSdW0osFQg3+7N3KWrE
         0oMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGweGSwzwaOJIfvS63qt2hh74JlX36/U9dE/nRYClePunyP1lz+OUVh7Qt4V6Lt2RnbfoE5GXg@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi+0S7+mTjUIX9DQSBsjY5whDgKNhXxVm+VuYLdW2TJ08MYphk
	ckXOdJvlY8k6f38El4glBYX+zM/0d2upvTkYeFVWI+TaHqGiUjgUazy0ClnheuToAG3rEn5BA48
	ysOcLkiuS7WCn1d2YwotsouzNGZPqiK1DiKEBkGNYpf0srH7rIGWBL/8+oDs=
X-Gm-Gg: ASbGnctoDglmJuCFiM3GZaEMZSOS+RNMaxtVrrAbhd6GclHr/kdAfIonyPC5O3gib/r
	V9GDdUWTvyi5m1EcDCqr9JpntsxZ8MFtenSw/T5iAOv1NjQeD7Dmjc/bpXlNORLUkMf3Jp9mbvv
	U8tw/2KrgREBa8H3bMA00s9l4YOVIea8mjFAKAd2pw/PJ5JkAd2RI19+BX2d456s88qXrh+9xtl
	RBzN0YsInOlgBYyCqL8DUvGusXQ1tficIb4camWozJvsTRKgDOIzqo2IfIlJFVolE8sQhSvPT1b
	jkI1WAmvFj2fsLJZJrG9gllmc+6B6bLOXhFQB2lQ+Avke7NEEjSV
X-Received: by 2002:a05:6a00:14d1:b0:740:a52f:9652 with SMTP id d2e1a72fcca58-74827e7e8f7mr53489b3a.6.1749135202299;
        Thu, 05 Jun 2025 07:53:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXM7rPbjWgk5G/wk0KzTdGuorqXonjTlB84aGSRDAJvTVwTQXWvO048S2FkRhUY/d35fLVcg==
X-Received: by 2002:a05:6a00:14d1:b0:740:a52f:9652 with SMTP id d2e1a72fcca58-74827e7e8f7mr53463b3a.6.1749135201913;
        Thu, 05 Jun 2025 07:53:21 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeaad78sm12843357b3a.46.2025.06.05.07.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 07:53:21 -0700 (PDT)
Date: Thu, 5 Jun 2025 22:53:17 +0800
From: Zorro Lang <zlang@redhat.com>
To: Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, friendy.su@sony.com
Subject: Re: [PATCH v1 5/7] generic/730: add _require_scratch_shutdown
Message-ID: <20250605145317.4gnj3phueo4bfxpq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
 <20250528091530.1218188-6-Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528091530.1218188-6-Yuezhang.Mo@sony.com>

On Wed, May 28, 2025 at 05:15:28PM +0800, Yuezhang Mo wrote:
> Before testing for shutdown, check whether the file system
> supports it with _require_scratch_shutdown.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Friendy Su <friendy.su@sony.com>
> ---
>  tests/generic/730 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/730 b/tests/generic/730
> index 6251980e..1dce547f 100755
> --- a/tests/generic/730
> +++ b/tests/generic/730
> @@ -25,6 +25,7 @@ _cleanup()
>  _require_test
>  _require_block_device $TEST_DEV
>  _require_scsi_debug
> +_require_scratch_shutdown

Hmm... although this test case really does "shutdown", but this _require_scratch_shutdown
looks weird, due to the g/730 doesn't has _require_scratch, that means there might be not
SCRATCH_DEV. So...(see below)

>  
>  size=$(_small_fs_size_mb 256)
>  SCSI_DEBUG_DEV=`_get_scsi_debug_dev 512 512 0 $size`

... how about

diff --git a/tests/generic/730 b/tests/generic/730
index 6251980e..6b5d3196 100755
--- a/tests/generic/730
+++ b/tests/generic/730
@@ -29,6 +29,7 @@ _require_scsi_debug
 size=$(_small_fs_size_mb 256)
 SCSI_DEBUG_DEV=`_get_scsi_debug_dev 512 512 0 $size`
 test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
+SCRATCH_DEV=$SCSI_DEBUG_DEV _require_scratch_shutdown
 echo "SCSI debug device $SCSI_DEBUG_DEV" >>$seqres.full

Thanks,
Zorro

> -- 
> 2.25.1
> 
> 

