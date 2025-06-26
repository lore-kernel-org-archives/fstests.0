Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE263203706
	for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 20:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750968347; cv=none; b=dDnuJw8Yp1dx10xWErcaivYD4q8S+GpTo0DpU4rBGwIhuiuLQNmRgRy/J9tSqCHhm8Ryzcmhx0qoow4huIw2X+6Pk/W8sZGWPzzZMkX6CwNGjtnjuXqN8+CVTbkeCuwz1tik9TQbKtYgrnts/ojhjZJ7F7bU61Ksa/vu7fjVP0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750968347; c=relaxed/simple;
	bh=TvDGSZSvh3879TYSdRuqN8GByKe+rD13D8ChHA3yz80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tF7bofZbNFqfjQXdcMbdWwG6BNRGuRBkE+uwW92sSFs8W9AFOQ5inCtfo0J/nkbX/hlUtqu21QGpKx5KdRx7bzqlfXQwqY7XXhnTV8R9MT1mBTvAN1Alms7pil9bw1uyWQwxn87+d6wpN+LnLRkVz02ExzxKSDyE4YRC1JGnyGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZJOMl/3w; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZJOMl/3w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750968344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4wMWh8rbintp8UAcpY16jcEK30xjRW0K/vW0loiYEMA=;
	b=ZJOMl/3w94XfvqmgnCClsz9Bjg/25K/ruF+77LMPugY2mTL34q2k/lFxxLUZvQ4FKyQWLD
	3Il1jmDVFt8NzsDHvPAzEijz/TfkElTiJ+5NgCJIq8eBdJP5oT67zdSxI3XoFrSezLSMV4
	8BCRTdxxPdEvEnrYd2U7TclXh6/VDQc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-qJuAHu_AO_aQERPOGtjC7g-1; Thu, 26 Jun 2025 16:05:43 -0400
X-MC-Unique: qJuAHu_AO_aQERPOGtjC7g-1
X-Mimecast-MFC-AGG-ID: qJuAHu_AO_aQERPOGtjC7g_1750968342
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-313d346dc8dso1387180a91.1
        for <fstests@vger.kernel.org>; Thu, 26 Jun 2025 13:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750968342; x=1751573142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4wMWh8rbintp8UAcpY16jcEK30xjRW0K/vW0loiYEMA=;
        b=hCUasczFAKtVeOubo9DW+6I5vxKPQQHFC0vhnnGHiFbkUdgmFXE+ASGXTN8QTVXH+h
         mEpqbIfb9PupsDltSk0oDLef4W3qBPhavcB9m9Ct7LnDXnVc2l8Yj75I/6QbSFIosv8X
         90oaZmC3APVT1GbBsTiMN/FkOjS986Tr7Pwq9kSNVQwys043qnfse+8HH+qD5q5xxMXU
         vmaL4bRm2bzJ1u2ED79o/Y+DA2q5FMECXyLd40TPeh7EDn6wgKvkDqtdz5mPS1HkYeDG
         XpPvodAD/Y+Oj2VOnU9EQzqdZL6SvUi4LVccNWuLGAgA6cdzTL5ipV/V6FEHmIm5RKaB
         YTpg==
X-Forwarded-Encrypted: i=1; AJvYcCWBJchdK9HcgC9wuT5kEdMKxAt2eII70TDX2PPUcol8GXEZoqlPU7YtrPCznJXjOiCM+W9M4pmT@vger.kernel.org
X-Gm-Message-State: AOJu0YyvOsSBt6yRAYc2y6sfZEfA81oq7W6o6NGIX5lvk6OHHCAe25Rp
	gTmTckaXkZQ4Repqu/tQyeCb/mLoSpYQIbWvXOd6sVbKKfyK/E2Okarsr+I5vMIxYVP+Iwfp2Ts
	QCyyNdH/0HSTo+bGhcK0i+bAGII9n9HGOa5RgN9w8Lk13dyTWxSwQMuYxbEo=
X-Gm-Gg: ASbGncvYIvBXR65zrnpmIqvHQzP4K7Eauimwt9tPrDdqaD+1UxtDZQrDuY0thX3rNAA
	mfLMH0Faz3f5vkSfOGlCzEk0xvebFcP3g33lyj2uzL0sDSg5vZZAf3G+gr7dKqok0SXrSOsp0QQ
	IVXm2PN3vtJ9eFyreKIQcyf2bmV+HIygjtKaSSeGoDs+UnOsrjyMNnEo6358xH29xlIljtCML8J
	EFHczrX/NIUyJuELPPkvVIIjOF/7kjF56v4cEBHNFoXmsubQ0IlMjmy8fX2eoefYEk0XTSr5ESG
	MQZ/eCKgo7uHQPGy6xsc5dawvkOYsjMA+B8NxXtBb1YpkyHH5MrFL9al7HjqQhM=
X-Received: by 2002:a17:90b:3890:b0:313:1a8c:c2c6 with SMTP id 98e67ed59e1d1-318c92ec03emr450983a91.16.1750968341865;
        Thu, 26 Jun 2025 13:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqyPAoteVdX367pYrKF1RsNrtPMDsZXBrkPqug9AvpshXmzgDeX3G9SEO3Xtzm+CU+L7SLVA==
X-Received: by 2002:a17:90b:3890:b0:313:1a8c:c2c6 with SMTP id 98e67ed59e1d1-318c92ec03emr450946a91.16.1750968341431;
        Thu, 26 Jun 2025 13:05:41 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-318c13d4bc3sm494501a91.21.2025.06.26.13.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jun 2025 13:05:41 -0700 (PDT)
Date: Fri, 27 Jun 2025 04:05:37 +0800
From: Zorro Lang <zlang@redhat.com>
To: Qu Wenruo <wqu@suse.com>
Cc: linux-btrfs@vger.kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] common/rc: add btrfs support for _small_fs_size_mb()
Message-ID: <20250626200537.pijg3htihst73sgy@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250625232021.69787-1-wqu@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625232021.69787-1-wqu@suse.com>

On Thu, Jun 26, 2025 at 08:50:21AM +0930, Qu Wenruo wrote:
> [FAILURE]
> With the incoming shutdown ioctl and remove_bdev callback support, btrfs
> is able to run the shutdown group.
> 
> However test case like generic/042 fails on btrfs:
> 
> generic/042 9s ... [failed, exit status 1]- output mismatch (see /home/adam/xfstests/results//generic/042.out.bad)
>     --- tests/generic/042.out	2022-05-11 11:25:30.763333331 +0930
>     +++ /home/adam/xfstests/results//generic/042.out.bad	2025-06-26 08:43:56.078509452 +0930
>     @@ -1,10 +1 @@
>      QA output created by 042
>     -falloc -k
>     -wrote 65536/65536 bytes at offset 0
>     -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     -fpunch
>     -wrote 65536/65536 bytes at offset 0
>     -XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>     ...
>     (Run 'diff -u /home/adam/xfstests/tests/generic/042.out /home/adam/xfstests/results//generic/042.out.bad'  to see the entire diff)
> Ran: generic/042
> Failures: generic/042
> Failed 1 of 1 tests
> 
> [CAUSE]
> The full output shows the reason directly:
> 
>   ERROR: '/mnt/scratch/042.img' is too small to make a usable filesystem
>   ERROR: minimum size for each btrfs device is 114294784
> 
> And the helper _small_fs_size_mb() doesn't support btrfs, thus the small
> 25M file is not large enough to support a btrfs.
> 
> [FIX]
> Fix the false alert by adding btrfs support in _small_fs_size_mb().
> 
> The btrfs minimal size is depending on the profiles even on a single
> device, e.g. DUP data will cost extra space.
> 
> So here we go safe by using 512MiB as the minimal size for btrfs.
> 
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---

Makes sense to me, thanks for fixing this test failure.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  common/rc | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/common/rc b/common/rc
> index d8ee8328..2d8e7167 100644
> --- a/common/rc
> +++ b/common/rc
> @@ -1195,6 +1195,11 @@ _small_fs_size_mb()
>  		# it will change again. So just set it 128M.
>  		fs_min_size=128
>  		;;
> +	btrfs)
> +		# Minimal btrfs size depends on the profiles, for single device
> +		# case, 512M should be enough.
> +		fs_min_size=512
> +		;;
>  	esac
>  	(( size < fs_min_size )) && size="$fs_min_size"
>  
> -- 
> 2.49.0
> 
> 

