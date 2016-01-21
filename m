Received: from ipmail04.adl6.internode.on.net ([150.101.137.141]:33544 "EHLO
	ipmail04.adl6.internode.on.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752551AbcAUBoD (ORCPT
	<rfc822;fstests@vger.kernel.org>); Wed, 20 Jan 2016 20:44:03 -0500
Received: from disappointment.disaster.area ([192.168.1.110] helo=disappointment)
	by dastard with esmtp (Exim 4.80)
	(envelope-from <dave@fromorbit.com>)
	id 1aM4HL-0001zw-9g
	for fstests@vger.kernel.org; Thu, 21 Jan 2016 12:43:15 +1100
Received: from dave by disappointment with local (Exim 4.86)
	(envelope-from <dave@disappointment.disaster>)
	id 1aM4HL-0002gs-8t
	for fstests@vger.kernel.org; Thu, 21 Jan 2016 12:43:15 +1100
From: Dave Chinner <david@fromorbit.com>
Subject: [PATCH 2/3] setup: add section support
Date: Thu, 21 Jan 2016 12:43:12 +1100
Message-Id: <1453340593-10236-3-git-send-email-david@fromorbit.com>
In-Reply-To: <1453340593-10236-1-git-send-email-david@fromorbit.com>
References: <1453340593-10236-1-git-send-email-david@fromorbit.com>
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

From: Dave Chinner <dchinner@redhat.com>

Make the setup command section aware so that it is easy to test
whether the section config code is generating the correct
configurations or not.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 setup | 53 +++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 47 insertions(+), 6 deletions(-)

diff --git a/setup b/setup
index eb7bdb3..1a41d81 100755
--- a/setup
+++ b/setup
@@ -15,22 +15,63 @@
 # along with this program; if not, write the Free Software Foundation,
 # Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 #
+usage()
+{
+
+	echo "Usage: $0 [options]"'
+
+	-s section		run only specified section(s) from config file
+'
+	exit 0
+}
+
+while [ $# -gt 0 ]; do
+	case "$1" in
+	-\? | -h | --help) usage ;;
+	-s)	RUN_SECTION="$RUN_SECTION $2"; shift ;;
+	*)	usage ;;
+	esac
+	shift
+done
+
 if ! . ./common/config
 then
     echo "check: failed to source common/config"
     exit 1
 fi
 
-[ "$USE_EXTERNAL"    = yes ] || USE_EXTERNAL=no
-[ "$USE_LBD_PATCH"   = yes ] || USE_LBD_PATCH=no
-[ "$LARGE_SCRATCH_DEV"  = yes ] || LARGE_SCRATCH_DEV=no
-[ "$USE_ATTR_SECURE" = yes ] || USE_ATTR_SECURE=no
-[ -z "$FSTYP" ] && FSTYP="xfs"
+for section in $HOST_OPTIONS_SECTIONS; do
+	OLD_FSTYP=$FSTYP
+	OLD_MOUNT_OPTIONS=$MOUNT_OPTIONS
+	get_next_config $section
+
+	# Do we need to run only some sections ?
+	if [ ! -z "$RUN_SECTION" ]; then
+		skip=true
+		for s in $RUN_SECTION; do
+			if [ $section == $s ]; then
+				skip=false
+			fi
+		done
+		if $skip; then
+			continue
+		fi
+	fi
+
+	[ "$USE_EXTERNAL"    = yes ] || USE_EXTERNAL=no
+	[ "$USE_LBD_PATCH"   = yes ] || USE_LBD_PATCH=no
+	[ "$LARGE_SCRATCH_DEV"  = yes ] || LARGE_SCRATCH_DEV=no
+	[ "$USE_ATTR_SECURE" = yes ] || USE_ATTR_SECURE=no
+	[ -z "$FSTYP" ] && FSTYP="xfs"
+
+	cat <<EOF
+SECTION       -- $section
 
-cat <<EOF
 TEST: DIR=$TEST_DIR DEV=$TEST_DEV rt=[$TEST_RTDEV] log=[$TEST_LOGDEV]
 TAPE: dev=[$TAPE_DEV] rmt=[$RMT_TAPE_DEV] rmtirix=[$RMT_TAPE_USER@$RMT_IRIXTAPE_DEV]
 SCRATCH: MNT=$SCRATCH_MNT DEV=$SCRATCH_DEV rt=[$SCRATCH_RTDEV] log=[$SCRATCH_LOGDEV]
 VARIABLES: external=$USE_EXTERNAL largeblk=$USE_LBD_PATCH fstyp=$FSTYP
 	   large_scratch_dev=$LARGE_SCRATCH_DEV attrsecure=$USE_ATTR_SECURE
+--------
 EOF
+done
-- 
2.5.0

