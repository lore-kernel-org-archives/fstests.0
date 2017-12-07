Received: from mga05.intel.com ([192.55.52.43]:19927 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750828AbdLGVfK (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 7 Dec 2017 16:35:10 -0500
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [PATCH 3/3] xfstests: fix Wlog_Error_String overflow issues
Date: Thu,  7 Dec 2017 14:35:03 -0700
Message-Id: <20171207213503.31070-3-ross.zwisler@linux.intel.com>
In-Reply-To: <20171207213503.31070-1-ross.zwisler@linux.intel.com>
References: <20171207213503.31070-1-ross.zwisler@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
List-ID: <fstests@vger.kernel.org>

The 'Wlog_Error_String' string is defined to be 256 bytes in length, but =
in
two places we write into it with a format that contains a string
(wfile->w_file) that has length 1024.  This can overflow Wlog_Error_Strin=
g,
as we see in the new compiler warnings from gcc 7.2.1:

 write_log.c:124:37: warning: =E2=80=98%s=E2=80=99 directive writing up t=
o 1023 bytes into
 a region of size 224 [-Wformat-overflow=3D]
 "Could not open write_log - open(%s, %#o, %#o) failed:  %s\n",
  ^~

Fix this by increasing the length of Wlog_Error_String to 1280 characters
(1024 for wfile->w_file plus 256 for the rest of the format string), and =
by
using snprintf() instead of sprintf() so we are sure we don't overflow.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 lib/write_log.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/lib/write_log.c b/lib/write_log.c
index 8c921fc5..3bfa8c7b 100644
--- a/lib/write_log.c
+++ b/lib/write_log.c
@@ -73,7 +73,8 @@
 /*#define PATH_MAX pathconf("/", _PC_PATH_MAX)*/
 #endif
=20
-char	Wlog_Error_String[256];
+#define ERROR_STRING_LEN 1280
+char	Wlog_Error_String[ERROR_STRING_LEN];
=20
 #if __STDC__
 static int	wlog_rec_pack(struct wlog_rec *wrec, char *buf, int flag);
@@ -120,7 +121,7 @@ int			mode;
 	umask(omask);
=20
 	if (wfile->w_afd =3D=3D -1) {
-		sprintf(Wlog_Error_String,
+		snprintf(Wlog_Error_String, ERROR_STRING_LEN,
 			"Could not open write_log - open(%s, %#o, %#o) failed:  %s\n",
 			wfile->w_file, oflags, mode, strerror(errno));
 		return -1;
@@ -132,7 +133,7 @@ int			mode;
=20
 	oflags =3D O_RDWR;
 	if ((wfile->w_rfd =3D open(wfile->w_file, oflags)) =3D=3D -1) {
-		sprintf(Wlog_Error_String,
+		snprintf(Wlog_Error_String, ERROR_STRING_LEN,
 			"Could not open write log - open(%s, %#o) failed:  %s\n",
 			wfile->w_file, oflags, strerror(errno));
 		close(wfile->w_afd);
--=20
2.14.3

