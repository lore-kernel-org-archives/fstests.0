Received: from mx1.redhat.com ([209.132.183.28]:46158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751045AbdG1GZz (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 28 Jul 2017 02:25:55 -0400
From: Eryu Guan <eguan@redhat.com>
Subject: [PATCH] new: validate groups when creating new test
Date: Fri, 28 Jul 2017 14:25:22 +0800
Message-Id: <20170728062522.16916-1-eguan@redhat.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
Cc: sandeen@sandeen.net, Eryu Guan <eguan@redhat.com>
List-ID: <fstests@vger.kernel.org>

Allow only lower case letters, digits, spaces and underscore when
adding groups, give prompt if there's any not-allowed characters.
Also remove redundant spaces between groups.

Signed-off-by: Eryu Guan <eguan@redhat.com>
---
 new | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/new b/new
index eb7da0ff463b..4eacccd3bf8b 100755
--- a/new
+++ b/new
@@ -239,7 +239,7 @@ then
 
     while true
     do
-	echo -n "Add to group(s) [other] (? for list): "
+	echo -n "Add to group(s) [other] (separate by space, ? for list): "
 	read ans
 	[ -z "$ans" ] && ans=other
 	if [ "X$ans" = "X?" ]
@@ -254,7 +254,17 @@ then
 	    lst=`for word in $grpl; do echo $word; done | sort| uniq `
 	    echo $lst
 	else
-	    break
+	    # only allow lower cases, spaces, digits and underscore in group
+	    inval=`echo $ans | tr -d '[:lower:][:space:][:digit:]_'`
+	    if [ "$inval" != "" ]; then
+		echo "Invalid characters in group(s): $inval"
+		echo "Only lower cases, digits and underscore are allowed in groups, separated by space"
+		continue
+	    else
+		# remove redundant spaces/tabs
+		ans=`echo "$ans" | sed 's/\s\+/ /g'`
+		break
+	    fi
 	fi
     done
 else
-- 
2.13.3

