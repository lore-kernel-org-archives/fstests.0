Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C5D381C4
	for <fstests@vger.kernel.org>; Wed, 12 Jun 2024 04:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718168320; cv=none; b=PD/VekMzt5K6jNUuiWlTBFCnouvZLe9A8DoO6FNeOyJZT5PmyHgMGk54g4UJrrwWpppi7h3Ygefyz57qCTFwavvu3geck/xhp37vUInJVze7ivMp5XNw4cYiZy5a/TlSTU8IKAZof+BfhO+AP8NwGhSIgR6gYPb33oMr0nfffpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718168320; c=relaxed/simple;
	bh=Yy/ru2tWIZ/cV5UmIc247y4eIrWqVLE+t8epCKwfWt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mIIawxuxSgCPooGTxa3tWsZxqqO6IgqapVT9OnGrZzBDsp3rgiLKiRhWKs47CyaJX/9ANoejxqltYgvR8FyaoTPaw2cQWIVxRUi7lcbBVzEysVHEisHFplFWoMF8nvJ+F2CvFnKN6GYIfoStAOOyzwSFwqTTnjs/T2pBtDxLfSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZcXGpy3J; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZcXGpy3J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718168317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+sq5RaOkQslBacwl5oxqiCbnmoCGzQwPUVNg8cSAG4=;
	b=ZcXGpy3JAXclXobGuEz9BMIQIXzc0zJDpQfNgo8AI+RynLviEOAqfX31qR3LirWITAHGUy
	/Lh7Xgc4uT4qetr1bOHaZ+X9oMrh3IJ21v1eLbVKpnfj9h4k2bi5NDGKXmoEgzJZavkF2G
	beGKcWmNiJSzyyWrh4QR7d9y5UPCNJg=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-HllYOoHKOyyV3udCPHF8KA-1; Wed, 12 Jun 2024 00:58:29 -0400
X-MC-Unique: HllYOoHKOyyV3udCPHF8KA-1
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-62f8a1b2969so7775117b3.3
        for <fstests@vger.kernel.org>; Tue, 11 Jun 2024 21:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718168308; x=1718773108;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r+sq5RaOkQslBacwl5oxqiCbnmoCGzQwPUVNg8cSAG4=;
        b=D6lG3iSxyOKhYT+axhLYngEsM8s7apV0eEF2VRQW3uUQysHibizJZpb4sFXa3s/TEw
         iZ5X3j5TJgBSchAmUVPdrMJ9T3caFiF0itRKB/yybCrvC3DH3DwpSgHx4+9zxBcRkQ06
         I7totqvs70EM2XuCz5diHxEqHtjHLZBzjbwUqyW+c8mhX+5fBMKq7yQf1yg6xXIQHX9O
         GRSxIBSsoz+fnIQ9k3aHfk3cwFfCWwECUVWy6yynDjyVF0ko2xWaC6gteJ/PCc/kAMSW
         mDZ3CRSTpy7pOoTTy0e4M8aqZUE5Xfn36G2eyG4ZlNgDGerBulL3+uTrMbQrN8pl24EY
         ZMHg==
X-Gm-Message-State: AOJu0YxsFNe0UvGg6YVa1aZf1JCmsvMw8eeWgsf6wEKL9Dp+m5RReEhz
	x2VNHqyhUNkjIWLh9GAGuMVBFBZ8KngyvJMmNxkyB18dvWcsbCaxmMQBIaTD+jvtf9cwb86dtfR
	iTLs6VjbKzNcps1mfrqJHxbpXxooFYhbfMc5V8XceiWq5+RKIr4dhgreEfrHFBuyklotC
X-Received: by 2002:a0d:c843:0:b0:61a:b038:6d34 with SMTP id 00721157ae682-62fb96efb2dmr8337077b3.24.1718168308456;
        Tue, 11 Jun 2024 21:58:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG4v9Ey7Y8fUaG5OskGi4LYYRp0KvExbt8+xe4rHScncJBkusZyGt0ufSdes2FHPEGRBB7KqA==
X-Received: by 2002:a0d:c843:0:b0:61a:b038:6d34 with SMTP id 00721157ae682-62fb96efb2dmr8336937b3.24.1718168308024;
        Tue, 11 Jun 2024 21:58:28 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f74179d0basm12154955ad.122.2024.06.11.21.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 21:58:27 -0700 (PDT)
Date: Wed, 12 Jun 2024 12:58:24 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: fstests@vger.kernel.org
Subject: Re: can we pull in git as a dependency for xfstests?
Message-ID: <20240612045824.6x3itjgnlkebq67d@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <ZmfjlWGk04r_R5j6@infradead.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZmfjlWGk04r_R5j6@infradead.org>

On Mon, Jun 10, 2024 at 10:41:41PM -0700, Christoph Hellwig wrote:
> xfs/073 has been failing for me for a while on most of my test setups
> with:
> 
> diff: memory exhausted
> 
> from the recursive diff.  Switching to the significantly more memory
> efficient implementation in git diff as in the patch below fixes this.
> 
> Would it be ok to pull in diff (including a supported check)?
> 
> diff --git a/tests/xfs/073 b/tests/xfs/073
> index c7616b9e9..85d8ae8d0 100755
> --- a/tests/xfs/073
> +++ b/tests/xfs/073
> @@ -76,7 +76,7 @@ _verify_copy()
>  	fi
>  
>  	echo comparing new image files to old
> -	diff -Naur $source_dir $target_dir
> +	git diff --no-index $source_dir $target_dir

The "diff" is more widespread, if we can use diff, better to not bring in
a new necessary dependence. But you can make it to be optional if you
need. Likes:

_diff()
{
	local cmd="git diff"

	grep -wq -- "--no-index" <($cmd --help 2>/dev/null)
	if [ $? -ne 0 ];then
		cmd=diff
	else
		cmd="$cmd --no-index"
	if

	$cmd $*
}

But there might be some incompatible options betweeen "diff" and "git diff".

Thanks,
Zorro

>  
>  	echo comparing new image directories to old
>  	find $source_dir | _filter_path $source_dir > $tmp.manifest1
> 

