Received: from aserp1040.oracle.com ([141.146.126.69]:21822 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750705AbdAWSwc (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 23 Jan 2017 13:52:32 -0500
Date: Mon, 23 Jan 2017 10:52:24 -0800
From: "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] mvtest: change "FSQA Test No." when we renumber tests
Message-ID: <20170123185224.GF14029@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <eguan@redhat.com>
Cc: fstests <fstests@vger.kernel.org>
List-ID: <fstests@vger.kernel.org>

We have a number of tests (and submitters) who write tests containing
"FSQA Test No." (as opposed to "FS QA Test No."), so update the mvtest
script to change both forms.

Also fix a sed bug that deletes too many group lines.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 tools/mvtest |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/mvtest b/tools/mvtest
index 20bc23e..572ae14 100755
--- a/tools/mvtest
+++ b/tools/mvtest
@@ -37,14 +37,14 @@ dgroupfile="tests/${dgroup}/group"
 
 git mv "tests/${src}" "tests/${dest}"
 git mv "tests/${src}.out" "tests/${dest}.out"
-sed -e "s/^# FS QA Test No. ${sid}$/# FS QA Test No. ${did}/g" -i "tests/${dest}"
+sed -e "s/^# FS[[:space:]]*QA.*Test.*[0-9]\+$/# FS QA Test No. ${did}/g" -i "tests/${dest}"
 sed -e "s/^QA output created by ${sid}$/QA output created by ${did}/g" -i "tests/${dest}.out"
 sed -e "s/test-${sid}/test-${did}/g" -i "tests/${dest}.out"
 
 grpline="$(grep "^${sid} " "${sgroupfile}")"
 newgrpline="$(echo "${grpline}" | sed -e "s/^${sid} /${did} /g")"
 
-sed -e "/^${sid}.*$/d" -i "${sgroupfile}"
+sed -e "/^${sid} .*$/d" -i "${sgroupfile}"
 cp "${dgroupfile}" "${dgroupfile}.new"
 append "${dgroupfile}.new" "${newgrpline}"
 "${dir}/sort-group" "${dgroupfile}.new"
