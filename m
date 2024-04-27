Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E025412B75
	for <fstests@vger.kernel.org>; Sat, 27 Apr 2024 17:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714240205; cv=none; b=UEgiaz03VsZbN5K2j8Q+TZOi1InbxufsSwYOXFLLpVhllWdYR44COyEm7cvcLDfYouQH64v3oqJIhzK/gpKDK9eDC6itFC/gFuck7IotEhtv+ip3u7gkyr+0pCXnQ0EbZCeIEg9eJVibTJfDwFUvCfgv0RjLynW03SVDGwwDtVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714240205; c=relaxed/simple;
	bh=oDUhJrhO43xS+Nv+3gF0pnVE+nJuYFMqHZ7qT5yLBSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ja7mZ9qm01xEt860t/n4qYj0udm5Fb3Rmxk+ShZybMpeOOUhZpijZd2iJGmAyM+nBCiK/nvhMmjH62CIykekdqIpquwd9xRBLYWLbBAOY1YA4VBLfZ9cb2Vq9cczl1/josSdn/J4wzuE6bBApZpxoyzGkDc+KcLTTdvdYzMdAog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SzoHPU9o; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzoHPU9o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714240202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N1864z29QRtLXA75xiJm/1XW0KYMpBoYBwIE13EyJHk=;
	b=SzoHPU9ohqvQySU9Uc5L0gD5MT1u2tHWoLMzbr2LCHxd4xkmgRnUx1Xz5rtYsNzU2AVKKu
	u+QSCXvUCbOHVraHZE3KedTNjejyrRDq8rsOpnYFxrm2pCSLARl7njP8Be+ll4Nyu0KG6x
	lnW9UbqfZnKnYaH6A4R8GoWtvfcc5mc=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-h--E6tstPdiCCu8A6QfKQg-1; Sat, 27 Apr 2024 13:50:00 -0400
X-MC-Unique: h--E6tstPdiCCu8A6QfKQg-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2a4b4418a69so3701561a91.1
        for <fstests@vger.kernel.org>; Sat, 27 Apr 2024 10:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714240199; x=1714844999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N1864z29QRtLXA75xiJm/1XW0KYMpBoYBwIE13EyJHk=;
        b=NRbth3wvTwmY2Zp2XGano2Xq5YtjhS/kIWAvnfg9cfSo2qyNuwX56G8tUjCSS00rRZ
         uixEMcdN0+xTKJ0ANMTgKNGpmewLrtkcZFx76Pm4dBhplI925Pe5lIoaWOpuCpR/ymSE
         CI9wpLDCx9No6lXB1/cvmbrhCjQgFT0vdC/azxOGPCwgOh33RqbTaMQ+hK+Ik0pYaTLK
         4rJi5L1Hc+lnLh2/H/OIcbX1SHRokPEeInnJFetjdYqKaEriX8dwLBc1z/mEJ8EI7icd
         krJDANIoW/JSt1BqBr5t+H4eHCvRLWvGApAZ1UFlbQynredUjovihnKmJpJ0h613bRAk
         eZDw==
X-Forwarded-Encrypted: i=1; AJvYcCWHpmq1YLCJ0Ys3UxhhNPN8V4VgRhZKYe4PDQzgtq9HuxFRrejiKhPFIierG+UAxDjETknT4bvEU8XiXNhaWXNs0QEc2waAqA==
X-Gm-Message-State: AOJu0Yy45wCncjMXfJK5uhSjoeTVfLh8w8U4dHvkvlCCzVKEgI7aFuwQ
	3G5v4YrVCn/osFz3hz5E9imX+2MNKCY5HKOVHkkoNy55nSuYiMiXR5L7fxwU2JijACTej8KZ2TX
	dyuFlgv2U06xWOr3BhgWpBZ3deaSRAC2DA4kgaz90zov93BiQnSp79a0=
X-Received: by 2002:a17:90a:a582:b0:2a2:eb67:b20a with SMTP id b2-20020a17090aa58200b002a2eb67b20amr2499672pjq.42.1714240199224;
        Sat, 27 Apr 2024 10:49:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8BFGKkCxJgeUfO2W5N8exa995dtAMkQ+xK5i7PAWYSxYySmlUN4iLu+qU4UvMeMaiyfmxxQ==
X-Received: by 2002:a17:90a:a582:b0:2a2:eb67:b20a with SMTP id b2-20020a17090aa58200b002a2eb67b20amr2499658pjq.42.1714240198652;
        Sat, 27 Apr 2024 10:49:58 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id so13-20020a17090b1f8d00b002aff85b97dfsm4334617pjb.27.2024.04.27.10.49.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 10:49:58 -0700 (PDT)
Date: Sun, 28 Apr 2024 01:49:53 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: zlang@kernel.org, fstests@vger.kernel.org
Subject: Re: [PATCH] generic/095: add to the quick group
Message-ID: <20240427174953.nlw5gfi36syp5jnw@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240427075530.1236045-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427075530.1236045-1-hch@lst.de>

On Sat, Apr 27, 2024 at 09:55:30AM +0200, Christoph Hellwig wrote:
> generic/095 doesn't take more than 4 seconds on any of my test setups,

Yeah, it generally takes ~5 seconds. But there's a "LOAD_FACTOR", so
before we add it into quick group, I'd like to ask
do you think if it's worth increasing the default LOAD_FACTOR a bit to
give it more stress, or move it to quick group directly?

> but is exercises code that handles buffered write iterations interrupted
> by concurrent direct I/O that no other test in the quick group does.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/generic/095 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/generic/095 b/tests/generic/095
> index 80448200b..9d0446e98 100755
> --- a/tests/generic/095
> +++ b/tests/generic/095
> @@ -7,7 +7,7 @@
>  # Concurrent mixed I/O (buffer I/O, aiodio, mmap, splice) on the same files
>  #
>  . ./common/preamble
> -_begin_fstest auto rw stress
> +_begin_fstest auto quick rw stress
>  
>  # Import common functions.
>  . ./common/filter
> -- 
> 2.39.2
> 
> 

