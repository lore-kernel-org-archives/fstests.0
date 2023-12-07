Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TYgz/GD4"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10F1FA
	for <fstests@vger.kernel.org>; Thu,  7 Dec 2023 01:49:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701942544; x=1702547344; i=quwenruo.btrfs@gmx.com;
	bh=6mkZFSQBMOHTdEyQR1s5DTbxkqliaYwRufdHch7iHZ4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=TYgz/GD4C0QVE7VBjR8D1ANW8fF4Cfipqddh2KOVtqz2ojqG9G217YBTRBb7aI1w
	 aKwOvO/vQo6QCY13/9SRgABBUPU2rLPoxSSmnoWrl3hEFmu/bm8DD9LuYK/oFTEak
	 llb10uE7GBlFpsJHq4qG1oHPOhFsatZgUe/Dm5bn8gfV7SVxlKpV/P9FMGxx1jDqR
	 /zDGENwhsamJJHBiP53XYz9zw374vN6dUbSADFBXc/cjP/bBy20SXgBuyeYdHhg1i
	 k7hQCVUtl6D7wFoYnvY4wpgiLi075WH58B2qU+jGAMidqJg71d6uylbRNjJjVu5Bu
	 qg/zIHQDwuFSOVGVPg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([122.151.37.21]) by mail.gmx.net (mrgmx004
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1N49lD-1rJfNW1g9J-0103WT; Thu, 07
 Dec 2023 10:49:04 +0100
Message-ID: <949dd5fe-560f-4986-b653-c84aa9afd778@gmx.com>
Date: Thu, 7 Dec 2023 20:19:00 +1030
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] btrfs/282: resolve intermittent failures
Content-Language: en-US
To: David Disseldorp <ddiss@suse.de>, fstests@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>
References: <20231207072056.14588-1-ddiss@suse.de>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <20231207072056.14588-1-ddiss@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5hVhXYEvrsuT4EqVyP4iM/X4E1jEwxAcFJa+37iQjmtWavFQmTp
 bu7Jfdb+TSbp8G5YyP5XhST0HPJhjoBHP96s9/Am5YlHHDm0rOVOWSEoSOazPxmxsRv26xn
 UQ5Bf86IUjD+/5ywmT9e/PkKaEHJzDOYDAZh54JPuOG94lg/A0WdzORv9d4z7vlFyd0iKQO
 smoEnqYoSuV7ZON8cTz+Q==
UI-OutboundReport: notjunk:1;M01:P0:A+qUhPPrVkQ=;MjWUt2KB6RYpjzRG1M6Bm/77/bJ
 e6Z9JKyBu4MPGSaYau0wMI8E1MrqolIglp9/QSSF45OvWWMDPjX9iozygP7PkC7nGDZTuvu9G
 ySZtF7SKrhxYezUVoJX51ETKFsxwSG/9ZWxvrjKS+eE3zKzptFgAkIEV/TDaHhIVUWkQZsDTb
 4mpILDfQ8erwhd6Rwg8nvn3fr18x2HF4m7AJuCWzPuT4WmfDym/qkZeJU0HArlh/pfUwnJQ8/
 qIsD0DudodbBpWCNMQjkNn7OCL1llvhEZv+rbZEqUbWpqr19pWTNjCNj4+VJ9n4GoHBDQvt83
 fY2yCWfBwVtDyTcyWeQCInrhGUgU6V8iXKbTU2huOkbOJTyqhXIzZJOlKLRklGGNVhsVEsmIi
 FvpYZFmEOk/KPQfurh9sOQfmMn+vqqJDIQpKG94xwM5A3WgaNJacnLLcyLGTgcqvTZ40J8VQt
 UMuojP2EL1bsR/zvA2wMDDVYUQPyDXQ58SWfmmNAkHkzCrGYtJy6BfhQ9RnEmm8xc1zn3gYMp
 2PuGau47L7ghzTMiC7nDPmcCUEtQ2is6VKF03ZW6WbbNmd5UUpq6Nkag/tHbvl5dqYNp9th/J
 DutQNAgXuU+j5atlpKxipMY1f3PRqAF6Zl5Zj8BXbFTpXPn5FYgjGUa579UPdqW92fegTNflj
 OtkBaOPSe+Zg5EdW1CLTxDCY1fD6oRc29CJAd0dvpFf7N0EV7+M0zgwo8gScgOnvCi+HUjcqO
 Exgo5b0Tj22uCMhNXLhA4dcS08415WnNRa3WJChshoTVGc23ed4kiUVlOEzCzLj17AZi4bsau
 HX/H3u39PC+uNCZK3WE//U7+SmSI2WEIjxpgPcOc9iFIA02hsUsZLrMyAhBkOjpXTcWHl8Q0V
 2zJy2w20201UHnqZ39zJkvmPNOJOul4tUu2azG09jGeq8VwetGwgK+/bhYlhUKgriUdZBMb5v
 T2rFhHFNMfJiSXPlFrZOqnx/u0I=



On 2023/12/7 17:50, David Disseldorp wrote:
> btrfs/282 fails intermittently under some circumstances. This patchset
> adds dmdelay to make storage latencies more uniform and slightly
> increases throttled rate tolerances.

My concern using dm_delay is, is the delay per-merged-bio or something els=
e?

If the delay is only per-bio (after merge), then I'm afraid it would not
be good enough.

The bio plug we use in scrub can have much higher chance to result a
difference in the scrub speed.

We may want a delay behavior which can take bio size into consideration
at least.

Thanks,
Qu

>
>   common/dmdelay      | 13 ++++---------
>   tests/btrfs/282     | 43 +++++++++++++++++++++++++++++--------------
>   tests/btrfs/282.out |  2 +-
>   tests/xfs/311       |  2 +-
>   4 files changed, 35 insertions(+), 25 deletions(-)
>
>
