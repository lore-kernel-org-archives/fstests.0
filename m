Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76AAD215075
	for <fstests@vger.kernel.org>; Fri, 21 Aug 2026 06:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787293027; cv=none; b=IHpHfvKlnh3vQ9cIGwCFutDXNK2nWsgNgAkXFJaFugreH3w/DRRZuE81w5Uu8ijFYYKedMXxWs0lmqRZsm/D/NtfpvZf5hQJpDITtNFhl3pTyLkaHxb9geBaMwEoo7I9rQqFT90s1TZ+oLKQhh5e24Xbq8kE2xM4FB6CgqJFJfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787293027; c=relaxed/simple;
	bh=eDJq9zf5s8o3Sr3VrJYODtziGv9K6nM4y4XB6B+Ulks=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m1fDaMjt/UUjdYy6X5aeUeq+ElW5wx+PYdzmUh20uiQU5SSbc6p947+WRyqkOJN2GdwISyTeuhaHgN1JPB9aLhuOfemipG7HvLqpLjBebDd3SdAzdLCNp8wcnVEomlJcJw6c+7Z5jpNq8SJ5fkpQFN32B3HpLHazf9x2I0j6Wxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=Rfz+d372; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="Rfz+d372"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1787293022; x=1787897822; i=quwenruo.btrfs@gmx.com;
	bh=/lzuYLPwqAasp+2zY/DK3j1GnmEN5plVhLi7ZZ4kWiE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Rfz+d372LXutHqgUFCNB6B3HXodp7yR1YNMtn0aVFkdlkXcIvyMTFBd17vZ8esZ7
	 E6bff49rvGN6ZXCQyfTaUNob5bGdH8jIQa392iw9tsM7pqd1E+ph1y0uww7leZRUR
	 7Nc+TCU6MRplGJMxs6214U6ZXnLPS/It1qV1ocmTIpmmNCAucJc+EG005Ozku4Yx+
	 GlP3ORboUXdvkngzXhAxIZvyNdvWyvZ9HJqbmbUDh7s+qDP5xpSpVWVPsAvm8bcpQ
	 qdeJY3Mj9KhXlYHFFyN87H+rwap+vujohVOkwHYi8g/AFWo7V3eqy5KnodbJh8n9G
	 z2oXji/tOMqXgAE9mg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1MEV3I-1xC7jo0x5O-0064YH; Fri, 21
 Aug 2026 08:17:02 +0200
Message-ID: <19e975ec-16ac-4df3-a315-a1f3392571ae@gmx.com>
Date: Fri, 21 Aug 2026 15:46:59 +0930
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] generic/800: TEST_DIR, not TEST_MNT
To: "Darrick J. Wong" <djwong@kernel.org>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
Cc: wqu@suse.com
References: <20260819152726.GA6060@frogsfrogsfrogs>
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
In-Reply-To: <20260819152726.GA6060@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jWBrOiMuYPkyc0LDw7iZpU832o44/Z0YE5GkvW6XxUcDoIf8sQ6
 5h1o3rjRUHB3ybqvzmxHbhVNMmVBzYNc7LyiTeFezlhUO/SOE4LWr4v4CAWaVthLE3fN4Eu
 Dg+t4PIVVYjEPODC3R29VsU8LXVY1vjcWBS1iY6p5Yu7asNh+wigGP9H0zcDVO+B+e84Tm5
 0uJ58lL4X5ighOH+LTPHQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Ix5c0oOLK/c=;4i3W9P4b+eTCTq/kso22cEbR6Fm
 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



=E5=9C=A8 2026/8/20 00:57, Darrick J. Wong =E5=86=99=E9=81=93:
> From: Darrick J. Wong <djwong@kernel.org>
>=20
> Fix this new test regression:
>=20
>   --- /run/fstests/bin/tests/generic/800.out	2026-08-18 09:30:13.6555130=
87 -0700
>   +++ /run/fstests/logs/generic/800.out.bad	2026-08-18 16:30:24.10711021=
5 -0700
>   @@ -1,2 +1,4 @@
>    QA output created by 800
>   +/dio-read-source: Read-only file system
>   +dio read failed
>    Silence is golden
>=20
> Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>

Facepalm...

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/generic/800 |    6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/tests/generic/800 b/tests/generic/800
> index 52a664a17e448b..b79c1a0c052876 100755
> --- a/tests/generic/800
> +++ b/tests/generic/800
> @@ -32,8 +32,8 @@ _cleanup()
>   _scratch_mkfs >> $seqres.full
>   _scratch_mount
>  =20
> -# Create the 4MiB target file on TEST_MNT as the read source.
> -$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 4M" "$TEST_MNT/dio-read-so=
urce" >> $seqres.full
> +# Create the 4MiB target file on TEST_DIR as the read source.
> +$XFS_IO_PROG -f -c "pwrite -i /dev/urandom 0 4M" "$TEST_DIR/dio-read-so=
urce" >> $seqres.full
>  =20
>   # Another 4MiB target file on SCRATCH_MNT as the mmap dest
>   $XFS_IO_PROG -f -c "pwrite 0 4M" "$SCRATCH_MNT/mmap-dest" >> $seqres.f=
ull
> @@ -42,7 +42,7 @@ read_workload()
>   {
>   	_register_cleanup "wait"
>   	while true; do
> -		$here/src/dio-read-into-mmap "$TEST_MNT/dio-read-source" \
> +		$here/src/dio-read-into-mmap "$TEST_DIR/dio-read-source" \
>   			"$SCRATCH_MNT/mmap-dest" &> /dev/null
>   		if [ $? -ne 0 ]; then
>   			echo "dio read failed"
>=20

