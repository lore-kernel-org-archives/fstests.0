Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795282562;
	b=UId+F+7jBqyfwqtyn0OtiUKfTLzC/f4E8byjcg7Tl/Sn66lHL0AjbammdfLIQraLdjnO
	 SPKb0XYwA9zbxNhTk2mmLKovbs5s2r6vHNlvLcW1jxv57thjsV3whvDz4ZH0ivx2MrxQx
	 5H6yGmaeccbYZRDX/75zBGRRPP1V/kgdyi7Vf8KKI6w5VHYVnGwGODyABUJNBMTC4ZHuz
	 ZVDwEgwRNk6CJNuoeZ51D3UydMLahWtaqKxAZTgFiJ/7lz7ke63YjcSYZX+9YT48vCO1M
	 t0UE3MnqfQaN4h6/ILW1JqQ6ZjjTqEjNxhWed3z1b7O1KaBbZMudivrOO7KXVIAMGGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795282562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:X-Mailer:
	 References:In-Reply-To;
	bh=iptS2vTGwyef/oQudP4H8mHhv5KvqnJZreLTYNNbBnY=;
	b=vOh8aWEH4yAiNjK0R9OMBSsdUlPOiMboTJrVmZCmN9b3vrTkEXzdcdaRAuUeAnDl1Ny2
	 uTH/Eh0YKVvgvqTa2lte8ScQsS58WWnCOpYJZjtyBgMM/t5glcjSaNMwaqf9aIab8LWOg
	 ZZ6gXJjJQy0OicX3XHsDyuTsNyeJ78uYzVylHJlCnNny3YwBkKjB3khDU/XjESiHS0VIY
	 lEWABRVk1D/pNE2W9Q+tm6gVFg+Z13Qql5gBeKV+NLRekVbm5C6qCcVdOCJRunNVmxrD0
	 +9XddGKj3E00AlWQ+XNXcOj6DzE8aP9pXtAJchKL3kEm9jg6W1HnTB+6u5j+Z9p9wjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bglsq8mj;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E62D606A337
	for <fstests@vger.kernel.org>; Sat, 21 Nov 2026 17:36:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E62D606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Bglsq8mj
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-490c3ae81d3so1217757f8f.2
        for <fstests@vger.kernel.org>; Sat, 21 Nov 2026 09:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795282560; x=1795887360; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iptS2vTGwyef/oQudP4H8mHhv5KvqnJZreLTYNNbBnY=;
        b=Bglsq8mj/iLIkJNeB1VrARoMiRx0+CHf+K0+lzevwI9mES7jRLbVhr28+rtkPEcGIL
         fLoKdw+YC8wiv/YULlDRUi9EgkZZpLVyrTHV81S8L81ieUvx+xF9cWTNq6fPzHyGdAmd
         jh/DL0c4nU2+nuXaPNC1AOGQFFEAp92usr1uSwY51HD5r3vaEE1CtlN6zJLEY8WBsZhg
         oLAasgPkrZI7aQtICHkrPIRAzLPsMLBeNS3xK6TFWrXvk/P0/+tNlZG9nKb3YEd+0nGa
         K3TomKoI86lCxjU6N/biCpNZ0t+8FN4MsfaeC0rz2FHqOvAopNfc//ChaZaZIeVjHOaD
         auog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795282560; x=1795887360;
        h=in-reply-to:references:to:from:subject:message-id:date:content-type
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iptS2vTGwyef/oQudP4H8mHhv5KvqnJZreLTYNNbBnY=;
        b=KrmFGUbdH4uIPrZaSd+Fr22SPofBPlarZ5IbtJWaZZTrV0LbYdoi4WUYxj5K1eOANi
         txbyS0qXbbsrHzYc8C7W6/z65T7TNgSZCt6F/D6SFkI5k8uxzwt00ModybmZAfp3DuFG
         wjgMxSgK/ZfDIG/gVeqL0F2+3qjLCzYHWvHUlZ5BFrFhvX6rOAAcVQdu5G/znnS8PrW7
         9TV+iPl5ERTttmxIS1Pc4kmMrP8zaL65oJZopv+QhxTa8AFt/4NcLsun2Z2LSuWnJDH0
         cxtr0cwkuS6crC8y9XrNnuhXD+NJWNMomrzAJG7OpKxuo38xH59zduJWChqM2IxBEkTX
         e9IQ==
X-Forwarded-Encrypted: i=1; AL+hErEJlLHcNb/7Xf7PIMurrtgbm2fhW6/G6C/6iShQ7X1IH/extcqZZQijhECsUvb/uH6AiaavvAiO@vger.kernel.org
X-Gm-Message-State: APuU4Z98b+St2Q/SIRLbqkMAJFpY3t1e1Mj5tV+JSSkgu9o8afn/VjSd
	OkEyMbi7tGnPdtG4BUp50mHzqnBJyrR2cRmUnzRlS1N1g7yHGzZDUtpJOQeGCI9ofHA=
X-Gm-Gg: AZFdTZfxOi7kwWT6cJz9MkGVb00oO5cRi2VW59DoKHxyEHsrD0gW/YFNmR0eJlXqnzW
	j+2Edn0s/unth4pttkRO5k5F9a/Wx3hwsbckAaixy1PtrZuM/xKqqJp8iBgm2aZ0AxfpBOb1IDp
	yvU+HNsVygfIz/U+E/VI8/3a6QSsH9fnIPFG/yRP6uOIsdvhtNUqWvIH1zVAQi6S6SBg2ns4NzA
	Bs3YzTPllw8DgU5QI1ALbsLjkTTp9O3tttzgqZvxvAVOtciTS/94sl9RVUhdjqVFZkSd8Qy72Kw
	u33ECNXjrwI1aFHuiNJePWQM9xK67N2bwv9zY4hZgPPWW/YDqWZIyGAh4cPSvCeVNWf6+p3nwKh
	cTRi9DNS4QvsS0DJ1K/NgUYjdeuHQ1kuUa9l9XbMX266FR92fdFw2YtDbyA8k7TYOrjPqdFAeEK
	39wOaxjyHqcrfklJZTMdfs6/2/yLzoaNYeV4KtFJGlIZVpPEYycwsX0zWzRyTEpdz/y1d9oYV47
	AKz5YHjd2hN1k8wp3eQCt+d2UNoRSGAEq0hq1wx7hnGc0Kkk8uq425/e9bpe/3nSO1Zv3wHwljK
	zXEQK0zs6jMUW7RIu5SYn+x6lg==
X-Received: by 2002:a05:600c:4f10:b0:4a1:88de:9e8b with SMTP id 5b1f17b1804b1-4bb88807909mr156132435e9.5.1795282560058;
        Sat, 21 Nov 2026 09:36:00 -0800 (PST)
Received: from localhost ([2001:b07:5d26:7a6a:365a:60ff:fe0d:cfc6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884c3063sm197499165e9.15.2026.11.21.09.35.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Nov 2026 09:35:58 -0800 (PST)
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Post: <mailto:fstests@vger.kernel.org>
List-Help: <mailto:fstests+help@vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
List-Owner: <mailto:fstests+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=f0c22b6c6a6b1cbda1de2ca74f3c9da1ab1be69871342b0bc9e65d2304d0;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sat, 21 Nov 2026 18:35:54 +0100
Message-Id: <DN12JVQQ4QUC.DE95899OAGJT@gmail.com>
Subject: Re: [PATCH v2] generic: add test for garbled stat output from
 negative nanoseconds
From: "koraynilay" <koray.fra@gmail.com>
To: "koraynilay" <koray.fra@gmail.com>, <fstests@vger.kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261121162003.234307-1-koray.fra@gmail.com>
 <awHTU6F4imBlRW7p@zlang-mailbox>
In-Reply-To: <awHTU6F4imBlRW7p@zlang-mailbox>

--f0c22b6c6a6b1cbda1de2ca74f3c9da1ab1be69871342b0bc9e65d2304d0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat Nov 21, 2026 at 6:31 PM CET, Zorro Lang wrote:
> On Sat, Nov 21, 2026 at 05:20:03PM +0100, koraynilay wrote:
>> Some filesystems don't use set_normalized_timespec64() to handle their
>> timestamps format conversion, leading to a garbled stat command output
>> for timestamps.
>>=20
>> For example:
>>      from cache:   1960-01-01 01:01:01.123456789 +0000
>>   after remount:   1960-01-01 01:01:02.()*+,--00 +0000
>>=20
>> This bug also violates a struct timespec64 invariant, as documented in
>> the set_normalized_timespec64() kernel-doc:
>> [...]
>>  * Note: The tv_nsec part is always in the range of 0 <=3D tv_nsec <
>>  * NSEC_PER_SEC.
>>  * For negative values only the tv_sec field is negative !
>>  */
>>=20
>> Example patches that fix the problem[1][2].
>>=20
>> Link: https://lore.kernel.org/linux-cifs/20261112111637.184045-1-koray.f=
ra@gmail.com/ [1]
>> Link: https://lore.kernel.org/linux-cifs/20261112111637.184045-2-koray.f=
ra@gmail.com/ [2]
>> Signed-off-by: koraynilay <koray.fra@gmail.com>
>> ---
>> v2 changes:
>> - use _fixed_by_fs_commit for ksmbd and cifs
>> - add _fixed_by_fs_commit for ntfs3
>> - fix cleanup function
>> - remove useless comment
>> - wrap more the other comments so they're easier to read
>>=20
>> Thanks.
>>=20
>>  tests/generic/812     | 48 +++++++++++++++++++++++++++++++++++++++++++
>>  tests/generic/812.out |  3 +++
>>  2 files changed, 51 insertions(+)
>>  create mode 100755 tests/generic/812
>>  create mode 100644 tests/generic/812.out
>>=20
>> diff --git a/tests/generic/812 b/tests/generic/812
>> new file mode 100755
>> index 00000000..eb76f2e5
>> --- /dev/null
>> +++ b/tests/generic/812
>> @@ -0,0 +1,48 @@
>> +#! /bin/bash
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2026 koraynilay.  All Rights Reserved.
>> +#
>> +# FS QA Test No. 812
>> +#
>> +# Based on generic/258, but tests timestamps prior to epoch with sub-se=
cond
>> +# precision.
>> +#
>> +# ksmbd, cifs, ntfs3 and other filesystem drivers violate timespec64
>> +# non-negative nanoseconds constraint, garbling output of stat.
>> +#
>> +. ./common/preamble
>> +_begin_fstest auto quick bigtime
>> +
>> +_fixed_by_fs_commit cifs 6a75ce0866bb \
>> +	"smb: client: fix negative timestamps being read from smb"
>> +_fixed_by_fs_commit cifs f2f961e0983c \
>> +	"ksmbd: fix negative timestamps being saved to disk"
>> +_fixed_by_fs_commit ntfs3 xxxxxxxxxxxx \
>> +	"ntfs3: fix negative timestamps corrupting stat output"
>> +
>> +_require_test
>> +_require_negative_timestamps
>> +
>> +TESTFILE=3D$TEST_DIR/timestamp-test.txt
>> +# we use 123456700 instead of 123456789 because some
>> +# filesystems support only 100ns precision
>> +DATE=3D"1960-01-01 01:01:01.123456700 UTC"
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f "$TESTFILE"
>> +}
>> +
>
> Haha, I probably didn't explain that clearly. I didn't mean changing the =
`rm`
> line in _cleanup. What I meant forcefully running `rm -f $TESTFILE` right
> before touch -d below, so that any existing file doesn't interfere with t=
he
> test, since we don't strictly require TEST_DIR to be completely cleaned
> up after every test case run.

Oh, yeah that makes more sense considering the template and other tests
all keep the rm -f $tmp.* ahah.

> Don't worry about sending a new version, I'll fix it when I merge. Then..=
.
>
> Reviewed-by: Zorro Lang <zlang@kernel.org>
>

Thank you.

Best,
koraynilay

>> +# create a file with a timestamp prior to the
>> +# epoch with nanosecond precision
>> +touch -d "$DATE" "$TESTFILE"
>> +
>> +TZ=3DUTC stat -c "%y" "$TESTFILE"
>> +
>> +# unmount, remount, and check the timestamp
>> +_test_cycle_mount
>> +
>> +TZ=3DUTC stat -c "%y" "$TESTFILE"
>> +
>> +_exit 0
>> diff --git a/tests/generic/812.out b/tests/generic/812.out
>> new file mode 100644
>> index 00000000..f0267fbb
>> --- /dev/null
>> +++ b/tests/generic/812.out
>> @@ -0,0 +1,3 @@
>> +QA output created by 812
>> +1960-01-01 01:01:01.123456700 +0000
>> +1960-01-01 01:01:01.123456700 +0000
>>=20
>> base-commit: 71641219a506ac62bfa231592394265ca812670e
>> --=20
>> 2.56.0
>>=20



--f0c22b6c6a6b1cbda1de2ca74f3c9da1ab1be69871342b0bc9e65d2304d0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSgVimKafU5DQMcjcDmj22qf5IGXAUCawHWegAKCRDmj22qf5IG
XB4aAQDVBc+ZDTCYN/dhnbnk1cv+ou3P6ITOPX5YxN47GD4VXwEAhMli0NGh2BSv
FiGG8sHXB5wg/6qvdr7wAAEsoqdd7A4=
=bw8P
-----END PGP SIGNATURE-----

--f0c22b6c6a6b1cbda1de2ca74f3c9da1ab1be69871342b0bc9e65d2304d0--
