Received: from ipmail01.adl2.internode.on.net ([150.101.137.133]:19739 "EHLO
        ipmail01.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754153AbeFTCE1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Jun 2018 22:04:27 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fVSTr-0006Q0-8n
        for fstests@vger.kernel.org; Wed, 20 Jun 2018 12:04:19 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fVSTr-0003tn-7r
        for fstests@vger.kernel.org; Wed, 20 Jun 2018 12:04:19 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 5/6] src/: spdx license conversion
Date: Wed, 20 Jun 2018 12:04:16 +1000
Message-Id: <20180620020417.14581-6-david@fromorbit.com>
In-Reply-To: <20180620020417.14581-1-david@fromorbit.com>
References: <20180620020417.14581-1-david@fromorbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Mostly scripted like all the others, manually added tags to
Makefile, nsexec.c and t_mmap_writev.c. Manually touched up
open_by_handle.c and t_encrypted_d_revalidate.c post script.

Notes for future reference:
- src/log-writes/ code has no explicit copyright or license tags,
  nor does the upstream repository, hence license is unknown.
  Need Josef to clarify the license and send a patch adding SPDX
  tags to those files.

- src/perf code has no explicit copyright or license tags, but it
  was code submitted explictly for fstests so it is assumed to be
  GPLv2.0 and tagged as such. If this is incorrect, Josef will need
  to clarify copyright and the license and send patches to correct
  it.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 src/Makefile                          |  1 +
 src/af_unix.c                         |  7 +------
 src/alloc.c                           | 14 +-------------
 src/attr-list-by-handle-cursor-test.c | 16 +---------------
 src/bstat.c                           | 14 +-------------
 src/cloner.c                          | 16 +---------------
 src/dbtest.c                          | 14 +-------------
 src/devzero.c                         | 14 +-------------
 src/dio-invalidate-cache.c            | 14 +-------------
 src/dirhash_collide.c                 | 14 +-------------
 src/dirperf.c                         | 14 +-------------
 src/dirstress.c                       | 14 +-------------
 src/dmerror                           | 16 +---------------
 src/dmiperf.c                         | 14 +-------------
 src/fault.c                           | 14 +-------------
 src/feature.c                         | 14 +-------------
 src/fiemap-tester.c                   | 14 +-------------
 src/fill.c                            | 14 +-------------
 src/fill2.c                           | 14 +-------------
 src/fs_perms.c                        | 16 +---------------
 src/fssum.c                           | 15 +--------------
 src/ftrunc.c                          | 14 +-------------
 src/getdevicesize.c                   | 14 +-------------
 src/global.h                          | 14 +-------------
 src/godown.c                          | 14 +-------------
 src/holes.c                           | 14 +-------------
 src/holetest.c                        | 15 +--------------
 src/iopat.c                           | 14 +-------------
 src/listxattr.c                       | 14 +-------------
 src/locktest.c                        | 14 +-------------
 src/log-writes/Makefile               |  2 ++
 src/loggen.c                          | 14 +-------------
 src/looptest.c                        | 14 +-------------
 src/lstat64.c                         | 14 +-------------
 src/makeextents.c                     | 14 +-------------
 src/metaperf.c                        | 14 +-------------
 src/multi_open_unlink.c               | 14 +-------------
 src/nametest.c                        | 14 +-------------
 src/nsexec.c                          | 17 ++++++++---------
 src/open_by_handle.c                  | 23 ++++-------------------
 src/perf/FioCompare.py                |  2 ++
 src/perf/FioResultDecoder.py          |  2 ++
 src/perf/Makefile                     |  2 ++
 src/perf/ResultData.py                |  2 ++
 src/perf/fio-insert-and-compare.py    |  2 ++
 src/perf/generate-schema.py           |  2 ++
 src/permname.c                        | 14 +-------------
 src/pwrite_mmap_blocked.c             | 14 +-------------
 src/randholes.c                       | 14 +-------------
 src/resvtest.c                        | 18 +-----------------
 src/runas.c                           | 14 +-------------
 src/scaleread.c                       | 14 +-------------
 src/seek_copy_test.c                  | 15 +--------------
 src/seek_sanity_test.c                | 15 +--------------
 src/stale_handle.c                    | 16 +---------------
 src/stat_test.c                       |  7 +------
 src/t_dir_offset2.c                   | 14 +-------------
 src/t_dir_type.c                      | 14 +-------------
 src/t_encrypted_d_revalidate.c        | 23 ++++-------------------
 src/t_futimens.c                      |  7 +------
 src/t_holes.c                         | 14 +-------------
 src/t_immutable.c                     | 16 +---------------
 src/t_mmap_writev.c                   | 27 +++++++--------------------
 src/t_stripealign.c                   |  8 +-------
 src/t_truncate_cmtime.c               | 15 +--------------
 src/test-nextquota.c                  | 14 +-------------
 src/trunc.c                           | 14 +-------------
 src/truncfile.c                       | 14 +-------------
 src/usemem.c                          | 14 +-------------
 src/writemod.c                        | 14 +-------------
 src/writev_on_pagefault.c             | 16 +---------------
 src/xfsctl.c                          | 14 +-------------
 72 files changed, 98 insertions(+), 843 deletions(-)
 mode change 100755 =3D> 100644 src/looptest.c

diff --git a/src/Makefile b/src/Makefile
index 01fe99efbdad..29e781325dd2 100644
--- a/src/Makefile
+++ b/src/Makefile
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Copyright (c) 2000-2005 Silicon Graphics, Inc.  All Rights Reserved.
 #
diff --git a/src/af_unix.c b/src/af_unix.c
index dc2368eadc2d..41037ee4b7ad 100644
--- a/src/af_unix.c
+++ b/src/af_unix.c
@@ -1,12 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /* Create an AF_UNIX socket.
- *
  * Copyright (C) 2017 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public Licence
- * as published by the Free Software Foundation; either version
- * 2 of the Licence, or (at your option) any later version.
  */
=20
 #include <stdarg.h>
diff --git a/src/alloc.c b/src/alloc.c
index 10d654d35b77..57a91f811d52 100644
--- a/src/alloc.c
+++ b/src/alloc.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2003 Silicon Graphics, Inc.
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
 =20
 #include "global.h"
diff --git a/src/attr-list-by-handle-cursor-test.c b/src/attr-list-by-han=
dle-cursor-test.c
index 4269d1e4c78b..fe4699d4c323 100644
--- a/src/attr-list-by-handle-cursor-test.c
+++ b/src/attr-list-by-handle-cursor-test.c
@@ -1,21 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (C) 2016 Oracle.  All Rights Reserved.
- *
  * Author: Darrick J. Wong <darrick.wong@oracle.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write the Free Software Foundation,
- * Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301, USA.
  */
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/src/bstat.c b/src/bstat.c
index 4e22ecd04f5a..e4367ceee4f4 100644
--- a/src/bstat.c
+++ b/src/bstat.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2003 Silicon Graphics, Inc.
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
=20
 #include "global.h"
diff --git a/src/cloner.c b/src/cloner.c
index 18c44b9770f5..ffad82f000b8 100644
--- a/src/cloner.c
+++ b/src/cloner.c
@@ -1,21 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  Tiny program to perform file (range) clones using raw Btrfs and CIFS=
 ioctls.
- *
  *  Copyright (C) 2014 SUSE Linux Products GmbH. All Rights Reserved.
- *
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
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-130=
7, USA.
  */
=20
 #include <sys/types.h>
diff --git a/src/dbtest.c b/src/dbtest.c
index 4366dcdf8da0..f063e8351669 100644
--- a/src/dbtest.c
+++ b/src/dbtest.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2001 Silicon Graphics, Inc.
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
 =20
 #include "global.h"
diff --git a/src/devzero.c b/src/devzero.c
index acdc0a6982cf..0896280f1d57 100644
--- a/src/devzero.c
+++ b/src/devzero.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2003 Silicon Graphics, Inc.
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
=20
 #include "global.h"
diff --git a/src/dio-invalidate-cache.c b/src/dio-invalidate-cache.c
index 0f87d668902c..10ea7eca8e8e 100644
--- a/src/dio-invalidate-cache.c
+++ b/src/dio-invalidate-cache.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2017 Red Hat Inc. All Rights Reserved.
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
=20
 /*
diff --git a/src/dirhash_collide.c b/src/dirhash_collide.c
index 55cec872d506..88e552e8515b 100644
--- a/src/dirhash_collide.c
+++ b/src/dirhash_collide.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generates files or directories with hash collisions on a XFS filesyst=
em
  * Copyright (C) 2014 Hannes Frederic Sowa
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-=
1301, USA.
  */
=20
 #include <stdlib.h>
diff --git a/src/dirperf.c b/src/dirperf.c
index 01af858d37b2..f874daa08310 100644
--- a/src/dirperf.c
+++ b/src/dirperf.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2004 Silicon Graphics, Inc.
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
=20
 #include <sys/param.h>
diff --git a/src/dirstress.c b/src/dirstress.c
index b70e6b88b948..615cb6e322e8 100644
--- a/src/dirstress.c
+++ b/src/dirstress.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2001 Silicon Graphics, Inc.
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
 =20
  /*
diff --git a/src/dmerror b/src/dmerror
index 4aaf682ee5f9..c34d1a9a99f3 100755
--- a/src/dmerror
+++ b/src/dmerror
@@ -1,20 +1,6 @@
 #!/bin/bash
-#-----------------------------------------------------------------------
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2017, Jeff Layton <jlayton@redhat.com>
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
-#-----------------------------------------------------------------------
=20
 . ./common/config
 . ./common/dmerror
diff --git a/src/dmiperf.c b/src/dmiperf.c
index 359324ac4e04..4026dcfb4aa2 100644
--- a/src/dmiperf.c
+++ b/src/dmiperf.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2006 Silicon Graphics, Inc.
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
=20
 #include <sys/types.h>
diff --git a/src/fault.c b/src/fault.c
index e20ab13629d6..6e079a19e8df 100644
--- a/src/fault.c
+++ b/src/fault.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2003 Silicon Graphics, Inc.
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
=20
 #include "global.h"
diff --git a/src/feature.c b/src/feature.c
index 0fb834a0273e..a7eb75950b4b 100644
--- a/src/feature.c
+++ b/src/feature.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2003 Silicon Graphics, Inc.
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
=20
 /*
diff --git a/src/fiemap-tester.c b/src/fiemap-tester.c
index 5cb58fc3b358..97ac5ad08d7a 100644
--- a/src/fiemap-tester.c
+++ b/src/fiemap-tester.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2009 Josef Bacik
  * All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License V2
- * as published by the Free Software Foundation.
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
=20
 #include <stdio.h>
diff --git a/src/fill.c b/src/fill.c
index b07fd9e0b2e9..3699c361dd24 100644
--- a/src/fill.c
+++ b/src/fill.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2001 Silicon Graphics, Inc.
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
=20
 #include <stdio.h>
diff --git a/src/fill2.c b/src/fill2.c
index 94a1c1778a44..4cc1c3d79a98 100644
--- a/src/fill2.c
+++ b/src/fill2.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2003 Silicon Graphics, Inc.
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
=20
=20
diff --git a/src/fs_perms.c b/src/fs_perms.c
index 57800160257d..6c89bfe62da9 100644
--- a/src/fs_perms.c
+++ b/src/fs_perms.c
@@ -1,20 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- *
  *   Copyright (c) International Business Machines  Corp., 2000
- *
- *   This program is free software;  you can redistribute it and/or modi=
fy
- *   it under the terms of the GNU General Public License as published b=
y
- *   the Free Software Foundation; either version 2 of the License, or
- *   (at your option) any later version.
- *
- *   This program is distributed in the hope that it will be useful,
- *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
- *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
- *   the GNU General Public License for more details.
- *
- *   You should have received a copy of the GNU General Public License
- *   along with this program;  if not, write to the Free Software
- *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307=
 USA
  */
=20
 /*
diff --git a/src/fssum.c b/src/fssum.c
index 2eaa236a6d76..5da39abfbe45 100644
--- a/src/fssum.c
+++ b/src/fssum.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2012 STRATO AG.  All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public
- * License v2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public
- * License along with this program; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 021110-1307, USA.
  */
 #ifdef __linux__
 #define _BSD_SOURCE
diff --git a/src/ftrunc.c b/src/ftrunc.c
index a85efdfef84d..67aa502cb4b1 100644
--- a/src/ftrunc.c
+++ b/src/ftrunc.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2003 Silicon Graphics, Inc.
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
=20
 #include <unistd.h>
diff --git a/src/getdevicesize.c b/src/getdevicesize.c
index a1745b013e36..cf183a426c35 100644
--- a/src/getdevicesize.c
+++ b/src/getdevicesize.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2004 Silicon Graphics, Inc.
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
=20
 /*
diff --git a/src/global.h b/src/global.h
index 9dec9d49dd82..e5e462343470 100644
--- a/src/global.h
+++ b/src/global.h
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2003 Silicon Graphics, Inc.
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
 =20
 #ifndef GLOBAL_H
diff --git a/src/godown.c b/src/godown.c
index b140a4186444..25ad21e7ce35 100644
--- a/src/godown.c
+++ b/src/godown.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2004 Silicon Graphics, Inc.
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
=20
 #include <syslog.h>
diff --git a/src/holes.c b/src/holes.c
index 3be8a6644ced..76a8964a45df 100644
--- a/src/holes.c
+++ b/src/holes.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2001 Silicon Graphics, Inc.
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
 =20
 #include "global.h"
diff --git a/src/holetest.c b/src/holetest.c
index ab582f5fad56..a8fded0f236d 100644
--- a/src/holetest.c
+++ b/src/holetest.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * holetest -- test simultaneous page faults on hole-backed pages
  * Copyright (C) 2015  Hewlett Packard Enterprise Development LP
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version 2
- * of the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software Foundatio=
n,
- * Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
  */
=20
=20
diff --git a/src/iopat.c b/src/iopat.c
index 7383af5065d5..a107a9a01df7 100644
--- a/src/iopat.c
+++ b/src/iopat.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2003 Silicon Graphics, Inc.
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
=20
 #include <stdlib.h>
diff --git a/src/listxattr.c b/src/listxattr.c
index d8517f56fb12..7f093980b8e2 100644
--- a/src/listxattr.c
+++ b/src/listxattr.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License as
- * published by the Free Software Foundation, either version 2 of
- * the License, or (at your option) any later version.
- *
- * This program is distributed in the hope that it would be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
 #include <errno.h>
diff --git a/src/locktest.c b/src/locktest.c
index eab48e2a012f..b23a1a99cc76 100644
--- a/src/locktest.c
+++ b/src/locktest.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2003 Silicon Graphics, Inc.
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
=20
 /*
diff --git a/src/log-writes/Makefile b/src/log-writes/Makefile
index d114177fda09..e407051a3aef 100644
--- a/src/log-writes/Makefile
+++ b/src/log-writes/Makefile
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
 TOPDIR =3D ../..
 include $(TOPDIR)/include/builddefs
=20
diff --git a/src/loggen.c b/src/loggen.c
index ed1ebbccc8ba..f9a2be565fc8 100644
--- a/src/loggen.c
+++ b/src/loggen.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2003 Silicon Graphics, Inc.
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
 =20
 /*
diff --git a/src/looptest.c b/src/looptest.c
old mode 100755
new mode 100644
index ff933954ceb7..7194a97d1061
--- a/src/looptest.c
+++ b/src/looptest.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2013 SGI.  All Rights Reserved.
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
 =20
 /* dxm - 28/2/2 */
diff --git a/src/lstat64.c b/src/lstat64.c
index c8a0cc6c05b1..db8726fde361 100644
--- a/src/lstat64.c
+++ b/src/lstat64.c
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
 =20
 #include <unistd.h>
diff --git a/src/makeextents.c b/src/makeextents.c
index a36685ae7b80..ed6c6a2e59a5 100644
--- a/src/makeextents.c
+++ b/src/makeextents.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2004 Silicon Graphics, Inc.
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
=20
 /*
diff --git a/src/metaperf.c b/src/metaperf.c
index 5f5a971ab7f6..ba5014545fed 100644
--- a/src/metaperf.c
+++ b/src/metaperf.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2003 Silicon Graphics, Inc.
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
=20
 #include <sys/param.h>
diff --git a/src/multi_open_unlink.c b/src/multi_open_unlink.c
index 51a405efaab4..d697e5f137e2 100644
--- a/src/multi_open_unlink.c
+++ b/src/multi_open_unlink.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2006 Silicon Graphics, Inc.
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
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/src/nametest.c b/src/nametest.c
index 776f91ead5b1..39ab4c56f443 100644
--- a/src/nametest.c
+++ b/src/nametest.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2001 Silicon Graphics, Inc.
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
=20
 #include "global.h"
diff --git a/src/nsexec.c b/src/nsexec.c
index c2d172fe71b4..750d52df1297 100644
--- a/src/nsexec.c
+++ b/src/nsexec.c
@@ -1,12 +1,11 @@
-/* userns_child_exec.c
-
-   Copyright 2013, Michael Kerrisk
-   Licensed under GNU General Public License v2 or later
-
-   Create a child process that executes a shell command in new
-   namespace(s); allow UID and GID mappings to be specified when
-   creating a user namespace.
-*/
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2013, Michael Kerrisk
+ *
+ * Create a child process that executes a shell command in new
+ * namespace(s); allow UID and GID mappings to be specified when
+ * creating a user namespace.
+ */
=20
 #ifndef  _GNU_SOURCE
 #define _GNU_SOURCE
diff --git a/src/open_by_handle.c b/src/open_by_handle.c
index f5be2350e3fd..36f2b07765e2 100644
--- a/src/open_by_handle.c
+++ b/src/open_by_handle.c
@@ -1,28 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
- * open_by_handle.c - attempt to create a file handle and open it
- *                    with open_by_handle_at() syscall
- *
+ * Copyright (C) 2010 Red Hat, Inc. All Rights reserved.
  * Copyright (C) 2017 CTERA Networks. All Rights Reserved.
  * Author: Amir Goldstein <amir73il@gmail.com>
  *
+ * Attempt to create a file handle and open it with open_by_handle_at() =
syscall
+ *
  * from:
  *  stale_handle.c
- *
- *  Copyright (C) 2010 Red Hat, Inc. All Rights reserved.
- *
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
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-130=
7, USA.
  */
=20
 /*
diff --git a/src/perf/FioCompare.py b/src/perf/FioCompare.py
index 6b56bd46e07f..52f992a7f2a5 100644
--- a/src/perf/FioCompare.py
+++ b/src/perf/FioCompare.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
 default_keys =3D [ 'iops', 'io_bytes', 'bw' ]
 latency_keys =3D [ 'lat_ns_min', 'lat_ns_max' ]
 main_job_keys =3D [ 'sys_cpu', 'elapsed' ]
diff --git a/src/perf/FioResultDecoder.py b/src/perf/FioResultDecoder.py
index e15406f89819..d004140c0fdf 100644
--- a/src/perf/FioResultDecoder.py
+++ b/src/perf/FioResultDecoder.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
 import json
=20
 class FioResultDecoder(json.JSONDecoder):
diff --git a/src/perf/Makefile b/src/perf/Makefile
index 819e76784b4b..5ccd752fae5e 100644
--- a/src/perf/Makefile
+++ b/src/perf/Makefile
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
 TOPDIR =3D ../..
 include $(TOPDIR)/include/builddefs
=20
diff --git a/src/perf/ResultData.py b/src/perf/ResultData.py
index f0c7eace6dad..6772c317a8dc 100644
--- a/src/perf/ResultData.py
+++ b/src/perf/ResultData.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
 import sqlite3
=20
 def _dict_factory(cursor, row):
diff --git a/src/perf/fio-insert-and-compare.py b/src/perf/fio-insert-and=
-compare.py
index 064af6daaa40..e5b12ab4b667 100644
--- a/src/perf/fio-insert-and-compare.py
+++ b/src/perf/fio-insert-and-compare.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
 import FioResultDecoder
 import ResultData
 import FioCompare
diff --git a/src/perf/generate-schema.py b/src/perf/generate-schema.py
index b61504b06efb..1631010d2b55 100644
--- a/src/perf/generate-schema.py
+++ b/src/perf/generate-schema.py
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+
 import json
 import argparse
 import FioResultDecoder
diff --git a/src/permname.c b/src/permname.c
index 77c8b97f0346..a5b0246dfc5f 100644
--- a/src/permname.c
+++ b/src/permname.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2001 Silicon Graphics, Inc.
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
 =20
 #include "global.h"
diff --git a/src/pwrite_mmap_blocked.c b/src/pwrite_mmap_blocked.c
index 0ebd746bc6fd..c2eac27d8fa7 100644
--- a/src/pwrite_mmap_blocked.c
+++ b/src/pwrite_mmap_blocked.c
@@ -1,17 +1,5 @@
+// SPDX-License-Identifier: GPL-2.0
 /*    Copyright (c) 2010 Intel Corporation
- *
- *    This program is free software; you can redistribute it and/or modi=
fy it
- *    under the terms of the GNU General Public License as published by =
the Free
- *    Software Foundation; version 2 of the License
- *
- *    This program is distributed in the hope that it will be useful, bu=
t
- *    WITHOUT ANY WARRANTY; without even the implied warranty of MERCHAN=
TABILITY
- *    or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public L=
icense
- *    for more details.
- *
- *    You should have received a copy of the GNU General Public License =
along
- *    with this program; if not, write to the Free Software Foundation, =
Inc., 59
- *    Temple Place - Suite 330, Boston, MA 02111-1307, USA.
  */
=20
 #include <stdio.h>
diff --git a/src/randholes.c b/src/randholes.c
index a16670f06547..648cabf7c469 100644
--- a/src/randholes.c
+++ b/src/randholes.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2003, 2010 SGI
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
 =20
 #include <inttypes.h>
diff --git a/src/resvtest.c b/src/resvtest.c
index ecad031781d7..898731de3cdd 100644
--- a/src/resvtest.c
+++ b/src/resvtest.c
@@ -1,22 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Copyright (c) 2004 Silicon Graphics, Inc.  All Rights Reserved.
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
- * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
- * USA
- *
- * Contact information: Silicon Graphics, Inc., 1500 Crittenden Lane,
- * Mountain View, CA 94043, USA, or: http://www.sgi.com
  */=20
=20
 #include "global.h"
diff --git a/src/runas.c b/src/runas.c
index 1e7ea25b4298..879d756a679d 100644
--- a/src/runas.c
+++ b/src/runas.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2001 Silicon Graphics, Inc.
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
=20
 /*
diff --git a/src/scaleread.c b/src/scaleread.c
index 7d53cf65f298..4a1def005dee 100644
--- a/src/scaleread.c
+++ b/src/scaleread.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2003-2004 Silicon Graphics, Inc.
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
  * Test scaling of multiple processes opening/reading
diff --git a/src/seek_copy_test.c b/src/seek_copy_test.c
index ee5e43400c72..0c2c6a3d40d1 100644
--- a/src/seek_copy_test.c
+++ b/src/seek_copy_test.c
@@ -1,19 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2011 Oracle.  All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public
- * License v2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public
- * License along with this program; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 021110-1307, USA.
  */
 #define _XOPEN_SOURCE 500
 #include <stdio.h>
diff --git a/src/seek_sanity_test.c b/src/seek_sanity_test.c
index 9245464400e8..e5aab239771d 100644
--- a/src/seek_sanity_test.c
+++ b/src/seek_sanity_test.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2011 Oracle.  All rights reserved.
  * Copyright (C) 2011 Red Hat.  All rights reserved.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public
- * License v2 as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public
- * License along with this program; if not, write to the
- * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
- * Boston, MA 021110-1307, USA.
  */
=20
 #define _XOPEN_SOURCE 500
diff --git a/src/stale_handle.c b/src/stale_handle.c
index 60f6ddcaf475..2acd4968c964 100644
--- a/src/stale_handle.c
+++ b/src/stale_handle.c
@@ -1,21 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  *  stale_handle.c - attempt to create a stale handle and open it
- *
  *  Copyright (C) 2010 Red Hat, Inc. All Rights reserved.
- *
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
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-130=
7, USA.
  */
=20
 #define TEST_UTIME
diff --git a/src/stat_test.c b/src/stat_test.c
index 198c1332fcc9..94c20d60c972 100644
--- a/src/stat_test.c
+++ b/src/stat_test.c
@@ -1,12 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /* Perform various tests on stat and statx output
- *
  * Copyright (C) 2017 Red Hat, Inc. All Rights Reserved.
  * Written by David Howells (dhowells@redhat.com)
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public Licence
- * as published by the Free Software Foundation; either version
- * 2 of the Licence, or (at your option) any later version.
  */
=20
 #include <stdarg.h>
diff --git a/src/t_dir_offset2.c b/src/t_dir_offset2.c
index 4792e10efac1..5a6d7193b0c0 100644
--- a/src/t_dir_offset2.c
+++ b/src/t_dir_offset2.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2011 Gra=C5=BEvydas Ignotas
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
=20
 /*
diff --git a/src/t_dir_type.c b/src/t_dir_type.c
index 7bba3043e941..ba8e38ff4855 100644
--- a/src/t_dir_type.c
+++ b/src/t_dir_type.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) 2016 CTERA Networks. All Rights Reserved.
  * Author: Amir Goldstein <amir73il@gmail.com>
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
=20
 /*
diff --git a/src/t_encrypted_d_revalidate.c b/src/t_encrypted_d_revalidat=
e.c
index 2cfd9834d2f1..cbe692c7031a 100644
--- a/src/t_encrypted_d_revalidate.c
+++ b/src/t_encrypted_d_revalidate.c
@@ -1,4 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
+ * Copyright (c) 2017 Google, Inc.  All Rights Reserved.
+ * Author: Eric Biggers <ebiggers@google.com>
+ *
  * t_encrypted_d_revalidate
  *
  * Test that ->d_revalidate() for encrypted dentries doesn't oops the
@@ -8,25 +12,6 @@
  * lookup in d_revalidate").
  *
  * This doesn't always reproduce reliably, but we give it a few seconds.
- *
- * ---------------------------------------------------------------------=
-------
- *
- * Copyright (c) 2017 Google, Inc.  All Rights Reserved.
- *
- * Author: Eric Biggers <ebiggers@google.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public Licence as published by
- * the Free Software Foundation; either version 2 of the Licence, or (at
- * your option) any later version.
- *
- * This program is distributed in the hope that it would be useful, but
- * WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
=20
 #include <errno.h>
diff --git a/src/t_futimens.c b/src/t_futimens.c
index 0c48e945ed26..a5d36e473f04 100644
--- a/src/t_futimens.c
+++ b/src/t_futimens.c
@@ -1,13 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Check ctime updates when calling futimens without UTIME_OMIT for the
  * mtime entry.
- *
  * Copyright (c) 2009 Eric Blake <ebb9@byu.net>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
  */
 #include <fcntl.h>
 #include <unistd.h>
diff --git a/src/t_holes.c b/src/t_holes.c
index 4424335a9c7c..116665d0b6f5 100644
--- a/src/t_holes.c
+++ b/src/t_holes.c
@@ -1,18 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2010 Silicon Graphics, Inc.  All Rights Reserved.
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
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/t_immutable.c b/src/t_immutable.c
index 7a7195e43f88..9a4e0169ec60 100644
--- a/src/t_immutable.c
+++ b/src/t_immutable.c
@@ -1,23 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0+
 /* compile with: gcc -g -O0 -Wall -I/usr/include/xfs -o t_immutable t_im=
mutable.c -lhandle -lacl -lattr */
=20
 /*
  *  t_immutable.c - hideous test suite for immutable/append-only flags.
- *
  *  Copyright (C) 2003 Ethan Benson
- *
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
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-130=
7, USA.
  */
=20
 #define TEST_UTIME
diff --git a/src/t_mmap_writev.c b/src/t_mmap_writev.c
index e5ca08ab98dc..d10730164c2f 100644
--- a/src/t_mmap_writev.c
+++ b/src/t_mmap_writev.c
@@ -1,24 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
-    mmap() a file and writev() back to another file
-         - kernel bug #22452 testcase
-
-    Copyright (C) 2010
-         by D.Buczek - Max Planck Institute for Molecular Genetics Berli=
n
-
-    This program is free software; you can redistribute it and/or modify
-    it under the terms of the GNU General Public License as published by
-    the Free Software Foundation; either version 2 of the License, or
-    (at your option) any later version.
-
-    This program is distributed in the hope that it will be useful,
-    but WITHOUT ANY WARRANTY; without even the implied warranty of
-    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-    GNU General Public License for more details.
-
-    You should have received a copy of the GNU General Public License al=
ong
-    with this program; if not, write to the Free Software Foundation, In=
c.,
-    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-*/
+ * Copyright (C) 2010
+ *	by D.Buczek - Max Planck Institute for Molecular Genetics Berlin
+ *
+ * mmap() a file and writev() back to another file
+ *	- kernel bug #22452 testcase
+ */
=20
 #include <sys/types.h>
 #include <fcntl.h>
diff --git a/src/t_stripealign.c b/src/t_stripealign.c
index 05ed36b5ba36..3c004b306629 100644
--- a/src/t_stripealign.c
+++ b/src/t_stripealign.c
@@ -1,14 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * t_stripealign.c
- *
  * Print whether the file start block is stripe-aligned.
- *
  * Copyright (c) 2010 Eric Sandeen <sandeen@sandeen.net>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
  */
 #include <unistd.h>
 #include <stdlib.h>
diff --git a/src/t_truncate_cmtime.c b/src/t_truncate_cmtime.c
index 4b28c2b5cd33..4c5d3c01b9f4 100644
--- a/src/t_truncate_cmtime.c
+++ b/src/t_truncate_cmtime.c
@@ -1,20 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Test ctime and mtime are updated on truncate(2) and ftruncate(2)
- *
  * Copyright (c) 2013 Red Hat, Inc.  All Rights Reserved.
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
=20
 #include <sys/stat.h>
diff --git a/src/test-nextquota.c b/src/test-nextquota.c
index 73c63d838914..9c97c99ea076 100644
--- a/src/test-nextquota.c
+++ b/src/test-nextquota.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2016 Red Hat, Inc.
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
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/src/trunc.c b/src/trunc.c
index 2b35d1ef3759..5f940b66a963 100644
--- a/src/trunc.c
+++ b/src/trunc.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2003 Silicon Graphics, Inc.
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
=20
 #include <unistd.h>
diff --git a/src/truncfile.c b/src/truncfile.c
index 4130e2dd98e1..1cf82064f450 100644
--- a/src/truncfile.c
+++ b/src/truncfile.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2001 Silicon Graphics, Inc.
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
 =20
 #include "global.h"
diff --git a/src/usemem.c b/src/usemem.c
index b8794a6b209c..2671016ed874 100644
--- a/src/usemem.c
+++ b/src/usemem.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2001 Silicon Graphics, Inc.
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
 =20
 /*
diff --git a/src/writemod.c b/src/writemod.c
index 16b3fa0c2dd3..18e30876c837 100644
--- a/src/writemod.c
+++ b/src/writemod.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2004 Silicon Graphics, Inc.
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
=20
 /*
diff --git a/src/writev_on_pagefault.c b/src/writev_on_pagefault.c
index eaa0c4ba5f19..e45ac485d784 100644
--- a/src/writev_on_pagefault.c
+++ b/src/writev_on_pagefault.c
@@ -1,21 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0+
 /*
  * Takes page fault while writev is iterating over the vectors in the IO=
V
- *
  * Copyright (C) 2017 Red Hat, Inc. All Rights reserved.
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
- * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA  02111-1307=
, USA.
  */
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/src/xfsctl.c b/src/xfsctl.c
index bf2a873a1457..4c0b098800a3 100644
--- a/src/xfsctl.c
+++ b/src/xfsctl.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2003 Silicon Graphics, Inc.
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
=20
 #include <stdlib.h>
--=20
2.17.0

