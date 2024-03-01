Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C62A41C6E
	for <fstests@vger.kernel.org>; Fri,  1 Mar 2024 13:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300962; cv=none; b=JCrd4vr1kUQBX5YW5FbycJs6K84Fb58Q5d70RexS2shCZ8v1jtKeE5sp1Af2YO0tU8inpPhEtNzUf9mV/C5m9DKOZUFBAm4xuvTjmLCYXLXeD8xAAtxPtavvHB/D/UlfZVDYmJIi/KV1a/bjXnS19e671U/lzRy9OiWUN2jBHIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300962; c=relaxed/simple;
	bh=kt/MYYIYath996sVK77LDTlMApYAUJGsJoWE61kDawQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ7EEsWrPr4TcmXfdftwz06L3AjQuETYvjnQrDiZC7XgbOQQV7yhmkRl37HwH4EGFVe3hxgH/2nclC8izYfjqH+ETSS10J9dN6gz4Y+XFadfx1Xiiy2Hl4DUcUGg9GZ9ccNoNzsLsO/jjOwwilAMLS94NowOUz26sPd/dnZV6NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ys5uP7E9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ys5uP7E9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709300960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=98e6wUklDvzqenc0B1oy6bnXiDvTsJRgWDDTG8l16ks=;
	b=Ys5uP7E9sOcDCCdltCP69hRE9jXPiBTsXcKHZO6L61MNtA1hjquTSQTvnq1idMiXEX3XXo
	09Uq0L/Tj/tyV1drVWB956qyWqIYoUmxfaTz2DuZ6YmAWW6Q140PhQl+2lhyhjvQ4zHL2R
	iN8XcoY943XT3RcIIIJvilRd3lSck30=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-kT9LN8vKOBu1H0ZzO0-_KQ-1; Fri, 01 Mar 2024 08:49:19 -0500
X-MC-Unique: kT9LN8vKOBu1H0ZzO0-_KQ-1
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6e4a51c4e44so1747312a34.1
        for <fstests@vger.kernel.org>; Fri, 01 Mar 2024 05:49:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709300958; x=1709905758;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=98e6wUklDvzqenc0B1oy6bnXiDvTsJRgWDDTG8l16ks=;
        b=YR4UwRzUj9cEsCKPdYV+87+QI/Xkiy/7POr0SGj2+PLmN22nb/FqMfenijOQ2YhXvF
         k2bTgp0OweJU8UIbY7aszJEGyo8sTmmzvLcObSgc5JF8Lo1LQhql1WOtYot+QPvLqe9y
         eR7dSqudeGLEcpTA6WLrzsp74WBO1CGNxvWiLEjSO5OqPRyF74G5LmF1MJuWwxtKrgAq
         uaygYssNunmQTdmIQ79Vux4Nrs+9dLZq+s7TqacMgP3XRFDvYadIxPYIaX3mFa1GPSH1
         +emYIDKYh647db8IzEHVh8S9MNEzopw3o3qBipR8IiQczAn9q8YkhFuBoyWmsepNAlQm
         REWw==
X-Gm-Message-State: AOJu0YyBipgTB6SPmyHVfWqM9Amb/OwGzBbcqIrd3vUR8v4t+K7Gvz5/
	ZbE0YQapgEDKMlgN3oZxAbTLy6oqgaQ3WJG/TKUumyZ0njOXXaMJHIrsN2saF5z0yYmT05YKvA+
	3YrR+22QiIRJc6IEiqC1xtMNWVFcP7HhWC3u7ddxPC2dO1Jct1HxIWZY=
X-Received: by 2002:a9d:7403:0:b0:6e4:4393:8565 with SMTP id n3-20020a9d7403000000b006e443938565mr1760569otk.25.1709300958394;
        Fri, 01 Mar 2024 05:49:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV0scFE61jnMLvTPZoaIdXZXWbpAhPTKWAGKHw3DYjV4u2Tx4jnhEIr8J0f7KR1NfxFn4pAw==
X-Received: by 2002:a9d:7403:0:b0:6e4:4393:8565 with SMTP id n3-20020a9d7403000000b006e443938565mr1760552otk.25.1709300957998;
        Fri, 01 Mar 2024 05:49:17 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i37-20020a635865000000b005dc5289c4edsm2975181pgm.64.2024.03.01.05.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 05:49:17 -0800 (PST)
Date: Fri, 1 Mar 2024 21:49:14 +0800
From: Zorro Lang <zlang@redhat.com>
To: Su Yue <glass.su@suse.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org, l@damenly.org
Subject: Re: [PATCH] btrfs/172,206: call _log_writes_cleanup in _cleanup
Message-ID: <20240301134914.dgcv4vh2jbx2egfp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240215140236.29171-1-l@damenly.org>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215140236.29171-1-l@damenly.org>

On Thu, Feb 15, 2024 at 10:02:36PM +0800, Su Yue wrote:
> From: Su Yue <glass.su@suse.com>
> 
> Because block group tree requires require no-holes feature,
> _log_writes_mkfs "-O ^no-holes" fails when "-O block-group-tree" is
> given in MKFS_OPTION.
> Without explicit _log_writes_cleanup, the two tests fail with
> logwrites-test device left. And all next tests will fail due to
> SCRATCH DEVICE EBUSY.
> 
> Fix it by overriding _cleanup to call _log_writes_cleanup.
> 
> Signed-off-by: Su Yue <glass.su@suse.com>
> ---
>  tests/btrfs/172 | 6 ++++++
>  tests/btrfs/206 | 6 ++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/tests/btrfs/172 b/tests/btrfs/172
> index f5acc6982cd7..fceff56c9d37 100755
> --- a/tests/btrfs/172
> +++ b/tests/btrfs/172
> @@ -13,6 +13,12 @@
>  . ./common/preamble
>  _begin_fstest auto quick log replay recoveryloop
>  
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	_log_writes_cleanup &> /dev/null

This _cleanup will override the default one, so better to copy the
default cleanup in this function,

  cd /
  rm -r -f $tmp.*

You can refer to btrfs/196 or generic/482 etc.

> +}
> +
>  # Import common functions.
>  . ./common/filter
>  . ./common/dmlogwrites
> diff --git a/tests/btrfs/206 b/tests/btrfs/206
> index f6571649076f..e05adf75b67e 100755
> --- a/tests/btrfs/206
> +++ b/tests/btrfs/206
> @@ -14,6 +14,12 @@
>  . ./common/preamble
>  _begin_fstest auto quick log replay recoveryloop punch prealloc
>  
> +# Override the default cleanup function.
> +_cleanup()
> +{
> +	_log_writes_cleanup &> /dev/null


Same as above.

Thanks,
Zorro

> +}
> +
>  # Import common functions.
>  . ./common/filter
>  . ./common/dmlogwrites
> -- 
> 2.43.0
> 
> 

