Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64462F42
	for <fstests@vger.kernel.org>; Sat, 12 Jul 2025 08:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752310420; cv=none; b=o/F1cnvsU5so9oWcWXoW9jiEIOkhponIB6XtIDW2C3EF39mnrAqB6Fp6TFnHnYVNy0p+4IxMign6/p0mnQu8t3Ht3rdO5cZBv/t/KUKVb4z3wt7BYYpj4S/PDOGpG9VmNlv8n+hphFl8bc0dd0/24mDrpgiQ6jZwnCtJoh3UXGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752310420; c=relaxed/simple;
	bh=FgDiNEbTQUM1CBboZW+3GiNtS2r9vMW/FKryylWNcPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEGWVQBH0E8gJKvWGJP8oyFBDc5bHY8rw3ROdTxcykMp7i8wLqnBxhOUrW5DxM2qsib8rlPp6bRm+GDw8jY+v8A8IA5vQj6r2jyC8qVC8tApB9sSqPpjE7uTZbMbGSFMPLNbOpiPIGrjnqnEdV3Os8Oq8hXsikb2c5ECfjzijYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HHQKk7f1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHQKk7f1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752310416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vAIDyz1RGkL7Fi724SZaRxH/j45Q7rhv41xQSVw0siE=;
	b=HHQKk7f11G/fCzb787s6O7SbQwROfnG94ZD4hJV1aPRSJv9SflAhEhvcZFT2UIuhl55122
	VFd27ymhuZ7JDzvM3Nbmvwtew7JYkVJixqr/QhcGPnmN8d+V/nQuOQ1vp7qdOAGZ+O3+XF
	xv+evtSFoD1B/CG/0Il3HgrVUfsK4h0=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-z_ORmoUgO6-4915R67rCWQ-1; Sat, 12 Jul 2025 04:53:34 -0400
X-MC-Unique: z_ORmoUgO6-4915R67rCWQ-1
X-Mimecast-MFC-AGG-ID: z_ORmoUgO6-4915R67rCWQ_1752310413
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-748cf01de06so4282896b3a.3
        for <fstests@vger.kernel.org>; Sat, 12 Jul 2025 01:53:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752310413; x=1752915213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vAIDyz1RGkL7Fi724SZaRxH/j45Q7rhv41xQSVw0siE=;
        b=rctaKRjecQGRfdEji/L8rPs5g6AMdZYU55zGJbkY+w+8ym2CuS0UG09tHeMi3MuTvm
         SM866omo44Bh0akElzIjZS9v0Wo8sSfVGLpyDWrMrIstRHMk9aMTtSpoOl0donbUdBXq
         3qrbrvNn+jcaQHyxOxqd6OYLTsxHEDn1tKWV7VEdkeZZuHLXtHFonhovMnHr4+4gUg+a
         x8erLmMxNmsgKkXQZpGv9sIJqf0ZjDxyC4SoGIfS820al+KonSxhyClywn8lwjc9JboB
         mnjDwKmfnlf7J4bwBhWCmTa85x2j49+UfL/wpDGBBLJ6MHpwMya8B3TKwAew/S7IlYhq
         5Yvw==
X-Gm-Message-State: AOJu0YyWh0UAwYhDG4tvpku58FBnxgdokGUpw7TU/JYCcImsVqD0laSU
	iq6A3240xoljWbWnxQ1hhzk3WGcBXK9gHG94hEjZzatG0goWSPZLE8MAZxiqGUPsXeqnfmIrW4M
	+7ej32hTB7NJlZfAFm/4mqN5ZGSKK+U7XfRsSocO7tW9l9AZ2TS2nNit33RM=
X-Gm-Gg: ASbGncszmwYdu8l87AF1elfUj3uon878q3OgkLUsbumJYgWOjqoymZuZ4Dr78RLS/62
	h2Tw0wuH44mtu3K+59ozNMNfkvCFahvOyKQDs3naIC19RXby8je8CuDbTXIW+CPIEqPBNl0sWpF
	sYzMIRYIfyuoCvf7SIWIZP+kVVY1ziN/yjUp6iPgXHmrToCwMj0TQ2TrZYAF4hVYv04zf6c03Qx
	+Nit1ubkIqu9i/p+UZ8j/JHypMkZB0BLLKDQoaf25WgRK/WpJea5eNhaKxHivUgxbqlQTSgOIu3
	3wyCZmMNG4JYgXRKrYgrP4eSquUHnFB2RNpDmtspFwuL1yJbx6XYs6awL9oOQ3G6HHZ/tD+Xurx
	uqNiR
X-Received: by 2002:a05:6a21:600a:b0:232:6ea3:9255 with SMTP id adf61e73a8af0-2326ea39659mr4404574637.31.1752310413229;
        Sat, 12 Jul 2025 01:53:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBKlciOUeMgwjkYvsVzzcYcnrC96ulKoYgJVXm1bgf0lX9LPSMnyRl4SqR7CY3nqUCCYgPhg==
X-Received: by 2002:a05:6a21:600a:b0:232:6ea3:9255 with SMTP id adf61e73a8af0-2326ea39659mr4404554637.31.1752310412750;
        Sat, 12 Jul 2025 01:53:32 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f4aabdsm6531143b3a.124.2025.07.12.01.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Jul 2025 01:53:32 -0700 (PDT)
Date: Sat, 12 Jul 2025 16:53:28 +0800
From: Zorro Lang <zlang@redhat.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: fstests@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic/365: Add fix hint for ext4
Message-ID: <20250712085328.kjutrljvhy7ht2mq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250711182744.1512486-1-ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711182744.1512486-1-ojaswin@linux.ibm.com>

On Fri, Jul 11, 2025 at 11:57:44PM +0530, Ojaswin Mujoo wrote:
> This test fails on ext4 if the commit 4a622e4d477b
> is missing in the kernel. Add this hint.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---

It's simple enough to catch up the release of this weekend :)

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/365 | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/tests/generic/365 b/tests/generic/365
> index 1bca848a..36cb2530 100755
> --- a/tests/generic/365
> +++ b/tests/generic/365
> @@ -14,6 +14,9 @@ if [ "$FSTYP" = "xfs" ]; then
>  		"xfs: Fix the owner setting issue for rmap query in xfs fsmap"
>  	_fixed_by_kernel_commit ca6448aed4f1 \
>  		"xfs: Fix missing interval for missing_owner in xfs fsmap"
> +elif [ "$FSTYP" = "ext4" ]; then
> +	_fixed_by_kernel_commit 4a622e4d477b \
> +		"ext4: fix FS_IOC_GETFSMAP handling"
>  fi
>  
>  . ./common/filter
> -- 
> 2.49.0
> 

