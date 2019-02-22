Received: from mx2.suse.de ([195.135.220.15]:42498 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbfBVKEc (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 22 Feb 2019 05:04:32 -0500
From: Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3] shared/298: Wire btrfs support in get_free_sectors
Date: Fri, 22 Feb 2019 12:04:25 +0200
Message-Id: <20190222100425.22433-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: fstests@vger.kernel.org
Cc: linux-btrfs@vger.kernel.org, guaneryu@gmail.com, Nikolay Borisov <nborisov@suse.com>
List-ID: <fstests@vger.kernel.org>

Add support for btrfs in shared/298. Achieve this by introducing 2
new awk scripts that parse relevant btrfs structures and print holes.
Additionally modify the test to create larger - 3gb filesystem in the
case of btrfs. This is needed so that distinct block groups are used
for data and metadata.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---

Changes since v2:=20

 * Moved files to src/ dir
 * Rename spb parameter in both scripts to sectorsize
 * Added comments for function
 * Added spaces after every # of a comment
 * Removed btrfs_Free variable from shared/298, now the awk scripts direc=
tly
 print their output

 src/parse-dev-tree.awk    |  64 +++++++++++++++++++++
 src/parse-extent-tree.awk | 144 ++++++++++++++++++++++++++++++++++++++++=
++++++
 tests/shared/298          |  33 ++++++++++-
 3 files changed, 238 insertions(+), 3 deletions(-)
 create mode 100755 src/parse-dev-tree.awk
 create mode 100755 src/parse-extent-tree.awk

diff --git a/src/parse-dev-tree.awk b/src/parse-dev-tree.awk
new file mode 100755
index 000000000000..9c98402cf66b
--- /dev/null
+++ b/src/parse-dev-tree.awk
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Nikolay Borisov, SUSE LLC.  All Rights Reserved.
+#
+# Parses btrfs' device tree for holes. For example given the followin de=
vice extents:
+#	item 3 key (1 DEV_EXTENT 38797312) itemoff 16091 itemsize 48
+#		dev extent chunk_tree 3
+#		chunk_objectid 256 chunk_offset 30408704 length 1073741824
+#		chunk_tree_uuid b8c8f022-452b-4fc1-bf5c-b42d9fba613e
+#	item 4 key (1 DEV_EXTENT 1112539136) itemoff 16043 itemsize 48
+#		dev extent chunk_tree 3
+#		chunk_objectid 256 chunk_offset 30408704 length 1073741824
+#		chunk_tree_uuid b8c8f022-452b-4fc1-bf5c-b42d9fba613e
+#
+# The scripts will find out if there is a hole between 38797312+10737418=
24 and
+# the start offset of the next extent, in this case 1112539136 so no hol=
e. But
+# if there was it would have printed the size of the hole.
+#
+# Following paramters must be set:
+#    * sectorsize - how many bytes per sector, used to convert script's =
output
+#    to sectors.
+#    * devsize - size of the device in bytes, used to output the final
+#    hole (if any)
+
+# Given a 'chunk_objectid 256 chunk_offset 22020096 length 8388608' line=
 this
+# function returns 8388608
+function get_extent_size(line,  tmp) {
+	split(line, tmp)
+	return tmp[6]
+}
+
+# Given a '	item 3 key (1 DEV_EXTENT 38797312) itemoff 16091 itemsize 48=
' line
+# this function returns 38797312
+function get_extent_offset(line,  tmp) {
+	split(line, tmp)
+	gsub(/\)/,"", tmp[6])
+	return tmp[6]
+}
+
+BEGIN {
+	dev_extent_match=3D"^.item [0-9]* key \\([0-9]* DEV_EXTENT [0-9]*\\).*"
+	dev_extent_len_match=3D"^\\s*chunk_objectid [0-9]* chunk_offset [0-9]* =
length [0-9]*$"
+}
+
+{
+	if (match($0,dev_extent_match)) {
+		extent_offset =3D get_extent_offset($0)
+		if (prev_extent_end) {
+			hole_size =3D extent_offset - prev_extent_end
+			if (hole_size > 0) {
+				print prev_extent_end / sectorsize, int((extent_offset - 1) / sector=
size)
+			}
+		}
+	} else if (match($0, dev_extent_len_match)) {
+		extent_size =3D get_extent_size($0)
+		prev_extent_end =3D extent_offset + extent_size
+	}
+}
+
+END {
+	if (prev_extent_end) {
+		print prev_extent_end / sectorsize, int((devsize - 1) / sectorsize)
+	}
+}
+
diff --git a/src/parse-extent-tree.awk b/src/parse-extent-tree.awk
new file mode 100755
index 000000000000..09fed61e5b71
--- /dev/null
+++ b/src/parse-extent-tree.awk
@@ -0,0 +1,144 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (c) 2019 Nikolay Borisov, SUSE LLC.  All Rights Reserved.
+#
+# Parses btrfs' extent tree for holes. Holes are the ranges between 2 ad=
jacent
+# extent blocks. For example if we have the following 2 metadata items i=
n the
+# extent tree:
+#	item 6 key (30425088 METADATA_ITEM 0) itemoff 16019 itemsize 33
+#	item 7 key (30490624 METADATA_ITEM 0) itemoff 15986 itemsize 33
+#
+# There is a whole of 64k between then - 30490624=E2=88=9230425088 =3D 6=
5536
+# Same logic applies for adjacent EXTENT_ITEMS.
+#
+# The script requires the following parameters passed on command line:
+#     * sectorsize - how many bytes per sector, used to convert the outp=
ut of
+#     the script to sectors.
+#     * nodesize - size of metadata extents, used for internal calculati=
ons
+
+# Given an extent line "item 2 key (13672448 EXTENT_ITEM 65536) itemoff =
16153 itemsize 53"
+# or "item 6 key (30425088 METADATA_ITEM 0) itemoff 16019 itemsize 33" r=
eturns
+# either 65536 (for data extents) or the fixes nodesize value for metada=
ta
+# extents.
+function get_extent_size(line,  tmp) {
+	if (line ~ data_match || line ~ bg_match) {
+		split(line, tmp)
+		gsub(/\)/,"", tmp[6])
+		return tmp[6]
+	} else if (line ~ metadata_match) {
+		return nodesize
+	}
+}
+
+# given a 'item 2 key (13672448 EXTENT_ITEM 65536) itemoff 16153 itemsiz=
e 53' or
+# returns 13672448.
+function get_extent_offset(line,  tmp) {
+	split(line, tmp)
+	gsub(/\(/,"",tmp[4])
+	return tmp[4]
+}
+
+# This function parse all the extents belonging to a particular block gr=
oup
+# which are accumulated in lines[] and calculates the offsets of the hol=
es
+# part of this block group.
+#
+# base_offset and bg_line are local variables
+function print_array(         base_offset, bg_line)
+{
+	if (match(lines[0], bg_match)) {
+		# we don't have an extent at the beginning of of blockgroup, so we
+		# have a hole between blockgroup offset and first extent offset
+		bg_line =3D lines[0]
+		prev_size=3D0
+		prev_offset=3Dget_extent_offset(bg_line)
+		delete lines[0]
+	} else {
+		# we have an extent at the beginning of block group, so initialize
+		# the prev_* vars correctly
+		bg_line =3D lines[1]
+		prev_size =3D get_extent_size(lines[0])
+		prev_offset =3D get_extent_offset(lines[0])
+		delete lines[1]
+		delete lines[0]
+	}
+
+	bg_offset=3Dget_extent_offset(bg_line)
+	bgend=3Dbg_offset + get_extent_size(bg_line)
+
+	for (i in lines) {
+			cur_size =3D get_extent_size(lines[i])
+			cur_offset =3D get_extent_offset(lines[i])
+			if (cur_offset  !=3D prev_offset + prev_size)
+				print int((prev_size + prev_offset) / sectorsize), int((cur_offset-1=
) / sectorsize)
+			prev_size =3D cur_size
+			prev_offset =3D cur_offset
+	}
+
+	print int((prev_size + prev_offset) / sectorsize), int((bgend-1) / sect=
orsize)
+	total_printed++
+	delete lines
+}
+
+BEGIN {
+	loi_match=3D"^.item [0-9]* key \\([0-9]* (BLOCK_GROUP_ITEM|METADATA_ITE=
M|EXTENT_ITEM) [0-9]*\\).*"
+	metadata_match=3D"^.item [0-9]* key \\([0-9]* METADATA_ITEM [0-9]*\\).*=
"
+	data_match=3D"^.item [0-9]* key \\([0-9]* EXTENT_ITEM [0-9]*\\).*"
+	bg_match=3D"^.item [0-9]* key \\([0-9]* BLOCK_GROUP_ITEM [0-9]*\\).*"
+	node_match=3D"^node.*$"
+	leaf_match=3D"^leaf [0-9]* flags"
+	line_count=3D0
+	total_printed=3D0
+	skip_lines=3D0
+}
+
+{
+	# skip lines not belonging to a leaf
+	if (match($0,node_match)) {
+		skip_lines=3D1
+	} else if (match($0, leaf_match)) {
+		skip_lines=3D0
+	}
+
+	if (!match($0,loi_match) || skip_lines =3D=3D 1) next;
+
+	# we have a line of interest, we need to parse it. First check if there=
 is
+	# anything in the array
+	if (line_count=3D=3D0) {
+		lines[line_count++]=3D$0;
+	} else {
+		prev_line=3Dlines[line_count-1]
+		split(prev_line, prev_line_fields)
+		prev_objectid=3Dprev_line_fields[4]
+		objectid=3D$4
+
+		if (objectid =3D=3D prev_objectid && match($0, bg_match)) {
+			if (total_printed>0) {
+				# We are adding a BG after we have added its first extent
+				# previously, consider this a record ending event and just print
+				# the array
+
+				delete lines[line_count-1]
+				print_array()
+				# we now start a new array with current and previous lines
+				line_count=3D0
+				lines[line_count++]=3Dprev_line
+				lines[line_count++]=3D$0
+			} else {
+				# first 2 added lines are EXTENT and BG that match, in this case
+				# just add them
+				lines[line_count++]=3D$0
+
+			}
+		} else if (match($0, bg_match)) {
+			# ordinary end of record
+			print_array()
+			line_count=3D0
+			lines[line_count++]=3D$0
+		} else {
+			lines[line_count++]=3D$0
+		}
+	}
+}
+
+END {
+	print_array()
+}
diff --git a/tests/shared/298 b/tests/shared/298
index e7b7b233de45..aafdc25f5575 100755
--- a/tests/shared/298
+++ b/tests/shared/298
@@ -15,14 +15,24 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 . ./common/rc
=20
-_supported_fs ext4 xfs
+_supported_fs ext4 xfs btrfs
 _supported_os Linux
 _require_test
 _require_loop
 _require_fstrim
 _require_xfs_io_command "fiemap"
-_require_fs_space $TEST_DIR 307200
+if [ "$FSTYP" =3D "btrfs" ]; then
+	# 3g for btrfs to have distinct bgs
+	_require_fs_space $TEST_DIR 3145728
+	fssize=3D3000
+else
+	_require_fs_space $TEST_DIR 307200
+	fssize=3D300
+fi
+
 [ "$FSTYP" =3D "ext4" ] && _require_dumpe2fs
+[ "$FSTYP" =3D "btrfs" ] && _require_btrfs_command inspect-internal dump=
-super
+[ "$FSTYP" =3D "btrfs" ] && _require_btrfs_command inspect-internal dump=
-tree
=20
 _cleanup()
 {
@@ -61,6 +71,22 @@ get_free_sectors()
 		 $AWK_PROG -v spb=3D$sectors_per_block -v agsize=3D$agsize \
 		'{ print spb * ($1 * agsize + $2), spb * ($1 * agsize + $2 + $3) - 1 }=
'
 	;;
+	btrfs)
+		local device_size=3D$($BTRFS_UTIL_PROG filesystem show --raw $loop_mnt=
 2>&1 \
+			| sed -n "s/^.*size \([0-9]*\).*$/\1/p")
+
+		local nodesize=3D$($BTRFS_UTIL_PROG inspect-internal dump-super $img_f=
ile  \
+			| sed -n 's/nodesize\s*\(.*\)/\1/p')
+
+		# Get holes within block groups
+		$BTRFS_UTIL_PROG inspect-internal dump-tree -t extent $img_file \
+			| $AWK_PROG -v sectorsize=3D512 -v nodesize=3D$nodesize -f $here/src/=
parse-extent-tree.awk
+
+		# Get holes within unallocated space on disk
+		$BTRFS_UTIL_PROG inspect-internal dump-tree -t dev $img_file \
+			| $AWK_PROG -v sectorsize=3D512 -v devsize=3D$device_size -f $here/sr=
c/parse-dev-tree.awk
+
+	;;
 	esac
 }
=20
@@ -105,7 +131,7 @@ here=3D`pwd`
 tmp=3D`mktemp -d`
=20
 img_file=3D$TEST_DIR/$$.fs
-dd if=3D/dev/zero of=3D$img_file bs=3D1M count=3D300 &> /dev/null
+dd if=3D/dev/zero of=3D$img_file bs=3D1M count=3D$fssize &> /dev/null
=20
 loop_dev=3D$(_create_loop_device $img_file)
 loop_mnt=3D$tmp/loop_mnt
@@ -118,6 +144,7 @@ merged_sectors=3D"$tmp/merged_free_sectors"
 mkdir $loop_mnt
=20
 [ "$FSTYP" =3D "xfs" ] && MKFS_OPTIONS=3D"-f $MKFS_OPTIONS"
+[ "$FSTYP" =3D "btrfs" ] && MKFS_OPTIONS=3D"$MKFS_OPTIONS -f -dsingle -m=
single"
=20
 _mkfs_dev $loop_dev
 _mount $loop_dev $loop_mnt
--=20
2.7.4
