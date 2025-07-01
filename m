Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97F027A127
	for <fstests@vger.kernel.org>; Tue,  1 Jul 2025 14:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751381778; cv=none; b=oANT5Hz9P9CgEb11pHbxzYdaZerXikSCCLR7wRxzTeGT7iB/670+YZv9R91kC2gUPuMNzykJzQ+XmkKJSscOCRgvRk5/NK3vYcPe32zl3tdJEafzdDMNd+k4gb8F2vsKqtdCpNEOXs2EJjonqKyI11DgqtQZZgYllmD242GWCF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751381778; c=relaxed/simple;
	bh=jvuexJOYZveqFgLJvIMrTzr0AD/7v+WwKZtlFKufrEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FeVf2BjGR5qKhNrUaQyBzERf4bDj8fNU22hBHqlTpSsMMq1JeB/6sdnbolfmGBaBtMdNuO/6OE3LfGMCi2FnxOvRCm7LSeEVO9ZRPA3SztzEeKRjJh8oplOi9n979IChRzOykDO0YGftYAbmBByKHUKfKSsvVPGZ5dY0EvCGo6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bU9WipkO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bU9WipkO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751381775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nXPDzUcvqq06M77VS5WtNkCRVrYbBSSbiWNXP2vd97c=;
	b=bU9WipkOlhJm+wWdM1bOLHzshuLPv3LfgINGMYUUY40G/Gia1XRHh9LJrk9JDFunSPTbR9
	zN0YQyCIoAYaTmTDRprScEZl+S9Ni5+b0Ok6k0xKm+MJ0XFff8f1qhrr4TiRGRgluMWHOH
	sAdNjqEYNFXDvj+irsvo+sE6nGOxzck=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-Zb4jjgpWM3eXa2OPak2_uA-1; Tue, 01 Jul 2025 10:56:12 -0400
X-MC-Unique: Zb4jjgpWM3eXa2OPak2_uA-1
X-Mimecast-MFC-AGG-ID: Zb4jjgpWM3eXa2OPak2_uA_1751381772
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b31814efd1cso4351887a12.3
        for <fstests@vger.kernel.org>; Tue, 01 Jul 2025 07:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751381771; x=1751986571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXPDzUcvqq06M77VS5WtNkCRVrYbBSSbiWNXP2vd97c=;
        b=IapxusskDaLg2e/RDOoV2lFNcGXMY+RsgeK+xL8nLvhQtsIsuVl/Y5mXLiKfSKtKTs
         r6DE9LbtQUsj/fUFPLRU8xTBfXyB8pX66K4la1hC5cg3XZt1c78w4KQzCVESdR+9bTRB
         z5sFOgQaYt1qgxpUaz0xyBzWf9+OATb/sK0YHH6o2T//a+A+91Soi7cPaqwu7gKbPjdG
         oIzx95LeGDM895XFP4lEDiEk8/N0xFkE3mnQUoCxxaSPA40d0fo5iMyUocHi1b3+VMbm
         bUVl1gP/FFhTPm+7uneze14ea6dDR0nHT5c8JY3vLxFGH/uwS7fKZ1qbHYmXwDREJGg7
         19dg==
X-Forwarded-Encrypted: i=1; AJvYcCWn3a54ndF+mgh8GkFbAFDEEYqArdmWp0AC/owoOjapAXnPL0GV44OzFGhezemoYx3CmVHi8kte@vger.kernel.org
X-Gm-Message-State: AOJu0YzF3Wk2hsUKCRIgL7tXmjhGKF71Rc0CtLRTgoJAoJe1dE8Jaub7
	jQqSQly7W0bI54CAWo3rz8ZJczrt6zyirb4v+marDjwofLl6u5yrhCh9yOAwFGVdx+xqkeoSZhJ
	gxLQVhrHnJQ5R1kIsy4C6rfhFezb9gl8wO5VJOEHKbhcKvDTrR2Z+KdtZtEzYgKJ8aRY=
X-Gm-Gg: ASbGncsBDiEROaU2iRQC8sCsOCOFYfQoXm6dLzhzbkf1uBoSUFjlIyhO3ThsLTs9Fv3
	SKLOBjw5iw9OBsi++9kuynTy+iHpb2SosF0Btau6oVDA5tYi5hpN93oHvecoW1goERPOGEOYReu
	DbQxmYlKv3Ma8igoBkDeGBg9MSgIe8d8fUR+l/RdBandOalw2VZZ+Md+0NYCmr+waa1KFJA7dBs
	Yopetrq874zyv+mzRc2BPOYdQrM+vi4TDPEOtVPa5fDg1Fyvs/wmy1d6p1GBq+bTUGPcBD2KCA2
	m88uEHpcRslTJGJZGruPSbspZTEpz3KIvk+FsDYj5CWxCi0e3aRXm8Roh2/xbzE=
X-Received: by 2002:a17:902:e78f:b0:235:e8da:8d1 with SMTP id d9443c01a7336-23ac2d8635cmr261455985ad.8.1751381771338;
        Tue, 01 Jul 2025 07:56:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFLkmB1wAhsIlceWu1ONxBQU/fOi/8NgTjc2Er0ditpvgRC51YYj9gFkUkUu5tHV8iAgrVRCQ==
X-Received: by 2002:a17:902:e78f:b0:235:e8da:8d1 with SMTP id d9443c01a7336-23ac2d8635cmr261455725ad.8.1751381770920;
        Tue, 01 Jul 2025 07:56:10 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb3d11b4sm109306405ad.254.2025.07.01.07.56.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 07:56:10 -0700 (PDT)
Date: Tue, 1 Jul 2025 22:56:06 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] common: add proper btrfs log tree detection to
 _has_metadata_journaling
Message-ID: <20250701145606.2mxdnldtcp7hcur2@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250630010253.30075-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250630010253.30075-1-wqu@suse.com>

On Mon, Jun 30, 2025 at 10:32:53AM +0930, Qu Wenruo wrote:
> [BUG]
> With the incoming btrfs shutdown ioctl/remove_bdev callback support,
> btrfs can be tested with the shutdown group.
> 
> But test case generic/050 still fails on btrfs with shutdown support:
> 
> generic/050 1s ... - output mismatch (see /home/adam/xfstests/results//generic/050.out.bad)
>     --- tests/generic/050.out	2022-05-11 11:25:30.763333331 +0930
>     +++ /home/adam/xfstests/results//generic/050.out.bad	2025-06-30 10:22:21.752068622 +0930
>     @@ -13,9 +13,7 @@
>      setting device read-only
>      mounting filesystem that needs recovery on a read-only device:
>      mount: device write-protected, mounting read-only
>     -mount: cannot mount device read-only
>      unmounting read-only filesystem
>     -umount: SCRATCH_DEV: not mounted
>      mounting filesystem with -o norecovery on a read-only device:
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/generic/050.out /home/adam/xfstests/results//generic/050.out.bad'  to see the entire diff)
> Ran: generic/050
> 
> [CAUSE]
> The test case generic/050 has several different golden output depending
> on the fs features.
> 
> For fses which requires data write (e.g. replay the journal) during
> mount, mounting a read-only block device should fail.
> And that is the default golden output.
> 
> However there are cases that the fs doesn't need to write anything, e.g.
> the fs has no metadata journal support at all, or the fs has no dirty
> journal to replay.
> 
> In that case, there is the generic/050.nojournal golden output.
> 
> The test case is using the helper _has_metadata_journaling() to
> determine the feature.
> 
> Unfortunately that helper doesn't support btrfs, thus the default
> behavior is to assume the fs has journal to replay, thus for btrfs it
> always assume there is a journal to replay and results the wrong golden
> output to be used.
> 
> [FIX]
> Add btrfs specific log tree check into _has_metadata_journaling(), so
> that if there is no log tree to replay, expose the "nojournal" feature
> correctly to pass generic/050.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
>  common/rc | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index 2d8e7167..a78b779a 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -4283,6 +4283,14 @@ _has_metadata_journaling()
>  			return 1
>  		fi
>  		;;
> +	btrfs)
> +		_require_btrfs_command inspect-internal dump-super
> +		if "$BTRFS_UTIL_PROG" inspect-internal dump-super $dev | \
> +		   grep -q "log_root\s\+0" ; then
> +			echo "$FSTYPE on $dev has empty log tree"
                               ^^^^^^
                               FSTYP




> +			return 1
> +		fi
> +		;;
>  	*)
>  		# by default we pass; if you need to, add your fs above!
>  		;;
> -- 
> 2.50.0
> 
> 

