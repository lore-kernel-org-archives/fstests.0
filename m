Received: from ipmail01.adl2.internode.on.net ([150.101.137.133]:49495 "EHLO
        ipmail01.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752784AbeFTCEZ (ORCPT
        <rfc822;fstests@vger.kernel.org>); Tue, 19 Jun 2018 22:04:25 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fVSTr-0006Px-6l
        for fstests@vger.kernel.org; Wed, 20 Jun 2018 12:04:19 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fVSTr-0003te-5p
        for fstests@vger.kernel.org; Wed, 20 Jun 2018 12:04:19 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/6] include/: spdx license conversion
Date: Wed, 20 Jun 2018 12:04:13 +1000
Message-Id: <20180620020417.14581-3-david@fromorbit.com>
In-Reply-To: <20180620020417.14581-1-david@fromorbit.com>
References: <20180620020417.14581-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Mostly scripted like all the others, manually added tags to
Makefile and build/config input files.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 include/Makefile           |  2 +-
 include/builddefs.in       |  2 +-
 include/buildmacros        |  2 +-
 include/buildrules         |  2 +-
 include/dataascii.h        | 14 +-------------
 include/file_lock.h        | 14 +-------------
 include/forker.h           | 14 +-------------
 include/install-sh         |  1 +
 include/open_flags.h       | 14 +-------------
 include/pattern.h          | 14 +-------------
 include/random_range.h     | 14 +-------------
 include/str_to_bytes.h     | 14 +-------------
 include/string_to_tokens.h | 14 +-------------
 include/tlibio.h           | 14 +-------------
 include/write_log.h        | 14 +-------------
 15 files changed, 15 insertions(+), 134 deletions(-)

diff --git a/include/Makefile b/include/Makefile
index 8e2b42fd1898..a95be1356071 100644
--- a/include/Makefile
+++ b/include/Makefile
@@ -1,4 +1,4 @@
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2000-2003 Silicon Graphics, Inc.  All Rights Reserved.
 #
 
diff --git a/include/builddefs.in b/include/builddefs.in
index cb52b99a39a8..fb8e912b10a2 100644
--- a/include/builddefs.in
+++ b/include/builddefs.in
@@ -1,4 +1,4 @@
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2003 Silicon Graphics, Inc.  All Rights Reserved.
 #
 # @configure_input@
diff --git a/include/buildmacros b/include/buildmacros
index b80b534ca607..60874842412b 100644
--- a/include/buildmacros
+++ b/include/buildmacros
@@ -1,4 +1,4 @@
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2002-2003 Silicon Graphics, Inc.  All Rights Reserved.
 #
 
diff --git a/include/buildrules b/include/buildrules
index 76b755e88fdf..bf187662f66f 100644
--- a/include/buildrules
+++ b/include/buildrules
@@ -1,4 +1,4 @@
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 1999, 2001-2003 Silicon Graphics, Inc.  All Rights Reserved.
 #
 ifndef _BUILDRULES_INCLUDED_
diff --git a/include/dataascii.h b/include/dataascii.h
index 3f87578a3915..50a73dcc4264 100644
--- a/include/dataascii.h
+++ b/include/dataascii.h
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
 #ifndef _DATAASCII_H_
 #define _DATAASCII_H_
diff --git a/include/file_lock.h b/include/file_lock.h
index 1d7ce56a5589..179f2ab4ff08 100644
--- a/include/file_lock.h
+++ b/include/file_lock.h
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
 #ifndef _FILE_LOCK_H_
 #define _FILE_LOCK_H_
diff --git a/include/forker.h b/include/forker.h
index f573dcb0103d..913a23e9f9ca 100644
--- a/include/forker.h
+++ b/include/forker.h
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
 #ifndef _FORKER_H_
 #define _FORKER_H_
diff --git a/include/install-sh b/include/install-sh
index 06d8aa9b6b9c..a19cbe3181cb 100755
--- a/include/install-sh
+++ b/include/install-sh
@@ -1,5 +1,6 @@
 #! /bin/bash
 #
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
 #
 # This script emulates bsd install and also recognises
diff --git a/include/open_flags.h b/include/open_flags.h
index f5e0e1546115..4526769c5e30 100644
--- a/include/open_flags.h
+++ b/include/open_flags.h
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
 #ifndef _OPEN_FLAGS_H_
 #define _OPEN_FLAGS_H_
diff --git a/include/pattern.h b/include/pattern.h
index d19294a5b9e1..c41ae9f5b2a1 100644
--- a/include/pattern.h
+++ b/include/pattern.h
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
 #ifndef _PATTERN_H_
 #define _PATTERN_H_
diff --git a/include/random_range.h b/include/random_range.h
index 44dbc9b8a56f..b47aef9ef619 100644
--- a/include/random_range.h
+++ b/include/random_range.h
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
 #ifndef _RANDOM_RANGE_H_
 #define _RANDOM_RANGE_H_
diff --git a/include/str_to_bytes.h b/include/str_to_bytes.h
index e2b6226eb516..ae27bc571430 100644
--- a/include/str_to_bytes.h
+++ b/include/str_to_bytes.h
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
 #ifndef _STR_TO_BYTES_
 #define _STR_TO_BYTES_
diff --git a/include/string_to_tokens.h b/include/string_to_tokens.h
index 59b9ccf023aa..795ae7921d73 100644
--- a/include/string_to_tokens.h
+++ b/include/string_to_tokens.h
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
 #ifndef _STRING_TO_TOKENS_H_
 #define _STRING_TO_TOKENS_H_
diff --git a/include/tlibio.h b/include/tlibio.h
index bf85cc5933da..12649cf54603 100644
--- a/include/tlibio.h
+++ b/include/tlibio.h
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
 
 #define LIO_IO_SYNC             00001   /* read/write */
diff --git a/include/write_log.h b/include/write_log.h
index 4a6eaced2435..025ebac024fa 100644
--- a/include/write_log.h
+++ b/include/write_log.h
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
 #ifndef _WRITE_LOG_H_
 #define _WRITE_LOG_H_
-- 
2.17.0

