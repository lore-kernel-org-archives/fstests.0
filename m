Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09297151991
	for <fstests@vger.kernel.org>; Mon,  2 Jun 2025 05:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748842063; cv=none; b=Usl6F883A0CIWI0MVjkrLSQl4V0m+IXmarRVwTaus1Us3UU187WN/7Cq/DacK6mmfI4q5mP9AjNRsSdR2Q2uo2Mne96Pg1vwoQoLOt2PQdACwiT5D4ZO45/wZmPlxzONlHTBE7UEkCd94R2MwiY7hIzTd8CdFeg9QGXkhwPeOaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748842063; c=relaxed/simple;
	bh=iMsQBKWmQo5ervVm/xYqHQHfREJYt0aPDRRlgIbhiJw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=mP1kWNomRVvkYJI/yC/QXy+4OC8Rqhd7Z1L8g0TiOwpuUvSwuOsfOu3KD+VVH43FXGPTFbMDgF+Q6/R3/vFg3mioTyrP+yUQbD8yl3o52ivZx6AqlmfA+jge+PX9bBoXoM3lLS4EfoVMB2QQWw47SbbhDlb+Lnz5BFCkE/KAC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ASNZCx2T; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ASNZCx2T"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-450caff6336so22474695e9.3
        for <fstests@vger.kernel.org>; Sun, 01 Jun 2025 22:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748842059; x=1749446859; darn=vger.kernel.org;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aCH0bGmkwFQ0oUtv+YEu8TOogqu6Zwww1ytD8yRSxs8=;
        b=ASNZCx2TnaltOr2B0IdTXZCkd6LYzK5HIQXljnW4HJ0ZRoia9ST6Ot7edEV/xCfxmA
         Tdy/UPZP5AWFxIzPpzk24Z2aGx8Y6habmZZPaXyNYx6qH7eV75NBIPB2hMxeYtoMFdLr
         yr84UtNFJtpj4AOFdRGKTogYK9pFf4CCw1NTxtM9pu3njngkupHEis9d7OM76RJmgzNm
         WA9A6sRia2/rRnVcKRtamHL7pWxdHavvO2SEE4jbgEARBozPhIAg0dC5HiJa5VtpLJ8Q
         rGs9vWsq5KAoPgeTS6amTnQ1f1tvu5EnyZbv5kRNXnLULg04U15FQOa+SIFJsSKujfD9
         28Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748842059; x=1749446859;
        h=content-transfer-encoding:autocrypt:subject:from:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aCH0bGmkwFQ0oUtv+YEu8TOogqu6Zwww1ytD8yRSxs8=;
        b=Y6H0g+8FqGMdWmY/7dJy2awKnMp+/jCMBBmBcAhCalfwoZt+hNU0/MnN54cnI+L+ka
         /EoyTfdsvVl9BlnZTmyvSha+eZUgx/LHumhaOwNt0GqTuEMhLA0yNmFI2pxWEscRP+0Q
         3HmwavoPb7+AV2yIccJlNQXdHkd5ve8t7vbMvion1FyNTjKqq3Okq9bEP7EoB15U1YVi
         wcyMaeQMwpjPh4WAgAxe1EUJpO12d9Ek7U8NmV0OKzZ/ZV9guU8Qi3XaE+zuDqZ1ys6N
         0od3fh8lPUWnu/kmUNoMz9asffTRNUOzFOtBDwY0tjQwmhEThoTTSFPv3iVO6KM/cjFH
         p1Gw==
X-Gm-Message-State: AOJu0Yy3QwcsBg728GXgffI+/XtjtLcTndYSoWDw8yuGJBqNUYJr18IH
	GCu0Ge+eL1FGC3Rc+3ioEBI4rO3/q1vjPdD3vC63VICffLyoIPba+vN7CYBxt1GqeMG2X8ZT6BB
	7Gpuc
X-Gm-Gg: ASbGncu8/BhvKDKrYBfXO1DncvX0/IOnOQ6yjnqKtrRL8366TrHEQ5deXqF+gQYPg+n
	H43qDVhfCrnLPmjPgSQvBWks2l7Z2uda/cdRaQXZVV0pojIIKw5yT5CMrTatAgMd/tGVbkJAPDE
	j39nVMO0Irm3nOeCEad+tB8bRJ0OinnFREruh/6u48CNw7R2eFfHyd9PyDaqC3qUC1ArW9gADxf
	MDIGVUXD7lpbl/Q/Wn0CyQGdk4plgE6Dy48CAmsYG+2pX9KuI0mv8FYk8kC+yzmFOHuYz2dKwvV
	8AvLHDt+6rGnOJvsE0i3sH/dS8atMvx5N8Vy2WQabJvnfXUViyd7whDu20mM9dT3YFJNnoME01W
	XTWs=
X-Google-Smtp-Source: AGHT+IFvrvR3g9f/QlYbsKHR6XQ6lLC7CrFLCNUVuDtc6HQwWob3qcqCbe+Z2M1LwkP/xtmvsCethQ==
X-Received: by 2002:a05:6000:40c7:b0:3a4:ead4:5ea4 with SMTP id ffacd0b85a97d-3a4f89ab616mr8721464f8f.24.1748842059172;
        Sun, 01 Jun 2025 22:27:39 -0700 (PDT)
Received: from ?IPV6:2403:580d:fda1::299? (2403-580d-fda1--299.ip6.aussiebb.net. [2403:580d:fda1::299])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23506cf468esm62830385ad.165.2025.06.01.22.27.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Jun 2025 22:27:38 -0700 (PDT)
Message-ID: <cd39db71-be9d-4df4-8e4e-e7b5d7a09179@suse.com>
Date: Mon, 2 Jun 2025 14:57:31 +0930
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
 linux-btrfs <linux-btrfs@vger.kernel.org>
From: Qu Wenruo <wqu@suse.com>
Subject: Weird failure count if generic/210 fails without any output
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
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Recently I'm hitting the following failure, the failure itself is a 
known one, but the point is there are two failures, but only reported one:

   Failures:  generic/747
   Failed 2 of 1091 tests

The missing one is generic/210, which fails like this:

   generic/210 1s ...  1s
          [failed, exit status 126]no qualified output

But it's not shown in the "Failures:" line.

Furthermore, I can no longer reproduce the failure on generic/210 just 
after checking out the latest patches-in-queue, and re-make.

This failure may be caused by my recent system update, which can lead to 
old binaries to fail to load due to changed .so libraries.

But this still makes me wonder, is there some error detection bug in the 
check script that can miss some test failures?

Thanks,
Qu
