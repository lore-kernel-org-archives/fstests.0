Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5AB7E
	for <fstests@vger.kernel.org>; Sun, 14 Jan 2024 15:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 88B65626FAE4
	for <fstests@vger.kernel.org>; Sun, 14 Jan 2024 16:42:42 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id qEOOx28MDG1F for <fstests@vger.kernel.org>;
	Sun, 14 Jan 2024 16:42:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 38A0B6343B28
	for <fstests@vger.kernel.org>; Sun, 14 Jan 2024 16:42:42 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id N_jVaRjA_QH0 for <fstests@vger.kernel.org>;
	Sun, 14 Jan 2024 16:42:42 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 1A027626FAE4
	for <fstests@vger.kernel.org>; Sun, 14 Jan 2024 16:42:42 +0100 (CET)
Date: Sun, 14 Jan 2024 16:42:41 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: fstests@vger.kernel.org
Message-ID: <1998649210.233983.1705246961955.JavaMail.zimbra@nod.at>
Subject: fsgqa group membership?
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Index: jfJhV5qLvRnXFZcWirg6KZ9gK+DRtQ==
Thread-Topic: fsgqa group membership?

Hi!

After migrating to a new test environment, I observed that generic/193 failed.
Initially, I assumed it was a UBIFS regression, but it appears that all other file systems have also been affected.

generic/193       - output mismatch (see /root/xfstests-dev/results//generic/193.out.bad)
    --- tests/generic/193.out   2024-01-14 08:55:20.114082471 +0000
    +++ /root/xfstests-dev/results//generic/193.out.bad 2024-01-14 14:30:51.598725128 +0000
    @@ -45,10 +45,10 @@
     check that suid/sgid bits are cleared after successful truncate...
     with no exec perm
     before: -rwSr-Sr--
    -after:  -rw-r-Sr--
    +after:  -rw-r--r--
     with user exec perm
     before: -rwsr-Sr--
    ...
    (Run 'diff -u /root/xfstests-dev/tests/generic/193.out /root/xfstests-dev/results//generic/193.out.bad'  to see the entire diff)

It turned out that the test failed because the user "fsgqa" did not have the "fsgqa" group assigned.
After rectifying this, the test passed successfully.

But it is nowhere stated that this has to be that way.

README says only:
6. (optional) Create fsgqa test users and groups:

   $ sudo useradd -m fsgqa
   $ sudo useradd 123456-fsgqa
   $ sudo useradd fsgqa2
   $ sudo groupadd fsgqa

Just in case, users fsgqa and fsgqa2 want the groups fsgqa/fsgqa2 as their primary groups
to have all tests work as expected?

Thanks,
//richard
