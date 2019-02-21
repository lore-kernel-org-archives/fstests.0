Received: from mx2.suse.de ([195.135.220.15]:40382 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726594AbfBUITv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Thu, 21 Feb 2019 03:19:51 -0500
Subject: Re: [PATCH v2] shared/298: Wire btrfs support in get_free_sectors
References: <20190208114404.13505-1-nborisov@suse.com>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <fd001b5e-5376-dbde-ae4a-82fac7aa98da@suse.com>
Date: Thu, 21 Feb 2019 10:19:48 +0200
MIME-Version: 1.0
In-Reply-To: <20190208114404.13505-1-nborisov@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: guaneryu@gmail.com
Cc: dsterb@suse.cz, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 8.02.19 =D0=B3. 13:44 =D1=87., Nikolay Borisov wrote:
> Add support for btrfs in shared/298. Achieve this by introducing 2
> new awk scripts that parse relevant btrfs structures and print holes.
> Additionally modify the test to create larger - 3gb filesystem in the
> case of btrfs. This is needed so that distinct block groups are used
> for data and metadata.
>=20
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>


Ping, I would really like to get this ASAP to get coverage for btrfs.

> ---
>=20
> V2:=20
>  * Changed the way args are passed to mkfs.btrfs to preserve existing=20
>  options, yet override data/metadata profile settings
>=20
>  parse-dev-tree.awk    |  47 +++++++++++++++++++
>  parse-extent-tree.awk | 125 ++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  tests/shared/298      |  36 +++++++++++++--
>  3 files changed, 205 insertions(+), 3 deletions(-)
>  create mode 100755 parse-dev-tree.awk
>  create mode 100755 parse-extent-tree.awk
>=20
> diff --git a/parse-dev-tree.awk b/parse-dev-tree.awk
> new file mode 100755
> index 000000000000..52f9c0aadc25
> --- /dev/null
> +++ b/parse-dev-tree.awk
> @@ -0,0 +1,47 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Nikolay Borisov, SUSE LLC.  All Rights Reserved.
> +#
> +# Parses btrfs' device tree for holes, required parameters passed on c=
ommand
> +# line:
> +#     * spb - how many bytes per sector, this is used so that the numb=
ers=20
> +# 		returned by the script are in sectors.
> +#	  * devsize - size of the device in bytes, used to output the final=20
> +# 		hole (if any)
> +
> +function get_extent_size(line,  tmp) {
> +	split(line, tmp)
> +	return tmp[6]
> +}
> +
> +function get_extent_offset(line,  tmp) {
> +	split(line, tmp)
> +	gsub(/\)/,"", tmp[6])
> +	return tmp[6]
> +}
> +
> +BEGIN {
> +	dev_extent_match=3D"^.item [0-9]* key \\([0-9]* DEV_EXTENT [0-9]*\\).=
*"
> +	dev_extent_len_match=3D"^\\s*chunk_objectid [0-9]* chunk_offset [0-9]=
* length [0-9]*$"
> +}
> +
> +{
> +	if (match($0,dev_extent_match)) {
> +		extent_offset =3D get_extent_offset($0)	=09
> +		if (prev_extent_end) {
> +			hole_size =3D extent_offset - prev_extent_end
> +			if (hole_size > 0) {
> +				print prev_extent_end / spb, int((extent_offset - 1) / spb)
> +			}
> +		}=20
> +	} else if (match($0, dev_extent_len_match)) {
> +		extent_size =3D get_extent_size($0)
> +		prev_extent_end =3D extent_offset + extent_size
> +	}
> +}
> +
> +END {
> +	if (prev_extent_end) {
> +		print prev_extent_end / spb, int((devsize - 1) / spb)
> +	}
> +}
> +
> diff --git a/parse-extent-tree.awk b/parse-extent-tree.awk
> new file mode 100755
> index 000000000000..01c61254cfef
> --- /dev/null
> +++ b/parse-extent-tree.awk
> @@ -0,0 +1,125 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# Copyright (c) 2019 Nikolay Borisov, SUSE LLC.  All Rights Reserved.
> +#
> +# Parses btrfs' extent tree for holes, required parameters passed on c=
ommand
> +# line:
> +#     * spb - how many bytes per sector, this is used so that the numb=
ers=20
> +# 		returned by the script are in sectors.
> +#	  * nodesize - size of metadata extents, used for internal calculati=
ons
> +
> +function get_extent_size(line,  tmp) {
> +	if (line ~ data_match || line ~ bg_match) {
> +		split(line, tmp)
> +		gsub(/\)/,"", tmp[6])
> +		return tmp[6]
> +	} else if (line ~ metadata_match) {
> +		return nodesize
> +	}
> +}
> +
> +function get_extent_offset(line,  tmp) {
> +	split(line, tmp)
> +	gsub(/\(/,"",tmp[4])
> +	return tmp[4]
> +}
> +
> +function print_array(         base_offset, bg_line)
> +{
> +	if (match(lines[0], bg_match)) {
> +		#we don't have an extent at the beginning of of blockgroup, so we
> +		#have a hole between blockgroup offset and first extent offset
> +		bg_line =3D lines[0]
> +		prev_size=3D0
> +		prev_offset=3Dget_extent_offset(bg_line)
> +		delete lines[0]
> +	} else {
> +		#we have an extent at the beginning of block group, so initialize=20
> +		#the prev_* vars correctly
> +		bg_line =3D lines[1]
> +		prev_size =3D get_extent_size(lines[0])
> +		prev_offset =3D get_extent_offset(lines[0])
> +		delete lines[1]
> +		delete lines[0]
> +	}
> +
> +	bg_offset=3Dget_extent_offset(bg_line)
> +	bgend=3Dbg_offset + get_extent_size(bg_line)
> +
> +	for (i in lines) {
> +			cur_size =3D get_extent_size(lines[i])
> +			cur_offset =3D get_extent_offset(lines[i])
> +			if (cur_offset  !=3D prev_offset + prev_size)
> +				print int((prev_size + prev_offset) / spb), int((cur_offset-1) / s=
pb)
> +			prev_size =3D cur_size
> +			prev_offset =3D cur_offset
> +	}
> +
> +	print int((prev_size + prev_offset) / spb), int((bgend-1) / spb)
> +	total_printed++
> +	delete lines
> +}
> +
> +BEGIN {
> +	loi_match=3D"^.item [0-9]* key \\([0-9]* (BLOCK_GROUP_ITEM|METADATA_I=
TEM|EXTENT_ITEM) [0-9]*\\).*"
> +	metadata_match=3D"^.item [0-9]* key \\([0-9]* METADATA_ITEM [0-9]*\\)=
.*"
> +	data_match=3D"^.item [0-9]* key \\([0-9]* EXTENT_ITEM [0-9]*\\).*"
> +	bg_match=3D"^.item [0-9]* key \\([0-9]* BLOCK_GROUP_ITEM [0-9]*\\).*"
> +	node_match=3D"^node.*$"
> +	leaf_match=3D"^leaf [0-9]* flags"
> +	line_count=3D0
> +	total_printed=3D0
> +	skip_lines=3D0
> +}
> +
> +{
> +	#skip lines not belonging to a leaf
> +	if (match($0,node_match)) {
> +		skip_lines=3D1
> +	} else if (match($0, leaf_match)) {
> +		skip_lines=3D0
> +	}
> +
> +	if (!match($0,loi_match) || skip_lines =3D=3D 1) next;
> +
> +	#we have a line of interest, we need to parse it. First check if ther=
e is
> +	#anything in the array
> +	if (line_count=3D=3D0) {
> +		lines[line_count++]=3D$0;
> +	} else {
> +		prev_line=3Dlines[line_count-1]
> +		split(prev_line, prev_line_fields)
> +		prev_objectid=3Dprev_line_fields[4]
> +		objectid=3D$4
> +
> +		if (objectid =3D=3D prev_objectid && match($0, bg_match)) {
> +			if (total_printed>0) {
> +				#We are adding a BG after we have added its first extent
> +				#previously, consider this a record ending event and just print
> +				#the array
> +
> +				delete lines[line_count-1]
> +				print_array()
> +				#we now start a new array with current and previous lines
> +				line_count=3D0
> +				lines[line_count++]=3Dprev_line
> +				lines[line_count++]=3D$0
> +			} else {
> +				#first 2 added lines are EXTENT and BG that match, in this case
> +				#just add them
> +				lines[line_count++]=3D$0
> +			=09
> +			}
> +		} else if (match($0, bg_match)) {
> +			#ordinary end of record
> +			print_array()
> +			line_count=3D0
> +			lines[line_count++]=3D$0
> +		} else {
> +			lines[line_count++]=3D$0
> +		}
> +	}
> +}
> +
> +END {
> +	print_array()
> +}
> diff --git a/tests/shared/298 b/tests/shared/298
> index e7b7b233de45..8c053aa34adb 100755
> --- a/tests/shared/298
> +++ b/tests/shared/298
> @@ -15,14 +15,24 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
> =20
>  . ./common/rc
> =20
> -_supported_fs ext4 xfs
> +_supported_fs ext4 xfs btrfs
>  _supported_os Linux
>  _require_test
>  _require_loop
>  _require_fstrim
>  _require_xfs_io_command "fiemap"
> -_require_fs_space $TEST_DIR 307200
> +if [ "$FSTYP" =3D "btrfs" ]; then
> +	# 3g for btrfs to have distinct bgs
> +	_require_fs_space $TEST_DIR 3145728
> +	fssize=3D3000
> +else
> +	_require_fs_space $TEST_DIR 307200
> +	fssize=3D300
> +fi
> +
>  [ "$FSTYP" =3D "ext4" ] && _require_dumpe2fs
> +[ "$FSTYP" =3D "btrfs" ] && _require_btrfs_command inspect-internal du=
mp-super
> +[ "$FSTYP" =3D "btrfs" ] && _require_btrfs_command inspect-internal du=
mp-tree
> =20
>  _cleanup()
>  {
> @@ -61,6 +71,25 @@ get_free_sectors()
>  		 $AWK_PROG -v spb=3D$sectors_per_block -v agsize=3D$agsize \
>  		'{ print spb * ($1 * agsize + $2), spb * ($1 * agsize + $2 + $3) - 1=
 }'
>  	;;
> +	btrfs)
> +		local device_size=3D$($BTRFS_UTIL_PROG filesystem show --raw $loop_m=
nt 2>&1 \
> +			| sed -n "s/^.*size \([0-9]*\).*$/\1/p")
> +
> +		local nodesize=3D$($BTRFS_UTIL_PROG inspect-internal dump-super $img=
_file  \
> +			| sed -n 's/nodesize\s*\(.*\)/\1/p')
> +
> +		# Get holes within block groups
> +		local btrfs_free=3D$($BTRFS_UTIL_PROG inspect-internal dump-tree -t =
extent $img_file \
> +			| $AWK_PROG -v spb=3D512 -v nodesize=3D$nodesize -f parse-extent-tr=
ee.awk)
> +
> +		btrfs_free+=3D"\n"
> +
> +		# Get holes within unallocated space on disk
> +		btrfs_free+=3D$($BTRFS_UTIL_PROG inspect-internal dump-tree -t dev $=
img_file \
> +			| $AWK_PROG -v spb=3D512 -v devsize=3D$device_size -f parse-dev-tre=
e.awk)
> +
> +		echo -e "$btrfs_free"
> +	;;
>  	esac
>  }
> =20
> @@ -105,7 +134,7 @@ here=3D`pwd`
>  tmp=3D`mktemp -d`
> =20
>  img_file=3D$TEST_DIR/$$.fs
> -dd if=3D/dev/zero of=3D$img_file bs=3D1M count=3D300 &> /dev/null
> +dd if=3D/dev/zero of=3D$img_file bs=3D1M count=3D$fssize &> /dev/null
> =20
>  loop_dev=3D$(_create_loop_device $img_file)
>  loop_mnt=3D$tmp/loop_mnt
> @@ -118,6 +147,7 @@ merged_sectors=3D"$tmp/merged_free_sectors"
>  mkdir $loop_mnt
> =20
>  [ "$FSTYP" =3D "xfs" ] && MKFS_OPTIONS=3D"-f $MKFS_OPTIONS"
> +[ "$FSTYP" =3D "btrfs" ] && MKFS_OPTIONS=3D"$MKFS_OPTIONS -f -dsingle =
-msingle"
> =20
>  _mkfs_dev $loop_dev
>  _mount $loop_dev $loop_mnt
>=20
