Received: from ipmail01.adl6.internode.on.net ([150.101.137.136]:59326 "EHLO
        ipmail01.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751905AbeFIBzq (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Jun 2018 21:55:46 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fRT6V-0007Y2-OV
        for fstests@vger.kernel.org; Sat, 09 Jun 2018 11:55:43 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fRT6V-0005Br-N8
        for fstests@vger.kernel.org; Sat, 09 Jun 2018 11:55:43 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 3/9] fstests: convert new test template to SPDX tags
Date: Sat,  9 Jun 2018 11:55:34 +1000
Message-Id: <20180609015540.19385-4-david@fromorbit.com>
In-Reply-To: <20180609015540.19385-1-david@fromorbit.com>
References: <20180609015540.19385-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 new | 41 +++++------------------------------------
 1 file changed, 5 insertions(+), 36 deletions(-)

diff --git a/new b/new
index 112a63d5b9f8..2bb8ce5055c1 100755
--- a/new
+++ b/new
@@ -1,22 +1,6 @@
 #! /bin/bash
-#
-#-----------------------------------------------------------------------
-#  Copyright (c) 2000-2005 Silicon Graphics, Inc.  All Rights Reserved.
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#
-#-----------------------------------------------------------------------
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2000-2005 Silicon Graphics, Inc.  All Rights Reserved.
 #
 # Make a new test
 #
@@ -162,28 +146,13 @@ year=`date +%Y`
 
 cat <<End-of-File >$tdir/$id
 #! /bin/bash
-# FS QA Test $id
-#
-# what am I here for?
-#
-#-----------------------------------------------------------------------
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) $year YOUR NAME HERE.  All Rights Reserved.
 #
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation.
-#
-# This program is distributed in the hope that it would be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
+# FS QA Test $id
 #
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#-----------------------------------------------------------------------
+# what am I here for?
 #
-
 seq=\`basename \$0\`
 seqres=\$RESULT_DIR/\$seq
 echo "QA output created by \$seq"
-- 
2.17.0

