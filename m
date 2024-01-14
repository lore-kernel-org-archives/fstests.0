Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0C21FA3
	for <fstests@vger.kernel.org>; Sun, 14 Jan 2024 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 3BF3B6343B2D
	for <fstests@vger.kernel.org>; Sun, 14 Jan 2024 10:56:23 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id bQLdx9YPhbUs; Sun, 14 Jan 2024 10:56:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D15FE626FAE4;
	Sun, 14 Jan 2024 10:56:22 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id wW870HrKmdPG; Sun, 14 Jan 2024 10:56:22 +0100 (CET)
Received: from blindfold.corp.sigma-star.at (84-115-239-180.cable.dynamic.surfer.at [84.115.239.180])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id 97CA16410404;
	Sun, 14 Jan 2024 10:56:22 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: fstests@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>
Subject: [PATCH] generic/597,598: Require groups
Date: Sun, 14 Jan 2024 10:56:11 +0100
Message-Id: <20240114095611.29401-1-richard@nod.at>
X-Mailer: git-send-email 2.26.2
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Moving to a new test bed is always fun.
Forgot to add group fsgqa2 and tests 597, 598 failed.

generic/597       - output mismatch (see /root/xfstests-dev/results//gene=
ric/597.out.bad)
    --- tests/generic/597.out   2024-01-14 08:55:20.176084268 +0000
    +++ /root/xfstests-dev/results//generic/597.out.bad 2024-01-14 09:41:=
15.548729962 +0000
    @@ -2,13 +2,17 @@
     =3D=3D Test symlink follow protection when
     =3D=3D process !=3D link owner and dir owner !=3D link owner
     fs.protected_symlinks =3D 0
    +chown: invalid group: 'fsgqa2:fsgqa2'
     successfully followed symlink
     fs.protected_symlinks =3D 1
    +chown: invalid group: 'fsgqa2:fsgqa2'

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 tests/generic/597 | 2 ++
 tests/generic/598 | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/generic/597 b/tests/generic/597
index ff985ca61915..a3035489aea3 100755
--- a/tests/generic/597
+++ b/tests/generic/597
@@ -32,8 +32,10 @@ _require_test
 _require_sysctl_variable fs.protected_symlinks
 _require_sysctl_variable fs.protected_hardlinks
 _require_user fsgqa2
+_require_group fsgqa2
 # Do this SECOND so that qa_user is fsgqa, and _user_do uses that accoun=
t
 _require_user fsgqa
+_require_group fsgqa
 _require_symlinks
=20
 OWNER=3Dfsgqa2
diff --git a/tests/generic/598 b/tests/generic/598
index 769c1b1a1ad9..31b7fde48868 100755
--- a/tests/generic/598
+++ b/tests/generic/598
@@ -32,8 +32,10 @@ _require_test
 _require_sysctl_variable fs.protected_regular
 _require_sysctl_variable fs.protected_fifos
 _require_user fsgqa2
+_require_group fsgqa2
 # Do this SECOND so that qa_user is fsgqa, and _user_do uses that accoun=
t
 _require_user fsgqa
+_require_group fsgqa
 _require_chmod
=20
 USER1=3Dfsgqa2
--=20
2.26.2

