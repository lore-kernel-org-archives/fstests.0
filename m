Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9591CB501
	for <fstests@vger.kernel.org>; Thu, 20 Feb 2025 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740033784; cv=none; b=rTOcx5iiVXgI6uQ31TBlwUOPaIy6CeDhR33Rb83jwMD+9Swu4BBlyj9hZMRfRfHutoXiL19VTR+ycFJBZV6gcA+94ICZ7rIvv0fmG8Whdpan+nbKJ0ZAREXUESnh3WcQM8t6Z1163IB/QczSV9QK2vNfWu5AhwUqKslfeAKWLxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740033784; c=relaxed/simple;
	bh=Eokg2V3Yvp2KSEhFD5KjBl02HUTMrmJ4lXkAdk8qm8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GpTvjYJRrnP5dQeJ//b/8wfyfPRuZHg3o/3gbQR+i8YxyAcEwtG0FIZTUoryuXVQWON/ARBE13Ev/tLziB3mwrx2gLd3XDdvYD8s2DM7g9xbMhLo2OjqZSu9sY+5f2UgnVVEeZtNsZ9yPnB2bVz9rY68UDcJeSd7h9OUGaTm3S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Tge4Ovco; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Tge4Ovco"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-38f3913569fso986593f8f.1
        for <fstests@vger.kernel.org>; Wed, 19 Feb 2025 22:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1740033780; x=1740638580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zTuDDf5qpxS8YpPXcwb6yMNEAv+LYFNJ0jetRHnbsXA=;
        b=Tge4Ovcotz1HEOdb4+wwV4xmGZ4f1vs6w6dT+rW7OywhaRbNLOIfI1TpyKVzQXVAba
         rL3nvvU59WTpn+X9pps9bmgwkhobx5cYPQ7H86ajPRgEmZeeWeKPcf13tZB7xFJlPLvx
         xQ24BziKBwDgMUxqwNxQ8QlQRFeT63WuYXveZOGqRJ7GoiNmdTkhdPnFjKaiR+NXpfTT
         wsghjzCAg4t81g8+Nhft3RUmVlEnyslQXK8XiOyIcOmzdIRjAj/X8qo9ssNF0AVdjKXO
         lAt6cOhtmI3b6YS9RgOrAta38WX3tmWx8LW5tE7AUyaWGFgP6BobWJ/KCKe052UxbKXw
         SagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740033780; x=1740638580;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTuDDf5qpxS8YpPXcwb6yMNEAv+LYFNJ0jetRHnbsXA=;
        b=jYXaMcY9fwjD8uXAW8lheL8W7kg1Ot5bZFXrsicJPiofvIGV77HWx7+o8eE9RJLXp8
         5w4nPbMw2iZWZ8UpgYQ1EyNjojM4JiHEIqRuCM6y4pVYA7iGUiUocnpuJ8Uw2BWoS3vF
         zmy2H35y8NGlRCSJuaUOBISp5YOsS7TLCuJvHgmGPMzbQPcRRHTqn3wVO7pPcVW4oq/W
         adFXZg2k4GTPM6/vcqrH6dmZdAkGtcoepD0iIA/3oi3iYXC+2E8jRwXK8WCIM90abM5o
         TxjvyjIaRMtCkxbLhCJqHWB87DHGsLtAON8YbKB89trlIbbFcF2gyxk/HTn1H+TXBlJN
         5TZw==
X-Forwarded-Encrypted: i=1; AJvYcCVFs5f+oCUNDxeCOfe9v5vZbz6WZ2pOCnhvb5NpD4Vl3RUw2Fwv9+ADpMvzxEa4Q5VyjMKyZlF+@vger.kernel.org
X-Gm-Message-State: AOJu0YzSLTliPra/uKo2kh4I0Hp+YXS2jAmJKJGhMAlDJGX7UwYNlCU2
	FyVEO/QoM1ebLSvNMgHpiARmwqZmFmQ+SPhzdTJeWeMT9IKFvj5nRUN4aBDppZ0=
X-Gm-Gg: ASbGnctCmR9AXS/j2DjYcO8V+aqnMOQ4AhwH1b3ucHr4t5INaZZbZXNOaZXnK9JYzu/
	4fPftsDXOVLz5W4tFAmxN+Yl9s6sXn4ws5xq77hLuImAaVmtR3keNInSfvGExTO/is7z/zIE2kD
	K5gz8GH4gyKrhJnnU4QcVd0k2XFPtAK/cn1utaFSEwjZVFtDAZN7ivc6dnuwO0lpBYXKqT7BU63
	4pt8HZMfnWqm9H2Vriu0Z1xjMxbOmOynQA4i8sqLWHKAW3rOE9DVbnfDelgf1Jpb/GVxxit5RBz
	HbHz78TIUHF80oez63icPq/t/aAYmygpYf8itMHr2Bc=
X-Google-Smtp-Source: AGHT+IEOEm6JeMzmk7lcl1VWh43gUSbAMqXnq19unBySFr650AW8WP2D18yi2cq4DEl8oelEiD46IQ==
X-Received: by 2002:a5d:59ac:0:b0:38d:d8f7:8f75 with SMTP id ffacd0b85a97d-38f6160f9a0mr1374208f8f.17.1740033779878;
        Wed, 19 Feb 2025 22:42:59 -0800 (PST)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d55b6ab7sm114091555ad.132.2025.02.19.22.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2025 22:42:59 -0800 (PST)
Message-ID: <3d281b8c-13c4-40ed-abaa-e3b98416d90e@suse.com>
Date: Thu, 20 Feb 2025 17:12:55 +1030
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] fstests: a couple fixes for btrfs/254
To: fdmanana@kernel.org, fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, Filipe Manana <fdmanana@suse.com>
References: <cover.1739989076.git.fdmanana@suse.com>
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
In-Reply-To: <cover.1739989076.git.fdmanana@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2025/2/20 04:49, fdmanana@kernel.org 写道:
> From: Filipe Manana <fdmanana@suse.com>
> 
> Fixes for btrfs/254, details in the change logs.

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu
> 
> Filipe Manana (2):
>    btrfs/254: don't leave mount on test fs in case of failure/interruption
>    btrfs/254: fix test failure in case scratch devices are larger than 50G
> 
>   tests/btrfs/254 | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 

