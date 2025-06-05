Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676C4272E54
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749131718; cv=none; b=uVI7M5+Zre62BccpF8qsFPiqxfNIYHZ8ePBXhMV0AGXRpfCOUAmHCHYJA9YI8HY4RYoI+XYNEHNk63hUFv4fuYw3nvlVZaPzHMvn/9qxT+HvlCPCQr2N0eKDAzrmKezMjAiMFr1uMr3VjhrhFKt47UOKmWTRq4ln5ZVRZgi0ZmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749131718; c=relaxed/simple;
	bh=SctAiA2foXNqJYEjm4cfizK+TOHRUkuQ934+6AeZttw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGSzISTOyTgffdCA9t4l+XjOmRLAT4hMGJhGmRpV5MYdB489ct/iA98qVG1VCbZoMJzoHJl9MgjcTg/WluzhmX3mXgCof1QvJ6TMzHniRpIdm4dRQeMHTMnCOau49nUTdEq7wHMTVJ7sn3Ykqlx1yBnFuJBUgj2aCd4hDF9ktRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PcJ9xB+o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcJ9xB+o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749131714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z/XMxkrrr1TxOmh0FzeoJV9OksOg2fvjSm32Qoykdbs=;
	b=PcJ9xB+o0ijThlHs+QC2ceUeiXvWfus/NItetZLiuApeNpuF3fX3Ssd1ZMcdLPY1W0ek7B
	VEcwGYRhnpMaahiuhdFLlwQtQwSkGn+aXGN+4CbFifcMiOYz6LgFMQAVKBWig90x8QLr6n
	B6N8AjuLf8Xz9ueVpMLv2lzE5P2IpP8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-T9NFFMnfOhGAnZaykmn0Sg-1; Thu, 05 Jun 2025 09:55:13 -0400
X-MC-Unique: T9NFFMnfOhGAnZaykmn0Sg-1
X-Mimecast-MFC-AGG-ID: T9NFFMnfOhGAnZaykmn0Sg_1749131712
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-22aa75e6653so8530195ad.0
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 06:55:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749131712; x=1749736512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z/XMxkrrr1TxOmh0FzeoJV9OksOg2fvjSm32Qoykdbs=;
        b=ov8N+tDeqqr7mt3/3s8ViX6Ut9gcuLIqjpQN2790gSvzXaHEibSx57X7O0lwRq1Mx/
         OjbuZsSS1HLiozmSxCQ/ju1Ku93euAcesZnEUkaIGyQUi7ksUvdjTqo5Dn2/Navz1aVl
         cUojk0uf34kVzIjQ46bN7pzNaCdqhZtMyxQTvvC5rSQVYvRmyJgTTluEjg8DKF/aVC0V
         E+ygdYiTj53q8p6tcVlxerx5ol6V/xy3hmkxyNuR+cQ0boQupGKmLVWpCEkB+xDcumYk
         QMT1vZNX5nzljJxo/7c+uLC9a0rCm4JaCwOTfGmHXs6Qy9PtYMZQuw9t8ZflmLdwT16J
         5svw==
X-Forwarded-Encrypted: i=1; AJvYcCWmuqNcSXoRebVgr8GxRPxwyq70Bf+mWAXZXSQpavWLU5VzsnX/75XhJZyxaYgol3coejXtH5j9@vger.kernel.org
X-Gm-Message-State: AOJu0YxUiRpYZYYxhjs7gKeXVW99VSIeTmQqgPBeJEeDjUUuV39KU47p
	E7wrO4NuvQ/zeiO/KodirgEatmVTVOTZSWlizB+L8NIUjTH78sG04w0GehQfHGlSn8G28RmxXHw
	IiTwhSybIovFIPY6nH4os+J4CEI6HIgCuoeVcQhvc97WxcdXRY1QLACj+548F0yRgwzs=
X-Gm-Gg: ASbGncvqfMxBqvC7eD54qaOcJaaIPBpFOZFTq+eqY0dEasBtbca8lGqyxKTr/2/XYyq
	Gq1gefa0XqrMMVtY9Xn7UEIn/DO2eFNVRiU55IE+yFS3me4btJtwvEPUS0D1VekjrxdLGwVnzh+
	GK9qstwpXk4V5f4sySfvySDMSjB1j2kPbQVYkTIXGiB5PMWt6ps2mNOh0/ajITGGxYWyOvXFfFb
	dh6PQ7RYcsYPkkbTQyosY8Glmfem6PjRazqJT56WKRF1L9gW2b2sme2Ze3N/zDp0OeRwB2Wo/MB
	c+jxMjkwKCCDMiW8yh100R2f237huca3b628EYsm++8IDyDPRBQ2
X-Received: by 2002:a17:902:e944:b0:234:b735:dca8 with SMTP id d9443c01a7336-235e1013660mr82291665ad.6.1749131711737;
        Thu, 05 Jun 2025 06:55:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPeRasX+K/ZN2buQ4TvMBEli7yK2HlC3J8Gb/ufoo79cVnvz1wScp+KlOQbmKyRpGFN2l7jw==
X-Received: by 2002:a17:902:e944:b0:234:b735:dca8 with SMTP id d9443c01a7336-235e1013660mr82291375ad.6.1749131711369;
        Thu, 05 Jun 2025 06:55:11 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cd8d06sm119857405ad.143.2025.06.05.06.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 06:55:11 -0700 (PDT)
Date: Thu, 5 Jun 2025 21:55:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] fstests: generic/730: exclude btrfs for now
Message-ID: <20250605135507.5ofwqd2fwf4lcvtz@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250604062509.227462-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604062509.227462-1-wqu@suse.com>

On Wed, Jun 04, 2025 at 03:55:09PM +0930, Qu Wenruo wrote:
> The test case always fail for btrfs:
> 
>   generic/730       - output mismatch (see /home/adam/xfstests-dev/results//generic/730.out.bad)
>     --- tests/generic/730.out	2024-04-25 18:13:45.203549435 +0930
>     +++ /home/adam/xfstests-dev/results//generic/730.out.bad	2025-06-04 15:10:39.062430952 +0930
>     @@ -1,2 +1 @@
>      QA output created by 730
>     -cat: -: Input/output error
>     ...
> 
> The root reasons are:
> 
> - Btrfs doesn't support shutdown callbacks
> 
> - The current shutdown callbacks are per-fs
>   Meanwhile btrfs is a multi-device fs, it needs to know which block
>   device is triggerring shutdown, and needs to do extra evaluation
>   (e.g. can the remaining devices support RW operations) before
>   triggering a full fs shutdown.
> 
> I'm trying to improve the situation, but until then just exlucde btrfs
> from the test case for now.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  tests/generic/730 | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tests/generic/730 b/tests/generic/730
> index 6251980e..cae6489f 100755
> --- a/tests/generic/730
> +++ b/tests/generic/730
> @@ -26,6 +26,10 @@ _require_test
>  _require_block_device $TEST_DEV
>  _require_scsi_debug
>  
> +if [ "$FSTYP" = "btrfs" ]; then
> +	_notrun "btrfs doesn't support per-fs shutdown yet"
> +fi
> +

Please use `_exclude_fs btrfs`, if you still hope to _notrun it on btrfs later :)

>  size=$(_small_fs_size_mb 256)
>  SCSI_DEBUG_DEV=`_get_scsi_debug_dev 512 512 0 $size`
>  test -b "$SCSI_DEBUG_DEV" || _notrun "Failed to initialize scsi debug device"
> -- 
> 2.49.0
> 
> 

