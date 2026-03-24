Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1132571C7
	for <fstests@vger.kernel.org>; Tue, 24 Mar 2026 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774386485; cv=none; b=kb+E/cuVXluNw460XfklU1vJh2TR163ueIERX9EpjnIipan2+ZaH+t8F6NpBZKHUpRVc5gX1qO+6HbffcNscrovp1wHNuAwUVl2POG4b/DA9sYLaexY2JL1J834dlXysQRlBvFjdig0blEF+I9n2KyLRykggVsJ0oXO8k14m0ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774386485; c=relaxed/simple;
	bh=RpoUXlbVETaYjPWt7jCgCfcGo2qlrXBlfB5VhZFWkyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Blz5wdNXkCkPELwXEU5HawUkI2lN+Oax9bh4YH8h5v2vUF6rAD9GRopjsNR2xFlhizsUC256W6cwJ/2heaMaeoz9Xu+uyUmhuLe2RJdGYaiUqIMJ6aH71ZcBw4FE+b9NlKPohwZmbDLxzceC5MvjNZw6KD1I74ZV2KJWNLMQHjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=HW+YzGte; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="HW+YzGte"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486fb112c09so39388355e9.1
        for <fstests@vger.kernel.org>; Tue, 24 Mar 2026 14:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774386482; x=1774991282; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HvrNB78/MbNCNXL3NPAFP3t4Zwsl1ZrFOecK0PEiluc=;
        b=HW+YzGteIBbzGykQ4dKSA3+5u1vcqX8eNnM+mcYkFvaaczYaLyolk9oCD0m89NXV6F
         F98Muqm8ENeYFx7eTz0PDqrFdpXCu7XkAfEYiR/1WMh2wDt5DjQIZv3e1B12ep1ZQ3bb
         7LRsc60nfLYaFHgp/AWL+UVdPVrZIM+ANoGzm1RgGSY8uyLdA13HS3rMZuA9Yt+TzyrX
         HUCBo5rnt5vfHwJwKkAG5Gy9UlSdLaefmtGQ75/54i/M0Sq2HME2SAruqh89H7qD5fOD
         zUlB7lVcHWKDppqe7zGTEE/Drr6RQHXU/mTieROtbGh78DOaIxwyYCH+e/EIo1qqtm1A
         /7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774386482; x=1774991282;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvrNB78/MbNCNXL3NPAFP3t4Zwsl1ZrFOecK0PEiluc=;
        b=nRJKVziKMfsoD3uNqg/gWSHsgAS+xzQUGXrPE6EtdR6BEiTNuKX80epDBmWGoHn45R
         CfT7mu6NGEzN6owMBQAiSYFdHsfwS4QhblRyvY6rgII7F4tsbJdjpGskaggDAiU/PCLV
         Is+j6+6PP/EAxnNLfjYHpfbn9vWjP8OpL1sBt0LqLgWJzUQK2fd4Wwl+CGZCATrs837S
         9YLJ/qPWusRpU1GwRtZJc14didZ+JBeJLrFKeD4xZaDnDWH1FsRny65f/6iprbGyyLhq
         Fnzbj8y5SOGdVgTnkbFpXdeuH6wn0gq3oSxu4DCQtjjFMDACEyrIxr63437xFRguVn9A
         dmwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB3bfJV+nHl59bDXQe7gy40k6a38sTqFC5eIwOuqvSa9WV+D4dS+2rM/qKT82otQNwxEcsKsFG@vger.kernel.org
X-Gm-Message-State: AOJu0YzX3sjRLFjG7l23+s9b0R2wx8HKE7zvCcS9J9tY8wVVSMh6I43X
	HJ/i+l08ws7ad3CWwPv10tbM6sNPEcxAsuWl1vN+qSTiEwZV9gD7MQ5ojP7SNtbWR+Y=
X-Gm-Gg: ATEYQzx/JhILMeyXp5KwsoNJ8Zgt8bpAHIvozBNECXCkyEHb0/MS5XlkYraWlH2zgLs
	0S3FitR7c1RrdTj9o4azXWjus1WP+DrcNWGZV49UURcp0RkHbnRcktEptI3CrhEl1Tsuj3kFfGT
	EA+MZ2wcVePE4rHbtqVEp6kMKLDMZb8PHRygeQ+2OH3oTM57V3wmYtD1hTA3CbZ/XfRjF5SZWvu
	k5jp5G6Oia7oVJUASLPuJLhBNhAdecxbv/Dr85lturqw3M35qqfhVR0nw1WBtf0pm7rNZqBZXuh
	YHPS6cqlDiZRU6V1CQvT+oKIns5I+AhosBei83EDhcPCbq29u3dYukgCU72C9Rr3j62hao7+JT4
	9ej5NpAQlC3QKrlcwUt7guIaL4ZuH44kD9jykFcHjpSyKD+JZTZ7XQoL89tgo78OUpCCwb15mxV
	1DGa1peOKONC+mGRE3r93YNLzuLWUHCVyYUaUR/6MhKNJnx6fpf/0=
X-Received: by 2002:a05:600c:c490:b0:485:3ff1:d5ed with SMTP id 5b1f17b1804b1-48715fc7437mr16688635e9.1.1774386482437;
        Tue, 24 Mar 2026 14:08:02 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c03124a87sm4212815a91.3.2026.03.24.14.07.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 14:08:01 -0700 (PDT)
Message-ID: <8bedc4b5-1e8f-47ad-a926-23c5c50778d8@suse.com>
Date: Wed, 25 Mar 2026 07:37:56 +1030
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic/301: skip extent count check on btrfs
To: Leo Martins <loemra.dev@gmail.com>, linux-btrfs@vger.kernel.org,
 kernel-team@fb.com, fstests@vger.kernel.org
References: <c56960b514baf810f2929b5e955a966d9955c468.1774383226.git.loemra.dev@gmail.com>
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
In-Reply-To: <c56960b514baf810f2929b5e955a966d9955c468.1774383226.git.loemra.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/3/25 07:10, Leo Martins 写道:
> The 2/3 fragmentation threshold was designed for XFS's cowextsize
> mechanism and is not applicable to btrfs. After commit 0dc118b3c327
> ("btrfs: be less aggressive with metadata overcommit when we can do
> full flushing"), btrfs commits transactions more frequently during
> writeback, reducing the extent allocator's opportunity to coalesce
> adjacent CoW extents. This causes the extent count to sometimes cross
> the threshold, making the test flaky on btrfs.
> 
> Skip only the extent count assertion for btrfs while keeping the CoW
> write + remount + md5sum data integrity checks, which remain useful.
> 
> Signed-off-by: Leo Martins <loemra.dev@gmail.com>

For the btrfs part:

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/generic/301 | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/tests/generic/301 b/tests/generic/301
> index 0303f25d..985d943a 100755
> --- a/tests/generic/301
> +++ b/tests/generic/301
> @@ -62,7 +62,12 @@ new_extents=$(_count_extents $testdir/file2)
>   echo "old extents: $old_extents" >> $seqres.full
>   echo "new extents: $new_extents" >> $seqres.full
>   echo "maximum extents: $internal_blks" >> $seqres.full
> -test $new_extents -lt $((internal_blks * 2 / 3)) || echo "file2 badly fragmented"
> +# btrfs CoW extent allocation depends on transaction commit frequency and
> +# metadata reservation behavior, so the 2/3 fragmentation threshold (designed
> +# for XFS cowextsize) is not applicable.
> +if [ "$FSTYP" != "btrfs" ]; then
> +	test $new_extents -lt $((internal_blks * 2 / 3)) || echo "file2 badly fragmented"
> +fi
>   
>   # success, all done
>   status=0

