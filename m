Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B584E392C32
	for <fstests@vger.kernel.org>; Fri, 24 Jul 2026 22:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930830; cv=none; b=lCCd3XNPLhwvE++rjjmfnOK/NB5Y5sEuFZoXwRw9fi5GqvTiNaZ2LDaakFyCCojsYtEojvhiH0c/KoYl8lnzraB0FzIy7HZaHLvO/sgwpWyh0VV4criDTj1U3rCvSNSdZU+2GLpuQ6FX2sLMdpmwtV3oxEQBi1t2ab1xXQK7Wi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930830; c=relaxed/simple;
	bh=+tgWUmE/aG5prFIkzaZog1uw4h2WHmIP4nYxDchqoWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nwRvJBikAb/Zkl80OVpDWSPXZrHczwyc+lNwlcYcQP7B0WBZdN5bj3ynakrJeG/V1eT7xe4qs7PMsUbzarKPaFIzFKMf8XM+kYHObhd57SCJ7OHB+0Q7Ehck2Z5nUfI9n9bTVqnqVFero6lX6kPdwe40zanrhmV/bupFhi6QTxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=PTpHaunA; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="PTpHaunA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1784930818; x=1785535618; i=quwenruo.btrfs@gmx.com;
	bh=npswX9u4HewnFZZbF/dHfwohEEdIMfmATF8giOH8fC8=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=PTpHaunAgHsBsroi2izJ1eb7hlNZrAx2botIDS8ISBHHLXy9BEKLAb9Ncn82Q1lv
	 UENfpuJB1gIT9/gJ6aaed+FGeP04dG4PTcnZIuMSi1JcXKgclJ0piuD30THLp/B+f
	 jIKiS/M+abIZiX2uDim5NRdUs6WgtQLau9zMWM77DPvFpClbrrMMX6+qzTFFUgxE8
	 mavnK4E4NvQeSf6uCVSrL2a2qMxTiMGESC8egkCZ+FxnvYZFIABEiUpCUK86+FR0+
	 YZXSz3E+ZHbTOqXaobbBnp6KEhGj3STZpK16qyUoo1RseUZq4ueqPjvH+xRdaxHmi
	 qmOMFHOQZwE6b9xvbw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MKsj7-1wYl4e2yQX-00OY54; Sat, 25
 Jul 2026 00:06:58 +0200
Message-ID: <1abbec27-e719-4671-98ae-6ec877106927@gmx.com>
Date: Sat, 25 Jul 2026 07:36:54 +0930
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic/761: add to the rw group
To: Christoph Hellwig <hch@lst.de>, zlang@kernel.org
Cc: wqu@suse.com, fstests@vger.kernel.org
References: <20260724125106.433118-1-hch@lst.de>
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
In-Reply-To: <20260724125106.433118-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fg+LOmheOPVlBV3k4TzRvvS5csjX8Mo9IuWDh8FEhEBkHPJtbgt
 fiLz83IEQ3lfNGcueXbQHJ+vOrpyndTdsEx3FUklN91Zpjr4eXrT6NL3AmHMpZgBVCc9J7y
 JWM658vUASnUsiNOdm0CVl++6gpAjrzUetG/hSuM6m4b3vo34dTxN2ikvBCJUGS7A/TZyY6
 GekM8jB6ypBgI9Bv33t+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+Qg1gQlERUg=;Zchl9uc4rWYb0Nqzd0Lp6a+Z4Vu
 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
 1XEqsbzH56sGLz8wlCZ7GVh4aN61dE



=E5=9C=A8 2026/7/24 22:21, Christoph Hellwig =E5=86=99=E9=81=93:
> This tests the read-write path, so add it to the proper group.
>=20
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/generic/761 | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/tests/generic/761 b/tests/generic/761
> index e9030f3c6ab3..d9e095f7a4fc 100755
> --- a/tests/generic/761
> +++ b/tests/generic/761
> @@ -13,7 +13,7 @@
>   #
>  =20
>   . ./common/preamble
> -_begin_fstest auto quick
> +_begin_fstest auto quick rw
>  =20
>   _require_scratch
>   _require_odirect

