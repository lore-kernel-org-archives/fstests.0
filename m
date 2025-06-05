Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F54142E67
	for <fstests@vger.kernel.org>; Thu,  5 Jun 2025 15:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136607; cv=none; b=J1S4LX2S7Ng8cjc3vvtHKO0CFmgfeW0t+Al1idGt1U7oqS/K5/QImi9aLGrzof25yUdapQj2dieCHRF2+BNVX+BvbJnRLK0C+3LUPcJ/hDciVx2RXjk/RBVODscIXo4SBHLfo2dNayk2ectW5dlFtG3eCJuY4piMHJSoBOFOV9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136607; c=relaxed/simple;
	bh=QgMa7zhtma0ZtFhhcQGn6nhmonaTgIteL3IRcxGJOHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWXAqA1ougYKE1qwjL37IFkQG9EEPAqymM6KUz9ry87mqYLq4xfC2nB48WYCfu1RQ/XCwbVF4W/DogyOlVsGdLGK/ynR4AyMh5JHPz6gjrA7DuCtemTGUp76SSQeMya6KihtCkzNJTCByzQ08kAp20rzelPTbAueYQl4XCjS2hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HjBFJXY5; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HjBFJXY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749136604;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SSMSUDXTnQsGOte7ZSwC1UdyoOVQF+/aES0nsWzNrSM=;
	b=HjBFJXY5SXI9U4Am5uoN5XiEcnLd30G4Wzz2MzHqwxO4RBNsew2w7yV1RqDcQPbTg6hJJA
	HO1GC94WjzjRGk1COJY91xXVgHFAM/qaZx28mTbXOwDtUSLyMv76X/Sza8ysp2VsijiweN
	1I93KSTDA+H/589zvMLIQ7NoK/YvUxA=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-09aLMa89OeWsPCuHfEpwSQ-1; Thu, 05 Jun 2025 11:16:43 -0400
X-MC-Unique: 09aLMa89OeWsPCuHfEpwSQ-1
X-Mimecast-MFC-AGG-ID: 09aLMa89OeWsPCuHfEpwSQ_1749136602
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-7391d68617cso1708530b3a.0
        for <fstests@vger.kernel.org>; Thu, 05 Jun 2025 08:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749136602; x=1749741402;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSMSUDXTnQsGOte7ZSwC1UdyoOVQF+/aES0nsWzNrSM=;
        b=GOkqdh3zbR/av/2R7zStF2fIYfiGJO3vb/aQDsA1Gj5l7AHwEsrLOsGir+fEJqvJDI
         wolnmzMPjb0t0huVLOV4RGvwyABxVcf05+8fdqvqq+TBHG7qKGq7WpD6Yw76UQm/xunW
         cjxE38fjgckOrGUP/4LmWIojZAM4d1Q3loUhFMzU8IJjPh84n5UCwuDEiJFz2c8EO0a+
         DVn7oFUPinOtlP+7sC+9atyYcKDToJBy85U2lCfBr+Uxk0MFsgl8V/GFXQOqjJbBRp/c
         +ZlgTc7znbW3gRu+LV1Jy+C/vJUv8sbIECcGw2n/Tloq0WdPgSgwmSYAd/cJvsttdHES
         DuEw==
X-Forwarded-Encrypted: i=1; AJvYcCUop3mI5oRU9Ph9jBOYXkkz/PZfS0P31DDbglZA/C7oVbPoIX5oa22Yttyi3pE+htYV6TbDj0YC@vger.kernel.org
X-Gm-Message-State: AOJu0YxzWsPF40IoZmMZLd1ZUFufN0KZn53dh/rfh7aTSafqINO3dwgS
	/Lv3zsIA7rc0OX1I+gOsUlOvt3WiKje1aggBobxHQ8ZC1DvlYYtUOqEiQLn3U60BCumZ5JcxZbO
	3kgfsH8K9+Zkwnmys2jDccLTd/1wJJCkCtXBhU1c7qXVkZhWO1HJzsDI8eEs=
X-Gm-Gg: ASbGncu0TbJSb3gLm4Mm4F+oWgeIDYh5k3FTgD87l0p1/ko5f5ijwE3ISXPMDmcjnwi
	50CUhegEXm2L5tfiZnowiwhMabHUAGZ0WqKo0Xblo7FZuxl2c/x6QMoyedEYtqqKJxJcBfTcT2Y
	t30gZBpV+xIiGE7S9E9LeYmbGNNZ58VdVOeehf2dKeWai13455ynaPoBGALHPASPAFlfLggEYIW
	RSlkIgHMtQxLGadFN7R74CB2b7Lq0IEuEbIDU8dFQ79mWUdQYp+4R6jiiDs1pZIgOGDCXBkR5vj
	viGIqbokj1CAPhVpzw+y/B5cxbrlyPF2tx4/qf+hRixFzIW3/4vu
X-Received: by 2002:a05:6a20:db0a:b0:215:e02f:1eb8 with SMTP id adf61e73a8af0-21d3637e63emr5662860637.14.1749136602450;
        Thu, 05 Jun 2025 08:16:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGnQw1YS5cKUDpiLiZ7+IdR7wrCYgAI0XFKPEYj2xduTtufxPclNGFwrOY29zTZYESd3/Bzw==
X-Received: by 2002:a05:6a20:db0a:b0:215:e02f:1eb8 with SMTP id adf61e73a8af0-21d3637e63emr5662836637.14.1749136602081;
        Thu, 05 Jun 2025 08:16:42 -0700 (PDT)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afeabc6asm13405671b3a.53.2025.06.05.08.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 08:16:41 -0700 (PDT)
Date: Thu, 5 Jun 2025 23:16:37 +0800
From: Zorro Lang <zlang@redhat.com>
To: Yuezhang Mo <Yuezhang.Mo@sony.com>
Cc: zlang@kernel.org, fstests@vger.kernel.org, friendy.su@sony.com
Subject: Re: [PATCH v1 4/7] generic/755: add _require_hardlinks
Message-ID: <20250605151637.wdtvvjvdq77ploud@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20250528091530.1218188-1-Yuezhang.Mo@sony.com>
 <20250528091530.1218188-5-Yuezhang.Mo@sony.com>
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250528091530.1218188-5-Yuezhang.Mo@sony.com>

On Wed, May 28, 2025 at 05:15:27PM +0800, Yuezhang Mo wrote:
> This test is used to test whether the ctime of the original file
> changes after deleting its hard link, which requires hardlink
> support, so add _require_hardlinks to check for hardlink support.
> 
> Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> Reviewed-by: Friendy Su <friendy.su@sony.com>
> ---
>  tests/generic/755 | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/tests/generic/755 b/tests/generic/755
> index a0c5abd4..b2fd3e58 100755
> --- a/tests/generic/755
> +++ b/tests/generic/755
> @@ -10,6 +10,7 @@
>  . ./common/preamble
>  _begin_fstest auto quick
>  
> +_require_hardlinks

OK, it helps to avoid this failure:

    +ln: failed to create hard link '/mnt/test/unlink-ctime2.132335' => '/mnt/test/unlink-ctime1.132335': Operation not permitted
    +unlink: cannot unlink '/mnt/test/unlink-ctime2.132335': No such file or directory
    +Target's ctime did not change after unlink!

Reviewed-by: Zorro Lang <zlang@redhat.com>

>  _require_test
>  [ "$FSTYP" = "btrfs" ] && _fixed_by_kernel_commit 3bc2ac2f8f0b \
>  	"btrfs: update target inode's ctime on unlink"
> -- 
> 2.25.1
> 
> 

