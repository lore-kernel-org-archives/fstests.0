Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A784C20C481
	for <fstests@vger.kernel.org>; Thu, 13 Feb 2025 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739437384; cv=none; b=rAeJFf4UWN4GIFmbp2ox0IH+DmK7gbI6P+bgQUCZVgsAKY9JqnlWjpsw8/W6FyBDYfov4iplfsBW5Ws0NSkEMivqqKCLAv3yu97l8dQLpv2tTdHkXyWJy6rcFC5ITO5j1EuMEi1Tom5Juq+7BTlLswLOV3cmFdM/vMhWbMf8Qs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739437384; c=relaxed/simple;
	bh=TAjco7brsSFel2FUEUod3lLMZm5CRiCYppYO6vaABbQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R5tfqh8krIIA2+ncl80dVQZj8lErcLZ+CHdxtWWW7iFC2+ACl6W4SW+BRO2DdJ7/agwvLCJs2G/k/YZgZ8fahrwZ6Gp7Z8i1v7348xlnwF4LhTHQ1/3f4zGcqmLgdrRpQVMajASQ13GDavmmA98g9bpgeMWo34JUATqLzw94JHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Iq3wo5ZS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Iq3wo5ZS"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4361e89b6daso3885315e9.3
        for <fstests@vger.kernel.org>; Thu, 13 Feb 2025 01:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739437381; x=1740042181; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=W/gzmySvA2+T0uLumROLCLv0roFEGFEf5laTHOqnpnU=;
        b=Iq3wo5ZSpAUwGJcuaKtI24W6sF1/rhtzwaANchAc0Tlb2KlxXH2MEA2WmdwATI6dt6
         DcX6mzWGkDWNCr2HnAlBGb22SSnk9bNyuVjqHCBzik+t33D6LNKNGjvNIuhL7pTAjLHl
         tsOuDV7pnP1S5cPSIzZi/GMuePnmnT2FnDRzRvyKm1QGMEDto5Y3XsP4P4Q0rnpUbFGh
         nAI88BwlCWgkXiWNxge1gc0DlHM2/6CcGGKmc67R81bBYUv1DBQidyoiKYCWPgLWdopF
         v7zgZ9mcLocI/Bc+GLWW1QnS7Nq7QtxzWnkUI8RYjB21RH1vK6yKe2V64d2J/uDh/M7U
         tGig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739437381; x=1740042181;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/gzmySvA2+T0uLumROLCLv0roFEGFEf5laTHOqnpnU=;
        b=vJRJiq7PSJSRndtoNcxARncslde3ghwKRquKhp9ckn0ITHK0BlJ36vO5ILdEV9XVLt
         HcqR+KobF2+7yVKSWUN29AMRb/tP8SJAc+HcK1X+HJjle2tsPfwuMKguCCzh52txvTDA
         Pka0TaG+mALkKc4I59ARpkOt/IAjwg4AsZ+aVFp2+ZtV2LBW6NvRntNeEnds4xv6sg/s
         UwrbJcGKrGMYZaN+IOc96su5UC9ta5vycmnRoqBSqK/QGtw5BPHSjLwL2ZkbLn8QL/Bm
         iTGY30wYEL8h812a5qDa20uX4SPZITAVYdW6rJsMi2lLdM8p3QDhcIj2fo3FmttFsP36
         byuA==
X-Forwarded-Encrypted: i=1; AJvYcCVXuL76KKRNo7SRJDTXpbCABEyUVf3cuttiGkrqo757E5Qvz37n+jA5R6CJd0nW0gFg+gU659gO@vger.kernel.org
X-Gm-Message-State: AOJu0YxlAoq+wQroat+gObr+j2W35GSxmx4GQYzD8ZInm/dSxzpfxXtw
	CUDWWqSIzKL78EdtdaYqpEKxFnTKBxXSezrNt+Jf2WUfEoFLag6+KUYDSRbFEBA=
X-Gm-Gg: ASbGnctJJm4CftC8U/OLOh+S6+PVkC1exvlatirs+Fqtluc1xNFvj1vitRYun3Zl6Gy
	+wCqLkcxaQjtOukSn/nJWFYQq575uUr4j797CrlcVShPx6VL0P1vLqVmGIUw2NjbFlp1Hii4IGM
	fuDvewdN9yIyyAjxP/nSPD7t7Yu5cG4CVT/bHnTbswxvpZeqSgacqFTrCEA2mtz59IAUfr9aEEq
	Nb8KWOzuN1HCNQk1XVO/NWzRu/tHa4VAFbXLPZGxnKe6u28QzaZyswxu9ZP5ycgVaklbFu3vCW4
	NCeft68jf3DomE7fPc1m3Jynzkyh3kPdKBacFuTOoDM=
X-Google-Smtp-Source: AGHT+IFQvHDRlSfWZTJbqB6B3OQWqnHIS1BDD5iz9Udut2Z9dii53jjyFsv1tXhX7Sy9Vi5Ix+cILw==
X-Received: by 2002:a5d:658f:0:b0:38d:dbbc:3b01 with SMTP id ffacd0b85a97d-38dea2f79f1mr4441942f8f.52.1739437380481;
        Thu, 13 Feb 2025 01:03:00 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d5364403sm8025965ad.62.2025.02.13.01.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Feb 2025 01:02:59 -0800 (PST)
Message-ID: <2eb9ad91-9c02-486e-bda5-e213a1828f70@suse.com>
Date: Thu, 13 Feb 2025 19:32:55 +1030
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] fstests: btrfs: fix test failures when running
 with compression or nodatasum
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1739379182.git.fdmanana@suse.com>
 <cover.1739403114.git.fdmanana@suse.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <cover.1739403114.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/13 10:04, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Several tests fail when running with the compression or nodatasum mount
> options. This patchset fixes that by either skipping the tests when those
> mount options are present or adapting the tests to able to run.
> Details in the changelogs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> 
> V2: Updated patch 5/8, the chattr must stay as we really want to create
>      an inline compressed extent, otherwise it wouldn't be exercising
>      cloning of an inline extent. So skip the test instead of nodatasum
>      is present and add a comment about it.
> 
>      Added some collect review tags.
> 
> Filipe Manana (8):
>    btrfs: skip tests incompatible with compression when compression is enabled
>    btrfs/290: skip test if we are running with nodatacow mount option
>    common/btrfs: add a _require_btrfs_no_nodatasum helper
>    btrfs/333: skip the test when running with nodatacow or nodatasum
>    btrfs/205: skip test when running with nodatasum mount option
>    btrfs: skip tests exercising data corruption and repair when using nodatasum
>    btrfs/281: skip test when running with nodatasum mount option
>    btrfs: skip tests that exercise compression property when using nodatasum
> 
>   common/btrfs    |  7 +++++++
>   tests/btrfs/048 |  3 +++
>   tests/btrfs/059 |  3 +++
>   tests/btrfs/140 |  4 +++-
>   tests/btrfs/141 |  4 +++-
>   tests/btrfs/157 |  4 +++-
>   tests/btrfs/158 |  4 +++-
>   tests/btrfs/205 |  5 +++++
>   tests/btrfs/215 |  8 +++++++-
>   tests/btrfs/265 |  7 ++++++-
>   tests/btrfs/266 |  7 ++++++-
>   tests/btrfs/267 |  7 ++++++-
>   tests/btrfs/268 |  7 ++++++-
>   tests/btrfs/269 |  7 ++++++-
>   tests/btrfs/281 |  2 ++
>   tests/btrfs/289 |  8 ++++++--
>   tests/btrfs/290 | 12 ++++++++++++
>   tests/btrfs/297 |  4 ++++
>   tests/btrfs/333 |  5 +++++
>   19 files changed, 96 insertions(+), 12 deletions(-)
> 

