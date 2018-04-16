Received: from u164.east.ru ([195.170.63.164]:17070 "EHLO u164.east.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750996AbeDPOOW (ORCPT <rfc822;fstests@vger.kernel.org>);
        Mon, 16 Apr 2018 10:14:22 -0400
Date: Mon, 16 Apr 2018 17:04:30 +0300
From: Anatoly Pugachev <matorola@gmail.com>
Subject: [PATCH] README requirements for debian sid to enable build of
 src/dbtest.c
Message-ID: <20180416140430.af246b2midlzetty@yogzotot>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hello!

Please apply the following trivial patch to enable building of src/dbtest.c on
debian sid. Without installing mentioned below devel package, xfstests could
not be built, complaining:

xfstests-dev$ make
Building include
Building lib
Building ltp
Building src
    [CC]    dbtest
dbtest.c:28:5: error: expected '=', ',', ';', 'asm' or '__attribute__' before '!' token
 bozo!
     ^
dbtest.c:41:3: warning: data definition has no type or storage class
 } myDB;
   ^~~~
dbtest.c:41:3: warning: type defaults to 'int' in declaration of 'myDB' [-Wimplicit-int]

Thanks.

Signed-off-by: Anatoly Pugachev <matorola@gmail.com>
---
 README | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/README b/README
index 50c68afa..8b7849bc 100644
--- a/README
+++ b/README
@@ -7,8 +7,8 @@ _______________________
   For example, for Ubuntu:
        sudo apt-get install xfslibs-dev uuid-dev libtool-bin \
        e2fsprogs automake gcc libuuid1 quota attr libattr1-dev make \
-       libacl1-dev libaio-dev xfsprogs libgdbm-dev gawk fio dbench \
-       uuid-runtime python sqlite3
+       libacl1-dev libaio-dev xfsprogs libgdbm-dev libgdbm-compat-dev \
+       gawk fio dbench uuid-runtime python sqlite3
   For Fedora, RHEL, or CentOS:
        yum install acl attr automake bc dbench dump e2fsprogs fio \
        gawk gcc indent libtool lvm2 make psmisc quota sed \
