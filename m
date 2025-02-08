Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D0A243946
	for <fstests@vger.kernel.org>; Sat,  8 Feb 2025 20:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739047215; cv=none; b=A/pAYrHhHGe0+XjcgZSEACZbIQDvKCaVSGNfVuIIrWGkKyqkB/ZTtCD3Us7zHdmuTpoTIHPRztdwCQgUD2M0ng+j6BJSNpnMSwYKo37h4XUVViXrgcSPEOhZcNc1xGqEkAd4638guSNWnx2Y3Uh0pAxgsw91X/Ya4F5O3BHQOZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739047215; c=relaxed/simple;
	bh=BJxs+CAn2wYODQDMt+B9UuqIGEGNZ9KYjZ+htkgZMME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dt33A7Yo2Rj6rayLlpBclmt26v1VNBuBwXwO2sQj6yMk/zc8+WnI8rHmieGc8ne4q0zxmAJV5L7ge4aUlRAoHTtpcAXOZSlAOIjubWyTMYOkwAMjTR+Q/tqhtqxeAO95ng0kXZwR4BzyByTirMsHQdZUftb6U5lQzdCf47gG2Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=AcAXh2ji; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="AcAXh2ji"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1739047211; x=1739652011; i=quwenruo.btrfs@gmx.com;
	bh=QB5wvxEJ9pR7nC4Q4ubBH3WnKsXNPjZLKOgElRmdMaA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=AcAXh2jisXBOH+k+vBN6CJme5/LqI6107jjNKqiFQ4YEtWpUVqbw5GwzUy/Ej8y6
	 TzFiprcN+ZxJaKyQfXzSkHk9PuHShnxgL/PseHe4iCBsE1Zj/luHmoNAs2bviKoX/
	 Otf/fL/EzphR0ESV52mhJSv1bIGO0w4Omao68/lj8YcQJ+EH7SN3/hOyO7B2Cbydd
	 XajRplU4CAgnpVuQiBzpMmYqtKZJ/0WvL2TEVO0mrKu7EB3T8pNE4bNzxqTbZ7S0a
	 5UEul4YH6E2NM3U0OsTRDX37fI/BnX5XzUmvsNLt3w6tgb9eqQATffkQBoVc3hNel
	 HBMHM72JkezagSUVog==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1My32F-1tTlWH3VpX-013pTN; Sat, 08
 Feb 2025 21:40:11 +0100
Message-ID: <dfe7dc98-ed02-4a18-8295-ced25f0b500e@gmx.com>
Date: Sun, 9 Feb 2025 07:10:07 +1030
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Failed to compile due to missing <linux/blkdev.h> header with
 liburing-2.9?
To: Jens Axboe <axboe@kernel.dk>
Cc: "fstests@vger.kernel.org" <fstests@vger.kernel.org>
References: <b7149d6f-2c1b-4c51-ac0c-0b2d7560330c@gmx.com>
 <e760d88e-e9e9-4e59-be69-eab333977f45@kernel.dk>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <e760d88e-e9e9-4e59-be69-eab333977f45@kernel.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Mj7Y+GCgZE9yFQ+AmdEn9M38KI7KoEDeTwA7LCmX9ABykqlV93a
 KHJvrn/F3P4qZnr/piTMBD8AtMTygXtYnWxwS0hU4cUvtWdXjxf4k9tHORKaCiPewZOk4hB
 LYOgKm/6gWXbmabq5VJRnLn0l1T4RuaqKWNk1kkoU61R3/Gs/5qhZFLsi4t8Y6eH7yhPIDa
 RuJNmsdwX9Jnj9sNt0YDg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3Zi6MPcZeHE=;gMV3JpSwWGF5kWvVKi0bjqK1Tx6
 BxYPDyivMWwXAEKt86i9nvSTmz8gxnkk6ua01QjRp7llG+6fzSTVb5mD2xtELu8uGeoBbk15A
 ltVPHAU1Oor4KYb8Av0NB4C8di8goyRSdSRwlB8ZW9t7K9UvgLKJik+ITSIYVpQOmKzwvQiBn
 A+Tjqk4Gj9ESIko6Qh4fXfbEwJFwfPE5fHOcjy03iLNQsLa7RYRUf7hqQIXiidjv+4g896/Mj
 5wZy6mXp1uy8+t4AZhBqburu1hyCjWCluN3Wnf6IF23NlElwiIFhXtAuDcHLvIqNPRoPbIsHt
 ulCjBRN0GLyE2Q6F9l2hlDhfd9No3+oLfKQ331oCuB+H8f5T3wB2JcYAkc6QL+wiChXepyEOC
 rgVBUN6akRCwqnFfqEwmj8qzPH0hDsZzv0NTdAEYzotIDaqe8OELtQWC2mnH3N0XLQFXTVCC5
 DTxTiPPlO8zMsPbt+UQSwpqbl+PEjXFCSK8Ey5scqcFmUWS8yJ0KpLmUXkVZXVkw9kT0v54Zh
 rp0hCHIPrM07Q6Y2KwlxyHQOVnF7b6vEGRB0wbINyUiH0pz4vE7K6GYLPFG33vXbCkJ+hGyBa
 lqfSUs0FuLKpg1hiYNjaNP+aTLr6I378m25Jn9bSu6QEblwiOO2yY4JJiTFwBOu0ZmZ+Vw4ys
 84ZqihFernpzgc6cr+8cEUwzAYVkEXDZ5JDnZssTILXuhQXI5mIh9OyLopNhgIKSsXkFZaRwj
 xhIPmoCESZ1td3+JQvZqrZrHXkJbrFozfEqctNY6HsS/gvbfKzQL+wtxlvZ5wMTFJrhEbU5IH
 q3K5z0pRxO8x7D3o4gVkX4s14YI4NBvW3lI5ztuShozPrCo3lHj3fPfU8ZXesCf3Enfkt98mX
 sBFVlRqZfE/V8kD94els2z/8wHQSIOlI0WdYEo/8lwHkrSuyTBoVm4tc+hi0nLJbukunVp0Hy
 D+2ffS87fXYt5pZ4TYE2PbAMyh4T6uuuzuIu7J7PeF8i40NiuKeSwso5yLlDZGttt8pHfDJiC
 HYJ/ngmSnJYCeWcGVt1G4XeAgGHF4+euV4UjbmUiLaVXQvq+JkdFz1gyqifXwslN7ZCIKd751
 N7QQP2pq+RCAJtqNdAJITn4UVtbGS/2lzXaqlfivYQ2lql1IaM2aFfBfI+MkcX9M6cbRIht96
 Y8v1omQy9eoc9pmy4YYt/jWFD4WsLYVH7dZKyOovrqECysYR0nrbP5tDn8ziiKUu8PNpBvz0A
 wzNJxyixzNLC+yvGDg8WkJQ9pV5LBSp6sKcFhWFeb/KJwZp3iG4ekbtgjNhVCIi5dNake/cRF
 MejvRMHZ7WwNN+0LAvZOHkAFQuoTOBbB3+aMqHrw1LTS6kqwsGo0sNAQeieYOvhtrWbyuxkM6
 /IxVkap3lYlSrRHzxjF+wEo/AakUsI/UGa8aIrcDuJQfd8xapIWLo9FG3e



=E5=9C=A8 2025/2/8 23:41, Jens Axboe =E5=86=99=E9=81=93:
> On 2/7/25 8:43 PM, Qu Wenruo wrote:
>> Hi,
>>
>> Just find out that fsstress no longer compiles on for-next (v2025.02.02=
)
>> , patches-in-queue (a494849fb48dc6b276c2a1784d6ff66c731e5572) nor maste=
r
>> branchs (8467552f09e1672a02712653b532a84bd46ea10e)
>> All fails with the following error:
>>
>> ```
>> Building ltp
>>  =C2=A0=C2=A0=C2=A0 [CC]=C2=A0=C2=A0=C2=A0 fsstress
>> In file included from /usr/include/liburing.h:17,
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 from fsstress.c:30:
>> /usr/include/liburing/compat.h:11:10: fatal error: linux/blkdev.h: No
>> such file or directory
>>  =C2=A0=C2=A0 11 | #include <linux/blkdev.h>
>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 ^~~~~~~~~~~~~~~~
>> ```
>>
>> This seems to be a change in the liburing headers, as v2.8 still
>> compiles fine.
>>
>> Is there something wrong with header change?
>
> Are you on arch linux? They messed up their packaging.
>

Thanks for confirming, will report back to downstream.

Thanks,
Qu
