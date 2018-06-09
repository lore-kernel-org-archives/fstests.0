Received: from ipmail01.adl6.internode.on.net ([150.101.137.136]:32241 "EHLO
        ipmail01.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752685AbeFIBzs (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Jun 2018 21:55:48 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fRT6V-0007Xz-NT
        for fstests@vger.kernel.org; Sat, 09 Jun 2018 11:55:43 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fRT6V-0005Bo-M0
        for fstests@vger.kernel.org; Sat, 09 Jun 2018 11:55:43 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/9] common: convert to SPDX license tags
Date: Sat,  9 Jun 2018 11:55:33 +1000
Message-Id: <20180609015540.19385-3-david@fromorbit.com>
In-Reply-To: <20180609015540.19385-1-david@fromorbit.com>
References: <20180609015540.19385-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

These have been scripted conversions then cleaned up by hand as
there was no consistency to the formatting of the license headers in
the common/ directory. Author information was also removed (it's in
the git history) and so now the header format is consistently:

##/bin/bash
# SPDX-License-Identifier: GPL-2.0(+)
# Copyright (c) <date> <owner>. All Rights Reserved.
#
# <file description>

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 common/attr        | 21 ++-------------------
 common/config      | 16 +---------------
 common/defrag      | 20 ++------------------
 common/dmapi       | 17 +----------------
 common/dmdelay     | 16 +---------------
 common/dmerror     | 16 +---------------
 common/dmflakey    | 16 +---------------
 common/dmhugedisk  | 23 +++--------------------
 common/dmlogwrites | 16 +---------------
 common/dmthin      | 16 +---------------
 common/dump        | 17 +----------------
 common/encrypt     | 23 +++--------------------
 common/filestreams | 17 +----------------
 common/filter      | 17 +----------------
 common/fuzzy       | 22 +++-------------------
 common/inject      | 24 ++++--------------------
 common/log         | 18 +-----------------
 common/module      | 22 +++-------------------
 common/populate    | 24 ++++--------------------
 common/punch       | 16 +---------------
 common/quota       | 21 ++-------------------
 common/rc          | 22 ++--------------------
 common/reflink     | 23 +++--------------------
 common/renameat2   | 23 +++--------------------
 common/repair      | 17 +----------------
 common/scsi_debug  | 22 ++--------------------
 26 files changed, 49 insertions(+), 456 deletions(-)

diff --git a/common/attr b/common/attr
index 49679d3cf3c6..10b98eefcb17 100644
--- a/common/attr
+++ b/common/attr
@@ -1,24 +1,7 @@
 ##/bin/bash
-#-----------------------------------------------------------------------
-#  Copyright (c) 2000-2004 Silicon Graphics, Inc.  All Rights Reserved.
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2000-2004 Silicon Graphics, Inc.  All Rights Reserved.
 #
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
-#  USA
-#
-#  Contact information: Silicon Graphics, Inc., 1500 Crittenden Lane,
-#  Mountain View, CA 94043, USA, or: http://www.sgi.com
-#-----------------------------------------------------------------------
 # common extended attribute and ACL support
 
 # filesystems that want to test maximum supported acl counts need to
diff --git a/common/config b/common/config
index d5150050d08d..09e7ffee30e8 100644
--- a/common/config
+++ b/common/config
@@ -1,21 +1,7 @@
 ##/bin/bash
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2000-2003,2006 Silicon Graphics, Inc.  All Rights Reserved.
 #
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
-#
 # setup and check for config parameters, and in particular
 #
 # EMAIL -           email of the script runner.
diff --git a/common/defrag b/common/defrag
index d279382f4b56..df249dfda660 100644
--- a/common/defrag
+++ b/common/defrag
@@ -1,24 +1,8 @@
 ##/bin/bash
-#
-# Copyright (c) 2009 Eric Sandeen
-# All Rights Reserved.
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
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2009 Eric Sandeen. All Rights Reserved.
 #
 # Functions useful for defragmentation tests
-#
 
 _require_defrag()
 {
diff --git a/common/dmapi b/common/dmapi
index 5eff3d92f195..5f7e56f743a7 100644
--- a/common/dmapi
+++ b/common/dmapi
@@ -1,23 +1,8 @@
 ##/bin/bash
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2006 Silicon Graphics, Inc.  All Rights Reserved.
 #
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
-#
 # dmapi functions
-#
 
 # Commands relitive to dmapi qa
 
diff --git a/common/dmdelay b/common/dmdelay
index 7f30d50184db..b9e4b9bb6cf0 100644
--- a/common/dmdelay
+++ b/common/dmdelay
@@ -1,21 +1,7 @@
 ##/bin/bash
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2016 Red Hat, Inc.  All Rights Reserved.
 #
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
-#
 # common functions for setting up and tearing down a dmdelay device
 
 DELAY_NONE=0
diff --git a/common/dmerror b/common/dmerror
index 238baa213b1f..4d6b8851b120 100644
--- a/common/dmerror
+++ b/common/dmerror
@@ -1,21 +1,7 @@
 ##/bin/bash
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2015 Oracle.  All Rights Reserved.
 #
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
-#
 # common functions for setting up and tearing down a dmerror device
 
 echo $MOUNT_OPTIONS | grep -q dax
diff --git a/common/dmflakey b/common/dmflakey
index 06eee378d0a2..51eab16bd080 100644
--- a/common/dmflakey
+++ b/common/dmflakey
@@ -1,21 +1,7 @@
 ##/bin/bash
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2013 Fusion IO, Inc.  All Rights Reserved.
 #
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
-#
 # common functions for setting up and tearing down a dmflakey device
 
 FLAKEY_ALLOW_WRITES=0
diff --git a/common/dmhugedisk b/common/dmhugedisk
index 733b10cd2292..4d0406d617c8 100644
--- a/common/dmhugedisk
+++ b/common/dmhugedisk
@@ -1,25 +1,8 @@
 ##/bin/bash
-# Routines for creating huge (fake) disks
-#-----------------------------------------------------------------------
-#  Copyright (c) 2016 Oracle.  All Rights Reserved.
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2016 Oracle.  All Rights Reserved.
 #
-#  You should have received a copy of the GNU General Public License
-#  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
-#  USA
-#
-#  Contact information: Oracle Corporation, 500 Oracle Parkway,
-#  Redwood Shores, CA 94065, USA, or: http://www.oracle.com/
-#-----------------------------------------------------------------------
+# Routines for creating huge (fake) disks
 
 _require_dmhugedisk()
 {
diff --git a/common/dmlogwrites b/common/dmlogwrites
index bf643a77ad09..9963bd98c2e6 100644
--- a/common/dmlogwrites
+++ b/common/dmlogwrites
@@ -1,21 +1,7 @@
 ##/bin/bash
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2015 Facebook, Inc.  All Rights Reserved.
 #
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
-#
 # common functions for setting up and tearing down a dm log-writes device
 
 _require_log_writes()
diff --git a/common/dmthin b/common/dmthin
index da0ad28488be..039d63e2397a 100644
--- a/common/dmthin
+++ b/common/dmthin
@@ -1,21 +1,7 @@
 #!/bin/bash
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2015 Red Hat, Inc.  All Rights Reserved.
 #
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
-#
 # common functions for setting up and tearing down a dmthin device
 
 # SOOO many devices!
diff --git a/common/dump b/common/dump
index 8a0ba1096d6a..b6b7fb46b236 100644
--- a/common/dump
+++ b/common/dump
@@ -1,23 +1,8 @@
 ##/bin/bash
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2000-2002,2005 Silicon Graphics, Inc.  All Rights Reserved.
 #
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
-#
 # Functions useful for xfsdump/xfsrestore tests
-#
 
 # --- initializations ---
 rm -f $seqres.full
diff --git a/common/encrypt b/common/encrypt
index 3d77ebd2cecc..1b10aa71ba24 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -1,25 +1,8 @@
-#-----------------------------------------------------------------------
-#
-# Common functions for testing filesystem-level encryption
-#
-#-----------------------------------------------------------------------
+##/bin/bash
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2016 Google, Inc.  All Rights Reserved.
 #
-# Author: Eric Biggers <ebiggers@google.com>
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
+# Functions for setting up and testing file encryption
 
 _require_scratch_encryption()
 {
diff --git a/common/filestreams b/common/filestreams
index d7a656f8bc23..267dcb3c3688 100644
--- a/common/filestreams
+++ b/common/filestreams
@@ -1,23 +1,8 @@
 ##/bin/bash
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2007 Silicon Graphics, Inc.  All Rights Reserved.
 #
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
-#
 # Core of filestreams tests.
-#
 
 _check_filestreams_support()
 {
diff --git a/common/filter b/common/filter
index 53874a08f5e3..3965c2eb752b 100644
--- a/common/filter
+++ b/common/filter
@@ -1,23 +1,8 @@
 ##/bin/bash
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
 #
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
-#
 # standard filters
-#
 
 # Checks that given_value is in range of correct_value +/- tolerance.
 # Tolerance can be an absolute value or a percentage of the correct value
diff --git a/common/fuzzy b/common/fuzzy
index f89765c1bfd2..8c370ae67b5a 100644
--- a/common/fuzzy
+++ b/common/fuzzy
@@ -1,24 +1,8 @@
 ##/bin/bash
-
-# Routines for fuzzing and scrubbing a filesystem.
-#
-#-----------------------------------------------------------------------
-#  Copyright (c) 2017 Oracle.  All Rights Reserved.
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2017 Oracle.  All Rights Reserved.
 #
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
-#  USA
-#-----------------------------------------------------------------------
+# Routines for fuzzing and scrubbing a filesystem.
 
 # Modify various files after a fuzzing operation
 _scratch_fuzz_modify() {
diff --git a/common/inject b/common/inject
index f30d0ba71449..903fb3790b92 100644
--- a/common/inject
+++ b/common/inject
@@ -1,25 +1,9 @@
 ##/bin/bash
-# Routines for injecting errors into filesystems
-#-----------------------------------------------------------------------
-#  Copyright (c) 2016 Oracle.  All Rights Reserved.
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
-#  USA
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2016 Oracle.  All Rights Reserved.
 #
-#  Contact information: Oracle Corporation, 500 Oracle Parkway,
-#  Redwood Shores, CA 94065, USA, or: http://www.oracle.com/
-#-----------------------------------------------------------------------
+# Routines for injecting errors into filesystems
+
 . ./common/log
 
 # Tests whether $FSTYP is one of the filesystems that supports error injection
diff --git a/common/log b/common/log
index 7a0a5f1f3b16..c7921f5020b2 100644
--- a/common/log
+++ b/common/log
@@ -1,24 +1,8 @@
 ##/bin/bash
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2000-2002 Silicon Graphics, Inc.  All Rights Reserved.
 #
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
-#
 # common routines for log testing
-# Created by dxm@sgi.com & tes@sgi.com
-#
 
 fulldir=$seqres.fulldir
 rm -rf $fulldir
diff --git a/common/module b/common/module
index ebaf29063362..39e4e7931c24 100644
--- a/common/module
+++ b/common/module
@@ -1,24 +1,8 @@
 ##/bin/bash
-
-# Routines for messing around with loadable kernel modules
-#
-#-----------------------------------------------------------------------
-#  Copyright (c) 2017 Oracle.  All Rights Reserved.
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2017 Oracle.  All Rights Reserved.
 #
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
-#  USA
-#-----------------------------------------------------------------------
+# Routines for messing around with loadable kernel modules
 
 # Return the module name for this fs.
 _module_for_fs()
diff --git a/common/populate b/common/populate
index b2dd053ff781..8c08f51656d5 100644
--- a/common/populate
+++ b/common/populate
@@ -1,26 +1,10 @@
 ##/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2015 Oracle.  All Rights Reserved.
+#
 # Routines for populating a scratch fs, and helpers to exercise an FS
 # once it's been fuzzed.
-#-----------------------------------------------------------------------
-#  Copyright (c) 2015 Oracle.  All Rights Reserved.
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
-#  USA
-#
-#  Contact information: Silicon Graphics, Inc., 1500 Crittenden Lane,
-#  Mountain View, CA 94043, USA, or: http://www.sgi.com
-#-----------------------------------------------------------------------
+
 . ./common/quota
 
 _require_populate_commands() {
diff --git a/common/punch b/common/punch
index 42a7e97496b7..8088b01a787c 100644
--- a/common/punch
+++ b/common/punch
@@ -1,21 +1,7 @@
 ##/bin/bash
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2007 Silicon Graphics, Inc.  All Rights Reserved.
 #
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
-#
 # common functions for excersizing hole punches with extent size hints etc.
 
 # source dmap_scratch_mount etc.
diff --git a/common/quota b/common/quota
index 68c350ee5bbb..0ea1922b7c1f 100644
--- a/common/quota
+++ b/common/quota
@@ -1,26 +1,9 @@
 ##/bin/bash
-#
-# Copyright (c) 2000-2001,2005 Silicon Graphics, Inc.
-# All Rights Reserved.
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
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2000-2001,2005 Silicon Graphics, Inc.  All Rights Reserved.
 #
 # Functions useful for quota tests
-#
 
-#
 # checks that the generic quota support in the kernel is enabled
 # and that we have valid quota user tools installed.
 #
diff --git a/common/rc b/common/rc
index 9d6665b6c4d7..b595a6e05662 100644
--- a/common/rc
+++ b/common/rc
@@ -1,24 +1,6 @@
 ##/bin/bash
-#-----------------------------------------------------------------------
-#  Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
-#
-#  You should have received a copy of the GNU General Public License
-#  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
-#  USA
-#
-#  Contact information: Silicon Graphics, Inc., 1500 Crittenden Lane,
-#  Mountain View, CA 94043, USA, or: http://www.sgi.com
-#-----------------------------------------------------------------------
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
 
 . common/config
 
diff --git a/common/reflink b/common/reflink
index 2a7c7b848e2b..e26632774f8a 100644
--- a/common/reflink
+++ b/common/reflink
@@ -1,25 +1,8 @@
 ##/bin/bash
-# Routines for reflinking, deduping, and comparing parts of files.
-#-----------------------------------------------------------------------
-#  Copyright (c) 2015 Oracle.  All Rights Reserved.
-#  This program is free software; you can redistribute it and/or modify
-#  it under the terms of the GNU General Public License as published by
-#  the Free Software Foundation; either version 2 of the License, or
-#  (at your option) any later version.
-#
-#  This program is distributed in the hope that it will be useful,
-#  but WITHOUT ANY WARRANTY; without even the implied warranty of
-#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#  GNU General Public License for more details.
+# SPDX-License-Identifier: GPL-2.0+
+# Copyright (c) 2015 Oracle.  All Rights Reserved.
 #
-#  You should have received a copy of the GNU General Public License
-#  along with this program; if not, write to the Free Software
-#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307
-#  USA
-#
-#  Contact information: Oracle Corporation, 500 Oracle Parkway,
-#  Redwood Shores, CA 94065, USA, or: http://www.oracle.com/
-#-----------------------------------------------------------------------
+# Routines for reflinking, deduping, and comparing parts of files.
 
 # Check that cp has a reflink argument
 _require_cp_reflink()
diff --git a/common/renameat2 b/common/renameat2
index a33516972088..f8d6d4f7a2bd 100644
--- a/common/renameat2
+++ b/common/renameat2
@@ -1,26 +1,9 @@
-######
-#
-# renameat2 helpers
-#
-#-----------------------------------------------------------------------
+##/bin/bash
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2014 Miklos Szeredi.  All Rights Reserved.
 #
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
-#
+# renameat2 helpers
 
-#
 # Setup source or dest
 #
 _setup_one()
diff --git a/common/repair b/common/repair
index b56954138401..6bbaffbe0b8a 100644
--- a/common/repair
+++ b/common/repair
@@ -1,23 +1,8 @@
 ##/bin/bash
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2000-2002 Silicon Graphics, Inc.  All Rights Reserved.
 #
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
-#
 # Functions useful for xfs_repair tests
-#
 
 _zero_position()
 {
diff --git a/common/scsi_debug b/common/scsi_debug
index 74c3802b76b3..d9aa0bd253fc 100644
--- a/common/scsi_debug
+++ b/common/scsi_debug
@@ -1,26 +1,8 @@
 ##/bin/bash
-#
-# Copyright (c) 2012 Red Hat, Inc
-# All Rights Reserved.
-#
-# Written by Eric Sandeen <sandeen@redhat.com>
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
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2012 Red Hat, Inc. All Rights Reserved.
 #
 # Functions useful for tests on unique block devices
-#
 
 _require_scsi_debug()
 {
-- 
2.17.0

