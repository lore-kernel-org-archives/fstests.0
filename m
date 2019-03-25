Received: from mail.cn.fujitsu.com ([183.91.158.132]:34142 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729230AbfCYG7Q (ORCPT
        <rfc822;fstests@vger.kernel.org>); Mon, 25 Mar 2019 02:59:16 -0400
Message-ID: <5C987C3E.4060707@cn.fujitsu.com>
Date: Mon, 25 Mar 2019 14:59:10 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/010: Accept the inconsistencies of sparse records
References: <1552980533-2138-1-git-send-email-yangx.jy@cn.fujitsu.com> <20190323085005.GS2824@desktop>
In-Reply-To: <20190323085005.GS2824@desktop>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Sender: fstests-owner@vger.kernel.org
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

On 2019/03/23 16:50, Eryu Guan wrote:
> On Tue, Mar 19, 2019 at 03:28:53PM +0800, Xiao Yang wrote:
>> If sparse inode is enabled, running xfs/010 gets the following error:
>> -----------------------------------------------------
>> +invalid inode count, AGNO/INO, count 0 ninodes 64
>>   finobt record with no free inodes, AGNO/INO
>> +invalid inode count, AGNO/INO, count 0 ninodes 64
>> -----------------------------------------------------
>>
>> We corrupt finobt records forcely, so it's reasonable for repair
>> to detect the inconsistencies of sparse records if sparse inode
>> is enabled.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> I cannot reproduce this failure, I'm using xfsprogs from upstream
> for-next branch and kernel 5.0.
>
> xfs/010 uses a fixed mkfs option to create the target fs:
>
> _scratch_mkfs_xfs "-m crc=1,finobt=1 -d agcount=2" | _filter_mkfs 2>$seqres.full
>
> So adding "-i sparse" to MKFS_OPTIONS won't create xfs with 'sparse'
> enabled in test. And even after editing above mkfs options manually in
> test, I still couldn't hit the failure. Did I miss anything?
Hi Eryu,

Sorry, this is a xfsprogs bug instead of test problem. :-[
I have confirmed that the xfsprogs bug has been fixed by the followoing 
patch:
'38c599e xfs_db: fix finobt record decoding when sparse inodes enabled'

Best Regards,
Xiao Yang
> Thanks,
> Eryu
>
>> ---
>>   tests/xfs/010 | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/xfs/010 b/tests/xfs/010
>> index e220a65..69c019b 100755
>> --- a/tests/xfs/010
>> +++ b/tests/xfs/010
>> @@ -106,8 +106,10 @@ _scratch_unmount
>>   # corrupt some finobt records
>>   _corrupt_finobt_records $SCRATCH_DEV
>>
>> -# repair should detect the inconsistencies
>> -_scratch_xfs_repair 2>&1 | _filter_repair
>> +# repair should detect the inconsistencies of finobt records
>> +# repair can also detect the inconsistencies of sparse records if
>> +# sparse inode is enabled, so accept both of outputs by filtering it.
>> +_scratch_xfs_repair 2>&1 | _filter_repair | sed -e '/invalid inode count, AGNO\/INO/d'
>>   _check_scratch_fs
>>
>>   # nuke the finobt root, repair will have to regenerate from the inobt
>> -- 
>> 1.8.3.1
>>
>>
>>
>
>
