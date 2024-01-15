Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750151B27A
	for <fstests@vger.kernel.org>; Mon, 15 Jan 2024 21:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 825836410409;
	Mon, 15 Jan 2024 22:28:34 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id 0K160SRqZH0k; Mon, 15 Jan 2024 22:28:34 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 33902641040E;
	Mon, 15 Jan 2024 22:28:34 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id cWMPojxjPUY9; Mon, 15 Jan 2024 22:28:34 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 13ED96410409;
	Mon, 15 Jan 2024 22:28:34 +0100 (CET)
Date: Mon, 15 Jan 2024 22:28:33 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: tytso <tytso@mit.edu>
Cc: fstests <fstests@vger.kernel.org>
Message-ID: <877564802.238094.1705354113891.JavaMail.zimbra@nod.at>
In-Reply-To: <20240115025706.GF911245@mit.edu>
References: <1998649210.233983.1705246961955.JavaMail.zimbra@nod.at> <20240115025706.GF911245@mit.edu>
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
Thread-Index: lwxQTm5swz743VHiYmfzrskeKIFpiw==

Ted,

----- Urspr=C3=BCngliche Mail -----
> Von: "tytso" <tytso@mit.edu>
> The useradd program creates the /etc/passwd entry as well as the
> /etc/group entry.  Demonstration:
>=20
> % kvm-xfstests shell
>    ...
> root@kvm-xfstests:~# grep foobarbaz /etc/passwd
> root@kvm-xfstests:~# grep foobarbaz /etc/group
> root@kvm-xfstests:~# useradd foobarbaz
> root@kvm-xfstests:~# grep foobarbaz /etc/passwd
> foobarbaz:x:31418:31418::/home/foobarbaz:/bin/sh
> root@kvm-xfstests:~# grep foobarbaz /etc/group
> foobarbaz:x:31418:

Only on systems with USERGROUPS_ENAB enabled in /etc/login.defs.

I happen to be on SUSE Linux which has traditionally no user groups.
...just sent a patch for generic/193 to detect this scenario.

Thanks,
//richard
