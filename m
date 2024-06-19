Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B0C13E3EC
	for <fstests@vger.kernel.org>; Wed, 19 Jun 2024 12:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718801370; cv=none; b=lVj8/q/73dgeLVvigUoNjwyGXku+OzPIlQRk5qT1sVwLQi8yfe+fpKHtay5ts9kmBh6rrCL34Lv1FYbHOQQ/iyV7ul3FdPqlpqT/5B3+lNZJgHh8uWhuVMSaLIewHdFifh2JD8WjC8ATUBAfMQu1bmRhMiQOCWVPI8ScXVdkI6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718801370; c=relaxed/simple;
	bh=N02dnH+s04vYWF/8xI6meCZqLL80mR533GDg9Bwg+RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1JOPAMaEGg2hRMwo0cCWFVszY9zDU78GrPVZdceN0sBTMkdR3mQzuvrzAt+TRxkm5ojl6Z+1lSmZtjQ1DktoSnmGeZqEgxpi36orUU7rWBePjx9ef14s8zPBvEk1nXexzCb9MQvXRpNq6Z/lN4+Ui7/VpZ/ANAUulTlkz0v6+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gW0VnUXf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gW0VnUXf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718801368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a/aeV7SyIxG2ya79k81mAo8i+5QZYIEdkti9+GhFhdo=;
	b=gW0VnUXfwsOisLNwOVWZteMGUdo5hkPEykJdtkLytmjIU/WSjyPQrNXZOMH8Oc20itd2HD
	OE3AJ2A4Tq3LLQTDHruuJKGahB8CYcJqmkDxwkv84UZ4+KruUkxp2ngkCcNCdsG0Ih6Czd
	zX0cDgv3Dj7/We6up2C3HduZpwdr4to=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-L5RZ5dyROCWUBqtMjrg4oA-1; Wed, 19 Jun 2024 08:49:26 -0400
X-MC-Unique: L5RZ5dyROCWUBqtMjrg4oA-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6efe7123e0so187422566b.0
        for <fstests@vger.kernel.org>; Wed, 19 Jun 2024 05:49:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718801365; x=1719406165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a/aeV7SyIxG2ya79k81mAo8i+5QZYIEdkti9+GhFhdo=;
        b=ZRFxeZ4R5w9jjFHwtyFmWn77SGyiv/0FOkc675ovbnfgWhpovyNf9uqzP4u3tiXkmK
         gvYPiANwlU3n7yKMVooGvLmRGBZU+1FpfPGHO6STqd8hyp3LsEddh8ajTqdQlaILMdXN
         dq+IZQbQu8a+k3OiRiI4WbA0jLcMZs2+SdxX1KVpjHMYwiK/Ovv1zodu/tcV4btzGbbT
         F62N6YU4aUfxw3RuNQ5K4QaMDF9uYxRCb2Mtw3sBnYwLxET3XqI+ohC5OspVhxngCbys
         vdemcAqGMjNn4BjaDz3Cb1HKpK5YtHhWDRMg2PlXz0IHxPyZrvWwSHV2hr35LQUIoBMc
         Hw6g==
X-Gm-Message-State: AOJu0Yzkq00d6NG92R1cIuD3zaT2kgJ6ujU6W4PnprFCggD6SVTdyXZX
	hHEzkUyTumrIDSgdv/uTfyKt8y6iHpyP41d5xZ/i2zK1C7LpIj2jnMof1+ym7Uvn24zlHYWyDo7
	OstUhTzRnbCkNaQP2F8O8zBfNRkHRo2ltdW6eToItz7Qv9mbJDj/vJA==
X-Received: by 2002:a50:f69b:0:b0:57d:3b8:85e6 with SMTP id 4fb4d7f45d1cf-57d07ebc187mr1975189a12.39.1718801365387;
        Wed, 19 Jun 2024 05:49:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyH7pHKIgzBJW3iLGU2UX8ZRVO1wz8NARWWlxCcUDThCSdrZWrZRtpL4+q5rfcc4UZB/gSGQ==
X-Received: by 2002:a50:f69b:0:b0:57d:3b8:85e6 with SMTP id 4fb4d7f45d1cf-57d07ebc187mr1975175a12.39.1718801364839;
        Wed, 19 Jun 2024 05:49:24 -0700 (PDT)
Received: from thinky ([109.183.6.197])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d0e28ddb2sm415676a12.90.2024.06.19.05.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:49:24 -0700 (PDT)
Date: Wed, 19 Jun 2024 14:49:23 +0200
From: Andrey Albershteyn <aalbersh@redhat.com>
To: Eric Biggers <ebiggers@kernel.org>
Cc: fstests@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [xfstests PATCH] generic/574: test corruption at more offsets
Message-ID: <rgy632iwsrbmwoiquqosutpj6wsfua3jzhcgb4eac4hz2zuqm5@f5qbqkh4qjae>
References: <20240612035334.134434-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240612035334.134434-1-ebiggers@kernel.org>

On 2024-06-11 20:53:34, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Expand generic/574 to test for corruption in more different parts of the
> file to try to exercise any hashing optimizations that might be used.
> 
> There is no existing bug that this finds.  This is just to prevent
> future bugs, considering optimizations along the lines of
> https://lore.kernel.org/fsverity/20240611034822.36603-7-ebiggers@kernel.org/
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  tests/generic/574 | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tests/generic/574 b/tests/generic/574
> index cb42baaa..72440d49 100755
> --- a/tests/generic/574
> +++ b/tests/generic/574
> @@ -194,10 +194,25 @@ test_block_size()
>  	corruption_test $block_size 131072 0 5
>  	corruption_test $block_size 131072 4091 5
>  	corruption_test $block_size 131072 65536 65536
>  	corruption_test $block_size 131072 131067 5
>  
> +	# Test corrupting a block in files of length 1..4 blocks, and test
> +	# corrupting each block of a 4-block file.  This ensures that all code
> +	# paths that might exist due to multi-block hashing optimizations the
> +	# fsverity implementation may use get covered, assuming no more than 4
> +	# blocks are hashed at once.  E.g., consider an fsverity implementation
> +	# that verifies sets of blocks but has a bug when given a single block,
> +	# or that has a bug that makes it not verify all the blocks of each set.
> +	local i
> +	for i in $(seq 1 4); do
> +		corruption_test $block_size $((i*block_size)) $((block_size/2)) 5
> +	done
> +	for i in $(seq 0 3); do
> +		corruption_test $block_size $((4*block_size)) $((i*block_size)) 5
> +	done
> +
>  	corrupt_eof_block_test $block_size 130999 72
>  
>  	# Merkle tree corruption.
>  	corruption_test $block_size 200000 100 10 true
>  
> 
> base-commit: e46fa3a7dae4a65fd80128bf381dba4fd5036ebb
> -- 
> 2.45.2
> 
> 

The addition looks fine to me, why is it 4 blocks though, isn't 2
enough?

Reviewed-by: Andrey Albershteyn <aalbersh@redhat.com>

-- 
- Andrey

