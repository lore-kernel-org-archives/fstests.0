Received: from ipmail01.adl2.internode.on.net ([150.101.137.133]:49495 "EHLO
        ipmail01.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752784AbeFTCEX (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Jun 2018 22:04:23 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fVSTr-0006Q1-9Q
        for fstests@vger.kernel.org; Wed, 20 Jun 2018 12:04:19 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fVSTr-0003tq-8W
        for fstests@vger.kernel.org; Wed, 20 Jun 2018 12:04:19 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 6/6] ltp/: spdx license conversion
Date: Wed, 20 Jun 2018 12:04:17 +1000
Message-Id: <20180620020417.14581-7-david@fromorbit.com>
In-Reply-To: <20180620020417.14581-1-david@fromorbit.com>
References: <20180620020417.14581-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Mostly scripted like all the others, manually added tags to
Makefile. aio-stress.c was manually touched up before scripted
conversions.

Notes for future reference:
- fsx.c license is ambiguous. Not tagged in any way.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 ltp/Makefile     |  2 +-
 ltp/aio-stress.c | 25 ++++---------------------
 ltp/doio.c       | 14 +-------------
 ltp/doio.h       | 14 +-------------
 ltp/fsstress.c   | 14 +-------------
 ltp/growfiles.c  | 14 +-------------
 ltp/iogen.c      | 14 +-------------
 7 files changed, 10 insertions(+), 87 deletions(-)

diff --git a/ltp/Makefile b/ltp/Makefile
index eed83f48dce3..5f784ecf6da4 100644
--- a/ltp/Makefile
+++ b/ltp/Makefile
@@ -1,4 +1,4 @@
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2003-2005 Silicon Graphics, Inc.  All Rights Reserved.
 #
 
diff --git a/ltp/aio-stress.c b/ltp/aio-stress.c
index d08843a8a2f8..06e1919d6361 100644
--- a/ltp/aio-stress.c
+++ b/ltp/aio-stress.c
@@ -1,26 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2004 SuSE, Inc.  All Rights Reserved.
- * 
- * This program is free software; you can redistribute it and/or modify it
- * under the terms of version 2 of the GNU General Public License as
- * published by the Free Software Foundation.
- * 
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
- * 
- * Further, this software is distributed without any warranty that it is
- * free of the rightful claim of any third person regarding infringement
- * or the like.  Any license provided herein, whether implied or
- * otherwise, applies only to this software file.  Patent licenses, if
- * any, provided herein do not apply to combinations of this program with
- * other software, or any other product whatsoever.
- * 
- * You should have received a copy of the GNU General Public License along
- * with this program; if not, write the Free Software Foundation, Inc., 59
- * Temple Place - Suite 330, Boston MA 02111-1307, USA.
- * 
- *
+ */
+
+/*
  * aio-stress
  *
  * will open or create each file on the command line, and start a series
diff --git a/ltp/doio.c b/ltp/doio.c
index 939a1eabf3ee..83f8cf556325 100644
--- a/ltp/doio.c
+++ b/ltp/doio.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.
  * All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 /*
  * doio -	a general purpose io initiator with system call and
diff --git a/ltp/doio.h b/ltp/doio.h
index bf8d58150132..dc2db9ace00d 100644
--- a/ltp/doio.h
+++ b/ltp/doio.h
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.
  * All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 /*
  * Define io syscalls supported by doio
diff --git a/ltp/fsstress.c b/ltp/fsstress.c
index e1070997f33e..1bffa115bf2d 100644
--- a/ltp/fsstress.c
+++ b/ltp/fsstress.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2002 Silicon Graphics, Inc.
  * All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
 #include <linux/fs.h>
diff --git a/ltp/growfiles.c b/ltp/growfiles.c
index 951b92665081..7ac44aba0bed 100644
--- a/ltp/growfiles.c
+++ b/ltp/growfiles.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.
  * All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 /*
  * This program will grow a list of files.
diff --git a/ltp/iogen.c b/ltp/iogen.c
index 8fc339e54c34..2b6644d52192 100644
--- a/ltp/iogen.c
+++ b/ltp/iogen.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000 Silicon Graphics, Inc.
  * All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 /*
  * iogen - a tool for generating file/sds io for a doio process
-- 
2.17.0

