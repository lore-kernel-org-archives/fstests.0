Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bv5S4DzE"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C87410F7
	for <fstests@vger.kernel.org>; Thu,  7 Dec 2023 12:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1701979328; x=1702584128; i=quwenruo.btrfs@gmx.com;
	bh=jRozNKwuey+jWtZvv+dMYvYmbqBe4WIqjFy5Vufkl/M=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=bv5S4DzE+YMZBI7nuk6WNOUmGeDhsqBaVUEtj6VrcuaKKREcSPg2KtrIZ074mleR
	 rNxhDCPtkRHZNHspwVxy9pi3K2LJXk6BCC5arnwT/eJVdH6pI762ny4Xj/HFh3v96
	 4G5UOIBsQ3MesxgONl/c4P1wt3FyROhPRZt+cxx7nVwNHEhgR5K3Wly2vTpH0BB5m
	 X5QujZMVeu2TMkade+xapuOkNPOfBITBjiMetG/D2NNJO/doSWdJwl+Oz84JvRM1E
	 nIRigLtK9jgfiudQrgRS6Hm0w/CBZyPTg3TK4WETPs0O3zKC7LKf0aM+f7d/KtN2w
	 4e5MX1wbPtJ93JUFHw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.153] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MfpOd-1rilde0o3N-00gKdy; Thu, 07
 Dec 2023 21:02:07 +0100
Message-ID: <103e1b45-19d9-4438-b70d-892757f695fc@gmx.com>
Date: Fri, 8 Dec 2023 06:32:03 +1030
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] btrfs/282: resolve intermittent failures
Content-Language: en-US
To: David Disseldorp <ddiss@suse.de>
Cc: fstests@vger.kernel.org, Qu Wenruo <wqu@suse.com>
References: <20231207072056.14588-1-ddiss@suse.de>
 <949dd5fe-560f-4986-b653-c84aa9afd778@gmx.com>
 <20231208004902.3df2bed2@echidna>
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
In-Reply-To: <20231208004902.3df2bed2@echidna>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qXgtuhkXSwqC6qTNStA2iSySA1b9Yw07o61zO3hGGwc4qn1zWi/
 TnJHUVWqiGIOyQ98HjPhqfFhOZeqFIDCC7i2ULrinJYcnR6v7sKhqYMZYjymG608uR2GttV
 PhpkPLIADfBNWgBR3xtygDCaV+o6H0UUPp9BTHNyDep22CoSKQtT9om3E7By1t5uxm0eDik
 xGwAt9bzOpEbVTa8tpF1A==
UI-OutboundReport: notjunk:1;M01:P0:6Qt9QABhu7E=;3cczstHtg2j4Uys8BLtbfIA8Ao2
 fF/vRMt6o/BOq0J7SYFho5T+CVFJnuAjX51/Rp0XcxrkwtCgiqYb4OmsEjIc7YwXX8eoDwFp6
 iXFJHLLa35MwxBPZxhb0oP/WCnIg+rqOxffgB6ejX72WQXtZloZ5mNEBtfvzvzUO4Enb/ufXa
 dEfBfgD6rWCBmHwtwUNqxt7Tu543B/FoaWTcIFqYkEqJuf7WIPjIEUqztn8JUfRxdu42vxDOV
 A0+qFva4cxHXi8MU4JhYr50yjbDv554RivUd6pLhTPrTBulttKp1QIukAZtOKAx552fzE6QTp
 crBUJw/5xp1ihmOTaYzN+NsFVr2SAKEqULVwR65eZumk8sUD6AqbvQ1qEbufWpgT/EhxcDLzE
 ixoWOKnifwVmGNohnsgfsAD9g+xMjxFxUgYfamP8u1dpFAG9pu4rhtb2H2qV3xcPuY6B3TnSh
 M4Z7lCcoetKt0MJTHaVQdfrHridrv9n9+gOJr7k6sb+tgzyzBXU3MUQ0CVQsjPWaInPUWUVP9
 bKjzE5gXKLR6RC2aN8vNGaAX6mbApboorJuaIERS/GZMsaeh4XtU8oVlee2JMoRUGNaMscsSx
 TKq9C5FA3PZtAX+tfqHVBNkmAGBJz2TS2lG4j66EYpyir2sCpXjYJCrJa0CHjYTobvAYkd0c5
 KjTg7Je9jLkztVZBDCQ/ZHHIkediLlanH9ymSldZhxukAJ3ciFbu/NhvPR02n5Cq4+wMoRdX7
 BsNqkrGyr5xyN3WvFzg1LS1Lhe/v+hqf5Gq/AxrQTcmf0dZUXBfIPqAlBf9DK1+XR61ibcTzI
 g55rmYHu7a8bAEbZH0T5rQ9NQgLNKs9fZZPSwr8TAE0oDxFLdzmpX95xVorK9NFDHKzMqp41M
 yF0r22uM6xMM0OVWZ9bijeVa6lzqFUXgnkngPjNEMmJgoMKlUMk8krPJZWvNjekoNHpJBkctZ
 rF7bmrBbu/RUjO7nz2xEeuNA4f8=



On 2023/12/8 00:19, David Disseldorp wrote:
> On Thu, 7 Dec 2023 20:19:00 +1030, Qu Wenruo wrote:
>
>> On 2023/12/7 17:50, David Disseldorp wrote:
>>> btrfs/282 fails intermittently under some circumstances. This patchset
>>> adds dmdelay to make storage latencies more uniform and slightly
>>> increases throttled rate tolerances.
>>
>> My concern using dm_delay is, is the delay per-merged-bio or something =
else?
>>
>> If the delay is only per-bio (after merge), then I'm afraid it would no=
t
>> be good enough.
>
> The dmdelay device presents itself as a regular block device, so I think
> delay_map()->delay_bio() handling comes after any merges.
>
>> The bio plug we use in scrub can have much higher chance to result a
>> difference in the scrub speed.
>>
>> We may want a delay behavior which can take bio size into consideration
>> at least.
>
> Should we manipulate it a bit by fiddling with queue/max_sectors_kb and
> queue/nomerges?

I'm not sure if delay is our best friend.

If we have something to limits the read/write speed directly that would
be the best case.

Unfortunately I didn't see a dm-throttle in upstream, can we limit the
IO speed on certain device using cgroup?

Thanks,
Qu
>
> Thanks, David
