Received: from aserp2120.oracle.com ([141.146.126.78]:49674 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbeJKKw5 (ORCPT
        <rfc822;fstests@vger.kernel.org>); Thu, 11 Oct 2018 06:52:57 -0400
Subject: Re: [PATCH v2 3/9] geneirc/077 fix min size for btrfs
From: Anand Jain <anand.jain@oracle.com>
References: <1537849462-619-1-git-send-email-anand.jain@oracle.com>
 <1537849462-619-4-git-send-email-anand.jain@oracle.com>
 <20181006112507.GL17817@desktop>
 <7874ee99-960a-e6c4-b710-d7a24bd9d64c@oracle.com>
Message-ID: <5166dac1-a4d3-2a74-8520-38359aa1eed9@oracle.com>
Date: Thu, 11 Oct 2018 11:27:17 +0800
MIME-Version: 1.0
In-Reply-To: <7874ee99-960a-e6c4-b710-d7a24bd9d64c@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Sender: fstests-owner@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
To: Eryu Guan <guaneryu@gmail.com>
Cc: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org
List-ID: <fstests@vger.kernel.org>



On 10/11/2018 11:14 AM, Anand Jain wrote:
>=20
>=20
> On 10/06/2018 07:25 PM, Eryu Guan wrote:
>> On Tue, Sep 25, 2018 at 12:24:16PM +0800, Anand Jain wrote:
>>> If btrfs need to be tested at its default blockgroup which is non-mix=
ed,
>>> then it needs at least 256mb.
>>>
>>> Signed-off-by: Anand Jain <anand.jain@oracle.com>
>>
>> (Sorry for the late review..)
>=20
>  =C2=A0Its fine. Sorry for the delay at my end too.
>=20
>>> ---
>>> =C2=A0 tests/generic/077 | 3 +--
>>> =C2=A0 1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/tests/generic/077 b/tests/generic/077
>>> index ef6af18c83e3..ec236992513f 100755
>>> --- a/tests/generic/077
>>> +++ b/tests/generic/077
>>> @@ -49,8 +49,7 @@ rm -f $seqres.full
>>> =C2=A0 _scratch_unmount >/dev/null 2>&1
>>> =C2=A0 echo "*** MKFS ***"=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 >>$seqres.full
>>> =C2=A0 echo ""=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 >>$seqres.full
>>> -SIZE=3D`expr 50 \* 1024 \* 1024`
>>> -_scratch_mkfs_sized $SIZE=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 >>$seqres=
.full 2>&1 \
>>> +_scratch_mkfs_sized $((256 * 1024 *1024))=C2=A0=C2=A0 >>$seqres.full=
 2>&1 \
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 || _fail "mkfs failed"
>>
>> Hmm, this test copies "/lib/modules/" to fill the original 50M
>> filesystem (which seems a bad way to me)
>=20
> Yep. I didn't like either. I started using the _populate_fs() but then=20
> was doubtful if it still meets the objective of this test case as it=20
> used the dd instead of cp. Moreover it kind of getting diverged from=20
> what's the object of this patch. If needed we could fix the cp approach=
=20
> in a separate patch so that we shall have better tracking.
>=20
>> "
>> # Something w/ enough data to fill 50M of fs...
>> filler=3D/lib/modules/
>> ...
>> echo "*** populate filesystem, pass #1" | tee -a $seqres.full
>> cp -rf $filler $SCRATCH_MNT/subdir >$seqres.full 2>&1
>> ...
>> "
>>
>> It works most of the time as "/lib/modules" is usually larger than 50M=
,
>> but it may not fullfil the fs with 256M size.
>>
>> I think we should fix the way to fill the fs too.
>=20
>  =C2=A0Right. There are two iterations of cp. So a check if the assigne=
d=20
> filler is big enough to fill the 256M will suffice, as we already=20
> _notrun the test if empty filler.
>=20
> Pls find v2 for review.

  Sorry for the typo it should be v3.

Thanks, Anand

> Thanks, Anand
>=20
>> Thanks,
>> Eryu
>>
>>> =C2=A0 _scratch_mount
>>> =C2=A0 mkdir $SCRATCH_MNT/subdir
>>> --=20
>>> 1.8.3.1
>>>
