Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0546D16DED2
	for <fstests@vger.kernel.org>; Tue,  7 Jan 2025 02:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736217803; cv=none; b=QvT/nXdQbrZ38QhfmLwR8CdmlMLT6zU42wDqolYnP6/ZqsKNKleJhfTwcaUm/jM85oP4IJJwyrnz6Ax3lRZV2eAUV6ilJ30hMwZZX3OZkxQZblQr6I/Y5pJAgnZudRQcWnfp+yukBQSaFLAhV8k/Pgr96X1utjrFF3rMWAvnAiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736217803; c=relaxed/simple;
	bh=atmxslussPqEoNewRStGfOlgpH0gRaohZK+PVuWNTbw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SAp6CIXMf7UILJIUS4PduPMv8Rekh3yv23FMnjt2jsXOCHNTE9sdeGncD/6K/jPBGwC5BjOIamSzSbJlvzMih02UUOF5+RURjb9WaPEpSFFiFu1cvHBJZiuSNjsyNTynUEMyXcd3qglj0Rhm2RTFHxf/Cx0FDsbGfAvg/Px/Bik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JXIESpB4; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JXIESpB4"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaeef97ff02so1865093666b.1
        for <fstests@vger.kernel.org>; Mon, 06 Jan 2025 18:43:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1736217798; x=1736822598; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXUcL3nStPzDQg53+DjpcZtNPpb29NiMyPlb3M2zrrg=;
        b=JXIESpB40Oho/g1tVGNwi9ktgaQXTjadnia/B8JTobrfjSUH7ycSlsdpGFN9ZpldYS
         IicNj6MVUzl2SabQ8FwVMbUg6qtClFMSn0ZHJYZALyNog3UtgjJ6akTOGyNKnwQqF3vs
         h3GB8l++IqbTtaK6WAsAk1xrz/XJKNDQLi6cSHe/5BakAvhWIOKXt2sdTv9oTqcVDTMU
         6NGudwelRVKI//cymPzdUO5fMJzZGZ9l4ll1NK0x/QcmF31/1pRGMGHKnPaOZxLr+l91
         frCMQAUDyYkmeluxISedQT0PeOIv7b+On8VqirF08Hia22wJV9GEsY08/Cgm/CLWEF27
         I24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736217798; x=1736822598;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pXUcL3nStPzDQg53+DjpcZtNPpb29NiMyPlb3M2zrrg=;
        b=YkOLkvCkLsyDJfIHqrqlXHcngnwlsmMFTPdBWJb7ywfnzmpNFwttmnK+/6WSSr6aKN
         iPG98Rbs0WdOD2be7yy+qFOlzhSI0JWnlNjBBCgpsfLDKjuUnOU5Zf+U+slk3ZkGAMLK
         B3KRZFI6+WDUu/dMYiV3Ww+C65cOmTvrfqBd1BDJXxYljQTXGwMCrXYhPEqiE2wO1wgB
         J6cazbAptb32euaubnafuLrYRS6EVE8khTvvG0ONlAYZuOxtqhH671PPOhuniem3MDwa
         h4qBrFkioTo/K/NjteSxwXbRqP/ttPqkHm8KRezwVl02YBZ6pljZEFWF50eR2e6SiVY/
         Btig==
X-Gm-Message-State: AOJu0YyZDnMd9h+lVgOKLrnqNxUCkAs0LRUboxmjCQnW1RSTs2gJqabw
	aKPoAJOwD25D67BoayGpjuj5zqMMh52AO7XN+rd985Fq1X0eIUpygWkRp08e+oKjIZ5QFBs5hFO
	8nCQ=
X-Gm-Gg: ASbGncvVvwpR70VYXK4RfL5RMo5+ZiByJ8n4ZSfaqM1RkpS6QOSIi3NUh+Ll9jznN8F
	2eZQ52gkYHjTjR7ByFiVxeW8hB4EoRBCx/nRApm2KFk79Oq3IODcnxQiAH9eOhoC72sJhqIGGdK
	7RrHsOrepZE5V0PzuyddI6yImKinsLfop7UD7uoAG3+lPlakOVwaEXaGXi90A6RbYRsJBSNAszY
	RULtPmkWmyuOWqe6SWRXE48P1gkWh5zPxkifDt97/6bXY0TE/vuWPunTnA=
X-Google-Smtp-Source: AGHT+IEsoJUsEaVLjDHC0PLwVOEL4shT4+vkrMouh+CENrtPO+h1kPxYzrZf4uW53TI3pchKVLPBZA==
X-Received: by 2002:a17:907:6d19:b0:aa6:8a1b:8b7c with SMTP id a640c23a62f3a-aac2d44727fmr5685406266b.2.1736217798266;
        Mon, 06 Jan 2025 18:43:18 -0800 (PST)
Received: from smtpclient.apple ([23.247.139.15])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cde0dsm299334125ad.140.2025.01.06.18.43.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2025 18:43:17 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.200.121\))
Subject: Re: [PATCH] generic/620: add '-J block64' mkfs option for ocfs2
From: Glass Su <glass.su@suse.com>
In-Reply-To: <20250107021254.GP6160@frogsfrogsfrogs>
Date: Tue, 7 Jan 2025 10:42:58 +0800
Cc: fstests@vger.kernel.org,
 ocfs2-devel@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <6B45499F-7306-478A-A860-73E02D47FCF3@suse.com>
References: <20250106140104.91880-1-glass.su@suse.com>
 <20250107021254.GP6160@frogsfrogsfrogs>
To: "Darrick J. Wong" <djwong@kernel.org>,
 Joseph Qi <joseph.qi@linux.alibaba.com>,
 Mark Fasheh <mark@fasheh.com>
X-Mailer: Apple Mail (2.3826.200.121)



> On Jan 7, 2025, at 10:12, Darrick J. Wong <djwong@kernel.org> wrote:
>=20
> On Mon, Jan 06, 2025 at 10:01:04PM +0800, Su Yue wrote:
>> mkfs.ocfs2 is using 32bit journal as default.
>> For 16T size device support, '-J block64' should be used.
>>=20
>> Signed-off-by: Su Yue <glass.su@suse.com>
>> ---
>> tests/generic/620 | 3 +++
>> 1 file changed, 3 insertions(+)
>>=20
>> diff --git a/tests/generic/620 b/tests/generic/620
>> index 3f1ce45a55fd..60e5a2cacdda 100755
>> --- a/tests/generic/620
>> +++ b/tests/generic/620
>> @@ -41,6 +41,9 @@ sectors=3D$((2*1024*1024*1024*17))
>> chunk_size=3D128
>>=20
>> _dmhugedisk_init $sectors $chunk_size
>> +
>> +[ "$FSTYP" =3D "ocfs2"  ] && MKFS_OPTIONS=3D"$MKFS_OPTIONS -J =
block64"
>=20
> Won't mkfs.ocfs2 turn on block64 on a > 16T volume without prompting?
>=20
It won=E2=80=99t. Only error will be printed:

ERROR: jbd can only store block numbers in 32 bits. =
/dev/mapper/huge-test.620 can hold 4563402752 blocks
which overflows this limit. If you have a new enough Ocfs2 with JBD2 =
support, you can try formatting with the "-Jblock64" option to turn on =
support for this size block device.

It=E2=80=99s 2025 now. Maybe it=E2=80=99s time to make mkfs.ocfs2  turn =
on block64 if device size > 16T.

Maintainers may know some stories.  Joseph?

=E2=80=94=20
Su

> --D
>=20
>> +
>> _mkfs_dev $DMHUGEDISK_DEV
>> _mount $DMHUGEDISK_DEV $SCRATCH_MNT || _fail "mount failed for =
$DMHUGEDISK_DEV $SCRATCH_MNT"
>> testfile=3D$SCRATCH_MNT/testfile-$seq
>> --=20
>> 2.47.1


