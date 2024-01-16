Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C52512B78
	for <fstests@vger.kernel.org>; Tue, 16 Jan 2024 09:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 14311626FB01;
	Tue, 16 Jan 2024 10:19:37 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id C8U7Ba8G-ZIG; Tue, 16 Jan 2024 10:19:36 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id A01BF626FB0A;
	Tue, 16 Jan 2024 10:19:36 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Kb-5WTDNXttQ; Tue, 16 Jan 2024 10:19:36 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 7B8EB626FB01;
	Tue, 16 Jan 2024 10:19:36 +0100 (CET)
Date: Tue, 16 Jan 2024 10:19:36 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: Dave Chinner <david@fromorbit.com>
Cc: fstests <fstests@vger.kernel.org>
Message-ID: <376534882.240308.1705396776298.JavaMail.zimbra@nod.at>
In-Reply-To: <ZaXB6wYpoqjeGHKg@dread.disaster.area>
References: <20240115212402.21888-1-richard@nod.at> <ZaXB6wYpoqjeGHKg@dread.disaster.area>
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
Thread-Index: VdBp79U9lNmsd4+X4ve3QbjOJAMsQg==

Dave,

----- Urspr=C3=BCngliche Mail -----
> Von: "Dave Chinner" <david@fromorbit.com>
> Just do this check in _require_user(). The user needs to be set up
> correctly for all tests - if the user and group is not set up
> correctly, don't run any of the tests that require that user.
>=20
> This means we don't have to play whack-a-mole with "user has no
> group" every time someone assumes that a user is created with a
> group by default.

I think _require_user_exists() fits better, because _require_user()
tests whether the user can run commands via su.

Are we all happy with something like that?
diff --git a/common/rc b/common/rc
index a9e0ba7e..f1eabf3c 100644
--- a/common/rc
+++ b/common/rc
@@ -2461,13 +2461,16 @@ _cat_group()
        cat /etc/group
 }
=20
-# check if a user exists in the system
+# check if a user exists in the system and has a user group
 #
 _require_user_exists()
 {
        local user=3D$1
        _cat_passwd | grep -q "^$user:"
        [ "$?" =3D=3D "0" ] || _notrun "$user user not defined."
+
+       id -n -G $user | grep -w -q $user
+       [ "$?" =3D=3D "0" ] || _notrun "$user not in group $user."
 }
=20
 # check if a user exists and is able to execute commands.

Thanks,
//richard
