Received: from aserp1040.oracle.com ([141.146.126.69]:18747 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752969AbcAWAgx (ORCPT
	<rfc822;fstests@vger.kernel.org>); Fri, 22 Jan 2016 19:36:53 -0500
Subject: [PATCH 1/5] tools/mvtest: call out to the correct group sort program
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Date: Fri, 22 Jan 2016 16:36:48 -0800
Message-ID: <20160123003648.2666.37062.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: david@fromorbit.com, darrick.wong@oracle.com
Cc: fstests@vger.kernel.org, xfs@oss.sgi.com
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

