Received: from mga05.intel.com ([192.55.52.43]:19927 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750862AbdLGVfJ (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 7 Dec 2017 16:35:09 -0500
From: Ross Zwisler <ross.zwisler@linux.intel.com>
Subject: [PATCH 2/3] xfstests: fix TagName overflow issues
Date: Thu,  7 Dec 2017 14:35:02 -0700
Message-Id: <20171207213503.31070-2-ross.zwisler@linux.intel.com>
In-Reply-To: <20171207213503.31070-1-ross.zwisler@linux.intel.com>
References: <20171207213503.31070-1-ross.zwisler@linux.intel.com>
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>, fstests <fstests@vger.kernel.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>
List-ID: <fstests@vger.kernel.org>

The 'TagName' string is defined to be 40 characters in length, but in three
places we write into it with a format of "(%.39s)".  This can result in a
string of up to 42 characters, the 39 character user string plus "()\0".
This overflows TagName, as we see in the new complier warnings from gcc
7.2.1:

iogen.c:1277:6: note: 'sprintf' output between 3 and 42 bytes into a
destination of size 40
  sprintf( TagName, "(%.39s)", optarg );
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fix this by limiting the user string to 37 characters.

Signed-off-by: Ross Zwisler <ross.zwisler@linux.intel.com>
---
 ltp/doio.c      | 2 +-
 ltp/growfiles.c | 2 +-
 ltp/iogen.c     | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ltp/doio.c b/ltp/doio.c
index dcb3efd8..b9377187 100644
--- a/ltp/doio.c
+++ b/ltp/doio.c
@@ -3184,7 +3184,7 @@ char	*opts;
 			break;
 
 		case 'N':
-			sprintf( TagName, "(%.39s)", optarg );
+			sprintf( TagName, "(%.37s)", optarg );
 			break;
 
 		case 'n':
diff --git a/ltp/growfiles.c b/ltp/growfiles.c
index fb91761f..ad1ecdf5 100644
--- a/ltp/growfiles.c
+++ b/ltp/growfiles.c
@@ -794,7 +794,7 @@ extern int Forker_npids;	/* num of forked pid, defined in forker.c */
 			break;
 
 		case 'W':
-			sprintf( TagName, "(%.39s)", optarg );
+			sprintf( TagName, "(%.37s)", optarg );
 			break;
 
 		case 'y':
diff --git a/ltp/iogen.c b/ltp/iogen.c
index 1eaab1f0..8fc339e5 100644
--- a/ltp/iogen.c
+++ b/ltp/iogen.c
@@ -1274,7 +1274,7 @@ char	*opts;
 	    break;
 
 	case 'N':
-	    sprintf( TagName, "(%.39s)", optarg );
+	    sprintf( TagName, "(%.37s)", optarg );
 	    break;
 
 	case 'o':
-- 
2.14.3

