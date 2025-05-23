Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579DA20ADF8
	for <fstests@vger.kernel.org>; Fri, 23 May 2025 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748007426; cv=none; b=YJ7RLAB4wGuG6/yDIdIR2ZuLaVS6wcVpKJ4CLLjZyfg/gphO244+cWsntDyLVs+6E7eF99hgf6F+Debx9hEl+pqyKO9phqxPEVYMcTvrfTpAc7aMLscC2LOYII6UPhjw83fyg5QhKwTWgL3FQc5lXPK/bsTs1wsmS6AryCxDqF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748007426; c=relaxed/simple;
	bh=RxurU9VH7u1wBYd690W47S66H7qxmMPgFfVb6Z/7Vyk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U5EA7GB/TMOLZ3/ylVj57Y9OOaw2F6eExikjbkYPcrAj4PsHErgZb4xHE1FWaVWln+rua8DefGNPiwE9e/o5b+QnQRsUSHrNqLGSKILiMwYN3awvre8/YDeyRnJNOAjt34RF+Ynu3PJzQZnQGTZjEGFdzSRU7MQ3hHjmmKz8f1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AFR0OFwt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AFR0OFwt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748007423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b4RHY5iqN2MaD+kEV0mHsFyeaBl8Tu8APPEOii/iCBs=;
	b=AFR0OFwtVw8XqBo/FoXZHAH983LvAZHIzyhrTUm6j6nIsxEHh4VUUKFikU40ZwaAcT1Dsk
	4jv8i6F5AJ4nsR1Fdyy7GopQd4D+Cl3t2UxZYx4M1C5l47ZHEb5istTWy9ATtZmOoJ2+PX
	7Vx4GSsAkuWRThTuqykrO6wX8xhg/YU=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-6gUp9PmjPra5R3rHCo7fYQ-1; Fri, 23 May 2025 09:37:01 -0400
X-MC-Unique: 6gUp9PmjPra5R3rHCo7fYQ-1
X-Mimecast-MFC-AGG-ID: 6gUp9PmjPra5R3rHCo7fYQ_1748007420
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b090c7c2c6aso5972298a12.0
        for <fstests@vger.kernel.org>; Fri, 23 May 2025 06:37:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748007420; x=1748612220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4RHY5iqN2MaD+kEV0mHsFyeaBl8Tu8APPEOii/iCBs=;
        b=xTVm04TY8on++eGAFEEnrJA4dkL9djsisjM+SeUU3OjvIRLtCEwliwobLclz+pA2/J
         V1b+87bT27QcUIF7x3LocO3tNIhGqxgrp3AtrCptud0m1HXvqfhXVXOcZy5H/gVhWPzW
         wu8mmL0yx2u+6qVQt+6gy5sXp5iCS94JqZTjg7ViwM2ZD46UQUpGgdFgLjDDS+3UhdWC
         VviQjUrL38/D7MHxaE733BIeS+YH909CrL+Itnt4ynzOnwWfv4VzKmoYTRmp8gEfbTN+
         3qQkf5Il3kZg1vLsi+4ZIWubQ0L2XakrFOY7DMymojyWxwrqKL2kw9GPiCftHiZEWSAB
         rkcQ==
X-Gm-Message-State: AOJu0Ywyem5IFgoy0HgI2omzrlZlCFIkfnZSBSRB463cejMFxfLlHa0o
	EIfbUqahmH1JtRWvl/2GUcBh7R726Hmd1yNLOsj4jKySRyOlBCpJ47Buh2DNWJPxF1u1C7H/XuK
	TJG4cusuKVlAihqZlOobwkWw61fag8WcOOhcSVlNu8RvwRfDVuRasfT/7VSI=
X-Gm-Gg: ASbGncsQeeIzHBEVAzU6hethDimAV5o3toheC0ZcgVX/AjHCL2oVePTm9pRCkRwb09t
	y0ZI7P9WwFbWYpDcjKLGgINBIzuqFIvbT2vMlalCbtsO12NYKrJFc3Xg31GCPtVC2GsE+fJ7x21
	kY6T68BHgDhoUmc8yczHgjYhJ13awBJ1lRP8zarSfa8YcNdcSzV3piv59H2VIYgjjxtfQDoQVjD
	/FZduGNrWxgkeGLcA3BJ0J7OA9Y5IONW2itBI/ONFon2sh26u81yknvvLCLI61sTAOSEtTajDlL
	eUHpeA5LWkKtmenx1q43zBY6YLXhkzQSd2Tzg2chXKRmi/TBbmO5
X-Received: by 2002:a05:6a21:318c:b0:1f5:9208:3ad6 with SMTP id adf61e73a8af0-2170ce8c04emr41721092637.41.1748007420522;
        Fri, 23 May 2025 06:37:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExolJZr41ZZehMDnfw2H6lN5AfEYxS12dLBplbRK0rq7eGBE+HwDv1wLGKguY4sO01uouzqA==
X-Received: by 2002:a05:6a21:318c:b0:1f5:9208:3ad6 with SMTP id adf61e73a8af0-2170ce8c04emr41721054637.41.1748007420163;
        Fri, 23 May 2025 06:37:00 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9709534sm12691975b3a.41.2025.05.23.06.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 06:36:59 -0700 (PDT)
Date: Fri, 23 May 2025 21:36:55 +0800
From: Zorro Lang <zlang@redhat.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/4] check: unbreak iam
Message-ID: <20250523133655.bkt7ajt7qwcw6mgf@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <174786719678.1398933.16005683028409620583.stgit@frogsfrogsfrogs>
 <174786719750.1398933.11433643731439553632.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174786719750.1398933.11433643731439553632.stgit@frogsfrogsfrogs>

On Wed, May 21, 2025 at 03:42:38PM -0700, Darrick J. Wong wrote:
> From: Darrick J. Wong <djwong@kernel.org>
> 
> I don't know why this change was made:
> 
> iam=check
> 
> to
> 
> iam=check.$$
> 
> The only users of this variable are:
> 
> check:36:iam=check
> check:52:rm -f $tmp.list $tmp.tmp $tmp.grep $here/$iam.out $tmp.report.* $tmp.arglist
> common/btrfs:216:               if [ "$iam" != "check" ]; then
> common/overlay:407:             if [ "$iam" != "check" ]; then
> common/rc:3565: if [ "$iam" != "check" ]; then
> common/xfs:1021:                if [ "$iam" != "check" ]; then
> new:9:iam=new
> 
> None of them were ported to notice the pid.  Consequently,
> _check_generic_filesystem (aka _check_test_fs on an ext4 filesystem)
> failing will cause ./check to exit the entire test suite when the test
> filesystem is corrupt.  That's not what we wanted, particularly since
> Leah added a patch to repair the test filesystem between tests.
> 
> Cc: <fstests@vger.kernel.org> # v2024.12.08
> Fixes: fa0e9712283f0b ("fstests: check-parallel")
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
> ---

I should revert this line too, when I removed privatens and run_setsid from check.
Thanks for this fixing.

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  check |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> 
> diff --git a/check b/check
> index ede54f6987bcc3..826641268f8b52 100755
> --- a/check
> +++ b/check
> @@ -33,7 +33,7 @@ exclude_tests=()
>  _err_msg=""
>  
>  # start the initialisation work now
> -iam=check.$$
> +iam=check
>  
>  # mkfs.xfs uses the presence of both of these variables to enable formerly
>  # supported tiny filesystem configurations that fstests use for fuzz testing
> 
> 

