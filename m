Received: from userp1050.oracle.com ([156.151.31.82]:45600 "EHLO
	userp1050.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935013AbcATD0v (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 19 Jan 2016 22:26:51 -0500
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
	by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u0ILC5hp016725
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <fstests@vger.kernel.org>; Mon, 18 Jan 2016 21:12:06 GMT
Date: Mon, 18 Jan 2016 13:09:56 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH v2] tools/mvtest: call out to the correct group sort program
Message-ID: <20160118210956.GB5751@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

mvtest should call the actual name of the sort-group program.
Fix a cut-paste error in finding the destination group file.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tools/mvtest |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/mvtest b/tools/mvtest
index af601d6..20bc23e 100755
--- a/tools/mvtest
+++ b/tools/mvtest
@@ -33,7 +33,7 @@ sgroup="$(basename "$(dirname "tests/${src}")")"
 dgroup="$(basename "$(dirname "tests/${dest}")")"
 
 sgroupfile="tests/${sgroup}/group"
-dgroupfile="tests/${sgroup}/group"
+dgroupfile="tests/${dgroup}/group"
 
 git mv "tests/${src}" "tests/${dest}"
 git mv "tests/${src}.out" "tests/${dest}.out"
@@ -47,7 +47,7 @@ newgrpline="$(echo "${grpline}" | sed -e "s/^${sid} /${did} /g")"
 sed -e "/^${sid}.*$/d" -i "${sgroupfile}"
 cp "${dgroupfile}" "${dgroupfile}.new"
 append "${dgroupfile}.new" "${newgrpline}"
-"${dir}/sort-group.py" "${dgroupfile}.new"
+"${dir}/sort-group" "${dgroupfile}.new"
 mv "${dgroupfile}.new" "${dgroupfile}"
 
 echo "Moved \"${src}\" to \"${dest}\"."
