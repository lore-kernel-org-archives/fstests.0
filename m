Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C996B1B279
	for <fstests@vger.kernel.org>; Fri, 10 Nov 2023 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N7rF9dWS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B650F387AE
	for <fstests@vger.kernel.org>; Fri, 10 Nov 2023 06:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699625614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d5WYnv7EtiuJnvaEvnTkogip31SOZhWzMoT4IK/HQic=;
	b=N7rF9dWSVoRj0APfjbzutrrwfs9hs+/UUiQhOWPTv9pqDZ+vJTnAoqZ/0QTw/I4nWGmL/I
	L8QxFfdfHFad4IBTKA4yMfFc62HCf+Nvwfn6HZKn4WR8E2CWDAVPKdMgPxV2DY2X4jE8+U
	tB83O3k3zPlhAAbtI5I54ZtouGheIWw=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-D8WPsHpEO6KpVxEjtNIvBg-1; Fri, 10 Nov 2023 09:13:33 -0500
X-MC-Unique: D8WPsHpEO6KpVxEjtNIvBg-1
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-6bde4f405f9so2096482b3a.1
        for <fstests@vger.kernel.org>; Fri, 10 Nov 2023 06:13:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699625612; x=1700230412;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5WYnv7EtiuJnvaEvnTkogip31SOZhWzMoT4IK/HQic=;
        b=gIPsBQ47xwoVS+UBINwww5IXcim/i5+AXVBc7QPtS1/eajxkZHrknApQm2XZh2vC6T
         /mHxv8LiyybMpn9IQ9tO42D45kZvkjWhZcqo7v23Vga5k37Sm7z/PT38TZRgUHvB3W42
         odaKkKSYoPwUf5CBFeRpmZ1wlYkFS0/Tv111MIIffy7PnDwNYRVeAFJXtb1ezf/d1Sy1
         NRem8jy9pGG6fKGoOUBxXLu4lf/wcNStw/SR6kWYBINPeHNbbMS9DKnxTEAlhtV+2dRU
         uRF2RH/5UbIWyLBSlybAB7WX9NtG8FtYbrX5+RbORePyv5mlOQFQdN316ETGcnnXyX76
         7IyA==
X-Gm-Message-State: AOJu0YzUYN7CMKPDF7WMUOZr9+6G2+8E84B82IJCgGFKwH/pDt6xxswW
	G12ZQ5oEU4KAQYh4fa2NVPhZyG4cDVCyH++eyEYBJGBp+23a0Kfet+KY/4dEcl2RXlWFui1tFDj
	YEQDnwI5vA9CtAcE1j2gzvjRlILaR
X-Received: by 2002:a05:6a21:3390:b0:16b:7602:15b1 with SMTP id yy16-20020a056a21339000b0016b760215b1mr9069502pzb.12.1699625612211;
        Fri, 10 Nov 2023 06:13:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYUqY0ivYKWTCHGf/2FMj6rXAw4wSEgxZDgnGZSIu0siKP9ailGKakvK618to2lCyAfCRjWA==
X-Received: by 2002:a05:6a21:3390:b0:16b:7602:15b1 with SMTP id yy16-20020a056a21339000b0016b760215b1mr9069487pzb.12.1699625611861;
        Fri, 10 Nov 2023 06:13:31 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y30-20020a056a00181e00b006c4cf21489asm1712276pfa.205.2023.11.10.06.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 06:13:31 -0800 (PST)
Date: Fri, 10 Nov 2023 22:13:28 +0800
From: Zorro Lang <zlang@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: fstests@vger.kernel.org
Subject: Re: [PATCH] xfs/146: require fallocate support
Message-ID: <20231110141328.2wpyfam6hsq6s33e@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20231109164947.736069-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231109164947.736069-1-hch@lst.de>

On Thu, Nov 09, 2023 at 05:49:47PM +0100, Christoph Hellwig wrote:
> xfs/146 uses the xfs_io falloc subcommand and thus kernel fallocate
> support.  Ensure the support is present.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  tests/xfs/146 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/xfs/146 b/tests/xfs/146
> index 123bdff5..c8268a52 100755
> --- a/tests/xfs/146
> +++ b/tests/xfs/146
> @@ -24,6 +24,7 @@ _begin_fstest auto quick rw realtime
>  _supported_fs xfs
>  _require_scratch
>  _require_realtime
> +_require_xfs_io_command "falloc"

Thanks, if so, we might need to add this case into "prealloc" group.
If you agree that too, I'll add it when I merge it.

Reviewed-by: Zorro Lang <zlang@redhat.com>

Thanks,
Zorro

>  _require_test_program "punch-alternating"
>  
>  # Format filesystem to get the block size
> -- 
> 2.39.2
> 
> 

