Received: from ipmail01.adl2.internode.on.net ([150.101.137.133]:18833 "EHLO
        ipmail01.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754161AbeFTCE0 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Jun 2018 22:04:26 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fVSTr-0006Py-7Q
        for fstests@vger.kernel.org; Wed, 20 Jun 2018 12:04:19 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fVSTr-0003th-6V
        for fstests@vger.kernel.org; Wed, 20 Jun 2018 12:04:19 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 3/6] lib/: spdx license conversion
Date: Wed, 20 Jun 2018 12:04:14 +1000
Message-Id: <20180620020417.14581-4-david@fromorbit.com>
In-Reply-To: <20180620020417.14581-1-david@fromorbit.com>
References: <20180620020417.14581-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Scripted like all the others, manually added tags to
Makefile, touchups required for random.c

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 lib/Makefile           |  2 +-
 lib/dataascii.c        | 14 +-------------
 lib/databin.c          | 14 +-------------
 lib/datapid.c          | 14 +-------------
 lib/file_lock.c        | 14 +-------------
 lib/forker.c           | 14 +-------------
 lib/open_flags.c       | 14 +-------------
 lib/pattern.c          | 14 +-------------
 lib/random.c           | 22 +++-------------------
 lib/random_range.c     | 14 +-------------
 lib/str_to_bytes.c     | 14 +-------------
 lib/string_to_tokens.c | 14 +-------------
 lib/tlibio.c           | 14 +-------------
 lib/write_log.c        | 14 +-------------
 14 files changed, 16 insertions(+), 176 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index c7348ce15f1c..53540ca705f7 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -1,4 +1,4 @@
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2003 Silicon Graphics, Inc.  All Rights Reserved.
 #
 
diff --git a/lib/dataascii.c b/lib/dataascii.c
index 1225a2353b57..e2509f8d5bc0 100644
--- a/lib/dataascii.c
+++ b/lib/dataascii.c
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
 #include <stdio.h>
 #include <string.h>
diff --git a/lib/databin.c b/lib/databin.c
index 3d2da0c9fe9c..8a36dff31efb 100644
--- a/lib/databin.c
+++ b/lib/databin.c
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
 #include <stdio.h>
 #include <sys/param.h>
diff --git a/lib/datapid.c b/lib/datapid.c
index 2e53ad559601..15af887167e4 100644
--- a/lib/datapid.c
+++ b/lib/datapid.c
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
 /************
 
diff --git a/lib/file_lock.c b/lib/file_lock.c
index 920adf340834..f0791489c771 100644
--- a/lib/file_lock.c
+++ b/lib/file_lock.c
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
 #include <sys/types.h>
 #include <sys/stat.h>
diff --git a/lib/forker.c b/lib/forker.c
index a5b786417cd0..63d8fcdba8d0 100644
--- a/lib/forker.c
+++ b/lib/forker.c
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
 /**************************************************************
  *
diff --git a/lib/open_flags.c b/lib/open_flags.c
index 389ea6b99e60..98b857df87c9 100644
--- a/lib/open_flags.c
+++ b/lib/open_flags.c
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
 /**************************************************************
  *
diff --git a/lib/pattern.c b/lib/pattern.c
index 247f861e82da..d622b93552f4 100644
--- a/lib/pattern.c
+++ b/lib/pattern.c
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
 #include <string.h>
 #include "pattern.h"
diff --git a/lib/random.c b/lib/random.c
index eb23cd96879f..d5c81be817c8 100644
--- a/lib/random.c
+++ b/lib/random.c
@@ -1,24 +1,8 @@
-/**************************************************************************
- *
+// SPDX-License-Identifier: GPL-2.0+
+/*
  * random.c -- pseudo random number generator
  * Copyright (C) 1994  Chris Wallace (csw@bruce.cs.monash.edu.au)
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
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- *
- *
- **************************************************************************/
+ */
 
 #include <sys/types.h>
 
diff --git a/lib/random_range.c b/lib/random_range.c
index 2e8dacbffcc8..3fa01f0ddffd 100644
--- a/lib/random_range.c
+++ b/lib/random_range.c
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
 #include <stdio.h>
 #include <stdlib.h>
diff --git a/lib/str_to_bytes.c b/lib/str_to_bytes.c
index ef5d4fd93403..2f6b2b92e3fc 100644
--- a/lib/str_to_bytes.c
+++ b/lib/str_to_bytes.c
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
 #include <stdio.h>
 #include <sys/param.h>
diff --git a/lib/string_to_tokens.c b/lib/string_to_tokens.c
index 76b563661418..08df9fcc0a3b 100644
--- a/lib/string_to_tokens.c
+++ b/lib/string_to_tokens.c
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
 /**********************************************************
  * 
diff --git a/lib/tlibio.c b/lib/tlibio.c
index 9b1b890272a5..f7259734af97 100644
--- a/lib/tlibio.c
+++ b/lib/tlibio.c
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
  *
diff --git a/lib/write_log.c b/lib/write_log.c
index 3bfa8c7b3091..cdc72593b9dc 100644
--- a/lib/write_log.c
+++ b/lib/write_log.c
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
  * This module contains code for logging writes to files, and for
-- 
2.17.0

