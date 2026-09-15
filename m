Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EBC343899
	for <fstests@vger.kernel.org>; Tue, 15 Sep 2026 22:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789510765; cv=none; b=W+7sTix+qomkngp2fcA2hq3q9XUvzMbGvajOampkf3s1ZoLlIXaIJ6pj4BiQns+FFgO8/MlRXUtSs5fSeOG3FsOUlGKetSB/we1XBksbuLKQypZVcnrh5P8TpN1qq+S9F7VqkTBw9ZFZCtzbeKROAJbmY8UcGNPehdY80j1lrZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789510765; c=relaxed/simple;
	bh=L4xo4wPOKAvUPtximANIcmyw+tN5k4wV80yANO/epwc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DQHh5p4rVBj/8rtS1fe3FcCrZ56X4jKo63YeujJCtf7xXTWjQ0jka/l7XUHyYfSpGge7M7zhuLSdAfLzEuILuXCgaeLLpRjiov0D+INnxl2ZbYTmtDDxCL3C2cKsMuOncawzE5tY9EsqlgEExoKOYC7F4ROknFTWAl/hcg6jESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=MStdKDi2; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="MStdKDi2"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f560398so52553166b.1
        for <fstests@vger.kernel.org>; Tue, 15 Sep 2026 15:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789510762; x=1790115562; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZVQidhjw84lz9C/NKuqC+wIZjbIbZWuve/5ZzSwfmQI=;
        b=MStdKDi2ufCyWBCK/RveXJHjds135uWaVlo1sqZfW4DZChF9f2VYmzdGIE0iODWOZ3
         58pjO1d0T5zQ9kTHwNzy0wsYEjao2idz0/FpOAMYR78cc+WNW3Wm/zzJ2mzS1aM2DHS4
         SZ4hLJ0ulCZjRTST5WFbzNOlUDK3MJrvTXtey+2+ZdOwASQfm07KLywrgjQOPvWygSWp
         WH5FgKBr9wIDFSQn3k5w9sRRsfiLI6j5oGgVd1i4rPqhGlMapk6WB0TQ80tgFG6Ivvoh
         /6odzMjqy34d8MUpB1Hb2EQ3yMWWtSMsQ8BgqzTSy1aXCOGnbtN8KCjczGsYcfui14wX
         xMVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789510762; x=1790115562;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZVQidhjw84lz9C/NKuqC+wIZjbIbZWuve/5ZzSwfmQI=;
        b=De7szFBwEmNIXSwVb3P/imXMJFEK5WSSxkBT4cz/GsTcuIbInL08O2uG6D5cwTGSfK
         JRnDt+EzJugFdN6Zy6HbQgMboPKO6I/JWsct0g0CrwVeSG79MLfOC6gdKOG2cTojYi32
         EhZAyhkfxD/NMic/z+QvE5lyilsStCMAZoqNyK8Kv1vGVb7s7arQTgFrfffXxl6+Ahkt
         X/dlI1+6uVb653gidk/nTeIPk644q4OFkDV+qp71WKAoxRKUNn66zfQzCKaDFg1HvKWL
         1p6ZGsdJ3HDWt7MCKK6P4khqYUsDk8ujCbf17JPiaa5h/w+JcIKYZMbaCEUdgliEKyNC
         6zfA==
X-Forwarded-Encrypted: i=1; AKwUvByQLlEyraWxKAYP0hUQZk4eapIL4XtSHITOMmjnLnjSiACxPENMdYnkx7yJWc/04t+kXpxu26/j@vger.kernel.org
X-Gm-Message-State: AFuF++n3g8O6+rgtljl7h2hB8+TjEO6Ik90xnulWeyuMizIstUn1DVDk
	8sOetaHH2gfX/oIUwr8eSbqvl/ymakXkmBHEXkFRA3p1FpAN0g2HM5j7MYIrYyBs9fA=
X-Gm-Gg: AYBFou1rGYT7sB5bYrke0hAWDFEFyUzrugCOofN4k4H70hV0zI9/2uClgmvbgN57Sof
	pVHTPn2qpgKJ2uiebK3J4Lubo67zxJdeebwJqeoXtAMq+XocO2Y6O6uTPzkWq6b2HheVD1PuE5k
	PFIU2U+rxhNr8oGlWvyTXSktd6DQ2PxxSxMrD9vfzq+CI0lwJ5i0vfMiDnwnIvfuXN/PhCQmH2z
	Yxm3NK8YFk7n7UrbElSLIWc0l5ZWecPPmMwVTP+G2dGfctlayASWJsmknl9Q+cR/2FcUqsA34kG
	+grGromB74512SmOrHgXFyK+H3iJ84i6VHQQo/b9ZKWbjfPvAuHuPOpaKp4SuCzSDiODQEhnwvn
	n/iXeUzRuceSCLtu3cm60vNtJlP1iJA0VX3e2U+JUVilhlSQFDlgbmJEP79dPGHT5yWy56CgRUx
	pzGGiTJTAi3MRG/KUkFLUTbFkduWX2ce84L/dxQQ7bMFTU4ps+vuH6Q7YYAuznGmI=
X-Received: by 2002:a17:907:e895:b0:c29:63f2:99bb with SMTP id a640c23a62f3a-c29e536364amr3312366b.47.1789510761727;
        Tue, 15 Sep 2026 15:19:21 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e1c2c5d86sm235579a91.4.2026.09.15.15.19.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 15:19:20 -0700 (PDT)
Message-ID: <45c16e73-22da-4f18-b96a-11572bb7333d@suse.com>
Date: Wed, 16 Sep 2026 07:49:14 +0930
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] common/btrfs: exercise all algorithms in
 _btrfs_stress_defrag()
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <97cbd58be421a2b35567031d58002f73493b3316.1789486109.git.fdmanana@suse.com>
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
In-Reply-To: <97cbd58be421a2b35567031d58002f73493b3316.1789486109.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/9/16 00:59, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> _btrfs_stress_defrag() is testing only zlib and lzo compression with the
> defrag tool, but we also have zstd support for some years now.
> 
> Change _btrfs_stress_defrag() to iterate over the list of all supported
> compression algorithms given by _btrfs_compression_algos().
> 
> Signed-off-by: Filipe Manana <fdmanana@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   common/btrfs | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/common/btrfs b/common/btrfs
> index 3eb68beb..1854cf07 100644
> --- a/common/btrfs
> +++ b/common/btrfs
> @@ -414,16 +414,17 @@ _btrfs_stress_defrag()
>   {
>   	local btrfs_mnt=$1
>   	local compress=$2
> +	local algo_list=($(_btrfs_compression_algos))
>   
>   	while true; do
>   		if [ "$compress" == "nocompress" ]; then
>   			find $btrfs_mnt \( -type f -o -type d \) -exec \
>   			$BTRFS_UTIL_PROG filesystem defrag {} \;
>   		else
> -			find $btrfs_mnt \( -type f -o -type d \) -exec \
> -			$BTRFS_UTIL_PROG filesystem defrag -clzo {} \;
> -			find $btrfs_mnt \( -type f -o -type d \) -exec \
> -			$BTRFS_UTIL_PROG filesystem defrag -czlib {} \;
> +			for algo in ${algo_list[@]}; do
> +				find $btrfs_mnt \( -type f -o -type d \) -exec \
> +				     $BTRFS_UTIL_PROG filesystem defrag -c$algo {} \;
> +			done
>   		fi
>   	done
>   }

