Received: from mx2.suse.de ([195.135.220.15]:58556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726867AbfE1N4r (ORCPT <rfc822;fstests@vger.kernel.org>);
        Tue, 28 May 2019 09:56:47 -0400
Subject: Re: [PATCH] fstests: generic/260: Make it handle btrfs more
 gracefully
References: <20190528081859.6203-1-wqu@suse.com>
 <5b41fcb4-ab2d-65b7-f43c-b67919347b0c@suse.com>
 <55e9ff7c-88b3-6762-0e2b-b61fd38d95d4@suse.de>
 <79c284b4-2fc6-e8b0-66c3-49215ca70267@suse.com>
From: Qu Wenruo <wqu@suse.de>
Message-ID: <b23e8be3-782b-66cb-b8c3-f4ff77c33c3c@suse.de>
Date: Tue, 28 May 2019 21:56:41 +0800
MIME-Version: 1.0
In-Reply-To: <79c284b4-2fc6-e8b0-66c3-49215ca70267@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Nikolay Borisov <nborisov@suse.com>, fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 2019/5/28 =E4=B8=8B=E5=8D=889:45, Nikolay Borisov wrote:
>=20
>=20
> On 28.05.19 =D0=B3. 16:24 =D1=87., Qu Wenruo wrote:
>>
>>
>> On 2019/5/28 =E4=B8=8B=E5=8D=888:48, Nikolay Borisov wrote:
>>>
>>>
>>> On 28.05.19 =D0=B3. 11:18 =D1=87., Qu Wenruo wrote:
>>>> If a filesystem doesn't map its logical address space (normally the
>>>> bytenr/blocknr returned by fiemap) directly to its devices(s), the
>>>> following assumptions used in the test case is no longer true:
>>>> - trim range start beyond the end of fs should fail
>>>> - trim range start beyond the end of fs with len set should fail
>>>>
>>>> Under the following example, even with just one device, btrfs can st=
ill
>>>> trim the fs correctly while breaking above assumption:
>>>>
>>>> 0		1G		1.25G
>>>> |---------------|///////////////|-----------------| <- btrfs logical
>>>> 		   |				       address space
>>>>         ------------  mapped as SINGLE
>>>>         |
>>>> 0	V	256M
>>>> |///////////////|			<- device address space
>>>>
>>>> Thus trim range start=3D1G len=3D256M will cause btrfs to trim the 2=
56M
>>>> block group, thus return correct result.
>>>>
>>>> Furthermore, there is no definitely behavior for whether a fs should
>>>> trim the unmapped space.
>>>> Btrfs currently will always trim the unmapped space, but the behavio=
r
>>>> can change as large trim can be very expensive.
>>>>
>>>> Despite the change to skip certain tests for btrfs, still run the
>>>> following tests for btrfs:
>>>> - trim start=3DU64_MAX with lenght set
>>>>   This will expose a bug that btrfs doesn't check overflow of the ra=
nge.
>>>>   This bug will be fixed soon.
>>>>
>>>> - trim beyond the end of the fs
>>>>   This will expose a bug where btrfs could send trim command beyond =
the
>>>>   end of its device.
>>>>   This bug is a regression, can be fixed by reverting c2d1b3aae336 (=
"btrfs:
>>>>   Honour FITRIM range constraints during free space trim")
>>>>
>>>> With proper fixes for btrfs, this test case should pass on btrfs, ex=
t4,
>>>> xfs.
>>>>
>>>> Signed-off-by: Qu Wenruo <wqu@suse.com>
>>>> ---
>>>>  common/rc             | 11 +++++++
>>>>  tests/generic/260     | 75 ++++++++++++++++++++++++++++------------=
---
>>>>  tests/generic/260.out |  9 +-----
>>>>  3 files changed, 62 insertions(+), 33 deletions(-)
>>>>
>>>> diff --git a/common/rc b/common/rc
>>>> index 17b89d5d..d7a5898f 100644
>>>> --- a/common/rc
>>>> +++ b/common/rc
>>>> @@ -4005,6 +4005,17 @@ _require_fibmap()
>>>>  	rm -f $file
>>>>  }
>>>> =20
>>>> +# Check if the logical address (returned by fiemap) of a fs is 1:1 =
mapped to
>>>> +# its underlying fs
>>>
>>> "underlying device" ?
>>
>> What's the proper expression?
>>
>> I mean the block device on which the fs lies above.
>=20
> I got confused by the "of a fs is 1:1 mapped to its underlying fs" this
> seems to have tautology and I gathered you meant if the extents as
> returned by fiemap of a fs are 1:1 mapped to the underlying device that
> the fs sits on ?

Yes.

For directly mapped fs, if fiemap returns something like offset=3D1M,
len=3D1M. Then we should be able to get the content (or at least the
encrypted content) from the offset 1M from the device.

For indirectly mapped fs, the fiemap just returns something can't be
directly used. (e.g. the value can even be beyond the end of any of the
device).

I just don't have a good expression to show the above lines.

>=20
>=20
> <snip>
>=20
>>>
>>> this check is rather ugly, instead if you return 0 on success (i.e it=
's
>>> directly mapped) it can be rewritten simply as:
>>>
>>> if is_fs_direct_mapped; then
>>>
>>> which is a lot cleaner than the $() fuckery
>>
>> I tried that before reverting back to the echo one.
>>
>> The biggest concern is, "return 0" is completely OK for regular
>> functions which does some work.
>> But for bool return, especially for case like this _is_xxx function,
>> return 0 for true is really confusing.
>>
>> Or this is just the preferred way in bash?
>=20
> This is the the unix convention - 0 indicates success,
> http://tldp.org/LDP/Bash-Beginners-Guide/html/sect_07_01.html
>=20
> And https://www.tldp.org/LDP/abs/html/exit-status.html re. exit statuse=
s.
>=20
>>
>>>
>>>> +	echo "[+] Start beyond the end of fs (should fail)" >> $seqres.ful=
l
>>>> +	$FSTRIM_PROG -o $beyond_eofs $SCRATCH_MNT >> $seqres.full 2>&1
>>>> +	[ $? -eq 0 ] && status=3D1
>>>> +
>>>> +	echo "[+] Start beyond the end of fs with len set (should fail)" >=
> $seqres.full
>>>> +	$FSTRIM_PROG -o $beyond_eofs -l1M $SCRATCH_MNT >> $seqres.full 2>&=
1
>>>> +	[ $? -eq 0 ] && status=3D1
>>>> +
>>>> +	# indirectly mapped fs may use this special value to trim their
>>>> +	# unmapped space, so don't do this for indirectly mapped fs.
>>>> +	echo "[+] Start =3D 2^64-1 (should fail)" >> $seqres.full
>>>> +	$FSTRIM_PROG -o $max_64bit $SCRATCH_MNT 2>&1 >> $seqres.full 2>&1
>>>> +	[ $? -eq 0 ] && status=3D1
>>>> +fi
>>>> =20
>>>> -echo "[+] Start =3D 2^64-1 and len is set (should fail)"
>>>> -out=3D$($FSTRIM_PROG -o $max_64bit -l1M $SCRATCH_MNT 2>&1)
>>>> +# This should fail due to overflow no matter how the fs is implemen=
ted
>>>> +echo "[+] Start =3D 2^64-1 and len is set (should fail)" >> $seqres=
.full
>>>> +$FSTRIM_PROG -o $max_64bit -l1M $SCRATCH_MNT >> $seqres.full 2>&1
>>>>  [ $? -eq 0 ] && status=3D1
>>>> -echo $out | _filter_scratch
>>>> =20
>>>>  _scratch_unmount
>>>>  _scratch_mkfs >/dev/null 2>&1
>>>> @@ -86,10 +97,12 @@ _scratch_unmount
>>>>  _scratch_mkfs >/dev/null 2>&1
>>>>  _scratch_mount
>>>> =20
>>>> +echo "[+] Trim an empty fs" >> $seqres.full
>>>>  # This is a bit fuzzy, but since the file system is fresh
>>>>  # there should be at least (fssize/2) free space to trim.
>>>>  # This is supposed to catch wrong FITRIM argument handling
>>>>  bytes=3D$($FSTRIM_PROG -v -o10M $SCRATCH_MNT | _filter_fstrim)
>>>> +echo "$bytes trimed" >> $seqres.full
>>>
>>> Does it bring any value printing those strings in seqres.full given t=
he
>>> output of the executed command won't be there. I think not.
>>
>> When something went wrong, like no bytes get trimmed but still return =
0,
>> then this is definitely valuable.
>>
>> BTW, there are cases btrfs trimmed just 0 bytes. And it's the same com=
mand.
>> To me, this can't be more valuable.
>>
>> In fact, I even considered to check $bytes to make the btrfs failure
>> more explicit.
>=20
> Fair enough but perhaps you can make
>=20
> echo -n "Trim an empty fs" >> $seqres.full
>=20
> exec commands
>=20
> echo "$bytes trimmed". That way  there is going to be a single line
> only. Anyway this is a nit so feel free to ignore.

Isn't there already a line printing doing exactly as you mentioned?

Although the long long comment makes it less obvious.

> +echo "[+] Trim an empty fs" >> $seqres.full
>  # This is a bit fuzzy, but since the file system is fresh
>  # there should be at least (fssize/2) free space to trim.
>  # This is supposed to catch wrong FITRIM argument handling
>  bytes=3D$($FSTRIM_PROG -v -o10M $SCRATCH_MNT | _filter_fstrim)
> +echo "$bytes trimed" >> $seqres.full

Thanks,
Qu

>>
>> Thanks,
>> Qu
>>
>>>
>>>> =20
>>>>  if [ $bytes -gt $(_math "$fssize*1024") ]; then
>>>>  	status=3D1
>>>> @@ -101,7 +114,7 @@ fi
>>>>  # It is because btrfs does not have not-yet-used parts of the devic=
e
>>>>  # mapped and since we got here right after the mkfs, there is not
>>>>  # enough free extents in the root tree.
>>>> -if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP !=3D "btrfs" ]=
; then
>>>> +if [ $bytes -le $(_math "$fssize*512") ] && [ $(_is_fs_direct_mappe=
d) -eq 1 ]; then
>>>
>>> same thing here - make is_fs_direct_mapped plain 'return 0/1' and che=
ck
>>> its ret val directly.
>>>
>>>>  	status=3D1
>>>>  	echo "After the full fs discard $bytes bytes were discarded"\
>>>>  	     "however the file system is $(_math "$fssize*1024") bytes lon=
g."
>>>> @@ -141,14 +154,24 @@ esac
>>>>  _scratch_unmount
>>>>  _scratch_mkfs >/dev/null 2>&1
>>>>  _scratch_mount
>>>> +
>>>> +echo "[+] Try to trim beyond the end of the fs" >> $seqres.full
>>>>  # It should fail since $start is beyond the end of file system
>>>> -$FSTRIM_PROG -o$start -l10M $SCRATCH_MNT &> /dev/null
>>>> -if [ $? -eq 0 ]; then
>>>> +$FSTRIM_PROG -o$start -l10M $SCRATCH_MNT >> $seqres.full 2>&1
>>>> +ret=3D$?
>>>> +if [ $ret -eq 0 ] && [ $(_is_fs_direct_mapped) -eq 1 ]; then
>>>>  	status=3D1
>>>>  	echo "It seems that fs logic handling start"\
>>>>  	     "argument overflows"
>>>>  fi
>>>> =20
>>>> +# For indirectly mapped fs, it shouldn't fail.
>>>> +# Btrfs will fail due to a bug in boundary check
>>>> +if [ $ret -ne 0 ] && [ $(_is_fs_direct_mapped) -eq 0 ]; then
>>>> +	status=3D1
>>>> +	echo "Unexpected error happened during trim"
>>>> +fi
>>>> +
>>>>  _scratch_unmount
>>>>  _scratch_mkfs >/dev/null 2>&1
>>>>  _scratch_mount
>>>> @@ -160,8 +183,10 @@ _scratch_mount
>>>>  # It is because btrfs does not have not-yet-used parts of the devic=
e
>>>>  # mapped and since we got here right after the mkfs, there is not
>>>>  # enough free extents in the root tree.
>>>> +echo "[+] Try to trim the fs with large enough len" >> $seqres.full
>>>>  bytes=3D$($FSTRIM_PROG -v -l$len $SCRATCH_MNT | _filter_fstrim)
>>>> -if [ $bytes -le $(_math "$fssize*512") ] && [ $FSTYP !=3D "btrfs" ]=
; then
>>>> +echo "$bytes trimed" >> $seqres.full
>>>> +if [ $bytes -le $(_math "$fssize*512") ] && [ $(_is_fs_direct_mappe=
d) =3D=3D 1 ]; then
>>>>  	status=3D1
>>>>  	echo "It seems that fs logic handling len argument overflows"
>>>>  fi
>>>> diff --git a/tests/generic/260.out b/tests/generic/260.out
>>>> index a16c4f74..f4ee2f72 100644
>>>> --- a/tests/generic/260.out
>>>> +++ b/tests/generic/260.out
>>>> @@ -1,12 +1,5 @@
>>>>  QA output created by 260
>>>> -[+] Start beyond the end of fs (should fail)
>>>> -fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
>>>> -[+] Start beyond the end of fs with len set (should fail)
>>>> -fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
>>>> -[+] Start =3D 2^64-1 (should fail)
>>>> -fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
>>>> -[+] Start =3D 2^64-1 and len is set (should fail)
>>>> -fstrim: SCRATCH_MNT: FITRIM ioctl failed: Invalid argument
>>>> +[+] Optional trim range test (fs dependent)
>>>>  [+] Default length (should succeed)
>>>>  [+] Default length with start set (should succeed)
>>>>  [+] Length beyond the end of fs (should succeed)
>>>>
