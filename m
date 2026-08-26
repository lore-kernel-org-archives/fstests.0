Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3A6407CEF
	for <fstests@vger.kernel.org>; Wed, 26 Aug 2026 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787782407; cv=none; b=YykxkehK9mCS6FNpqziDTBLV1i3VbPBB/xNuWHvfVX1vfNMJCXTpT1lda3G23Vsc1/YtPqySlEH0IK53d73pCehJaViGUdpmacdGRkxYUCDLL7vgl8HFRkBC5JU8PWRZHGAZb9oDdR0LixwJXZtlB+HiCjFHRVdpwbyVxsdgvjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787782407; c=relaxed/simple;
	bh=GZpMiO/3ItDjbupSdAO8xbj9oef8V0Tqg4358XiTjTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ae4AQLuK3IwEQd57HgmadGdpYc1B2rNQZYcmA0xj9vS5IMRLVNRENqUgApRYQ57y7TfswLpTc4aE+QNIZ9wIKhEvusAjTchgXURYIlq8/uueBaVOQXzrpnSghv/WvApZS3qDjU5gUSEF/7IVzCTQ/I79Gc5U6VLItCXhVazHfH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=OiC1DYtq; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="OiC1DYtq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1787782403; x=1788387203; i=quwenruo.btrfs@gmx.com;
	bh=6EJ1meyaoAbI5aHBfyRweEnnVwuJTJpkEjUp+eQYnnE=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=OiC1DYtq6dW9FPdZaoE+MZ5w/sE2JKbVOJSkx1RPojkNk7YaP3Btx5HeZeokxO24
	 yi0Q2moHuKtvLhvpfFUj6Eq56ztGbOwGOPfUwAd8ynZx4BYb/dRMHepjffaCBDBpv
	 Ot8u0FMxRhFLxuwaoR2dmOwa0fhGtzf5VCHeIiYopuIt5VzoPeAMGTwUS7WIkd5mY
	 yoSnxyCODdBh42qtb6Le67D6JLyA3UMJYwYZzCzQF+JE/YR0HYGBMheu6vWqedx70
	 Hw2AMMKr7K7ol8eGwP3vDbZ25veQyEGhr87AA6IO3bVMbxCfFhuu29HXR6bcpCaSt
	 ZvkBeeRFM/0RDjOLJg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MG9g4-1x9Eqc1rpM-002dQD; Thu, 27
 Aug 2026 00:13:22 +0200
Message-ID: <c67ab7c6-2d94-457c-aa85-aeba6f1c2c60@gmx.com>
Date: Thu, 27 Aug 2026 07:43:19 +0930
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] generic/798: chain xfs_io commands into a single
 invocation
To: Avinesh Kumar <avinesh.kumar@suse.com>, djwong@kernel.org,
 fstests@vger.kernel.org
Cc: wqu@suse.com
References: <20260826152014.GT839663@frogsfrogsfrogs>
 <20260826155423.183785-1-avinesh.kumar@suse.com>
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
In-Reply-To: <20260826155423.183785-1-avinesh.kumar@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Zi8v1e5dSZkYhgYg1ddcnpYmuwCBKZHSbFExEYz3pNOBlR5kgn
 xi2e947krqDnHmt6Ncin7qohzYbQP15CLMF2U0MMCb6iO8yGS1ODWrJws7CCWkxrW6ad8rG
 rukKqhZlsFbWYCC+g5DMPkOAyjE6VvE2r34g0ktGwuoJoGd58NrkCz45x1VqMwAvU8LJmfY
 lXvqiE65TBV0asB7jVb0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:blEXvQXV2j8=;Xm+YtsLGmBnFq42c3vY4Cyankzf
 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



=E5=9C=A8 2026/8/27 01:24, Avinesh Kumar =E5=86=99=E9=81=93:
> From: Avinesh Kumar <avinesh.kumar@suse.com>
>=20
> The write, cachestat, fsync, and cachestat calls were each run as
> separate xfs_io invocations, closing and reopening the file in
> between. Some filesystems flush dirty data back on close(), clearing
> the dirty bit before the first cachestat ever ran, causing test failure
>=20
> - output mismatch (see /opt/xfstests/results//generic/798.out.bad)
>      --- tests/generic/798.out	2026-08-20 05:25:39.000000000 -0400
>      +++ /opt/xfstests/results//generic/798.out.bad	2026-08-21 12:30:39.=
831381108 -0400
>      @@ -1,16 +1,16 @@
>       QA output created by 798
>       =3D=3D=3D Test with 1 pages =3D=3D=3D
>      -Cached: 1, Dirty: 1, Writeback: 0, Evicted: 0, Recently Evicted: 0
>      +Cached: 1, Dirty: 0, Writeback: 0, Evicted: 0, Recently Evicted: 0
>       Cached: 1, Dirty: 0, Writeback: 0, Evicted: 0, Recently Evicted: 0
>       =3D=3D=3D Test with 2 pages =3D=3D=3D
>      -Cached: 2, Dirty: 2, Writeback: 0, Evicted: 0, Recently Evicted: 0
>      ...
>=20
> Run the whole sequence on one open file descriptor instead by chaining
> all xfs_io commands in single invocation.
>=20
> Suggested-by: "Darrick J. Wong" <djwong@kernel.org>
> Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>

Reviewed-by: Qu Wenruo <wqu@suse.com>

Thanks,
Qu

> ---
>   tests/generic/798 | 19 ++++++++++++++-----
>   1 file changed, 14 insertions(+), 5 deletions(-)
>=20
> diff --git a/tests/generic/798 b/tests/generic/798
> index 0fe37646..5c81b429 100755
> --- a/tests/generic/798
> +++ b/tests/generic/798
> @@ -27,12 +27,21 @@ for num_page in 1 2 4 8 16; do
>   	echo "=3D=3D=3D Test with $num_page pages =3D=3D=3D"
>  =20
>   	rm -f $SCRATCH_MNT/foobar
> -	$XFS_IO_PROG -f -c "pwrite -b $pagesize 0 $size" $SCRATCH_MNT/foobar >=
 /dev/null
> -	# Basic cached number reporting
> -	$XFS_IO_PROG -c "cachestat 0 $size" $SCRATCH_MNT/foobar
>  =20
> -	# Test dirty page number reporting after a fsync.
> -	$XFS_IO_PROG -c "fsync" -c "cachestat 0 $size" $SCRATCH_MNT/foobar
> +	# Basic cached number reporting and test dirty page number
> +	# reporting after a fsync.
> +	#
> +	# Do the whole write+cachestat+fsync+cachestat sequence in a
> +	# single xfs_io invocation. Some filesystems (e.g. NFS) flush
> +	# dirty data back to the server as part of their own close()-time
> +	# cache consistency, which would clear the dirty bits before the
> +	# second xfs_io process ever got to run cachestat.
> +	$XFS_IO_PROG -f \
> +		-c "pwrite -q -b $pagesize 0 $size" \
> +		-c "cachestat 0 $size" \
> +		-c "fsync" \
> +		-c "cachestat 0 $size" \
> +		$SCRATCH_MNT/foobar
>   done
>  =20
>   _scratch_unmount

