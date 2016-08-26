Received: from cn.fujitsu.com ([59.151.112.132]:61995 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752970AbcHZDd1 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 25 Aug 2016 23:33:27 -0400
Message-ID: <57BFB868.7030806@cn.fujitsu.com>
Date: Fri, 26 Aug 2016 11:32:56 +0800
From: Xiao Yang <yangx.jy@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [PATCH] xfs/098: fix xfs_repair on newer xfsprogs
References: <1472116951-3317-1-git-send-email-yangx.jy@cn.fujitsu.com> <20160825120903.GF10350@dhcp12-143.nay.redhat.com> <20160825154052.GD20705@birch.djwong.org>
In-Reply-To: <20160825154052.GD20705@birch.djwong.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: "Darrick J. Wong" <darrick.wong@oracle.com>
Cc: Zorro Lang <zlang@redhat.com>, fstests@vger.kernel.org
List-ID: <fstests@vger.kernel.org>

=E4=BA=8E 2016/08/25 23:40, Darrick J. Wong =E5=86=99=E9=81=93:
> On Thu, Aug 25, 2016 at 08:09:03PM +0800, Zorro Lang wrote:
>> On Thu, Aug 25, 2016 at 05:22:31PM +0800, Xiao Yang wrote:
>>> Make sure xfs_repair can't clear the log by default when it is corrup=
ted.
>>> xfs_repair always and only clear the log when the -L parameter is spe=
cified.
>>> This has updated by:
>>> Commit f2053bc ("xfs_repair: don't clear the log by default")
>>>
>>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>>> ---
>>>   tests/xfs/098 | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/xfs/098 b/tests/xfs/098
>>> index d91d617..0fe8d93 100755
>>> --- a/tests/xfs/098
>>> +++ b/tests/xfs/098
>>> @@ -93,7 +93,9 @@ echo "+ mount image"
>>>   _scratch_mount 2>/dev/null&&  _fail "mount should not succeed"
>>>
>>>   echo "+ repair fs"
>>> -_scratch_xfs_repair>>  $seqres.full 2>&1
>>> +_scratch_xfs_repair>>  $seqres.full 2>&1&&  _fail "xfs_repair should=
 not succeed without -L option"
>> Hi,
>>
>> If you make it fail at here, this case can't run for old xfsprogs(with=
out
>> commit f2053bc).
>>
>>> +
>>> +_scratch_xfs_repair -L>>  $seqres.full 2>&1
>> For compatibility, maybe you can use "-L" directly. Or use -L
>> after _scratch_xfs_repair return error.
> I suggest _repair_scratch_fs.
>
> --D
>
Hi Darrick
I changed _repair_scratch_fs because xfs_repair return 1 when log is=20
corrupted.

Thanks for your review.

Regards,
Xiao Yang

>> Thanks,
>> Zorro
>>
>>>
>>>   echo "+ mount image (2)"
>>>   _scratch_mount
>>> --=20
>>> 1.8.3.1
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe fstests" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>



