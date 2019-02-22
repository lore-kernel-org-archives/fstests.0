Received: from mx2.suse.de ([195.135.220.15]:57628 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725888AbfBVGXv (ORCPT <rfc822;fstests@vger.kernel.org>);
        Fri, 22 Feb 2019 01:23:51 -0500
Subject: Re: [PATCH v2] shared/298: Wire btrfs support in get_free_sectors
References: <20190208114404.13505-1-nborisov@suse.com>
 <20190221171051.GC2713@desktop>
From: Nikolay Borisov <nborisov@suse.com>
Message-ID: <d72dcb14-eb87-6173-cf47-0276196b6a72@suse.com>
Date: Fri, 22 Feb 2019 08:23:46 +0200
MIME-Version: 1.0
In-Reply-To: <20190221171051.GC2713@desktop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <guaneryu@gmail.com>
Cc: dsterba@suse.cz, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 21.02.19 =D0=B3. 19:10 =D1=87., Eryu Guan wrote:
> On Fri, Feb 08, 2019 at 01:44:04PM +0200, Nikolay Borisov wrote:
>> Add support for btrfs in shared/298. Achieve this by introducing 2
>> new awk scripts that parse relevant btrfs structures and print holes.
>> Additionally modify the test to create larger - 3gb filesystem in the
>> case of btrfs. This is needed so that distinct block groups are used
>> for data and metadata.
>>
>> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
>=20
> Sorry for the late review.. I find that parsing btrfs extent and dev
> tree is very btrfs-specific, it'd be great if btrfs folks could help
> review the two awk scripts as well!
>=20
>> ---
>>
>> V2:=20
>>  * Changed the way args are passed to mkfs.btrfs to preserve existing=20
>>  options, yet override data/metadata profile settings
>>
>>  parse-dev-tree.awk    |  47 +++++++++++++++++++
>>  parse-extent-tree.awk | 125 +++++++++++++++++++++++++++++++++++++++++=
+++++++++
>=20
> I'd prefer placing these files in src dir, instead of dumping them in
> top dir directly.

Ok

>=20
>>  tests/shared/298      |  36 +++++++++++++--
>>  3 files changed, 205 insertions(+), 3 deletions(-)
>>  create mode 100755 parse-dev-tree.awk
>>  create mode 100755 parse-extent-tree.awk
>>
>> diff --git a/parse-dev-tree.awk b/parse-dev-tree.awk
>> new file mode 100755
>> index 000000000000..52f9c0aadc25
>> --- /dev/null
>> +++ b/parse-dev-tree.awk
>> @@ -0,0 +1,47 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2019 Nikolay Borisov, SUSE LLC.  All Rights Reserved.
>> +#
>> +# Parses btrfs' device tree for holes, required parameters passed on =
command
>=20
> I find this description not very useful, would you please describe the
> expected output and format as well?

Ok will make it a bit more verbose

>=20
>> +# line:
>> +#     * spb - how many bytes per sector, this is used so that the num=
bers=20
>            ^^^ This is misleading, in shared/298 spb represents "sector
> 	   per block", but here it's really sector size.

Yeah probably should rename it.

>=20
>> +# 		returned by the script are in sectors.
>> +#	  * devsize - size of the device in bytes, used to output the final=
=20
>=20
> This line is not aligned with above line, it contains leading tab.
>=20
>> +# 		hole (if any)
>> +
>> +function get_extent_size(line,  tmp) {
>=20
> Would you please document the expected intput and output in comment as
> well? So it's easier to review.
>=20
> Also, is the 'tmp' argument really needed?

tmp in this case is really a function-local variable as per:
https://www.gnu.org/software/gawk/manual/html_node/Variable-Scope.html :

"Unlike in many languages, there is no way to make a variable local to a
{ =E2=80=A6 } block in awk, but you can make a variable local to a functi=
on. It
is good practice to do so whenever a variable is needed only in that
function."


>=20
>> +	split(line, tmp)
>> +	return tmp[6]
>> +}
>> +
>> +function get_extent_offset(line,  tmp) {
>=20
> Same here.
>=20
>> +	split(line, tmp)
>> +	gsub(/\)/,"", tmp[6])
>> +	return tmp[6]
>> +}
>> +
>> +BEGIN {
>> +	dev_extent_match=3D"^.item [0-9]* key \\([0-9]* DEV_EXTENT [0-9]*\\)=
.*"
>> +	dev_extent_len_match=3D"^\\s*chunk_objectid [0-9]* chunk_offset [0-9=
]* length [0-9]*$"
>> +}
>> +
>> +{
>> +	if (match($0,dev_extent_match)) {
>> +		extent_offset =3D get_extent_offset($0)	=09
>> +		if (prev_extent_end) {
>> +			hole_size =3D extent_offset - prev_extent_end
>> +			if (hole_size > 0) {
>> +				print prev_extent_end / spb, int((extent_offset - 1) / spb)
>> +			}
>> +		}=20
>> +	} else if (match($0, dev_extent_len_match)) {
>> +		extent_size =3D get_extent_size($0)
>> +		prev_extent_end =3D extent_offset + extent_size
>> +	}
>> +}
>> +
>> +END {
>> +	if (prev_extent_end) {
>> +		print prev_extent_end / spb, int((devsize - 1) / spb)
>> +	}
>> +}
>> +
>> diff --git a/parse-extent-tree.awk b/parse-extent-tree.awk
>> new file mode 100755
>> index 000000000000..01c61254cfef
>> --- /dev/null
>> +++ b/parse-extent-tree.awk
>> @@ -0,0 +1,125 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +# Copyright (c) 2019 Nikolay Borisov, SUSE LLC.  All Rights Reserved.
>> +#
>> +# Parses btrfs' extent tree for holes, required parameters passed on =
command
>=20
> Same here, please provide more details.
>=20
>> +# line:
>> +#     * spb - how many bytes per sector, this is used so that the num=
bers=20
>=20
> And replace 'spb' with a more proper variable name.
>=20
>> +# 		returned by the script are in sectors.
>> +#	  * nodesize - size of metadata extents, used for internal calculat=
ions
>=20
> Indention issue too.
>=20
>> +
>> +function get_extent_size(line,  tmp) {
>> +	if (line ~ data_match || line ~ bg_match) {
>> +		split(line, tmp)
>> +		gsub(/\)/,"", tmp[6])
>> +		return tmp[6]
>> +	} else if (line ~ metadata_match) {
>> +		return nodesize
>> +	}
>> +}
>> +
>> +function get_extent_offset(line,  tmp) {
>> +	split(line, tmp)
>> +	gsub(/\(/,"",tmp[4])
>> +	return tmp[4]
>> +}
>> +
>> +function print_array(         base_offset, bg_line)
>=20
> Document the expected input and output of these functions too.
>=20
> And why there're so many spaces before 'base_offset' argument?

Again, those 2 are used as local variables as per early cited documentati=
on.

>=20
>> +{
>> +	if (match(lines[0], bg_match)) {
>> +		#we don't have an extent at the beginning of of blockgroup, so we
>=20
> Add a space after '#' for comments.

Ok

<snip>

>>
>=20
