Received: from ipmail01.adl2.internode.on.net ([150.101.137.133]:49495 "EHLO
        ipmail01.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754175AbeFTCE2 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Jun 2018 22:04:28 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fVSTr-0006Pw-64
        for fstests@vger.kernel.org; Wed, 20 Jun 2018 12:04:19 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fVSTr-0003tb-58
        for fstests@vger.kernel.org; Wed, 20 Jun 2018 12:04:19 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 1/6] dmapi: spdx license conversion
Date: Wed, 20 Jun 2018 12:04:12 +1000
Message-Id: <20180620020417.14581-2-david@fromorbit.com>
In-Reply-To: <20180620020417.14581-1-david@fromorbit.com>
References: <20180620020417.14581-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Scripted like all the others.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 dmapi/Makefile                                 | 16 +---------------
 dmapi/src/Makefile                             | 16 +---------------
 dmapi/src/common/Makefile                      | 16 +---------------
 dmapi/src/common/cmd/Makefile                  | 16 +---------------
 dmapi/src/common/cmd/read_invis.c              | 14 +-------------
 dmapi/src/common/cmd/set_region.c              | 14 +-------------
 dmapi/src/common/cmd/set_return_on_destroy.c   | 14 +-------------
 dmapi/src/common/cmd/write_invis.c             | 14 +-------------
 dmapi/src/common/lib/Makefile                  | 16 +---------------
 dmapi/src/common/lib/dmport.h                  | 14 +-------------
 dmapi/src/common/lib/find_session.c            | 14 +-------------
 dmapi/src/common/lib/print.c                   | 14 +-------------
 dmapi/src/common/lib/stubs.c                   | 14 +-------------
 dmapi/src/sample_hsm/Makefile                  | 16 +---------------
 dmapi/src/simple/Makefile                      | 16 +---------------
 dmapi/src/simple/dm_create_session.c           | 14 +-------------
 dmapi/src/simple/dm_destroy_session.c          | 14 +-------------
 dmapi/src/simple/dm_find_eventmsg.c            | 14 +-------------
 dmapi/src/simple/dm_getall_sessions.c          | 14 +-------------
 dmapi/src/simple/dm_getall_tokens.c            | 14 +-------------
 dmapi/src/simple/dm_query_session.c            | 14 +-------------
 dmapi/src/suite1/Makefile                      | 16 +---------------
 dmapi/src/suite1/cmd/Makefile                  | 16 +---------------
 dmapi/src/suite1/cmd/create_userevent.c        | 14 +-------------
 dmapi/src/suite1/cmd/dm_handle.c               | 14 +-------------
 dmapi/src/suite1/cmd/downgrade_right.c         | 14 +-------------
 dmapi/src/suite1/cmd/fd_to_handle.c            | 14 +-------------
 dmapi/src/suite1/cmd/get_allocinfo.c           | 14 +-------------
 dmapi/src/suite1/cmd/get_config_events.c       | 14 +-------------
 dmapi/src/suite1/cmd/get_dirattrs.c            | 14 +-------------
 dmapi/src/suite1/cmd/get_dmattr.c              | 14 +-------------
 dmapi/src/suite1/cmd/get_eventlist.c           | 14 +-------------
 dmapi/src/suite1/cmd/get_events.c              | 14 +-------------
 dmapi/src/suite1/cmd/get_fileattr.c            | 14 +-------------
 dmapi/src/suite1/cmd/get_mountinfo.c           | 14 +-------------
 dmapi/src/suite1/cmd/get_region.c              | 14 +-------------
 dmapi/src/suite1/cmd/getall_disp.c             | 14 +-------------
 dmapi/src/suite1/cmd/getall_dmattr.c           | 14 +-------------
 dmapi/src/suite1/cmd/handle_to_fshandle.c      | 14 +-------------
 dmapi/src/suite1/cmd/handle_to_path.c          | 14 +-------------
 dmapi/src/suite1/cmd/init_service.c            | 14 +-------------
 dmapi/src/suite1/cmd/link_test.c               | 14 +-------------
 dmapi/src/suite1/cmd/make_rt_sparse.c          | 14 +-------------
 dmapi/src/suite1/cmd/make_sparse.c             | 14 +-------------
 dmapi/src/suite1/cmd/obj_ref_hold.c            | 14 +-------------
 dmapi/src/suite1/cmd/obj_ref_query.c           | 14 +-------------
 dmapi/src/suite1/cmd/obj_ref_rele.c            | 14 +-------------
 dmapi/src/suite1/cmd/path_to_fshandle.c        | 14 +-------------
 dmapi/src/suite1/cmd/path_to_handle.c          | 14 +-------------
 dmapi/src/suite1/cmd/pending.c                 | 14 +-------------
 dmapi/src/suite1/cmd/print_fshandle.c          | 14 +-------------
 dmapi/src/suite1/cmd/probe_hole.c              | 14 +-------------
 dmapi/src/suite1/cmd/probe_punch_xfsctl_hole.c | 14 +-------------
 dmapi/src/suite1/cmd/punch_hole.c              | 14 +-------------
 dmapi/src/suite1/cmd/query_right.c             | 14 +-------------
 dmapi/src/suite1/cmd/randomize_file.c          | 14 +-------------
 dmapi/src/suite1/cmd/release_right.c           | 14 +-------------
 dmapi/src/suite1/cmd/remove_dmattr.c           | 14 +-------------
 dmapi/src/suite1/cmd/request_right.c           | 14 +-------------
 dmapi/src/suite1/cmd/respond_event.c           | 14 +-------------
 dmapi/src/suite1/cmd/rwt.c                     | 14 +-------------
 dmapi/src/suite1/cmd/security_hole.c           | 14 +-------------
 dmapi/src/suite1/cmd/security_hole2.c          | 14 +-------------
 dmapi/src/suite1/cmd/set_disp.c                | 14 +-------------
 dmapi/src/suite1/cmd/set_dmattr.c              | 14 +-------------
 dmapi/src/suite1/cmd/set_eventlist.c           | 14 +-------------
 dmapi/src/suite1/cmd/set_fileattr.c            | 14 +-------------
 dmapi/src/suite1/cmd/struct_test.c             | 14 +-------------
 dmapi/src/suite1/cmd/sync_by_handle.c          | 14 +-------------
 dmapi/src/suite1/cmd/test_assumption.c         | 14 +-------------
 dmapi/src/suite1/cmd/upgrade_right.c           | 14 +-------------
 dmapi/src/suite2/Makefile                      | 16 +---------------
 dmapi/src/suite2/lib/errtest.h                 | 14 +-------------
 dmapi/src/suite2/src/Makefile                  | 16 +---------------
 dmapi/src/suite2/src/check_dmapi.c             | 14 +-------------
 dmapi/src/suite2/src/invis_test.c              | 14 +-------------
 dmapi/src/suite2/src/mm_fill.c                 | 14 +-------------
 dmapi/src/suite2/src/mmap.c                    | 14 +-------------
 dmapi/src/suite2/src/mmap_cp.c                 | 14 +-------------
 dmapi/src/suite2/src/region_test.c             | 14 +-------------
 dmapi/src/suite2/src/send_msg.c                | 14 +-------------
 dmapi/src/suite2/src/test_dmattr.c             | 14 +-------------
 dmapi/src/suite2/src/test_efault.c             | 14 +-------------
 dmapi/src/suite2/src/test_eventlist.c          | 14 +-------------
 dmapi/src/suite2/src/test_fileattr.c           | 14 +-------------
 dmapi/src/suite2/src/test_hole.c               | 14 +-------------
 dmapi/src/suite2/src/test_invis.c              | 14 +-------------
 dmapi/src/suite2/src/test_region.c             | 14 +-------------
 dmapi/src/suite2/src/test_rights.c             | 14 +-------------
 89 files changed, 89 insertions(+), 1179 deletions(-)

diff --git a/dmapi/Makefile b/dmapi/Makefile
index 104dc53b5200..88da5b30dcde 100644
--- a/dmapi/Makefile
+++ b/dmapi/Makefile
@@ -1,22 +1,8 @@
-#
+# SPDX-License-Identifier: GPL-2.0+
 # Copyright (C) 2011 SGI  All Rights Reserved.
 #
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
 #
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-# 02110-1301, USA.
 #
-
 TOPDIR = ..
 
 include $(TOPDIR)/include/builddefs
diff --git a/dmapi/src/Makefile b/dmapi/src/Makefile
index d3e157d5df9f..6220b9689049 100644
--- a/dmapi/src/Makefile
+++ b/dmapi/src/Makefile
@@ -1,22 +1,8 @@
-#
+# SPDX-License-Identifier: GPL-2.0+
 # Copyright (C) 2011 SGI  All Rights Reserved.
 #
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
 #
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-# 02110-1301, USA.
 #
-
 TOPDIR = ../..
 
 include $(TOPDIR)/include/builddefs
diff --git a/dmapi/src/common/Makefile b/dmapi/src/common/Makefile
index 12c94afd6527..04413241c2e6 100644
--- a/dmapi/src/common/Makefile
+++ b/dmapi/src/common/Makefile
@@ -1,22 +1,8 @@
-#
+# SPDX-License-Identifier: GPL-2.0+
 # Copyright (C) 2011 SGI  All Rights Reserved.
 #
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
 #
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-# 02110-1301, USA.
 #
-
 TOPDIR = ../../..
 
 include $(TOPDIR)/include/builddefs
diff --git a/dmapi/src/common/cmd/Makefile b/dmapi/src/common/cmd/Makefile
index 4525581d2d86..909f13934977 100644
--- a/dmapi/src/common/cmd/Makefile
+++ b/dmapi/src/common/cmd/Makefile
@@ -1,22 +1,8 @@
-#
+# SPDX-License-Identifier: GPL-2.0+
 # Copyright (C) 2011 SGI  All Rights Reserved.
 #
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
 #
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-# 02110-1301, USA.
 #
-
 TOPDIR = ../../../..
 
 include $(TOPDIR)/include/builddefs
diff --git a/dmapi/src/common/cmd/read_invis.c b/dmapi/src/common/cmd/read_invis.c
index 53fd3d315fa8..4ea3c057bf98 100644
--- a/dmapi/src/common/cmd/read_invis.c
+++ b/dmapi/src/common/cmd/read_invis.c
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
 
 #include <ctype.h>
diff --git a/dmapi/src/common/cmd/set_region.c b/dmapi/src/common/cmd/set_region.c
index cfe5429657b7..c0ac28cca24c 100644
--- a/dmapi/src/common/cmd/set_region.c
+++ b/dmapi/src/common/cmd/set_region.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/common/cmd/set_return_on_destroy.c b/dmapi/src/common/cmd/set_return_on_destroy.c
index a85e9205ed2d..078cc93770c5 100644
--- a/dmapi/src/common/cmd/set_return_on_destroy.c
+++ b/dmapi/src/common/cmd/set_return_on_destroy.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/common/cmd/write_invis.c b/dmapi/src/common/cmd/write_invis.c
index b0b2af6216b8..aab74e8a1f8a 100644
--- a/dmapi/src/common/cmd/write_invis.c
+++ b/dmapi/src/common/cmd/write_invis.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/common/lib/Makefile b/dmapi/src/common/lib/Makefile
index a2ed2e3a3c0b..463bf78b59aa 100644
--- a/dmapi/src/common/lib/Makefile
+++ b/dmapi/src/common/lib/Makefile
@@ -1,22 +1,8 @@
-#
+# SPDX-License-Identifier: GPL-2.0+
 # Copyright (C) 2011 SGI  All Rights Reserved.
 #
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
 #
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-# 02110-1301, USA.
 #
-
 TOPDIR = ../../../..
 
 include $(TOPDIR)/include/builddefs
diff --git a/dmapi/src/common/lib/dmport.h b/dmapi/src/common/lib/dmport.h
index 253ed5bd1bac..0aac506ae65d 100644
--- a/dmapi/src/common/lib/dmport.h
+++ b/dmapi/src/common/lib/dmport.h
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
 
 #ifndef	_DMFSAPI_DMPORT_H
diff --git a/dmapi/src/common/lib/find_session.c b/dmapi/src/common/lib/find_session.c
index e15fe7e3ca99..01a7af3beef0 100644
--- a/dmapi/src/common/lib/find_session.c
+++ b/dmapi/src/common/lib/find_session.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/common/lib/print.c b/dmapi/src/common/lib/print.c
index 384ba9ce8835..f6c4a04bb30c 100644
--- a/dmapi/src/common/lib/print.c
+++ b/dmapi/src/common/lib/print.c
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
 
 #include <sys/types.h>
diff --git a/dmapi/src/common/lib/stubs.c b/dmapi/src/common/lib/stubs.c
index 0c4965b30ebd..c6588a0b2dbd 100644
--- a/dmapi/src/common/lib/stubs.c
+++ b/dmapi/src/common/lib/stubs.c
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
 
 #include <errno.h>
diff --git a/dmapi/src/sample_hsm/Makefile b/dmapi/src/sample_hsm/Makefile
index 55df563df3d9..3c812fd42261 100644
--- a/dmapi/src/sample_hsm/Makefile
+++ b/dmapi/src/sample_hsm/Makefile
@@ -1,22 +1,8 @@
-#
+# SPDX-License-Identifier: GPL-2.0+
 # Copyright (C) 2011 SGI  All Rights Reserved.
 #
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
 #
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-# 02110-1301, USA.
 #
-
 TOPDIR = ../../..
 
 include $(TOPDIR)/include/builddefs
diff --git a/dmapi/src/simple/Makefile b/dmapi/src/simple/Makefile
index 938bbe1351ce..7c4183210035 100644
--- a/dmapi/src/simple/Makefile
+++ b/dmapi/src/simple/Makefile
@@ -1,22 +1,8 @@
-#
+# SPDX-License-Identifier: GPL-2.0+
 # Copyright (C) 2011 SGI  All Rights Reserved.
 #
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
 #
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-# 02110-1301, USA.
 #
-
 TOPDIR = ../../..
 
 include $(TOPDIR)/include/builddefs
diff --git a/dmapi/src/simple/dm_create_session.c b/dmapi/src/simple/dm_create_session.c
index 95c914d15a2e..ec76888ec8a4 100644
--- a/dmapi/src/simple/dm_create_session.c
+++ b/dmapi/src/simple/dm_create_session.c
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
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/dmapi/src/simple/dm_destroy_session.c b/dmapi/src/simple/dm_destroy_session.c
index 0b28f8fc172f..1a6da4b9264a 100644
--- a/dmapi/src/simple/dm_destroy_session.c
+++ b/dmapi/src/simple/dm_destroy_session.c
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
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/dmapi/src/simple/dm_find_eventmsg.c b/dmapi/src/simple/dm_find_eventmsg.c
index dab49df5c0a2..0765eb0f8613 100644
--- a/dmapi/src/simple/dm_find_eventmsg.c
+++ b/dmapi/src/simple/dm_find_eventmsg.c
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
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/dmapi/src/simple/dm_getall_sessions.c b/dmapi/src/simple/dm_getall_sessions.c
index a822de79adb4..d762f7561e1e 100644
--- a/dmapi/src/simple/dm_getall_sessions.c
+++ b/dmapi/src/simple/dm_getall_sessions.c
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
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/dmapi/src/simple/dm_getall_tokens.c b/dmapi/src/simple/dm_getall_tokens.c
index 0a7141e40cfc..de813c7fbb1a 100644
--- a/dmapi/src/simple/dm_getall_tokens.c
+++ b/dmapi/src/simple/dm_getall_tokens.c
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
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/dmapi/src/simple/dm_query_session.c b/dmapi/src/simple/dm_query_session.c
index dc4f116601e0..795418f04f03 100644
--- a/dmapi/src/simple/dm_query_session.c
+++ b/dmapi/src/simple/dm_query_session.c
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
 #include <stdlib.h>
 #include <stdio.h>
diff --git a/dmapi/src/suite1/Makefile b/dmapi/src/suite1/Makefile
index 9ce531e2df0a..3bfaf7a5f846 100644
--- a/dmapi/src/suite1/Makefile
+++ b/dmapi/src/suite1/Makefile
@@ -1,22 +1,8 @@
-#
+# SPDX-License-Identifier: GPL-2.0+
 # Copyright (C) 2011 SGI  All Rights Reserved.
 #
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
 #
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-# 02110-1301, USA.
 #
-
 TOPDIR = ../../..
 
 include $(TOPDIR)/include/builddefs
diff --git a/dmapi/src/suite1/cmd/Makefile b/dmapi/src/suite1/cmd/Makefile
index 05dbead7ca30..f185a7aac679 100644
--- a/dmapi/src/suite1/cmd/Makefile
+++ b/dmapi/src/suite1/cmd/Makefile
@@ -1,22 +1,8 @@
-#
+# SPDX-License-Identifier: GPL-2.0+
 # Copyright (C) 2011 SGI  All Rights Reserved.
 #
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
 #
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-# 02110-1301, USA.
 #
-
 TOPDIR = ../../../..
 
 include $(TOPDIR)/include/builddefs
diff --git a/dmapi/src/suite1/cmd/create_userevent.c b/dmapi/src/suite1/cmd/create_userevent.c
index 35cb2f27a777..23faf8940bf4 100644
--- a/dmapi/src/suite1/cmd/create_userevent.c
+++ b/dmapi/src/suite1/cmd/create_userevent.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/dm_handle.c b/dmapi/src/suite1/cmd/dm_handle.c
index 6ad9a92c3c45..2ba7239dcf41 100644
--- a/dmapi/src/suite1/cmd/dm_handle.c
+++ b/dmapi/src/suite1/cmd/dm_handle.c
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
 
 #include <sys/types.h>
diff --git a/dmapi/src/suite1/cmd/downgrade_right.c b/dmapi/src/suite1/cmd/downgrade_right.c
index 96a4bb7a805f..d8ddfbbd2978 100644
--- a/dmapi/src/suite1/cmd/downgrade_right.c
+++ b/dmapi/src/suite1/cmd/downgrade_right.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/fd_to_handle.c b/dmapi/src/suite1/cmd/fd_to_handle.c
index 6d6f84349ecb..fa6895f7df3b 100644
--- a/dmapi/src/suite1/cmd/fd_to_handle.c
+++ b/dmapi/src/suite1/cmd/fd_to_handle.c
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
 
 /* Given a file object's pathname, print the object's handle. */
diff --git a/dmapi/src/suite1/cmd/get_allocinfo.c b/dmapi/src/suite1/cmd/get_allocinfo.c
index 35839642a244..9dc9a717590a 100644
--- a/dmapi/src/suite1/cmd/get_allocinfo.c
+++ b/dmapi/src/suite1/cmd/get_allocinfo.c
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
 
 #include <sys/types.h>
diff --git a/dmapi/src/suite1/cmd/get_config_events.c b/dmapi/src/suite1/cmd/get_config_events.c
index d50eaa784be2..9c8a1cd65b8f 100644
--- a/dmapi/src/suite1/cmd/get_config_events.c
+++ b/dmapi/src/suite1/cmd/get_config_events.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/get_dirattrs.c b/dmapi/src/suite1/cmd/get_dirattrs.c
index a7e671ef372f..e82f4c54e148 100644
--- a/dmapi/src/suite1/cmd/get_dirattrs.c
+++ b/dmapi/src/suite1/cmd/get_dirattrs.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/get_dmattr.c b/dmapi/src/suite1/cmd/get_dmattr.c
index 9c7eabba639b..e4c03f8f745e 100644
--- a/dmapi/src/suite1/cmd/get_dmattr.c
+++ b/dmapi/src/suite1/cmd/get_dmattr.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/get_eventlist.c b/dmapi/src/suite1/cmd/get_eventlist.c
index 37ed8c46d1e2..9bfaef00d526 100644
--- a/dmapi/src/suite1/cmd/get_eventlist.c
+++ b/dmapi/src/suite1/cmd/get_eventlist.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/get_events.c b/dmapi/src/suite1/cmd/get_events.c
index 55ae09b0e99d..b2f947d73d5d 100644
--- a/dmapi/src/suite1/cmd/get_events.c
+++ b/dmapi/src/suite1/cmd/get_events.c
@@ -1,19 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (c) 2000-2005 Silicon Graphics, Inc.
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/get_fileattr.c b/dmapi/src/suite1/cmd/get_fileattr.c
index e3ab024443d8..85d09244fe86 100644
--- a/dmapi/src/suite1/cmd/get_fileattr.c
+++ b/dmapi/src/suite1/cmd/get_fileattr.c
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
 
 #include <sys/types.h>
diff --git a/dmapi/src/suite1/cmd/get_mountinfo.c b/dmapi/src/suite1/cmd/get_mountinfo.c
index 33fdf8366d36..55bef1ab749d 100644
--- a/dmapi/src/suite1/cmd/get_mountinfo.c
+++ b/dmapi/src/suite1/cmd/get_mountinfo.c
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
 
 #include <sys/types.h>
diff --git a/dmapi/src/suite1/cmd/get_region.c b/dmapi/src/suite1/cmd/get_region.c
index 997faab28636..47f3d0d2a84e 100644
--- a/dmapi/src/suite1/cmd/get_region.c
+++ b/dmapi/src/suite1/cmd/get_region.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/getall_disp.c b/dmapi/src/suite1/cmd/getall_disp.c
index ef676b25ffa5..32ce6a76291f 100644
--- a/dmapi/src/suite1/cmd/getall_disp.c
+++ b/dmapi/src/suite1/cmd/getall_disp.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/getall_dmattr.c b/dmapi/src/suite1/cmd/getall_dmattr.c
index 56f2248d04cf..758b8c41dd31 100644
--- a/dmapi/src/suite1/cmd/getall_dmattr.c
+++ b/dmapi/src/suite1/cmd/getall_dmattr.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/handle_to_fshandle.c b/dmapi/src/suite1/cmd/handle_to_fshandle.c
index 93f101d51e34..405e6b6ef6d2 100644
--- a/dmapi/src/suite1/cmd/handle_to_fshandle.c
+++ b/dmapi/src/suite1/cmd/handle_to_fshandle.c
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
 
 /* Given an object's handle, print the filesystem handle. */
diff --git a/dmapi/src/suite1/cmd/handle_to_path.c b/dmapi/src/suite1/cmd/handle_to_path.c
index b3759e124b56..749eed1fe6bd 100644
--- a/dmapi/src/suite1/cmd/handle_to_path.c
+++ b/dmapi/src/suite1/cmd/handle_to_path.c
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
 
 #include <errno.h>
diff --git a/dmapi/src/suite1/cmd/init_service.c b/dmapi/src/suite1/cmd/init_service.c
index 6c7afa447bc2..a010c4b9ead9 100644
--- a/dmapi/src/suite1/cmd/init_service.c
+++ b/dmapi/src/suite1/cmd/init_service.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/link_test.c b/dmapi/src/suite1/cmd/link_test.c
index 19ffaa81959e..fab1b4f10efe 100644
--- a/dmapi/src/suite1/cmd/link_test.c
+++ b/dmapi/src/suite1/cmd/link_test.c
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
 
 #include <stdlib.h>
diff --git a/dmapi/src/suite1/cmd/make_rt_sparse.c b/dmapi/src/suite1/cmd/make_rt_sparse.c
index 1047e8742e5c..14ee8a0daf72 100644
--- a/dmapi/src/suite1/cmd/make_rt_sparse.c
+++ b/dmapi/src/suite1/cmd/make_rt_sparse.c
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
 
 /*
diff --git a/dmapi/src/suite1/cmd/make_sparse.c b/dmapi/src/suite1/cmd/make_sparse.c
index ead7390e2d9d..76bc7b245106 100644
--- a/dmapi/src/suite1/cmd/make_sparse.c
+++ b/dmapi/src/suite1/cmd/make_sparse.c
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
 
 /*
diff --git a/dmapi/src/suite1/cmd/obj_ref_hold.c b/dmapi/src/suite1/cmd/obj_ref_hold.c
index 771deb437303..0fb2a79bd7ca 100644
--- a/dmapi/src/suite1/cmd/obj_ref_hold.c
+++ b/dmapi/src/suite1/cmd/obj_ref_hold.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/obj_ref_query.c b/dmapi/src/suite1/cmd/obj_ref_query.c
index f85716fae1f2..34deb62c822c 100644
--- a/dmapi/src/suite1/cmd/obj_ref_query.c
+++ b/dmapi/src/suite1/cmd/obj_ref_query.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/obj_ref_rele.c b/dmapi/src/suite1/cmd/obj_ref_rele.c
index 1c39b90a3def..31a3d6793c66 100644
--- a/dmapi/src/suite1/cmd/obj_ref_rele.c
+++ b/dmapi/src/suite1/cmd/obj_ref_rele.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/path_to_fshandle.c b/dmapi/src/suite1/cmd/path_to_fshandle.c
index 16563d9a3628..eef9de7af033 100644
--- a/dmapi/src/suite1/cmd/path_to_fshandle.c
+++ b/dmapi/src/suite1/cmd/path_to_fshandle.c
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
 
 /* Given a file object's pathname, print the filesystem handle. */
diff --git a/dmapi/src/suite1/cmd/path_to_handle.c b/dmapi/src/suite1/cmd/path_to_handle.c
index 546415c1c558..b2d3d9da074e 100644
--- a/dmapi/src/suite1/cmd/path_to_handle.c
+++ b/dmapi/src/suite1/cmd/path_to_handle.c
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
 
 /* Given a file object's pathname, print the object's handle. */
diff --git a/dmapi/src/suite1/cmd/pending.c b/dmapi/src/suite1/cmd/pending.c
index 827b61ee8ea2..81e0697da5bc 100644
--- a/dmapi/src/suite1/cmd/pending.c
+++ b/dmapi/src/suite1/cmd/pending.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/print_fshandle.c b/dmapi/src/suite1/cmd/print_fshandle.c
index 86aeb07b957c..d85cd280e6d9 100644
--- a/dmapi/src/suite1/cmd/print_fshandle.c
+++ b/dmapi/src/suite1/cmd/print_fshandle.c
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
 
 /* Given a file pathname, print the filesystem handle and the uuid_t for
diff --git a/dmapi/src/suite1/cmd/probe_hole.c b/dmapi/src/suite1/cmd/probe_hole.c
index c5f945a83191..1090e775f968 100644
--- a/dmapi/src/suite1/cmd/probe_hole.c
+++ b/dmapi/src/suite1/cmd/probe_hole.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/probe_punch_xfsctl_hole.c b/dmapi/src/suite1/cmd/probe_punch_xfsctl_hole.c
index 855c5f60dd4e..4b7d7ec760ed 100644
--- a/dmapi/src/suite1/cmd/probe_punch_xfsctl_hole.c
+++ b/dmapi/src/suite1/cmd/probe_punch_xfsctl_hole.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/punch_hole.c b/dmapi/src/suite1/cmd/punch_hole.c
index 68439a755955..fc02b5e76ba7 100644
--- a/dmapi/src/suite1/cmd/punch_hole.c
+++ b/dmapi/src/suite1/cmd/punch_hole.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/query_right.c b/dmapi/src/suite1/cmd/query_right.c
index aab4de5b9ed8..108935231b98 100644
--- a/dmapi/src/suite1/cmd/query_right.c
+++ b/dmapi/src/suite1/cmd/query_right.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/randomize_file.c b/dmapi/src/suite1/cmd/randomize_file.c
index 0c272fe587f7..a9731d5de4d7 100644
--- a/dmapi/src/suite1/cmd/randomize_file.c
+++ b/dmapi/src/suite1/cmd/randomize_file.c
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
 
 #include <sys/types.h>
diff --git a/dmapi/src/suite1/cmd/release_right.c b/dmapi/src/suite1/cmd/release_right.c
index e6a92d37a23f..28eeca3a6a65 100644
--- a/dmapi/src/suite1/cmd/release_right.c
+++ b/dmapi/src/suite1/cmd/release_right.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/remove_dmattr.c b/dmapi/src/suite1/cmd/remove_dmattr.c
index 865898d489be..52153b069a84 100644
--- a/dmapi/src/suite1/cmd/remove_dmattr.c
+++ b/dmapi/src/suite1/cmd/remove_dmattr.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/request_right.c b/dmapi/src/suite1/cmd/request_right.c
index fff3e78b68e0..5deb8b8c2e53 100644
--- a/dmapi/src/suite1/cmd/request_right.c
+++ b/dmapi/src/suite1/cmd/request_right.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/respond_event.c b/dmapi/src/suite1/cmd/respond_event.c
index bf1bb94883b2..cadd8c978a49 100644
--- a/dmapi/src/suite1/cmd/respond_event.c
+++ b/dmapi/src/suite1/cmd/respond_event.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/rwt.c b/dmapi/src/suite1/cmd/rwt.c
index c1489bdd4da2..5768a3200920 100644
--- a/dmapi/src/suite1/cmd/rwt.c
+++ b/dmapi/src/suite1/cmd/rwt.c
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
 
 #include <sys/types.h>
diff --git a/dmapi/src/suite1/cmd/security_hole.c b/dmapi/src/suite1/cmd/security_hole.c
index d34026da7d4b..bd17bcafddfb 100644
--- a/dmapi/src/suite1/cmd/security_hole.c
+++ b/dmapi/src/suite1/cmd/security_hole.c
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
 
 #include <fcntl.h>
diff --git a/dmapi/src/suite1/cmd/security_hole2.c b/dmapi/src/suite1/cmd/security_hole2.c
index 3af3395a6b2b..9e5eee7817c5 100644
--- a/dmapi/src/suite1/cmd/security_hole2.c
+++ b/dmapi/src/suite1/cmd/security_hole2.c
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
 
 #include <fcntl.h>
diff --git a/dmapi/src/suite1/cmd/set_disp.c b/dmapi/src/suite1/cmd/set_disp.c
index fee1dcedeb52..a3b019208940 100644
--- a/dmapi/src/suite1/cmd/set_disp.c
+++ b/dmapi/src/suite1/cmd/set_disp.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/set_dmattr.c b/dmapi/src/suite1/cmd/set_dmattr.c
index 4753cf445c0d..bd0677573029 100644
--- a/dmapi/src/suite1/cmd/set_dmattr.c
+++ b/dmapi/src/suite1/cmd/set_dmattr.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/set_eventlist.c b/dmapi/src/suite1/cmd/set_eventlist.c
index 857523d33dc2..fb19b2183381 100644
--- a/dmapi/src/suite1/cmd/set_eventlist.c
+++ b/dmapi/src/suite1/cmd/set_eventlist.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/set_fileattr.c b/dmapi/src/suite1/cmd/set_fileattr.c
index 70ae52f18f0c..8dfd3225ab6a 100644
--- a/dmapi/src/suite1/cmd/set_fileattr.c
+++ b/dmapi/src/suite1/cmd/set_fileattr.c
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
 
 #include <ctype.h>
diff --git a/dmapi/src/suite1/cmd/struct_test.c b/dmapi/src/suite1/cmd/struct_test.c
index 7a0dd3580738..9d3be54e90f6 100644
--- a/dmapi/src/suite1/cmd/struct_test.c
+++ b/dmapi/src/suite1/cmd/struct_test.c
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
 	
 #include <stddef.h>
diff --git a/dmapi/src/suite1/cmd/sync_by_handle.c b/dmapi/src/suite1/cmd/sync_by_handle.c
index ee2276731e72..b5319e31f695 100644
--- a/dmapi/src/suite1/cmd/sync_by_handle.c
+++ b/dmapi/src/suite1/cmd/sync_by_handle.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite1/cmd/test_assumption.c b/dmapi/src/suite1/cmd/test_assumption.c
index 98dea4c15f45..b1a37569e2e2 100644
--- a/dmapi/src/suite1/cmd/test_assumption.c
+++ b/dmapi/src/suite1/cmd/test_assumption.c
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
 
 #include <sys/types.h>
diff --git a/dmapi/src/suite1/cmd/upgrade_right.c b/dmapi/src/suite1/cmd/upgrade_right.c
index d24939122592..b3cf7517fcf7 100644
--- a/dmapi/src/suite1/cmd/upgrade_right.c
+++ b/dmapi/src/suite1/cmd/upgrade_right.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite2/Makefile b/dmapi/src/suite2/Makefile
index 36aa819ac69b..fd85059cd13d 100644
--- a/dmapi/src/suite2/Makefile
+++ b/dmapi/src/suite2/Makefile
@@ -1,22 +1,8 @@
-#
+# SPDX-License-Identifier: GPL-2.0+
 # Copyright (C) 2011 SGI  All Rights Reserved.
 #
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
 #
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-# 02110-1301, USA.
 #
-
 TOPDIR = ../../..
 
 include $(TOPDIR)/include/builddefs
diff --git a/dmapi/src/suite2/lib/errtest.h b/dmapi/src/suite2/lib/errtest.h
index a618d6719680..c70be672df9f 100644
--- a/dmapi/src/suite2/lib/errtest.h
+++ b/dmapi/src/suite2/lib/errtest.h
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
 #ifndef __ERRTEST_SEEN
 #define __ERRTEST_SEEN
diff --git a/dmapi/src/suite2/src/Makefile b/dmapi/src/suite2/src/Makefile
index c5cf6da9681e..9cd434e22f65 100644
--- a/dmapi/src/suite2/src/Makefile
+++ b/dmapi/src/suite2/src/Makefile
@@ -1,22 +1,8 @@
-#
+# SPDX-License-Identifier: GPL-2.0+
 # Copyright (C) 2011 SGI  All Rights Reserved.
 #
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License as
-# published by the Free Software Foundation; either version 2 of the
-# License, or (at your option) any later version.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-# General Public License for more details.
 #
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-# 02110-1301, USA.
 #
-
 TOPDIR = ../../../..
 
 include $(TOPDIR)/include/builddefs
diff --git a/dmapi/src/suite2/src/check_dmapi.c b/dmapi/src/suite2/src/check_dmapi.c
index ad0193117cb7..9c7080f43498 100644
--- a/dmapi/src/suite2/src/check_dmapi.c
+++ b/dmapi/src/suite2/src/check_dmapi.c
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
 
 #include <sys/types.h>
diff --git a/dmapi/src/suite2/src/invis_test.c b/dmapi/src/suite2/src/invis_test.c
index 6946b058cdd3..a210f8164a74 100644
--- a/dmapi/src/suite2/src/invis_test.c
+++ b/dmapi/src/suite2/src/invis_test.c
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
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/dmapi/src/suite2/src/mm_fill.c b/dmapi/src/suite2/src/mm_fill.c
index 451e8f142bca..18dbc39f28e5 100644
--- a/dmapi/src/suite2/src/mm_fill.c
+++ b/dmapi/src/suite2/src/mm_fill.c
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
 /*
  *      mmap_fill
diff --git a/dmapi/src/suite2/src/mmap.c b/dmapi/src/suite2/src/mmap.c
index 0f8f0b193c4d..974c01bd6d58 100644
--- a/dmapi/src/suite2/src/mmap.c
+++ b/dmapi/src/suite2/src/mmap.c
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
 /*
  *	This routine simulates
diff --git a/dmapi/src/suite2/src/mmap_cp.c b/dmapi/src/suite2/src/mmap_cp.c
index bd3d7b3e319b..9b71173517a4 100644
--- a/dmapi/src/suite2/src/mmap_cp.c
+++ b/dmapi/src/suite2/src/mmap_cp.c
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
 /*
  *      mmap_fill
diff --git a/dmapi/src/suite2/src/region_test.c b/dmapi/src/suite2/src/region_test.c
index f8b28683e0a7..fb965cf3b606 100644
--- a/dmapi/src/suite2/src/region_test.c
+++ b/dmapi/src/suite2/src/region_test.c
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
 
 #include <sys/types.h>
diff --git a/dmapi/src/suite2/src/send_msg.c b/dmapi/src/suite2/src/send_msg.c
index 3f07d06fa621..fca05b97cbd2 100644
--- a/dmapi/src/suite2/src/send_msg.c
+++ b/dmapi/src/suite2/src/send_msg.c
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
 
 #include <sys/types.h>
diff --git a/dmapi/src/suite2/src/test_dmattr.c b/dmapi/src/suite2/src/test_dmattr.c
index a8a05958003f..f1f05a41ff83 100644
--- a/dmapi/src/suite2/src/test_dmattr.c
+++ b/dmapi/src/suite2/src/test_dmattr.c
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
 
 #include <unistd.h>
diff --git a/dmapi/src/suite2/src/test_efault.c b/dmapi/src/suite2/src/test_efault.c
index 83f69b2981b6..39160db70356 100644
--- a/dmapi/src/suite2/src/test_efault.c
+++ b/dmapi/src/suite2/src/test_efault.c
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
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/dmapi/src/suite2/src/test_eventlist.c b/dmapi/src/suite2/src/test_eventlist.c
index 2257f4424cf7..99a8474ec60f 100644
--- a/dmapi/src/suite2/src/test_eventlist.c
+++ b/dmapi/src/suite2/src/test_eventlist.c
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
 
 #include <lib/hsm.h>
diff --git a/dmapi/src/suite2/src/test_fileattr.c b/dmapi/src/suite2/src/test_fileattr.c
index ff8da833612c..9d718bbebc20 100644
--- a/dmapi/src/suite2/src/test_fileattr.c
+++ b/dmapi/src/suite2/src/test_fileattr.c
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
 
 #include <sys/types.h>
diff --git a/dmapi/src/suite2/src/test_hole.c b/dmapi/src/suite2/src/test_hole.c
index 3c2c4fcd1eca..58c4bd0ede60 100644
--- a/dmapi/src/suite2/src/test_hole.c
+++ b/dmapi/src/suite2/src/test_hole.c
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
 
 #include <sys/types.h>
diff --git a/dmapi/src/suite2/src/test_invis.c b/dmapi/src/suite2/src/test_invis.c
index 7266713e27fa..2f2a83f039b8 100644
--- a/dmapi/src/suite2/src/test_invis.c
+++ b/dmapi/src/suite2/src/test_invis.c
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
 
 #include <sys/types.h>
diff --git a/dmapi/src/suite2/src/test_region.c b/dmapi/src/suite2/src/test_region.c
index 7bdb0bfd26a8..e4dad7fedff7 100644
--- a/dmapi/src/suite2/src/test_region.c
+++ b/dmapi/src/suite2/src/test_region.c
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
 
 #include <sys/types.h>
diff --git a/dmapi/src/suite2/src/test_rights.c b/dmapi/src/suite2/src/test_rights.c
index 1198e0a8e689..175f04e84af5 100644
--- a/dmapi/src/suite2/src/test_rights.c
+++ b/dmapi/src/suite2/src/test_rights.c
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
 #include <sys/types.h>
 #include <sys/stat.h>
-- 
2.17.0

