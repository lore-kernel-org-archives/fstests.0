Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B814280
	for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708875694; cv=none; b=h4NWmCHL9WGFnB+m1x8rBNU3x+mnhf1wVwNW21nNlUOV3OO02jv/pXirVECth2xnrhYCT/YZH0pFmBprwmnTlqIgvHDZ9SLbHhU+gH2E1TwZa4sIF93P5VPWBBEvk7mKTfYxwXbnhNYKhV4H7StfUXKDSpaZC2qcncYzq3FcfWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708875694; c=relaxed/simple;
	bh=7v7db/JNN0EXDSBfGzIGKFxeQUgobasoqFt45WxellU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qO9VHoUvFFq3fNeaooQfe1M7f6iDuYmXuXI1BocHxHYqGpvY1YL9qY1S0KXVi2ywiZ2EKzFVmwwXgCZ+asyXxh6jbkL12Iy2l0k6TxVzuDVoQr4K9hl8XIQN2qJXK7q/nynX3SmS8X4du9NALT1iWRRdNhjXItQ4afWAL3UQu2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WqHF9pSe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WqHF9pSe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708875691;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ATVNc9fNDwtTwgTZk/LuN2EPr9bg2I/iUG+7ebh1HZw=;
	b=WqHF9pSeRIrPi+Vb9TKcWFmeruojOyft8FXJpAvLit2COV25+tXbjcRExTVhAov6Ztbdm9
	tadTr0DtmLjZUZHE0fPL9YhzxGITlfvrvR0ea4sksa63u7Ol3sZdZifT/Tke4qaVXPXm/e
	jdsLYoqrgHMXC8ONYGFZ/TuA7rmGuEc=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-QGHVsUiNNKqm5xVR7XeNWQ-1; Sun, 25 Feb 2024 10:41:29 -0500
X-MC-Unique: QGHVsUiNNKqm5xVR7XeNWQ-1
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5cdfd47de98so2327551a12.1
        for <fstests@vger.kernel.org>; Sun, 25 Feb 2024 07:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708875688; x=1709480488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ATVNc9fNDwtTwgTZk/LuN2EPr9bg2I/iUG+7ebh1HZw=;
        b=o+HdFyxTlWxxkkT/Xk+I6fl8Aw+h5O4PqlCVnb3SfMTzY057HQKyf2zO6j7grN4OmH
         3vwLTmWt/B6uV6fnHvXuzwul/1ftwcganAnSFYsdOv9rIJppzz2I0kDpztTJJA5ODi2s
         YDEm0vN3jlCPkPRO98qR7X7a1DgbeSdSBtzdShcCJGP7NgGYNF+TsEiPb6YTghzF+HO2
         BccomK0kTyt4bwq7ut1rYqIwj2BxRBWy95Pa3Wb/74zq9/ENh5GAeGyVl5NkvSMvwtzZ
         wWHa/YRuouoxXex/RgzfBUGDXVUygF30dUxhYIgB1NHuqO6NsrBIejlEB6cJlWzmbXqv
         vHZA==
X-Gm-Message-State: AOJu0YyaC+LQeNjIstTlmQTWuK+irn2dHlNRCE/B/ecEnyxYj8RPDlnF
	4Qbc332DkKcgWH3ZqwFUUmbLyjWbght4w/EnHzqVPwhxPJ47DZ2B9Vf3lLIiFE4HWvKJmkA0wDV
	QSmklcfMgTQW+9gmH/cqRG1XjQ581UckHfU5HHgzVhK9jIvKS5WEIxXY=
X-Received: by 2002:a05:6a21:1014:b0:1a0:d956:5590 with SMTP id nk20-20020a056a21101400b001a0d9565590mr3349445pzb.20.1708875688495;
        Sun, 25 Feb 2024 07:41:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIhB90RtmLPRMccW7nL5Uc/9prciuKDb0bGcBFUuoVUuWU/PKpIui+JCDIEA2+0e7OsfE+ug==
X-Received: by 2002:a05:6a21:1014:b0:1a0:d956:5590 with SMTP id nk20-20020a056a21101400b001a0d9565590mr3349436pzb.20.1708875688158;
        Sun, 25 Feb 2024 07:41:28 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e2-20020a63e002000000b005dc87643cc3sm2487253pgh.27.2024.02.25.07.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 07:41:27 -0800 (PST)
Date: Sun, 25 Feb 2024 23:41:23 +0800
From: Zorro Lang <zlang@redhat.com>
To: David Sterba <dsterba@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH] generic/733: disable for btrfs
Message-ID: <20240225154123.pswx5nznphszonns@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240222095048.14211-1-dsterba@suse.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240222095048.14211-1-dsterba@suse.com>

On Thu, Feb 22, 2024 at 10:50:48AM +0100, David Sterba wrote:
> This tests if a clone source can be read but in btrfs there's an
> exclusive lock and the test always fails. The functionality might be
> implemented in btrfs in the future but for now disable the test.
> 
> CC: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> ---
>  tests/generic/733 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/733 b/tests/generic/733
> index d88d92a4705add..b26fa47dad776f 100755
> --- a/tests/generic/733
> +++ b/tests/generic/733
> @@ -18,7 +18,7 @@ _begin_fstest auto clone punch
>  . ./common/reflink
>  
>  # real QA test starts here
> -_supported_fs generic
> +_supported_fs generic ^btrfs

If only need a blacklist, you can write "^btrfs" directly, e.g.

  _supported_fs ^btrfs

then others (except btrfs) are in whitelist, don't need the "generic".

Thanks,
Zorro

>  _require_scratch_reflink
>  _require_cp_reflink
>  _require_xfs_io_command "fpunch"
> -- 
> 2.42.1
> 
> 

