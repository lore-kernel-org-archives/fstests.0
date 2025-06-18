Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A51A2EBBBE
	for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 14:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750257778; cv=none; b=P+fpEbK06VlQ+I+mlR9Q57fbeFU+ACk9cqXvhenMRsrlrqofwLywMFaDoQXotzlm14fXSEn90mbCfilK6yx8XBIc/0ETuO0GOatpMAub3ApsJ4USY394sHFb8QVIJIUPZ2/kmZARqTsl3Ix0zYJY6X86muam7wuJR3Kn6KNi2Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750257778; c=relaxed/simple;
	bh=YDMa/wQnHAZGGIVM4hjjMQrI1FR4JMNJaz4jalTqQA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqkS30ODW7ZOVSJ23dOJyHFr+NtKViZWnSCySMrS25BGuV3z4cwUOwZK0zYqh70C/jLV1BFf7V4qWqaWWn3aFzzjACY8S1Re8OmZOD/6JnoIlD0dBUKCmZDCe3SxiZvv3LTVb2y4Nwh556+QCk4mfU3n53m6ZUHBd2emXhk+Dyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KOWLwTdn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KOWLwTdn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750257775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jYplESCF19MHBq4tvpJlFlIqBQP+mI2cKNKUPE9m/Nw=;
	b=KOWLwTdn0RfaY64tvh8W2hUAQLUR5RRQ+WvUIMzHT1wYk5d+wkw0PSURfqR8rfYMWyTvfY
	RUfSOP+vVinmqsSyb2Amb5HolewhkzBthCNRRCHVU6k9TD0dmNklQ7/bKt1S/0TAZ/7Mbh
	Fkf69BoH/7f8d2E3dmC1ODRsRCsBfh0=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-x4b58BMGNLmZc-oSHnrdRw-1; Wed, 18 Jun 2025 10:42:53 -0400
X-MC-Unique: x4b58BMGNLmZc-oSHnrdRw-1
X-Mimecast-MFC-AGG-ID: x4b58BMGNLmZc-oSHnrdRw_1750257773
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b31c9a9dcc3so923252a12.2
        for <fstests@vger.kernel.org>; Wed, 18 Jun 2025 07:42:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750257773; x=1750862573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jYplESCF19MHBq4tvpJlFlIqBQP+mI2cKNKUPE9m/Nw=;
        b=mf5pCb+AMejtqP0CRLzzj9D5kv4Q//PK3JrNi5ZvROBD0Ml1qmzT/3JWuOPsaqaeho
         Ldyy63+g/X+kCrErDByHsd2s2LCrqXBSUdc1arEZpXQrPNxpiter6RsJCxOiTJxzWxeR
         vRrPLxTUef6NGWRLaU/uRb6S3W5j9nFvEXCkZEwBxkWpREfeHnozuPaDP2Fbwt2GDpfR
         /DtY1FeLgFkyfGfUVoVil7PeOkJFxNvhZPfEcRFpQY0dPgiKJT+0Iq/yNlQ8gr3bPF7d
         cD4X/CX6wtLLyWlAjr8T57mfpB1wwm//a8KvgN9z9EsRDBfE4N2UviUjA+Y/sDPXpxQL
         LHgg==
X-Forwarded-Encrypted: i=1; AJvYcCXtcIs4pRrGpRQvQIHuuUOM5zGivHOSoAFC384OZaJ07xhRlahGuI5obdVEq0C0Zwhcq98+7usq@vger.kernel.org
X-Gm-Message-State: AOJu0YwddC1Vns8kp8fBqj1jb/W2X6Ecf+9plqZaJI4I4Uh6DDMYrdVs
	Yq+cxwb/08L5LiCEv5XR3KS/qBaAMcTsV5O6T/LgvdC8Yj8OqtnyoeuV5eoPT4Pzo4h9Jc8EbHE
	hwbntBYhsi6GwXeWWl+CyygYZyxY15VL4+gkc+Hxtrw03t1jVGqUf32fPHqw=
X-Gm-Gg: ASbGncstYFwCwqamte6KN0RzAnhTYkoIgXbZHje+3KTnUHzpKh5OG2L777ZgHwTUxuc
	+quWxvrEB3o8Mc7i3iWBOkTvZrbKfcThfa+0Ey6k3RlAlA6at3FXzQaWQr9oEE5b8d8FD6WvKTS
	/xMB6Yl05zUp5d0dmEQl5YcQpJir4za1Rwj/jqo8zmj/FoFlDuIPJCE3zbV+c6P7k/7MVQ9sOAk
	/9OktLILNwmprRXq8OEq/Ci5G8ZfYfTDSFqBbOYC51ENDYYQgWn0eZbF4wf7X6Q9za7ylvfzilk
	0wMkv5KCywgyV6a7R6Bm6ChQ4TyKLWzaivCJM9gZMbdGFqDZhgtvoMXXtgH/Yuc=
X-Received: by 2002:a05:6a21:9991:b0:1ee:d418:f764 with SMTP id adf61e73a8af0-21fbd5d2f85mr25880294637.38.1750257772920;
        Wed, 18 Jun 2025 07:42:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNF3w3dA6VVtlhNpAaFk9ATsZsJFOvVPLG4qscpsoWOCLNbpJO7ARUwxmjBT/K2Huyf770pA==
X-Received: by 2002:a05:6a21:9991:b0:1ee:d418:f764 with SMTP id adf61e73a8af0-21fbd5d2f85mr25880265637.38.1750257772558;
        Wed, 18 Jun 2025 07:42:52 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748e1a26105sm2379398b3a.45.2025.06.18.07.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 07:42:51 -0700 (PDT)
Date: Wed, 18 Jun 2025 22:42:48 +0800
From: Zorro Lang <zlang@redhat.com>
To: Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH v1] generic/689: add _require_acls
Message-ID: <20250618144248.meohfjvgesa6tb6b@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250606103516.3349389-2-Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250606103516.3349389-2-Yuezhang.Mo@sony.com>

On Fri, Jun 06, 2025 at 06:35:17PM +0800, Yuezhang Mo wrote:
> Before testing for ACLs, check whether the file system supports it
> with _require_acls.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> ---

It's good to me, and help to avoid below error on exfat testing.

    +idmapped-mounts.c: 7569: setxattr_fix_705191b03d50 - Operation not permitted - failure: chown_r
    +vfstest.c: 2418: run_test - Operation not permitted - failure: test that setxattr works correctly for userns mountable filesystems

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  tests/generic/689 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/generic/689 b/tests/generic/689
> index 36c74cd7..739d10b3 100755
> --- a/tests/generic/689
> +++ b/tests/generic/689
> @@ -15,10 +15,12 @@ _begin_fstest auto quick perms idmapped
>  
>  # Import common functions.
>  . ./common/filter
> +. ./common/attr
>  
>  
>  _require_test
>  _require_idmapped_mounts
> +_require_acls
>  _require_user fsgqa
>  _require_group fsgqa
>  
> -- 
> 2.25.1
> 
> 

