Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6594280CF6
	for <fstests@vger.kernel.org>; Thu, 25 Dec 2025 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766658984; cv=none; b=s0huWxi4TXL+64dRtNcvRTTsRgl4NjY+OMcIML4RiPQiBB39uvTUAFwKDmNqkVyTVAF/glXGRiMDEjbESH6GRfK6qed5JWiPPvoh3M7YlQDd3QUUOOPquFy4yjQmkVNSQWA8MTfBwoxZPgo/Fi5oAkrH6CM41SyX1ehhVCRvhlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766658984; c=relaxed/simple;
	bh=lNSbt0u/gZghOeU/fe5iiQaSinBfTtPshvxOYvB+iuA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tMUIWC5rhhKIzU8RCCjcq0v1cnhIIqFOcJSsUgCyPrgyveI9pzzRhL2AlH/wwLNooFrqU3cMs8YdrU0SJC3tczVspTiBZ12crd5zXmqjyMt4N37tZ2h+mjZ2EYYs39issu8uZRApVv0qIlBOiu1N54zaVj7RFPGRXlItaCtHhI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mtkap2yW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mtkap2yW"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2a09d981507so46875515ad.1
        for <fstests@vger.kernel.org>; Thu, 25 Dec 2025 02:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766658977; x=1767263777; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4TbfVgNyXB/XUtAQGmdqnGShqOTHGFrEbiVxzdYz4RU=;
        b=Mtkap2yWkyJiZPuMgA0iTAcRsA/SV7XLapG0fSF8tDmMzK+3GNEYAhkLSiVu9hEvyZ
         JIlTz7aFKn0ul+Kuk7kTu1bbLyoH+6ubjoCbJ+NAt2YGA4aA682vZNqkx2AfJJaseHC+
         cr3BsMUa+Rc/q+Z7/5Mxjx7Eexr5HoRlrczaQCz5mobUg42kOaWjSNVIL2taK7gRDeaL
         febqxVtmom6HyOLv2SKy2CblfMrhmuCr2UbSf622TYmdam0YI8/dHeB15nQzhK95BPY8
         y5Y3CYuU5gfJdOTpQNdQiS1f8wCSHiBdsNSuWgJXs3r+d2USWWDxGSvcI8ggoT5FbtCI
         6DEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766658977; x=1767263777;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TbfVgNyXB/XUtAQGmdqnGShqOTHGFrEbiVxzdYz4RU=;
        b=bUiQiKnnMp8jccH9vA3MYb7kU6e5wktwePUpz7HrDBPCgIhJaJ46qtgpbQQGWqVFsJ
         vsZX+kXRnOMbp5GCDe6wEdylEFtiPQLWZCAW1SDLfISAPV2XvFxdes+Ztn7orL/5mIl3
         BQPSoEdgoxr59NcoE/NtvJT+bMh60+qWHEQ1YtWJN3iz//ur7cgPbH9LJIthsd8jX2B4
         5bvyvdJiXgxnlTxKDkDyNocVEsEIcFSGL5VKCz1TX3JBTuJrp6h+Aw/NZIbefNqtrJiB
         xD2uSvW7uqVWAM0gMF0lMHgANaI/aljzB1GrlLsODMlafMh2JYulvv8Z1qP05ttnDi4m
         JQWg==
X-Forwarded-Encrypted: i=1; AJvYcCVugpqwF9ndm3Ls/6heyk0AHqNdLghIw3RlP3iAdNOr3BUvZ8SItq8zp6gjOV1iotRp8TrlUjfR@vger.kernel.org
X-Gm-Message-State: AOJu0YzAVoLOdSiIm9b7wqptjonhvhpj2GzJI1hhLumW7FDSwvJPncha
	X0F/5VmMfsvcLiLKfOKxTXcI7rPDwe6jG/HPsWqLSoOVL2IFA0915T2C
X-Gm-Gg: AY/fxX5hZ0PP4MS4w8N1RIAuofGKGIBKcY1ZydW5D5KjWuS8oYJcLYyHN5niopWb2hL
	jnoGQXekclt1zFnFJr4UcVKjynj/hTMobsdlVOrEGc2QczvCEe9+vh50U7dWsdEbzvX5vqlYX6F
	H6w+erm5wcPYWMigqDsKnhaVgAka7z4mPmK5dE6oHmTNniv/juM79s6uCiKCKzsasQZxxt7BArU
	nOsHtE7PGeepzqpn8vR1FDVlEes34cMNfPNe9m2uH3Vr0OyUZUFKKLOqmocrSZvpGeszKpCKHjI
	ufN2MsF+X/hcuUBOE02xVT9hGEYhPgg5zRKDY7JFHImCdGWROoB/6e4Qgj2/6f0+Hr4S4gj1MZ7
	Q7HZ4rJoeMGjMbh6R1U58v1e0oVPKa/JnbDvWGjl2NigLjCaKj07RVcWRRQr6cwdC68yc0az/22
	ZSSofCNFHyVQqO3Rw=
X-Google-Smtp-Source: AGHT+IHexr0TBG3Lf12i3N35SIWIo/7NMxI9To9FUzahjKgxaPyd5wE6QKKQgioQ845NnpHiYRsm2w==
X-Received: by 2002:a17:903:94c:b0:2a2:b620:12d9 with SMTP id d9443c01a7336-2a2f0caa70amr256856685ad.5.1766658977253;
        Thu, 25 Dec 2025 02:36:17 -0800 (PST)
Received: from [192.168.50.70] ([49.245.38.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c66473sm155403335ad.13.2025.12.25.02.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Dec 2025 02:36:16 -0800 (PST)
Message-ID: <5a733a1e-dbc4-4761-bc85-bc811e8fa195@gmail.com>
Date: Thu, 25 Dec 2025 18:36:14 +0800
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fstests: btrfs/131: remove deprecated v1 space cache
 tests
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
 fstests@vger.kernel.org
References: <20251223073939.128157-1-wqu@suse.com>
Content-Language: en-US
From: Anand Jain <anajain.sg@gmail.com>
In-Reply-To: <20251223073939.128157-1-wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 23/12/25 15:39, Qu Wenruo wrote:
> Since upstream kernel commit 1e7bec1f7d65 ("btrfs: emit a warning about
> space cache v1 being deprecated"), v1 space cache is deprecated and
> we're considering to remove the support soon.
> 
> This means soon v1 space cache mount option will no longer be accepted,
> and the test case will fail due to such change.
> 
> Update the test case to remove all v1 cache usage, so we only support
> two cache modes, either nospace_cache or space_cache=v2.
> 
> This also allows bs < ps btrfs to be tested for this test case which has
> no v1 space cache from day 1.

We need testing space_cache=v1 for LTS kernels for its maintenance.

So why not duplicate this test case: one for kernels that support
both space_cache=v1 and FST, and another for kernels with FST
support only? Kernels would then either run or _notrun each test
case accordingly.

> -mkfs_v1
> -echo "Disabling free space cache and enabling free space tree"
> +mkfs_nocache

> +echo "Clearing free space cache and enabling free space tree"

The message should be “Clearing no space cache..”. ?

-Anand

