Received: from ipmail07.adl2.internode.on.net ([150.101.137.131]:21924 "EHLO
        ipmail07.adl2.internode.on.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755808AbeE2AsC (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 28 May 2018 20:48:02 -0400
Received: from discord.disaster.area ([192.168.1.111])
        by dastard with esmtp (Exim 4.80)
        (envelope-from <david@fromorbit.com>)
        id 1fNSns-0007pd-Sc
        for fstests@vger.kernel.org; Tue, 29 May 2018 10:47:56 +1000
Received: from dave by discord.disaster.area with local (Exim 4.91)
        (envelope-from <david@fromorbit.com>)
        id 1fNSns-0002Uz-Rf
        for fstests@vger.kernel.org; Tue, 29 May 2018 10:47:56 +1000
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/2] fstests: start changeover to spdx license tags
Date: Tue, 29 May 2018 10:47:52 +1000
Message-Id: <20180529004752.8243-3-david@fromorbit.com>
In-Reply-To: <20180529004752.8243-1-david@fromorbit.com>
References: <20180529004752.8243-1-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Create a LICENSE directory and list the licenses used under this
directory, and start using SPDX tags in files to point at these
licenses. This will greatly reduce the amount of boiler plate text
in each test.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 LICENSES/GPL-2.0    | 353 ++++++++++++++++++++++++++++++++++++++++++++
 Makefile            |  18 +--
 check               |  19 +--
 common/Makefile     |   2 +-
 common/attr         |  21 +--
 common/btrfs        |   1 +
 common/config       |  16 +-
 common/defrag       |  20 +--
 common/dmapi        |  17 +--
 common/dmdelay      |  16 +-
 common/dmerror      |  16 +-
 common/dmflakey     |  16 +-
 common/dmhugedisk   |  23 +--
 common/dmlogwrites  |  16 +-
 common/dmthin       |  16 +-
 common/dump         |  17 +--
 common/encrypt      |  22 +--
 common/filestreams  |  17 +--
 common/filter       |  17 +--
 common/filter.btrfs |   1 +
 common/fuzzy        |  22 +--
 common/inject       |  24 +--
 common/log          |  18 +--
 common/module       |  22 +--
 common/nfs          |   2 +-
 common/overlay      |   3 +-
 common/perf         |   3 +-
 common/populate     |  24 +--
 common/punch        |  16 +-
 common/quota        |  21 +--
 common/rc           |  22 +--
 common/reflink      |  23 +--
 common/renameat2    |  21 +--
 common/repair       |  17 +--
 common/report       |   2 +-
 common/scsi_debug   |  22 +--
 common/setup_test   |   2 +
 common/xfs          |   2 +-
 lsqa.pl             |  25 +---
 new                 |  42 +-----
 randomize.awk       |  15 +-
 setup               |  17 +--
 soak                |  18 +--
 tests/generic/001   |  22 +--
 tests/xfs/001       |  21 +--
 45 files changed, 435 insertions(+), 635 deletions(-)
 create mode 100644 LICENSES/GPL-2.0

diff --git a/LICENSES/GPL-2.0 b/LICENSES/GPL-2.0
new file mode 100644
index 000000000000..b8db91d3a1cb
--- /dev/null
+++ b/LICENSES/GPL-2.0
@@ -0,0 +1,353 @@
+Valid-License-Identifier: GPL-2.0
+Valid-License-Identifier: GPL-2.0+
+SPDX-URL: https://spdx.org/licenses/GPL-2.0.html
+Usage-Guide:
+  To use this license in source code, put one of the following SPDX
+  tag/value pairs into a comment according to the placement
+  guidelines in the licensing rules documentation.
+  For 'GNU General Public License (GPL) version 2 only' use:
+    SPDX-License-Identifier: GPL-2.0
+  For 'GNU General Public License (GPL) version 2 or any later version' use:
+    SPDX-License-Identifier: GPL-2.0+
+License-Text:
+
+		    GNU GENERAL PUBLIC LICENSE
+		       Version 2, June 1991
+
+ Copyright (C) 1989, 1991 Free Software Foundation, Inc.
+                       51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ Everyone is permitted to copy and distribute verbatim copies
+ of this license document, but changing it is not allowed.
+
+			    Preamble
+
+  The licenses for most software are designed to take away your
+freedom to share and change it.  By contrast, the GNU General Public
+License is intended to guarantee your freedom to share and change free
+software--to make sure the software is free for all its users.  This
+General Public License applies to most of the Free Software
+Foundation's software and to any other program whose authors commit to
+using it.  (Some other Free Software Foundation software is covered by
+the GNU Library General Public License instead.)  You can apply it to
+your programs, too.
+
+  When we speak of free software, we are referring to freedom, not
+price.  Our General Public Licenses are designed to make sure that you
+have the freedom to distribute copies of free software (and charge for
+this service if you wish), that you receive source code or can get it
+if you want it, that you can change the software or use pieces of it
+in new free programs; and that you know you can do these things.
+
+  To protect your rights, we need to make restrictions that forbid
+anyone to deny you these rights or to ask you to surrender the rights.
+These restrictions translate to certain responsibilities for you if you
+distribute copies of the software, or if you modify it.
+
+  For example, if you distribute copies of such a program, whether
+gratis or for a fee, you must give the recipients all the rights that
+you have.  You must make sure that they, too, receive or can get the
+source code.  And you must show them these terms so they know their
+rights.
+
+  We protect your rights with two steps: (1) copyright the software, and
+(2) offer you this license which gives you legal permission to copy,
+distribute and/or modify the software.
+
+  Also, for each author's protection and ours, we want to make certain
+that everyone understands that there is no warranty for this free
+software.  If the software is modified by someone else and passed on, we
+want its recipients to know that what they have is not the original, so
+that any problems introduced by others will not reflect on the original
+authors' reputations.
+
+  Finally, any free program is threatened constantly by software
+patents.  We wish to avoid the danger that redistributors of a free
+program will individually obtain patent licenses, in effect making the
+program proprietary.  To prevent this, we have made it clear that any
+patent must be licensed for everyone's free use or not licensed at all.
+
+  The precise terms and conditions for copying, distribution and
+modification follow.
+
+		    GNU GENERAL PUBLIC LICENSE
+   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
+
+  0. This License applies to any program or other work which contains
+a notice placed by the copyright holder saying it may be distributed
+under the terms of this General Public License.  The "Program", below,
+refers to any such program or work, and a "work based on the Program"
+means either the Program or any derivative work under copyright law:
+that is to say, a work containing the Program or a portion of it,
+either verbatim or with modifications and/or translated into another
+language.  (Hereinafter, translation is included without limitation in
+the term "modification".)  Each licensee is addressed as "you".
+
+Activities other than copying, distribution and modification are not
+covered by this License; they are outside its scope.  The act of
+running the Program is not restricted, and the output from the Program
+is covered only if its contents constitute a work based on the
+Program (independent of having been made by running the Program).
+Whether that is true depends on what the Program does.
+
+  1. You may copy and distribute verbatim copies of the Program's
+source code as you receive it, in any medium, provided that you
+conspicuously and appropriately publish on each copy an appropriate
+copyright notice and disclaimer of warranty; keep intact all the
+notices that refer to this License and to the absence of any warranty;
+and give any other recipients of the Program a copy of this License
+along with the Program.
+
+You may charge a fee for the physical act of transferring a copy, and
+you may at your option offer warranty protection in exchange for a fee.
+
+  2. You may modify your copy or copies of the Program or any portion
+of it, thus forming a work based on the Program, and copy and
+distribute such modifications or work under the terms of Section 1
+above, provided that you also meet all of these conditions:
+
+    a) You must cause the modified files to carry prominent notices
+    stating that you changed the files and the date of any change.
+
+    b) You must cause any work that you distribute or publish, that in
+    whole or in part contains or is derived from the Program or any
+    part thereof, to be licensed as a whole at no charge to all third
+    parties under the terms of this License.
+
+    c) If the modified program normally reads commands interactively
+    when run, you must cause it, when started running for such
+    interactive use in the most ordinary way, to print or display an
+    announcement including an appropriate copyright notice and a
+    notice that there is no warranty (or else, saying that you provide
+    a warranty) and that users may redistribute the program under
+    these conditions, and telling the user how to view a copy of this
+    License.  (Exception: if the Program itself is interactive but
+    does not normally print such an announcement, your work based on
+    the Program is not required to print an announcement.)
+
+These requirements apply to the modified work as a whole.  If
+identifiable sections of that work are not derived from the Program,
+and can be reasonably considered independent and separate works in
+themselves, then this License, and its terms, do not apply to those
+sections when you distribute them as separate works.  But when you
+distribute the same sections as part of a whole which is a work based
+on the Program, the distribution of the whole must be on the terms of
+this License, whose permissions for other licensees extend to the
+entire whole, and thus to each and every part regardless of who wrote it.
+
+Thus, it is not the intent of this section to claim rights or contest
+your rights to work written entirely by you; rather, the intent is to
+exercise the right to control the distribution of derivative or
+collective works based on the Program.
+
+In addition, mere aggregation of another work not based on the Program
+with the Program (or with a work based on the Program) on a volume of
+a storage or distribution medium does not bring the other work under
+the scope of this License.
+
+  3. You may copy and distribute the Program (or a work based on it,
+under Section 2) in object code or executable form under the terms of
+Sections 1 and 2 above provided that you also do one of the following:
+
+    a) Accompany it with the complete corresponding machine-readable
+    source code, which must be distributed under the terms of Sections
+    1 and 2 above on a medium customarily used for software interchange; or,
+
+    b) Accompany it with a written offer, valid for at least three
+    years, to give any third party, for a charge no more than your
+    cost of physically performing source distribution, a complete
+    machine-readable copy of the corresponding source code, to be
+    distributed under the terms of Sections 1 and 2 above on a medium
+    customarily used for software interchange; or,
+
+    c) Accompany it with the information you received as to the offer
+    to distribute corresponding source code.  (This alternative is
+    allowed only for noncommercial distribution and only if you
+    received the program in object code or executable form with such
+    an offer, in accord with Subsection b above.)
+
+The source code for a work means the preferred form of the work for
+making modifications to it.  For an executable work, complete source
+code means all the source code for all modules it contains, plus any
+associated interface definition files, plus the scripts used to
+control compilation and installation of the executable.  However, as a
+special exception, the source code distributed need not include
+anything that is normally distributed (in either source or binary
+form) with the major components (compiler, kernel, and so on) of the
+operating system on which the executable runs, unless that component
+itself accompanies the executable.
+
+If distribution of executable or object code is made by offering
+access to copy from a designated place, then offering equivalent
+access to copy the source code from the same place counts as
+distribution of the source code, even though third parties are not
+compelled to copy the source along with the object code.
+
+  4. You may not copy, modify, sublicense, or distribute the Program
+except as expressly provided under this License.  Any attempt
+otherwise to copy, modify, sublicense or distribute the Program is
+void, and will automatically terminate your rights under this License.
+However, parties who have received copies, or rights, from you under
+this License will not have their licenses terminated so long as such
+parties remain in full compliance.
+
+  5. You are not required to accept this License, since you have not
+signed it.  However, nothing else grants you permission to modify or
+distribute the Program or its derivative works.  These actions are
+prohibited by law if you do not accept this License.  Therefore, by
+modifying or distributing the Program (or any work based on the
+Program), you indicate your acceptance of this License to do so, and
+all its terms and conditions for copying, distributing or modifying
+the Program or works based on it.
+
+  6. Each time you redistribute the Program (or any work based on the
+Program), the recipient automatically receives a license from the
+original licensor to copy, distribute or modify the Program subject to
+these terms and conditions.  You may not impose any further
+restrictions on the recipients' exercise of the rights granted herein.
+You are not responsible for enforcing compliance by third parties to
+this License.
+
+  7. If, as a consequence of a court judgment or allegation of patent
+infringement or for any other reason (not limited to patent issues),
+conditions are imposed on you (whether by court order, agreement or
+otherwise) that contradict the conditions of this License, they do not
+excuse you from the conditions of this License.  If you cannot
+distribute so as to satisfy simultaneously your obligations under this
+License and any other pertinent obligations, then as a consequence you
+may not distribute the Program at all.  For example, if a patent
+license would not permit royalty-free redistribution of the Program by
+all those who receive copies directly or indirectly through you, then
+the only way you could satisfy both it and this License would be to
+refrain entirely from distribution of the Program.
+
+If any portion of this section is held invalid or unenforceable under
+any particular circumstance, the balance of the section is intended to
+apply and the section as a whole is intended to apply in other
+circumstances.
+
+It is not the purpose of this section to induce you to infringe any
+patents or other property right claims or to contest validity of any
+such claims; this section has the sole purpose of protecting the
+integrity of the free software distribution system, which is
+implemented by public license practices.  Many people have made
+generous contributions to the wide range of software distributed
+through that system in reliance on consistent application of that
+system; it is up to the author/donor to decide if he or she is willing
+to distribute software through any other system and a licensee cannot
+impose that choice.
+
+This section is intended to make thoroughly clear what is believed to
+be a consequence of the rest of this License.
+
+  8. If the distribution and/or use of the Program is restricted in
+certain countries either by patents or by copyrighted interfaces, the
+original copyright holder who places the Program under this License
+may add an explicit geographical distribution limitation excluding
+those countries, so that distribution is permitted only in or among
+countries not thus excluded.  In such case, this License incorporates
+the limitation as if written in the body of this License.
+
+  9. The Free Software Foundation may publish revised and/or new versions
+of the General Public License from time to time.  Such new versions will
+be similar in spirit to the present version, but may differ in detail to
+address new problems or concerns.
+
+Each version is given a distinguishing version number.  If the Program
+specifies a version number of this License which applies to it and "any
+later version", you have the option of following the terms and conditions
+either of that version or of any later version published by the Free
+Software Foundation.  If the Program does not specify a version number of
+this License, you may choose any version ever published by the Free Software
+Foundation.
+
+  10. If you wish to incorporate parts of the Program into other free
+programs whose distribution conditions are different, write to the author
+to ask for permission.  For software which is copyrighted by the Free
+Software Foundation, write to the Free Software Foundation; we sometimes
+make exceptions for this.  Our decision will be guided by the two goals
+of preserving the free status of all derivatives of our free software and
+of promoting the sharing and reuse of software generally.
+
+			    NO WARRANTY
+
+  11. BECAUSE THE PROGRAM IS LICENSED FREE OF CHARGE, THERE IS NO WARRANTY
+FOR THE PROGRAM, TO THE EXTENT PERMITTED BY APPLICABLE LAW.  EXCEPT WHEN
+OTHERWISE STATED IN WRITING THE COPYRIGHT HOLDERS AND/OR OTHER PARTIES
+PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY OF ANY KIND, EITHER EXPRESSED
+OR IMPLIED, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
+MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE.  THE ENTIRE RISK AS
+TO THE QUALITY AND PERFORMANCE OF THE PROGRAM IS WITH YOU.  SHOULD THE
+PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF ALL NECESSARY SERVICING,
+REPAIR OR CORRECTION.
+
+  12. IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
+WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MAY MODIFY AND/OR
+REDISTRIBUTE THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES,
+INCLUDING ANY GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING
+OUT OF THE USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED
+TO LOSS OF DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY
+YOU OR THIRD PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER
+PROGRAMS), EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE
+POSSIBILITY OF SUCH DAMAGES.
+
+		     END OF TERMS AND CONDITIONS
+
+	    How to Apply These Terms to Your New Programs
+
+  If you develop a new program, and you want it to be of the greatest
+possible use to the public, the best way to achieve this is to make it
+free software which everyone can redistribute and change under these terms.
+
+  To do so, attach the following notices to the program.  It is safest
+to attach them to the start of each source file to most effectively
+convey the exclusion of warranty; and each file should have at least
+the "copyright" line and a pointer to where the full notice is found.
+
+    <one line to give the program's name and a brief idea of what it does.>
+    Copyright (C) <year>  <name of author>
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+
+
+Also add information on how to contact you by electronic and paper mail.
+
+If the program is interactive, make it output a short notice like this
+when it starts in an interactive mode:
+
+    Gnomovision version 69, Copyright (C) year name of author
+    Gnomovision comes with ABSOLUTELY NO WARRANTY; for details type `show w'.
+    This is free software, and you are welcome to redistribute it
+    under certain conditions; type `show c' for details.
+
+The hypothetical commands `show w' and `show c' should show the appropriate
+parts of the General Public License.  Of course, the commands you use may
+be called something other than `show w' and `show c'; they could even be
+mouse-clicks or menu items--whatever suits your program.
+
+You should also get your employer (if you work as a programmer) or your
+school, if any, to sign a "copyright disclaimer" for the program, if
+necessary.  Here is a sample; alter the names:
+
+  Yoyodyne, Inc., hereby disclaims all copyright interest in the program
+  `Gnomovision' (which makes passes at compilers) written by James Hacker.
+
+  <signature of Ty Coon>, 1 April 1989
+  Ty Coon, President of Vice
+
+This General Public License does not permit incorporating your program into
+proprietary programs.  If your program is a subroutine library, you may
+consider it more useful to permit linking proprietary applications with the
+library.  If this is what you want to do, use the GNU Library General
+Public License instead of this License.
diff --git a/Makefile b/Makefile
index 1064984573be..297484bc73a2 100644
--- a/Makefile
+++ b/Makefile
@@ -1,21 +1,5 @@
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (C) 2000-2008, 2011 SGI  All Rights Reserved.
-#
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
 
 ifeq ("$(origin V)", "command line")
   BUILD_VERBOSE = $(V)
diff --git a/check b/check
index 0cdf95e9f5e7..26b3a36db670 100755
--- a/check
+++ b/check
@@ -1,23 +1,8 @@
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
-#
+# Control script for QA
 
 tmp=/tmp/$$
 status=0
diff --git a/common/Makefile b/common/Makefile
index 5f91e8c32134..e07a092e71f4 100644
--- a/common/Makefile
+++ b/common/Makefile
@@ -1,6 +1,6 @@
 #
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2003-2006 Silicon Graphics, Inc.  All Rights Reserved.
-#
 
 TOPDIR = ..
 include $(TOPDIR)/include/builddefs
diff --git a/common/attr b/common/attr
index 3d1385a493b0..78937f05a62c 100644
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
+# SPDX-License-Identifier: GPL-2.0
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
diff --git a/common/btrfs b/common/btrfs
index 79c687f73376..c685d9c42af5 100644
--- a/common/btrfs
+++ b/common/btrfs
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Common btrfs specific functions
 #
diff --git a/common/config b/common/config
index 1cf402eee1dc..a746f3c23254 100644
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
index 4d3b63fcfcca..9a0b7dabeab8 100644
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
+# SPDX-License-Identifier: GPL-2.0
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
index 7b9c10a25414..e83fd1540ee2 100644
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
index 3d77ebd2cecc..f92aa1f42934 100644
--- a/common/encrypt
+++ b/common/encrypt
@@ -1,25 +1,7 @@
-#-----------------------------------------------------------------------
-#
-# Common functions for testing filesystem-level encryption
-#
-#-----------------------------------------------------------------------
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
+# Common functions for testing filesystem-level encryption
 
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
diff --git a/common/filter.btrfs b/common/filter.btrfs
index aaff2278987d..2e52e663adbb 100644
--- a/common/filter.btrfs
+++ b/common/filter.btrfs
@@ -1,3 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
 # Filters for btrfs command output
 
 . ./common/filter
diff --git a/common/fuzzy b/common/fuzzy
index f89765c1bfd2..9ed3f624cd0c 100644
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
+# SPDX-License-Identifier: GPL-2.0
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
index f30d0ba71449..edcbd09300b9 100644
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
+# SPDX-License-Identifier: GPL-2.0
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
index ebaf29063362..cc9cecea14f0 100644
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
+# SPDX-License-Identifier: GPL-2.0
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
diff --git a/common/nfs b/common/nfs
index a03eaf48e1c0..6933cbdaabcd 100644
--- a/common/nfs
+++ b/common/nfs
@@ -1,6 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # NFS specific common functions.
-#
 
 # given an NFS export and a NFS version number, return 0 if
 # the mounted NFS is the given version. e.g.
diff --git a/common/overlay b/common/overlay
index 441827b88fc6..e0f093be1567 100644
--- a/common/overlay
+++ b/common/overlay
@@ -1,6 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # overlayfs specific common functions.
-#
+
 . ./common/module
 
 # Export overlayfs xattrs and constant value
diff --git a/common/perf b/common/perf
index 8b4c9bef8a8d..040e8dae8a41 100644
--- a/common/perf
+++ b/common/perf
@@ -1,7 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Common perf specific functions
-#
-
 
 _require_fio_results()
 {
diff --git a/common/populate b/common/populate
index 07ea7e60a420..276a0b252664 100644
--- a/common/populate
+++ b/common/populate
@@ -1,26 +1,10 @@
 ##/bin/bash
+# SPDX-License-Identifier: GPL-2.0
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
index 68c350ee5bbb..186fac40ef50 100644
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
+# Copyright (c) 2000-2001,2005 Silicon Graphics, Inc. All Rights Reserved.
 #
 # Functions useful for quota tests
-#
 
-#
 # checks that the generic quota support in the kernel is enabled
 # and that we have valid quota user tools installed.
 #
diff --git a/common/rc b/common/rc
index 68aad24bfa7c..622a57d9a616 100644
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
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2000-2006 Silicon Graphics, Inc.  All Rights Reserved.
 
 BC=$(which bc 2> /dev/null) || BC=
 
diff --git a/common/reflink b/common/reflink
index 2a7c7b848e2b..9fe958ce1310 100644
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
+# SPDX-License-Identifier: GPL-2.0
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
index a33516972088..e7367cb29320 100644
--- a/common/renameat2
+++ b/common/renameat2
@@ -1,26 +1,9 @@
 ######
-#
-# renameat2 helpers
-#
-#-----------------------------------------------------------------------
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
diff --git a/common/report b/common/report
index a62d343e5216..99924a0cb410 100644
--- a/common/report
+++ b/common/report
@@ -1,6 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # Reports generator funcitons lives here
-#
 
 # List of xfstests's enviroment variables to include reports
 ## TODO automate list population inside common/conf
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
diff --git a/common/setup_test b/common/setup_test
index 0e22452b4f6e..eece95dc82a3 100644
--- a/common/setup_test
+++ b/common/setup_test
@@ -1,3 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+#
 # common test setup preamble
 # test specific cleanup is done via the cleanup() function now.
 
diff --git a/common/xfs b/common/xfs
index 92223513d561..5b330d2f9797 100644
--- a/common/xfs
+++ b/common/xfs
@@ -1,6 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0
 #
 # XFS specific common functions.
-#
 
 _setup_large_xfs_fs()
 {
diff --git a/lsqa.pl b/lsqa.pl
index b4fc83f43f99..3fd5c8ea33c9 100755
--- a/lsqa.pl
+++ b/lsqa.pl
@@ -1,21 +1,6 @@
 #!/usr/bin/perl -w
+# SPDX-License-Identifier: GPL-2.0
 #
-# Copyright (c) 2008 Silicon Graphics, Inc.  All Rights Reserved.
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
-
 # Print headers of given tests
 # Accepted parameter types:
 # - nothing - list all tests from all subdirectories in tests/*
@@ -109,9 +94,11 @@ sub get_qa_header($) {
     open(my $FH, $f) || die "couldn't open '$f': $!";
     while (<$FH>) {
 	#ignore.
-	m/^#\!/    		and next; #shebang
-	m/^#\s*\-{10}/		and last; #dashed lines
-	m/^#\s*copyright/i 	and last; #copyright lines
+	m/^#\!/			and next; # shebang
+	m/^# SPDX/i		and next; # SPDX tags
+	m/^# Copyright/i	and next; # Copyright tags
+	m/^#\s*\-{10}/		and last; # dashed lines
+	m/setup_test/i		and last; # test start
 
 	s/^# *//;
 
diff --git a/new b/new
index 5e7f6a3c4198..ab7107dfd8fb 100755
--- a/new
+++ b/new
@@ -1,25 +1,8 @@
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
-#
 
 # generic initialization
 iam=new
@@ -159,27 +142,12 @@ year=`date +%Y`
 
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
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write the Free Software Foundation,
-# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
-#-----------------------------------------------------------------------
+# FS QA Test $id
 #
+# what am I here for?
 
 . common/setup_test
 
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
index eb37d80abe48..91b9567d7406 100755
--- a/setup
+++ b/setup
@@ -1,20 +1,7 @@
 #!/bin/bash
-#
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2003-2004 Silicon Graphics, Inc.  All Rights Reserved.
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
+
 usage()
 {
 
diff --git a/soak b/soak
index 8fd0b9043329..7d21d0998ad5 100755
--- a/soak
+++ b/soak
@@ -1,22 +1,6 @@
 #!/bin/bash
-#-----------------------------------------------------------------------
+# SPDX-License-Identifier: GPL-2.0
 # Copyright (c) 2000-2002 Silicon Graphics, Inc.  All Rights Reserved.
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
-#
 
 . common/setup_test
 
diff --git a/tests/generic/001 b/tests/generic/001
index f86dc5a85d5d..a425eda6c81a 100755
--- a/tests/generic/001
+++ b/tests/generic/001
@@ -1,4 +1,7 @@
 #! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
+#
 # FS QA Test No. 001
 #
 # Random file copier to produce chains of identical files so the head
@@ -11,25 +14,6 @@
 #
 # config has one line per file with filename and byte size, else use
 # the default one below.
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2000-2001 Silicon Graphics, Inc.  All Rights Reserved.
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
-#
 
 . common/setup_test
 
diff --git a/tests/xfs/001 b/tests/xfs/001
index 1b5a1020e173..4304df2b2e8c 100755
--- a/tests/xfs/001
+++ b/tests/xfs/001
@@ -1,27 +1,12 @@
 #! /bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2014 SGI.  All Rights Reserved.
+#
 # FS QA Test No. 001
 #
 # Test the xfs_db write of the XFS BMBT entries. For each XFS BMBT field,
 # write the value 0, each bit and finally the entry beyond the maximum legal
 # value. Also makes sure a core write and hex input still work.
-#
-#-----------------------------------------------------------------------
-# Copyright (c) 2014 SGI.  All Rights Reserved.
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
 
 . common/setup_test
 
-- 
2.17.0

