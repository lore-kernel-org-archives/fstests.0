Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4A2159589
	for <fstests@vger.kernel.org>; Tue, 16 Jan 2024 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.201.40.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705435243; cv=none; b=BnSeNXyQ746zSWJqmWoV5yjErGLSXmbvetCr+RJ6zfIpuSy62fxPjQ1lscnD4Az9gJnOJnOFHOjPiZKTeODwV/Fp84s7+jwna1STQdwSX8SSXJ/b1fNKxa/vnyJEd9et6U5igG9ia3jDB4mF2wnlvWJftGwuRnJO4i9N3CTkZTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705435243; c=relaxed/simple;
	bh=rv6pVYFus65dwTi0VBS7BF4JGdgFRjyJZsSeMFNlka4=;
	h=Received:Received:Received:Received:Received:Date:From:To:Cc:
	 Message-ID:In-Reply-To:References:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Originating-IP:X-Mailer:
	 Thread-Topic:Thread-Index; b=Rir2XgfCtJVBIxEx+P0QgvjASeYFrtpwumt4HbbIhgMy5y3a0EuWHQaStMAivLGZJBL+hwGagTDRjd7KduQXyfBEdk2hg1sMCe7EeWm2Y7bLsZfjcQABLbt3K4yDa98wWoCuNa5+QFOR/L8tD+rd/e0xSO3S7w0NTmCAXBhClS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at; spf=fail smtp.mailfrom=nod.at; arc=none smtp.client-ip=195.201.40.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1E8BE64507CC;
	Tue, 16 Jan 2024 21:00:38 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id iOym_mpAKn9H; Tue, 16 Jan 2024 21:00:37 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A98B464507CF;
	Tue, 16 Jan 2024 21:00:37 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id qcsTeMmPCkqj; Tue, 16 Jan 2024 21:00:37 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 89FBA64507CC;
	Tue, 16 Jan 2024 21:00:37 +0100 (CET)
Date: Tue, 16 Jan 2024 21:00:37 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Zorro Lang <zlang@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, fstests <fstests@vger.kernel.org>
Message-ID: <1532659619.242214.1705435237434.JavaMail.zimbra@nod.at>
In-Reply-To: <20240116171055.on2qz2zi3bijdgyi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <20240115212402.21888-1-richard@nod.at> <ZaXB6wYpoqjeGHKg@dread.disaster.area> <376534882.240308.1705396776298.JavaMail.zimbra@nod.at> <20240116171055.on2qz2zi3bijdgyi@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Subject: Re: [PATCH] generic/193: Ensure user in expected group
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: generic/193: Ensure user in expected group
Thread-Index: j6Gv5PbKpwv2hQmer/1u+8J+pQ1qNQ==

----- Urspr=C3=BCngliche Mail -----
> Von: "Zorro Lang" <zlang@redhat.com>
> An: "richard" <richard@nod.at>
> CC: "Dave Chinner" <david@fromorbit.com>, "fstests" <fstests@vger.kernel.=
org>
> Gesendet: Dienstag, 16. Januar 2024 18:10:55
> Betreff: Re: [PATCH] generic/193: Ensure user in expected group

> On Tue, Jan 16, 2024 at 10:19:36AM +0100, Richard Weinberger wrote:
>> Dave,
>>=20
>> ----- Urspr=C3=BCngliche Mail -----
>> > Von: "Dave Chinner" <david@fromorbit.com>
>> > Just do this check in _require_user(). The user needs to be set up
>> > correctly for all tests - if the user and group is not set up
>> > correctly, don't run any of the tests that require that user.
>> >=20
>> > This means we don't have to play whack-a-mole with "user has no
>> > group" every time someone assumes that a user is created with a
>> > group by default.
>=20
> I think Dave is right. Due to not only the g/193, lots of cases base
> on "fsgqa* user is in fsgqa* group". If you hope to check that by
> the single function _require_user_in_group(), it might need to call
> it in most of cases which use _require_user.
>=20
> But yes, as you said, it's weird to do it in _require_user, that makes
> the _require_group calling is a bit redundant.
>=20
> If I have to choose one way, I think we can keep the _require_user_in_gro=
up
> as an independent function, but call it in _require_user, e.g.
>=20
> _require_user()
> {
>        qa_user=3Dfsgqa
>        if [ -n "$1" ];then
>                qa_user=3D$1
>        fi
>        _require_user_exists $qa_user
> +=09# fstests needs each test user is in its own group name, it only need
> +=09# a user exist, please use _require_user_exists directly.
> +=09_require_user_in_group $qa_user $qa_user
>        echo /bin/true | su $qa_user
>        [ "$?" =3D=3D "0" ] || _notrun "$qa_user cannot execute commands."
> }
>=20
> What do both of you think?

Fine by me. :-)

Thanks,
//richard
