Received: from cn.fujitsu.com ([59.151.112.132]:15178 "EHLO
	heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932797AbcFNCia (ORCPT
	<rfc822;fstests@vger.kernel.org>); Mon, 13 Jun 2016 22:38:30 -0400
Received: from G08CNEXCHPEKD01.g08.fujitsu.local (unknown [10.167.33.80])
	by cn.fujitsu.com (Postfix) with ESMTP id A7DBA409257A
	for <fstests@vger.kernel.org>; Tue, 14 Jun 2016 10:38:26 +0800 (CST)
Subject: Re: [PATCH] fstests: ext4: regression test for fsync transaction ids
 initialization
References: <1465354945-11307-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
 <20160608085546.GP5140@eguan.usersys.redhat.com>
From: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
Message-ID: <575F6DDC.9050000@cn.fujitsu.com>
Date: Tue, 14 Jun 2016 10:37:16 +0800
MIME-Version: 1.0
In-Reply-To: <20160608085546.GP5140@eguan.usersys.redhat.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

Hello,

Thanks for reviewing.

On 06/08/2016 04:55 PM, Eryu Guan wrote:
> On Wed, Jun 08, 2016 at 11:02:25AM +0800, Wang Xiaoguang wrote:
>> Commit 688f869 fixed this bug:
>>      ext4: ext4: Initialize fsync transaction ids in ext4_new_inode()
> Double "ext4: " here :)
>
> And the "fstests: " prefix in summary can be dropped, "ext4: " prefix is
> Okay.
>
>> We manually modify jbd2 journal_superblock_s.s_sequence to be a very large
>> number, which will greatly reduce the time taken to trigger this bug, though
>> it seems some too hacked.
>>
>> Signed-off-by: Wang Xiaoguang <wangxg.fnst@cn.fujitsu.com>
>> ---
>>   tests/ext4/021     | 117 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>>   tests/ext4/021.out |   2 +
>>   tests/ext4/group   |   1 +
>>   3 files changed, 120 insertions(+)
>>   create mode 100755 tests/ext4/021
>>   create mode 100644 tests/ext4/021.out
>>
>> diff --git a/tests/ext4/021 b/tests/ext4/021
>> new file mode 100755
>> index 0000000..cdc1524
>> --- /dev/null
>> +++ b/tests/ext4/021
>> @@ -0,0 +1,117 @@
>> +#! /bin/bash
>> +# FS QA Test 021
>> +#
>> +# Regression test for commit:
>> +# 688f869 ext4: Initialize fsync transaction ids in ext4_new_inode()
>> +#
>> +#-----------------------------------------------------------------------
>> +# Copyright (c) 2016 Fujitsu.  All Rights Reserved.
>> +#
>> +# This program is free software; you can redistribute it and/or
>> +# modify it under the terms of the GNU General Public License as
>> +# published by the Free Software Foundation.
>> +#
>> +# This program is distributed in the hope that it would be useful,
>> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
>> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> +# GNU General Public License for more details.
>> +#
>> +# You should have received a copy of the GNU General Public License
>> +# along with this program; if not, write the Free Software Foundation,
>> +# Inc.,  51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
>> +#-----------------------------------------------------------------------
>> +#
>> +
>> +seq=`basename $0`
>> +seqres=$RESULT_DIR/$seq
>> +echo "QA output created by $seq"
>> +
>> +here=`pwd`
>> +tmp=/tmp/$$
>> +status=1	# failure is the default!
>> +trap "_cleanup; exit \$status" 0 1 2 3 15
>> +
>> +_cleanup()
>> +{
>> +	cd /
>> +	rm -f $tmp.*
>> +	$UMOUNT_PROG $loop_mnt
>> +	_destroy_loop_device $loop_dev1
>> +	_destroy_loop_device $loop_dev2
>> +	rm -rf $loop_mnt
>> +	rm -f $fs_img1 $fs_img2
>> +}
>> +
>> +# get standard environment, filters and checks
>> +. ./common/rc
>> +
>> +# remove previous $seqres.full before test
>> +rm -f $seqres.full
>> +
>> +# real QA test starts here
>> +_supported_fs ext4
>> +_supported_os Linux
>> +_require_test
>> +_require_loop
>> +
>> +BLOCKSIZE=1024
>> +loop_mnt=$TEST_DIR/$seq.$$.mnt
>> +fs_img1=$TEST_DIR/$seq.$$.img1
>> +fs_img2=$TEST_DIR/$seq.$$.img2
>> +mkdir $loop_mnt
>> +$XFS_IO_PROG -f -c "truncate 128m" $fs_img1 >>$seqres.full 2>&1
>> +$XFS_IO_PROG -f -c "truncate 16m" $fs_img2 >>$seqres.full 2>&1
>> +
>> +loop_dev1=`_create_loop_device $fs_img1`
>> +loop_dev2=`_create_loop_device $fs_img2`
> You're using two loop devices and one is used as external journal
> device, I think test on SCRATCH_DEV should be fine, e.g.
>
> _scratch_mkfs_sized a 8M ext4 filesystem, then use a script to find the
> journal superblock on disk, then modify the journal.s_sequence according
> to the location of journal superblock and the offset of s_sequence to
> it. I use the following script to do all this:
>
> #/bin/bash
> dev=$1
> mkfs -t ext4 $dev 8M
> blocksize=`dumpe2fs -h $dev 2>/dev/null | grep "Block size" | awk '{print $3}'`
> offset=0
> found=0
> # this is the jbd2 journal superblock magic number on disk, in big endian
> magic="c0 3b 39 98"
>
> # 8M in bytes
> filesize=$((8 * 1024 * 1024))
> while [ $offset -lt $filesize ]; do
>          if  | grep -i "$magic";then
>                  echo "Found journal: $offset"
>                  found=1
>                  break
>          fi
>          offset=$((offset + blocksize))
> done
Thanks for your script, but I wonder whether there will be some other
metadata which would have the same magic number "c0 3b 39 98", such
as ext4 super_block or block_group_description.

Regards,
Xiaoguang Wang


>
> # Overwrite journal.s_squence to 0x 81d1a480
> # 0x81d1a480 is hex form of 2178000000, and jbd2 journal is big endian on
> # disk, the s_squence offset to the beginning of journal superblock is 24
> xfs_io  -c "pwrite -S 0x81 $((offset+24)) 1" \
>          -c "pwrite -S 0xd1 $((offset+25)) 1" \
>          -c "pwrite -S 0xa4 $((offset+26)) 1" \
>          -c "pwrite -S 0x80 $((offset+27)) 1" $dev
>
>
> This way, we don't have to use loop device nor external journal device,
> and don't have to test on fixed block size ext4, SCRATCH_DEV just works.
>
>> +
>> +_mkfs_dev -b $BLOCKSIZE -O journal_dev $loop_dev2 >>$seqres.full 2>&1
>> +_mkfs_dev -b $BLOCKSIZE -J device=$loop_dev2 $loop_dev1 >>$seqres.full 2>&1
>> +
>> +# Below command will modify jbd2 journal transaction id to be 2178000000,
>> +# which will reduce the time taken to trigger this bug. When ext4 fs block
>> +# size is 1024, journal superblock will start at offset 2048, and
>> +# journal_superblock_s.s_sequence will start at offset 2072. After this
>> +# modification, jbd2 will will start to run with a initial transaction id
>> +# 2178000000.
>> +echo 81d1a480 | xxd -r -ps | dd of=$loop_dev2 bs=4 count=1 seek=518 >/dev/null 2>&1
>> +
>> +trans_id=$(dumpe2fs $loop_dev2 2>/dev/null | grep "Journal sequence" | \
>> +  awk -F ":" '{print $2}')
>> +trans_id=$((trans_id))
> I think this is unnecessary, just print the hex form.
>
>> +if [ $trans_id -ne 2178000000 ]; then
>> +	echo "fail to set initial transaction id to 2178000000"
>> +	exit
>> +fi
> This is not needed, because..
>
>> +echo "Initial transaction id is $trans_id"
> You have this in golden output, when trans_id goes wrong, it will be
> caught by golden image.
>
>> +
>> +_mount $loop_dev1 $loop_mnt
>> +cd $loop_mnt
>> +
>> +cat >do_fdatasync.c <<EOF
>> +#include <sys/stat.h>
>> +#include <fcntl.h>
>> +#include <unistd.h>
>> +#include <sys/types.h>
>> +
>> +void main(void)
>> +{
>> +	int fd;
>> +
>> +	fd = open("testfile", O_RDWR | O_CREAT | O_EXCL);
>> +	while (1)
>> +		fdatasync(fd);
>> +}
>> +EOF
>> +gcc -o do_fdatasync do_fdatasync.c >> $seqres.full 2>&1 || \
>> +  _notrun "Could not compile test program (see end of $seqres.full)"
>> +
>> +./do_fdatasync &
>> +child_process=$!
> No need to write a temporary c program, calling xfs_io -c "fdatasync" in
> a loop is good enough.
>
>> +
>> +sleep 60
>> +kill $child_process >/dev/null 2>&1
> In my test, the test triggers WARNINGs (seems not panic every time)
> almost as soon as the fdatasync loop runs. I think 10s is long enough.
>
>> +
>> +# success, all done
>> +status=0
>> +exit
>> diff --git a/tests/ext4/021.out b/tests/ext4/021.out
>> new file mode 100644
>> index 0000000..ee3e81d
>> --- /dev/null
>> +++ b/tests/ext4/021.out
>> @@ -0,0 +1,2 @@
>> +QA output created by 021
>> +Initial transaction id is 2178000000
>> diff --git a/tests/ext4/group b/tests/ext4/group
>> index 9e28159..7736da1 100644
>> --- a/tests/ext4/group
>> +++ b/tests/ext4/group
>> @@ -23,6 +23,7 @@
>>   018 fuzzers
>>   019 fuzzers
>>   020 auto quick ioctl rw
>> +021 auto
> If it runs for 10s, quick group can be added.
>
> Thanks,
> Eryu
>
>>   271 auto rw quick
>>   301 aio auto ioctl rw stress
>>   302 aio auto ioctl rw stress
>> -- 
>> 2.5.0
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>



