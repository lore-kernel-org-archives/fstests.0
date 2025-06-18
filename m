Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE0823A9B3
	for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 14:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257560; cv=none; b=A8eoK6hZ+yUOpKVRlvWJ2LKNJ3783EsZy3zKPPcvyJadhtpInKKO8qgsj7kdg0LpPKfJYxxwQa32sXAUeCRYIS6jHhKslK1Z0TYT2eCgPj2XIVISM/cUCHb/oeemOBWlQRHXfe8XzazxZzDTXMFQZ6EaYvzVlj/S0+1/3S24Gd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257560; c=relaxed/simple;
	bh=TSjMrv3ivqBtS8l+1zgvxUrExGyp+JqHoU81Wo/EAPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETCGCk/xeOTgvo/U4iiB5Ds+dau1BnN7A/M4qAGI7WruIL2PkA1l/53LgIQ1wqu+u/iYfUV9URJSmUaswn7EMoCvAc3CklhsWKPb+Sv0LVUsGKc8/xEDOI3o6H12e3lxXGYJcauImstoQXCs+oVdXFBD0ngm2j+SVPyIYt+sLpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KTsLaPC8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KTsLaPC8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750257556;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/lbujesOcRUhQzmZdWrKfbOfmRGUy/UwrzDdeXPTzI=;
	b=KTsLaPC85SG/o/Wq8/OBx2I38peNLmXvPbn9dbtWD1di3XL2mL4V+CDy9y4GEKZwygqKB+
	ZkxSNn+YbeHhcL3TcGy/l8lMjMA9z4Xb4J5mQH7QTEznPAz/gFAs4Zknyg+v3O+7+x5gq5
	ub+QLpw8iaPTQxQKxy1k83IVeysDmvA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-6-VzoI7ihhNnSeKBCSWxtFZg-1; Wed, 18 Jun 2025 10:39:14 -0400
X-MC-Unique: VzoI7ihhNnSeKBCSWxtFZg-1
X-Mimecast-MFC-AGG-ID: VzoI7ihhNnSeKBCSWxtFZg_1750257554
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-31218e2d5b0so10948287a91.2
        for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 07:39:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750257554; x=1750862354;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4/lbujesOcRUhQzmZdWrKfbOfmRGUy/UwrzDdeXPTzI=;
        b=f+U4SBX5Gpq0/y+v48tbKTqRX1T7KHdHDAiCgktnGjoST+hh2GjU3OxgvLgFVM1fX3
         eCUwIR47U3h8Qj5ObUbLrvCEnOX15JT96vhhcBghJFLC095LcmIGPey7O5zfgX0oiCwL
         KJ0NX911H2Ghj1Co/leypWfq8AWhOzk9eZvizx/BYN7w/3AKX2K4WlK46frUJPQJ2Mru
         D4iMpqwsoEiSvaF3fJTj3Dh9xqACMgkDSWx5cBzhnhuXreM368XMM3+Qdh3veWI+fef/
         iSWyddSh4JgkXyBJSdDKfXqKyWsCMxX9e4NZU631kbYtZzlN92oMLbqy5EXn7ME3nZa3
         6Rcg==
X-Forwarded-Encrypted: i=1; AJvYcCXLwHDasNYBdr+HXZ2Vy6caEis0aP9Bprn6Yq/VxY4Hkycq4vqXBysbYDYrHZi5McvVECpcCNsv@vger.kernel.org
X-Gm-Message-State: AOJu0YwpRWARviRPfpNe/luRWPa5hWj6R0vhbDjbMfqs937Be7+pYYdg
	cubMyB0CsujjxxHMBHgrE0yCPFAt3sxJtHNOJrWd8zcMTIKUe2f/b4uIffGcTySkjJB6bsSsffQ
	Bf9+eD26I7yPd2ZkjE5gaBvu+YbWPwdBvIilyGo2esueijmnqjF/lh4b5pbQ=
X-Gm-Gg: ASbGnct7lGlp8Grv/ajkvjvNEp62kvokYScTywV2sy2ASsPjh0qnM6g2nIZH8BPitle
	CqDZofd0XoNApvZgspTyGepDgsd0ccjaveVQHfugLRFqPeM4uO8ii4VLa01L/szit9ettb+SMgA
	58wVindMJQHLJ4lAQILvbEqUOAY9L7GuPRcrNeoTCHd+QBkTINU2V9pglaXn0YDxiC6nH+vGl2Y
	pG3VjrfkPmMTeQXnz6CX3ILNI7lnsVlM6KfULyw1ut86bqfjNPe/6IiCmBSUD4MlJYx8H0g+lQg
	JRXkUvQREZh9SRUEm6f/EXoSKRWkJ8+gDx8n8Lh81cPidlGdOqrcaRNU5Sptb5A=
X-Received: by 2002:a17:90a:d60f:b0:311:d28a:73ef with SMTP id 98e67ed59e1d1-313f1c03416mr30421245a91.10.1750257553620;
        Wed, 18 Jun 2025 07:39:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnGWBMmdJc8iUmgvuGbwHPw62zUgHI/Ruwmx5v/CNbimW40GE4bnSiaJdYV8CdEt56fdrG0Q==
X-Received: by 2002:a17:90a:d60f:b0:311:d28a:73ef with SMTP id 98e67ed59e1d1-313f1c03416mr30421208a91.10.1750257553137;
        Wed, 18 Jun 2025 07:39:13 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-313c1b5129asm12815180a91.28.2025.06.18.07.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 07:39:12 -0700 (PDT)
Date: Wed, 18 Jun 2025 22:39:07 +0800
From: Zorro Lang <zlang@redhat.com>
To: Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v1] generic/622: fix for exfat
Message-ID: <20250618143907.o5oeyq6tmomonr23@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250606102854.3348648-2-Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606102854.3348648-2-Yuezhang.Mo@sony.com>

On Fri, Jun 06, 2025 at 06:28:55PM +0800, Yuezhang Mo wrote:
> After commit(f761fcdd289d exfat: Implement sops->shutdown and
> ioctl), shutdown is supported by exfat, this test can be run, but
> fails because exfat has a 2 second granularity for access_time
> and no timestamps for metadata changes.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> ---

It's good to me and fix a test failure on my side.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/622 | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/tests/generic/622 b/tests/generic/622
> index 0c744fde..a67931ad 100755
> --- a/tests/generic/622
> +++ b/tests/generic/622
> @@ -116,6 +116,9 @@ do_test()
>  
>  	echo -e "\n# Testing that lazytime $timestamp_type update is persisted by $persist_method"
>  
> +	# exfat does not support last metadata change timestamp
> +	[ "${FSTYP}" == "exfat" -a "${timestamp_type}" == "ctime" ] && return 0
> +
>  	# Mount the filesystem with lazytime.  If atime is being tested, then
>  	# also use strictatime, since otherwise the filesystem may default to
>  	# relatime and not do the atime updates.
> @@ -128,6 +131,10 @@ do_test()
>  	# Update the specified timestamp on the file.
>  	local orig_time=$(get_timestamp $timestamp_type)
>  	sleep 0.1
> +
> +	# exfat's timestamp for access_time has double seconds granularity
> +	[ "${FSTYP}" == "exfat" -a "${timestamp_type}" == "atime" ] && sleep 2
> +
>  	case $timestamp_type in
>  	atime)
>  		# Read from the file to update its atime.
> -- 
> 2.25.1
> 

