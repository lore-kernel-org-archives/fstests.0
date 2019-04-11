Received: from szxga07-in.huawei.com ([45.249.212.35]:35666 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727242AbfDKJbK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 11 Apr 2019 05:31:10 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DA2A988EA6D76E0BB900
        for <fstests@vger.kernel.org>; Thu, 11 Apr 2019 17:31:08 +0800 (CST)
From: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
Subject: [PATCH] generic/478: should wait until dup success or fail
Date: Thu, 11 Apr 2019 17:35:21 +0800
Message-ID: <1554975321-121948-1-git-send-email-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: guaneryu@gmail.com, fstests@vger.kernel.org, zhangxiaoxu5@huawei.com
List-ID: <fstests@vger.kernel.org>

When test on nfs, maybe failed as below:
  wait sem0 0: Resource temporarily unavailable
  set sem0 0: Invalid argument
  exit rmid: Invalid argument

It means getlk routine wait sem0 timeout, because the setlk routine
maybe take too long time on =E2=80=98fcntl=E2=80=99 or 'dup'.

So, let wait on sem0 in getlk routine until the setlk routine success
or fail.

Signed-off-by: ZhangXiaoxu <zhangxiaoxu5@huawei.com>
---
 src/t_ofd_locks.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/t_ofd_locks.c b/src/t_ofd_locks.c
index e3b15dd..32e90c0 100644
--- a/src/t_ofd_locks.c
+++ b/src/t_ofd_locks.c
@@ -414,9 +414,7 @@ int main(int argc, char **argv)
 		sop.sem_num =3D 0;
 		sop.sem_op =3D 0;
 		sop.sem_flg =3D 0;
-		ts.tv_sec =3D 5;
-		ts.tv_nsec =3D 0;
-		if (semtimedop(semid, &sop, 1, &ts) =3D=3D -1)
+		if (semtimedop(semid, &sop, 1, NULL) =3D=3D -1)
 			err_exit("wait sem0 0", errno);
=20
 		if (fcntl(fd, getlk_macro, &flk) < 0)
--=20
2.7.4
