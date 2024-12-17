Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5261D416A
	for <fstests@vger.kernel.org>; Tue, 17 Dec 2024 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422040; cv=none; b=Tp4ePa+lLx9KJJusQ8GMJ3TdyI5WNwitS8Lv7Gd+gmGv8It3dM/kjiIkRPufclnICdWrOfAgwEBE8lS6TqQ02oHLQ8hyg63ro//ZF95gElvcou2V7ddAO1q2TWOQtfF5LcJNHqG9VsF+jyHqWbYcvssT3LkV5VaAUY/HVnapJBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422040; c=relaxed/simple;
	bh=Bpu/O8gr/P186Ez+jiI9p9KSMiybkDvgAlyxwn1PupI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ftLe2zbCF48WPCG8EELPzjfh6DJkbHVkmo8ymopJfbSsAGVD03Z4AV7y8Y7u3n9x+gIs+D8yUEJzcByriEqZVRO0xAXBn5jC+W90GOLJmv23dB90GmQaafumjrH3mMlym6x3JEbPnBfCWRwABtxZVpnz35QhKFfPp1FdnDk2LXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Gw+ANYSc; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Gw+ANYSc"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385e0e224cbso2569885f8f.2
        for <fstests@vger.kernel.org>; Mon, 16 Dec 2024 23:53:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1734422036; x=1735026836; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wgPs939+JTOtFHfLHRar72zvOYaxxVBHfsyOFECZ2dY=;
        b=Gw+ANYSco3BJr4LtZRnt+0ZbTxYKo8DBN8nwQHpz92GuMlfFdQVT34bWGEcC4p7Nfn
         MV8o8nSTzQTp1G1jdnRetTyR8TG4ENBeUY+QRMuMINCHP8bn9Nr5jX4h2BXYTO/k48KY
         2kqWe8ditkEtsFaDfBx63/EQQW5XbRM2ytOKzYh5s9o4t+Wm9twck9h9JCkxdz6cL4pJ
         8nxSfOqbhHA7hwH+InuaWLPcEJibs4OHhECm+YIFtayi36UE4aVf9d2IWiCVrEHYM1ej
         RdOCcNJqhm4P7h3dd/ABnOJkY4O8E/s0/VVI5Mudp3fEvv54O5t/HuqmaeB982ZvvAOs
         9hjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734422036; x=1735026836;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgPs939+JTOtFHfLHRar72zvOYaxxVBHfsyOFECZ2dY=;
        b=tjn5RQ7xSJpJVN8T9ciPifQNu/fju28c620V6aSuEUBwdSkt4nIgWlz82ks5eNy+fP
         GtpZTGvQhb0sRSOTrQiL8zj7IwTIoxVJroiA+n8TbM9VhO5xnRrSbKo++R5Xu6L4JsWq
         miPHns+gl8tGvCuSjIfckw1caAJxaq/BlgrhA6TkE8AMWRfMYxRFcg1v45s9bCf9YQJT
         XaKSSdLgdxL8weo9Hs7CnBR9Ub5P/mWz4BHdOR6yIjicSLCAkg8F6A66SQnjd7YxxKWf
         9cfvOKqAKIvcELxoHjr3gcpFfQCl7WcNdLs9lnHbECCnQmuRHMy5Pxp9fYek+WA+tp7J
         ZqsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRYlvRKfV8Ia+gSMxlAwIuoRoIe9WlAFeaA3PAUXDphoIF8/8xoh/TmZrMkcKt8I7TmIUbrfRc@vger.kernel.org
X-Gm-Message-State: AOJu0YxTqSB5eEywNpagu65yJ67QTNk5W9D8lTn44ZiT6U+5kvcxDwzA
	5dOTKbn0H0kCwMDms3TH1LHdYucQt1m2lbKRU3krqUEsYiJmogbSwXHgfxv5sqk=
X-Gm-Gg: ASbGnctorP0T05AwuWMw3qs5PRfpPMnoy5+I6TSx25UuaLkb6+m7U/mS/AmFYQwyrqi
	oyjIVKUxigqdFlZpi/yWxiftiuHWWbL+NAoqmPt6zWxN+OUflBwbQnowOcu9Qulo7CeGIm5ho0v
	4VunlhDjcc7czDgEXSslA+9E0/Dux96ZQy2JZi7NffNleXLCfLODKnaGRPc85e91uZNMZBGZ7nT
	bTr7u2klck9DV+8qrN/lt3t2h734WQt/YnPZJLn90X2GTXq9FjJxIZPrH/yHcH7RDU+uBWA2J84
	xcGbwOEh
X-Google-Smtp-Source: AGHT+IHl7dpftuyHXi5id3CCfsuRjsqcclMHhkC8ECicieZ4eslNd1yDq6PW4i60d2oyveqJ8hLwkg==
X-Received: by 2002:a05:6000:1848:b0:385:e968:f189 with SMTP id ffacd0b85a97d-3888e0c0826mr13609065f8f.51.1734422035350;
        Mon, 16 Dec 2024 23:53:55 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1dd69d9sm53736995ad.111.2024.12.16.23.53.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Dec 2024 23:53:54 -0800 (PST)
Message-ID: <5e21e7f6-6c91-4395-836e-728ffbcdca04@suse.com>
Date: Tue, 17 Dec 2024 18:23:49 +1030
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] btrfs/100, btrfs/101: fix device name in their golden
 output
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, dchinner@redhat.com,
 Filipe Manana <fdmanana@suse.com>
References: <84afb2bfe9615a98a1ae4de7dfd5fca98771937d.1733851994.git.fdmanana@suse.com>
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
In-Reply-To: <84afb2bfe9615a98a1ae4de7dfd5fca98771937d.1733851994.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2024/12/11 04:03, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> After commit 88c0291d297c ("fstests: per-test dmerror instances"), the dm
> error device name changed so that it's no longer a plain 'error-test' but
> instead it's that plus a prefix matching the test number, such as
> 'error-test.100' for example. The tests btrfs/100 and btrfs/101 are still
> using the plain old name 'error-test' in their golden output, which makes
> them fail. So update them to use 'error-test.100' and 'error-test.101'.
> 
> Fixes: 88c0291d297c ("fstests: per-test dmerror instances")
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/100.out | 2 +-
>   tests/btrfs/101.out | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/btrfs/100.out b/tests/btrfs/100.out
> index 1fe3c0de..e0e6cec2 100644
> --- a/tests/btrfs/100.out
> +++ b/tests/btrfs/100.out
> @@ -2,7 +2,7 @@ QA output created by 100
>   Label: none  uuid: <UUID>
>   	Total devices <NUM> FS bytes used <SIZE>
>   	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> -	devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test
> +	devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test.100
>   Label: none  uuid: <UUID>
>   	Total devices <NUM> FS bytes used <SIZE>
>   	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> diff --git a/tests/btrfs/101.out b/tests/btrfs/101.out
> index c2359c7c..fbb5faa1 100644
> --- a/tests/btrfs/101.out
> +++ b/tests/btrfs/101.out
> @@ -2,7 +2,7 @@ QA output created by 101
>   Label: none  uuid: <UUID>
>   	Total devices <NUM> FS bytes used <SIZE>
>   	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV
> -	devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test
> +	devid <DEVID> size <SIZE> used <SIZE> path /dev/mapper/error-test.101
>   Label: none  uuid: <UUID>
>   	Total devices <NUM> FS bytes used <SIZE>
>   	devid <DEVID> size <SIZE> used <SIZE> path SCRATCH_DEV

