Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DD1B66F
	for <fstests@vger.kernel.org>; Sun,  3 Mar 2024 13:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709471457; cv=none; b=jQxJY3Yr8kSPIlwssxcwr77PUL1mhCiBEi8fXB3mfoqogNPheBJ9sUKbVhU2HfMQb4urNKIpq2/QKOqUKkaCyi4P37ZbRL1DtmQAI4LY0YFEkxFmP3HdLf2oSv7bRXH6IWl7LAUW9MapXNITFaExiyjgYrQe3/DGYTUe6Cy8zxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709471457; c=relaxed/simple;
	bh=aTMzKaZRxU23i409OjT26LlFjB63Hs/hnKqJHhzYDYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rQkLA/p9PHXrAvCJe9+L3aVZhj1ojXvTHcZLVAR7y46XwXyg2z9PL8NKvVULqnLWrl/yh5Ll2CpuU9oSkw3L9ZBe9qGRCNapnAF6ZwOsYw8DWTHdh9h+Pi3XtIlYdY1IzV8flyG/vGkQJlc01VdJbW61GhcxNj0nb/tWH4z7pT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ckfGKAr1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ckfGKAr1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709471454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K7+CBVUOb3nwftCqW3xQMHPRcaIeoQg9DrW8Xr4mB3U=;
	b=ckfGKAr1q2XVTRcJxue/zbfVbYc2qg4dWdJCgLT9MeZCkGDs1CoPeycqD0h+nh/MzyX9d1
	cK0src5rADoINPmF8hJ4x2SQUY/13v9TU6yXb1ZuxBfTj43bau+RrHIVZlbl7gib1uV6Mx
	TOxqaGILTFUW++rPA+/GwUH2CEnqmvo=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-yK1j4coDO2KzcOH5EAm8sw-1; Sun, 03 Mar 2024 08:10:53 -0500
X-MC-Unique: yK1j4coDO2KzcOH5EAm8sw-1
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-5d8dbe37d56so3174918a12.0
        for <fstests@vger.kernel.org>; Sun, 03 Mar 2024 05:10:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709471452; x=1710076252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7+CBVUOb3nwftCqW3xQMHPRcaIeoQg9DrW8Xr4mB3U=;
        b=qe2rM2x37p83P/IsGbOPpABxiT7Va2y8cbEfOiehA7GcvSOfKO6oqUaaUkyo3TpJTO
         D1eZeOy+LNT0vwDS8b8t55bNSTAoHPOQFPQLujkTiCu26AsOFxhqEnjNog074/0YoUKQ
         JwRsmC+OIsh5VKGnaZFhOYFg9fvSC12kJF1HN2bJF0xqoAOUzxaTL/RLG7dtrfFCujaN
         Mg0yQF6e1CbT5O2fFo7/a/BARValsmqAGEbJKyWH6DToW287jyu4vUdlPgqpm5nkn3mU
         +r0ERIVgBeH+yxGIZKEpZijt7qMftjMVF0l+6i7q3Bje74phZ3aw/rX6oeD3Sa7onSS/
         OJKQ==
X-Gm-Message-State: AOJu0YytrUIoc7P3bpBLKYRETC+e+Yo3oEeA6yH1h05lC73cpQt/eEns
	2zgXLVSgLL4GeQE+v1aJHnBwWhxRKneo7DOkMbjB6zVFSzDiGnwhV4t1cBkOAX4CZyds+bxQkVl
	SsU8tCCrLiCtcQ17tKnJtvsO+lVrw9TGJnXyKs6Vp8KJPEq8gTQ2zLR4=
X-Received: by 2002:a17:903:288:b0:1dc:df18:c5c1 with SMTP id j8-20020a170903028800b001dcdf18c5c1mr6473855plr.33.1709471452164;
        Sun, 03 Mar 2024 05:10:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0JtfiD4ETPl4rGH/BswkXyPj0FZ70SYDWMJOlWEhTAhFy3wQuGYIewUydxmrq5H/Mq39Cig==
X-Received: by 2002:a17:903:288:b0:1dc:df18:c5c1 with SMTP id j8-20020a170903028800b001dcdf18c5c1mr6473830plr.33.1709471451688;
        Sun, 03 Mar 2024 05:10:51 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902c20c00b001dbab519ce7sm6584824pll.212.2024.03.03.05.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 05:10:51 -0800 (PST)
Date: Sun, 3 Mar 2024 21:10:48 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH] shared/298: run xfs_db against the loop device instead
 of the image file
Message-ID: <20240303131048.kx4a4b2463deud7t@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240301152820.1149483-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301152820.1149483-1-hch@lst.de>

On Fri, Mar 01, 2024 at 08:28:20AM -0700, Christoph Hellwig wrote:
> xfs_db fails to properly detect the device sector size and thus segfaults
> when run again an image file with 4k sector size.  While that's something
> we should fix in xfs_db it will require a fair amount of refactoring of
> the libxfs init code.  For now just change shared/298 to run xfs_db
> against the loop device created on the image file that is used for I/O,
> which feels like the right thing to do anyway to avoid cache coherency
> issues.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/shared/298 | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/shared/298 b/tests/shared/298
> index 071c03dee..f657578c7 100755
> --- a/tests/shared/298
> +++ b/tests/shared/298
> @@ -69,7 +69,7 @@ get_free_sectors()
>  	agsize=`$XFS_INFO_PROG $loop_mnt | $SED_PROG -n 's/.*agsize=\(.*\) blks.*/\1/p'`
>  	# Convert free space (agno, block, length) to (start sector, end sector)
>  	_umount $loop_mnt
        ^^^^^^^
Above line causes a conflict, due to it doesn't match the current shared/298 code. It's
"$UMOUNT_PROG $loop_mnt" in current fstests. So you might have another patch to do this
change.

> -	$XFS_DB_PROG -r -c "freesp -d" $img_file | $SED_PROG '/^.*from/,$d'| \
> +	$XFS_DB_PROG -r -c "freesp -d" $loop_dev | $SED_PROG '/^.*from/,$d'| \

As this patch focus on this change, so I'll only make this change. But if above
"_umount $loop_mnt" is needed too, please tell me.

Thanks,
Zorro

>  		 $AWK_PROG -v spb=$sectors_per_block -v agsize=$agsize \
>  		'{ print spb * ($1 * agsize + $2), spb * ($1 * agsize + $2 + $3) - 1 }'
>  	;;
> -- 
> 2.39.2
> 
> 

