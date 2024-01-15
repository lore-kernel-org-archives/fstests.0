Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DDC1B272
	for <fstests@vger.kernel.org>; Mon, 15 Jan 2024 21:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nod.at
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nod.at
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 938EF626FB0A
	for <fstests@vger.kernel.org>; Mon, 15 Jan 2024 22:24:15 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id EZYu5965xm4v; Mon, 15 Jan 2024 22:24:14 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id D73F0626FB01;
	Mon, 15 Jan 2024 22:24:14 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Y6-eeA_qmBCB; Mon, 15 Jan 2024 22:24:14 +0100 (CET)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
	by lithops.sigma-star.at (Postfix) with ESMTPSA id ABB7D626FAF9;
	Mon, 15 Jan 2024 22:24:14 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
To: fstests@vger.kernel.org
Cc: Richard Weinberger <richard@nod.at>
Subject: [PATCH] generic/193: Ensure user in expected group
Date: Mon, 15 Jan 2024 22:24:02 +0100
Message-Id: <20240115212402.21888-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: fstests@vger.kernel.org
List-Id: <fstests.vger.kernel.org>
List-Subscribe: <mailto:fstests+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:fstests+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The test assumes that the $qa_user is member of the group
$qa_user. While this is automatically the case on systems
with USERGROUPS_ENAB set in /etc/login.defs, not all
enable this option. Most notably SUSE Linux.

So make sure this case is noticed and reported instead of
failing the test and let the test guy puzzle.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 common/rc         | 11 +++++++++++
 tests/generic/193 |  1 +
 2 files changed, 12 insertions(+)

diff --git a/common/rc b/common/rc
index a9e0ba7e..5c6671a3 100644
--- a/common/rc
+++ b/common/rc
@@ -2484,6 +2484,17 @@ _require_user()
 	[ "$?" =3D=3D "0" ] || _notrun "$qa_user cannot execute commands."
 }
=20
+# check if a user is member of a specifc group
+#
+_require_user_in_group()
+{
+	local user=3D"$1"
+	local group=3D"$2"
+
+	id -n -G $user | grep -w -q $group
+	[ "$?" =3D=3D "0" ] || _notrun "$user not in group $group."
+}
+
 # check for a chown support
 #
 _require_chown()
diff --git a/tests/generic/193 b/tests/generic/193
index e2710b07..d543f321 100755
--- a/tests/generic/193
+++ b/tests/generic/193
@@ -51,6 +51,7 @@ _supported_fs generic
=20
 _require_test
 _require_user
+_require_user_in_group ${qa_user} ${qa_user}
 _require_chown
=20
 test_root=3D$TEST_DIR/$seq.$$.root
--=20
2.35.3

