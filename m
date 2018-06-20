Received: from ipmail01.adl2.internode.on.net ([150.101.137.133]:19739 "EHLO
        ipmail01.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754153AbeFTCEY (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Jun 2018 22:04:24 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fVSTr-0006Pz-84
        for fstests@vger.kernel.org; Wed, 20 Jun 2018 12:04:19 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fVSTr-0003tk-7A
        for fstests@vger.kernel.org; Wed, 20 Jun 2018 12:04:19 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 4/6] src/aio-dio-regress/: spdx license conversion
Date: Wed, 20 Jun 2018 12:04:15 +1000
Message-Id: <20180620020417.14581-5-david@fromorbit.com>
In-Reply-To: <20180620020417.14581-1-david@fromorbit.com>
References: <20180620020417.14581-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

The license headers all had to be manually editted into a consistent
format, then converted to spdx tags via scripting.  Manually added
tag to Makefile.

Notes for future reference and research:
- quoted source repositories for aio-dio suite no longer exist
- src/aio-dio-regress/aiodio_sparse2.c has no explicit license
  statement, so need to find original source to determine actual
  license before tagging.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 src/aio-dio-regress/Makefile                  |  2 ++
 .../aio-dio-append-write-read-race.c          | 16 +--------
 src/aio-dio-regress/aio-dio-cow-race.c        | 14 +-------
 src/aio-dio-regress/aio-dio-cycle-write.c     | 20 ++---------
 src/aio-dio-regress/aio-dio-eof-race.c        | 19 ++--------
 src/aio-dio-regress/aio-dio-extend-stat.c     | 19 ++--------
 src/aio-dio-regress/aio-dio-fcntl-race.c      | 19 ++--------
 .../aio-dio-hole-filling-race.c               | 19 ++--------
 .../aio-dio-invalidate-failure.c              | 19 ++--------
 .../aio-dio-invalidate-readahead.c            | 19 ++--------
 .../aio-dio-subblock-eof-read.c               | 22 +++---------
 .../aio-free-ring-with-bogus-nr-pages.c       | 25 ++++---------
 ...o-setup-with-nonwritable-context-pointer.c | 23 +++---------
 src/aio-dio-regress/aio-last-ref-held-by-io.c | 21 +++--------
 src/aio-dio-regress/aiocp.c                   | 36 +++++--------------
 15 files changed, 53 insertions(+), 240 deletions(-)
 mode change 100755 => 100644 src/aio-dio-regress/aio-dio-cow-race.c

diff --git a/src/aio-dio-regress/Makefile b/src/aio-dio-regress/Makefile
index 79dd55d81fbc..bd8b4b5df82d 100644
--- a/src/aio-dio-regress/Makefile
+++ b/src/aio-dio-regress/Makefile
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
 TOPDIR = ../..
 include $(TOPDIR)/include/builddefs
 
diff --git a/src/aio-dio-regress/aio-dio-append-write-read-race.c b/src/aio-dio-regress/aio-dio-append-write-read-race.c
index 443994771623..911f27230b95 100644
--- a/src/aio-dio-regress/aio-dio-append-write-read-race.c
+++ b/src/aio-dio-regress/aio-dio-append-write-read-race.c
@@ -1,23 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2013 Alibaba Group.
  * Copyright (c) 2017 Red Hat Inc.
  * All Rights Reserved.
  *
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
- */
-
-/*
  * This is a normal case that we do some append dio writes and meanwhile
  * we do some dio reads.  Currently in vfs we don't ensure that i_size
  * is updated properly.  Hence the reader will read some data with '0'.
diff --git a/src/aio-dio-regress/aio-dio-cow-race.c b/src/aio-dio-regress/aio-dio-cow-race.c
old mode 100755
new mode 100644
index 9fdce4daf7f8..cb5030e62436
--- a/src/aio-dio-regress/aio-dio-cow-race.c
+++ b/src/aio-dio-regress/aio-dio-cow-race.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) Christoph Hellwig.  All Rights Reserved.
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
 #include <sys/stat.h>
 #include <sys/types.h>
diff --git a/src/aio-dio-regress/aio-dio-cycle-write.c b/src/aio-dio-regress/aio-dio-cycle-write.c
index 3236e6b96a4a..bbf21760a40f 100644
--- a/src/aio-dio-regress/aio-dio-cycle-write.c
+++ b/src/aio-dio-regress/aio-dio-cycle-write.c
@@ -1,24 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- * Directly AIO re-write a file with different content again and again.
- * And check the data integrity.
- *
  * Copyright (C) 2017 Red Hat, Inc. All Rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ * Directly AIO re-write a file with different content again and again.
+ * And check the data integrity.
  */
-
 #include <sys/stat.h>
 #include <sys/types.h>
 #include <errno.h>
diff --git a/src/aio-dio-regress/aio-dio-eof-race.c b/src/aio-dio-regress/aio-dio-eof-race.c
index 044790358abd..04d79be11f8e 100644
--- a/src/aio-dio-regress/aio-dio-eof-race.c
+++ b/src/aio-dio-regress/aio-dio-eof-race.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- * Launch 4 sub-block AIOs past EOF and ensure that we don't see
- * corruption from racing sub-block zeroing when they're complete.
- *
  * Copyright (C) 2015 Red Hat, Inc. All Rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ * Launch 4 sub-block AIOs past EOF and ensure that we don't see
+ * corruption from racing sub-block zeroing when they're complete.
  */
 #include <sys/stat.h>
 #include <sys/types.h>
diff --git a/src/aio-dio-regress/aio-dio-extend-stat.c b/src/aio-dio-regress/aio-dio-extend-stat.c
index 7733f510ab6e..6d607d57a426 100644
--- a/src/aio-dio-regress/aio-dio-extend-stat.c
+++ b/src/aio-dio-regress/aio-dio-extend-stat.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- *   aio-dio-extend-stat - test race in dio aio completion
- *   Copyright (C) 2006 Rafal Wijata
+ * Copyright (C) 2006 Rafal Wijata
  *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ * Test race in dio aio completion
  */
-
 #define __USE_GNU
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/aio-dio-regress/aio-dio-fcntl-race.c b/src/aio-dio-regress/aio-dio-fcntl-race.c
index 88a27472d375..d9e551566948 100644
--- a/src/aio-dio-regress/aio-dio-fcntl-race.c
+++ b/src/aio-dio-regress/aio-dio-fcntl-race.c
@@ -1,25 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
+ * Copyright (c) 2014 Dmitry Monakhov.  All Rights Reserved.
+ *
  * Perform aio writes to file and toggle O_DIRECT flag concurrently
  * this may trigger race between file->f_flags read and modification
  * unuligned aio allow to makes race window wider.
  * Regression test for https://lkml.org/lkml/2014/10/8/545 CVE-2014-8086
  * Patch proposed: http://www.spinics.net/lists/linux-ext4/msg45683.html
- *
- * Copyright (c) 2014 Dmitry Monakhov.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
  */
 #include <sys/stat.h>
 #include <sys/types.h>
diff --git a/src/aio-dio-regress/aio-dio-hole-filling-race.c b/src/aio-dio-regress/aio-dio-hole-filling-race.c
index f79c0469c273..81967e270c72 100644
--- a/src/aio-dio-regress/aio-dio-hole-filling-race.c
+++ b/src/aio-dio-regress/aio-dio-hole-filling-race.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- * Read from a sparse file immedialy after filling a hole to test for races
- * in unwritten extent conversion.
- *
  * Copyright (C) 2010 Red Hat, Inc. All Rights reserved.
  *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ * Read from a sparse file immedialy after filling a hole to test for races
+ * in unwritten extent conversion.
  */
 #include <sys/stat.h>
 #include <sys/types.h>
diff --git a/src/aio-dio-regress/aio-dio-invalidate-failure.c b/src/aio-dio-regress/aio-dio-invalidate-failure.c
index 24f3e3c660b2..3df96118bb75 100644
--- a/src/aio-dio-regress/aio-dio-invalidate-failure.c
+++ b/src/aio-dio-regress/aio-dio-invalidate-failure.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- *   aio-dio-invalidate-failure - test race in read cache invalidation
- *   Copyright (C) 2007 Zach Brown
+ * Copyright (C) 2007 Zach Brown
  *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ * Test race in read cache invalidation
  */
- 
 #define _XOPEN_SOURCE 500 /* pwrite */
 #include <unistd.h>
 #include <stdio.h>
diff --git a/src/aio-dio-regress/aio-dio-invalidate-readahead.c b/src/aio-dio-regress/aio-dio-invalidate-readahead.c
index 58ea8c0c2e7b..2ac415148623 100644
--- a/src/aio-dio-regress/aio-dio-invalidate-readahead.c
+++ b/src/aio-dio-regress/aio-dio-invalidate-readahead.c
@@ -1,22 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- *   aio-dio-invalidate-readahead - test sync DIO invalidation of readahead
- *   Copyright (C) 2007 Zach Brown
+ * Copyright (C) 2007 Zach Brown
  *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ * Test sync DIO invalidation of readahead
  */
- 
 #define _XOPEN_SOURCE 500 /* pwrite */
 #include <unistd.h>
 #include <stdio.h>
diff --git a/src/aio-dio-regress/aio-dio-subblock-eof-read.c b/src/aio-dio-regress/aio-dio-subblock-eof-read.c
index 00bd0f13e2f3..6f35b0e8a518 100644
--- a/src/aio-dio-regress/aio-dio-subblock-eof-read.c
+++ b/src/aio-dio-regress/aio-dio-subblock-eof-read.c
@@ -1,23 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- *   aio-dio-subblock-eof-read - test AIO read of last block of DIO file
- *   Copyright (C) 2005 Jeff Moyer
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ * Copyright (C) 2005 Jeff Moyer
  */
- 
+
 /*
+ *  Test AIO read of last block of DIO file
+ *
  *  Code taken from an example posted to linux-aio at kvack.org
  *  http://marc.info/?l=linux-aio&m=112263621431161&w=2
  *  Original Author: Drangon Zhou
diff --git a/src/aio-dio-regress/aio-free-ring-with-bogus-nr-pages.c b/src/aio-dio-regress/aio-free-ring-with-bogus-nr-pages.c
index f133fc0dfb80..7e8189f06a4e 100644
--- a/src/aio-dio-regress/aio-free-ring-with-bogus-nr-pages.c
+++ b/src/aio-dio-regress/aio-free-ring-with-bogus-nr-pages.c
@@ -1,26 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- *   aio-free-ring-with-bogus-nr-pages - test aio_setup_ring with bad nr_pages
- *   Copyright (C) 2006 Kostantin Khorenko
- *   Copyright (C) 2006 Jeff Moyer
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ * Copyright (C) 2006 Kostantin Khorenko
+ * Copyright (C) 2006 Jeff Moyer
  */
- 
+
 /*
- *  Code taken from an example posted to Red Hat bugzilla #220971
+ *  Test aio_setup_ring with bad nr_pages
  *
+ *  Code taken from an example posted to Red Hat bugzilla #220971
  *  Original Author: Kostantin Khorenko from OpenVZ/Virtuozzo
  *  Munged by Jeff Moyer.
  *
diff --git a/src/aio-dio-regress/aio-io-setup-with-nonwritable-context-pointer.c b/src/aio-dio-regress/aio-io-setup-with-nonwritable-context-pointer.c
index 092cbb42f9df..11096b9991f3 100644
--- a/src/aio-dio-regress/aio-io-setup-with-nonwritable-context-pointer.c
+++ b/src/aio-dio-regress/aio-io-setup-with-nonwritable-context-pointer.c
@@ -1,25 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- *   aio-io-setup-with-nonwritable-context-pointer -
- *   Test what happens when a non-writable context pointer is passed to io_setup
- *   Copyright (C) 2007 Jeff Moyer
- *
- *   This program is free software; you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY; without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *   GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program; if not, write to the Free Software
- *   Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ * Copyright (C) 2007 Jeff Moyer
  */
- 
+
 /*
- *  Author:  Jeff Moyer
+ *  Test what happens when a non-writable context pointer is passed to io_setup
  *
  *  Description: Pass a non-writable context pointer to io_setup to see if
  *  the kernel deals with it correctly.  In the past, the reference counting
diff --git a/src/aio-dio-regress/aio-last-ref-held-by-io.c b/src/aio-dio-regress/aio-last-ref-held-by-io.c
index 7633831e1023..a70f2a9b7de8 100644
--- a/src/aio-dio-regress/aio-last-ref-held-by-io.c
+++ b/src/aio-dio-regress/aio-last-ref-held-by-io.c
@@ -1,21 +1,8 @@
-/* Copyright (C) 2010, Matthew E. Cross <matt.cross@gmail.com>
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2010, Matthew E. Cross <matt.cross@gmail.com>
  *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
- */
-
-/* Code to reproduce the aio lockup.
+ * Code to reproduce an aio lockup.
  *
  * Make a test file that is at least 4MB long.  Something like this:
  * 'dd if=/dev/zero of=/tmp/testfile bs=1M count=10'
diff --git a/src/aio-dio-regress/aiocp.c b/src/aio-dio-regress/aiocp.c
index ccab2ac223ba..7e71cc5ce649 100644
--- a/src/aio-dio-regress/aiocp.c
+++ b/src/aio-dio-regress/aiocp.c
@@ -1,48 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2004 Daniel McNeil <daniel@osdl.org>
  *               2004 Open Source Development Lab
- *   This program is free software;  you can redistribute it and/or modify
- *   it under the terms of the GNU General Public License as published by
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
  *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
+ * Copy file by using a async I/O state machine.
+ * 1. Start read request
+ * 2. When read completes turn it into a write request
+ * 3. When write completes decrement counter and free resources
  *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
+ * Usage: aiocp [-b blksize] -n [num_aio] [-w] [-z] [-s filesize]
+ *		[-f DIRECT|TRUNC|CREAT|SYNC|LARGEFILE] src dest
  *
- * Module: .c
- */
-
-/*
  * Change History:
  *
- *
  * version of copy command using async i/o
  * From:	Stephen Hemminger <shemminger@osdl.org>
  * Modified by Daniel McNeil <daniel@osdl.org> for testing aio.
  *	- added -a alignment
- *	- added -b blksize option 
+ *	- added -b blksize option
  *	_ added -s size	option
  *	- added -f open_flag option
  *	- added -w (no write) option (reads from source only)
- *	- added -n (num aio) option 
+ *	- added -n (num aio) option
  *	- added -z (zero dest) opton (writes zeros to dest only)
  *	- added -D delay_ms option
  *  - 2/2004  Marty Ridgeway (mridge@us.ibm.com) Changes to adapt to LTP
- *
- * Copy file by using a async I/O state machine.
- * 1. Start read request
- * 2. When read completes turn it into a write request
- * 3. When write completes decrement counter and free resources
- *
- *
- * Usage: aiocp [-b blksize] -n [num_aio] [-w] [-z] [-s filesize] 
- *		[-f DIRECT|TRUNC|CREAT|SYNC|LARGEFILE] src dest
  */
 
 //#define _GNU_SOURCE
-- 
2.17.0

