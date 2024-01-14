Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204F61097D
	for <fstests@vger.kernel.org>; Sun, 14 Jan 2024 20:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id BFC416410419;
	Sun, 14 Jan 2024 21:48:54 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id L89zgk94eEQw; Sun, 14 Jan 2024 21:48:54 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 57FEC626FB01;
	Sun, 14 Jan 2024 21:48:54 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id v4uP9DuaRdvQ; Sun, 14 Jan 2024 21:48:54 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 326286410419;
	Sun, 14 Jan 2024 21:48:54 +0100 (CET)
Date: Sun, 14 Jan 2024 21:48:53 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Zorro Lang <zlang@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
Message-ID: <1829752362.234840.1705265333986.JavaMail.zimbra@nod.at>
In-Reply-To: <20240114201831.jhaww3xzbfqervc5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: <1998649210.233983.1705246961955.JavaMail.zimbra@nod.at> <20240114201831.jhaww3xzbfqervc5@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Subject: Re: fsgqa group membership?
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: fsgqa group membership?
Thread-Index: 6HKEGPm+vyw8ImDfjX/V/Gr4s4J2Jw==

Zorro,

----- Urspr=C3=BCngliche Mail -----
>> It turned out that the test failed because the user "fsgqa" did not have=
 the
>> "fsgqa" group assigned.
>> After rectifying this, the test passed successfully.
>=20
> OK, so you've found out why it's failed :)

Yeah, but took me more time than it should. ;-)
=20
>>=20
>> But it is nowhere stated that this has to be that way.
>>=20
>> README says only:
>> 6. (optional) Create fsgqa test users and groups:
>>=20
>>    $ sudo useradd -m fsgqa
>>    $ sudo useradd 123456-fsgqa
>>    $ sudo useradd fsgqa2
>>    $ sudo groupadd fsgqa
>>=20
>> Just in case, users fsgqa and fsgqa2 want the groups fsgqa/fsgqa2 as the=
ir
>> primary groups
>> to have all tests work as expected?
>=20
> Actually above steps aren't exact enough. It depends on a default behavio=
r
> of useradd command -- "By default, a group will also be created for the
> new user" (from `man useradd`)
>=20
> And according to the manual:
>=20
>       -g, --gid GROUP
>           The name or the number of the user's primary group. The group n=
ame must exist. A
>           group number must refer to an already existing group.
>=20
>           If not specified, the behavior of useradd will depend on the US=
ERGROUPS_ENAB
>           variable in /etc/login.defs. If this variable is set to yes (or=
 -U/--user-group
>           is specified on
>           the command line), a group will be created for the user, with t=
he same name as
>           her loginname. If the variable is set to no (or -N/--no-user-gr=
oup is specified
>           on the command
>           line), useradd will set the primary group of the new user to th=
e value specified
>           by the GROUP variable in /etc/default/useradd, or 1000 by defau=
lt.
>=20
> You said "After migrating to a new test environment", I don't know what's
> your new test env. Maybe your USERGROUPS_ENAB isn't set to yes by default=
,
> or your useradd has an alias "useradd -N", or any other reasons.

SUSE Linux has traditionally not set USERGROUPS_ENAB, this explains the iss=
ue.
The old setup was not SUSE based.

> Anyway if you hope to make sure each fsgqa users is assigned to their
> own group, how about:
>=20
> $ groupadd fsgqa
> $ useradd -m -g fsgqa fsgqa
> $ groupadd fsgqa2
> $ useradd -g fsgqa2 fsgqa2
> $ groupadd 123456-fsgqa
> $ useradd -g 123456-fsgqa 123456-fsgqa

Sounds good! It is verbose but that way everybody will know and it will wor=
k
on "strange" systems too.

Thanks,
//richard
