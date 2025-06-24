Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABDE23FE7
	for <fstests@vger.kernel.org>; Tue, 24 Jun 2025 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750729157; cv=none; b=sxpAx1tZkWIj/W3G6IykA+tPzu8S3RoFwbR8A4KzAQO5kqap3bq/WnEL6GKnScthvWQL+NJN9sCrxEwHKpbHtiGdqlQINKxh06pdrj2hYruVlQY0WsYHlGuIsVUJidFAmBJTvwPOl5oP8lIeuGYPpkD9iwsXPtBAi+BsMG6f5eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750729157; c=relaxed/simple;
	bh=bOzpy65BOZh3D67d6CY6iBPHUQjT/pCSkk9+ic74Tcc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Dszci4imvuG7Koq4Yw9MaiHjm6/I9gi9g4Yl/Y4d0K/AxaUesyMN9Jdrr/vur+zIH4uuTQiNCvLB1zZ7Hl5mqKNYYgYgBBD7k54wItutO0nBJmnvlWADB2X0UMVVqKS547lSsvlY2AGZxN2oGo/x7MeoLFCHzIJ84YwfucWMUUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=eSjhJDjT; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="eSjhJDjT"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a575a988f9so2364067f8f.0
        for <fstests@vger.kernel.org>; Mon, 23 Jun 2025 18:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1750729154; x=1751333954; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQWtGoCA4F9Cme0HwKmpNkAbwOyi18VR+a9Tpa9HcUA=;
        b=eSjhJDjTGBbtfzBt34ysMC+pDnG0G5+aYprnwoEKvL8rG/k4anWQ9pTanpm/Xpiwhh
         ZnjRPEXLDysq9RwpxozsfDNQKZ8axLX8pmapI75hjznpi5xiROuUFUf0W4BKCYt7NSSg
         BiJ4WFNYPVinLEGQYjpBLiLu498aVB7hYiLLvqzD/LCdlSC8aWp7OuRIHv8zMSzvhEyF
         RnY3Xn8VBMbWvDgam3v7b9aDxlR6eTUXxSjnVS8Q14Q+Y1NK7n2tNd1dMZiSt0DMI4Aq
         shTPex81biUy8Z0J4Htj7FvVxDpy3wyfMWyXkW5ihQy8bkReE6zBJ4RsBGnFPwSZdkgw
         pxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750729154; x=1751333954;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQWtGoCA4F9Cme0HwKmpNkAbwOyi18VR+a9Tpa9HcUA=;
        b=wvHD7GpdGMJaDT8YZsj3x2Oo6nHal3FQDy06Fk5igQsiPnVn8rpPVCWDO2pvAmcS0J
         j59knGNtLhA3qtrnVBhaED7iA1Oqm7hz1m37dLjtUAvZ6VAAORJ26nY42aSFqk7AOiZS
         gDSipSmnJZGjWoeC7Kr62DuBgcUi6pTnpiozOM2Q6Y2BvcbD2etM31n6yaa+Ies7Jk5C
         bb2EsUM6AAINOUhDjmCKUe3nKDjI4QWQIxDIoBPyFZ8RikZ2y6RmQGkz5oQ9nlAqnbyz
         6qWCTLizgjKTgqsiAkfru/wyWsG+Mu2g6hlStw9MD6806yxyQ33amvUaWvpFGxkeBpww
         Oq3g==
X-Gm-Message-State: AOJu0YzSd/iHAT5Ye2wy5KbqsGTSymyfd4AgoXGUOFYwReBiBIs+bIje
	SdRS+S1F7oMuL4funwUqGnlK+nxQmAqdKpO8HHErZA6LAs/8YqxPCuSNbn8IPOrDMo16a1+fBQz
	ZfuqSeFmstw==
X-Gm-Gg: ASbGncsHXy/I/TCpKuWTSlcOIrmMkRZIWz6fHYZlhZXd1INNvW69N/5+3wvZ/tNWaKW
	eYRZYrGnKxUdWjP0HN0PzhVqc4a+kYP3EX1ChbL/U6niFmk/Tvzx4cFcbK2A3pbZZEVZXJwGptS
	Euc03i5ael4gFE59AGQ6Inc01XSGYdiIL9EUHrpq8IioPONiX37voQPyJKvzv+5sUW7jGs/nma0
	gTs9OLwPXRFvtNpdHS6Vg1cag7ea+msVF+5WdXoYc+DF1mspx5hNkDfW4JnXFowJrndrCE18XGH
	TUKjcoaavBmqmj903JCiyO5QicMd9eJaJSIBWYE2FNQoGA4QnQq9FaxuUOlHa7bXq02c7S+Uk4V
	BP5DR7w==
X-Google-Smtp-Source: AGHT+IHeE8iiYRLuE/2O29proc0r8PlcXTKwdvUBim7baWNWIht9aBMqwa5S5l08ltCnuYfMowPmOg==
X-Received: by 2002:a05:6000:1aca:b0:3a5:2465:c0c8 with SMTP id ffacd0b85a97d-3a6d119291fmr11852450f8f.7.1750729153930;
        Mon, 23 Jun 2025 18:39:13 -0700 (PDT)
Received: from smtpclient.apple ([137.184.246.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237f7579cddsm37854095ad.202.2025.06.23.18.39.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jun 2025 18:39:13 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH] common/quota: adjust _qmount_option for gfs2
From: Glass Su <glass.su@suse.com>
In-Reply-To: <20250620173839.q735lweoglone5cp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Date: Tue, 24 Jun 2025 09:38:59 +0800
Cc: fstests@vger.kernel.org,
 Su Yue <l@damenly.org>,
 gfs2@lists.linux.dev
Content-Transfer-Encoding: quoted-printable
Message-Id: <089C8762-DDC0-45F6-8769-FD52A75CA626@suse.com>
References: <20250603041009.59811-1-glass.su@suse.com>
 <20250620173839.q735lweoglone5cp@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
To: Zorro Lang <zlang@redhat.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)



> On Jun 21, 2025, at 01:38, Zorro Lang <zlang@redhat.com> wrote:
>=20
> On Tue, Jun 03, 2025 at 12:10:09PM +0800, Su Yue wrote:
>> gfs2 supports mount options 'quota=3D[off/account/quiet/on]' but
>> 'usrquota' and 'grpquota' are unsupported.
>> So in _qmount_option, transform $OPTS to 'quota=3Don' first.
>>=20
>> Signed-off-by: Su Yue <glass.su@suse.com>
>> ---
>> common/quota | 7 +++++++
>> 1 file changed, 7 insertions(+)
>>=20
>> diff --git a/common/quota b/common/quota
>> index a51386b1dd24..4b8052e07dde 100644
>> --- a/common/quota
>> +++ b/common/quota
>> @@ -283,6 +283,12 @@ _qmount_option()
>> {
>> OPTS=3D$1
>>=20
>> + if [[ "$FSTYP" =3D=3D gfs2 ]]; then
>> + OPTS=3D`echo $OPTS \
>> + | sed   -e 's/usrquota/quota=3Don/g' \
>> + -e 's/grpquota/quota=3Don/g'`
>> + fi
>=20
> There's not response from gfs list. I'm not familiar with gfs2, so I =
have to
> ask some questions about your patch...

Feel free to communicate : )
>=20
> =46rom the manual of gfs2:
>  quota=3D[off/account/on]
>  Turns quotas on or off for a filesystem. Setting the quotas to be in =
the "account" state causes the per UID/GID usage statistics to be =
correctly maintained by the filesystem, limit and warn values are =
ignored. The default value is "off".
>=20
> Looks like there's only one mount option "quota=3D..." for gfs2. And I =
didn't
> find a description about project quota, so
> 1. What will gfs2 do if there's a "prjquota" or "pquota"?

The mount will fail if prjquota/pquota is in mount options.
_require_prjquota() should be modified.

> 2. Do you need to replace "noquota" with "quota=3Doff"?

Yes.. I forgot the case.

> 3. And "quota" to "quota=3Don" ?

The only case "_qmount_option =E2=80=98quota=E2=80=99=E2=80=9D is =
tests/xfs/820, not in generic group.

> 4. Have you tried your patch on gfs2, can all quota related generic =
cases pass/notrun
>   on gfs2?
>=20

TBH, not all quota tests run well on gfs2
There was a bug which can cause kernel hang in gfs2 fixed by kernel =
commit 5a90f8d49922 ("gfs2: Don't start unnecessary transactions during =
log flush=E2=80=9D)
In v6.16-rc1.

> BTW, in this function you can see:
>        # ext4 doesn't _do_ "-o pquota/prjquota" because reasons
>        # Switch it to "quota" to enable mkfs-time pquota

The comment is confusing to me. ext[234] support =E2=80=98-o prjquota=E2=80=
=99 if  MKFS_OPTIONS=3D"-O quota -E =
quotatype=3Dusrquota:grpquota:prjquota=E2=80=9D.

>        if [[ "$FSTYP" =3D=3D ext[234] ]]; then
>                OPTS=3D`echo $OPTS \
>                | sed   -e 's/\bpquota/quota/g' \
>                        -e 's/prjquota/quota/g'`
>        # ocfs2 doesn't support "-o projquota"
>        elif [[ "$FSTYP" =3D=3D ocfs2 ]]; then
>                OPTS=3D`echo $OPTS | sed -e 's/prjquota//g'`
>        fi
>=20
> please move your gfs2 specific codes here ^^, and give it enough =
comments.

There is one question from me about the _qmount_option() and _qmount()

Not all tests of qgroup use _qmount, some of them call _scratch_mount() =
directly.
Is this intentional to avoid influenced by other mount options? If =
It=E2=80=99s not IMO it=E2=80=99s feasible
to convert them to _qmount?

>=20
>> +
>> # Replace any user defined quota options
>> # with the quota option that we want.
>> # Simplest to do this rather than delete existing ones first because
>> @@ -300,6 +306,7 @@ _qmount_option()
>> -e 's/\bpquota/QUOTA/g'    \
>> -e 's/prjquota/QUOTA/g'    \
>> -e 's/noquota/QUOTA/g'     \
>> + -e 's/quota=3D[^, ]*/QUOTA/g' \
>=20
> I think you might need a word boundary, e.g. "\bquota=3D..."

Right.
=E2=80=94=20
Su
>=20
> Thanks,
> Zorro
>=20
>> -e 's/quota/QUOTA/g'       \
>> -e 's/uqnoenforce/QUOTA/g' \
>> -e 's/gqnoenforce/QUOTA/g' \
>> --=20
>> 2.48.1


