Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87BB1353346
	for <fstests@vger.kernel.org>; Tue, 19 Aug 2025 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640758; cv=none; b=lTS/N/Xw3r2Kf7AhnKQz6eD00nEETZybCp4vcTUJ7+fIM0WvOcHuMuEhkXxhsk6i3kGJl595b1nVSAfJy4lRdMpvjf5xqiLi6ViLn6XogWrq8a8gcaAullH9vLMLHvISYJI1yX7asn6at7bmdS6w0s8AUz+bbavq1yCTHq70Rp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640758; c=relaxed/simple;
	bh=inmnY4PV/KOfPsxdHCJiK64MO9/qTvqbWgizOJ7kAFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EZ8fMGGPnUoiDpGgTSL7LxCNmg8p/vWGURG6A3uLjZwua2obT60GQdIwdh0WlrgNaptmprzqUPVaAZeP38W9RDE3OAIrGthcuTf2fM87GBlI/V1PZ9r7Ns4QoGE5qBFxym0tfZhiPXF+OeP7bWIpvJhfc7uPZpTOjCAdbB622QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GpkgCT5K; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GpkgCT5K"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-45a286135c8so1778985e9.0
        for <fstests@vger.kernel.org>; Tue, 19 Aug 2025 14:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1755640754; x=1756245554; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=rUlAuILfOze2r61y7KA7vRVQx03to8px5XRMKOD01HU=;
        b=GpkgCT5K2C8O/YlpU5zYqXF3UUcWD4lnKRy6DzFxIYqEztzeX34A/PpBdkTmSnaLpP
         XrQJc36vcKsRbKtGS45BBwlMsLeUYZeSVGGRjk8JiLBJom4UecKsqkJONE9wiygpCbzl
         nR/0MZ5oY8AuR5IMiES9aQfWw0O1TTEGMWPYFq3h7w0j8abaXRy9fNqMVArSoKFlMS5A
         muWVCKlTwWke5DqXWKxytrFgjr5RMTCiqG1xk5hiKJSDy08wOT/+XAeTirUqH99pHTYP
         f2zpO34H3BLPBcH9ypibLbuoMwVDrux02Aun762IWqt2z2G8kNV5byFE3aEOLPXA6VSa
         x9vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640754; x=1756245554;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rUlAuILfOze2r61y7KA7vRVQx03to8px5XRMKOD01HU=;
        b=g3TZHfwLijLagO1mKIDdr13ZKGcb0rBXLKbja6L/LDtcV+UYFaUWna/IxgfzGFERFa
         ilxPXA0qIKLBEA5maG4wO9Mbx9yllb84lZ6iC8iaGakJrdrdC+ZurjJ1xI4LESnItS0s
         df0utZj1fm857ku2Q9OXGIqmjL7D6FF+E6AZMeC6f759Bk5Q1i/+IrkvCRelSXCw+mcs
         kFwd9TeKeLE5/Lv2+5/x3CRMwzYjXt1SuRyVnr9nTI0chZ8pC6zb4BZKlp1uFG4SAamf
         xk8Ns7R3iW1ijI/Q55kWAGQ9VN1lO+jaltItOstK6pvRAoL/+6rQj9bOaPim8aB9UHBt
         +opQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbwqp3PxNzbU/vJRWDy34hQK/JyF8RsgbvrHhP7beJb5PiEELdin6aU1l3Rj5IjifueQ3XE/XK@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx5H4RoGAjZwEYSTVjUhBW3k4M/cptWso7mNPK4nHsik+shuax
	4h3+MfTHqxxlAe69/sn6OmvBSVkDLIeEcfjWdruWDBhkEP/R1ymltbwyttufYldejN8e23GUbbm
	myTu5
X-Gm-Gg: ASbGncu7tHJeJauOUBD3dpU/VBVC9oW2BUNAiRvjGjNP6fIs3I8wub+bESYs0Pn+n2L
	jvOlVDFPFKw35H63A2lhcuwuA4SBIy8vJIIiaFk3X/hQOLrrwRyWPskmGxCOod/DrKAdes5R7a0
	g2onfOUPSLYbHdUNgR1Rsnl9IqtkRKn41UPQ+GcvZziY10gaJIKlzapv5Ld9GgBNPJxGoZnVRyI
	XHqbZ4NiIaVOeds2vzUKCYB7nEBo1SeqI+8ENX6HozSpEa3FBsC+Zgf9di/4N8qDn+tkqjge6y/
	Hd+h53Jr2TG5jDHS3jG1R+iNyIfAoL71INB8LnOlhwl5GmBt+Au32tt0cnjBmGCUGysVGHn6W4i
	8DKGM2aAQBuwetD4z0CWYm6NcQeLsBS/hFtwxvtlDwu/tKkX3+mk=
X-Google-Smtp-Source: AGHT+IHIaTOhTTCeWHRYbi1rPoijG80hFcco8UcQG8z7UoPrK2NZYoaX01K6loeSJiC/6BbDPbDKhA==
X-Received: by 2002:a05:6000:4313:b0:3c3:5406:12b6 with SMTP id ffacd0b85a97d-3c3540616bdmr97037f8f.30.1755640753772;
        Tue, 19 Aug 2025 14:59:13 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d5c09sm3491602b3a.22.2025.08.19.14.59.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 14:59:13 -0700 (PDT)
Message-ID: <f257edaa-b7aa-4076-bb7c-a2f3dc7549fa@suse.com>
Date: Wed, 20 Aug 2025 07:29:07 +0930
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] btrfs/301: Make the test compatible with all the
 supported block sizes
To: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, ritesh.list@gmail.com,
 ojaswin@linux.ibm.com, djwong@kernel.org, zlang@kernel.org,
 fdmanana@kernel.org, quwenruo.btrfs@gmx.com
References: <cover.1755604735.git.nirjhar.roy.lists@gmail.com>
 <122da7535db9470515980b765ebbd05f6dd7d882.1755604735.git.nirjhar.roy.lists@gmail.com>
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
In-Reply-To: <122da7535db9470515980b765ebbd05f6dd7d882.1755604735.git.nirjhar.roy.lists@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/8/19 21:30, Nirjhar Roy (IBM) 写道:
> With large block sizes like 64k the test failed with the
> following logs:
> 
>       QA output created by 301
>       basic accounting
>      +subvol 256 mismatched usage 33947648 vs 4587520 (expected data 4194304 expected meta 393216 diff 29360128)
>      +subvol 256 mismatched usage 168165376 vs 138805248 (expected data 138412032 expected meta 393216 diff 29360128)
>      +subvol 256 mismatched usage 33947648 vs 4587520 (expected data 4194304 expected meta 393216 diff 29360128)
>      +subvol 256 mismatched usage 33947648 vs 4587520 (expected data 4194304 expected meta 393216 diff 29360128)
>       fallocate: Disk quota exceeded
> 
> The test creates nr_fill files each of size 8k. Now with 64k
> block size, 8k sized files occupy more than the expected sizes (i.e, 8k)
> due to internal fragmentation, since 1 file will occupy at least 1
> fsblock. Fix this by making the file size 64k, which is aligned
> with all the supported block sizes.
> 
> Reported-by: Disha Goel <disgoel@linux.ibm.com>
> Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/btrfs/301 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/btrfs/301 b/tests/btrfs/301
> index 6b59749d..be346f52 100755
> --- a/tests/btrfs/301
> +++ b/tests/btrfs/301
> @@ -23,7 +23,7 @@ subv=$SCRATCH_MNT/subv
>   nested=$SCRATCH_MNT/subv/nested
>   snap=$SCRATCH_MNT/snap
>   nr_fill=512
> -fill_sz=$((8 * 1024))
> +fill_sz=$((64 * 1024))
>   total_fill=$(($nr_fill * $fill_sz))
>   nodesize=$($BTRFS_UTIL_PROG inspect-internal dump-super $SCRATCH_DEV | \
>   					grep nodesize | $AWK_PROG '{print $2}')

