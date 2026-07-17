Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1343ECBE2
	for <fstests@vger.kernel.org>; Fri, 17 Jul 2026 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784310127; cv=none; b=MVqD5N0+3nTDEyK41UN0Z6Mx/zS441hNsuyOIsbJQ3/U5h95nka+LwKjzbwzDhNXr0bHqGqtOd9amRl6xy8jvQlFis8KprrbvrzRvO12juOgacSYp+8A3c4Rp36mopHrmVIYDXWwuCuW3dIPrdu4+6czK0pfrAMU07UJNt36Qjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784310127; c=relaxed/simple;
	bh=oMrwtSf9eKG+7xjH/rMiFDrqqDARE42txGOQToUldcM=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=COZ2o3CmCHWz9e/oiLex87l3Lc1GDkZgZqFIS3tmECAiEEzbKhy5zPa7dXNaRJp6t7o9LBket1bdHQggS54sIxpCFnPHGyYlHI1YRg3Pf6yLP4hO9v+dK+VaivDjooYjCwkE1PDNP8IarnSnNb7c5TdfS01Tyq5ovz9yLUfELUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b=i/mnUm5N; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20251104.gappssmtp.com header.i=@dubeyko-com.20251104.gappssmtp.com header.b="i/mnUm5N"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8143daf89c7so45593037b3.1
        for <fstests@vger.kernel.org>; Fri, 17 Jul 2026 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20251104.gappssmtp.com; s=20251104; t=1784310125; x=1784914925; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DsDZ3compjXmhO5+c1QTd2UypQS/yxjW35a+0/CPDPo=;
        b=i/mnUm5NtI+e1KqjcZ7FCuqmhMYFXmEXfDYHGq4EBcQnAJgG2Q41lzYmia0rB4EgMx
         arp85IEqlp6a7IabvBD8iIlv1Pt1C5VFSw8H5jYR/IXTxP+w4wEnOpBgkNqe2W8jrPnB
         DY/aZpJ5R8flALnxeGuRuLvxckwH5oBZqwlt79/sBQ9wA78WsgDzcWVrmdlk+gVuKXaf
         O1xtvSYIJRz/oxPgy3OY5tB0nwNaEabRpysOA3U2DaqdPHIong+Q1+xWzWtxO+j5uBFr
         DaTd5blcHuJ1KBupRXmrHUKaAMwtH2FI2C40qMaVeiTpIFFGQSK/wb9waKPSRWv5TDSj
         fMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784310125; x=1784914925;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DsDZ3compjXmhO5+c1QTd2UypQS/yxjW35a+0/CPDPo=;
        b=CxS0h57Ad5nbovno3/cI8/8VbnCx+UR4+WDa1FGkh/8Jxr3LVjVGX0kB0v9rbUDXiJ
         m26JSrCZPhV/2kBpYZLvEPqBnFEJSUl2rC1kNoj7KzuOGNbSr1ehs9gd9hfFWm1LctWP
         jVLcig1TfX5Nw4wTpSeMphyF/CWFcNzPW5C3sbM4jsfuHghH6yifBs9UDtkyG4hs5L1p
         QVngtcm/Pov9vuod24vslA5ga+CFlBkcT8MUBl2GM/MrwFWZWLRgTbk6bFID0Agwszsj
         zcmT4VMBIcQ6HK2Y7xoLe55OmsbMqbNeQeTeF/TmHGI1BDG1t4aE6zez38eMlPjdjZIP
         yEGg==
X-Forwarded-Encrypted: i=1; AHgh+RoFlHJh8AJcu/mHKSKD0dGdve0hIPQ678LfRycq2hBxXTSdbTCJ9BkFa7mY2XL8UvoopCB5tm5k@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+FTTs9hrnT7xT0WnGwYn0ouB8EXYQclxfcs5nV+Rqf1bPlrKz
	0ERXAyL27IrQIibo/2wnK3bevkZy90durNTXi7UtAvE8lno8r5Mht8aT8F320wWDl48=
X-Gm-Gg: AfdE7cnpWAv7v2wZbS/140VYHNJ/0A6iq4b+itxJHtfxyqbYKPn+aieuGZj8KLXm4RF
	C/JESHqJYyj4rKSoUdfwrIJma5SZ+IOyjuphfRn5ralV3wFp/BUrnb7YgXh96MzzSPyge1M+/za
	L61Nat/Q8qnUPBhAKcKwXqIJ1gfKu2D982E6K5tPWgN5yF9xJcsG4JKCF6RHotdNWEwJdZC9PUp
	q3sQT0c1yc7oJGWJeUPpn4kIMxoatxZaSHh0M43xvfEVA0PQtuVi6CFqGsPfeeXOvI9oJ02VeCv
	ASmYWbpbyCuwYDPmtDPf0+JqrBxF1nHieDC+nd73HZYIffp1kbN7flQ8EhInuShPz8uU71fJnRl
	yKTTT7dJvQQ81Gkqnh+a0BAMELjE0LlTA2BB+HP68dPX2BoFCfFvaTttM+KRjRouTpdY4xBWE3Z
	BPDVpP4uTPLozdwDFp27QTJABGGExHYtVX+tZAscn9/pFdOjzPyss16HAULZ5HYrfuE2o3+NN5M
	1FJQydgAtOOOMhapTYEnlx16H1yEKEiKNOTgl5mAwyE+CjZ1HATSPE7nyc4gkWs3aNcdUQc61GI
	vQu8Y2rUcbi/U7p6
X-Received: by 2002:a05:690c:600c:b0:80c:ebd4:762 with SMTP id 00721157ae682-81ef22c9739mr14077437b3.7.1784310125096;
        Fri, 17 Jul 2026 10:42:05 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:9b0a:7ecd:9294:edb1? ([2600:1700:6476:1430:9b0a:7ecd:9294:edb1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef40534dcsm15860427b3.16.2026.07.17.10.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 10:42:04 -0700 (PDT)
Message-ID: <6352480175f4737a4d37e2a4e0bc43e0b6f8225a.camel@dubeyko.com>
Subject: Re: Should we consider disable generic/563 for file systems that do
 not support cgroup2?
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, "fstests@vger.kernel.org"
	 <fstests@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	 <linux-fsdevel@vger.kernel.org>
Date: Fri, 17 Jul 2026 10:42:03 -0700
In-Reply-To: <alpUADtQccA2zmWh@zlang-mailbox>
References: <ff1c0710cbb31f8ebf51457c0629a496ea6f658e.camel@ibm.com>
	 <alpUADtQccA2zmWh@zlang-mailbox>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-07-18 at 00:19 +0800, Zorro Lang wrote:
> On Fri, Jul 10, 2026 at 07:10:43PM +0000, Viacheslav Dubeyko wrote:
> > Hello,
> >=20
> > As far as I can see, the generic/563 test is dedicated to cgroup v2
> > functionality. And several file systems fails to execute the test:
> >=20
> > sudo ./check generic/563
> > FSTYP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- hfsplus
> > PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/x86_64 hfsplus-testing-=
0001 7.2.0-rc1+ #55
> > SMP
> > PREEMPT_DYNAMIC Fri Jul 10 11:21:38 PDT 2026
> > MKFS_OPTIONS=C2=A0 -- /dev/loop51
> > MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
> >=20
> > generic/563=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - output mismatch=
 (see xfstests-
> > dev/results//generic/563.out.bad)
> > =C2=A0=C2=A0=C2=A0 --- tests/generic/563.out	2026-04-07 14:19:04.785079=
940 -
> > 0700
> > =C2=A0=C2=A0=C2=A0 +++ xfstests-dev/results//generic/563.out.bad	2026-0=
7-10
> > 11:33:14.231562955 -0700
> > =C2=A0=C2=A0=C2=A0 @@ -4,11 +4,13 @@
> > =C2=A0=C2=A0=C2=A0=C2=A0 write is in range
> > =C2=A0=C2=A0=C2=A0=C2=A0 write -> read/write
> > =C2=A0=C2=A0=C2=A0=C2=A0 read is in range
> > =C2=A0=C2=A0=C2=A0 -write is in range
> > =C2=A0=C2=A0=C2=A0 +write has value of 0
> > =C2=A0=C2=A0=C2=A0 +write is NOT in range 15938355.2 .. 17616076.8
> > =C2=A0=C2=A0=C2=A0=C2=A0 read is in range
> > =C2=A0=C2=A0=C2=A0 ...
> > =C2=A0=C2=A0=C2=A0 (Run 'diff -u xfstests-dev/tests/generic/563.out xfs=
tests-
> > dev/results//generic/563.out.bad'=C2=A0 to see the entire diff)
> > Ran: generic/563
> > Failures: generic/563
> > Failed 1 of 1 tests
> >=20
> > sudo ./check generic/563
> > FSTYP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- vfat
> > PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/x86_64 hfsplus-testing-=
0001 7.2.0-rc1+ #55
> > SMP
> > PREEMPT_DYNAMIC Fri Jul 10 11:21:38 PDT 2026
> > MKFS_OPTIONS=C2=A0 -- /dev/loop51
> > MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
> >=20
> > generic/563=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - output mismatch=
 (see xfstests-
> > dev/results//generic/563.out.bad)
> > =C2=A0=C2=A0=C2=A0 --- tests/generic/563.out	2026-04-07 14:19:04.785079=
940 -
> > 0700
> > =C2=A0=C2=A0=C2=A0 +++ xfstests-dev/results//generic/563.out.bad	2026-0=
7-10
> > 11:36:02.221320239 -0700
> > =C2=A0=C2=A0=C2=A0 @@ -1,14 +1,19 @@
> > =C2=A0=C2=A0=C2=A0=C2=A0 QA output created by 563
> > =C2=A0=C2=A0=C2=A0=C2=A0 read/write
> > =C2=A0=C2=A0=C2=A0 -read is in range
> > =C2=A0=C2=A0=C2=A0 +read has value of 22014464
> > =C2=A0=C2=A0=C2=A0 +read is NOT in range 15938355.2 .. 17616076.8
> > =C2=A0=C2=A0=C2=A0=C2=A0 write is in range
> > =C2=A0=C2=A0=C2=A0=C2=A0 write -> read/write
> > =C2=A0=C2=A0=C2=A0 ...
> > =C2=A0=C2=A0=C2=A0 (Run 'diff -u xfstests-dev/tests/generic/563.out xfs=
tests-
> > dev/results//generic/563.out.bad'=C2=A0 to see the entire diff)
> > Ran: generic/563
> > Failures: generic/563
> > Failed 1 of 1 tests
> >=20
> > sudo ./check generic/563
> > FSTYP=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- nilfs2
> > PLATFORM=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -- Linux/x86_64 hfsplus-testing-=
0001 7.2.0-rc1+ #55
> > SMP
> > PREEMPT_DYNAMIC Fri Jul 10 11:21:38 PDT 2026
> > MKFS_OPTIONS=C2=A0 -- /dev/loop51
> > MOUNT_OPTIONS -- /dev/loop51 /mnt/scratch
> >=20
> > generic/563=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - output mismatch=
 (see xfstests-
> > dev/results//generic/563.out.bad)
> > =C2=A0=C2=A0=C2=A0 --- tests/generic/563.out	2026-04-07 14:19:04.785079=
940 -
> > 0700
> > =C2=A0=C2=A0=C2=A0 +++ xfstests-dev/results//generic/563.out.bad	2026-0=
7-10
> > 11:37:57.633280743 -0700
> > =C2=A0=C2=A0=C2=A0 @@ -1,14 +1,18 @@
> > =C2=A0=C2=A0=C2=A0=C2=A0 QA output created by 563
> > =C2=A0=C2=A0=C2=A0=C2=A0 read/write
> > =C2=A0=C2=A0=C2=A0=C2=A0 read is in range
> > =C2=A0=C2=A0=C2=A0 -write is in range
> > =C2=A0=C2=A0=C2=A0 +write has value of 0
> > =C2=A0=C2=A0=C2=A0 +write is NOT in range 15938355.2 .. 17616076.8
> > =C2=A0=C2=A0=C2=A0=C2=A0 write -> read/write
> > =C2=A0=C2=A0=C2=A0 ...
> > =C2=A0=C2=A0=C2=A0 (Run 'diff -u xfstests-dev/tests/generic/563.out xfs=
tests-
> > dev/results//generic/563.out.bad'=C2=A0 to see the entire diff)
> > Ran: generic/563
> > Failures: generic/563
> > Failed 1 of 1 tests
> >=20
> > Should file system (like HFS/HFS+, for example) implement cgroup2
> > support to
> > pass the=C2=A0 generic/563 successfully? Is it generic enough test-case=
?
> > Should we
> > consider disable generic/563 for file systems that do not support
> > cgroup2?
>=20
> Hi Viacheslav,
>=20
> I completely understand your frustration. The "generic" test suite in
> fstests
> isn't a universal requirement document, so I can't really answer
> whether HFS+
> should support cgroup2 or not..
>=20
> File systems that are not supported by fstests good enough,
> frequently run into
> false failures. When facing a test that is "destined" to fail on a
> specific
> $FSTYP, you have below options (maybe more):
>=20
> 1. You can add this specific test (e.g., generic/563) to your daily
> local test
> =C2=A0=C2=A0 exclusion list, refer to the -e or -E options with the ./che=
ck
> script.
>=20
> 2. You can modify the test case to explicitly skip a specific $FSTYP
> using the
> =C2=A0=C2=A0 _exclude_fs helper, along with a short comment explaining wh=
y.
>=20
> 3. You can use or implement a _require_ function to check if a
> specific feature
> =C2=A0=C2=A0 is supported, which will gracefully _notrun the test if it's
> missing. While
> =C2=A0=C2=A0 _require_cgroup2() already exists, its granularity is curren=
tly
> too coarse to
> =C2=A0=C2=A0 _notrun for HFS. You might want to consider refining it or
> introducing a new
> =C2=A0=C2=A0 helper to help file systems like HFS+ _notrun properly.
>=20
> I hope my reply help to clear something for you, please let me know
> if you have
> any further questions.
>=20
>=20

Hi Zorro,

Thanks for this explanation. I decided to take a deeper look into the
HFS+ related issue to better understand the root case. When I'll have
clear understanding what is going on in generic/563, then I'll be able
to select the proper solution. Currently, I haven't really good
understanding of the root case of issue for HFS+ case. Let me spend
more time on this. :)

Thanks,
Slava.
