Received: from ipmail03.adl6.internode.on.net ([150.101.137.143]:28629 "EHLO
        ipmail03.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751466AbeFICLe (ORCPT
        <rfc822;fstests@vger.kernel.org>); Fri, 8 Jun 2018 22:11:34 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fRT6V-0007YL-UZ
        for fstests@vger.kernel.org; Sat, 09 Jun 2018 11:55:44 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fRT6V-0005C6-TC
        for fstests@vger.kernel.org; Sat, 09 Jun 2018 11:55:43 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 8/9] fstests: convert top level files and tools to SPDX
Date: Sat,  9 Jun 2018 11:55:39 +1000
Message-Id: <20180609015540.19385-9-david@fromorbit.com>
In-Reply-To: <20180609015540.19385-1-david@fromorbit.com>
References: <20180609015540.19385-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Scripted conversion, see script in initial SPDX license commit
message. Many files required touch-ups after the script had run
because of the old and widely different formats. most touchups were
to remove excess empty comment lines the script left behind.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 Makefile               | 18 +-----------------
 check                  | 19 ++-----------------
 lsqa.pl                | 16 +---------------
 randomize.awk          | 15 +--------------
 setup                  | 15 +--------------
 soak                   | 17 +----------------
 tools/ag-wipe          | 18 +++---------------
 tools/auto-qa          | 16 +---------------
 tools/compare-failures | 22 +++-------------------
 tools/db-walk          | 18 +-----------------
 tools/fs-walk          | 17 +----------------
 tools/interop          | 16 +---------------
 12 files changed, 17 insertions(+), 190 deletions(-)

diff --git a/Makefile b/Makefile
index 1064984573be..9fd37e0cca54 100644
--- a/Makefile
+++ b/Makefile
@@ -1,22 +1,6 @@
-#
+# SPDX-License-Identifier: GPL-2.0+
 # Copyright (C) 2000-2008, 2011 SGI  All Rights Reserved.
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
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
-# 02110-1301, USA.
-#
-
 ifeq ("$(origin V)", "command line")
   BUILD_VERBOSE = $(V)
 endif
diff --git a/check b/check
index d768d6e90358..f3c8021d94b9 100755
--- a/check
+++ b/check
@@ -1,24 +1,9 @@
 #!/bin/bash
-#
-# Control script for QA
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2000-2002,2006 Silicon Graphics, Inc.  All Rights Reserved.
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
+# Control script for QA
 #
-
 tmp=/tmp/$$
 status=0
 needwrap=true
diff --git a/lsqa.pl b/lsqa.pl
index b4fc83f43f99..dd45eeda4e2c 100755
--- a/lsqa.pl
+++ b/lsqa.pl
@@ -1,21 +1,7 @@
 #!/usr/bin/perl -w
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2008 Silicon Graphics, Inc.  All Rights Reserved.
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
-
 # Print headers of given tests
 # Accepted parameter types:
 # - nothing - list all tests from all subdirectories in tests/*
diff --git a/randomize.awk b/randomize.awk
index 2504eb85be13..0a8ad71aa94a 100644
--- a/randomize.awk
+++ b/randomize.awk
@@ -1,19 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2005 Silicon Graphics, Inc.  All Rights Reserved.
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
-
 # randomize stdin.
 
 function randomize(array, N) {
diff --git a/setup b/setup
index eb37d80abe48..375a54c98ddf 100755
--- a/setup
+++ b/setup
@@ -1,20 +1,7 @@
 #!/bin/bash
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2003-2004 Silicon Graphics, Inc.  All Rights Reserved.
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
 usage()
 {
 
diff --git a/soak b/soak
index 26b345a3e4a9..d5c4229ad6e7 100755
--- a/soak
+++ b/soak
@@ -1,22 +1,7 @@
 #!/bin/bash
-#-----------------------------------------------------------------------
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
-#-----------------------------------------------------------------------
-#
 
 # get standard environment, filters and checks
 . ./common/rc
diff --git a/tools/ag-wipe b/tools/ag-wipe
index 476f0eaf0315..52acf0f80127 100755
--- a/tools/ag-wipe
+++ b/tools/ag-wipe
@@ -1,23 +1,11 @@
 #!/usr/bin/perl -w
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2003-2004 Silicon Graphics, Inc.  All Rights Reserved.
+#
 use strict;
 use IO::File;
 use Getopt::Std;
 #
-# Copyright (c) 2003-2004 Silicon Graphics, Inc.  All Rights Reserved.
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
 #
 # Modify a filesystem's superblock and AGF metadata structures
 # so that only a subset of the allocation groups will be used.
diff --git a/tools/auto-qa b/tools/auto-qa
index b81b0b5960c2..1d0cc07cc0a4 100755
--- a/tools/auto-qa
+++ b/tools/auto-qa
@@ -1,21 +1,7 @@
 #!/bin/sh
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2000-2003 Silicon Graphics, Inc.  All Rights Reserved.
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
 # automatic qa system. 31/08/00 dxm@sgi.com
 #
 # Usage: auto_qa start-state [stop-state]
diff --git a/tools/compare-failures b/tools/compare-failures
index 9604a6385552..d72f168569a7 100755
--- a/tools/compare-failures
+++ b/tools/compare-failures
@@ -1,5 +1,7 @@
 #!/bin/bash
-
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
+#
 # Compare test failures across runs
 #
 # Takes multiple "results" files as arguments, comprised of the
@@ -7,24 +9,6 @@
 #
 # Outputs a table of failures for comparison across runs
 #
-#-----------------------------------------------------------------------
-# Copyright (c) 2017 Red Hat, Inc.  All Rights Reserved.
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
-#
-
 filter_names() {
 	sed -e s/btrfs/b/ \
 	    -e s/cifs/c/g \
diff --git a/tools/db-walk b/tools/db-walk
index b64758706ff4..e0992055959f 100755
--- a/tools/db-walk
+++ b/tools/db-walk
@@ -1,25 +1,9 @@
 #!/usr/bin/perl -w
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
 # use db to try to traverse the entire filesystem starting at the root
 #
-#                                                       dxm 5/10/00
-
 my $device;
 my $rootino;
 my $agcount;
diff --git a/tools/fs-walk b/tools/fs-walk
index 0c80cd88e5d5..918e1ad67f36 100755
--- a/tools/fs-walk
+++ b/tools/fs-walk
@@ -1,24 +1,9 @@
 #!/usr/bin/perl -w
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
 # traverse the entire filesystem dumping info.
 #
-#                                                       dxm 5/10/00
 use MD5;
 use Getopt::Std;
 
diff --git a/tools/interop b/tools/interop
index 0cfa2e4e886d..dc1652c2b2ee 100755
--- a/tools/interop
+++ b/tools/interop
@@ -1,21 +1,7 @@
 #!/usr/sbin/perl
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2001 Silicon Graphics, Inc.  All Rights Reserved.
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
-
 sub setup()
 {
     $PATH="$PATH:/usr/local/bin/ptools:/sbin:/usr/sbin";
-- 
2.17.0

