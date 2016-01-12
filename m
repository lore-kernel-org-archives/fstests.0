Received: from userp1040.oracle.com ([156.151.31.81]:44957 "EHLO
	userp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753269AbcALJkQ (ORCPT
	<rfc822;fstests@vger.kernel.org>); Tue, 12 Jan 2016 04:40:16 -0500
Date: Tue, 12 Jan 2016 01:40:07 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] tools/mvtest: call out to the correct group sort program
Message-ID: <20160112094007.GD7832@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: Eryu Guan <eguan@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

mvtest should call the actual name of the sort-group program.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tools/mvtest |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/mvtest b/tools/mvtest
index af601d6..e99b33b 100755
--- a/tools/mvtest
+++ b/tools/mvtest
@@ -47,7 +47,7 @@ newgrpline="$(echo "${grpline}" | sed -e "s/^${sid} /${did} /g")"
 sed -e "/^${sid}.*$/d" -i "${sgroupfile}"
 cp "${dgroupfile}" "${dgroupfile}.new"
 append "${dgroupfile}.new" "${newgrpline}"
-"${dir}/sort-group.py" "${dgroupfile}.new"
+"${dir}/sort-group" "${dgroupfile}.new"
 mv "${dgroupfile}.new" "${dgroupfile}"
 
 echo "Moved \"${src}\" to \"${dest}\"."
