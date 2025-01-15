Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B3315D5C5
	for <fstests@vger.kernel.org>; Wed, 15 Jan 2025 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736955217; cv=none; b=GJ4eE75nd8IDWGLShj+I3YFHEPY6RHIU7RYx3fDpGDIPloe27bCdU09cE85X5AD/TfqCHTdWR3ECYsfOL7sZBobhmxNdScfSnvkDsScwZeSwTQ/04ZqEm+hjyOTBlDgK7dvwlqW4/1CxSbwjN7oWEgTXVs44lhab5EThBR922uA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736955217; c=relaxed/simple;
	bh=8Koq0cDmgjknDctgrBiiSvW1wuDmiLFRINcH+m+RgAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+nJk6Ao/1vFnJy9Rcpzge44N/K4DiTZvqADQEZr2T/Aa90NFWuoE9FkzhptCMP4ITi2U8nq3TxOWrUeqft6w8xVJ8tJzS23gXWOWmq/9OZq3VlVVzMmAfCpbtqP6f3lY8Sdif408trEImgYFQtMXqUi5aASReTFrUU4wkLTRDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZNJJZmoP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZNJJZmoP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1736955214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FV7OZYrCTuMqaDKhF7SFkKjXTg1pxi1RaFuxGcXJosI=;
	b=ZNJJZmoPwz3GeUUsYqJlhExMtCpKJVIUq0GkdoWSxn/dM6Cy0URsgLOMv4sjYpnayFEKuv
	xBwlUPReWLYjL+grBn6kuJ+XE0GS+we+a7Wts2zEZb4toKw9fbKYV72nXv3DhgTMdhuffG
	f+ZensCGmk8mdlIQAL9QyUY18yVyxw8=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-3Sgg5rGCP3-p-JbnmwOYOg-1; Wed, 15 Jan 2025 10:33:32 -0500
X-MC-Unique: 3Sgg5rGCP3-p-JbnmwOYOg-1
X-Mimecast-MFC-AGG-ID: 3Sgg5rGCP3-p-JbnmwOYOg
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-2f129f7717fso12513990a91.0
        for <fstests@vger.kernel.org>; Wed, 15 Jan 2025 07:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736955211; x=1737560011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FV7OZYrCTuMqaDKhF7SFkKjXTg1pxi1RaFuxGcXJosI=;
        b=GvG0oA79ckq1+68fnEAfNGpwolkH04uC+FzBV8gY4OcsGePyYcZoTbDC0+jRP/fNbx
         3hZ6I36Yrj2noCrfgJUNy9XvKS2252TJ3sXPaaOhmUiAhnLpeVkSPSgC4ehNvdrQEPDO
         k66/wwoSjfhnOi/giEI55hhPvfVsqtpCv6gyFLZbf4s7921n+sSipXB95OP5T4yMftzh
         wX2DDAqs8c5oOQ0uHWn1L1IQzWzEckHPkpCIFPZC8ztHP00oc0KYBpOlwrVFs14jyR0S
         FA5MU/P/xFFt8sRQZ4tdyuFhSaSWDzuvBohFE1iKz9vtwo/Qlj41YBZNVz6MqB+amGL/
         j6XA==
X-Gm-Message-State: AOJu0YyZNfwhUq+fOsrj/Y50AJxlkjN2vRDzzOit6W3M1tz/d/1gkErz
	kPEGBA9/bdjzt6Q0PFJNCSgwllZEoy5NDRqWO5ZzWdbkVckasgE0aw8RRBXJfajWwXTdgrZM5g7
	CTg4ypoIKzonR94mCtxPBfuQarVvWdOa+wHisv2ZGJW9EJoLPs0R9/fhVUyf1Knq+Dg==
X-Gm-Gg: ASbGncuK7GlzQNpU3c93QAryPAL18fJjAOf2L4jcv0tLX8JcG6bh2lHqi+7rQfezPG/
	BJMo79/ISrrvkhSrp5Pi1L0yYQz2Vh8U9FfE2yoLw85YCkQu9kI5NJdEsYHAv8CzoN6ntuIt8Yh
	ynlfbn1tnPUe/qGCJ7h0V0U4XS6Ww+zIevknV/XroOfJtzb8tLODQELRcJiwKImCE8pMglzl0bE
	KLoUXkCBNGALJiFoOpVJ8t0z7x0LroTQzd8png/Bnsj1/t+SeNaavjl1ce22lPt8gjQXXMFciPy
	adPZhyZBCrsQByd5GYoGtw==
X-Received: by 2002:a05:6a00:35c6:b0:728:e1f9:b680 with SMTP id d2e1a72fcca58-72d21f30e46mr39790246b3a.6.1736955211029;
        Wed, 15 Jan 2025 07:33:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxp4LOBX0nC3Rvz7L8fLORwgzvAzVkO6+Ojv4LDON967yJxXPvEI99r1p/QVx53WAQsG7GBg==
X-Received: by 2002:a05:6a00:35c6:b0:728:e1f9:b680 with SMTP id d2e1a72fcca58-72d21f30e46mr39790215b3a.6.1736955210591;
        Wed, 15 Jan 2025 07:33:30 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a935csm9593454b3a.179.2025.01.15.07.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 07:33:30 -0800 (PST)
Date: Wed, 15 Jan 2025 23:33:27 +0800
From: Zorro Lang <zlang@redhat.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] include/builddefs.in: ignore unused-result warning
Message-ID: <20250115153327.izjczrhtpd2yjfjc@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250106095906.330877-1-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250106095906.330877-1-ruansy.fnst@fujitsu.com>

On Mon, Jan 06, 2025 at 05:59:06PM +0800, Shiyang Ruan wrote:
> When build xfstests, a lot of "unused result" warning are reported:
> 
>     [CC] write_log.lo
> write_log.c: In function 'wlog_record_write':
> write_log.c:205:13: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
>   205 |             write(wfile->w_afd, wbuf, reclen);
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> write_log.c:209:13: warning: ignoring return value of 'write' declared with attribute 'warn_unused_result' [-Wunused-result]
>   209 |             write(wfile->w_rfd, wbuf, reclen);
>       |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>     [CC] random.lo

Hi,

I never hit this build warning:

# make
...
Building lib
    [LTDEP]
    [CC] write_log.lo
    [LD]
Building ltp
    [CC]    doio
    [CC]    fsstress
...

Besides that ...

> 
> Mostly are calused by not using the return value of read()/write()/...
> Ignore this warning by adding `-Wno-unused-result` to CCFLAGS.  This
> won't cause other problem but make the log clean.
> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  include/builddefs.in | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/builddefs.in b/include/builddefs.in
> index 7274cde8d..edf87ff00 100644
> --- a/include/builddefs.in
> +++ b/include/builddefs.in
> @@ -75,7 +75,7 @@ HAVE_RLIMIT_NOFILE = @have_rlimit_nofile@
>  NEED_INTERNAL_XFS_IOC_EXCHANGE_RANGE = @need_internal_xfs_ioc_exchange_range@
>  HAVE_FICLONE = @have_ficlone@
>  
> -GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall
> +GCCFLAGS = -funsigned-char -fno-strict-aliasing -Wall -Wno-unused-result

I'm not an expert of gcc. From the manual of gcc, it says:

       -Wno-unused-result
           Do not warn if a caller of a function marked with attribute "warn_unused_result" does not use its return value. The default is -Wunused-result.

Looks like the "-Wno-unused-result" works for "a function marked with
attribute warn_unused_result", e.g.

    int __attribute__((warn_unused_result)) foo(void)

I think fstests doesn't use that attribute.

Thanks,
Zorro


>  
>  ifeq ($(PKG_PLATFORM),linux)
>  PCFLAGS = -D_GNU_SOURCE -D_FILE_OFFSET_BITS=64 $(GCCFLAGS)
> -- 
> 2.43.0
> 
> 

