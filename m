Received: from mx2.suse.de ([195.135.220.15]:39618 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754589AbbKXKkE (ORCPT <rfc822;fstests@vger.kernel.org>);
	Tue, 24 Nov 2015 05:40:04 -0500
From: Jan Kara <jack@suse.cz>
Subject: [PATCH 1/3] common: Factor out function to get OS name
Date: Tue, 24 Nov 2015 11:39:56 +0100
Message-Id: <1448361598-28438-2-git-send-email-jack@suse.cz>
In-Reply-To: <1448361598-28438-1-git-send-email-jack@suse.cz>
References: <1448361598-28438-1-git-send-email-jack@suse.cz>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
List-ID: <fstests@vger.kernel.org>

Signed-off-by: Jan Kara <jack@suse.cz>
---
 common/rc | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/common/rc b/common/rc
index 4c2f42c8d0eb..81418280f163 100644
--- a/common/rc
+++ b/common/rc
@@ -2188,6 +2188,18 @@ _full_platform_details()
      echo "$os/$platform $host $kernel"
 }
 
+_get_os_name()
+{
+	if [ "`uname`" == "IRIX64" ] || [ "`uname`" == "IRIX" ]; then
+		echo 'irix'
+	elif [ "`uname`" == "Linux" ]; then
+		echo 'linux'
+	else
+		echo Unknown operating system: `uname`
+		exit
+	fi
+}
+
 _link_out_file()
 {
 	if [ -z "$1" -o -z "$2" ]; then
@@ -2195,14 +2207,8 @@ _link_out_file()
 		exit
 	fi
 	rm -f $2
-	if [ "`uname`" == "IRIX64" ] || [ "`uname`" == "IRIX" ]; then
-		ln -s $1.irix $2
-	elif [ "`uname`" == "Linux" ]; then
-		ln -s $1.linux $2
-	else
-		echo Error test $seq does not run on the operating system: `uname`
-		exit
-	fi
+	SUFFIX=$(_get_os_name())
+	ln -s $1.$SUFFIX $2
 }
 
 _die()
-- 
2.1.4

